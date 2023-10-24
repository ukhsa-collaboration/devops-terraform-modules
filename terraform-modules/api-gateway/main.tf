##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/resource-name-prefix?ref=resource-name-prefix/vALPHA_0.0.0"

  name = var.name
  tags = var.tags
}

############################
#  REST API Configuration  #
############################
resource "aws_api_gateway_rest_api" "api_gw" {
  name        = "${module.resource_name_prefix.resource_name}-api-gw"
  description = "REST API Gateway for ${module.resource_name_prefix.resource_name}"
  tags        = var.tags
}

locals {
  expanded_endpoints = flatten([
    for key, endpoint in var.endpoints : [
      for method in endpoint.methods : {
        key       = key
        path      = endpoint.path
        method    = method
      }
    ]
  ])
}

resource "aws_api_gateway_resource" "api_resource" {
  for_each     = var.endpoints

  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  parent_id   = aws_api_gateway_rest_api.api_gw.root_resource_id
  path_part   = each.value.path
}


resource "aws_api_gateway_method" "api_method" {
  for_each = { for idx, endpoint in local.expanded_endpoints : "${endpoint.key}-${endpoint.method}" => endpoint }

  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  resource_id   = aws_api_gateway_resource.api_resource[each.value.key].id
  http_method   = each.value.method
  authorization = "NONE"  # Assuming no authorization for simplicity
}

############################
#    Lambda Integration    #
############################ # Most likely this should be its own module
resource "aws_api_gateway_integration" "lambda_integration" {
  for_each = { for idx, endpoint in local.expanded_endpoints : "${endpoint.key}-${endpoint.method}" => endpoint }

  depends_on              = [aws_api_gateway_method.api_method]
  rest_api_id             = aws_api_gateway_rest_api.api_gw.id
  resource_id             = aws_api_gateway_resource.api_resource[each.value.key].id
  http_method             = each.value.method
  integration_http_method = each.value.method
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_invoke_arn
}


resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id   = "${module.resource_name_prefix.resource_name}-allow-api-gw-invoke"
  action         = "lambda:InvokeFunction"
  function_name  = var.lambda_function_name
  principal      = "apigateway.amazonaws.com"
  source_arn     = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/*/*"
}

resource "aws_iam_policy" "api_gateway_invoke_lambda" {
  name        = "${module.resource_name_prefix.resource_name}-api-gw-invoke-lambda"
  description = "Allows API Gateway to invoke Lambda function"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "lambda:InvokeFunction",
            "Resource": "${var.lambda_function_invoke_arn}"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "api_gateway_invoke_lambda_attachment" {
  role       = aws_iam_role.api_gateway_cloudwatch_role.name
  policy_arn = aws_iam_policy.api_gateway_invoke_lambda.arn
}

###########################
#      API Usage Plan     #
###########################
resource "aws_api_gateway_usage_plan" "usage_plan" {
  depends_on = [ aws_api_gateway_stage.stage ]
  name        = "${module.resource_name_prefix.resource_name}-api-up"
  description = "Usage plan for ${module.resource_name_prefix.resource_name} API"

  dynamic "api_stages" {
    for_each = var.stage_names
    content {
      api_id = aws_api_gateway_rest_api.api_gw.id
      stage  = api_stages.value
    }
  }

  quota_settings {
    limit  = var.quota_settings.limit
    offset = var.quota_settings.offset
    period = var.quota_settings.period
  }

  throttle_settings {
    burst_limit = var.throttle_settings.burst_limit
    rate_limit  = var.throttle_settings.rate_limit
  }
}

###########################
#        API Keys         #
###########################
resource "aws_api_gateway_api_key" "api_key" {
  name        = "${module.resource_name_prefix.resource_name}-api-key"
  description = "API Key for ${module.resource_name_prefix.resource_name} API"
  enabled     = true
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}

##########################
#     API Deployment     #
##########################
resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_method.api_method, aws_api_gateway_resource.api_resource, aws_api_gateway_integration.lambda_integration, aws_lambda_permission.apigw_lambda_permission]
  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  api_log_format = "{ \"requestId\":\"$context.requestId\", \"ip\": \"$context.identity.sourceIp\", \"caller\":\"$context.identity.caller\", \"user\":\"$context.identity.user\",\"requestTime\":\"$context.requestTime\", \"httpMethod\":\"$context.httpMethod\",\"resourcePath\":\"$context.resourcePath\", \"status\":\"$context.status\",\"protocol\":\"$context.protocol\", \"responseLength\":\"$context.responseLength\" }"
}

resource "aws_api_gateway_stage" "stage" {
  for_each = toset(var.stage_names)

  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  stage_name    = each.value

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_log_group[each.value].arn
    format          = local.api_log_format
  }

  tags = var.tags
}

##########################
#    Specify IP Ranges   #
##########################
data "aws_caller_identity" "current" {}

resource "aws_api_gateway_rest_api_policy" "api_policy" {
  for_each = toset(var.stage_names)

  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "execute-api:Invoke",
        Resource  = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/*",
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.allowed_ip_ranges[each.value]
          }
        }
      }
    ]
  })
}

##########################
#      CloudWatch        #
##########################
resource "aws_cloudwatch_log_group" "api_log_group" {
  for_each = toset(var.stage_names)

  name              = "${module.resource_name_prefix.resource_name}-api-gw-${each.value}-stage-logs"
  retention_in_days = var.log_retention_in_days
}

resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  name = "${module.resource_name_prefix.resource_name}-api-gw-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "api_cloudwatch_logging_policy" {
  name        = "${module.resource_name_prefix.resource_name}-api-gw-lp"
  description = "CloudWatch logging policy for API Gateway"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchAccess1",
            "Effect": "Allow",
            "Action": [
                "logs:GetLogEvents",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*"
        },
        {
            "Sid": "CloudWatchAccess2",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:FilterLogEvents",
                "logs:CreateLogGroup"
            ],
            "Resource": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "api_gw_cloudwatch_policy_attachment" {
  role       = aws_iam_role.api_gateway_cloudwatch_role.name
  policy_arn = aws_iam_policy.api_cloudwatch_logging_policy.arn
}

resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role.arn
}


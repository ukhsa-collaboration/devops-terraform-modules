##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.2"

  name = var.name
  tags = var.tags
}

############################
#  REST API Configuration  #
############################
resource "aws_api_gateway_rest_api" "api_gw" {
  name        = "${module.resource_name_prefix.resource_name}-api-gw"
  description = "REST API Gateway for ${module.resource_name_prefix.resource_name}"

  endpoint_configuration {
    types            = var.create_private_endpoint ? ["PRIVATE"] : ["EDGE"]
    vpc_endpoint_ids = var.create_private_endpoint ? var.vpc_endpoint_ids : null
  }

  tags = var.tags
}

locals {
  expanded_endpoints = flatten([
    for key, endpoint in var.endpoints : [
      for method in endpoint.methods : {
        key    = key
        path   = endpoint.path
        method = method
        authorization = endpoint.authorization
      }
    ]
  ])
}

resource "aws_api_gateway_resource" "api_resource" {
  for_each = var.endpoints

  rest_api_id = aws_api_gateway_rest_api.api_gw.id
  parent_id   = aws_api_gateway_rest_api.api_gw.root_resource_id
  path_part   = each.value.path
}

resource "aws_api_gateway_method" "api_method" {
  for_each = { for idx, endpoint in local.expanded_endpoints : "${endpoint.key}-${endpoint.method}" => endpoint }

  rest_api_id   = aws_api_gateway_rest_api.api_gw.id
  resource_id   = aws_api_gateway_resource.api_resource[each.value.key].id
  http_method   = each.value.method
  authorization = each.value.authorization
  api_key_required = true
}

############################
#        Integration       #
############################
resource "aws_api_gateway_integration" "integration" {
  for_each = { for idx, endpoint in local.expanded_endpoints : "${endpoint.key}-${endpoint.method}" => endpoint }

  depends_on              = [aws_api_gateway_method.api_method]
  rest_api_id             = aws_api_gateway_rest_api.api_gw.id
  resource_id             = aws_api_gateway_resource.api_resource[each.value.key].id
  http_method             = each.value.method
  integration_http_method = each.value.method
  type                    = var.integration_type
  uri                     = var.integration_uri

  connection_type = var.create_vpc_link ? "VPC_LINK" : "INTERNET"
  connection_id   = var.create_vpc_link ? aws_api_gateway_vpc_link.vpc_link[0].id : null
}

###########################
#      API Usage Plan     #
###########################
resource "aws_api_gateway_usage_plan" "usage_plan" {
  depends_on  = [aws_api_gateway_stage.stage]
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
  depends_on  = [aws_api_gateway_method.api_method, aws_api_gateway_resource.api_resource, aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api_gw.id

  # Trigger for changes in methods or integrations
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_method.api_method))
  }

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
#     REST API Policy    #
##########################
data "aws_caller_identity" "current" {}

locals {
  policy_statements = [
    {
      Effect    = "Allow",
      Principal = "*",
      Action    = "execute-api:Invoke",
      Resource  = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/*",
      Condition = {
        IpAddress = {
          "aws:SourceIp" = var.allowed_ip_ranges
        }
      }
    },
    # Only add the Deny statement if use_private_endpoint is true
    var.create_private_endpoint ? {
      Effect    = "Deny",
      Principal = "*",
      Action    = "execute-api:Invoke",
      Resource  = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/*",
      Condition = {
        StringNotEquals = {
          "aws:sourceVpce" = var.vpc_endpoint_ids
        }
      }
    } : null
  ]
  # Filter out the null values from the policy statements
  filtered_policy_statements = [for policy in local.policy_statements : policy if policy != null]
}

resource "aws_api_gateway_rest_api_policy" "api_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gw.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = local.filtered_policy_statements
  })
}

##########################
#       VPC Links        #
##########################
resource "aws_api_gateway_vpc_link" "vpc_link" {
  count       = var.create_vpc_link ? 1 : 0 # Conditional creation
  name        = "${module.resource_name_prefix.resource_name}-vpc-link"
  description = "VPC link for ${module.resource_name_prefix.resource_name} API"
  target_arns = var.vpc_link_target_arns # 06/11/2023 - Note: Currently AWS only supports 1 target
}

##########################
#          IAM           #
##########################
resource "aws_iam_role" "api_gateway_role" {
  name = "${module.resource_name_prefix.resource_name}-api-gw-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "apigateway.amazonaws.com"
        },
        Effect = "Allow",
        Sid = ""
      }
    ]
  })
}

resource "aws_iam_role_policy" "api_invoke_policy" {
  name   = "${module.resource_name_prefix.resource_name}-invoke-policy"
  role   = aws_iam_role.api_gateway_role.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Action   = ["execute-api:Invoke"],
      Effect   = "Allow",
      Resource = ["arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.api_gw.id}/*/*/*"]
    }]
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
  role       = aws_iam_role.api_gateway_role.name
  policy_arn = aws_iam_policy.api_cloudwatch_logging_policy.arn
}

resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_role.arn
}

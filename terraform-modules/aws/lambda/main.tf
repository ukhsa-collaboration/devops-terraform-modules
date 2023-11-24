##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.2"

  name = var.name
  tags = var.tags
}

##########################
#         Lambda         #
##########################
resource "aws_lambda_function" "lambda" {
  function_name    = "${module.resource_name_prefix.resource_name}-lambda"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = var.runtime
  handler          = var.handler
  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [var.environment_variables]
    content {
      variables = environment.value
    }
  }

  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) == 0 && length(var.security_group_ids) == 0 ? [] : [1]
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }

  tracing_config {
    mode = var.xray_tracing ? "Active" : "PassThrough"
  }

  tags = var.tags
}


resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = aws_cloudwatch_log_group.lambda_log_group.arn
}

##########################
#           IAM          #
##########################
resource "aws_iam_role" "lambda_execution_role" {
  name = "${module.resource_name_prefix.resource_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Custom Policy Support
resource "aws_iam_role_policy_attachment" "custom_policies" {
  for_each   = toset(var.custom_policy_arns)
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = each.value
}


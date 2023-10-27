output "api_id" {
  value       = aws_api_gateway_rest_api.api_gw.id
  description = "The ID of the REST API Gateway"
}

output "api_url" {
  value       = "${aws_api_gateway_rest_api.api_gw.id}.execute-api.${var.aws_region}.amazonaws.com"
  description = "The URL of the REST API Gateway"
}

output "api_stage_name" {
  value       = [for stage in values(aws_api_gateway_stage.stage) : stage.stage_name]
  description = "The names of the deployed stages"
}

output "api_stage_invoke_url" {
  value = { for stage in toset(var.stage_names) : stage => aws_api_gateway_stage.stage[stage].invoke_url }
  description = "The invoke URL of the deployed stage"
}

output "stage_arns" {
  value = values({ for stage_name, stage in aws_api_gateway_stage.stage : stage_name => stage.arn })
  description = "The ARNs of the API Gateway stages."
}

output "api_key_id" {
  value       = aws_api_gateway_api_key.api_key.id
  description = "The ID of the API key"
}

output "api_key_value" {
  value       = aws_api_gateway_api_key.api_key.value
  description = "The value of the API key"
  sensitive   = true
}

output "usage_plan_id" {
  value       = aws_api_gateway_usage_plan.usage_plan.id
  description = "The ID of the API Gateway usage plan"
}

output "cloudwatch_log_group_name" {
  value       = { for stage, log_group in aws_cloudwatch_log_group.api_log_group : stage => log_group.name }
  description = "The names of the CloudWatch Log Groups for each stage."
}

output "cloudwatch_role_arn" {
  value       = aws_iam_role.api_gateway_cloudwatch_role.arn
  description = "The ARN of the IAM role used for CloudWatch logging"
}
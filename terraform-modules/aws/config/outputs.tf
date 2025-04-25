output "recorder_name" {
  value       = aws_config_configuration_recorder.config_recorder.name
  description = "Name of the AWS Config recorder."
}

output "config_role_arn" {
  value       = var.custom_config_role_arn != null ? var.custom_config_role_arn : aws_iam_role.config[0].arn
  description = "ARN of the IAM role used by AWS Config."
}

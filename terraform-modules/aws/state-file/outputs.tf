output "s3_state_bucket_arn" {
  value       = module.terraform_state.s3_bucket_arn
  description = "The ARN of the S3 state bucket"
}

output "s3_state_bucket_id" {
  value       = module.terraform_state.s3_bucket_id
  description = "The ID of the S3 state bucket"
}

output "s3_logging_bucket_arn" {
  value       = module.terraform_state.s3_bucket_arn
  description = "The ARN of the S3 logging bucket"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.terraform_locks.arn
  description = "The ARN of the DynamoDB table"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB table"
}
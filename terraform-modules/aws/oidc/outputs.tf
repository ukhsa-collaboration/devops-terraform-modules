output "aws_iam_role" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the IAM role"
}
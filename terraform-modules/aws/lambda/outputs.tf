output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.lambda.arn
}

output "lambda_function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.lambda.function_name
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda function."
  value       = aws_lambda_function.lambda.invoke_arn
}

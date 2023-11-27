##########################
# CloudFront Distribution
##########################
output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.cloudfront_distribution.id
  description = "The ID of the CloudFront distribution."
}

output "cloudfront_distribution_url" {
  value       = aws_cloudfront_distribution.cloudfront_distribution.domain_name
  description = "The domain name corresponding to the CloudFront distribution."
}

##########################
#      S3 Resources      #
##########################
output "s3_bucket_id" {
  value       = module.s3_bucket.bucket_id
  description = "The ID of the S3 bucket for logs."
}

output "s3_bucket_arn" {
  value       = module.s3_bucket.bucket_arn
  description = "The ARN of the S3 bucket for logs."
}

##########################
#  CloudFront OAI Config #
##########################
output "cloudfront_origin_access_identity_id" {
  value       = aws_cloudfront_origin_access_identity.oai.id
  description = "The ID of the CloudFront Origin Access Identity."
}

output "cloudfront_origin_access_identity_iam_arn" {
  value       = aws_cloudfront_origin_access_identity.oai.iam_arn
  description = "The IAM ARN of the CloudFront Origin Access Identity."
}

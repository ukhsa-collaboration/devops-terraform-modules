##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.1"

  name = var.name
  tags = var.tags
}

locals {
  origin_id = "${module.resource_name_prefix.resource_name}-origin"
}

##########################
# CloudFront Distribution
##########################
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = local.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${module.resource_name_prefix.resource_name} CloudFront Distribution - ${var.description}"

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin", "Authorization", "Content-Type"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.ttl["min_ttl"]
    default_ttl            = var.ttl["default_ttl"]
    max_ttl                = var.ttl["max_ttl"]
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type  = "whitelist"
      locations         = var.geo_restriction_locations
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.logs.bucket_domain_name}"
    prefix          = "cloudfront/logs/"
  }

  tags = var.tags
}

##########################
#      S3 Resources      #
##########################
locals {
  s3_bucket_name = "${module.resource_name_prefix.resource_name}-cloudfront-logs"
}

resource "aws_s3_bucket" "logs" {
  bucket = local.s3_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.logs.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.logs.id
  acl    = var.s3_acl
}

##########################
#  CloudFront OAI Config #
##########################
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for CloudFront to access ${local.s3_bucket_name} S3 bucket"
}

##########################
#   S3 Bucket Policy     #
##########################
resource "aws_s3_bucket_policy" "logs_policy" {
  bucket = aws_s3_bucket.logs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.oai.id}"
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.logs.arn}/*"
    }
  ]
}
POLICY
}
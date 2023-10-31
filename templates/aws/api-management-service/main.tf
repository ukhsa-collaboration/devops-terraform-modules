module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
  additional_tags = {
    "Purpose" = "Proof of Concept"
  }
}

module "api_gateway" {
    source = "../../terraform-modules/api-gateway"

    name = var.name

    lambda_function_name = aws_lambda_function.lambda.function_name #""
    lambda_function_invoke_arn = aws_lambda_function.lambda.invoke_arn #""

    aws_region = var.aws_region
    stage_names = [ "prod", "dev" ]

    endpoints = {
      example = {
        path = "example"
        methods = [ "POST", "GET" ] 
      }
    }

    allowed_ip_ranges = {
        prod = [ "0.0.0.0/0" ] 
        dev =  ["198.51.100.0/24", "198.51.100.1/24"]
    }

    log_retention_in_days = 1

    quota_settings = {
        limit = 5000
        offset = 0
        period = "MONTH"
    }

    throttle_settings = {
        burst_limit = 200
        rate_limit = 100
    }

    tags = module.tags.tags
}

module "waf" {
  source = "../../terraform-modules/waf"

  name = var.name
  waf_description = "API Gateway WAF"

  aws_region               = var.aws_region

  # Web Application Firewall Config
  scope                    = "REGIONAL"
  sampled_requests_enabled = false

  # Resource association 
  association_resource_arns = module.api_gateway.stage_arns

  # Logging Config
  retention_in_days        = 30

  tags = module.tags.tags
}

module "cloudfront_distribution" {
  source = "../../terraform-modules/cloudfront-distribution"

  # Naming Config
  name = var.name
  description = "API Gateway"

  # CloudFront Distribution
  domain_name                 = module.api_gateway.api_url
  allowed_methods             = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  cached_methods              = ["GET", "HEAD"]
  geo_restriction_locations   = ["GB"]
  ttl                         = { min_ttl = 0,   default_ttl = 3600,  max_ttl = 86400 }

  # S3 Resources
  s3_acl                      = "private"
  object_ownership            = "BucketOwnerPreferred"

  tags = module.tags.tags
}

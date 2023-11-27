##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.2"

  name = var.name
  tags = var.tags
}

##########################
#        S3 Bucket       #
##########################
# Generate random suffix to make bucket unique
resource "random_string" "unique_bucket_suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${module.resource_name_prefix.resource_name}-${var.bucket_name}-${random_string.unique_bucket_suffix.result}"
  acl           = var.bucket_acl
  force_destroy = var.force_destroy

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.encryption_algorithm
      }
    }
  }

  lifecycle_rule {
    enabled = var.lifecycle_rule_enabled

    noncurrent_version_expiration {
      days = var.noncurrent_version_expiration_days
    }

    expiration {
      days = var.expiration_days
    }
  }

  tags = var.tags
}

# Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.bucket_ownership
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "terraform_state_bucket" {
  statement {
    sid = "allow-user-list-access"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = distinct(var.iam_principals, data.aws_caller_identity.current.arn)
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]

    resources = [
      module.terraform_state.s3_bucket_arn,
      "${module.terraform_state.s3_bucket_arn}/*"
    ]
  }
}

module "terraform_state" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v4.1.2"

  bucket = "${data.aws_caller_identity.current.account_id}-${var.region_name}-state"

  attach_policy                            = true
  attach_public_policy                     = true
  policy                                   = data.aws_iam_policy_document.terraform_state_bucket.json
  attach_deny_insecure_transport_policy    = true
  attach_require_latest_tls_policy         = true
  attach_deny_incorrect_encryption_headers = true
  attach_deny_unencrypted_object_uploads   = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }

  logging = {
    target_bucket = module.terraform_state_log.s3_bucket_id
    target_prefix = "log/"
    target_object_key_format = {
      partitioned_prefix = {
        partition_date_source = "DeliveryTime"
      }
    }
  }

  server_side_encryption_configuration = {
    rule = {
      #checkov:skip=CKV2_AWS_67:Using a CMK is decided by the caller of the module and creating one is out-of-scope here.
      apply_server_side_encryption_by_default = {
        kms_master_key_id = length(var.state_bucket_kms_key_id) > 0 ? var.state_bucket_kms_key_id : null
        sse_algorithm     = length(var.state_bucket_kms_key_id) > 0 ? "AES256" : "aws:kms"
      }
    }
  }
}

module "terraform_state_log" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v4.1.2"

  bucket = "${data.aws_caller_identity.current.account_id}-${var.region_name}-state-logs"

  attach_policy                            = true
  attach_public_policy                     = true
  attach_deny_insecure_transport_policy    = true
  attach_require_latest_tls_policy         = true
  attach_deny_incorrect_encryption_headers = true
  attach_deny_incorrect_kms_key_sse        = true
  attach_deny_unencrypted_object_uploads   = true

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  access_log_delivery_policy_source_accounts = [data.aws_caller_identity.current.account_id]
  access_log_delivery_policy_source_buckets  = [module.terraform_state.s3_bucket_arn]

  allowed_kms_key_arn = length(var.state_bucket_kms_key_id) > 0 ? var.state_bucket_kms_key_id : null

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      #checkov:skip=CKV2_AWS_67:Using a CMK is decided by the caller of the module and creating one is out-of-scope here.
      apply_server_side_encryption_by_default = {
        kms_master_key_id = length(var.state_bucket_kms_key_id) > 0 ? var.state_bucket_kms_key_id : null
        sse_algorithm     = length(var.state_bucket_kms_key_id) > 0 ? "AES256" : "aws:kms"
      }
    }
  }
}


resource "aws_dynamodb_table" "terraform_locks" {
  # checkov:skip=CKV_AWS_28:The state lock table is ephemeral and doesn't need PITR.
  # checkov:skip=CKV_AWS_119:No data is contained in this table. Encrypting with CMK is unnecessary.
  name         = "${var.region_name}-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
}
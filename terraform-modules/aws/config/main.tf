# Service-linked role (required once per account)
resource "aws_iam_service_linked_role" "config" {
  aws_service_name = "config.amazonaws.com"
}

data "aws_iam_policy_document" "config_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "config" {
  count              = var.custom_config_role_arn == null ? 1 : 0
  name               = "AuditAccountConfigAggregatorRole"
  description        = "Role used by AWS Config to list and describe AWS resources"
  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json
}

resource "aws_iam_role_policy_attachment" "config_policy_attach" {
  count      = var.custom_config_role_arn == null ? 1 : 0
  role       = aws_iam_role.config[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "default"
  role_arn = var.custom_config_role_arn != null ? var.custom_config_role_arn : aws_iam_role.config[0].arn

  recording_group {
    all_supported = false

    exclusion_by_resource_types {
      resource_types = [
        "AWS::IAM::Group",
        "AWS::IAM::Policy",
        "AWS::IAM::Role",
        "AWS::IAM::User"
      ]
    }

    recording_strategy {
      use_only = "EXCLUSION_BY_RESOURCE_TYPES"
    }
  }
}


resource "aws_config_delivery_channel" "audit" {
  s3_bucket_name = var.audit_bucket_name
  depends_on     = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.audit]
}


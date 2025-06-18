terraform {
  required_version = ">= 1.0" 
}

locals {
  mandatory_tag_names = toset([
    "lz-TechOwner",
    "lz-CostCode", 
    "lz-BillingOwner",
    "lz-BusinessOwner",
    "lz-SupportTier",
    "lz-GovernmentSecurityClassification",
    "lz-Service",
    "lz-Environment",
    "lz-Team",
    "lz-Notification",
    "lz-LeanIXId"
  ])
}

# Data sources for mandatory universal tags
data "aws_ssm_parameter" "mandatory_universal_tags" {
  for_each =  local.mandatory_tag_names
  
  name = "/tagging/mandatory/universal/${each.key}"
}

locals {
  mandatory_tags = {
    for key in local.mandatory_tags : key => data.aws_ssm_parameter.mandatory_universal_tags[key].value
  }

  additional_tags = {
    for k, v in var.additional_tags :
    k => v if length(v) > 0
  }

  all_tags = merge(
    local.mandatory_tags,
    local.additional_tags
  )
}

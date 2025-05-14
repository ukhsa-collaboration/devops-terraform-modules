locals {
  mandatory_tags = {
    "Owner"           = var.owner
    "BillingOwner"    = var.billing_owner
    "Service"         = var.service
    "Environment"     = var.environment
    "Confidentiality" = var.confidentiality
  }

  raw_optional_tags = {
    "Directorate" = var.directorate
    "Team"        = var.team
  }
  optional_tags = {
    for k, v in local.raw_optional_tags :
    k => v if length(v) > 0
  }

  additional_tags = {
    for k, v in var.additional_tags :
    k => v if length(v) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", v))
  }

  all_tags = merge(
    local.mandatory_tags,
    local.optional_tags,
    local.additional_tags
  )
}
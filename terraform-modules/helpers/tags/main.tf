terraform {
  required_version = ">= 1.0" 
}

locals {
  mandatory_tags = {
    "lz-TechOwner"                        = var.lz_tech_owner
    "lz-CostCode"                         = var.lz_cost_code
    "lz-BillingOwner"                     = var.lz_billing_owner
    "lz-BusinessOwner"                    = var.lz_business_owner
    "lz-SupportTier"                      = var.lz_support_tier
    "lz-GovernmentSecurityClassification" = var.lz_government_security_classification
    "lz-Service"                          = var.lz_service
    "lz-Environment"                      = var.lz_environment
    "lz-Team"                             = var.lz_team
    "lz-Notification"                     = var.lz_notification
    "lz-LeanIXId"                         = var.lz_lean_ix_id
  }

  specific_mandatory_tags = {
    "lz-BackupPlan" = var.lz_backup_plan
  }

  raw_optional_tags = {
    "lz-GitCommitURL"       = var.lz_git_commit_url
    "lz-Schedule"           = var.lz_schedule
    "lz-DataClassification" = var.lz_data_classification
    "lz-HealthData"         = var.lz_health_data
  }
  
  optional_tags = {
    for k, v in local.raw_optional_tags :
    k => v if length(v) > 0
  }

  additional_tags = {
    for k, v in var.additional_tags :
    k => v if length(v) > 0
  }

  all_tags = merge(
    local.mandatory_tags,
    local.specific_mandatory_tags,
    local.optional_tags,
    local.additional_tags
  )
}

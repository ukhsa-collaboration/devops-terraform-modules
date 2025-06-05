# LZ Mandatory Tags
variable "lz_tech_owner" {
  description = "(Mandatory) Technical person (or team) responsible for the workload. First point of contact for incidents and technical enquiries."
  type        = string

  validation {
    condition     = length(var.lz_tech_owner) > 0 && can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.lz_tech_owner))
    error_message = "The lz_tech_owner variable must be a valid Civil Servant email address."
  }
}

variable "lz_cost_code" {
  description = "(Mandatory) Finance for the given project/workload, validated during the keyholder process. Used to determine cost of cloud-based resources for a given workload or project."
  type        = string

  validation {
    condition     = length(var.lz_cost_code) > 0 && can(regex("^[A-Z][0-9]{3}$", var.lz_cost_code))
    error_message = "The lz_cost_code variable must be 1 letter followed by 3 digits (e.g., A123)."
  }
}

variable "lz_billing_owner" {
  description = "(Mandatory) To establish billing ownership across accounts/subscriptions to enable Showback/Chargeback strategy."
  type        = string

  validation {
    condition     = length(var.lz_billing_owner) > 0 && can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.lz_billing_owner))
    error_message = "The lz_billing_owner variable must be a valid Civil Servant email address."
  }
}

variable "lz_backup_plan" {
  description = "(Mandatory) Describe the backup plan that should be associated with the resource."
  type        = string

  validation {
    condition     = length(var.lz_backup_plan) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.lz_backup_plan))
    error_message = "The lz_backup_plan variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "lz_government_security_classification" {
  description = "(Mandatory) Classification according to the Government Security Classification Policy."
  type        = string

  validation {
    condition     = contains(["OFFICIAL", "OFFICIAL-SENSITIVE", "SECRET", "TOP SECRET"], var.lz_government_security_classification)
    error_message = "The lz_government_security_classification variable must be one of: OFFICIAL, OFFICIAL-SENSITIVE, SECRET, TOP SECRET."
  }
}

variable "lz_service" {
  description = "(Mandatory) Name of the service that is delivered via this account/subscription."
  type        = string

  validation {
    condition     = length(var.lz_service) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.lz_service))
    error_message = "The lz_service variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "lz_environment" {
  description = "(Mandatory) The environment that the account services, e.g, Pre-Production, Production, Development."
  type        = string

  validation {
    condition     = contains(["Production", "PreProduction", "Development", "Sandbox"], var.lz_environment)
    error_message = "The lz_environment variable must be one of: Production, PreProduction, Development, Sandbox."
  }
}

variable "lz_support_tier" {
  description = "(Mandatory) Support wrapper - RTO and RPO."
  type        = string

  validation {
    condition     = contains(["Platinum", "Gold", "Silver", "Bronze"], var.lz_support_tier)
    error_message = "The lz_support_tier variable must be one of: Platinum, Gold, Silver, Bronze."
  }
}

variable "lz_team" {
  description = "(Mandatory) To relate a workload back to a team in the absence of an existing person as an owner."
  type        = string

  validation {
    condition     = length(var.lz_team) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.lz_team))
    error_message = "The lz_team variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "lz_notification" {
  description = "(Mandatory) Email address to send notifications to."
  type        = string

  validation {
    condition     = length(var.lz_notification) > 0 && can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.lz_notification))
    error_message = "The lz_notification variable must be a valid email address."
  }
}

variable "lz_lean_ix_id" {
  description = "(Mandatory) Reference to record in LeanIX."
  type        = number

  validation {
    condition     = var.lz_lean_ix_id > 0
    error_message = "The lz_lean_ix_id variable must be a valid positive number."
  }
}

# LZ Optional Tags
variable "lz_business_owner" {
  description = "(Optional) Business person responsible for the workload. First point of contact for business related enquiries. Only required if different from TechOwner."
  type        = string
  default     = ""

  validation {
    condition     = length(var.lz_business_owner) == 0 || can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.lz_business_owner))
    error_message = "The lz_business_owner variable must be a valid Civil Servant email address."
  }
}

variable "lz_schedule" {
  description = "(Optional) Define compute downtime schedule for cost savings on batch and non-prod workloads."
  type        = string
  default     = ""

  validation {
    condition     = length(var.lz_schedule) == 0 || can(regex("^[-a-zA-Z0-9_ @.]+$", var.lz_schedule))
    error_message = "The lz_schedule variable can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "lz_data_classification" {
  description = "(Optional) The classification or type of data that is being held."
  type        = string
  default     = ""

  validation {
    condition     = length(var.lz_data_classification) == 0 || contains(["Personal", "Commercial", "Corporate"], var.lz_data_classification)
    error_message = "The lz_data_classification variable must be one of: Personal, Commercial, Corporate."
  }
}

variable "lz_git_commit_url" {
  description = "(Optional) Resource level information to assist in tracking down issue root caused during incidents."
  type        = string
  default     = ""

  validation {
    condition     = length(var.lz_git_commit_url) == 0 || can(regex("^https?://", var.lz_git_commit_url))
    error_message = "The lz_git_commit_url variable must be a valid URL starting with http:// or https://."
  }
}

variable "lz_health_data" {
  description = "(Optional) Whether the data held is related to health information."
  type        = bool
  default     = null

  validation {
    condition     = var.lz_health_data == null || can(var.lz_health_data)
    error_message = "The lz_health_data variable must be true or false."
  }
}

# Others
variable "additional_tags" {
  description = "(Optional) Any additional tags you want to add to AWS resources"
  type        = map(string)
  default     = {}
}
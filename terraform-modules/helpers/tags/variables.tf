# Mandatory
variable "owner" {
  description = "(Mandatory) The owner of the workload or application"
  type        = string

  validation {
    condition     = length(var.owner) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.owner))
    error_message = "The owner variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "billing_owner" {
  description = "(Mandatory) The owner of billing for the workload or application"
  type        = string

  validation {
    condition     = length(var.billing_owner) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.billing_owner))
    error_message = "The billing_owner variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "service" {
  description = "(Mandatory) Project name to which the resource is associated"
  type        = string

  validation {
    condition     = length(var.service) > 0 && can(regex("^[-a-zA-Z0-9_ @.]+$", var.service))
    error_message = "The service variable must be set to a non-empty string and can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "environment" {
  description = "(Mandatory) The environment for this deployment (Development, Test, Pre-Production or Production)"
  type        = string

  validation {
    condition     = contains(["Development", "Test", "Pre-Production", "Production"], var.environment)
    error_message = "The environment variable can only be set to 'Development', 'Test', 'Pre-Production' or 'Production'."
  }
}

variable "confidentiality" {
  description = "(Mandatory) The confidentiality level of the data being processed (OFFICIAL or OFFICIAL-SENSITIVE)"
  type        = string

  validation {
    condition     = contains(["OFFICIAL", "OFFICIAL-SENSITIVE"], var.confidentiality)
    error_message = "The confidentiality variable can only be set to 'OFFICIAL' or 'OFFICIAL-SENSITIVE'"
  }
}

# Optional
variable "directorate" {
  description = "(Optional) The directorate responsible for the workload or application"
  type        = string
  default     = ""

  validation {
    condition     = length(var.directorate) == 0 || can(regex("^[-a-zA-Z0-9_ @.]+$", var.directorate))
    error_message = "The directorate variable can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

variable "team" {
  description = "(Optional) The team responsible for the workload or application"
  type        = string
  default     = ""

  validation {
    condition     = length(var.team) == 0 || can(regex("^[-a-zA-Z0-9_ @.]+$", var.team))
    error_message = "The team variable can only contain: a-z, A-Z, 0-9, _, -, @, ."
  }
}

# Others
variable "additional_tags" {
  description = "(Optional) Any additional tags you want to add to AWS resources"
  type        = map(string)
  default     = {}
}

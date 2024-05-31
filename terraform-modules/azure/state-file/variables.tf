variable "location" {
  description = "The Azure region to create resources in."
  type        = string
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "tfstate"
}

variable "environment" {
  description = "The environment you are created eg. dev"
  type        = string
  default     = "dev"
}

variable "storage_account" {
  description = "Storage account configuration."
  type = map(object({
    account_kind                      = optional(string)
    account_tier                      = optional(string, "Standard")
    account_replication_type          = string
    enable_https_traffic_only         = optional(string)
    min_tls_version                   = optional(string)
    shared_access_key_enabled         = optional(string, "false")
    default_to_oauth_authentication   = optional(string, "true")
    infrastructure_encryption_enabled = optional(string)

    blob_properties = optional(object({
      versioning_enabled            = optional(string, "true")
      change_feed_enabled           = optional(string, "true")
      change_feed_retention_in_days = optional(number, 90)
      last_access_time_enabled      = optional(string, true)

      delete_retention_policy = optional(object({
        days = optional(number)
      }))
      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))
    }))


  }))
  default = {}
}
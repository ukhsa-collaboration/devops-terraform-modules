variable "storage_account_name" {
  description = "The name of the storage account to deploy."
  type        = string
  default     = "terraformstate"
}

variable "location" {
  description = "The Azure region to create resources in."
  type        = string
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "tfstateellis"
}

variable "environment" {
  description = "The environment you are created eg. dev"
  type        = string
  default     = "dev"
}


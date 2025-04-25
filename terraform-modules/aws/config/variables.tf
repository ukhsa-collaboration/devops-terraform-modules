variable "audit_bucket_name" {
  description = "Name of the S3 bucket where AWS Config will deliver configuration snapshots. Must exist with correct policy."
  type        = string
}

variable "custom_config_role_arn" {
  description = "Optional: ARN of a pre-created IAM role for AWS Config to use. If not set, this module will create one."
  type        = string
  default     = null
}

variable "all_supported" {
  description = "Whether to record all supported AWS resource types."
  type        = bool
  default     = true
}

variable "include_global_resource_types" {
  description = "Whether to include global resource types (like IAM)."
  type        = bool
  default     = true
}
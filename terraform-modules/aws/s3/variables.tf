########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "bucket_acl" {
  description = "The access control list (ACL) of the bucket"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "The encryption algorithm to use"
  type        = string
  default     = "AES256"
}

variable "lifecycle_rule_enabled" {
  description = "Enable lifecycle rules"
  type        = bool
  default     = false
}

variable "noncurrent_version_expiration_days" {
  description = "Number of days to retain noncurrent versions"
  type        = number
  default     = 30
}

variable "expiration_days" {
  description = "Number of days after which to expunge the objects"
  type        = number
  default     = 90
}

variable "bucket_ownership" {
  description = "Defines the ownership control of the bucket"
  type        = string
  default     = "BucketOwnerPreferred"
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}
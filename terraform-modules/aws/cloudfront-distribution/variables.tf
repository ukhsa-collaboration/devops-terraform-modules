########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

###########################
# CloudFront Distribution #
###########################
variable "domain_name" {
  description = "The domain name for the CloudFront Distribution's origin."
  type        = string
}

variable "description" {
  description = "The description of the Web Application Firewall."
  type        = string
}

variable "allowed_methods" {
  description = "HTTP methods that are processed by the distribution."
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  description = "HTTP methods that are cached by the distribution."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "geo_restriction_locations" {
  description = "The countries in which viewers are allowed to access your distribution."
  type        = list(string)
  default     = ["GB"]
}

variable "ttl" {
  description = "TTL settings for the CloudFront Distribution."
  type        = map(number)
  default     = {
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }
}

##########################
#      S3 Resources      #
##########################
variable "s3_acl" {
  description = "The canned ACL to apply to the S3 bucket."
  type        = string
  default     = "private"
}

variable "object_ownership" {
  description = "Specifies the Object Ownership controls for the S3 bucket."
  type        = string
  default     = "BucketOwnerPreferred"
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}

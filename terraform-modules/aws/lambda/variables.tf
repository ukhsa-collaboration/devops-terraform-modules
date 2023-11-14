########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

##########################
#         Lambda         #
##########################
variable "runtime" {
  description = "The identifier of the function's runtime."
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = string
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem."
  type        = string
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda function."
  type        = map(string)
  default     = {}
}

variable "subnet_ids" {
  description = "List of subnet IDs associated with the Lambda function."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "List of security group IDs associated with the Lambda function."
  type        = list(string)
  default     = []
}

variable "xray_tracing" {
  description = "Enable X-Ray tracing."
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Number of days to retain log events in the log group for the Lambda function."
  type        = number
  default     = 14
}

variable "aws_region" {
  description = "The AWS region where the Lambda function is deployed."
  type        = string
}

variable "custom_policy_arns" {
  description = "A list of custom policy ARNs to attach to the Lambda execution role"
  type        = list(string)
  default     = []
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}
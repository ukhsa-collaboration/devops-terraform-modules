########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

###########################
#  REST API Configuration  #
###########################
variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created"
}

variable "endpoints" {
  type        = map(object({
    path    = string
    methods = list(string)
  }))
  description = "A map of endpoint configurations, each with a path and a list of methods"
}

############################
#    Lambda Integration    #
############################
variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "lambda_function_invoke_arn" {
  description = "The ARN of the Lambda function."
  type        = string
}

##########################
#     API Deployment     #
##########################
variable "stage_names" {
  type        = list(string)
  description = "The name of the stage for API Gateway deployment. Stages are limited to dev or prod but can be expanded in the future"

  validation {
    condition     = length(var.stage_names) > 0 && alltrue([for name in var.stage_names : name == "dev" || name == "prod"])
    error_message = "The stage_names variable must be a list containing either 'dev' or 'prod' or both."
  }
}

##########################
#    Specify IP Ranges   #
##########################
variable "allowed_ip_ranges" {
  type        = map(list(string))
  description = "A map of allowed IP ranges for each stage."
}

##########################
#      CloudWatch        #
##########################
variable "log_retention_in_days" {
  type        = number
  description = "The number of days to retain log events in CloudWatch"
}

##########################
#     Other Settings     #
##########################
variable "quota_settings" {
  type        = object({
    limit  = number
    offset = number
    period = string
  })
  description = "A map of quota settings for the API Usage Plan"
  default     = {
    limit  = 5000
    offset = 0
    period = "MONTH"
  }
}

variable "throttle_settings" {
  type        = object({
    burst_limit = number
    rate_limit  = number
  })
  description = "A map of throttle settings for the API Usage Plan"
  default     = {
    burst_limit = 200
    rate_limit  = 100
  }
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}

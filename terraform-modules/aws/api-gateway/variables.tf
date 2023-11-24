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
  type = map(object({
    path          = string
    methods       = list(string)
    authorization = string
  }))
  description = "A map of endpoint configurations, each with a path and a list of methods"
}

############################
#       Integration        #
############################
variable "integration_uri" {
  description = "The integration URI of your resource."
  type        = string
}

variable "integration_type" {
  description = "The integration type of your resource."
  type        = string
}


############################
#    Custom Authorizers    #
############################
variable "custom_auth_lambda" {
  description = "Configuration for the Lambda function"
  type = object({
    runtime         = string
    handler         = string
    filename        = string
    authTokenHeader = string
    aws_region      = string
  })
  # You can set default values if appropriate
  default = {
    runtime         = ""
    handler         = ""
    filename        = ""
    authTokenHeader = ""
    aws_region      = ""
  }
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
  type        = list(string)
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
#     Throttle/Quota     #
##########################
variable "quota_settings" {
  type = object({
    limit  = number
    offset = number
    period = string
  })
  description = "A map of quota settings for the API Usage Plan"
  default = {
    limit  = 5000
    offset = 0
    period = "MONTH"
  }
}

variable "throttle_settings" {
  type = object({
    burst_limit = number
    rate_limit  = number
  })
  description = "A map of throttle settings for the API Usage Plan"
  default = {
    burst_limit = 200
    rate_limit  = 100
  }
}

##########################
#   Input validation    #
##########################
variable "model_schema" {
  description = "The model schema for request validation"
  type = object({
    name : string
    description : string
    content_type : string
    schema : string
  })
  default = {
    name         = "DefaultModel"
    description  = "Default Terraform Module Model Scheme"
    content_type = "application/json"
    schema       = <<EOF
{
  "type": "object",
  "properties": {}
}
EOF
  }
}

##########################
#       VPC Links        #
##########################
variable "create_vpc_link" {
  description = "Whether to create a VPC Link for the API Gateway integration"
  type        = bool
  default     = false
}

variable "vpc_link_target_arns" {
  description = "List of ARNs to be used by the VPC Link"
  default     = []
  type        = list(string)
}

##########################
#   Private Endpoints    #
##########################
variable "create_private_endpoint" {
  description = "Whether to create a private endpoint for the API Gateway"
  type        = bool
  default     = false
}

variable "vpc_endpoint_ids" {
  description = "List of VPC Endpoint IDs to associate with the API Gateway if a private endpoint is used"
  type        = list(string)
  default     = []
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}

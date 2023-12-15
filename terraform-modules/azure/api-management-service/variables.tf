########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

##########################
#    Resource Group      #
##########################
variable "resource_group" {
  description = "The name of the resource group where resources will be created."
  type        = string
}

##########################
# API Management Service #
##########################
variable "publisher_email" {
  default     = "test@contoso.com"
  description = "The email address of the owner of the service"
  type        = string
  validation {
    condition     = length(var.publisher_email) > 0
    error_message = "The publisher_email must contain at least one character."
  }
}

variable "publisher_name" {
  default     = "publisher"
  description = "The name of the owner of the service"
  type        = string
  validation {
    condition     = length(var.publisher_name) > 0
    error_message = "The publisher_name must contain at least one character."
  }
}

variable "sku" {
  description = "The pricing tier of this API Management service"
  default     = "Developer"
  type        = string
  validation {
    condition     = contains(["Developer", "Standard", "Premium"], var.sku)
    error_message = "The sku must be one of the following: Developer, Standard, Premium."
  }
}

variable "sku_count" {
  description = "The instance size of this API Management service."
  default     = 1
  type        = number
  validation {
    condition     = contains([1, 2], var.sku_count)
    error_message = "The sku_count must be one of the following: 1, 2."
  }
}

##########################
# API Configuration      #
##########################
variable "api_revision" {
  description = "The revision number of the API."
  default     = "1"
  type        = string
}

variable "api_path" {
  description = "The URL path for accessing the API."
  type        = string
}

variable "api_protocols" {
  description = "The array of protocols the API uses (e.g., ['https'])."
  type        = list(string)
  default     = ["https"]
}

variable "api_import_content_format" {
  description = "The format of the imported API content (e.g., 'swagger-json')."
  type        = string
}

variable "api_import_content_value" {
  description = "The value for the imported content (e.g., URL or inline JSON)."
  type        = string
}

##########################
# Application Insights   #
##########################
variable "app_insights_type" {
  description = "The type of Application Insights (e.g., 'web')."
  default     = "web"
  type        = string
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}

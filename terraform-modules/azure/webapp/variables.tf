
######################################
#     Environment setup              #
######################################

variable "env" {
  description = "The environment in which the resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region in which all resources should be created"
  type        = string
}

######################################
#          Service plan              #
######################################

variable "service_plan_id" {
  description = "The ID of the Azure App Service Plan"
  type        = string
}

######################################
#     Webapp config                  #
######################################

variable "webapp_config" {
  description = "Configuration settings for the Azure Web App"

  type = object({
    web_app_name                  = string
    virtual_network_subnet_id     = string
    enable_client_affinity        = bool
    enable_https                  = bool
    always_on                     = bool
    restriction_action            = optional(string)
    restriction_name              = optional(string)
    restriction_priority          = optional(number)
    restriction_service_tag       = optional(string)
    auth_settings_enabled         = optional(bool)
    client_certificate_enabled    = optional(bool)
    public_network_access_enabled = optional(bool)
    ftps_state                    = optional(string)
    http_logs                     = optional(bool)
    detailed_error_messages       = optional(bool)
    failed_request_tracing        = optional(bool)
    retention_in_days             = optional(number)
    retention_in_mb               = optional(number)
    http2_enabled                 = optional(bool)
    health_check_path             = optional(string)
  })
}

variable "webapp_storage" {
  description = "Configuration settings for the Azure Web App"

  type = object({
    name         = optional(string)
    type         = optional(string)
    account_name = optional(string)
    access_key   = optional(string)
    share_name   = optional(string)
  })
}

######################################
#     Connection varialbles          #
######################################

variable "connection_target_resource" {
  description = "Enable Always On for the Azure Web App"
  type        = string
  default     = ""
}

variable "webapp_connection_config" {
  type = object({
    service_connection_name        = optional(string)
    connection_authentication_type = optional(string)
  })
  default = {}
}

######################################
#            Tagging                 #
######################################

variable "tags" {
  description = "(Required) Tags to be assigned to the resources, must include project, client, owner and environment keys"
  type = object({
    project         = string
    client          = string
    owner           = string
    environment     = string
    additional_tags = optional(map(string))
  })
  nullable = false
}
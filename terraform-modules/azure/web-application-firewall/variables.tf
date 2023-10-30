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

############################
# Web Application Firewall #
############################
variable "managed_rules" {
  description = "A list of additional managed rules to apply."
  type        = list(object({
    type    = string
    version = string
  }))
  default     = []
}

variable "custom_rules" {
  description = "A list of custom rules for the Web Application Firewall Policy."
  type        = list(object({
    name                   = string
    priority               = number
    rule_type              = string
    action                 = string
    match_variable_name    = string
    match_variable_operator= string
    match_variable_selector= string
    condition_operator     = string
    condition_negation     = bool
    condition_match_values = list(string)
  }))
  default     = []
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}
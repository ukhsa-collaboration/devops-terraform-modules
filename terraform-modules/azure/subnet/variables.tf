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
variable "virtual_network_name" {
  description = "The name of the virtual network to which the subnet is attached."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

variable "service_delegations" {
  description = "A list of delegation blocks for services."
  type = list(object({
    name                       = string
    service_delegation_name    = string
    service_delegation_actions = list(string)
  }))
  default = []
}

variable "service_endpoints" {
  description = "List of service endpoints to associate with the subnet"
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

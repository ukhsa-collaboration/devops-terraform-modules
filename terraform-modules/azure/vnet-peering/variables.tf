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
#       VNET Peering       #
############################
variable "peering_name" {
  description = "Name of the VNet peering."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "remote_vnet_id" {
  description = "Resource ID of the remote virtual network."
  type        = string
}

variable "allow_vnet_access" {
  description = "Whether the VNets can access each other."
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Whether forwarded traffic from VNets is allowed."
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Whether gateway transit is allowed."
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Whether to use remote gateways."
  type        = bool
  default     = false
}


########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}

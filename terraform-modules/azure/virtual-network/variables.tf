variable "name" {
  description = "The name of the virtual network"
  type        = string
}

##########################
#    Resource Group      #
##########################
variable "resource_group" {
  description = "The name of the resource group where resources will be created."
  type        = string
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "The DNS servers to be used with the vNet"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

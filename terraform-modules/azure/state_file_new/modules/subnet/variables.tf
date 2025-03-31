variable "name" {
  type     = string
  nullable = false
}

variable "virtual_network_id" {
  type     = string
  nullable = false
}

variable "address_prefix" {
  type    = string
  default = null
}

variable "address_prefixes" {
  type    = list(string)
  default = null

  validation {
    condition     = var.address_prefixes != null ? length(var.address_prefixes) > 0 : var.address_prefix != null
    error_message = "One of `address_prefix` or `address_prefixes` must be supplied."
  }
}

variable "default_outbound_access_enabled" {
  type     = bool
  default  = false
  nullable = false
}

variable "delegation" {
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  }))
  default = null
}

variable "nat_gateway" {
  type = object({
    id = string
  })
  default = null
}

variable "network_security_group_id" {
  type    = string
  default = null
}

variable "private_endpoint_network_policies" {
  type     = string
  default  = "Enabled"
  nullable = false

  validation {
    condition     = can(regex("^(Disabled|Enabled|NetworkSecurityGroupEnabled|RouteTableEnabled)$", var.private_endpoint_network_policies))
    error_message = "private_endpoint_network_policies must be one of Disabled, Enabled, NetworkSecurityGroupEnabled, or RouteTableEnabled."
  }
}

variable "private_link_service_network_policies_enabled" {
  type     = bool
  default  = true
  nullable = false
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default  = {}
  nullable = false
}

variable "route_table" {
  type = object({
    id = string
  })
  default = null
}

variable "service_endpoint_policies" {
  type = map(object({
    id = string
  }))
  default = null
}

variable "service_endpoints" {
  type    = set(string)
  default = null
}

variable "sharing_scope" {
  type    = string
  default = null

  validation {
    condition     = var.sharing_scope != null ? can(regex("^(DelegatedServices|Tenant)$", var.sharing_scope)) : true
    error_message = "sharing_scope must be one of DelegatedServices or Tenant."
  }
}

variable "subscription_id" {
  type    = string
  default = null
}

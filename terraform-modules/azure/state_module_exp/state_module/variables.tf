variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy storage account to"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
}

variable "resource_group_name_vnet" {
  description = "Resource Group Name of Virtual Network"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group of Subnet"
  type        = string
}

variable "subnet_name" {
  description = "Subnet where the private endpoint will be created to access the storage account"
  type        = string
}

variable "address_prefix" {
  description = "Address range of subnet"
  type        = string
}

variable "project_name" {
  description = "Acronym of project name to include in naming the Private Endpoint resource i.e. strcse, cmwapi, lsapi, apim"
  type = string
}

variable "environment" {
  description = "Environment where the storage account is to be deployed i.e. test, prod, dev"
  type = string
}

# Forming storage account name
locals {
  subscription_id_no_dashes = replace(data.azurerm_client_config.az-client-config.subscription_id, "-", "")
  subscription_id_first_12 = substr(local.subscription_id_no_dashes, 0, 12)
  st_name = "${local.subscription_id_first_12}state"
}
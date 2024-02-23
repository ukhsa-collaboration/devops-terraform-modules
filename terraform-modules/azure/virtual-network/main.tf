##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.2"

  name = var.name
  tags = var.tags
}

##########################
#     Resource Group     #
##########################
data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

############################
#  REST API Configuration  #
############################
resource "azurerm_virtual_network" "vnet" {
  name                = "${module.resource_name_prefix.resource_name}-vn"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.tags
}
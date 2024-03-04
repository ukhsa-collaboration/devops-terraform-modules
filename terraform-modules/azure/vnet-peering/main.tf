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
#       VNET Peering       #
############################
resource "azurerm_virtual_network_peering" "vnet_peering" {
  name                         = "${module.resource_name_prefix.resource_name}-vnet-peering"
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = var.remote_vnet_id
  allow_virtual_network_access = var.allow_vnet_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}

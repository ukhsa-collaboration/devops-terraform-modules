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
resource "azurerm_subnet" "subnet" {
  name                 = "${module.resource_name_prefix.resource_name}-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  dynamic "delegation" {
    for_each = var.service_delegations
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = delegation.value.service_delegation_actions
      }
    }
  }
}
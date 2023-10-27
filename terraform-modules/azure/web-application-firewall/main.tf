##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/resource-name-prefix?ref=resource-name-prefix/vALPHA_0.0.0"

  name = var.name
  tags = var.tags
}

##########################
#    Resource Group      #
##########################
data "azurerm_resource_group" "group" {
  name = var.resource_group
}

############################
# Web Application Firewall #
############################


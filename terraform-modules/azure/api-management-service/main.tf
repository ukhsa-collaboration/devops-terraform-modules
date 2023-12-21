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
resource "azurerm_api_management" "api" {
  name                = "${module.resource_name_prefix.resource_name}-api-mgmt"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  publisher_email     = var.publisher_email
  publisher_name      = var.publisher_name
  sku_name            = "${var.sku}_${var.sku_count}"
}

resource "azurerm_api_management_api" "api" {
  name                = "${module.resource_name_prefix.resource_name}-api-mgmt-api"
  resource_group_name = azurerm_api_management.api.resource_group_name
  api_management_name = azurerm_api_management.api.name
  revision            = var.api_revision
  display_name        = "${module.resource_name_prefix.resource_name}-api"
  path                = var.api_path
  protocols           = var.api_protocols

  import {
    content_format = var.api_import_content_format
    content_value  = var.api_import_content_path
  }
}

resource "azurerm_application_insights" "app_insights" {
  name                = "${module.resource_name_prefix.resource_name}-app-insights"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = azurerm_api_management.api.resource_group_name
  application_type    = var.app_insights_type
}

resource "azurerm_api_management_logger" "logger" {
  name                = "${module.resource_name_prefix.resource_name}-logger"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_api_management.api.resource_group_name
  application_insights {
    instrumentation_key = azurerm_application_insights.app_insights.instrumentation_key
  }
}


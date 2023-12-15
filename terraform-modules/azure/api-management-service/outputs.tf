output "api_management_service_name" {
  value = azurerm_api_management.api.name
}

output "api_management_service_id" {
  value = azurerm_api_management.api.id
}

output "api_management_service_url" {
  value = azurerm_api_management.api.gateway_url
}

output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "api_management_service_location" {
  value = azurerm_api_management.api.location
}

output "publisher_email" {
  value = azurerm_api_management.api.publisher_email
}

output "publisher_name" {
  value = azurerm_api_management.api.publisher_name
}

output "sku_name" {
  value = azurerm_api_management.api.sku_name
}

output "application_insights_instrumentation_key" {
  value = azurerm_application_insights.app_insights.instrumentation_key
}

output "api_endpoint_url" {
  value = azurerm_api_management_api.api.service_url
}

output "logger_id" {
  value = azurerm_api_management_logger.logger.id
}

output "resource_group_id" {
  value = data.azurerm_resource_group.rg.id
}

output "api_management_gateway_regional_url" {
  value = azurerm_api_management.api.gateway_regional_url
}
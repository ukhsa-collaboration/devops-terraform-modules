output "web_app_id" {
  description = "The ID of the Azure Web App"
  value       = azurerm_windows_web_app.web_app.id
}

output "identity_id" {
  description = "The ID of the Azure Web App"
  value       = azurerm_windows_web_app.web_app.identity[0].principal_id
}

output "default_hostname" {
  description = "The ID of the Azure Web App"
  value       = azurerm_windows_web_app.web_app.default_hostname
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.subnet.resource_id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = module.subnet.name
}

output "private_endpoint_id" {
  description = "The ID of the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.id
}

output "private_endpoint_name" {
  description = "The name of the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.name
}

output "peering_id" {
  value       = azurerm_virtual_network_peering.vnet_peering.id
  description = "The ID of the VNet peering."
}

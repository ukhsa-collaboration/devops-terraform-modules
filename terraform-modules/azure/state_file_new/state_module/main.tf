data "azurerm_client_config" "az-client-config" {}

resource "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
  location = var.location
}

data "azurerm_virtual_network" "network" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name_vnet
}

resource "azurerm_network_security_group" "nsg" {
   name                = var.nsg_name
   location            = var.location
   resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "az-${var.project_name}-${var.location}-${var.environment}-state-st-pe-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.subnet.resource_id

  private_service_connection {
    name                           = "private-sc"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

module "subnet" {
  source = "../modules/subnet"
  virtual_network_id = data.azurerm_virtual_network.network.id
  name = var.subnet_name
  address_prefixes                = [var.address_prefix]
  default_outbound_access_enabled = true
  network_security_group_id       = azurerm_network_security_group.nsg.id

  depends_on = [
    data.azurerm_virtual_network.network,
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_storage_account" "storage_account" {
  name                          = local.st_name
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
  blob_properties {
    delete_retention_policy {
      days = 30
    }
  }

  network_rules {
    private_link_access {
      endpoint_resource_id = "/subscriptions/${data.azurerm_client_config.az-client-config.subscription_id}/providers/Microsoft.Security/datascanners/StorageDataScanner"
      endpoint_tenant_id   = data.azurerm_client_config.az-client-config.tenant_id
    }
    default_action = "Deny"
  }

  min_tls_version = "TLS1_2"
  
}

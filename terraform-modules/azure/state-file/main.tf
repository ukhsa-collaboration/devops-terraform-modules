resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
}

# Create storage account
resource "azurerm_storage_account" "this" {
  for_each            = var.storage_account
  name                = "${each.key}${var.environment}${random_string.resource_code.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_kind                      = each.value.account_kind
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  enable_https_traffic_only         = each.value.enable_https_traffic_only
  min_tls_version                   = each.value.min_tls_version
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled


  dynamic "blob_properties" {
    for_each = each.value.blob_properties[*]
    content {
      versioning_enabled            = each.value.blob_properties.versioning_enabled
      change_feed_enabled           = each.value.blob_properties.change_feed_enabled
      change_feed_retention_in_days = each.value.blob_properties.change_feed_retention_in_days
      last_access_time_enabled      = each.value.blob_properties.last_access_time_enabled

      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy[*]
        content {
          days = delete_retention_policy.value.days
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy[*]
        content {
          days = container_delete_retention_policy.value.days
        }
      }
    }
  }
}



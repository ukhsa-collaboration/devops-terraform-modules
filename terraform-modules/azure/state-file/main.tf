resource "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}"
  location = var.location
}

module "storage_account" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount.git?ref=e017ac14fec632b1ca48592396f0078aa4773630" # Version 0.2.0 released 28/06/2024

  name                = "${var.storage_account_name}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier = "Standard"
  shared_access_key_enabled = "true" # shared access keys should be enabled to true when Azure AD is resolve. https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount#:~:text=IMPORTANT%20We%20recommend%20using%20Azure%20AD%20authentication%20over%20Shared%20Key%20for%20provisioning%20Storage%20Containers%2C%20Blobs%2C%20and%20other%20items.
  default_to_oauth_authentication = "false"
  infrastructure_encryption_enabled = "true"
  public_network_access_enabled = "true"
  network_rules = {
    default_action = "Allow"
  }

  blob_properties = {
    delete_retention_policy = {
      days = 30
    }
    container_delete_retention_policy = {
      days = 40
    }
  }
  sas_policy = {
    expiration_period = "00.02:00:00"
  }

 containers = {
    application = {
      name                  = "application"
      container_access_type = "private"
    }
    core-services = {
      name                  = "core-services"
      container_access_type = "private"

    }
}
}

# resource "azurerm_storage_share" "this" {
#   name                 = "state-upload"
#   storage_account_name = module.storage_account.name
#   quota                = 1
   
#     acl {
#     id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

#     access_policy {
#       permissions = "rwdl"
#     }
#   }

#   depends_on = [module.storage_account]
# }

# resource "azurerm_storage_share_file" "this" {
#   name             = "terraform.tfstate"
#   storage_share_id = azurerm_storage_share.this.id
#   source           = "terraform.tfstate"
# }
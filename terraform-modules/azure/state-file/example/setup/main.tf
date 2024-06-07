module "state_test" {
  source = "../../"

  resource_group_name = "tfstate-test"
  environment         = "dev"


  storage_account = {
    "example" = {
      account_replication_type = "GRS"
      shared_access_key_enabled = "true"
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
  } } }
  storage_container = {
    "core-services" = {
      storage_account_name = "example"
    }
    "application" = {
      storage_account_name = "example"
    }
  }
#   role_definition = {
#     "storageaccess" = {
#         storage_account_name = "coreservices"
#         actions = ["Microsoft.Storage/storageAccounts/blobServices/containers/read",
#                     "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"]
#         data_actions = [ "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
#       "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
#       "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"]
#     }
#   }
}
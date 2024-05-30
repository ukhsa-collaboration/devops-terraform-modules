module "state_test" {
  source = "../"

  resource_group_name = "tfstate-test"
  environment         = "dev"

  storage_account = {
    "stateaccount1" = {
      storage_account_name     = "tfstate"
      account_replication_type = "GRS"
      blob_properties          = {}
    }

  }
}
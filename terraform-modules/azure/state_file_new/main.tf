module "storage_account" {
  source                   = "./state_module"
  resource_group_name      = "rg-state-example-tst-uksouth-01"
  location                 = "uksouth"
  vnet_name                = "vnet-example-test-uksouth-01"
  resource_group_name_vnet = "rg-vnet-example-test-uksouth-01"
  nsg_name                 = "az-example-uks-tst-state-01"
  subnet_name              = "az-example-uksouth-state-snet-01"
  address_prefix           = "10.0.0.0/29"
  environment              = "tst"
  project_name             = "example"
}
resource "random_pet" "rg_name" {
  prefix = "dev-test"
}

resource "azurerm_resource_group" "rg" {
  location = "UK south"
  name     = random_pet.rg_name.id
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-test-dev"
    storage_account_name = "exampledevntjzw" #set to your storage account name (due to random string wil be different)
    container_name       = "application"
    key                  = "application-example-terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.78"  # Adjust this to the version you want to use
    }
  }

  required_version = ">=1.2.0"

}

provider "azurerm" {
  features {}
}


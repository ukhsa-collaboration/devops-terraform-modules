#########################
#     Requirements      #
#########################
terraform {
  required_version = ">= 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.91, < 4.0"
    }
  }
}
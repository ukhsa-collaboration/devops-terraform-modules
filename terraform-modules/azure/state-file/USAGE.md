How to use state file module.

Step 1
Login to Azure

Step 2
Set up state file module in terraform
Please follow the following naming conventions setout here: https://confluence.collab.test-and-trace.nhs.uk/display/DOE/Cloud+resource+naming+standards

module "state" {
source = "git@github.com:UKHSA-Internal/devops-terraform-modules//terraform-modules/azure/state-file"

location = "uksouth" #This is defaulted to UK south so is not required when setting up to consume module
resource_group_name = "example"  #The name of the resource group you want to create for the storage account to be put into
storage_account_name = "example123"  #Must be unique to Azure
}

Step 3 

Terraform apply/github actions.


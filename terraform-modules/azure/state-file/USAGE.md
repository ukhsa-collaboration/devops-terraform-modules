How to use state file module.

Step 1
Login to Azure

Step 2
Set up state file module in terraform
Please follow the [cloud resource naming convention standards](https://confluence.collab.test-and-trace.nhs.uk/display/DOST/Cloud+resource+naming+standards)

```
module "state" {
    source = "git@github.com:UKHSA-Internal/devops-terraform-modules//terraform-modules/azure/state-file"

    # The name of the resource group you want to create for the storage account to be put into.
    resource_group_name  = "${var.name_prefix}-${var.environment}-resources-state"
    
    storage_account_name = "${substr(replace(data.azurerm_subscription.current.subscription_id, "-", ""), 0, 12)}state"
}

# name_prefix = "az-myproject-uks"
variable "name_prefix" {
  type        = string
  description = "The prefix for the resources. (provider-project-region)"

  validation {
    condition     = can(regex("^az-[a-z0-9]{4,10}-[a-z0-9]{1,5}$", var.name_prefix))
    error_message = "The name prefix must match the pattern: az-[a-z0-9]{4,10}-[a-z0-9]{1,5}."
  }

}

# environment = "dev"
variable "environment" {
  type        = string
  description = "The deployment environment (dev, qat, pre, prd)"

  validation {
    condition     = can(regex("^(dev|tst|qat|pre|prd)$", var.environment))
    error_message = "The environment must be one of: dev, qat, pre, prd."
  }
}
```

Step 3 

`terraform apply`


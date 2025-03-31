<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |

## Providers

- azurerm
- azapi

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./state_module | n/a |


## Resources

- Private Storage Account
- Subnet
- Private Endpoint
- Virtual Network (Data resource)
- Network Security Group

## Inputs
All Required.

- resource_group_name
- location
- vnet_name
- resource_group_name_vnet
- nsg_name
- subnet_name
- address_prefix
- environment
- project_name

## Outputs

- Storage Account ID
- Storage Account Name
- Subnet ID
- Subnet Name
- Private Endpoint ID
- Private Endpoint Name

## Using the module
Save a copy of the folder locally or fetch the code from GitHub and follow the below instructions to generate the resources:
- Enter az login on the terminal
- After authenticating select the subscription to be deployed to
- Go to main.tf file and edit all the information as required. Note the VNET would already be established so check the Azure portal for the vnet name.
- Save and run terraform init in the terminal
- Run terraform Apply in the terminal
- Validate resources and enter 'yes' in the terminal when prompted
- Resources will be created, the local state file can then be deleted (along with the local folder copy if that was used) as this is a one time deploy.
<!-- END_TF_DOCS -->

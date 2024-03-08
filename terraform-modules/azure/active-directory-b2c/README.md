<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_aadb2c_directory.azure_b2c](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/aadb2c_directory) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_b2c_display_name"></a> [b2c\_display\_name](#input\_b2c\_display\_name) | Display name of the B2C tenant | `string` | n/a | yes |
| <a name="input_b2c_domain_name"></a> [b2c\_domain\_name](#input\_b2c\_domain\_name) | Domain name of the B2C tenant, including the .onmicrosoft.com suffix. | `string` | n/a | yes |
| <a name="input_b2c_sku"></a> [b2c\_sku](#input\_b2c\_sku) | Billing SKU for the B2C tenant. Must be one of: PremiumP1 or PremiumP2 | `string` | n/a | yes |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | Country code of the B2C tenant - Get country code here https://learn.microsoft.com/en-us/azure/active-directory-b2c/data-residency | `string` | n/a | yes |
| <a name="input_data_residency_location"></a> [data\_residency\_location](#input\_data\_residency\_location) | Location in which the B2C tenant is hosted and data resides. Possible values are Asia Pacific, Australia, Europe, Global and United States | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the AAD B2C Directory should exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to B2C instance | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_b2c_id"></a> [azure\_b2c\_id](#output\_azure\_b2c\_id) | The ID of the AAD B2C Directory. |
| <a name="output_azure_b2c_tenant_id"></a> [azure\_b2c\_tenant\_id](#output\_azure\_b2c\_tenant\_id) | The Tenant ID for the AAD B2C tenant. |
<!-- END_TF_DOCS -->
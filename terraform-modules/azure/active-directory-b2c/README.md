<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.91, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.91, < 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_name_prefix"></a> [resource\_name\_prefix](#module\_resource\_name\_prefix) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix | TF/helpers/resource-name-prefix/vALPHA_0.0.2 |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags | TF/helpers/tags/vALPHA_0.0.6 |

## Resources

| Name | Type |
|------|------|
| [azurerm_aadb2c_directory.azure_b2c](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/aadb2c_directory) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aadb2c_tags"></a> [aadb2c\_tags](#input\_aadb2c\_tags) | (Optional) Tags to be assigned to the Azure AD B2C tenant. | `map(string)` | `{}` | no |
| <a name="input_b2c_display_name"></a> [b2c\_display\_name](#input\_b2c\_display\_name) | (Required) Display name of the B2C tenant | `string` | n/a | yes |
| <a name="input_b2c_domain_name"></a> [b2c\_domain\_name](#input\_b2c\_domain\_name) | (Required) Domain name of the B2C tenant, including the .onmicrosoft.com suffix. | `string` | n/a | yes |
| <a name="input_b2c_sku"></a> [b2c\_sku](#input\_b2c\_sku) | (Required) Billing SKU for the B2C tenant. Must be one of: PremiumP1 or PremiumP2 | `string` | n/a | yes |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | (Required) Country code of the B2C tenant - Get country code here https://learn.microsoft.com/en-us/azure/active-directory-b2c/data-residency | `string` | n/a | yes |
| <a name="input_data_residency_location"></a> [data\_residency\_location](#input\_data\_residency\_location) | (Required) Location in which the B2C tenant is hosted and data resides. Possible values are Asia Pacific, Australia, Europe, Global and United States | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags to be assigned to the resources, must include project, client, owner and environment keys | <pre>object({<br>    project         = string<br>    client          = string<br>    owner           = string<br>    environment     = string<br>    additional_tags = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_b2c_id"></a> [azure\_b2c\_id](#output\_azure\_b2c\_id) | The ID of the AAD B2C Directory. |
| <a name="output_azure_b2c_tenant_id"></a> [azure\_b2c\_tenant\_id](#output\_azure\_b2c\_tenant\_id) | The Tenant ID for the AAD B2C tenant. |
<!-- END_TF_DOCS -->
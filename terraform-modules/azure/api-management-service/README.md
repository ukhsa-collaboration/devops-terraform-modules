<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_name_prefix"></a> [resource\_name\_prefix](#module\_resource\_name\_prefix) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix | TF/helpers/resource-name-prefix/vALPHA_0.0.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_logger.logger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_import_content_format"></a> [api\_import\_content\_format](#input\_api\_import\_content\_format) | The format of the imported API content (e.g., 'swagger-json'). | `string` | n/a | yes |
| <a name="input_api_import_content_path"></a> [api\_import\_content\_path](#input\_api\_import\_content\_path) | The value for the imported content (e.g., URL or inline JSON). | `string` | n/a | yes |
| <a name="input_api_path"></a> [api\_path](#input\_api\_path) | The URL path for accessing the API. | `string` | n/a | yes |
| <a name="input_api_protocols"></a> [api\_protocols](#input\_api\_protocols) | The array of protocols the API uses (e.g., ['https']). | `list(string)` | <pre>[<br>  "https"<br>]</pre> | no |
| <a name="input_api_revision"></a> [api\_revision](#input\_api\_revision) | The revision number of the API. | `string` | `"1"` | no |
| <a name="input_app_insights_type"></a> [app\_insights\_type](#input\_app\_insights\_type) | The type of Application Insights (e.g., 'web'). | `string` | `"web"` | no |
| <a name="input_name"></a> [name](#input\_name) | The base name of the resources | `string` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email address of the owner of the service | `string` | `"test@contoso.com"` | no |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the owner of the service | `string` | `"publisher"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of this API Management service | `string` | `"Developer"` | no |
| <a name="input_sku_count"></a> [sku\_count](#input\_sku\_count) | The instance size of this API Management service. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoint_url"></a> [api\_endpoint\_url](#output\_api\_endpoint\_url) | n/a |
| <a name="output_api_management_gateway_regional_url"></a> [api\_management\_gateway\_regional\_url](#output\_api\_management\_gateway\_regional\_url) | n/a |
| <a name="output_api_management_service_id"></a> [api\_management\_service\_id](#output\_api\_management\_service\_id) | n/a |
| <a name="output_api_management_service_location"></a> [api\_management\_service\_location](#output\_api\_management\_service\_location) | n/a |
| <a name="output_api_management_service_name"></a> [api\_management\_service\_name](#output\_api\_management\_service\_name) | n/a |
| <a name="output_api_management_service_url"></a> [api\_management\_service\_url](#output\_api\_management\_service\_url) | n/a |
| <a name="output_application_insights_instrumentation_key"></a> [application\_insights\_instrumentation\_key](#output\_application\_insights\_instrumentation\_key) | n/a |
| <a name="output_logger_id"></a> [logger\_id](#output\_logger\_id) | n/a |
| <a name="output_publisher_email"></a> [publisher\_email](#output\_publisher\_email) | n/a |
| <a name="output_publisher_name"></a> [publisher\_name](#output\_publisher\_name) | n/a |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | n/a |
<!-- END_TF_DOCS -->
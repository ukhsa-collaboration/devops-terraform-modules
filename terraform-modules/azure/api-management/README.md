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
| [azurerm_api_management.api_management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_diagnostic.api_diagnostic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_diagnostic) | resource |
| [azurerm_api_management_logger.logger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) | resource |
| [azurerm_application_insights.application_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apis"></a> [apis](#input\_apis) | n/a | <pre>map(object({<br>    api_name                  = string<br>    revision                  = string<br>    display_name              = string<br>    path                      = string<br>    protocols                 = list(string)<br>    content_format            = string<br>    content_value             = string<br>    identifier                = string<br>    sampling_percentage       = number<br>    always_log_errors         = bool<br>    log_client_ip             = bool<br>    verbosity                 = string<br>    http_correlation_protocol = string<br>    frontend_request = object({<br>      body_bytes     = number<br>      headers_to_log = list(string)<br>    })<br>    frontend_response = object({<br>      body_bytes     = number<br>      headers_to_log = list(string)<br>    })<br>    backend_request = object({<br>      body_bytes     = number<br>      headers_to_log = list(string)<br>    })<br>    backend_response = object({<br>      body_bytes     = number<br>      headers_to_log = list(string)<br>    })<br>  }))</pre> | n/a | yes |
| <a name="input_application_insights_type"></a> [application\_insights\_type](#input\_application\_insights\_type) | (Optional) Type of the Application Insights resource | `string` | `"other"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Is public access to the service allowed? Defaults to true. | `bool` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | (Required) Email of the publisher for the API Management service | `string` | n/a | yes |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | (Required) Name of the publisher for the API Management service | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which the resources will be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) sku\_name is a string consisting of two parts separated by an underscore(\_). The first part is the name, valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer\_1). | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The id of the subnet that will be used for the API Management. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags to be assigned to the resources, must include project, client, owner and environment keys | <pre>object({<br>    project         = string<br>    client          = string<br>    owner           = string<br>    environment     = string<br>    additional_tags = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_location"></a> [additional\_location](#output\_additional\_location) | Zero or more additional\_location blocks. |
| <a name="output_developer_portal_url"></a> [developer\_portal\_url](#output\_developer\_portal\_url) | The URL for the Developer Portal associated with this API Management service. |
| <a name="output_gateway_regional_url"></a> [gateway\_regional\_url](#output\_gateway\_regional\_url) | The Region URL for the Gateway of the API Management Service. |
| <a name="output_gateway_url"></a> [gateway\_url](#output\_gateway\_url) | The URL of the Gateway for the API Management Service. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the API Management Service. |
| <a name="output_management_api_url"></a> [management\_api\_url](#output\_management\_api\_url) | The URL for the Management API associated with this API Management service. |
| <a name="output_portal_url"></a> [portal\_url](#output\_portal\_url) | The URL for the Publisher Portal associated with this API Management service. |
| <a name="output_private_ip_addresses"></a> [private\_ip\_addresses](#output\_private\_ip\_addresses) | The Private IP addresses of the API Management Service. |
| <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses) | The Public IP addresses of the API Management Service. |
| <a name="output_scm_url"></a> [scm\_url](#output\_scm\_url) | The URL for the SCM (Source Code Management) Endpoint associated with this API Management service. |
<!-- END_TF_DOCS -->
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
| [azurerm_application_gateway.app_gw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | A list of backend address pools. | <pre>list(object({<br>    name = string<br>  }))</pre> | `[]` | no |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | A list of backend HTTP settings. | <pre>list(object({<br>    name                  = string<br>    cookie_based_affinity = string<br>    port                  = number<br>    protocol              = string<br>    request_timeout       = number<br>  }))</pre> | `[]` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | A list of frontend IP configurations. | <pre>list(object({<br>    name                 = string<br>    public_ip_address_id = optional(string)<br>    subnet_id            = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | A list of frontend ports. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | `[]` | no |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | A list of HTTP listeners. | <pre>list(object({<br>    name                           = string<br>    frontend_ip_configuration_name = string<br>    frontend_port_name             = string<br>    protocol                       = string<br>    ssl_certificate_name           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The base name of the resources | `string` | n/a | yes |
| <a name="input_request_routing_rules"></a> [request\_routing\_rules](#input\_request\_routing\_rules) | A list of request routing rules. | <pre>list(object({<br>    name                       = string<br>    rule_type                  = string<br>    http_listener_name         = string<br>    backend_address_pool_name  = string<br>    backend_http_settings_name = string<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_sku_capacity"></a> [sku\_capacity](#input\_sku\_capacity) | The capacity (instance count) of the SKU used for the application gateway. | `number` | `2` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU used for the application gateway. | `string` | `"Standard_v2"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The tier of the SKU used for the application gateway. | `string` | `"Standard_v2"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet in which to create the application gateway. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign | `map(string)` | n/a | yes |
| <a name="input_waf_configuration"></a> [waf\_configuration](#input\_waf\_configuration) | The Web Application Firewall configuration. | <pre>object({<br>    enabled          = bool<br>    firewall_mode    = string<br>    rule_set_type    = string<br>    rule_set_version = string<br>    rules = list(object({<br>      name = string<br>    }))<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "firewall_mode": "Detection",<br>  "rule_set_type": "OWASP",<br>  "rule_set_version": "3.0",<br>  "rules": []<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_gateway_backend_address_pools"></a> [application\_gateway\_backend\_address\_pools](#output\_application\_gateway\_backend\_address\_pools) | The backend address pools of the application gateway. |
| <a name="output_application_gateway_backend_http_settings"></a> [application\_gateway\_backend\_http\_settings](#output\_application\_gateway\_backend\_http\_settings) | The backend HTTP settings of the application gateway. |
| <a name="output_application_gateway_frontend_ip_configurations"></a> [application\_gateway\_frontend\_ip\_configurations](#output\_application\_gateway\_frontend\_ip\_configurations) | The frontend IP configurations of the application gateway. |
| <a name="output_application_gateway_frontend_ports"></a> [application\_gateway\_frontend\_ports](#output\_application\_gateway\_frontend\_ports) | The frontend ports of the application gateway. |
| <a name="output_application_gateway_http_listeners"></a> [application\_gateway\_http\_listeners](#output\_application\_gateway\_http\_listeners) | The HTTP listeners of the application gateway. |
| <a name="output_application_gateway_id"></a> [application\_gateway\_id](#output\_application\_gateway\_id) | The ID of the application gateway. |
| <a name="output_application_gateway_name"></a> [application\_gateway\_name](#output\_application\_gateway\_name) | The name of the application gateway. |
| <a name="output_application_gateway_request_routing_rules"></a> [application\_gateway\_request\_routing\_rules](#output\_application\_gateway\_request\_routing\_rules) | The request routing rules of the application gateway. |
| <a name="output_application_gateway_waf_configuration"></a> [application\_gateway\_waf\_configuration](#output\_application\_gateway\_waf\_configuration) | The Web Application Firewall configuration of the application gateway. |
<!-- END_TF_DOCS -->
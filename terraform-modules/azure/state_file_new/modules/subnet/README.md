<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.2 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 1.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~> 1.13 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azapi_resource.subnet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |
| [azapi_update_resource.allow_deletion_of_ip_prefix_from_subnet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azapi_update_resource.allow_multiple_address_prefixes_on_subnet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azapi_update_resource.enable_shared_vnet](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_role_assignment.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefix"></a> [address\_prefix](#input\_address\_prefix) | n/a | `string` | `null` | no |
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | n/a | `list(string)` | `null` | no |
| <a name="input_default_outbound_access_enabled"></a> [default\_outbound\_access\_enabled](#input\_default\_outbound\_access\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_delegation"></a> [delegation](#input\_delegation) | n/a | <pre>list(object({<br>    name = string<br>    service_delegation = object({<br>      name    = string<br>      actions = optional(list(string))<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_nat_gateway"></a> [nat\_gateway](#input\_nat\_gateway) | n/a | <pre>object({<br>    id = string<br>  })</pre> | `null` | no |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | n/a | `string` | `null` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | n/a | `string` | `"Enabled"` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | n/a | <pre>map(object({<br>    role_definition_id_or_name             = string<br>    principal_id                           = string<br>    description                            = optional(string, null)<br>    skip_service_principal_aad_check       = optional(bool, false)<br>    condition                              = optional(string, null)<br>    condition_version                      = optional(string, null)<br>    delegated_managed_identity_resource_id = optional(string, null)<br>    principal_type                         = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_route_table"></a> [route\_table](#input\_route\_table) | n/a | <pre>object({<br>    id = string<br>  })</pre> | `null` | no |
| <a name="input_service_endpoint_policies"></a> [service\_endpoint\_policies](#input\_service\_endpoint\_policies) | n/a | <pre>map(object({<br>    id = string<br>  }))</pre> | `null` | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | n/a | `set(string)` | `null` | no |
| <a name="input_sharing_scope"></a> [sharing\_scope](#input\_sharing\_scope) | n/a | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_gateway_ip_configuration_resource_id"></a> [application\_gateway\_ip\_configuration\_resource\_id](#output\_application\_gateway\_ip\_configuration\_resource\_id) | The application gateway ip configurations resource id. |
| <a name="output_name"></a> [name](#output\_name) | The resource name of the subnet. |
| <a name="output_resource"></a> [resource](#output\_resource) | All attributes of the subnet |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The resource ID of the subnet. |
<!-- END_TF_DOCS -->
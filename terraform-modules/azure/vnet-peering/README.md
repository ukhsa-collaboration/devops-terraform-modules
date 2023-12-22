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
| [azurerm_virtual_network_peering.vnet_peering](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_forwarded_traffic"></a> [allow\_forwarded\_traffic](#input\_allow\_forwarded\_traffic) | Whether forwarded traffic from VNets is allowed. | `bool` | `false` | no |
| <a name="input_allow_gateway_transit"></a> [allow\_gateway\_transit](#input\_allow\_gateway\_transit) | Whether gateway transit is allowed. | `bool` | `false` | no |
| <a name="input_allow_vnet_access"></a> [allow\_vnet\_access](#input\_allow\_vnet\_access) | Whether the VNets can access each other. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The base name of the resources | `string` | n/a | yes |
| <a name="input_peering_name"></a> [peering\_name](#input\_peering\_name) | Name of the VNet peering. | `string` | n/a | yes |
| <a name="input_remote_vnet_id"></a> [remote\_vnet\_id](#input\_remote\_vnet\_id) | Resource ID of the remote virtual network. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign | `map(string)` | n/a | yes |
| <a name="input_use_remote_gateways"></a> [use\_remote\_gateways](#input\_use\_remote\_gateways) | Whether to use remote gateways. | `bool` | `false` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peering_id"></a> [peering\_id](#output\_peering\_id) | The ID of the VNet peering. |
<!-- END_TF_DOCS -->
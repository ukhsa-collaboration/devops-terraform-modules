<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api"></a> [api](#module\_api) | ../../../terraform-modules/azure/api-management-service | n/a |
| <a name="module_apim_subnet"></a> [apim\_subnet](#module\_apim\_subnet) | ../../../terraform-modules/azure/subnet | n/a |
| <a name="module_app_gw_subnet"></a> [app\_gw\_subnet](#module\_app\_gw\_subnet) | ../../../terraform-modules/azure/subnet | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags | TF/helpers/tags/vALPHA_0.0.1 |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | ../../../terraform-modules/azure/virtual-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_import_content_format"></a> [api\_import\_content\_format](#input\_api\_import\_content\_format) | The format of the API content to be imported | `string` | n/a | yes |
| <a name="input_api_import_content_path"></a> [api\_import\_content\_path](#input\_api\_import\_content\_path) | The path to the API content to be imported | `string` | n/a | yes |
| <a name="input_client"></a> [client](#input\_client) | Client to which the resource is associated | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for this deployment (e.g., dev, prod) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resources | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the resource | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project name to which the resource is associated | `string` | n/a | yes |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email address of the owner of the service | `string` | `"test@contoso.com"` | no |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of the owner of the service | `string` | `"publisher"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group where resources will be created. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | The pricing tier of this API Management service | `string` | `"Developer"` | no |
| <a name="input_sku_count"></a> [sku\_count](#input\_sku\_count) | The instance size of this API Management service. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_management_service_name"></a> [api\_management\_service\_name](#output\_api\_management\_service\_name) | n/a |
<!-- END_TF_DOCS -->
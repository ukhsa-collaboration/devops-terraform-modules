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
| <a name="module_resource_name_prefix"></a> [resource\_name\_prefix](#module\_resource\_name\_prefix) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix | e33b08113eef62432e32fd837d0e75f871b38340 |
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/tags | e33b08113eef62432e32fd837d0e75f871b38340 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_connection.connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_connection) | resource |
| [azurerm_windows_web_app.web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_target_resource"></a> [connection\_target\_resource](#input\_connection\_target\_resource) | Enable Always On for the Azure Web App | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region in which all resources should be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure Resource Group | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | The ID of the Azure App Service Plan | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags to be assigned to the resources, must include project, client, owner and environment keys | <pre>object({<br>    project         = string<br>    client          = string<br>    owner           = string<br>    environment     = string<br>    additional_tags = optional(map(string))<br>  })</pre> | n/a | yes |
| <a name="input_webapp_config"></a> [webapp\_config](#input\_webapp\_config) | Configuration settings for the Azure Web App | <pre>object({<br>    web_app_name                  = string<br>    virtual_network_subnet_id     = string<br>    enable_client_affinity        = bool<br>    enable_https                  = bool<br>    always_on                     = bool<br>    restriction_action            = optional(string)<br>    restriction_name              = optional(string)<br>    restriction_priority          = optional(number)<br>    restriction_service_tag       = optional(string)<br>    auth_settings_enabled         = optional(bool)<br>    client_certificate_enabled    = optional(bool)<br>    public_network_access_enabled = optional(bool)<br>    ftps_state                    = optional(string)<br>    http_logs                     = optional(bool)<br>    detailed_error_messages       = optional(bool)<br>    failed_request_tracing        = optional(bool)<br>    retention_in_days             = optional(number)<br>    retention_in_mb               = optional(number)<br>    http2_enabled                 = optional(bool)<br>    health_check_path             = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_webapp_connection_config"></a> [webapp\_connection\_config](#input\_webapp\_connection\_config) | n/a | <pre>object({<br>    service_connection_name        = optional(string)<br>    connection_authentication_type = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The ID of the Azure Web App |
| <a name="output_identity_id"></a> [identity\_id](#output\_identity\_id) | The ID of the Azure Web App |
| <a name="output_web_app_id"></a> [web\_app\_id](#output\_web\_app\_id) | The ID of the Azure Web App |
<!-- END_TF_DOCS -->
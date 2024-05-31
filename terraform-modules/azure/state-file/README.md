<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [random_string.resource_code](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment you are created eg. dev | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region to create resources in. | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | `"tfstate"` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | Storage account configuration. | <pre>map(object({<br>    account_kind                      = optional(string)<br>    account_tier                      = optional(string, "Standard")<br>    account_replication_type          = string<br>    enable_https_traffic_only         = optional(string)<br>    min_tls_version                   = optional(string)<br>    shared_access_key_enabled         = optional(string, "false")<br>    default_to_oauth_authentication   = optional(string, "true")<br>    infrastructure_encryption_enabled = optional(string)<br><br>    blob_properties = optional(object({<br>      versioning_enabled            = optional(string, "true")<br>      change_feed_enabled           = optional(string, "true")<br>      change_feed_retention_in_days = optional(number, 90)<br>      last_access_time_enabled      = optional(string, true)<br><br>      delete_retention_policy = optional(object({<br>        days = optional(number)<br>      }))<br>      container_delete_retention_policy = optional(object({<br>        days = optional(number)<br>      }))<br>    }))<br>    sas_policy = optional(object({<br>      expiration_period = string<br>      expiration_action = optional(string, "Log")<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_storage_container"></a> [storage\_container](#input\_storage\_container) | Azure storage container configuration | <pre>map(object({<br>    container_access_type = optional(string, "private")<br>    storage_account_name  = string<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
# Azure WAF Terraform Module

This Terraform module provides functionalities to manage Azure Web Application Firewall (WAF) resources, along with associated configurations like Resource Groups and Logging.

**Note**: Adding DDOS protection to this module is out of scope. Azure's DDOS Protection Service only allows one DDOS policy per VPC.

## Prerequisites

- **Terraform Tags Module:** Before using the `WAF` module, you must integrate the [Terraform Tags Module](../helpers/tags) to ensure consistent tagging across Azure resources. Refer to its documentation to understand its setup and usage.

## Features

- Configurable Web Application Firewall with both predefined and custom rules.
- Logging configuration with Azure Log Analytics Workspace.

## Usage

```hcl
module "tags" {
  source = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
  additional_tags = {
    "Purpose" = "Proof of Concept"
  }
}

module "waf" {
  source = "../../../terraform-modules/azure/web-application-firewall"

  name = var.name
  resource_group = "rg-apimpoc"

  tags = module.tags.tags
}
```

## Inputs

| Name                    | Description                                                   | Type           | Default | Required |
|-------------------------|---------------------------------------------------------------|----------------|---------|----------|
| `name`                  | The base name of the resources                                | `string`       | n/a     | yes      |
| `resource_group`        | The name of the resource group where resources will be created| `string`       | n/a     | yes      |
| `managed_rules`         | A list of additional managed rules to apply                   | `list(object)` | `[]`    | no       |
| `custom_rules`          | A list of custom rules for the Web Application Firewall Policy| `list(object)` | `[]`    | no       |
| `tags`                  | Tags to assign                                                | `map(string)`  | n/a     | yes      |

## Outputs

| Name                            | Description                                        |
|---------------------------------|----------------------------------------------------|
| `waf_policy_id`                 | The ID of the Web Application Firewall Policy      |
| `waf_policy_name`               | The name of the Web Application Firewall Policy    |
| `log_analytics_workspace_id`    | The ID of the Log Analytics Workspace              |
| `log_analytics_workspace_name`  | The name of the Log Analytics Workspace            |


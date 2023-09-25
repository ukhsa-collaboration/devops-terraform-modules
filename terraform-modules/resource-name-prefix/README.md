# Resource Name Prefix Terraform Module

This Terraform module provides functionalities to manage the naming configuration of resources in AWS. It combines the given base name with the provided tags (specifically `Project` and `Environment`) to generate a consistent naming prefix.

## Features

- Automated resource naming prefix generation based on base name, project, and environment tags.
- Ensures consistent resource naming conventions across AWS resources.
- Provides output for the generated resource name prefix for easy referencing.

## Usage

```hcl
module "resource_name_prefix" {
  source  = <PLACEHOLDER_should_be_github.com/>
  name    = "MyResource"
  tags    = {
    "Project"     = "MyProject",
    "Environment" = "prod"
  }
}

# Referencing outputs from the module
output "resource_name_output" {
  value = module.resource_name_prefix.resource_name
}
```
## Inputs

| Name  | Description                           | Type        | Default | Required |
|-------|---------------------------------------|-------------|---------|----------|
| `name`| The base name of the resources        | `string`    | n/a     | yes      |
| `tags`| Tags to assign, must include `Project` and `Environment` keys | `map(string)` | n/a  | yes      |

## Outputs

| Name            | Description               |
|-----------------|---------------------------|
| `resource_name` | Generated resource name prefix |

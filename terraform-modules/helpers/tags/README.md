# Terraform Tags Module

This Terraform module provides a standardized set of tags that can be used across all cloud resources, ensuring consistent tagging.

They conform to the Cloud Center of Excellence (CCoE) [Cloud Tagging Strategy](https://ukhsa.atlassian.net/wiki/spaces/CCE/pages/203496041/Cloud+Tagging+Strategy+WIP+-+Private).

## Features

- Provides a standardised set of mandatory tags, including `Owner`, `BillingOwner`, `Service`, `Environment`, and `Confidentiality`.
- Supports optional tags such as `Directorate` and `Team`.
- Allows additional custom tags through the `additional_tags` variable.
- Ensures all tags conform to validation rules for consistency.

## Usage

```hcl
module "tags" {
  source = "./modules/tags"

  # Mandatory variables
  environment     = "Development"
  owner           = "user@example.com"
  billing_owner   = "billing@example.com"
  service         = "testservice"
  confidentiality = "OFFICIAL"

  # Optional variables
  directorate     = "Data and Digital"
  team            = "DevOps"

  # Additional tags
  additional_tags = {
    "Project"    = "TestProject"
    "CostCenter" = "CC12345"
  }
}

# Example usage of tags module with an AWS resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = module.tags.all
}
```

If you wish to append your own specific tags to a resource use the following as an example:
```
# Example usage of all tags with its own on an AWS resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = merge(
    {
      "ExampleOne" = "example",
      "ExampleTwo" = true
    },
    module.success_tags.all
  )
}
```

## Constraints

- The `environment` variable can only accept the values `Development`, `Test`, `Pre-Production`, or `Production`.
- The `confidentiality` variable can only accept the values `OFFICIAL` or `OFFICIAL-SENSITIVE`.
- All string variables must conform to the regex pattern `^[-a-zA-Z0-9_ @.]+$` where applicable.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | (Optional) Any additional tags you want to add to AWS resources | `map(string)` | `{}` | no |
| <a name="input_billing_owner"></a> [billing\_owner](#input\_billing\_owner) | (Mandatory) The owner of billing for the workload or application | `string` | n/a | yes |
| <a name="input_confidentiality"></a> [confidentiality](#input\_confidentiality) | (Mandatory) The confidentiality level of the data being processed (OFFICIAL or OFFICIAL-SENSITIVE) | `string` | n/a | yes |
| <a name="input_directorate"></a> [directorate](#input\_directorate) | (Optional) The directorate responsible for the workload or application | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Mandatory) The environment for this deployment (Development, Test, Pre-Production or Production) | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | (Mandatory) The owner of the workload or application | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | (Mandatory) Project name to which the resource is associated | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | (Optional) The team responsible for the workload or application | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all"></a> [all](#output\_all) | A map of all tags to be applied to the resource |
| <a name="output_mandatory"></a> [mandatory](#output\_mandatory) | A map of mandatory tags to be applied to the resource |
<!-- END_TF_DOCS -->
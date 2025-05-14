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

## Inputs

| Name              | Description                                                                 | Type           | Default | Required |
| ----------------- | --------------------------------------------------------------------------- | -------------- | ------- | -------- |
| `owner`           | The owner of the workload or application                                    | `string`       | n/a     | yes      |
| `billing_owner`   | The owner of billing for the workload or application                        | `string`       | n/a     | yes      |
| `service`         | Project name to which the resource is associated                           | `string`       | n/a     | yes      |
| `environment`     | The environment for this deployment (Development, Test, Pre-Production, Production) | `string`       | n/a     | yes      |
| `confidentiality` | The confidentiality level of the data being processed (OFFICIAL, OFFICIAL-SENSITIVE) | `string`       | n/a     | yes      |
| `directorate`     | (Optional) The directorate responsible for the workload or application      | `string`       | `""`    | no       |
| `team`            | (Optional) The team responsible for the workload or application            | `string`       | `""`    | no       |
| `additional_tags` | (Optional) Any additional tags you want to add to AWS resources                       | `map(string)`  | `{}`    | no       |

## Outputs

| Name         | Description                                      |
| ------------ | ------------------------------------------------ |
| `all`        | A map of all tags to be applied to the resource including mandatory, optional and additional tags  |
| `mandatory`  | A map of only mandatory tags to be applied to the resource |

## Constraints

- The `environment` variable can only accept the values `Development`, `Test`, `Pre-Production`, or `Production`.
- The `confidentiality` variable can only accept the values `OFFICIAL` or `OFFICIAL-SENSITIVE`.
- All string variables must conform to the regex pattern `^[-a-zA-Z0-9_ @.]+$` where applicable.

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

# Example usage of tags module and tags with an AWS resource
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
<!-- END_TF_DOCS -->

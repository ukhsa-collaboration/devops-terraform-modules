# AWS Config Terraform Module

This module sets up AWS Config in a given account, enabling recording of supported resource types and delivering configuration snapshots to an S3 bucket.

---

## Features
- Creates AWS Config service-linked role
- Creates IAM role and attaches AWS-managed policies (unless a custom one is provided)
- Enables the configuration recorder
- Delivers snapshots to an existing S3 bucket
- Outputs the recorder name and IAM role ARN

---

## Usage

```hcl
module "aws_config" {
  source = "./modules/aws_config" # or GitHub/registry source

  audit_bucket_name               = "my-config-audit-bucket"
  all_supported                   = true
  include_global_resource_types   = true
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_config_configuration_recorder.config_recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder) | resource |
| [aws_config_configuration_recorder_status.config_recorder_status](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder_status) | resource |
| [aws_config_delivery_channel.audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_delivery_channel) | resource |
| [aws_iam_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.config_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_service_linked_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_iam_policy_document.config_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_supported"></a> [all\_supported](#input\_all\_supported) | Whether to record all supported AWS resource types. | `bool` | `true` | no |
| <a name="input_audit_bucket_name"></a> [audit\_bucket\_name](#input\_audit\_bucket\_name) | Name of the S3 bucket where AWS Config will deliver configuration snapshots. Must exist with correct policy. | `string` | n/a | yes |
| <a name="input_custom_config_role_arn"></a> [custom\_config\_role\_arn](#input\_custom\_config\_role\_arn) | Optional: ARN of a pre-created IAM role for AWS Config to use. If not set, this module will create one. | `string` | `null` | no |
| <a name="input_include_global_resource_types"></a> [include\_global\_resource\_types](#input\_include\_global\_resource\_types) | Whether to include global resource types (like IAM). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_role_arn"></a> [config\_role\_arn](#output\_config\_role\_arn) | ARN of the IAM role used by AWS Config. |
| <a name="output_recorder_name"></a> [recorder\_name](#output\_recorder\_name) | Name of the AWS Config recorder. |
<!-- END_TF_DOCS -->

---

## Notes
- This module assumes the S3 bucket already exists and is properly permissioned for AWS Config.
- See [AWS Config permissions requirements](https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html) for required bucket policy.

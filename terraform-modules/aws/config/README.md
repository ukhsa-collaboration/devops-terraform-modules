<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

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
| <a name="input_audit_bucket_name"></a> [audit\_bucket\_name](#input\_audit\_bucket\_name) | Name of the S3 bucket where AWS Config will deliver configuration snapshots. Must exist with correct policy. | `string` | n/a | yes |
| <a name="input_custom_config_role_arn"></a> [custom\_config\_role\_arn](#input\_custom\_config\_role\_arn) | Optional: ARN of a pre-created IAM role for AWS Config to use. If not set, this module will create one. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config_role_arn"></a> [config\_role\_arn](#output\_config\_role\_arn) | ARN of the IAM role used by AWS Config. |
| <a name="output_recorder_name"></a> [recorder\_name](#output\_recorder\_name) | Name of the AWS Config recorder. |
<!-- END_TF_DOCS -->
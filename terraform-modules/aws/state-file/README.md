<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform_state"></a> [terraform\_state](#module\_terraform\_state) | terraform-aws-modules/s3-bucket/aws | v4.1.2 |
| <a name="module_terraform_state_log"></a> [terraform\_state\_log](#module\_terraform\_state\_log) | terraform-aws-modules/s3-bucket/aws | v4.1.2 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_locks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.terraform_state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_dynamodb_table"></a> [create\_dynamodb\_table](#input\_create\_dynamodb\_table) | Whether to create the DynamoDB table used for Terraform state locking. | `bool` | `true` | no |
| <a name="input_iam_principals"></a> [iam\_principals](#input\_iam\_principals) | A list of IAM user or role ARNs that will have access to the state S3 bucket | `list(string)` | n/a | yes |
| <a name="input_region_name"></a> [region\_name](#input\_region\_name) | Name of the region that the state file is responsible for | `string` | n/a | yes |
| <a name="input_state_bucket_kms_key_id"></a> [state\_bucket\_kms\_key\_id](#input\_state\_bucket\_kms\_key\_id) | The KMS key ID used to encrypt the S3 state bucket. Uses AWS-managed key if not specified. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | The ARN of the DynamoDB table (null when create\_dynamodb\_table is false) |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | The name of the DynamoDB table (null when create\_dynamodb\_table is false) |
| <a name="output_s3_logging_bucket_arn"></a> [s3\_logging\_bucket\_arn](#output\_s3\_logging\_bucket\_arn) | The ARN of the S3 logging bucket |
| <a name="output_s3_state_bucket_arn"></a> [s3\_state\_bucket\_arn](#output\_s3\_state\_bucket\_arn) | The ARN of the S3 state bucket |
| <a name="output_s3_state_bucket_id"></a> [s3\_state\_bucket\_id](#output\_s3\_state\_bucket\_id) | The ID of the S3 state bucket |
<!-- END_TF_DOCS -->
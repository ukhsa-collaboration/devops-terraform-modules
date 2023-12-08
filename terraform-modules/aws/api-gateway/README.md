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
| <a name="module_lambda_custom_auth"></a> [lambda\_custom\_auth](#module\_lambda\_custom\_auth) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/aws/lambda | TF/aws/lambda/vALPHA_0.0.3 |
| <a name="module_resource_name_prefix"></a> [resource\_name\_prefix](#module\_resource\_name\_prefix) | git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/helpers/resource-name-prefix | TF/helpers/resource-name-prefix/vALPHA_0.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.api_gateway_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_api_key.api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_authorizer.lambda_authorizer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_authorizer) | resource |
| [aws_api_gateway_deployment.deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.api_method](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_model.request_model](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_model) | resource |
| [aws_api_gateway_request_validator.request_validator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_request_validator) | resource |
| [aws_api_gateway_resource.api_resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.api_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_rest_api_policy.api_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api_policy) | resource |
| [aws_api_gateway_stage.stage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.usage_plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.usage_plan_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_api_gateway_vpc_link.vpc_link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_vpc_link) | resource |
| [aws_cloudwatch_log_group.api_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.api_cloudwatch_logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.api_gateway_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.api_invoke_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.api_gw_cloudwatch_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_permission.api_gw_lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | A map of allowed IP ranges for each stage. | `list(string)` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_create_private_endpoint"></a> [create\_private\_endpoint](#input\_create\_private\_endpoint) | Whether to create a private endpoint for the API Gateway | `bool` | `false` | no |
| <a name="input_create_vpc_link"></a> [create\_vpc\_link](#input\_create\_vpc\_link) | Whether to create a VPC Link for the API Gateway integration | `bool` | `false` | no |
| <a name="input_custom_auth_lambda"></a> [custom\_auth\_lambda](#input\_custom\_auth\_lambda) | Configuration for the Lambda function | <pre>object({<br>    runtime         = string<br>    handler         = string<br>    filename        = string<br>    authTokenHeader = string<br>    aws_region      = string<br>  })</pre> | <pre>{<br>  "authTokenHeader": "",<br>  "aws_region": "",<br>  "filename": "",<br>  "handler": "",<br>  "runtime": ""<br>}</pre> | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | A map of endpoint configurations, each with a path and a list of methods | <pre>map(object({<br>    path          = string<br>    methods       = list(string)<br>    authorization = string<br>  }))</pre> | n/a | yes |
| <a name="input_integration_type"></a> [integration\_type](#input\_integration\_type) | The integration type of your resource. | `string` | n/a | yes |
| <a name="input_integration_uri"></a> [integration\_uri](#input\_integration\_uri) | The integration URI of your resource. | `string` | n/a | yes |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The number of days to retain log events in CloudWatch | `number` | n/a | yes |
| <a name="input_model_schema"></a> [model\_schema](#input\_model\_schema) | The model schema for request validation | <pre>object({<br>    name : string<br>    description : string<br>    content_type : string<br>    schema : string<br>  })</pre> | <pre>{<br>  "content_type": "application/json",<br>  "description": "Default Terraform Module Model Scheme",<br>  "name": "DefaultModel",<br>  "schema": "{\r\n  \"type\": \"object\",\r\n  \"properties\": {}\r\n}\r\n"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The base name of the resources | `string` | n/a | yes |
| <a name="input_quota_settings"></a> [quota\_settings](#input\_quota\_settings) | A map of quota settings for the API Usage Plan | <pre>object({<br>    limit  = number<br>    offset = number<br>    period = string<br>  })</pre> | <pre>{<br>  "limit": 5000,<br>  "offset": 0,<br>  "period": "MONTH"<br>}</pre> | no |
| <a name="input_stage_names"></a> [stage\_names](#input\_stage\_names) | The name of the stage for API Gateway deployment. Stages are limited to dev or prod but can be expanded in the future | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign | `map(string)` | n/a | yes |
| <a name="input_throttle_settings"></a> [throttle\_settings](#input\_throttle\_settings) | A map of throttle settings for the API Usage Plan | <pre>object({<br>    burst_limit = number<br>    rate_limit  = number<br>  })</pre> | <pre>{<br>  "burst_limit": 200,<br>  "rate_limit": 100<br>}</pre> | no |
| <a name="input_vpc_endpoint_ids"></a> [vpc\_endpoint\_ids](#input\_vpc\_endpoint\_ids) | List of VPC Endpoint IDs to associate with the API Gateway if a private endpoint is used | `list(string)` | `[]` | no |
| <a name="input_vpc_link_target_arns"></a> [vpc\_link\_target\_arns](#input\_vpc\_link\_target\_arns) | List of ARNs to be used by the VPC Link | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_role_arn"></a> [api\_gateway\_role\_arn](#output\_api\_gateway\_role\_arn) | The ARN of the API Gateway role |
| <a name="output_api_gateway_role_id"></a> [api\_gateway\_role\_id](#output\_api\_gateway\_role\_id) | The ID of the API Gateway role |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | The ID of the REST API Gateway |
| <a name="output_api_key_id"></a> [api\_key\_id](#output\_api\_key\_id) | The ID of the API key |
| <a name="output_api_key_value"></a> [api\_key\_value](#output\_api\_key\_value) | The value of the API key |
| <a name="output_api_stage_invoke_url"></a> [api\_stage\_invoke\_url](#output\_api\_stage\_invoke\_url) | The invoke URL of the deployed stage |
| <a name="output_api_stage_name"></a> [api\_stage\_name](#output\_api\_stage\_name) | The names of the deployed stages |
| <a name="output_api_url"></a> [api\_url](#output\_api\_url) | The URL of the REST API Gateway |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | The names of the CloudWatch Log Groups for each stage. |
| <a name="output_stage_arns"></a> [stage\_arns](#output\_stage\_arns) | The ARNs of the API Gateway stages. |
| <a name="output_usage_plan_id"></a> [usage\_plan\_id](#output\_usage\_plan\_id) | The ID of the API Gateway usage plan |
<!-- END_TF_DOCS -->
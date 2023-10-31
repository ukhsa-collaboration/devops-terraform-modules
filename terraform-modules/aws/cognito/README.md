# AWS Cognito Terraform Module

This Terraform module provides functionalities to manage AWS Cognito User Pools, User Pool Clients, User Pool Domains, and associated configurations.

## Prerequisites

- **Terraform Tags Module:** Before using the `ec2-autoscale` module, you must integrate the [Terraform Tags Module](../helpers/tags) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automated resource naming configuration based on provided variables.
- Configurable Cognito User Pool with custom schema, password policies, and account recovery settings.
- Configurable Cognito User Pool Client with token validity, callback URLs, and allowed OAuth scopes and flows.
- Configurable Cognito User Pool Domain.

## Usage

```hcl
module "tags" {
  source          = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/tags?ref=TF/helpers/tags/vALPHA_0.0.0"

  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

module "aws_cognito" {
  source                      = "git@github.com:UKHSA-Internal/devops-terraform-modules.git//terraform-modules/cognito?ref=cognito/vALPHA_0.0.0"

  name                        = var.name
  lambda_auth_challenge_arn   = var.lambda_auth_challenge_arn
  password_min_length         = var.password_min_length
  temp_password_validity_days = var.temp_password_validity_days
  token_validity              = var.token_validity
  callback_url                = var.callback_url
  schema                      = var.schema
  recovery_mechanism          = var.recovery_mechanism
  explicit_auth_flows         = var.explicit_auth_flows
  allowed_oauth_scopes        = var.allowed_oauth_scopes
  supported_identity_providers= var.supported_identity_providers
  allowed_oauth_flows         = var.allowed_oauth_flows
  domain                      = var.domain
  tags                        = var.tags
}

# Referencing outputs from the module
output "cognito_user_pool_id" {
  description = "The ID of the Cognito User Pool."
  value       = module.aws_cognito.cognito_user_pool_id
}
```

## Inputs

| Name                            | Description                                        | Type           | Default | Required |
|---------------------------------|----------------------------------------------------|----------------|---------|----------|
| `name`                          | The base name of the resources                     | `string`       | n/a     | yes      |
| `lambda_auth_challenge_arn`     | ARN for the Lambda function used for auth challenge | `string`       | n/a     | yes      |
| `password_min_length`           | Minimum password length for Cognito User Pool       | `number`       | `12`    | no       |
| `temp_password_validity_days`   | Validity of temporary passwords in days            | `number`       | `7`     | no       |
| `token_validity`                | Validity duration for tokens in hours              | `number`       | `1`     | no       |
| `callback_url`                  | Callback URL for the Cognito User Pool Client      | `string`       | n/a     | yes      |
| `schema`                        | Schema definition for the Cognito User Pool        | `list(object)` | n/a     | yes      |
| `recovery_mechanism`            | Account recovery settings for the Cognito User Pool| `list(object)` | n/a     | yes      |
| `explicit_auth_flows`           | Explicit authentication flows for the Cognito User Pool Client | `list(string)` | `["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]` | no |
| `allowed_oauth_scopes`          | Allowed OAuth scopes for the Cognito User Pool Client | `list(string)` | `["email", "openid"]` | no |
| `supported_identity_providers`  | Supported identity providers for the Cognito User Pool Client | `list(string)` | `["COGNITO"]` | no |
| `allowed_oauth_flows`           | Allowed OAuth flows for the Cognito User Pool Client | `list(string)` | `["code"]` | no |
| `domain`                        | The domain name                                   | `string`       | n/a     | yes      |
| `tags`                          | Tags to assign                                    | `map(string)`  | n/a     | yes      |

## Outputs

| Name                                  | Description                                   |
|---------------------------------------|-----------------------------------------------|
| `name`                                | Generated name from local configuration      |
| `cognito_user_pool_id`                | The ID of the Cognito User Pool              |
| `cognito_user_pool_arn`               | The ARN of the Cognito User Pool             |
| `cognito_user_pool_client_id`         | The client ID of the Cognito User Pool       |
| `cognito_user_pool_client_secret`     | The client secret of the Cognito User Pool Client |
| `cognito_user_pool_client_callback_urls` | The callback URLs of the Cognito User Pool Client |
| `cognito_domain`                      | The domain associated with the Cognito User Pool |

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [tls_certificate.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_refs"></a> [allowed\_refs](#input\_allowed\_refs) | The 'audience' that should be allowed to assume the role. Use '*' for all branches / enviroments. <br>      By default, only the 'main' branch can assume the role.<br><br>      For more examples on how to filter by branch, environment, tag or event type see:<br>      https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect#example-subject-claims | `string` | `"ref:refs/heads/main"` | no |
| <a name="input_iam_policy_arn"></a> [iam\_policy\_arn](#input\_iam\_policy\_arn) | The ARN of the IAM policy that the OIDC role should use. Will use a default policy if not specified. | `string` | `""` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | The full name of the Github Repo that should be allowed to assume the role. E.g. UKHSA-Internal/devops-terraform-example-project | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_iam_openid_connect_provider"></a> [aws\_iam\_openid\_connect\_provider](#output\_aws\_iam\_openid\_connect\_provider) | The ARN of the OpenID Connector Provider |
| <a name="output_aws_iam_role"></a> [aws\_iam\_role](#output\_aws\_iam\_role) | The ARN of the IAM role |
<!-- END_TF_DOCS -->
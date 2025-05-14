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
| <a name="output_all"></a> [all](#output\_all) | A map of all tags to be applied to the resource including mandatory tags |
| <a name="output_mandatory"></a> [mandatory](#output\_mandatory) | A map of only mandatory tags to be applied to the resource |
<!-- END_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

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
| <a name="input_lz_backup_plan"></a> [lz\_backup\_plan](#input\_lz\_backup\_plan) | (Mandatory) Describe the backup plan that should be associated with the resource. | `string` | n/a | yes |
| <a name="input_lz_billing_owner"></a> [lz\_billing\_owner](#input\_lz\_billing\_owner) | (Mandatory) To establish billing ownership across accounts/subscriptions to enable Showback/Chargeback strategy. | `string` | n/a | yes |
| <a name="input_lz_business_owner"></a> [lz\_business\_owner](#input\_lz\_business\_owner) | (Optional) Business person responsible for the workload. First point of contact for business related enquiries. Only required if different from TechOwner. | `string` | `""` | no |
| <a name="input_lz_cost_code"></a> [lz\_cost\_code](#input\_lz\_cost\_code) | (Mandatory) Finance for the given project/workload, validated during the keyholder process. Used to determine cost of cloud-based resources for a given workload or project. | `string` | n/a | yes |
| <a name="input_lz_data_classification"></a> [lz\_data\_classification](#input\_lz\_data\_classification) | (Optional) The classification or type of data that is being held. | `string` | `""` | no |
| <a name="input_lz_environment"></a> [lz\_environment](#input\_lz\_environment) | (Mandatory) The environment that the account services, e.g, Pre-Production, Production, Development. | `string` | n/a | yes |
| <a name="input_lz_git_commit_url"></a> [lz\_git\_commit\_url](#input\_lz\_git\_commit\_url) | (Optional) Resource level information to assist in tracking down issue root caused during incidents. | `string` | `""` | no |
| <a name="input_lz_government_security_classification"></a> [lz\_government\_security\_classification](#input\_lz\_government\_security\_classification) | (Mandatory) Classification according to the Government Security Classification Policy. | `string` | n/a | yes |
| <a name="input_lz_health_data"></a> [lz\_health\_data](#input\_lz\_health\_data) | (Optional) Whether the data held is related to health information. | `bool` | `null` | no |
| <a name="input_lz_lean_ix_id"></a> [lz\_lean\_ix\_id](#input\_lz\_lean\_ix\_id) | (Mandatory) Reference to record in LeanIX. | `number` | n/a | yes |
| <a name="input_lz_notification"></a> [lz\_notification](#input\_lz\_notification) | (Mandatory) Email address to send notifications to. | `string` | n/a | yes |
| <a name="input_lz_schedule"></a> [lz\_schedule](#input\_lz\_schedule) | (Optional) Define compute downtime schedule for cost savings on batch and non-prod workloads. | `string` | `""` | no |
| <a name="input_lz_service"></a> [lz\_service](#input\_lz\_service) | (Mandatory) Name of the service that is delivered via this account/subscription. | `string` | n/a | yes |
| <a name="input_lz_support_tier"></a> [lz\_support\_tier](#input\_lz\_support\_tier) | (Mandatory) Support wrapper - RTO and RPO. | `string` | n/a | yes |
| <a name="input_lz_team"></a> [lz\_team](#input\_lz\_team) | (Mandatory) To relate a workload back to a team in the absence of an existing person as an owner. | `string` | n/a | yes |
| <a name="input_lz_tech_owner"></a> [lz\_tech\_owner](#input\_lz\_tech\_owner) | (Mandatory) Technical person (or team) responsible for the workload. First point of contact for incidents and technical enquiries. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all"></a> [all](#output\_all) | A map of all tags to be applied to the resource including mandatory tags |
| <a name="output_mandatory"></a> [mandatory](#output\_mandatory) | A map of only mandatory tags to be applied to the resource |
<!-- END_TF_DOCS -->
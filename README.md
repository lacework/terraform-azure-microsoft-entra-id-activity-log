<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-azure-microsoft-entra-id-activity-log

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-azure-microsoft-entra-id-activity-log.svg)](https://github.com/lacework/terraform-azure-microsoft-entra-id-activity-log/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to configure a Lacework integration with Azure Event Hub for Entra ID audit log analysis. It configures a Diagnostic Setting that routes these logs to the event hub, from which Lacework reads them.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.31 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | ~> 1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_az_ad_application"></a> [az\_ad\_application](#module\_az\_ad\_application) | lacework/ad-application/azure | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventhub.lacework](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub) | resource |
| [azurerm_eventhub_namespace.lacework](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) | resource |
| [azurerm_eventhub_namespace_authorization_rule.lacework](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace_authorization_rule) | resource |
| [azurerm_monitor_aad_diagnostic_setting.entra_id_activity_logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_resource_group.lacework](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.lacework](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [lacework_integration_azure_ad_al.default](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/integration_azure_ad_al) | resource |
| [random_id.uniq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_sleep.wait_time](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The Active Directory Application id to use (required when use\_existing\_ad\_application is set to true) | `string` | `""` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | The name of the Azure Active Directory Application (required when use\_existing\_ad\_application is set to true) | `string` | `"lw_security_audit"` | no |
| <a name="input_application_password"></a> [application\_password](#input\_application\_password) | The Active Directory Application password to use (required when use\_existing\_ad\_application is set to true) | `string` | `""` | no |
| <a name="input_diagnostic_settings_name"></a> [diagnostic\_settings\_name](#input\_diagnostic\_settings\_name) | The name of the subscription's Diagnostic Setting for Activity Logs (required when use\_existing\_diagnostic\_settings is set to true) | `string` | `"active-directory-activity-logs"` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | The name of the Event Hub. | `string` | n/a | yes |
| <a name="input_lacework_integration_name"></a> [lacework\_integration\_name](#input\_lacework\_integration\_name) | The Lacework integration name | `string` | `"TF Entra ID activity log"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the Event Hub will reside. | `string` | `"West US 2"` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Specifies the number of days that logs will be retained. | `number` | `7` | no |
| <a name="input_num_partitions"></a> [num\_partitions](#input\_num\_partitions) | The number of partitions for the Event Hub. | `number` | `1` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use at the beginning of every generated resource | `string` | `"lacework"` | no |
| <a name="input_service_principal_id"></a> [service\_principal\_id](#input\_service\_principal\_id) | The Enterprise App Object ID related to the application\_id (required when use\_existing\_ad\_application is true) | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value map of Tag names and Tag values | `map(string)` | `{}` | no |
| <a name="input_use_existing_ad_application"></a> [use\_existing\_ad\_application](#input\_use\_existing\_ad\_application) | Set this to `true` to use an existing Active Directory Application | `bool` | `false` | no |
| <a name="input_wait_time"></a> [wait\_time](#input\_wait\_time) | Amount of time to wait before the Lacework resources are provisioned | `string` | `"50s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application\_id](#output\_application\_id) | The Lacework AD Application id |
| <a name="output_application_password"></a> [application\_password](#output\_application\_password) | The Lacework AD Application password |
| <a name="output_diagnostic_settings_name"></a> [diagnostic\_settings\_name](#output\_diagnostic\_settings\_name) | The name of the subscription's Diagnostic Setting for Activity Logs |
| <a name="output_eventhub_name"></a> [eventhub\_name](#output\_eventhub\_name) | The name of the Event Hub for Activity Logs |
| <a name="output_eventhub_namespace_name"></a> [eventhub\_namespace\_name](#output\_eventhub\_namespace\_name) | The name of the Event Hub Namespace for Activity Logs |
| <a name="output_integration_name"></a> [integration\_name](#output\_integration\_name) | The Lacework integration name |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | The location of the resource group of the Event Hub for Activity Logs |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group of the Event Hub for Activity Logs |
| <a name="output_service_principal_id"></a> [service\_principal\_id](#output\_service\_principal\_id) | The Lacework Service Principal id |
<!-- END_TF_DOCS -->
output "application_password" {
  value       = local.application_password
  description = "The Lacework AD Application password"
  sensitive   = true
}
output "application_id" {
  value       = local.application_id
  description = "The Lacework AD Application id"
}
output "diagnostic_settings_name" {
  value       = local.diagnostic_settings_name
  description = "The name of the subscription's Diagnostic Setting for Activity Logs"
}
output "service_principal_id" {
  value       = local.service_principal_id
  description = "The Lacework Service Principal id"
}
output "eventhub_namespace_name" {
  value       = local.eventhub_namespace_name
  description = "The name of the Event Hub Namespace for Activity Logs"
}
output "eventhub_name" {
  value       = local.eventhub_name
  description = "The name of the Event Hub for Activity Logs"
}
output "resource_group_name" {
  value       = local.resource_group_name
  description = "The resource group of the Event Hub for Activity Logs"
}
output "resource_group_location" {
  value       = local.resource_group_location
  description = "The location of the resource group of the Event Hub for Activity Logs"
}
output "integration_name" {
  value       = var.lacework_integration_name
  description = "The Lacework integration name"
}
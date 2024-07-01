variable "eventhub_name" {
  type        = string
  description = "The name of the Event Hub."
}
variable "num_partitions" {
  type        = number
  default     = 1
  description = "The number of partitions for the Event Hub."
}
variable "application_id" {
  type        = string
  default     = ""
  description = "The Active Directory Application id to use (required when use_existing_ad_application is set to true)"
}
variable "application_name" {
  type        = string
  default     = "lw_security_audit"
  description = "The name of the Azure Active Directory Application (required when use_existing_ad_application is set to true) "
}
variable "application_password" {
  type        = string
  default     = ""
  description = "The Active Directory Application password to use (required when use_existing_ad_application is set to true) "
}
variable "diagnostic_settings_name" {
  type        = string
  default     = "active-directory-activity-logs"
  description = "The name of the subscription's Diagnostic Setting for Activity Logs (required when use_existing_diagnostic_settings is set to true)"
}
variable "lacework_integration_name" {
  type        = string
  default     = "TF Entra ID activity log"
  description = "The Lacework integration name"
}
variable "location" {
  type        = string
  default     = "West US 2"
  description = "Azure region where the Event Hub will reside."
}
variable "log_retention_days" {
  type        = number
  description = "Specifies the number of days that logs will be retained."
  default     = 7
}
# NOTE: this prefix is used in all resources and we have a limitation with the
# storage name that can only consist of lowercase letters and numbers, and must
# be between 3 and 24 characters long
variable "prefix" {
  type        = string
  default     = "lacework"
  description = "The prefix to use at the beginning of every generated resource"
}
variable "service_principal_id" {
  type        = string
  default     = ""
  description = "The Enterprise App Object ID related to the application_id (required when use_existing_ad_application is true)"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key-value map of Tag names and Tag values"
}
variable "use_existing_ad_application" {
  type        = bool
  default     = false
  description = "Set this to `true` to use an existing Active Directory Application"
}
variable "wait_time" {
  type        = string
  default     = "50s"
  description = "Amount of time to wait before the Lacework resources are provisioned"
}
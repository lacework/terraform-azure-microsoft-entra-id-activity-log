locals {
  application_id           = var.use_existing_ad_application ? var.application_id : module.az_ad_application.application_id
  application_password     = var.use_existing_ad_application ? var.application_password : module.az_ad_application.application_password
  service_principal_id     = var.use_existing_ad_application ? var.service_principal_id : module.az_ad_application.service_principal_id
  eventhub_namespace_name  = substr("${var.prefix}-eventhub-ns-${random_id.uniq.hex}", 0, 24)
  eventhub_name            = substr("${var.prefix}-eventhub-${random_id.uniq.hex}", 0, 24)
  resource_group_name      = "${var.prefix}-group-${random_id.uniq.hex}"
  resource_group_location  = var.location
  diagnostic_settings_name = "${var.prefix}-${var.diagnostic_settings_name}-${random_id.uniq.hex}"
  version_file             = "${abspath(path.module)}/VERSION"
  module_name              = "terraform-azure-microsoft-entra-id-activity-log"
  module_version           = fileexists(local.version_file) ? file(local.version_file) : ""
}

module "az_ad_application" {
  source           = "lacework/ad-application/azure"
  version          = "~> 2.0"
  create           = var.use_existing_ad_application ? false : true
  application_name = var.application_name
}

resource "random_id" "uniq" {
  byte_length = 4
}

resource "azurerm_resource_group" "lacework" {
  name     = local.resource_group_name
  location = local.resource_group_location
  tags     = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_eventhub_namespace" "lacework" {
  name                = local.eventhub_namespace_name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  sku                 = "Standard"

  depends_on = [azurerm_resource_group.lacework]
}

resource "azurerm_eventhub" "lacework" {
  name                = local.eventhub_name
  namespace_name      = local.eventhub_namespace_name
  resource_group_name = local.resource_group_name
  partition_count     = var.num_partitions
  message_retention   = var.log_retention_days

  depends_on = [azurerm_eventhub_namespace.lacework]
}

resource "azurerm_role_assignment" "lacework" {
  scope                = azurerm_eventhub.lacework.id
  role_definition_name = "Azure Event Hubs Data Receiver"
  principal_id         = local.service_principal_id

  depends_on = [azurerm_eventhub_namespace.lacework]
}


resource "azurerm_eventhub_namespace_authorization_rule" "lacework" {
  name                = "${var.prefix}-rule-${random_id.uniq.hex}"
  namespace_name      = local.eventhub_namespace_name
  resource_group_name = local.resource_group_name
  listen              = true
  send                = true
  manage              = false

  depends_on = [azurerm_eventhub.lacework]
}

resource "azurerm_monitor_aad_diagnostic_setting" "entra_id_activity_logs" {
  name                           = local.diagnostic_settings_name
  eventhub_name                  = local.eventhub_name
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.lacework.id

  enabled_log {
    category = "AuditLogs"
    retention_policy {
    }
  }

  enabled_log {
    category = "SignInLogs"
    retention_policy {
    }
  }

  enabled_log {
    category = "NonInteractiveUserSignInLogs"
    retention_policy {
    }
  }

  enabled_log {
    category = "ServicePrincipalSignInLogs"
    retention_policy {
    }
  }

  depends_on = [azurerm_eventhub.lacework]
}

data "azurerm_client_config" "current" {}

# wait for X seconds for the Azure resources to be created
resource "time_sleep" "wait_time" {
  create_duration = var.wait_time
  depends_on = [
    azurerm_eventhub_namespace_authorization_rule.lacework,
    azurerm_eventhub_namespace.lacework,
    azurerm_eventhub.lacework,
    azurerm_monitor_aad_diagnostic_setting.entra_id_activity_logs,
  ]
  triggers = {
    # If App ID changes, trigger a wait between lacework_integration_azure_al destroys and re-creates, to avoid API errors
    app_id = local.application_id
    # If the Integration object changes (like during upgrade to v1.0), trigger a wait between lacework_integration_azure_al destroys and re-creates, to avoid API errors
    integration_name = var.lacework_integration_name
  }

}

resource "lacework_integration_azure_ad_al" "default" {
  name                = var.lacework_integration_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  event_hub_namespace = "${local.eventhub_namespace_name}.servicebus.windows.net"
  event_hub_name      = azurerm_eventhub.lacework.name
  credentials {
    client_id     = local.application_id
    client_secret = local.application_password
  }
  depends_on = [time_sleep.wait_time]
}
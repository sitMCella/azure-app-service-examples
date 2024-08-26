locals {
  subscription_id = "/subscriptions/${var.subscription_id}"
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting" {
  name                           = "diagnostic_settings_activity_logs"
  target_resource_id             = local.subscription_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = "${var.eventhub_namespace_id}/authorizationRules/RootManageSharedAccessKey"
  enabled_log {
    category       = null
    category_group = "allLogs"
  }
}

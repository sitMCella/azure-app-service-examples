output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = azurerm_resource_group.resource_group.name
}

output "log_analytics_workspace_id" {
  description = "The ID of the Azure Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

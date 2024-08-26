output "resource_group_name" {
  description = "The name of the Resource Group."
  value       = azurerm_resource_group.resource_group.name
}

output "eventhub_namespace_id" {
  description = "The ID of the Event Hub Namespace."
  value       = azurerm_eventhub_namespace.eventhub_namespace.id
}

output "eventhub_namespace_name" {
  description = "The name of the Event Hub Namespace."
  value       = azurerm_eventhub_namespace.eventhub_namespace.name
}

output "eventhub_namespace_default_primary_connection_string" {
  description = "The primany connection string of the Event Hub Namespace for the authorization rule RootManageSharedAccessKey."
  value       = azurerm_eventhub_namespace.eventhub_namespace.default_primary_connection_string
}

output "eventhub_name" {
  description = "The name of the Event Hub."
  value       = azurerm_eventhub.eventhub.name
}

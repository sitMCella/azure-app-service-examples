output "virtual_network_id" {
  description = "The ID of the Azure Virtual Network."
  value       = azurerm_virtual_network.virtual_network.id
}

output "app_service_subnet_id" {
  description = "The ID of the subnet for the Azure App Service."
  value       = azurerm_subnet.app_service_subnet.id
}

output "storage_subnet_id" {
  description = "The ID of the subnet for the Azure Storage."
  value       = azurerm_subnet.storage_subnet.id
}

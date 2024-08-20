output "file_storage_private_dns_zone_id" {
  description = "The ID of the Private DNS Zone for the Azure File Storage."
  value       = azurerm_private_dns_zone.file_storage_dns_zone.id
}

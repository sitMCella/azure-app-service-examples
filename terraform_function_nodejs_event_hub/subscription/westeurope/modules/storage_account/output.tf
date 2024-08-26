output "storage_account_id" {
  description = "The ID of the Azure Storage Account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account."
  value       = azurerm_storage_account.storage_account.name
}

output "access_key" {
  description = "The Access Key for the Storage Account."
  value       = azurerm_storage_account.storage_account.primary_access_key
}

output "primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = azurerm_storage_account.storage_account.primary_connection_string
}


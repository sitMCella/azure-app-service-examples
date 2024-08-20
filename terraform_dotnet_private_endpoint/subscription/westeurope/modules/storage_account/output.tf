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

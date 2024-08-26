resource "azurerm_resource_group" "resource_group" {
  name     = "rg-storage-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                          = "stblobprod${var.location_abbreviation}001"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  min_tls_version               = "TLS1_2"
  shared_access_key_enabled     = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

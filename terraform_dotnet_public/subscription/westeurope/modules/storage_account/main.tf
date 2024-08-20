resource "azurerm_resource_group" "resource_group" {
  name     = "rg-storage-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = ar.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                          = "stshareprod${var.location_abbreviation}001"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  account_kind                  = "FileStorage"
  account_tier                  = "Premium"
  account_replication_type      = "ZRS"
  min_tls_version               = "TLS1_2"
  shared_access_key_enabled     = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_share" "storage_container" {
  name                 = var.storage_share_name
  storage_account_name = azurerm_storage_account.storage_account.name
  enabled_protocol     = "SMB"
  quota                = 100
}

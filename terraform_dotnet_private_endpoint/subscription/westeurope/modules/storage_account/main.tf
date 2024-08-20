resource "azurerm_resource_group" "resource_group" {
  name     = "rg-storage-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
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
  public_network_access_enabled = true // Set to false in the final configuration

  // Initial configuration for the Terraform deployment from the local environment
  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.allowed_public_ip_addresses
  }

  tags = var.tags
}

resource "azurerm_storage_share" "storage_container" {
  name                 = var.storage_share_name
  storage_account_name = azurerm_storage_account.storage_account.name
  enabled_protocol     = "SMB"
  quota                = 100
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                          = "pe-storage-prod-${var.location_abbreviation}-001"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  subnet_id                     = var.subnet_id
  custom_network_interface_name = "nic-storage-prod-${var.location_abbreviation}-001"

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [var.file_storage_private_dns_zone_id]
  }

  private_service_connection {
    name                           = "pe-storage-prod-${var.location_abbreviation}-001"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = ["File"]
  }

  tags = var.tags
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-dns-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_private_dns_zone" "file_storage_dns_zone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "file_storage_dns_zone_virtual_network_link" {
  name                  = "link-dns-file-prod-${var.location_abbreviation}-001"
  resource_group_name   = azurerm_resource_group.resource_group.name
  private_dns_zone_name = azurerm_private_dns_zone.file_storage_dns_zone.name
  virtual_network_id    = var.virtual_network_id
}

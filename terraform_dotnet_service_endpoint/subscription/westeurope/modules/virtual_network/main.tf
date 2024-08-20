resource "azurerm_resource_group" "resource_group" {
  name     = "rg-network-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "vnet-network-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/22"]

  tags = var.tags
}

resource "azurerm_subnet" "app_service_subnet" {
  name                 = "snet-appservice-prod-${var.location_abbreviation}-001"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]

  delegation {
    name = "Microsoft.Web.serverFarms"

    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      name    = "Microsoft.Web/serverFarms"
    }
  }

  service_endpoints = ["Microsoft.Storage"]
}

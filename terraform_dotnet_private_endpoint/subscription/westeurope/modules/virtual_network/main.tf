resource "azurerm_resource_group" "resource_group" {
  name     = "rg-network-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "nsg-network-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "Allow443Inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "Allow445Inbound"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "10.0.1.0/24"
  }

  tags = var.tags
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
}

resource "azurerm_subnet_network_security_group_association" "app_service_subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.app_service_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

resource "azurerm_subnet" "storage_subnet" {
  name                 = "snet-storage-prod-${var.location_abbreviation}-001"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "storage_subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.storage_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}

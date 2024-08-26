resource "azurerm_resource_group" "resource_group" {
  name     = "rg-eventhub-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "evhns-eventhub-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

resource "azurerm_eventhub" "eventhub" {
  name                = "evheventhubprod${var.location_abbreviation}001"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = azurerm_resource_group.resource_group.name
  partition_count     = 2
  message_retention   = 1
}

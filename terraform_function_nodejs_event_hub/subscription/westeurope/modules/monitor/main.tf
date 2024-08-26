resource "azurerm_resource_group" "resource_group" {
  name     = "rg-monitor-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "log-monitor-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-appservice-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "app_service_plan" {
  name                   = "asp-appservice-prod-${var.location_abbreviation}-001"
  location               = azurerm_resource_group.resource_group.location
  resource_group_name    = azurerm_resource_group.resource_group.name
  os_type                = "Linux"
  sku_name               = "P1v3"
  zone_balancing_enabled = true
  worker_count           = 3

  tags = var.tags
}

resource "azurerm_application_insights" "application_insights" {
  name                = "appi-appservice-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = "web"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_linux_web_app" "app_service" {
  name                                           = "app-appservice-prod-${var.location_abbreviation}-001"
  location                                       = azurerm_resource_group.resource_group.location
  resource_group_name                            = azurerm_resource_group.resource_group.name
  service_plan_id                                = azurerm_service_plan.app_service_plan.id
  public_network_access_enabled                  = true
  ftp_publish_basic_authentication_enabled       = true
  webdeploy_publish_basic_authentication_enabled = true
  virtual_network_subnet_id                      = var.subnet_id

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
    always_on           = true
    minimum_tls_version = "1.2"
    worker_count        = 3
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"                  = azurerm_application_insights.application_insights.instrumentation_key
    "APPINSIGHTS_PROFILERFEATURE_VERSION"             = "1.0.0"
    "APPINSIGHTS_SNAPSHOTFEATURE_VERSION"             = "1.0.0"
    "APPLICATIONINSIGHTS_CONNECTION_STRING"           = azurerm_application_insights.application_insights.connection_string
    "APPLICATIONINSIGHTS_ENABLESQLQUERYCOLLECTION"    = "disabled"
    "ApplicationInsightsAgent_EXTENSION_VERSION"      = "~2"
    "DISABLE_APPINSIGHTS_SDK"                         = "disabled"
    "DiagnosticServices_EXTENSION_VERSION"            = "~3"
    "IGNORE_APPINSIGHTS_SDK"                          = "disabled"
    "InstrumentationEngine_EXTENSION_VERSION"         = "disabled"
    "SnapshotDebugger_EXTENSION_VERSION"              = "disabled"
    "XDT_MicrosoftApplicationInsights_BaseExtensions" = "disabled"
    "XDT_MicrosoftApplicationInsights_Mode"           = "recommended"
    "XDT_MicrosoftApplicationInsights_PreemptSdk"     = "disabled"
  }

  sticky_settings {
    app_setting_names = [
      "APPINSIGHTS_INSTRUMENTATIONKEY",
      "APPLICATIONINSIGHTS_CONNECTION_STRING ",
      "APPINSIGHTS_PROFILERFEATURE_VERSION",
      "APPINSIGHTS_SNAPSHOTFEATURE_VERSION",
      "ApplicationInsightsAgent_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_BaseExtensions",
      "DiagnosticServices_EXTENSION_VERSION",
      "InstrumentationEngine_EXTENSION_VERSION",
      "SnapshotDebugger_EXTENSION_VERSION",
      "XDT_MicrosoftApplicationInsights_Mode",
      "XDT_MicrosoftApplicationInsights_PreemptSdk",
      "APPLICATIONINSIGHTS_CONFIGURATION_CONTENT",
      "XDT_MicrosoftApplicationInsightsJava",
      "XDT_MicrosoftApplicationInsights_NodeJS",
    ]
  }

  zip_deploy_file = var.zip_deploy_file

  identity {
    type = "SystemAssigned"
  }

  storage_account {
    name         = "share"
    type         = "AzureFiles"
    account_name = var.storage_account_name
    share_name   = var.storage_share_name
    access_key   = var.storage_access_key
    mount_path   = var.storage_share_mount_path
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.storage_account_id
  role_definition_name = "Storage File Data SMB Share Contributor"
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id
}

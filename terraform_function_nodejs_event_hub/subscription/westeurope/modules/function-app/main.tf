resource "azurerm_resource_group" "resource_group" {
  name     = "rg-appservice-prod-${var.location_abbreviation}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "asp-appservice-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = var.tags
}

resource "azurerm_application_insights" "application_insights" {
  name                = "appi-appservice-prod-${var.location_abbreviation}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = "other"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_storage_account" "storage_account_function_app" {
  name                          = "stfuncprod${var.location_abbreviation}001"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "LRS"
  access_tier                   = "Hot"
  https_traffic_only_enabled    = true
  min_tls_version               = "TLS1_2"
  shared_access_key_enabled     = true
  public_network_access_enabled = true
  blob_properties {
    delete_retention_policy {
      days = 14
    }
    container_delete_retention_policy {
      days = 7
    }
  }
  tags = var.tags
}

resource "azurerm_user_assigned_identity" "function_app_user_assigned_identity" {
  name                = "id-function-app-prod-${var.location}-001"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = var.tags
}

resource "azurerm_role_assignment" "function_app_identity_role_assignment_001" {
  scope                = azurerm_storage_account.storage_account_function_app.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.function_app_user_assigned_identity.principal_id
}

data "archive_file" "function_package" {
  type        = "zip"
  source_dir  = "${path.cwd}/modules/function-app/function"
  output_path = "function.zip"
}

resource "azurerm_linux_function_app" "function_app" {
  name                       = "func-app-prod-${var.location}-001"
  location                   = azurerm_resource_group.resource_group.location
  resource_group_name        = azurerm_resource_group.resource_group.name
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account_function_app.name
  storage_account_access_key = azurerm_storage_account.storage_account_function_app.primary_access_key

  site_config {
    always_on = false
    application_stack {
      node_version = "20"
    }
    application_insights_connection_string = azurerm_application_insights.application_insights.connection_string
    application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key
  }

  app_settings = {
    "evhnseventhubprod${var.location_abbreviation}001_RootManageSharedAccessKey_EVENTHUB" = var.eventhub_namespace_default_primary_connection_string
    AzureWebJobsStorageoutput                                                             = var.storage_primary_connection_string
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.function_app_user_assigned_identity.id]
  }

  zip_deploy_file = data.archive_file.function_package.output_path

  tags = var.tags
}

locals {
  tags                   = {}
  storage_container_name = "container"
}

module "monitor" {
  source = "./modules/monitor"

  location              = var.location
  location_abbreviation = var.location_abbreviation
  tags                  = local.tags
}

module "storage_account" {
  source = "./modules/storage_account"

  location               = var.location
  location_abbreviation  = var.location_abbreviation
  storage_container_name = local.storage_container_name
  tags                   = local.tags
}

module "event_hub" {
  source = "./modules/event_hub"

  location              = var.location
  location_abbreviation = var.location_abbreviation
  tags                  = local.tags
}

module "activity_logs" {
  source = "./modules/activity_logs"

  location                   = var.location
  location_abbreviation      = var.location_abbreviation
  resource_group_name        = module.monitor.resource_group_name
  subscription_id            = var.subscription_id
  log_analytics_workspace_id = module.monitor.log_analytics_workspace_id
  eventhub_name              = module.event_hub.eventhub_name
  eventhub_namespace_id      = module.event_hub.eventhub_namespace_id
}

module "function-app" {
  source = "./modules/function-app"

  location                                             = var.location
  location_abbreviation                                = var.location_abbreviation
  storage_account_id                                   = module.storage_account.storage_account_id
  storage_account_name                                 = module.storage_account.storage_account_name
  storage_container_name                               = local.storage_container_name
  storage_access_key                                   = module.storage_account.access_key
  storage_primary_connection_string                    = module.storage_account.primary_connection_string
  log_analytics_workspace_id                           = module.monitor.log_analytics_workspace_id
  eventhub_namespace_default_primary_connection_string = module.event_hub.eventhub_namespace_default_primary_connection_string
  tags                                                 = local.tags
}

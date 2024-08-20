locals {
  tags               = {}
  storage_share_name = "share"
}

module "monitor" {
  source = "./modules/monitor"

  location              = var.location
  location_abbreviation = var.location_abbreviation
  tags                  = local.tags
}

module "storage_account" {
  source = "./modules/storage_account"

  location              = var.location
  location_abbreviation = var.location_abbreviation
  storage_share_name    = local.storage_share_name
  tags                  = local.tags
}

module "app_service" {
  source = "./modules/app_service"

  location                   = var.location
  location_abbreviation      = var.location_abbreviation
  storage_account_id         = module.storage_account.storage_account_id
  storage_account_name       = module.storage_account.storage_account_name
  storage_share_name         = local.storage_share_name
  storage_access_key         = module.storage_account.access_key
  zip_deploy_file            = var.zip_deploy_file
  log_analytics_workspace_id = module.monitor.log_analytics_workspace_id
  storage_share_mount_path   = var.storage_share_mount_path
  tags                       = local.tags
}

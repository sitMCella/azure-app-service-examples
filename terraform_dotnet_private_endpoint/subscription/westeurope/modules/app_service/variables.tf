variable "location" {
  description = "(Required) The Azure Region where the Azure resources should exist."
}

variable "location_abbreviation" {
  description = "(Required) The Azure Region Abbreviation."
}

variable "storage_account_id" {
  description = "(Required) The ID of the Storage Account."
}

variable "storage_account_name" {
  description = "(Required) The name of the Storage Account."
}

variable "storage_share_name" {
  description = "(Required) The name of the file share in the Storage Account."
}

variable "storage_access_key" {
  description = "(Required) The Access Key for the Storage Account."
}

variable "log_analytics_workspace_id" {
  description = "(Required) The ID of the Azure Log Analytics workspace."
}

variable "zip_deploy_file" {
  description = "(Required) The path of the ZIP package with the web application."
}

variable "storage_share_mount_path" {
  description = "(Required) The path of the File Share mount."
}

variable "subnet_id" {
  description = "(Required) The resource ID of the subnet where to create the VNet Integration."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

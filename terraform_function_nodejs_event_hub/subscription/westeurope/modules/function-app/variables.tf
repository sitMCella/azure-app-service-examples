variable "location" {
  description = "(Required) The Azure Region where the Azure resources should exist."
}

variable "location_abbreviation" {
  description = "(Required) The Azure Region abbreviation."
}

variable "storage_account_id" {
  description = "(Required) The ID of the Storage Account."
}

variable "storage_account_name" {
  description = "(Required) The name of the Storage Account."
}

variable "storage_container_name" {
  description = "(Required) The name of the container in the Storage Account."
}

variable "storage_access_key" {
  description = "(Required) The Access Key for the Storage Account."
}

variable "storage_primary_connection_string" {
  description = "(Required) The connection string associated with the primary location."
}

variable "log_analytics_workspace_id" {
  description = "(Required) The ID of the Azure Log Analytics workspace."
}

variable "eventhub_namespace_default_primary_connection_string" {
  description = "The primany connection string of the Event Hub Namespace for the authorization rule RootManageSharedAccessKey."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

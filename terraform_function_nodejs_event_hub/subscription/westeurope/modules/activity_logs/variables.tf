variable "location" {
  description = "(Required) The Azure Region where the Azure resources should exist."
}

variable "location_abbreviation" {
  description = "(Required) The Azure Region abbreviation."
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group."
}

variable "subscription_id" {
  description = "(Required) The ID of the Subscription."
}

variable "log_analytics_workspace_id" {
  description = "(Required) The ID of the Azure Log Analytics workspace."
}

variable "eventhub_name" {
  description = "(Required) The name of the Event Hub."
}

variable "eventhub_namespace_id" {
  description = "(Required) The ID of the Event Hub Namespace."
}

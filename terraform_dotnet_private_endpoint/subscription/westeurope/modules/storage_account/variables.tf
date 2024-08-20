variable "location" {
  description = "(Required) The Azure Region where the Azure resources should exist."
}

variable "location_abbreviation" {
  description = "(Required) The Azure Region abbreviation."
}

variable "subnet_id" {
  description = "(Required) The resource ID of the subnet where to create the Private Endpoint."
}

variable "allowed_public_ip_addresses" {
  description = "(Optional) The Public IP addresses that are allowed to access the Storage Account."
  type        = list(string)
  default     = null
}

variable "app_service_subnet_id" {
  description = "(Required) The ID of the subnet for the Azure App Service."
}

variable "storage_share_name" {
  description = "(Required) The name of the file share in the Storage Account."
}

variable "file_storage_private_dns_zone_id" {
  description = "The ID of the Private DNS Zone for the Azure File Storage."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

variable "location" {
  description = "(Required) The Azure Region where the Azure resources should exist."
}

variable "location_abbreviation" {
  description = "(Required) The Azure Region abbreviation."
}

variable "storage_container_name" {
  description = "(Required) The name of the container in the Storage Account."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

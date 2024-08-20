variable "tenant_id" {
  description = "(Required) The Entra ID tenant."
}

variable "client_id" {
  description = "(Required) The Client ID of the Service Principal Account (App Registration)."
}

variable "client_secret" {
  description = "(Required) The Client secret of the Service Principal Account (App Registration)."
}

variable "location" {
  description = "(Required) The location of the Azure resources."
}

variable "location_abbreviation" {
  description = "(Required) The abbreviation for the location of the Azure resources."
}

variable "zip_deploy_file" {
  description = "(Required) The path of the ZIP package with the web application."
}

variable "storage_share_mount_path" {
  description = "(Required) The path of the File Share mount."
}

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

variable "subscription_id" {
  description = "(Required) The ID of the Subscription."
}

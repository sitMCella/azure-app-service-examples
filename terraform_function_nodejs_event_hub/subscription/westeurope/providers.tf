provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = "<subscription_id>"
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_version = ">= 1.3.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.116.0"
    }
  }
}

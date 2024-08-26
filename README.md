# Azure App Service Examples

The following repository contains example Terraform projects with Azure App Service.

## terraform_dotnet_public

Terraform project that creates one Azure App Service connected to one Azure File Share.

The Storage Account and the Azure App Service are Public available.

The web application is deployed with Code publishing model (ZIP package).

## terraform_dotnet_service_endpoint

Terraform project that creates one Azure App Service connected to one Azure File Share.

The Firewall configuration in the Storage Account is configured to grant access just to the Azure 
App Service. The Azure App Service is Public available and configured with VNet integration.

The web application is deployed with Code publishing model (ZIP package).

## terraform_dotnet_private_endpoint

Terraform project that creates one Azure App Service connected to one Azure File Share.

The Storage Account is configured with one Private Endpoint. The Azure App Service is Public available 
and configured with VNet integration.

The web application is deployed with Code publishing model (ZIP package).

## terraform_function_nodejs_event_hub

Terraform project that creates one Azure Function App connected to one Azure Event Hub in inbound and one 
Azure Storage Account in outbound.

The Azure Function App is configured to use the Node JS runtime.

The Azure resources are Public available.

## terraform_function_powershell_event_hub

Terraform project that creates one Azure Function App connected to one Azure Event Hub in inbound and one 
Azure Storage Account in outbound.

The Azure Function App is configured to use the PowerShell Core runtime.

The Azure resources are Public available.

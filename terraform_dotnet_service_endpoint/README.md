# Terraform Project

This Terraform project creates one Azure App Service connected to one Azure File Share.

The Firewall configuration in the Storage Account is configured to grant access just to the Azure 
App Service. The Azure App Service is Public available and configured with VNet integration.

## Basics

### Terraform

Install the latest version of Terraform in the local environment:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Azure Terraform Library

Terraform communicates with Azure using the components defined in the Terraform library AzureRM:
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

## Web Application

Before proceeding with the creation of the Azure resources using Terraform, you must build and publish the ASP.NET web application locally.

### Compile Web Application

1. Install .NET 8 in the local environment.
2. Build and publish the web application located in the directory "Application", follow the instructions in the [README.md](https://github.com/sitMCella/azure-app-service-examples/blob/main/terraform_dotnet_service_endpoint/README.md) file.

### Create ZIP package

Open the directory "Application/out" generated during the publishing of the web application, and ZIP the content of the directory.

The web application is deployed to the Azure App Service using the ZIP package created from the published web application.
Refer to: https://learn.microsoft.com/en-us/azure/app-service/deploy-run-package

## Configuration

The Terraform project is located in the directory "subscription/westeurope" and must be associated to one Azure Subscription.

Specify the Subscription ID in the file `providers.tf`.

Create one file `secret/main.json` with the following content in the current directory:
```
{
  "tenant_id": "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "client_id": "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "client_secret": "xxxxxxxxxxxxxxxxx"
}
```
The `tenant_id` property corresponds to the Entra ID tenant.
Specify the value of the `client_id` and `client_secret` properties as described in the following section.

### Authentication

The Terraform project makes use of one Azure Service Principal account for authenticating to Azure.

 1. Create one Azure Service Principal Account (App Registration) in Azure.
 2. Generate the secret for the Azure Service Principal account in Azure.
 3. Add the `client_id` and `client_secret` values into the `secret/main.json` file.
 4. Assign the RBAC roles "Contributor", "User Access Administrator", and "Storage File Data SMB Share Elevated Contributor" on the Subscription level to the Service Principal account.

### Terraform Project Initialization

Initialize the Terraform project.
This procedure have to be done the first time the Terraform project is created.

Run the following commands:

```$bash
cd subscription/westeurope
terraform init -backend-config="../../secret/main.json" -reconfigure
```

## Development

### Configure parameters

Configure the following variables in the file `terraform.tfvars`:
- `zip_deploy_file`: The path of the ZIP file with the web application
- `storage_share_mount_path`: The mount path of the Azure File Share
- `allowed_public_ip_addresses`: The Public IP addresses that are allowed to access the Storage Account. Required for executing the Terraform project from the local environment.

### Verify the Updates in the Terraform Code

Run the following Terraform commands:

```$bash
cd subscription/westeurope
terraform plan -var-file="../../secret/main.json"
```

### Apply the Updates from the Terraform Code

Run the following Terraform commands:

```$bash
cd subscription/westeurope
terraform apply -var-file="../../secret/main.json" -auto-approve
```

### Format Terraform Code

```$bash
find . -not -path "*/.terraform/*" -type f -name '*.tf' -print | uniq | xargs -n1 terraform fmt
```

### Destroy the Azure environment

Run the following Terraform commands:

```$bash
cd subscription/westeurope
terraform apply -var-file="../../secret/main.json" -auto-approve -destroy
```

# Terraform Project

This Terraform project creates one Azure Function App with PowerShell runtime. The Azure Function App is 
connected to one Azure Event Hub in inbound and one Azure Storage Account in outbound.

The Azure Function App is configured to use the PowerShell Core runtime.

The functin in the Azure Function uses the PowerShell language.

## Basics

### Terraform

Install the latest version of Terraform in the local environment:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Azure Terraform Library

Terraform communicates with Azure using the components defined in the Terraform library AzureRM:
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

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
 4. Assign the RBAC roles "Contributor", and "User Access Administrator" on the Subscription level to the Service Principal account.

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
- `subscription_id`: The ID of the Azure Subscription.

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

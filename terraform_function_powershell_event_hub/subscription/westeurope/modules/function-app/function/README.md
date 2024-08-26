# Configure Azure resources

## Azure Function

Provision one Azure Function App with Consumption hosting plan.
Create one App Settings (Environment variables) with name "evhnseventhubprodweu001_RootManageSharedAccessKey_EVENTHUB" and 
with value the "Connection string–primary key" of the Shared access policy "RootManageSharedAccessKey" of the Event Hubs Namespace.

Create one App Settings (Environment variables) with name "AzureWebJobsStorageoutput" and with value the primary connection string of the 
Azure Storage Account.

# References

https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-event-hubs-trigger?tabs=python-v2%2Cisolated-process%2Cnodejs-v4%2Cfunctionsv2%2Cextensionv5&pivots=programming-language-powershell

https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-storage-blob-output?tabs=python-v2%2Cisolated-process%2Cnodejs-v4&pivots=programming-language-powershell

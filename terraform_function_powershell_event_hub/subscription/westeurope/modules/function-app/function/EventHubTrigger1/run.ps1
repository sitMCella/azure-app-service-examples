param($eventHubMessages, $TriggerMetadata)

Write-Host "PowerShell eventhub trigger function called for message array: $eventHubMessages"

$eventHubMessages | ForEach-Object { Write-Host "Event Hub Processed message: $_" }

Push-OutputBinding -Name blobName -Value "content"

Write-Host "Created one text file in the Storage Account container"

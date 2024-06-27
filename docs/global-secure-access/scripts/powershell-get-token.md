---
title: PowerShell sample - Get the Auth Token for registering your Microsoft Entra private network connector through Azure Marketplace. 
description: PowerShell example that gets the Auth Token for registering your Microsoft Entra private network connector through Azure Marketplace. 
author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: sample
ms.date: 06/27/2024
ms.author: kenwith
ms.reviewer: sumi
---

# Get the Auth Token for registering your Microsoft Entra private network connector through Azure Marketplace. 

The PowerShell script helps you get the Auth Token for registering your Microsoft Entra private network connector through Azure Marketplace. 

If you don't have an Azure subscription, create an Azure free account before you begin.

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

```powershell
# This sample script lets you obtain the Auth Token Microsoft that you can use for registering the Entra private network connector through Marketplace.
#
# Version 1.0
#
# This script requires PowerShell 5.1 (x64) or beyond and one of the following modules:
#
# MicrosoftEntraPrivateNetworkConnectorPSModule 
#
# The script will get the module as result of Entra Private Network Connector Installation and quiet Registration (/q flag). A quiet installation doesn't prompt you to accept the End-User License Agreement.
# This script will uninstall the Entra Private Network Connector once the required modules are downloaded. 
#
# Before you begin:
#    
# - Make sure you are running PowerShell as an Administrator
# - You are on Windows Machine which is not running the Entra Private Network Connector already. If you already have a connector installed, quite registration step below will fail. 
# - Make sure there in no C:\temp folder on the machine. If you have some files stored, please move those before running the script 


# Make sure ExecutionPolicy is set to Unrestricted
Set-ExecutionPolicy UnRestricted -Force

# The script will use a temp folder on C Drive. First it will remove the folder and create a new folder to ensure its empty.
Remove-Item -Path C:\temp -Recurse
New-Item -ItemType Directory c:\temp


# Copy Required Dlls 
Invoke-WebRequest https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/DownloadConnectorInstaller -OutFile c:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe

# Set the prompt path to C:\temp
cd "C:\temp"

# Quiet Registration of the Connector. This step will provide the required Module for aquiring the token. 
# At the end of this step, you should see 2 folders under C:\Program Files. 1) Microsoft Entra private network connector 2) Microsoft Entra private network connector updater
# These folders contains the required modules needed for getting the token. 
.\MicrosoftEntraPrivateNetworkConnectorInstaller.exe REGISTERCONNECTOR="false" /q

#Wait 60 seconds
Start-Sleep -Seconds 60

# Set the prompt path to C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule
cd "C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule"

# Import Module 
Write-Output "---------------------------------------"
Write-Output "Import Module Operation "
Write-Output "---------------------------------------"
Import-Module ..\MicrosoftEntraPrivateNetworkConnectorPSModule -ErrorAction Stop

# Load MSAL  
Add-Type -Path .\Microsoft.Identity.Client.dll

# The AAD authentication endpoint uri

$authority = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"

#The application ID of the connector in AAD. Use the Connector AppId below

$connectorAppId = "55747057-9b5d-4bd4-b387-abf52a8bd489"

#The AppIdUri of the registration service in AAD
$registrationServiceAppIdUri = "https://proxy.cloudwebappproxy.net/registerapp/user_impersonation"

# Define the resources and scopes you want to call

$scopes = New-Object System.Collections.ObjectModel.Collection["string"]

$scopes.Add($registrationServiceAppIdUri)

$app = [Microsoft.Identity.Client.PublicClientApplicationBuilder]::Create($connectorAppId).WithAuthority($authority).WithDefaultRedirectUri().Build()

[Microsoft.Identity.Client.IAccount] $account = $null

# Acquiring the token

$authResult = $null

$authResult = $app.AcquireTokenInteractive($scopes).WithAccount($account).ExecuteAsync().ConfigureAwait($false).GetAwaiter().GetResult()

# Check AuthN result
If (($authResult) -and ($authResult.AccessToken) -and ($authResult.TenantId)) {

$token = $authResult.AccessToken
   $tenantId = $authResult.TenantId

Write-Output "Success: Authentication result returned."
}
else {

Write-Output "Error: Authentication result, token or tenant id returned with null."

}

$accessToken = $token

Write-Output "---------------------------------------"
Write-Output "Access Token that you aquired is below. Please copy and save it"
Write-Output "---------------------------------------"
Write-Output "$accessToken "
Write-Output "---------------------------------------"

# Set the prompt path to C:\temp
cd "C:\"

# Uninstall the Connector from your machine.
# You can do so programatically (below) or manually by double clicking C:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe and choose Uninstall. 
# Note that if the Connector service is not uninstalled properly, next iteration can fail on this machine.  

$programName1 = "Microsoft Entra private network connector"
$programName2 = "Microsoft Entra private network connector updater"
$program1 = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name = '$programName1'"
#Wait 30 seconds
Start-Sleep -Seconds 30
$program2 = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name = '$programName2'"
#Wait 30 seconds
Start-Sleep -Seconds 30

if ($program1) {
    # Uninstall the program
	$program1.Uninstall() | Out-Null
    Write-Host "Successfully uninstalled $programName1."
} else {
    Write-Host "$programName1 not found."
}

if ($program2) {
    # Uninstall the program
	$program2.Uninstall() | Out-Null
    Write-Host "Successfully uninstalled $programName2."
} else {
    Write-Host "$programName2 not found."
}

# Delete the related files. Note that if you need to get the token again from 

Write-Host "Cleaning Up....."
Remove-Item C:\temp\*.*
Remove-Item -Path "C:\temp"
Remove-Item -Path "C:\Program Files\Microsoft Entra private network connector" -Recurse
Remove-Item -Path "C:\Program Files\Microsoft Entra private network connector updater" -Recurse
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)
- [Global Secure Access PowerShell examples](../powershell-samples.md)

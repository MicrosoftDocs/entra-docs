---
title: PowerShell sample - Get the Auth Token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces. 
description: PowerShell example that gets the Auth Token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces. 
author: kenwith
manager: femila
ms.service: global-secure-access
ms.topic: sample
ms.date: 02/21/2025
ms.author: kenwith
ms.reviewer: sumi
---

# Get the Auth Token for registering your Microsoft Entra private network connector through Azure, AWS or GCP Marketplaces

The PowerShell script helps you get the Auth Token for registering your Microsoft Entra private network connector through [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/microsoftcorporation1687208452115.entraprivatenetworkconnector?tab=overview) or [AWS Marketplace](https://aws.amazon.com/marketplace/pp/prodview-cgpbjiaphamuc) or [GCP Marketplace](https://console.cloud.google.com/marketplace/product/ciem-entra/entraprivatenetworkconnector?hl=en). 

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Important considerations
- Run the PowerShell script as an Administrator from an elevated PowerShell ISE.
- Don't run the script on a Windows computer where the private network connector is already installed. 
- Make sure there's no C:\temp folder on the machine. If you have some files stored in a C:\temp folder, move them before you run the script.
- After the script runs successfully, the Access Token is available at C:\token.txt.

## Sample script

```powershell
# This sample script lets you obtain the Auth Token that you can use for registering the Entra private network connector through Marketplace.
#
# Version 1.0
#
# This script requires following 
#    - PowerShell 5.1 (x64) or beyond
#    - Module: MicrosoftEntraPrivateNetworkConnectorPSModule 
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
$tempPath = "C:\temp"
# Check if the folder exists
if (Test-Path -Path $tempPath) {
Write-Host "Your C Drive has existing temp folder that is being deleted"
Remove-Item -Path C:\temp -Recurse
} 
# Creating C:\temp folder
New-Item -ItemType Directory c:\temp
New-Item -ItemType File -Path C:\token.txt -Force

# Copy Required Dlls 
Invoke-WebRequest https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/DownloadConnectorInstaller -OutFile c:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe

# Set the prompt path to C:\temp
cd "C:\temp"

# Quiet Registration of the Connector. This step will provide the required Module for acquiring the token. 
# At the end of this step, you should see 2 folders under C:\Program Files. 1) Microsoft Entra private network connector 2) Microsoft Entra private network connector updater
# These folders contains the required modules needed for getting the token. 
.\MicrosoftEntraPrivateNetworkConnectorInstaller.exe REGISTERCONNECTOR="false" /q

#Wait 60 seconds
Start-Sleep -Seconds 60

$folderPath = "C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule"

# Check if the Module exists
if (Test-Path -Path $folderPath) {
    Write-Host "The Module is successfully made available at path: $folderPath"
}
   
# Set the prompt path to C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule
cd "C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule"

# Import Module 
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
}
else {
Write-Output "Error: Authentication result, token or tenant id returned with null."
}

$accessToken = $token

Set-Content -Path C:\token.txt -Value "$accessToken"

# Set the prompt path to C:\

cd "C:\"

# Uninstall the Connector from your machine.
# You can do so programmatically (below) or manually by double clicking C:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe and choose Uninstall. 
# Note that if the Connector service is not uninstalled properly, next iteration can fail on this machine.  

C:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe /uninstall /quiet 

#Wait 60 seconds
Start-Sleep -Seconds 60

# Delete the related files. Note that if you need to get the token again from 

Remove-Item -Path "C:\temp" -Recurse
Remove-Item -Path "C:\Program Files\Microsoft Entra private network connector" -Recurse
Remove-Item -Path "C:\Program Files\Microsoft Entra private network connector updater" -Recurse

Write-Output "Access Token that you acquired is available in C:\token.txt. "
Write-Output "Please ensure no additional spaces are introduced when copying token to marketplace input form. Introducing spaces can change the token and can cause failures"

} else {
    Write-Host "The required module is not made available at path: $folderPath"
	Write-Host "This could be related to left over state from previous installation of connector on this machine."
	Write-Host "You can try to go to c:\temp\ and double click the MicrosoftEntraPrivateNetworkConnectorInstaller.exe file. Click Uninstall if visible. This can clean the state. "
    Write-Host "If you don't have .exe file, you can download it from https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/DownloadConnectorInstaller and double click it to Uninstall"
	Write-Host "Try Again after the state is clean"
    return
}
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)

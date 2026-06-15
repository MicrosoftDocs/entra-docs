---
title: PowerShell sample - Get the auth token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces
description: PowerShell example that gets the auth token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces.
ms.topic: sample
ms.date: 03/16/2026
ms.reviewer: katabish
---

# Get the auth token for registering your Microsoft Entra private network connector through Azure, AWS, or GCP Marketplaces

## Overview

The PowerShell script helps you get the auth token for registering your Microsoft Entra private network connector through [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/microsoftcorporation1687208452115.entraprivatenetworkconnector?tab=overview), [AWS Marketplace](https://aws.amazon.com/marketplace/pp/prodview-cgpbjiaphamuc), or [GCP Marketplace](https://console.cloud.google.com/marketplace/product/ciem-entra/entraprivatenetworkconnector?hl=en).

[!INCLUDE [quickstarts-free-trial-note](~/includes/azure-docs-pr/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/includes/azure-docs-pr/updated-for-az.md)]

The sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Important considerations
- Run the PowerShell script as an Administrator from an elevated PowerShell ISE.
- Don't run the script on a Windows computer where the private network connector is already installed. 
- Make sure there's no `C:\temp` folder on the machine. If you have some files stored in a `C:\temp` folder, move them before you run the script.
- After the script runs successfully, the access token is available at `C:\token.txt`.

## Sample script

```powershell
# This sample script lets you obtain the Auth Token that you can use for registering the Entra private network connector through Marketplace.
#
# Version 1.3
#
# CHANGELOG:
# Version 1.3 (2026-06-15) - Michael Morten Sonne, blog.sonnes.cloud, https://github.com/michaelmsonne
#   - Added comprehensive error handling with try-catch-finally blocks throughout the script
#   - Added #Requires statements for version validation and administrator rights enforcement
#   - Implemented transcript logging for full execution history and debugging
#   - Added color-coded console output (Green=Success, Yellow=Warning, Red=Error, Cyan=Info)
#   - Enhanced download validation with file size and existence checks
#   - Added exit code checking for installer/uninstaller processes
#   - Improved cleanup logic with array-based folder management
#   - Added automatic cleanup on script failure
#   - Enhanced user feedback with progress indicators and status messages
#   - Added validation for MSAL library existence before loading
#   - Implemented strict mode for better error detection
#   - Added error-specific cleanup in catch block to ensure clean state
#
# Version 1.2
#   - Original version
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
# - You are on Windows Machine which is not running the Entra Private Network Connector already. If you already have a connector installed, quiet registration step below will fail. 
# - Make sure there is no C:\temp folder on the machine. If you have some files stored, please move those before running the script 

#Requires -Version 5.1
#Requires -RunAsAdministrator

# Set strict mode for better error detection
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Start transcript for logging
$transcriptPath = Join-Path $env:TEMP "EntraConnectorToken_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
Start-Transcript -Path $transcriptPath -Append

try {
    Write-Host "Script started at $(Get-Date)" -ForegroundColor Cyan
    Write-Host "Log file: $transcriptPath" -ForegroundColor Cyan

    # Make sure ExecutionPolicy is set to Unrestricted
    try {
        Set-ExecutionPolicy UnRestricted -Force -Scope Process
        Write-Host "Execution policy set successfully" -ForegroundColor Green
    }
    catch {
        Write-Warning "Could not set execution policy: $_"
        Write-Host "Continuing anyway..." -ForegroundColor Yellow
    }

    # The script will use a temp folder on C Drive. First it will remove the folder and create a new folder to ensure its empty.
    $tempPath = "C:\temp"
    $tokenPath = "C:\token.txt"

    # Check if the folder exists
    if (Test-Path -Path $tempPath) {
        Write-Host "Existing temp folder found at '$tempPath'. Attempting to remove..." -ForegroundColor Yellow
        try {
            Remove-Item -Path $tempPath -Recurse -Force -ErrorAction Stop
            Write-Host "Temp folder removed successfully" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to remove existing temp folder '$tempPath'. Please manually delete it and try again. Error: $_"
            throw
        }
    } 

    # Creating C:\temp folder
    try {
        New-Item -ItemType Directory -Path $tempPath -Force -ErrorAction Stop | Out-Null
        Write-Host "Created temp folder: $tempPath" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to create temp folder '$tempPath'. Error: $_"
        throw
    }

    # Copy Required Dlls 
    Write-Host "Downloading Entra Private Network Connector Installer..." -ForegroundColor Cyan
    $installerUrl = "https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/DownloadConnectorInstaller"
    $installerPath = "$tempPath\MicrosoftEntraPrivateNetworkConnectorInstaller.exe"
    
    try {
        Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath -ErrorAction Stop
        
        if (-not (Test-Path -Path $installerPath)) {
            throw "Installer file was not downloaded successfully"
        }
        
        $fileSize = (Get-Item $installerPath).Length
        if ($fileSize -lt 1MB) {
            throw "Downloaded file seems too small ($fileSize bytes). Download may have failed."
        }
        
        Write-Host "Installer downloaded successfully ($([Math]::Round($fileSize/1MB, 2)) MB)" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to download installer from '$installerUrl'. Error: $_"
        throw
    }

    # Set the prompt path to C:\temp
    try {
        Set-Location -Path $tempPath -ErrorAction Stop
        Write-Host "Changed directory to: $tempPath" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to change directory to '$tempPath'. Error: $_"
        throw
    }

    # Quiet Registration of the Connector. This step will provide the required Module for acquiring the token. 
    # At the end of this step, you should see 2 folders under C:\Program Files. 1) Microsoft Entra private network connector 2) Microsoft Entra private network connector updater
    # These folders contains the required modules needed for getting the token. 
    Write-Host "Installing connector (quiet mode)..." -ForegroundColor Cyan
    
    try {
        $installProcess = Start-Process -FilePath $installerPath -ArgumentList "REGISTERCONNECTOR=`"false`"", "/q" -Wait -PassThru -ErrorAction Stop
        
        if ($installProcess.ExitCode -ne 0) {
            Write-Warning "Installer returned exit code: $($installProcess.ExitCode)"
        }
        else {
            Write-Host "Installer completed successfully" -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Failed to run installer. Error: $_"
        throw
    }

    # Wait 60 seconds for installation to complete
    Write-Host "Waiting for installation to complete..." -ForegroundColor Cyan
    Start-Sleep -Seconds 60

    $folderPath = "C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule"

    # Check if the Module exists
    if (Test-Path -Path $folderPath) {
        Write-Host "The Module is successfully made available at path: $folderPath" -ForegroundColor Green
    
    # Set the prompt path to C:\Program Files\Microsoft Entra private network connector\Modules\MicrosoftEntraPrivateNetworkConnectorPSModule
        try {
            Set-Location -Path $folderPath -ErrorAction Stop
            Write-Host "Changed directory to module path" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to change directory to '$folderPath'. Error: $_"
            throw
        }

        # Import Module 
        try {
            Import-Module ..\MicrosoftEntraPrivateNetworkConnectorPSModule -ErrorAction Stop
            Write-Host "Module imported successfully" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to import module. Error: $_"
            throw
        }

        # Load MSAL  
        $msalPath = ".\Microsoft.Identity.Client.dll"
        try {
            if (-not (Test-Path -Path $msalPath)) {
                throw "MSAL library not found at: $msalPath"
            }
            Add-Type -Path $msalPath -ErrorAction Stop
            Write-Host "MSAL library loaded successfully" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to load MSAL library. Error: $_"
            throw
        }

        # The AAD authentication endpoint uri
        $authority = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"

        # The application ID of the connector in AAD. Use the Connector AppId below
        $connectorAppId = "55747057-9b5d-4bd4-b387-abf52a8bd489"

        # The AppIdUri of the registration service in AAD
        $registrationServiceAppIdUri = "https://proxy.cloudwebappproxy.net/registerapp/user_impersonation"

        # Define the resources and scopes you want to call
        $scopes = New-Object System.Collections.ObjectModel.Collection["string"]
        $scopes.Add($registrationServiceAppIdUri)

        try {
            $app = [Microsoft.Identity.Client.PublicClientApplicationBuilder]::Create($connectorAppId).WithAuthority($authority).WithDefaultRedirectUri().Build()
            Write-Host "MSAL application created successfully" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to create MSAL application. Error: $_"
            throw
        }

        [Microsoft.Identity.Client.IAccount] $account = $null

        # Acquiring the token
        Write-Host "Acquiring authentication token (interactive login required)..." -ForegroundColor Cyan
        Write-Host "A browser window will open for authentication. Please complete the login process." -ForegroundColor Yellow
        
        $authResult = $null
        try {
            $authResult = $app.AcquireTokenInteractive($scopes).WithAccount($account).ExecuteAsync().ConfigureAwait($false).GetAwaiter().GetResult()
            Write-Host "Authentication completed successfully" -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to acquire authentication token. User may have cancelled or authentication failed. Error: $_"
            throw
        }

        # Check AuthN result
        If (($authResult) -and ($authResult.AccessToken) -and ($authResult.TenantId)) {
            $token = $authResult.AccessToken
            $tenantId = $authResult.TenantId
            
            $accessToken = $token

            try {
                New-Item -ItemType File -Path $tokenPath -Force -ErrorAction Stop | Out-Null
                Set-Content -Path $tokenPath -Value "$accessToken" -ErrorAction Stop
                Write-Host "Token successfully acquired and saved to $tokenPath" -ForegroundColor Green
            }
            catch {
                Write-Error "Failed to save token to '$tokenPath'. Error: $_"
                throw
            }

            # Set the prompt path to C: 
            try {
                Set-Location -Path "C:\" -ErrorAction Stop
            }
            catch {
                Write-Warning "Could not change directory to C:\. Error: $_"
            }

            # Uninstall the Connector from your machine.
            # You can do so programmatically (below) or manually by double clicking C:\temp\MicrosoftEntraPrivateNetworkConnectorInstaller.exe and choose Uninstall. 
            # Note that if the Connector service is not uninstalled properly, next iteration can fail on this machine.
            Write-Host "Uninstalling connector..." -ForegroundColor Cyan
            
            try {
                if (Test-Path -Path $installerPath) {
                    $uninstallProcess = Start-Process -FilePath $installerPath -ArgumentList "/uninstall", "/quiet" -Wait -PassThru -ErrorAction Stop
                    
                    if ($uninstallProcess.ExitCode -ne 0) {
                        Write-Warning "Uninstaller returned exit code: $($uninstallProcess.ExitCode)"
                    }
                    else {
                        Write-Host "Uninstaller completed successfully" -ForegroundColor Green
                    }
                }
                else {
                    Write-Warning "Installer not found at '$installerPath'. Cannot run uninstaller."
                }
            }
            catch {
                Write-Warning "Failed to run uninstaller. Error: $_"
                Write-Host "You may need to manually uninstall the connector." -ForegroundColor Yellow
            }

            # Wait 60 seconds
            Write-Host "Waiting for uninstallation to complete..." -ForegroundColor Cyan
            Start-Sleep -Seconds 60

            # Delete the related files
            Write-Host "Cleaning up files..." -ForegroundColor Cyan
            
            $foldersToClean = @(
                $tempPath,
                "C:\Program Files\Microsoft Entra private network connector",
                "C:\Program Files\Microsoft Entra private network connector updater"
            )
            
            foreach ($folder in $foldersToClean) {
                if (Test-Path -Path $folder) {
                    try {
                        Remove-Item -Path $folder -Recurse -Force -ErrorAction Stop
                        Write-Host "Successfully removed: $folder" -ForegroundColor Green
                    }
                    catch {
                        Write-Warning "Could not fully remove '$folder': $_"
                    }
                }
            }

            Write-Host "`n========================================" -ForegroundColor Green
            Write-Host "SUCCESS!" -ForegroundColor Green
            Write-Host "========================================" -ForegroundColor Green
            Write-Output "Access Token that you acquired is available in $tokenPath."
            Write-Output "Please ensure no additional spaces are introduced when copying token to marketplace input form. Introducing spaces can change the token and can cause failures"
            Write-Host "========================================`n" -ForegroundColor Green

        }
        else {
            Write-Error "Authentication failed: result, access token, or tenant ID was null. No token has been saved. Please re-run the script and complete the interactive login."
            Set-Location -Path "C:\" -ErrorAction SilentlyContinue
            throw "Authentication failed"
        }
    }
    else {
        Write-Error "The required module is not made available at path: $folderPath"
        Write-Host "This could be related to left over state from previous installation of connector on this machine." -ForegroundColor Yellow
        Write-Host "You can try to go to c:\temp\ and double click the MicrosoftEntraPrivateNetworkConnectorInstaller.exe file. Click Uninstall if visible. This can clean the state." -ForegroundColor Yellow
        Write-Host "If you don't have .exe file, you can download it from https://download.msappproxy.net/Subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/Connector/DownloadConnectorInstaller and double click it to Uninstall" -ForegroundColor Yellow
        Write-Host "Try Again after the state is clean" -ForegroundColor Yellow
        throw "Module not found at expected path"
    }
}
catch {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "SCRIPT FAILED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Error "An error occurred: $_"
    Write-Host "========================================`n" -ForegroundColor Red
    
    # Attempt cleanup on error
    Write-Host "Attempting cleanup..." -ForegroundColor Yellow
    Set-Location -Path "C:\" -ErrorAction SilentlyContinue
    
    $foldersToCleanOnError = @(
        $tempPath,
        "C:\Program Files\Microsoft Entra private network connector",
        "C:\Program Files\Microsoft Entra private network connector updater"
    )
    
    foreach ($folder in $foldersToCleanOnError) {
        if (Test-Path -Path $folder) {
            try {
                Remove-Item -Path $folder -Recurse -Force -ErrorAction SilentlyContinue
                Write-Host "Cleaned up: $folder" -ForegroundColor Green
            }
            catch {
                Write-Warning "Could not clean up '$folder'. You may need to manually remove it."
            }
        }
    }
    
    throw
}
finally {
    Stop-Transcript
    Write-Host "Log file saved to: $transcriptPath" -ForegroundColor Cyan
}
```

## Next steps

- [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview)

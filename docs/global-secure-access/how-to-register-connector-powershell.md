---
title: Silent install Microsoft Entra private network connector
description: Covers how to perform an unattended installation of the Microsoft Entra private network connector.
author: kenwith
manager: femila
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/21/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Create an unattended installation script for the Microsoft Entra private network connector

This article helps you create a Windows PowerShell script that enables unattended installation and registration for your Microsoft Entra private network connector.

Unattended installation is useful when you want to:

* Install the connector on Windows servers that don't have user interface enabled, or that you can't access with Remote Desktop.
* Install and register many connectors at once.
* Integrate the connector installation and registration as part of another procedure.
* Create a standard server image that contains the connector bits but isn't registered.

For the [private network connector](concept-connectors.md) to work, you must register it with Microsoft Entra ID. Registration is done in the user interface when you install the connector, but you can use PowerShell to automate the process.

There are two steps for an unattended installation. First, install the connector. Second, register the connector with Microsoft Entra ID.

> [!IMPORTANT]
> If you are installing the connector for the Microsoft Azure Government cloud, review the [prerequisites](~/identity/hybrid/connect/reference-connect-government-cloud.md#allow-access-to-urls) and [installation steps](~/identity/hybrid/connect/reference-connect-government-cloud.md#install-the-agent-for-the-azure-government-cloud). The Microsoft Azure Government cloud requires enabling access to a different set of URLs and an additional parameter to run the installation.

## Install the connector
Use the following steps to install the connector without registering it:

1. Open a command prompt.
2. Run the following command, the `/q` flag means quiet installation. A quiet installation doesn't prompt you to accept the End-User License Agreement.

   ```
   MicrosoftEntraPrivateNetworkConnectorInstaller.exe REGISTERCONNECTOR="false" /q
   ```

## Register the connector with Microsoft Entra ID
Register the connector using a token created offline.

### Register the connector using a token created offline
1. Create an offline token using the `AuthenticationContext` class using the values in this code snippet or PowerShell cmdlets:

   **Using C#:**

   ```csharp
   using System;
   using System.Linq;
   using System.Collections.Generic;
   using Microsoft.Identity.Client;

   class Program
   {
      #region constants
      /// <summary>
      /// The AAD authentication endpoint uri
      /// </summary>
      static readonly string AadAuthenticationEndpoint = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";

      /// <summary>
      /// The application ID of the connector in AAD
      /// </summary>
      static readonly string ConnectorAppId = "55747057-9b5d-4bd4-b387-abf52a8bd489";
   
      /// <summary>
      /// The AppIdUri of the registration service in AAD
      /// </summary>
      static readonly string RegistrationServiceAppIdUri = "https://proxy.cloudwebappproxy.net/registerapp/user_impersonation";

      #endregion

      #region private members
      private string token;
      private string tenantID;
      #endregion

      public void GetAuthenticationToken()
      {
         IPublicClientApplication clientApp = PublicClientApplicationBuilder
            .Create(ConnectorAppId)
            .WithDefaultRedirectUri() // will automatically use the default Uri for native app
            .WithAuthority(AadAuthenticationEndpoint)
            .Build();

         AuthenticationResult authResult = null;

         IAccount account = null;

         IEnumerable<string> scopes = new string[] { RegistrationServiceAppIdUri };

         try
         {
         authResult = await clientApp.AcquireTokenSilent(scopes, account).ExecuteAsync();
         }
         catch (MsalUiRequiredException ex)
         {
         authResult = await clientApp.AcquireTokenInteractive(scopes).ExecuteAsync();
         }

         if (authResult == null || string.IsNullOrEmpty(authResult.AccessToken) || string.IsNullOrEmpty(authResult.TenantId))
         {
         Trace.TraceError("Authentication result, token or tenant id returned are null");
         throw new InvalidOperationException("Authentication result, token or tenant id returned are null");
         }

         token = authResult.AccessToken;
         tenantID = authResult.TenantId;
      }
   }
   ```

   **Using PowerShell:**
   ```powershell
   # Loading DLLs

   Find-PackageProvider -Name NuGet| Install-PackageProvider -Force
   Register-PackageSource -Name nuget.org -Location https://www.nuget.org/api/v2 -ProviderName NuGet
   Install-Package Microsoft.IdentityModel.Abstractions  -ProviderName Nuget -RequiredVersion 6.22.0.0 
   Install-Module Microsoft.Identity.Client
 
   add-type -path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.IdentityModel.Abstractions.6.22.0\lib\net461\Microsoft.IdentityModel.Abstractions.dll"
   add-type -path "C:\Program Files\WindowsPowerShell\Modules\Microsoft.Identity.Client\4.53.0\Microsoft.Identity.Client.dll"

   # The AAD authentication endpoint uri

   $authority = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize"

   #The application ID of the connector in AAD

   $connectorAppId = "55747057-9b5d-4bd4-b387-abf52a8bd489";

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
   Else {

      Write-Output "Error: Authentication result, token or tenant id returned with null."

   } 
   ```
1. Once you have the token, create a `SecureString` using the token:
   ```powershell
   $SecureToken = $Token | ConvertTo-SecureString -AsPlainText -Force
   ```
1. Run the following Windows PowerShell command, replacing `<tenant GUID>` with your directory ID:

   ```powershell
   .\RegisterConnector.ps1 -modulePath "C:\Program Files\Microsoft Entra private network connector\Modules\" -moduleName "MicrosoftEntraPrivateNetworkConnectorPSModule" -Authenticationmode Token -Token $SecureToken -TenantId <tenant GUID> -Feature ApplicationProxy
   ```
1. Store the script or code in a secure location as it contains sensitive credential information.

## Next steps
- [What is Global Secure Access?](overview-what-is-global-secure-access.md)

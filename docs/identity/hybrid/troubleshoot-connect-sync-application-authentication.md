---
title: Troubleshoot Microsoft Entra Connect Sync application-based authentication
description: Learn how to troubleshoot known issues with application-based authentication (ABA) in Microsoft Entra Connect Sync, including missing connectivity parameters and multiple servers using the same connector account.
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.subservice: hybrid
ms.topic: troubleshooting
ms.date: 01/15/2025

# Customer intent: As an IT administrator managing Microsoft Entra Connect Sync, I want to resolve authentication issues with application-based authentication so that my hybrid identity synchronization works reliably and securely.
---

# Troubleshoot Microsoft Entra Connect Sync application-based authentication

Application-based authentication (ABA) for Microsoft Entra Connect Sync uses an application identity (a service principal with a certificate) instead of a username and password to authenticate to Microsoft Entra ID. This method improves security by eliminating the need for storing admin credentials on the sync server. This article helps you troubleshoot known issues with ABA in Microsoft Entra Connect Sync and provides steps to resolve them.

## Known issues

**Connectivity parameters missing after auto-upgrade** – After an automatic upgrade to an ABA-enabled Microsoft Entra Connect version, the Microsoft Entra (Azure AD) connector's connectivity fields (such as Application and Certificate) appear blank in the Synchronization Service Manager UI. Selecting **OK** on the connector properties causes **ApplicationManagedBy isn't set** error in the configuration wizard and prevents the next automatic certificate rollover.

**Multiple servers using the same connector account** – ABA is designed to work with one set of service principal or certificate per server. If two Microsoft Entra Connect Sync servers share the same custom Microsoft Entra (Azure AD) connector account (on-premises service account in Microsoft Entra ID), the automatic ABA setup gives them one shared application registration, causing the servers to use the same Microsoft Entra ID app or service principal. 

When one server updates the certificate for that app, the other server's authentication breaks, leading to sync errors on the second server. This issue can also occur with the default Microsoft Entra (Azure AD) connector account (that is, `Sync_SERVERNAME_############@contoso.onmicrosoft.com`) if the server was cloned after installing the Microsoft Entra Connect Sync service.

## Microsoft Entra Connector's Connectivity Parameters missing after upgrade

### Symptom

After your Microsoft Entra Connect server autoupdates to version 2.5.x and automatically switches to application-based auth, the Microsoft Entra (Azure AD) connector in Synchronization Service Manager shows no values for the new connectivity parameters, the fields for `ApplicationManagedBy`, `CertificateManagedBy`, and `CertificateId` are blank. If you open the connector properties and select **OK** (even if not changing anything), it saves the connector configuration and clears those ABA parameter definitions. 

As a result, when you run the Microsoft Entra Connect configuration wizard, it fails with an error: **ApplicationManagedBy isn't set**. The synchronization continues to work using the current certificate until it expires, but because the configuration is incomplete, the automatic certificate rollover fails and synchronization to Microsoft Entra ID is interrupted upon the next renewal.

### Cause

The Synchronization Service Manager UI isn't updated to handle the new ABA fields, when you open and save the connector in this legacy UI, it drops the application-based authentication settings. This issue occurs only in instances that autorolled over to ABA after autoupgrade. If you enabled ABA manually using the wizard or in a fresh installation, this issue doesn't occur.

### Resolution

Use a PowerShell repair function to restore missing parameters in the Microsoft Entra Connector configuration. Take the following steps on the affected server:

1. Start a new PowerShell session with **Run as Administrator**.

1. In order to use ADSyncTools module, you need to install or update it from PowerShell Gallery, as follows.

   > [!NOTE]
   > The minimum required version for this function of ADSyncTools is 2.3.0.

   ```powershell
   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   Install-Module ADSyncTools # If ADSyncTools isn't installed, or;
   Update-Module ADSyncTools # If ADSyncTools is already installed
   ```

1. Import ADSyncTools module:

   ```powershell
   Import-Module ADSyncTools
   ```

1. Run the repair function:

   ```powershell
   Repair-ADSyncToolsEntraAppParameters
   ```

This process restores the missing parameters. You should also be able to run the configuration wizard without errors. The sync service will use application-based authentication, and future certificate rollovers succeed.

> [!IMPORTANT]
> Avoid using the Synchronization Service Manager UI to view or edit the Microsoft Entra (Azure AD) connector's properties when ABA is enabled. Even selecting **OK** without changes can remove required settings. Always use the Microsoft Entra Connect wizard (or PowerShell commands) for configuration changes to the connector.

## Multiple servers sharing the same custom Microsoft Entra Connector account

### Symptom

Consider a deployment with two Microsoft Entra Connect Sync servers, one active server and one staging server for backup, if these servers were configured to use the same Microsoft Entra ID connector account (that is, the same Microsoft Entra service account credentials for legacy authentication), you might encounter the following authentication errors after ABA is enabled.

```
Log Name:      Application
Source:        Directory Synchronization
Date:          12/01/2025 0:00:00 AM
Event ID:      906
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      EntraConnect.Contoso.com
Description:
[MSAL] AcquireTokenWithCertificate: Exception caught while acquiring token via certificate. [invalid_client] - A configuration issue is preventing authentication - check the error message from the server for details. You can modify the configuration in the application registration portal. See https://aka.ms/msal-net-invalid-client for details.  Original exception: AADSTS700027: The certificate with identifier used to sign the client assertion is not registered on application. [Reason - The key was not found., Please visit the Azure Portal, Graph Explorer or directly use MS Graph to see configured keys for app Id '<guid>'. Review the documentation at https://docs.microsoft.com/en-us/graph/deployments to determine the corresponding service endpoint and https://docs.microsoft.com/en-us/graph/api/application-get?view=graph-rest-1.0&tabs=http to build a query request URL, such as 'https://graph.microsoft.com/beta/applications/<guid>']. Trace ID: <guid> Correlation ID: <guid> Timestamp: <datetime>
```

Typically, the second server (or whichever server switched to ABA last) will work normally, and the server that had ABA configured first, will start failing to connect to Microsoft Entra ID with such certificate errors. If you try to fix the first server (for instance, by rerunning the ABA setup manually), then authentication breaks on the second server.

### Cause

By design, only one server can authenticate at a time with one Microsoft Entra ID application. The automatic ABA enrollment uses the connector's service account to identify the application registration. When two different servers share the same account, the system mistakenly uses a single application identity for both. Both servers end up configured with the same Application and Service Principal. This isn't supported, as each Microsoft Entra Connect instance should have a unique application. 

The same issue occurs when a server with Microsoft Entra Connect installed is cloned into another production server, which isn't a supported method of deploying this product as these servers with share the same machine identifier. In short, the server's identity conflicts because they get tied to one app registration. The Microsoft Entra Connect wizard by default uses unique accounts per server because it uses the server's name to identify the application registration instead of the Microsoft Entra connector's service account, which avoids this issue.

> [!NOTE]
> To prevent this issue, ensure that each Microsoft Entra Connect instance uses a unique connector account and a unique machine identifier. If you have multiple sync servers (for example, in staging mode) using the same Microsoft Entra (Azure AD) Connector account, follow the documented resolution steps on each server so that each instance gets its own application registration.

> [!WARNING]
> Don't use a **Global Administrator** account as the Microsoft Entra (Azure AD) Connector account. The Microsoft Entra service account that is configured by default has more restricted permissions for what's needed during synchronization whereas an administrator account has unlimited privileges in the cloud. If an on-premises Microsoft Entra Connect server configured with a Global Administrator account gets compromised, it puts your entire Microsoft Entra tenant at risk.

### Resolution

Give each Microsoft Entra Connect server its own application identity. To do this, you must reconfigure each server separately by reverting it to legacy authentication and then running the ABA configuration so that each server creates its own app registration.
In this scenario, there are two servers configured with ABA: ServerA is running correctly, and ServerB is in a broken state. Perform the following steps on each server, starting with the working server and then moving to the server in the broken state.

1. **On ServerA, temporarily pause the sync scheduler**: Open PowerShell as an administrator on the Microsoft Entra Connect server and run:

   ```powershell
   Set-ADSyncScheduler -SyncCycleEnabled $false
   ```

1. **Revert ServerA to legacy authentication**: In the PowerShell window, run the following commands to assign a service account back to the Microsoft Entra (Azure AD) connector. You're prompted to enter credentials. Provide the username and password of a Global Administrator or Hybrid Identity Administrator in Microsoft Entra ID. The following cmdlet configures the Microsoft Entra (Azure AD) connector to use an account for sync called `Sync_<Servername>_<SyncMachineIdentifier>` (replacing the application identity).

   ```powershell
   $cred = Get-Credential
   $connAccountName = "Sync_$($env:COMPUTERNAME)_$((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Azure AD Connect').SyncMachineIdentifier.Substring(0, 12))"
   Add-ADSyncAADServiceAccount -AADCredential $cred -Name $connAccountName
   ```

1. **Verify legacy auth is in use (optional)**: You can confirm the connector is back to using a service account by running the command `Get-ADSyncEntraConnectorCredential`. In the output, check if the `ConnectorIdentityType` is ServiceAccount (not Application). This means the connector is now using the provided account credentials.

1. **Check ServerA Machine identifier**: Take note of the current machine identifier from ServerA before switching to ServerB:

   ```powershell
   Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Azure AD Connect" | Select-Object SyncMachineIdentifier
   ```

1. **Switch to ServerB and rotate ABA certificate**: To fix Microsoft Entra ID authentication for ServerB (broken state), run the Microsoft Entra Connect wizard on ServerB and select **Rotate application certificate**, then complete all the steps in order to recover ABA.

1. **Temporarily pause the sync scheduler (ServerB)**: Open PowerShell as an administrator on the Microsoft Entra Connect server and run:

   ```powershell
   Set-ADSyncScheduler -SyncCycleEnabled $false
   ```

1. Check ServerB Machine identifier: Get the current machine identifier from ServerB and compare it with ServerA's value.

   ```powershell
   Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Azure AD Connect" | Select-Object SyncMachineIdentifier
   ```

1. **Generate a new machine identifier**: If both servers have the same machine identifier, run the following commands to generate a new ID:

   ```powershell
   # 1. Stop ADSync service
   Stop-Service ADSync
   
   # 2. Generate and set new identifier
   $newId = [Guid]::NewGuid().ToString("N")
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Azure AD Connect" -Name SyncMachineIdentifier -Value $newId
   
   # 3. Confirm new identifier
   Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Azure AD Connect" | Select-Object SyncMachineIdentifier
   
   # 4. Restart ADSync service
   Start-Service ADSync
   ```

1. **Revert ServerB to legacy authentication**: In the PowerShell window, run the following commands to assign a service account back to the Microsoft Entra (Azure AD) connector. You're prompted to enter credentials. Provide the username and password of a Global Administrator or Hybrid Identity Administrator in Microsoft Entra ID. The following cmdlet configures the Microsoft Entra (Azure AD) connector to use an account for sync called `Sync_<Servername>_<SyncMachineIdentifier>` (replacing the application identity).

   ```powershell
   $cred = Get-Credential
   $connAccountName = "Sync_$($env:COMPUTERNAME)_$((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Azure AD Connect').SyncMachineIdentifier.Substring(0, 12))"
   Add-ADSyncAADServiceAccount -AADCredential $cred -Name $connAccountName
   ```

1. **Delete the app from Microsoft Entra ID**: Go to the [Microsoft Entra admin center](https://entra.microsoft.com) and navigate to **App Registrations** > **All Applications**, then remove one or more previous apps that had the certificate conflict (that is, `ConnectSyncProvisioning_*`).

1. **Reconfigure ABA on ServerB**: Start the Microsoft Entra Connect wizard on ServerB, select Configure application-based authentication, and go through the setup steps to enable ABA on this server. This registers a new Microsoft Entra application dedicated to ServerB.

1. **Resume the sync scheduler**: Run the following command to re-enable sync and confirm that normal synchronization is resumed.
    ```powershell
    Set-ADSyncScheduler -SyncCycleEnabled $true
    ```

1. **Switch to ServerA**: Repeat steps 11 and 12 on ServerA.

After completing these steps, each Microsoft Entra Connect server is linked to its own application identity in Microsoft Entra ID. They'll no longer conflict with each other. Both servers should be able to run synchronization concurrently without authentication errors. You can verify in the Microsoft Entra admin center under **App registrations** that there are now two distinct app entries (one for each server) with a name `ConnectSyncProvisioning_<Servername>_<SyncMachineIdentifier>`.

By addressing the issues discussed in this guide, restoring missing connectivity parameters after an upgrade, and separating application identities for multiple servers, you can maintain a healthy and more secure Microsoft Entra Connect environment using application-based authentication. 

Always use the Microsoft Entra Connect wizard or documented PowerShell commands for configuration changes. For more information on setting up and managing ABA, see [Authenticate to Microsoft Entra ID by Using Application Identity](~/identity/hybrid/connect/authenticate-application-id.md).

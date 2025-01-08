---
title: 'Auditing administrator events in Microsoft Entra Connect Sync'
description: This article describes security improvements to Microsoft Entra Connect Sync and how to enable logging of administrator activities.
author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 01/07/2025
ms.subservice: hybrid-connect
ms.author: billmath
---

# Auditing administrator events in Microsoft Entra Connect Sync (Public Preview)

In January 2025, we released a new version (2.4.27.0) of Microsoft Entra Connect Sync. This version contains an update to auditing which is enabled be default. With this update, you can now monitor administrator events and activity.  The following article describes how to disable the auditing feature.  **All customers are required to upgrade** to the [minimum versions](#minimum-versions) by **April 7, 2025**. 

## How to manually disable auditing of administrator events
To enable auditing of administrator events, use the following steps

1. Open the Registry Editor - Press Win + R to open the Run dialog. 
2. Type **regedit** and press Enter to launch the Registry Editor. Confirm any security prompts to proceed. 
3. Navigate to the following path: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure AD Connect**.  
4. Modify or Create the **AuditEventLogging** Value by right-click on the Azure AD Connect key, select New -> **DWORD (32-bit)** Value if the AuditEventLogging value does not already exist. 
5. Name the new DWORD as **AuditEventLogging**. 
6. Double-clicking on the **AuditEventLogging** entry and enter **0** to enable audit event logging.  Enter 0 to disable it. 

:::image type="content" source="media/admin-audit-logging/logging-1.png" alt-text="Screenshot of the new AuditEventLogging registry kety." lightbox="media/admin-audit-logging/logging-1.png":::


## How to use PowerShell to disable auditing of administrator events
You can also use PowerShell to enable audit logging of administrator events.  Use the following script.

  ```powershell
  #Declare variables
  $registryPath = 'HKLM:\SOFTWARE\Microsoft\Azure AD Connect'
  $valueName = 'AuditEventLoggging'
  $newValue = '0'

  #Create the AuditEventLogging key if it does not exist
  if (!(Test-Path $registryPath)) {New-Item -Path $registryPath -Force}

  #Set the value of the new AuditEventLogging key
  Set-ItemProperty -Path $registryPath -Name $valueName -Value $newValue
  ```

## List of logged events
The following table is a list of events that are logged with the new auditing feature.  To view the events, use Event Viewer and look in the Application log. 

|EventID|EventName|Description|
|-----|-----|-----|
|2503|Add/Update/DeleteDirectories||
|2504|EnableExpresssettingsmode|| 
|2505|Enable/DisablealldomainsandOUforsync|| 
|2506|Enable/DisablePHSSync|| 
|2507|Enable/DisableSyncstartafterinstall|| 
|2508|CreateADDSaccount|| 
|2509|UseExistingADDSaccount|| 
|2510|Create/Update/Deletecustominboundsyncrule|| 
|2511|Enable/DisableDomainbasedfiltering||
|2512|Enable/DisableOUbasedfiltering|| 
|2513|UserSign-Inmethodchanged|| 
|2514|ConfigurenewADFSfarm|| 
|2515|Enable/DisableSinglesign-on|| 
|2516|Installwebapplicationproxyserver||
|2517|SetPermissions|| 
|2518|ChangeADDSConnectorPasswordcredential|| 
|2519|ReinitializeEntraIDConnectoraccountpassword|| 
|2520|InstallADFSServer|| 
|2521|SetADFSServiceAccount|| 


  ## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
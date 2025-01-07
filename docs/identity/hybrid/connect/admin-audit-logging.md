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

# Auditing administrator events in Microsoft Entra Connect Sync

In January 2025, we released a new version (2.4.27.0) of Microsoft Entra Connect Sync. This version contains an update to auditing. With this update, you can now monitor administrator events and activity.  **All customers are required to upgrade** to the [minimum versions](#minimum-versions) by **April 7, 2025**. 

## How to manually enable auditing of administrator events
To enable auditing of administrator events, use the following steps

1. Open the Registry Editor - Press Win + R to open the Run dialog. 
2. Type **regedit** and press Enter to launch the Registry Editor. Confirm any security prompts to proceed. 
3. Navigate to the following path: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure AD Connect**.  
4. Modify or Create the **AuditEventLogging** Value by right-click on the Azure AD Connect key, select New -> **DWORD (32-bit)** Value if the AuditEventLogging value does not already exist. 
5. Name the new DWORD as **AuditEventLogging**. 
6. Double-clicking on the **AuditEventLogging** entry and enter **1** to enable audit event logging.  Enter 0 to disable it. 

:::image type="content" source="media/admin-audit-logging/logging-1.png" alt-text="Screenshot of the new AuditEventLogging registry kety." lightbox="media/admin-audit-logging/logging-1.png":::


## How to use PowerShell to enbale auditing of administrator events
You can also use PowerShell to enable audit logging of administrator events.  Use the following script.

  ```powershell
  #Declare variables
  $registryPath = 'HKLM:\SOFTWARE\Microsoft\Azure AD Connect'
  $valueName = 'AuditEventLoggging'
  $newValue = '1'

  #Create the AuditEventLogging key if it does not exist
  if (!(Test-Path $registryPath)) {New-Item -Path $registryPath -Force}

  #Set the value of the new AuditEventLogging key
  Set-ItemProperty -Path $registryPath -Name $valueName -Value $newValue
  ```

  ## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
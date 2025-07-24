---
title: Audit Administrator Events in Microsoft Entra Connect Sync
description: This article describes security improvements to Microsoft Entra Connect Sync and how to enable logging of administrator activities.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 07/24/2025
ms.subservice: hybrid-connect
ms.author: jomondi
---

# Audit administrator events in Microsoft Entra Connect Sync

Starting from version [(2.4.129.0)](reference-connect-version-history.md#241290) of Microsoft Entra Connect Sync, a new admin audit logging feature is available and enabled by default. This feature allows organizations to monitor changes made to Microsoft Entra Connect Sync configurations by Global Administrators or Hybrid Administrators.

Admin actions performed through the Microsoft Entra Connect Sync Wizard, PowerShell, or the Synchronization Rules Editor—such as updates to synchronization rules, authentication settings, and federation settings are captured and logged in a dedicated audit log channel within the Windows Event Viewer. This provides improved visibility into identity infrastructure changes and supports troubleshooting, operational accountability, and regulatory compliance.

This article outlines the list of events logged by this feature and explains how to disable it, if needed.

## List of logged events

The following table is a list of events that are logged with the new auditing feature. To view the events, use the Event Viewer and view the Application log.

:::image type="content" source="media/admin-audit-logging/logging-2.png" alt-text="Screenshot that shows the Event Viewer." lightbox="media/admin-audit-logging/logging-2.png":::

> [!NOTE]
> We recommend that you increase the application events log size, as the Windows default size of 20MB is relatively small and can be quickly overwritten. A minimum size of 250MB-500MB is suggested.

|Event ID|Event name|Description|
|-----|-----|-----|
|2503|Add/Update/Delete directories.|Provides the name of the affected directory.|
|2504|Enable Express settings mode.| This event is logged after the administrator selects **Express Setup**.|
|2505|Enable/Disable domains and organizational units (OUs) for sync.| Shows a list of all domains connected to Microsoft Entra Connect Sync.|
|2506|Enable/Disable password hash synchronization (PHS).| Shows that PHS is enabled or disabled.|
|2507|Enable/Disable sync start after installation.| Event is logged when sync is enabled or disabled after the installation is finished.|
|2508|Create Active Directory Domain Services (AD DS) account.| Shows the created account needed to connect to the new directory added.|
|2509|Use existing AD DS account.| Shows the name of the account used to connect to the directory.|
|2510|Create/Update/Delete custom sync rule.| Shows the name of the sync rule that changed along with information on what changed.|
|2511|Enable/Disable domain-based filtering.|Shows that domain filtering is selected and lists selected domains.|
|2512|Enable/Disable OU-based filtering.| Shows that OU-based filtering is selected and lists selected OUs. |
|2513|User sign-in method changed.|Shows the old sign-in method and the new one. |
|2514|Configure new Active Directory Federation Services (AD FS) farm.| Shows the federation services name.|
|2515|Enable/Disable single sign-on.| Shows single sign-on change. |
|2516|Install web application proxy server.|Shows selected AD FS servers and the domain admin username.|
|2517|Set permissions.| Shows the specific ADSync permission that changed.|
|2518|Change AD DS Connector credential.| Shows the AD DS Connector credential that changed.|
|2519|Reinitialize Microsoft Entra ID Connector account password.| Shows that the ADSync account password was reset.|
|2520|Install AD FS server.| Shows the selected server.|
|2521|Set AD FS service account.| Specifies if group managed or a domain user. Includes the administrator username.|
|2522|`ConfigureEntraApplicationAuthentication`|Specifies that configuring application authentication to Microsoft Entra ID was attempted. It provides the status of the operation along with relevant details like application (client) ID.|
|2523|`RotateEntraApplicationCertificate`|Specifies that rotation of the application certificate used for authentication to Microsoft Entra ID was attempted along with the status of the operation.|
|2524|`DeleteEntraConnectorAccount`|Specifies that deletion of the Microsoft Entra ID synchronization account was attempted. It provides the status of the operation along with the name of the account.|
|2525|`DeleteEntraApplication`|Specifies that deletion of the Microsoft Entra Connect Sync application used for synchronizing with Microsoft Entra ID was attempted. It provides the application (client) ID along with the status of the operation.|
|2526|`DeleteApplicationCertificate`|Specifies that deletion of the Microsoft Entra Connect Sync application certificate was attempted. It provides the application (client) ID and the certificate ID along with the status of the operation.|

## Disable auditing of administrator events

### Use the Registry Editor

To disable auditing of administrator events, follow these steps:

1. Open the Registry Editor. Select **Win+R** to open the **run** dialog.
1. Enter **regedit** and select **Enter** to open the Registry Editor. Confirm any security prompts to proceed.
1. Go to **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure AD Connect**.
1. Right-click the **Azure AD Connect** key to modify or create the **AuditEventLogging** value. Select **New** and select the **DWORD (32-bit)** value if the **AuditEventLogging** value doesn't already exist.
1. Name the new **DWORD** as **AuditEventLogging**.
1. Double-click the **AuditEventLogging** entry and enter **0** to disable the audit event logging. Enter **1** to reenable it.

:::image type="content" source="media/admin-audit-logging/logging-1.png" alt-text="Screenshot that shows the new AuditEventLogging registry key." lightbox="media/admin-audit-logging/logging-1.png":::

### Use PowerShell

You can also use PowerShell to disable audit logging of administrator events. Use the following script:

 ```powershell
 #Declare variables
 $registryPath = 'HKLM:\SOFTWARE\Microsoft\Azure AD Connect'
 $valueName = 'AuditEventLogging'
 $newValue = '0'

 #Create the AuditEventLogging key if it doesn't exist
 if (!(Test-Path $registryPath)) {New-Item -Path $registryPath -Force}

 #Set the value of the new AuditEventLogging key
 Set-ItemProperty -Path $registryPath -Name $valueName -Value $newValue
 ```

## Related content

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)

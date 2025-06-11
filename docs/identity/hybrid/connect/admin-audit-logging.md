---
title: 'Auditing administrator events in Microsoft Entra Connect Sync'
description: This article describes security improvements to Microsoft Entra Connect Sync and how to enable logging of administrator activities.
author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: billmath
---

# Auditing administrator events in Microsoft Entra Connect Sync (Public Preview)

In January 2025, we released a new version [(2.4.129.0)](reference-connect-version-history.md#241290) of Microsoft Entra Connect Sync. This version contains an update to auditing which is enabled by default. With this update, you can now monitor administrator events and activity. The following article describes how to disable the auditing feature. 


## How to manually disable auditing of administrator events
To disable auditing of administrator events, use the following steps:

1. Open the Registry Editor - Press Win + R to open the run dialog. 
2. Type **regedit** and press Enter to launch the Registry Editor. Confirm any security prompts to proceed. 
3. Navigate to the following path: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Azure AD Connect**. 
4. Modify or Create the **AuditEventLogging** Value by right-click on the Azure AD Connect key, select New -> **DWORD (32-bit)** Value if the AuditEventLogging value doesn't already exist. 
5. Name the new DWORD as **AuditEventLogging**. 
6. Double-clicking on the **AuditEventLogging** entry and enter **0** to disable the audit event logging. Enter 1 to re-enable it. 

:::image type="content" source="media/admin-audit-logging/logging-1.png" alt-text="Screenshot of the new AuditEventLogging registry key." lightbox="media/admin-audit-logging/logging-1.png":::


## How to use PowerShell to disable auditing of administrator events
You can also use PowerShell to disable audit logging of administrator events. Use the following script.

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

## List of logged events
The following table is a list of events that are logged with the new auditing feature. To view the events, use Event Viewer and look in the Application log. 

:::image type="content" source="media/admin-audit-logging/logging-2.png" alt-text="Screenshot of Event Viewer." lightbox="media/admin-audit-logging/logging-2.png":::

|EventID|EventName|Description|
|-----|-----|-----|
|2503|Add/Update/Delete Directories|Provides the name of the affected directory|
|2504|Enable Express settings mode| This event will be logged when "Express Setup" is selected by the administrator|
|2505|Enable/Disable domains and OU for sync| Shows a list of all domains connected to Connect Sync|
|2506|Enable/Disable PHS Sync| Shows Password Hash Sync is enabled or disabled|
|2507|Enable/Disable Sync start after install| Event is logged when sync is enabled or disabled when the installation is done|
|2508|Create ADDS account| Shows the created account needed to connect to the new directory added|
|2509|Use Existing ADDS account| Shows name of the account used to connect to the directory|
|2510|Create/Update/Delete custom sync rule| Shows the name of the sync rule that has changed along with information on what changed|
|2511|Enable/Disable Domain based filtering|Shows domain filtering is selected and lists selected domains|
|2512|Enable/Disable OU based filtering| Shows OU based filtering is selected and lists selected OUs |
|2513|User Sign-In method changed|Shows the old sign in method and the new one |
|2514|Configure new ADFS farm| Shows the federation service name|
|2515|Enable/Disable Single sign-on| Shows single sign-on change |
|2516|Install web application proxy server|Shows selected ADFS servers and Domain Admin username|
|2517|Set Permissions| Shows the specific AD Sync permission changed|
|2518|Change ADDS Connector credential| Shows ADDS Connector credential changed|
|2519|Reinitialize Entra ID Connector account password| Shows that the AD Sync service account password was reset|
|2520|Install ADFS Server| Shows the selected server|
|2521|Set ADFS Service Account| Specifies if group-managed or domain user. Includes administrator username|
|2522|ConfigureEntraApplicationAuthentication|Specifies that configuring application authentication to Microsoft Entra ID was attempted. It provides the status of the operation along with relevant details like application (Client) Id.|
|2523|RotateEntraApplicationCertificate|Speifies that rotation of the application certificate that is used for authentication to Microsoft Entra ID was attempted along with the status of the operation.|
|2524|DeleteEntraConnectorAccount|Specifies that deletion of the Microsoft Entra ID synchronization account was attempted. It provides the status of the operation along with the name of the account.|
|2525|DeleteEntraApplication|Specifies that deletion of the Entra Connect Sync application used for synchronizing with Microsoft Entra ID was attempted. It provides the application(Client) Id along with the status of the operation.|
|2526|DeleteApplicationCertificate|Specifies that deletion of the Entra Connect Sync application certificate was attempted. It provides the application (Client) Id and the Certificate Id along with the status of the operation.|


 ## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)

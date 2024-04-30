---
title: 'Microsoft Entra Connect: Version release history archive'
description: This article lists all archived releases of Microsoft Entra Connect and Azure AD Sync

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath

ms.custom: has-adal-ref, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---
# Microsoft Entra Connect: Version release history archive

The Microsoft Entra team regularly updates Microsoft Entra Connect with new features and functionality. Not all additions are applicable to all audiences.

>[!NOTE] 
> This article contains version reference information about all archived versions of Microsoft Entra ID - 1.5.42.0 and older. For current releases, see the [Microsoft Entra Connect Version release history](reference-connect-version-history.md).

## 1.5.42.0

### Release status
07/10/2020: Released for download

### Functional changes
Includes a public preview of the functionality to export the configuration of an existing Microsoft Entra Connect server into a .JSON file.  This file can be used when installing a new Microsoft Entra Connect server to create a copy of the original server.

A detailed description of this new feature can be found in [this article](./how-to-connect-import-export-config.md)

### Fixed issues
- Fixed a bug where there would be a false warning about the local DB size on the localized builds during upgrade.
- Fixed a bug where there would be a false error in the app events for the account name/domain name swap.
- Fixed an error where Microsoft Entra Connect would fail to install on a DC, giving error "member not found".


## 1.5.30.0

### Release status
05/07/2020: Released for download

### Fixed issues
This hotfix build fixes an issue where unselected domains were getting incorrectly selected from the wizard UI if only grandchild containers were selected.


>[!NOTE]
>This version includes the new Microsoft Entra Connect Sync V2 endpoint API. This new V2 endpoint is currently in public preview. This version or later is required to use the new V2 endpoint API. However, simply installing this version doesn't enable the V2 endpoint. You'll continue to use the V1 endpoint unless you enable the V2 endpoint. You need to follow the steps under [Microsoft Entra Connect Sync V2 endpoint API (public preview)](how-to-connect-sync-endpoint-api-v2.md) in order to enable it and opt-in to the public preview. 

## 1.5.29.0

### Release status
04/23/2020: Released for download

### Fixed issues
This hotfix build fixes an issue introduced in build 1.5.20.0 where a tenant administrator with MFA wasn't able to enable DSSO.

## 1.5.22.0

### Release status
04/20/2020: Released for download

### Fixed issues
This hotfix build fixes an issue in build 1.5.20.0 if you have cloned the **In from AD - Group Join** rule and haven't cloned the **In from AD - Group Common** rule.

## 1.5.20.0

### Release status
04/09/2020: Released for download

### Fixed issues
- This hotfix build fixes an issue with build 1.5.18.0 if you have the Group Filtering feature enabled and use mS-DS-ConsistencyGuid as the source anchor.
- An issue in the ADSyncConfig PowerShell module, where invoking DSACLS command used in all the Set-ADSync* Permissions cmdlets would cause one of the following errors:
   - `GrantAclsNoInheritance : The parameter is incorrect.  The command failed to complete successfully.`
   - `GrantAcls : No GUID Found for computer …`

> [!IMPORTANT]
> If you have cloned the **In from AD - Group Join** sync rule and haven't cloned the **In from AD - Group Common** sync rule and plan to upgrade, complete the following steps as part of the upgrade:
> 1. During Upgrade, uncheck the option **Start the synchronization process when configuration completes**.
> 2. Edit the cloned join sync rule and add the following two transformations:
>   - Set direct flow `objectGUID` to `sourceAnchorBinary`.
>   - Set expression flow `ConvertToBase64([objectGUID])` to `sourceAnchor`.   
> 3. Enable the scheduler using `Set-ADSyncScheduler -SyncCycleEnabled $true`.



## 1.5.18.0

### Release status
04/02/2020: Released for download

### Functional changes ADSyncAutoUpgrade 

- Added support for the mS-DS-ConsistencyGuid feature for group objects. Allows you to move groups between forests or reconnect groups in AD to Microsoft Entra ID where the AD group objectID has changed. For more information, see [Moving groups between forests](how-to-connect-migrate-groups.md).
- The mS-DS-ConsistencyGuid attribute is automatically set on all synced groups and you don't have to do anything to enable this feature. 
- Removed the Get-ADSyncRunProfile because it's no longer in use. 
- Changed the warning you see when attempting to use an Enterprise Admin or Domain Admin account for the AD DS connector account to provide more context. 
- Added a new cmdlet to remove objects from the connector space the old CSDelete.exe tool is removed, and it's replaced with the new Remove-ADSyncCSObject cmdlet. The Remove-ADSyncCSObject cmdlet takes a CsObject as input. This object can be retrieved by using the Get-ADSyncCSObject cmdlet.

>[!NOTE]
>The old CSDelete.exe tool has been removed and replaced with the new Remove-ADSyncCSObject cmdlet 

### Fixed issues

- Fixed a bug in the group writeback forest/OU selector on rerunning the Microsoft Entra Connect wizard after disabling the feature. 
- Introduced a new error page that will be displayed if the required DCOM registry values are missing with a new help link. Information is also written to log files. 
- Fixed an issue with the creation of the Microsoft Entra synchronization account where enabling Directory Extensions or PHS may fail because the account hasn't propagated across all service replicas before attempted use. 
- Fixed a bug in the sync errors compression utility that wasn't handling surrogate characters correctly. 
- Fixed a bug in the auto upgrade that left the server in the scheduler suspended state. 

## 1.4.38.0
### Release status
12/9/2019: Release for download. Not available through auto-upgrade.
### New features and improvements
- We updated Password Hash Sync for Microsoft Entra Domain Services to properly account for padding in Kerberos hashes. Provides a performance improvement during password synchronization from Microsoft Entra ID to Microsoft Entra Domain Services.
- We added support for reliable sessions between the authentication agent and service bus.
- We added a DNS cache for websocket connections between authentication agent and cloud services.
- We added the ability to target specific agent from cloud to test for agent connectivity.

### Fixed issues
- Release 1.4.18.0 had a bug where the PowerShell cmdlet for DSSO was using the login Windows credentials instead of the admin credentials provided while running PowerShell. As a result of which it wasn't possible to enable DSSO in multiple forests through the Microsoft Entra Connect user interface. 
- A fix was made to enable DSSO simultaneously in all forest through the Microsoft Entra Connect user interface

## 1.4.32.0
### Release status
11/08/2019: Released for download. Not available through auto-upgrade.

>[!IMPORTANT]
>Due to an internal schema change in this release of Microsoft Entra Connect, if you manage AD FS trust relationship configuration settings using [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) then you must update your Microsoft Graph PowerShell module to version 1.1.183.57 or higher.

### Fixed issues

This version fixes an issue with existing Microsoft Entra hybrid joined devices. This release contains a new device sync rule that corrects this issue.
This rule change may cause deletion of obsolete devices from Microsoft Entra ID. These device objects aren't used by Microsoft Entra ID during Conditional Access authorization. For some customers, the number of devices that will be deleted through this rule change can exceed the deletion threshold. If you see the deletion of device objects in Microsoft Entra exceeding the Export Deletion Threshold, see [How to allow deletes to flow when they exceed the deletion threshold](how-to-connect-sync-feature-prevent-accidental-deletes.md)

## 1.4.25.0

### Release status
9/28/2019: Released for auto-upgrade to select tenants. Not available for download.

This version fixes a bug where some servers that were auto-upgraded from a previous version to 1.4.18.0 and experienced issues with Self-service password reset (SSPR) and Password Writeback.

### Fixed issues

Under certain circumstances, servers that were auto upgraded to version 1.4.18.0 didn't re-enable Self-service password reset and Password Writeback after the upgrade was completed. This auto upgrade release fixes that issue and re-enables Self-service password reset and Password Writeback.

We fixed a bug in the sync errors compression utility that wasn't handling surrogate characters correctly.

## 1.4.18.0

>[!WARNING]
>We are investigating an incident where some customers are experiencing an issue with existing Microsoft Entra hybrid joined devices after upgrading to this version of Microsoft Entra Connect. We advise customers who have deployed Microsoft Entra hybrid join to postpone upgrading to this version until the root cause of these issues are fully understood and mitigated. More information will be provided as soon as possible.

>[!IMPORTANT]
>With this version of Microsoft Entra Connect some customers may see some or all of their Windows devices disappear from Microsoft Entra ID. These device identities aren't used by Microsoft Entra ID during Conditional Access authorization. For more information, see [Understanding Microsoft Entra Connect 1.4.xx.x device disappearance](/troubleshoot/azure/active-directory/reference-connect-device-disappearance)


### Release status
9/25/2019: Released for auto-upgrade only.

### New features and improvements
- New troubleshooting tooling helps troubleshoot "user not syncing", "group not syncing" or "group member not syncing" scenarios.
- Add support for national clouds in Microsoft Entra Connect troubleshooting script.
- Customers should be informed that the deprecated WMI endpoints for MIIS_Service have now been removed. Any WMI operations should now be done via PowerShell cmdlets.
- Security improvement by resetting constrained delegation on AZUREADSSOACC object.
- When adding/editing a sync rule, if there are any attributes used in the rule that are in the connector schema, but not added to the connector, the attributes will automatically be added to the connector. The same is true for the object type the rule affects. If anything is added to the connector, the connector will be marked for full import on the next sync cycle.
- Using an Enterprise or Domain admin as the connector account is no longer supported in new Microsoft Entra Connect Deployments. Current Microsoft Entra Connect deployments using an Enterprise or Domain admin as the connector account won't be affected by this release.
- In the Synchronization Manager, a full sync is run on rule creation/edit/deletion. A pop-up will appear on any rule change notifying the user if full import or full sync is going to be run.
- Added mitigation steps for password errors to 'connectors > properties > connectivity' page.
- Added a deprecation warning for the sync service manager on the connector properties page. This warning notifies the user that changes should be made through the Microsoft Entra Connect wizard.
- Added new error for issues with a user's password policy.
- Prevent misconfiguration of group filtering by domain and OU filters. Group filtering will show an error when the domain/OU of the entered group is already filtered out. Group filtering will keep the user from moving forward until the issue is resolved.
- Users can no longer create a connector for Active Directory Domain Services or Windows Azure Active Directory in the Synchronization Service Manager UI.
- Fixed accessibility of custom UI controls in the Synchronization Service Manager.
- Enabled six federation management tasks for all sign-in methods in Microsoft Entra Connect. (Previously, only the "Update AD FS TLS/SSL certificate" task was available for all sign-ins.)
- Added a warning when changing the sign-in method from federation to PHS or PTA that all Microsoft Entra domains and users will be converted to managed authentication.
- Removed token-signing certificates from the "Reset Microsoft Entra ID and AD FS trust" task and added a separate sub-task to update these certificates.
- Added a new federation management task called "Manage certificates" which has sub-tasks to update the TLS or token-signing certificates for the AD FS farm.
- Added a new federation management sub-task called "Specify primary server" which allows administrators to specify a new primary server for the AD FS farm.
- Added a new federation management task called "Manage servers" which has sub-tasks to deploy an AD FS server, deploy a Web Application Proxy server, and specify primary server.
- Added a new federation management task called "View federation configuration" that displays the current AD FS settings. (Because of this addition, AD FS settings have been removed from the "Review your solution" page.)

### Fixed issues
- Resolved sync error issue for the scenario where a user object taking over its corresponding contact object has a self-reference (e.g. user is their own manager).
- Help pop-ups now show on keyboard focus.
- For Auto upgrade, if any conflicting app is running from 6 hours, kill it and continue with upgrade.
- Limit the number of attributes a customer can select to 100 per object when selecting directory extensions. This limit will prevent the error from occurring during export as Azure has a maximum of 100 extension attributes per object.
- Fixed a bug to make the AD Connectivity script more robust.
- Fixed a bug to make Microsoft Entra Connect install on a machine using an existing Named Pipes WCF service more robust.
- Improved diagnostics and troubleshooting around group policies that don't allow the ADSync service to start when initially installed.
- Fixed a bug where display name for a Windows computer was written incorrectly.
- Fix a bug where OS type for a Windows computer was written incorrectly.
- Fixed a bug where non-Windows 10 computers were syncing unexpectedly. Note that the effect of this change is that non-Windows-10 computers that were previously synced will now be deleted. This doesn't affect any features as the sync of Windows computers is only used for Hybrid Microsoft Entra domain join, which only works for Windows-10 devices.
- Added several new (internal) cmdlets to the ADSync PowerShell module.

## 1.3.21.0
>[!IMPORTANT]
>There's a known issue with upgrading Microsoft Entra Connect from an earlier version to 1.3.21.0 where the Microsoft 365 portal doesn't reflect the updated version even though Microsoft Entra Connect upgraded successfully.
>
> To resolve this issue, you need to import the **AdSync** module and then run the `Set-ADSyncDirSyncConfiguration` PowerShell cmdlet on the Microsoft Entra Connect server. You can use the following steps:
>
>1.  Open PowerShell in administrator mode.
>2.  Run `Import-Module "ADSync"`.
>3.  Run `Set-ADSyncDirSyncConfiguration -AnchorAttribute ""`.
 
### Release status 

05/14/2019: Released for download

### Fixed issues 

- Fixed an elevation of privilege vulnerability that exists in Microsoft Entra Connect build 1.3.20.0. This vulnerability, under certain conditions, may allow an attacker to execute two PowerShell cmdlets in the context of a privileged account, and perform privileged actions. This security update addresses the issue by disabling these cmdlets. For more information, see [security update](https://portal.msrc.microsoft.com/security-guidance/advisory/CVE-2019-1000).


## 1.3.20.0 

### Release status 

04/24/2019: Released for download

### New features and improvements 

- Add support for Domain Refresh 
- Exchange Mail Public Folders feature goes GA 
- Improve wizard error handling for service failures 
- Added warning link on Synchronization Service Manager UI in the connector properties page. 
- The Unified Groups Writeback feature is now GA 
- Improved SSPR error message when the DC is missing an LDAP control 
- Added diagnostics for DCOM registry errors during install 
- Improved tracing of PHS RPC errors 
- Allow EA creds from a child domain 
- Allow database name to be entered during install (default name ADSync)
- Upgrade to ADAL 3.19.8 to pick up a WS-Trust fix for Ping and add support for new Azure instances 
- Modify Group Sync Rules to flow samAccountName, DomainNetbios and DomainFQDN to cloud - needed for claims 
- Modified Default Sync Rule Handling – read more [here](how-to-connect-fix-default-rules.md).
- Added a new agent running as a Windows service. This agent, named “Admin Agent”, enables deeper remote diagnostics of the Microsoft Entra Connect server to help Microsoft Engineers troubleshoot when you open a support case. This agent isn't installed and enabled by default. For more information on how to install and enable the agent, see [What is the Microsoft Entra Connect Admin Agent?](whatis-aadc-admin-agent.md). 
- Updated the End User License Agreement (EULA) 
- Added auto upgrade support for deployments that use AD FS as their login type. This also removed the requirement of updating the AD FS Microsoft Entra ID Relying Party Trust as part of the upgrade process. 
- Added a Microsoft Entra ID trust management task that provides two options: analyze/update trust and reset trust. 
- Changed the AD FS Microsoft Entra ID Relying Party trust behavior so that it always uses the -SupportMultipleDomain switch (includes trust and Microsoft Entra domain updates). 
- Changed the install new AD FS farm behavior so that it requires a .pfx certificate by removing the option of using a pre-installed certificate.
- Updated the install new AD FS farm workflow so that it only allows deploying 1 AD FS and 1 WAP server. All additional servers will be done after initial installation. 

### Fixed issues 

- Fix the SQL reconnect logic for ADSync service 
- Fix to allow clean Install using an empty SQL AOA DB 
- Fix PowerShell Permissions script to refine GWB permissions 
- Fix VSS Errors with LocalDB 
- Fix misleading error message when object type isn't in scope 
- Corrected an issue where installation of Microsoft Graph PowerShell on a server could potentially cause an assembly conflict with Microsoft Entra Connect. 
- Fixed PHS bug on Staging Server when Connector Credentials are updated in the Synchronization Service Manager UI. 
- Fixed some memory leaks 
- Miscellaneous Autoupgrade fixes 
- Miscellaneous fixes to Export and Unconfirmed Import Processing 
- Fixed a bug with handling a backslash in Domain and OU filtering 
- Fixed an issue where ADSync service takes more than 2 minutes to stop and causes a problem at upgrade time. 




## 1.2.70.0

### Release status

12/18/2018: Released for download

### Fixed issues

This build updates the non-standard connectors (for example, Generic LDAP Connector and Generic SQL Connector) shipped with Microsoft Entra Connect. For more information on applicable connectors, see version 1.1.911.0 in [Connector Version Release History](/microsoft-identity-manager/reference/microsoft-identity-manager-2016-connector-version-history).


## 1.2.69.0

### Release status
12/11/2018: Released for download

### Fixed issues
This hotfix build allows the user to select a target domain, within the specified forest, for the RegisteredDevices container when enabling device writeback. In the previous versions that contain the new Device Options functionality (1.1.819.0 – 1.2.68.0), the RegisteredDevices container location was limited to the forest root and didn't allow child domains. This limitation only manifested itself on new deployments – in-place upgrades were unaffected. 

If any build containing the updated Device Options functionality was deployed to a new server and device writeback was enabled, you'll need to manually specify the location of the container if you don't want it in the forest root. To do this, you need to disable device writeback and re-enable it which will allow you to specify the container location on the “Writeback forest” page.



## 1.2.68.0

### Release status 

11/30/2018: Released for download

### Fixed issues

This hotfix build fixes a conflict where an authentication error might occur due to the independent presence of the Microsoft Graph PowerShell Gallery module on the synchronization server.



## 1.2.67.0

### Release status 

11/19/2018: Released for download

### Fixed issues

This hotfix build fixes a regression in the previous build where Password Writeback fails when using an ADDS Domain Controller on Windows Server 2008/R2.

## 1.2.65.0 

### Release status 

10/25/2018: Released for download


### New features and improvements 


- Changed the functionality of attribute write-back to ensure hosted voice-mail is working as expected. Under certain scenarios, Microsoft Entra ID was overwriting the msExchUcVoicemailSettings attribute during write-back with a null value. Microsoft Entra ID will now no longer clear the on-premises value of this attribute if the cloud value isn't set.
- Added diagnostics in the Microsoft Entra Connect wizard to investigate and identify Connectivity issues to Microsoft Entra ID. These same diagnostics can also be run directly through PowerShell using the Test- AdSyncAzureServiceConnectivity Cmdlet. 
- Added diagnostics in the Microsoft Entra Connect wizard to investigate and identify Connectivity issues to AD. These same diagnostics can also be run directly through PowerShell using the Start-ConnectivityValidation function in the ADConnectivityTools PowerShell module. For more information, see [What is the ADConnectivityTool PowerShell Module?](how-to-connect-adconnectivitytools.md)
- Added an AD schema version pre-check for Microsoft Entra hybrid join and device write-back 
- Changed the Directory Extension page attribute search to be non-case sensitive.
-	Added full support for TLS 1.2. This release supports all other protocols being disabled and only TLS 1.2 being enabled on the machine where Microsoft Entra Connect is installed. For more information, see [TLS 1.2 enforcement for Microsoft Entra Connect](reference-connect-tls-enforcement.md)



### Fixed issues  

- Fixed a bug where Microsoft Entra Connect Upgrade would fail if SQL Always On was being used. 
- Fixed a bug to correctly parse OU names that contain a forward slash. 
- Fixed an issue where Pass-Through Authentication would be disabled for a clean install in staging mode. 
- Fixed a bug that prevented the PowerShell module to be loaded when running the Troubleshooting tools 
- Fixed a bug that would block customers from using numeric values in the first character of a host name. 
- Fixed a bug where Microsoft Entra Connect would allow invalid partitions and container selection 
- Fixed the “Invalid Password” error message when Desktop SSO is enabled. 
- Various Bug fixes for AD FS Trust Management 
- When configuring Device Writeback - fixed the schema check to look for the msDs-DeviceContainer object class (introduced on WS2012 R2)


## 1.1.882.0 

9/7/2018: Released for download, won't be released for auto upgrade 

### Fixed issues 

Microsoft Entra Connect Upgrade fails if SQL Always On Availability is configured for the ADSync DB. This hotfix addresses this issue and allows Upgrade to succeed. 

## 1.1.880.0

### Release status

8/21/2018: Released for download and auto upgrade. 

### New features and improvements

- The Ping Federate integration in Microsoft Entra Connect is now available for General Availability. [Learn more about how to federated Microsoft Entra ID with Ping Federate](./plan-connect-user-signin.md#federation-with-pingfederate)
- Microsoft Entra Connect now creates the backup of Microsoft Entra ID trust in AD FS every time an update is made and stores it in a separate file for easy restore if required. [Learn more about the new functionality and Microsoft Entra ID trust management in Microsoft Entra Connect](./how-to-connect-azure-ad-trust.md).
- New troubleshooting tooling helps troubleshoot changing primary email address and hiding account from global address list
- Microsoft Entra Connect was updated to include the latest SQL Server 2012 Native Client
- When you switch user sign-in to Password Hash Synchronization or Pass-through Authentication in the "Change user sign-in" task, the Seamless single sign-on checkbox is enabled by default.
- Added support for Windows Server Essentials 2019
- The Microsoft Entra Connect Health agent was updated to the latest version 3.1.7.0
- During an upgrade, if the installer detects changes to the default sync rules, the admin is prompted with a warning before overwriting the modified rules. This will allow the user to take corrective actions and resume later. Old Behavior: If there was any modified out-of-box rule then manual upgrade was overwriting those rules without giving any warning to the user and sync scheduler was disabled without informing user. New Behavior: User will be prompted with warning before overwriting the modified out-of-box sync rules. User will have choice to stop the upgrade process and resume later after taking corrective action.
- Provide a better handling of a FIPS compliance issue, providing an error message for MD5 hash generation in a FIPS compliant environment and a link to documentation that provides a  work-around for this issue.
- UI update to improve federation tasks in the wizard, which are now under a separate sub group for federation. 
- All federation additional tasks are now grouped under a single sub-menu for ease of use.
- A new revamped ADSyncConfig Posh Module (AdSyncConfig.psm1) with new AD Permissions functions moved from the old ADSyncPrep.psm1 (which may be deprecated shortly)

### Fixed issues 

- Fixed a bug where the Microsoft Entra Connect server would show high CPU usage after upgrading to .NET 4.7.2
- Fixed a bug that would intermittently produce an error message for an auto-resolved SQL deadlock issue
- Fixed several accessibility issues for the Sync Rules Editor and the Sync Service Manager 
- Fixed a bug where Microsoft Entra Connect can't get registry setting information
- Fixed a bug that created issues when the user goes forward/back in the wizard
- Fixed a bug to prevent an error happening due to incorrect multi-thread handing in the wizard
- When Group Sync Filtering page encounters an LDAP error when resolving security groups, Microsoft Entra Connect now returns the exception with full fidelity. The root cause for the referral exception is still unknown and will be addressed by a different bug.
- Fixed a bug where permissions for STK and NGC keys (ms-DS-KeyCredentialLink attribute on User/Device objects for WHfB) weren't correctly set.   
- Fixed a bug where 'Set-ADSyncRestrictedPermissions’ wasn't called correctly
- Adding support for permission granting on Group Writeback in the Microsoft Entra Connect installation wizard
- When changing the sign in method from Password Hash Sync to AD FS, Password Hash Sync wasn't disabled.
- Added verification for IPv6 addresses in AD FS configuration
- Updated the notification message to inform that an existing configuration exists.
- Device writeback fails to detect container in untrusted forest. This has been updated to provide a better error message and a link to the appropriate documentation
- Deselecting an OU and then synchronization/writeback corresponding to that OU gives a generic sync error. This has been changed to create a more understandable error message.

## 1.1.819.0

### Release status

5/14/2018: Released for auto upgrade and download.

### New features and improvements

New features and improvements

- This release includes the public preview of the integration of PingFederate in Microsoft Entra Connect. With this release, customers can easily, and reliably configure their Microsoft Entra environment to leverage PingFederate as their federation provider. To learn more about how to use this new feature, please visit our [online documentation](plan-connect-user-signin.md#federation-with-pingfederate). 
- Updated the Microsoft Entra Connect Wizard Troubleshooting Utility, where it now analyzes more error scenario’s, such as Linked Mailboxes and AD Dynamic Groups. Read more about the troubleshooting utility [here](tshoot-connect-objectsync.md).
- Device Writeback configuration is now managed solely within the Microsoft Entra Connect Wizard.
- A new PowerShell Module called ADSyncTools.psm1 is added that can be used to troubleshoot SQL Connectivity issues and various other troubleshooting utilities. Read more about the ADSyncTools module [here](tshoot-connect-tshoot-sql-connectivity.md). 
- A new additional task “Configure device options” has been added. You can use the task to configure the following two operations: 
 - **Microsoft Entra hybrid join**: If your environment has an on-premises AD footprint and you also want benefit from the capabilities provided by Microsoft Entra ID, you can implement Microsoft Entra hybrid joined devices. These are devices that are both, joined to your on-premises Active Directory and your Microsoft Entra ID.
 - **Device writeback**: Device writeback is used to enable Conditional Access based on devices to AD FS (2012 R2 or higher) protected devices

  >[!NOTE] 
  > - The option to enable device writeback from Customize synchronization options will be greyed out. 
  > - The PowerShell module for ADPrep is deprecated with this release.


### Fixed issues 

- This release updates the SQL Server Express installation to SQL Server 2012 SP4, which, among others, provides fixes for several security vulnerabilities. Please see [here](https://support.microsoft.com/help/4018073/sql-server-2012-service-pack-4-release-information) for more information about SQL Server 2012 SP4.
- Sync Rule Processing: outbound Join sync rules with no Join Condition should be de-applied if the parent sync rule is no longer applicable
- Several accessibility fixes have been applied to the Synchronization Service Manager UI and the Sync Rules Editor
- Microsoft Entra Connect Wizard: Error creating AD Connector account when Microsoft Entra Connect is in a workgroup
- Microsoft Entra Connect Wizard: On the Microsoft Entra Sign-in page display the verification checkbox whenever there's any mismatch in AD domains and Microsoft Entra ID Verified domains
- Auto-upgrade PowerShell fix to set auto upgrade state correctly in certain cases after auto upgrade attempted.
- Microsoft Entra Connect Wizard: Updated telemetry to capture previously missing information
- Microsoft Entra Connect Wizard: The following changes have been made when you use the **Change user sign-in** task to switch from AD FS to Pass-through Authentication:
  - The Pass-through Authentication Agent is installed on the Microsoft Entra Connect server and the Pass-through Authentication feature is enabled, before we convert domain(s) from federated to managed.
  - Users are no longer converted from federated to managed. Only domain(s) are converted.
- Microsoft Entra Connect Wizard: AD FS Multi Domain Regex isn't correct when user UPN has ' special character Regex update to support special characters
- Microsoft Entra Connect Wizard: Remove spurious "Configure source anchor attribute" message when no change 
- Microsoft Entra Connect Wizard: AD FS support for the dual federation scenario
- Microsoft Entra Connect Wizard: AD FS Claims aren't updated for added domain when converting a managed domain to federated
- Microsoft Entra Connect Wizard: During detection of installed packages, we find stale Dirsync/Azure AD Sync/Azure AD Connect related products. We will now attempt to uninstall the stale products.
- Microsoft Entra Connect Wizard: Correct Error Message Mapping when installation of passthrough authentication agent fails
- Microsoft Entra Connect Wizard: Removed "Configuration" container from Domain OU Filtering page
- Sync Engine install: remove unnecessary legacy logic that occasionally failed from Sync Engine install msi
- Microsoft Entra Connect Wizard: Fix pop-up help text on Optional Features page for Password Hash Sync
- Sync Engine runtime: Fix the scenario where a CS object has an imported delete and Sync Rules attempt to re-provision the object.
- Sync Engine runtime: Add help link for Online connectivity troubleshooting guide to the event log for an Import Error
- Sync Engine runtime: Reduced memory usage of Sync Scheduler when enumerating Connectors
- Microsoft Entra Connect Wizard: Fix an issue resolving a custom Sync Service Account which has no AD Read privileges
- Microsoft Entra Connect Wizard: Improve logging of Domain and OU filtering selections
- Microsoft Entra Connect Wizard: AD FS Add default claims to federation trust created for MFA scenario
- Microsoft Entra Connect Wizard: AD FS Deploy WAP: Adding server fails to use new certificate
- Microsoft Entra Connect Wizard: DSSO exception when onPremCredentials aren't initialized for a domain 
- Preferentially flow the AD distinguishedName attribute from the Active User object.
- Fixed a cosmetic bug were the Precedence of the first OOB Sync Rule was set to 99 instead of 100



## 1.1.751.0
Status 4/12/2018: Released for download only

>[!NOTE]
>This release is a hotfix for Microsoft Entra Connect
<a name='azure-ad-connect-sync'></a>

### Microsoft Entra Connect Sync
#### Fixed issues
Corrected an issue were automatic Azure instance discovery for China tenants was occasionally failing. 

### AD FS Management
#### Fixed issues

There was a problem in the configuration retry logic that would result in an ArgumentException stating “an item with the same key has already been added.” This would cause all retry operations to fail.

## 1.1.750.0
Status 3/22/2018: Released for auto-upgrade and download.
>[!NOTE]
>When the upgrade to this new version completes, it will automatically trigger a full sync and full import for the Microsoft Entra connector and a full sync for the AD connector. Since this may take some time, depending on the size of your Microsoft Entra Connect environment, make sure that you have taken the necessary steps to support this or hold off on upgrading until you have found a convenient moment to do so.
>[!NOTE]
>“AutoUpgrade functionality was incorrectly disabled for some tenants who deployed builds later than 1.1.524.0. To ensure that your Microsoft Entra Connect instance is still eligible for AutoUpgrade, run the following PowerShell cmdlet:
“Set-ADSyncAutoUpgrade -AutoupGradeState Enabled”

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect
#### Fixed issues

* Set-ADSyncAutoUpgrade cmdlet would previously block Autoupgrade if auto-upgrade state is set to Suspended. This functionality has now changed so it doesn't block AutoUpgrade of future builds.
* Changed the **User Sign-in** page option "Password Synchronization" to "Password Hash Synchronization". Microsoft Entra Connect synchronizes password hashes, not passwords, so this aligns with what is actually occurring. For more information, see [Implement password hash synchronization with Microsoft Entra Connect Sync](how-to-connect-password-hash-synchronization.md)

## 1.1.749.0
Status: Released to select customers

>[!NOTE]
>When the upgrade to this new version completes, it will automatically trigger a full sync and full import for the Microsoft Entra connector and a full sync for the AD connector. Since this may take some time, depending on the size of your Microsoft Entra Connect environment, please make sure that you have taken the necessary steps to support this or hold off on upgrading until you have found a convenient moment to do so.
<a name='azure-ad-connect'></a>

### Microsoft Entra Connect
#### Fixed issues
* Fix timing window on background tasks for Partition Filtering page when switching to next page.

* Fixed a bug that caused Access violation during the ConfigDB custom action.

* Fixed a bug to recover from SQL connection timeout.

* Fixed a bug where certificates with SAN wildcards failed a prerequisite check.

* Fixed a bug which causes miiserver.exe to crash during a Microsoft Entra connector export.

* Fixed a bug which bad password attempt logged on DC when running the Microsoft Entra Connect wizard to change configuration.


#### New features and improvements

* Adding Privacy Settings for the General Data Protection Regulation (GDPR). For more information, see the article [here](reference-connect-user-privacy.md).

[!INCLUDE [Privacy](~/includes/azure-docs-pr/gdpr-intro-sentence.md)] 

* application telemetry - admin can switch this class of data on/off at will

* Microsoft Entra Health data - admin must visit the health portal to control their health settings.
  Once the service policy has been changed, the agents will read and enforce it.

* Added device write-back configuration actions and a progress bar for page initialization

* Improved General Diagnostics with HTML report and full data collection in a ZIP-Text / HTML Report

* Improved the reliability of auto upgrade and added additional telemetry to ensure the health of the server can be determined

* Restrict permissions available to privileged accounts on AD Connector account

 * For new installations, the wizard will restrict the permissions that privileged accounts have on the Microsoft Graph PowerShell account after creating the Microsoft Graph PowerShell account.

The changes will take care of following:
1. Express Installations
2. Custom Installations with Auto-Create account
3. Changed the installer so it doesn't require SA privilege on clean install of Microsoft Entra Connect

* Added a new utility to troubleshoot synchronization issues for a specific object. It's available under 'Troubleshoot Object Synchronization' option of Microsoft Entra Connect Wizard Troubleshoot Additional Task. Currently, the utility checks for the following:

 * UserPrincipalName mismatch between synchronized user object and the user account in Microsoft Entra tenant.
 * If the object is filtered from synchronization due to domain filtering
 * If the object is filtered from synchronization due to organizational unit (OU) filtering

* Added a new utility to synchronize the current password hash stored in the on-premises Active Directory for a specific user account.

The utility doesn't require a password change. It's available under 'Troubleshoot Password Hash Synchronization' option of Microsoft Entra Connect Wizard Troubleshoot Additional Task.






## 1.1.654.0
Status: December 12th, 2017

>[!NOTE]
>This release is a security related hotfix for Microsoft Entra Connect
<a name='azure-ad-connect'></a>

### Microsoft Entra Connect
An improvement has been added to Microsoft Entra Connect version 1.1.654.0 (and after) to ensure that the recommended permission changes described under section [Lock down access to the AD DS account](#lock) are automatically applied when Microsoft Entra Connect creates the AD DS account. 

- When setting up Microsoft Entra Connect, the installing administrator can either provide an existing AD DS account, or let Microsoft Entra Connect automatically create the account. The permission changes are automatically applied to the AD DS account that is created by Microsoft Entra Connect during setup. They aren't applied to existing AD DS account provided by the installing administrator.
- For customers who have upgraded from an older version of Microsoft Entra Connect to 1.1.654.0 (or after), the permission changes won't be retroactively applied to existing AD DS accounts created prior to the upgrade. They'll only be applied to new AD DS accounts created after the upgrade. This occurs when you're adding new AD forests to be synchronized to Microsoft Entra ID.

>[!NOTE]
>This release only removes the vulnerability for new installations of Microsoft Entra Connect where the service account is created by the installation process. For existing installations, or in cases where you provide the account yourself, you should ensure that this vulnerability doesn't exist.
#### <a name="lock"></a> Lock down access to the AD DS account
Lock down access to the AD DS account by implementing the following permission changes in the on-premises AD: 

*	Disable inheritance on the specified object
*	Remove all ACEs on the specific object, except ACEs specific to SELF. We want to keep the default permissions intact when it comes to SELF.
*	Assign these specific permissions:

Type   | Name             | Access        | Applies To
---------|-------------------------------|----------------------|--------------|
Allow  | SYSTEM            | Full Control     | This object |
Allow  | Enterprise Admins       | Full Control     | This object |
Allow  | Domain Admins         | Full Control     | This object |
Allow  | Administrators        | Full Control     | This object |
Allow  | Enterprise Domain Controllers | List Contents    | This object |
Allow  | Enterprise Domain Controllers | Read All Properties | This object |
Allow  | Enterprise Domain Controllers | Read Permissions   | This object |
Allow  | Authenticated Users      | List Contents    | This object |
Allow  | Authenticated Users      | Read All Properties | This object |
Allow  | Authenticated Users      | Read Permissions   | This object |

#### PowerShell script to tighten a pre-existing service account

To use the PowerShell script, to apply these settings, to a pre-existing AD DS account, (ether provided by your organization or created by a previous installation of Microsoft Entra Connect, please download the script from the provided link above.

##### Usage:

```powershell
Set-ADSyncRestrictedPermissions -ObjectDN <$ObjectDN> -Credential <$Credential>
```

Where 

**$ObjectDN** = The Active Directory account whose permissions need to be tightened.

**$Credential** = Administrator credential that has the necessary privileges to restrict the permissions on the $ObjectDN account. These privileges are typically held by the Enterprise or Domain administrator. Use the fully qualified domain name of the administrator account to avoid account lookup failures. Example: contoso.com\admin.

>[!NOTE] 
>$credential.UserName should be in FQDN\username format. Example: contoso.com\admin 
##### Example:

```powershell
Set-ADSyncRestrictedPermissions -ObjectDN "CN=TestAccount1,CN=Users,DC=bvtadwbackdc,DC=com" -Credential $credential 
```
### Was this vulnerability used to gain unauthorized access?

To see if this vulnerability was used to compromise your Microsoft Entra Connect configuration you should verify the last password reset date of the service account. If the timestamp in unexpected, further investigation, via the event log, for that password reset event, should be undertaken.

For more information, see [Microsoft Security Advisory 4056318](/security-updates/securityadvisories/2017/4056318)

## 1.1.649.0
Status: October 27 2017

>[!NOTE]
>This build isn't available to customers through the Microsoft Entra Connect Auto Upgrade feature.
<a name='azure-ad-connect'></a>

### Microsoft Entra Connect
#### Fixed issue
* Fixed a version compatibility issue between Microsoft Entra Connect and Microsoft Entra Connect Health Agent (for sync). This issue affects customers who are performing Microsoft Entra Connect in-place upgrade to version 1.1.647.0, but currently has Health Agent version 3.0.127.0. After the upgrade, the Health Agent can no longer send health data about Microsoft Entra Connect Synchronization Service to Microsoft Entra Health Service. With this fix, Health Agent version 3.0.129.0 is installed during Microsoft Entra Connect in-place upgrade. Health Agent version 3.0.129.0 doesn't have compatibility issue with Microsoft Entra Connect version 1.1.649.0.


## 1.1.647.0
Status: October 19 2017

> [!IMPORTANT]
> There's a known compatibility issue between Microsoft Entra Connect version 1.1.647.0 and Microsoft Entra Connect Health Agent (for sync) version 3.0.127.0. This issue prevents the Health Agent from sending health data about the Microsoft Entra Connect Synchronization Service (including object synchronization errors and run history data) to Microsoft Entra Health Service. Before manually upgrading your Microsoft Entra Connect deployment to version 1.1.647.0, please verify the current version of Microsoft Entra Connect Health Agent installed on your Microsoft Entra Connect server. You can do so by going to *Control Panel → Add Remove Programs* and look for application *Microsoft Entra Connect Health Agent for Sync*. If its version is 3.0.127.0, it's recommended that you wait for the next Microsoft Entra Connect version to be available before upgrade. If the Health Agent version isn't 3.0.127.0, it's fine to proceed with the manual, in-place upgrade. This issue doesn't affect swing upgrade or customers who are performing new installation of Microsoft Entra Connect.
>
>
<a name='azure-ad-connect'></a>

### Microsoft Entra Connect
#### Fixed issues
* Fixed an issue with the *Change user sign-in* task in Microsoft Entra Connect wizard:

 * The issue occurs when you have an existing Microsoft Entra Connect deployment with Password Synchronization **enabled**, and you're trying to set the user sign-in method as *Pass-through Authentication*. Before the change is applied, the wizard incorrectly shows the "*Disable Password Synchronization*" prompt. However, Password Synchronization remains enabled after the change is applied. With this fix, the wizard no longer shows the prompt.

 * By design, the wizard doesn't disable Password Synchronization when you update the user sign-in method using the *Change user sign-in* task. This is to avoid disruption to customers who want to keep Password Synchronization, even though they're enabling Pass-through Authentication or federation as their primary user sign-in method.

 * If you wish to disable Password Synchronization after updating the user sign-in method, you must execute the *Customize Synchronization Configuration* task in the wizard. When you navigate to the *Optional features* page, uncheck the *Password Synchronization* option.

 * Note that the same issue also occurs if you try to enable/disable Seamless single sign-on. Specifically, you have an existing Microsoft Entra Connect deployment with Password Synchronization enabled and the user sign-in method is already configured as *Pass-through Authentication*. Using the *Change user sign-in* task, you try to check/uncheck the *Enable Seamless single sign-on* option while the user sign-in method remains configured as "Pass-through Authentication". Before the change is applied, the wizard incorrectly shows the "*Disable Password Synchronization*" prompt. However, Password Synchronization remains enabled after the change is applied. With this fix, the wizard no longer shows the prompt.

* Fixed an issue with the *Change user sign-in* task in Microsoft Entra Connect wizard:

 * The issue occurs when you have an existing Microsoft Entra Connect deployment with Password Synchronization **disabled**, and you're trying to set the user sign-in method as *Pass-through Authentication*. When the change is applied, the wizard enables both Pass-through Authentication and Password Synchronization. With this fix, the wizard no longer enables Password Synchronization.

 * Previously, Password Synchronization was a pre-requisite for enabling Pass-through Authentication. When you set the user sign-in method as *Pass-through Authentication*, the wizard would enable both Pass-through Authentication and Password Synchronization. Recently, Password Synchronization was removed as a pre-requisite. As part of Microsoft Entra Connect version 1.1.557.0, a change was made to Microsoft Entra Connect to not enable Password Synchronization when you set the user sign-in method as *Pass-through Authentication*. However, the change was only applied to Microsoft Entra Connect installation. With this fix, the same change is also applied to the *Change user sign-in* task.

 * Note that the same issue also occurs if you try to enable/disable Seamless single sign-on. Specifically, you have an existing Microsoft Entra Connect deployment with Password Synchronization disabled and the user sign-in method is already configured as *Pass-through Authentication*. Using the *Change user sign-in* task, you try to check/uncheck the *Enable Seamless single sign-on* option while the user sign-in method remains configured as "Pass-through Authentication". When the change is applied, the wizard enables Password Synchronization. With this fix, the wizard no longer enables Password Synchronization. 

* Fixed an issue that caused Microsoft Entra Connect upgrade to fail with error "*Unable to upgrade the Synchronization Service*". Further, the Synchronization Service can no longer start with event error "*The service was unable to start because the version of the database is newer than the version of the binaries installed*". The issue occurs when the administrator performing the upgrade doesn't have sysadmin privilege to the SQL server that is being used by Microsoft Entra Connect. With this fix, Microsoft Entra Connect only requires the administrator to have db_owner privilege to the ADSync database during upgrade.

* Fixed a Microsoft Entra Connect Upgrade issue that affected customers who have enabled [Seamless single sign-on](./how-to-connect-sso.md). After Microsoft Entra Connect is upgraded, Seamless single sign-on incorrectly appears as disabled in Microsoft Entra Connect wizard, even though the feature remains enabled and fully functional. With this fix, the feature now appears correctly as enabled in the wizard.

* Fixed an issue that caused Microsoft Entra Connect wizard to always show the “*Configure Source Anchor*” prompt on the *Ready to Configure* page, even if no changes related to Source Anchor were made.

* When performing manual in-place upgrade of Microsoft Entra Connect, the customer is required to provide the Global Administrator credentials of the corresponding Microsoft Entra tenant. Previously, upgrade could proceed even though the Global Administrator's credentials belonged to a different Microsoft Entra tenant. While upgrade appears to complete successfully, certain configurations aren't correctly persisted with the upgrade. With this change, the wizard prevents the upgrade from proceeding if the credentials provided don't match the Microsoft Entra tenant.

* Removed redundant logic that unnecessarily restarted Microsoft Entra Connect Health service at the beginning of a manual upgrade.


#### New features and improvements
* Added logic to simplify the steps required to set up Microsoft Entra Connect with Microsoft Germany Cloud. Previously, you're required to update specific registry keys on the Microsoft Entra Connect server for it to work correctly with Microsoft Germany Cloud, as described in this article. Now, Microsoft Entra Connect can automatically detect if your tenant is in Microsoft Germany Cloud based on the Hybrid Identity Administrator credentials provided during setup.

<a name='azure-ad-connect-sync'></a>

### Microsoft Entra Connect Sync
> [!NOTE]
> Note: The Synchronization Service has a WMI interface that lets you develop your own custom scheduler. This interface is now deprecated and will be removed from future versions of Microsoft Entra Connect shipped after June 30, 2018. Customers who want to customize synchronization schedule should use the [built-in scheduler](./how-to-connect-sync-feature-scheduler.md).
#### Fixed issues
* When Microsoft Entra Connect wizard creates the AD Connector account required to synchronize changes from on-premises Active Directory, it doesn't correctly assign the account the permission required to read PublicFolder objects. This issue affects both Express installation and Custom installation. This change fixes the issue.

* Fixed an issue that caused the Microsoft Entra Connect Wizard troubleshooting page to not render correctly for administrators running from Windows Server 2016.

#### New features and improvements
* When troubleshooting Password Synchronization using the Microsoft Entra Connect wizard troubleshooting page, the troubleshooting page now returns domain-specific status.

* Previously, if you tried to enable Password Hash Synchronization, Microsoft Entra Connect doesn't verify whether the AD Connector account has required permissions to synchronize password hashes from on-premises AD. Now, Microsoft Entra Connect wizard will verify and warn you if the AD Connector account doesn't have sufficient permissions.

### AD FS Management
#### Fixed issue
* Fixed an issue related to the use of [ms-DS-ConsistencyGuid as Source Anchor](./plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor) feature. This issue affects customers who have configured *Federation with AD FS* as the user sign-in method. When you execute *Configure Source Anchor* task in the wizard, Microsoft Entra Connect switches to using *ms-DS-ConsistencyGuid as source attribute for immutableId. As part of this change, Microsoft Entra Connect attempts to update the claim rules for ImmutableId in AD FS. However, this step failed because Microsoft Entra Connect didn't have the administrator credentials required to configure AD FS. With this fix, Microsoft Entra Connect now prompts you to enter the administrator credentials for AD FS when you execute the *Configure Source Anchor* task.



## 1.1.614.0
Status: September 05 2017

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

#### Known issues
* There's a known issue that is causing Microsoft Entra Connect upgrade to fail with error "*Unable to upgrade the Synchronization Service*". Further, the Synchronization Service can no longer start with event error "*The service was unable to start because the version of the database is newer than the version of the binaries installed*". The issue occurs when the administrator performing the upgrade doesn't have sysadmin privilege to the SQL server that is being used by Microsoft Entra Connect. Dbo permissions aren't sufficient.

* There's a known issue with Microsoft Entra Connect Upgrade that is affecting customers who have enabled [Seamless single sign-on](how-to-connect-sso.md). After Microsoft Entra Connect is upgraded, the feature appears as disabled in the wizard, even though the feature remains enabled. A fix for this issue will be provided in future release. Customers who are concerned about this display issue can manually fix it by enabling Seamless single sign-on in the wizard.

#### Fixed issues
* Fixed an issue that prevented Microsoft Entra Connect from updating the claims rules in on-premises AD FS while enabling the [ms-DS-ConsistencyGuid as Source Anchor](./plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor) feature. The issue occurs if you try to enable the feature for an existing Microsoft Entra Connect deployment that has AD FS configured as the sign-in method. The issue occurs because the wizard doesn't prompt for ADFS credentials before trying to update the claims rules in AD FS.
* Fixed an issue that caused Microsoft Entra Connect to fail installation if the on-premises AD forest has NTLM disabled. The issue is due to Microsoft Entra Connect wizard not providing fully qualified credentials when creating the security contexts required for Kerberos authentication. This causes Kerberos authentication to fail and Microsoft Entra Connect wizard to fall back to using NTLM.

<a name='azure-ad-connect-sync'></a>

### Microsoft Entra Connect Sync
#### Fixed issues
* Fixed an issue where new synchronization rule can't be created if the Tag attribute isn’t populated.
* Fixed an issue that caused Microsoft Entra Connect to connect to on-premises AD for Password Synchronization using NTLM, even though Kerberos is available. This issue occurs if the on-premises AD topology has one or more domain controllers that were restored from a backup.
* Fixed an issue that caused full synchronization steps to occur unnecessarily after upgrade. In general, running full synchronization steps is required after upgrade if there are changes to out-of-box synchronization rules. The issue was due to an error in the change detection logic that incorrectly detected a change when encountering synchronization rule expression with newline characters. Newline characters are inserted into sync rule expression to improve readability.
* Fixed an issue that can cause the Microsoft Entra Connect server to not work correctly after Automatic Upgrade. This issue affects Microsoft Entra Connect servers with version 1.1.443.0 (or earlier). For details about the issue, refer to article [Microsoft Entra Connect isn't working correctly after an automatic upgrade](https://support.microsoft.com/help/4038479/azure-ad-connect-is-not-working-correctly-after-an-automatic-upgrade).
* Fixed an issue that can cause Automatic Upgrade to be retried every 5 minutes when errors are encountered. With the fix, Automatic Upgrade retries with exponential back-off when errors are encountered.
* Fixed an issue where password synchronization event 611 is incorrectly shown in Windows Application Event logs as **informational** instead of **error**. Event 611 is generated whenever password synchronization encounters an issue. 
* Fixed an issue in the Microsoft Entra Connect wizard that allows Group writeback feature to be enabled without selecting an OU required for Group writeback.

#### New features and improvements
* Added a Troubleshoot task to Microsoft Entra Connect wizard under Additional Tasks. Customers can leverage this task to troubleshoot issues related to password synchronization and collect general diagnostics. In the future, the Troubleshoot task will be extended to include other directory synchronization-related issues.
* Microsoft Entra Connect now supports a new installation mode called **Use Existing Database**. This installation mode allows customers to install Microsoft Entra Connect that specifies an existing ADSync database. For more information about this feature, refer to article [Use an existing database](how-to-connect-install-existing-database.md).
* For improved security, Microsoft Entra Connect now defaults to using TLS1.2 to connect to Microsoft Entra ID for directory synchronization. Previously, the default was TLS1.0.
* When Microsoft Entra Connect Password Synchronization Agent starts up, it tries to connect to Microsoft Entra well-known endpoint for password synchronization. Upon successful connection, it's redirected to a region-specific endpoint. Previously, the Password Synchronization Agent caches the region-specific endpoint until it's restarted. Now, the agent clears the cache and retries with the well-known endpoint if it encounters connection issue with the region-specific endpoint. This change ensures that password synchronization can failover to a different region-specific endpoint when the cached region-specific endpoint is no longer available.
* To synchronize changes from an on-premises AD forest, an AD DS account is required. You can either (i) create the AD DS account yourself and provide its credential to Microsoft Entra Connect, or (ii) provide an Enterprise Admin's credentials and let Microsoft Entra Connect create the AD DS account for you. Previously, (i) is the default option in the Microsoft Entra Connect wizard. Now, (ii) is the default option.

<a name='azure-ad-connect-health'></a>

### Microsoft Entra Connect Health

#### New features and improvements
* Added support for Microsoft Azure Government Cloud and Microsoft Cloud Germany.

### AD FS Management
#### Fixed issues
* The Initialize-ADSyncNGCKeysWriteBack cmdlet in the AD prep PowerShell module was incorrectly applying ACLs to the device registration container and would therefore only inherit existing permissions. This was updated so that the sync service account has the correct permissions.

#### New features and improvements
* The Microsoft Entra Connect Verify ADFS Login task was updated so that it verifies logins against Microsoft Online and not just token retrieval from ADFS.
* When setting up a new ADFS farm using Microsoft Entra Connect, the page asking for ADFS credentials was moved so that it now occurs before the user is asked to provide ADFS and WAP servers. This allows Microsoft Entra Connect to check that the account specified has the correct permissions.
* During Microsoft Entra Connect upgrade, we no longer fail an upgrade if the ADFS Microsoft Entra ID Trust fails to update. If that happens, the user will be shown an appropriate warning message and should proceed to reset the trust via the Microsoft Entra Connect additional task.

### Seamless single sign-on
#### Fixed issues
* Fixed an issue that caused Microsoft Entra Connect wizard to return an error if you try to enable [Seamless single sign-on](how-to-connect-sso.md). The error message is *“Configuration of Microsoft Entra Connect Authentication Agent failed.”* This issue affects existing customers who had manually upgraded the preview version of the Authentication Agents for [Pass-through Authentication](how-to-connect-sso.md) based on the steps described in this [article](how-to-connect-pta-upgrade-preview-authentication-agents.md).


## 1.1.561.0
Status: July 23 2017

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

#### Fixed issue

* Fixed an issue that caused the out-of-box synchronization rule “Out to AD - User ImmutableId” to be removed:

 * The issue occurs when Microsoft Entra Connect is upgraded, or when the task option *Update Synchronization Configuration* in the Microsoft Entra Connect wizard is used to update Microsoft Entra Connect synchronization configuration.

 * This synchronization rule is applicable to customers who have enabled the [ms-DS-ConsistencyGuid as Source Anchor feature](plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor). This feature was introduced in version 1.1.524.0 and after. When the synchronization rule is removed, Microsoft Entra Connect can no longer populate on-premises AD ms-DS-ConsistencyGuid attribute with the ObjectGuid attribute value. It doesn't prevent new users from being provisioned into Microsoft Entra ID.

 * The fix ensures that the synchronization rule will no longer be removed during upgrade, or during configuration change, as long as the feature is enabled. For existing customers who have been affected by this issue, the fix also ensures that the synchronization rule is added back after upgrading to this version of Microsoft Entra Connect.

* Fixed an issue that causes out-of-box synchronization rules to have precedence value that is less than 100:

 * In general, precedence values 0 - 99 are reserved for custom synchronization rules. During upgrade, the precedence values for out-of-box synchronization rules are updated to accommodate sync rule changes. Due to this issue, out-of-box synchronization rules may be assigned precedence value that is less than 100.

 * The fix prevents the issue from occurring during upgrade. However, it doesn't restore the precedence values for existing customers who have been affected by the issue. A separate fix will be provided in the future to help with the restoration.

* Fixed an issue where the [Domain and OU Filtering screen](how-to-connect-install-custom.md#domain-and-ou-filtering) in the Microsoft Entra Connect wizard is showing *Sync all domains and OUs* option as selected, even though OU-based filtering is enabled.

*	Fixed an issue that caused the [Configure Directory Partitions screen](how-to-connect-sync-configure-filtering.md#organizational-unitbased-filtering) in the Synchronization Service Manager to return an error if the *Refresh* button is clicked. The error message is *“An error was encountered while refreshing domains: Unable to cast object of type ‘System.Collections.ArrayList’ to type ‘Microsoft.DirectoryServices.MetadirectoryServices.UI.PropertySheetBase.MaPropertyPages.PartitionObject.”* The error occurs when new AD domain has been added to an existing AD forest and you're trying to update Microsoft Entra Connect using the Refresh button.

#### New features and improvements

* [Automatic Upgrade feature](how-to-connect-install-automatic-upgrade.md) has been expanded to support customers with the following configurations:
 * You have enabled the device writeback feature.
 * You have enabled the group writeback feature.
 * The installation isn't an Express settings or a DirSync upgrade.
 * You have more than 100,000 objects in the metaverse.
 * you're connecting to more than one forest. Express setup only connects to one forest.
 * The AD Connector account isn't the default Microsoft Graph PowerShell account anymore.
 * The server is set to be in staging mode.
 * You have enabled the user writeback feature.

 >[!NOTE]
 >The scope expansion of the Automatic Upgrade feature affects customers with Microsoft Entra Connect build 1.1.105.0 and after. If you don't want your Microsoft Entra Connect server to be automatically upgraded, you must run following cmdlet on your Microsoft Entra Connect server: `Set-ADSyncAutoUpgrade -AutoUpgradeState disabled`. For more information about enabling/disabling Automatic Upgrade, refer to article [Microsoft Entra Connect: Automatic upgrade](how-to-connect-install-automatic-upgrade.md).
## 1.1.558.0
Status: won't be released. Changes in this build are included in version 1.1.561.0.

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

#### Fixed issue

* Fixed an issue that caused the out-of-box synchronization rule “Out to AD - User ImmutableId” to be removed when OU-based filtering configuration is updated. This synchronization rule is required for the [ms-DS-ConsistencyGuid as Source Anchor feature](plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor).

* Fixed an issue where the [Domain and OU Filtering screen](how-to-connect-install-custom.md#domain-and-ou-filtering) in the Microsoft Entra Connect wizard is showing *Sync all domains and OUs* option as selected, even though OU-based filtering is enabled.

*	Fixed an issue that caused the [Configure Directory Partitions screen](how-to-connect-sync-configure-filtering.md#organizational-unitbased-filtering) in the Synchronization Service Manager to return an error if the *Refresh* button is clicked. The error message is *“An error was encountered while refreshing domains: Unable to cast object of type ‘System.Collections.ArrayList’ to type ‘Microsoft.DirectoryServices.MetadirectoryServices.UI.PropertySheetBase.MaPropertyPages.PartitionObject.”* The error occurs when new AD domain has been added to an existing AD forest and you're trying to update Microsoft Entra Connect using the Refresh button.

#### New features and improvements

* [Automatic Upgrade feature](how-to-connect-install-automatic-upgrade.md) has been expanded to support customers with the following configurations:
 * You have enabled the device writeback feature.
 * You have enabled the group writeback feature.
 * The installation isn't an Express settings or a DirSync upgrade.
 * You have more than 100,000 objects in the metaverse.
 * you're connecting to more than one forest. Express setup only connects to one forest.
 * The AD Connector account isn't the default Microsoft Graph PowerShell account anymore.
 * The server is set to be in staging mode.
 * You have enabled the user writeback feature.

 >[!NOTE]
 >The scope expansion of the Automatic Upgrade feature affects customers with Microsoft Entra Connect build 1.1.105.0 and after. If you don't want your Microsoft Entra Connect server to be automatically upgraded, you must run following cmdlet on your Microsoft Entra Connect server: `Set-ADSyncAutoUpgrade -AutoUpgradeState disabled`. For more information about enabling/disabling Automatic Upgrade, refer to article [Microsoft Entra Connect: Automatic upgrade](how-to-connect-install-automatic-upgrade.md).
## 1.1.557.0
Status: July 2017

>[!NOTE]
>This build isn't available to customers through the Microsoft Entra Connect Auto Upgrade feature.
<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

#### Fixed issue
* Fixed an issue with the Initialize-ADSyncDomainJoinedComputerSync cmdlet that caused the verified domain configured on the existing service connection point object to be changed even if it's still a valid domain. This issue occurs when your Microsoft Entra tenant has more than one verified domains that can be used for configuring the service connection point.

#### New features and improvements
* Password writeback is now available for preview with Microsoft Azure Government cloud and Microsoft Cloud Germany. For more information about Microsoft Entra Connect support for the different service instances, refer to article [Microsoft Entra Connect: Special considerations for instances](reference-connect-instances.md).

* The Initialize-ADSyncDomainJoinedComputerSync cmdlet now has a new optional parameter named AzureADDomain. This parameter lets you specify which verified domain to be used for configuring the service connection point.

### Pass-through Authentication

#### New features and improvements
* The name of the agent required for Pass-through Authentication has been changed from *Microsoft Entra private network connector* to *Microsoft Entra Connect Authentication Agent*.

* Enabling Pass-through Authentication no longer enables Password Hash Synchronization by default.


## 1.1.553.0
Status: June 2017

> [!IMPORTANT]
> There are schema and sync rule changes introduced in this build. Microsoft Entra Connect Synchronization Service will trigger Full Import and Full Synchronization steps after upgrade. Details of the changes are described below. To temporarily defer Full Import and Full Synchronization steps after upgrade, refer to article [How to defer full synchronization after upgrade](how-to-upgrade-previous-version.md#how-to-defer-full-synchronization-after-upgrade).
>
>
<a name='azure-ad-connect-sync'></a>

### Microsoft Entra Connect Sync

#### Known issue
* There's an issue that affects customers who are using [OU-based filtering](how-to-connect-sync-configure-filtering.md#organizational-unitbased-filtering) with Microsoft Entra Connect Sync. When you navigate to the [Domain and OU Filtering page](how-to-connect-install-custom.md#domain-and-ou-filtering) in the Microsoft Entra Connect wizard, the following behavior is expected:
 * If OU-based filtering is enabled, the **Sync selected domains and OUs** option is selected.
 * Otherwise, the **Sync all domains and OUs** option is selected.

The issue that arises is that the **Sync all domains and OUs option** is always selected when you run the Wizard. This occurs even if OU-based filtering was previously configured. Before saving any Microsoft Entra Connect configuration changes, make sure the **Sync selected domains and OUs option is selected** and confirm that all OUs that need to synchronize are enabled again. Otherwise, OU-based filtering will be disabled.

#### Fixed issues

* Fixed an issue with Password writeback that allows a Microsoft Entra Administrator to reset the password of an on-premises AD privileged user account. The issue occurs when Microsoft Entra Connect is granted the Reset Password permission over the privileged account. The issue is addressed in this version of Microsoft Entra Connect by not allowing a Microsoft Entra Administrator to reset the password of an arbitrary on-premises AD privileged user account unless the administrator is the owner of that account. For more information, refer to [Security Advisory 4033453](/security-updates/SecurityAdvisories/2017/4033453).

* Fixed an issue related to the [ms-DS-ConsistencyGuid as Source Anchor](./plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor) feature where Microsoft Entra Connect doesn't writeback to on-premises AD ms-DS-ConsistencyGuid attribute. The issue occurs when there are multiple on-premises AD forests added to Microsoft Entra Connect and the *User identities exist across multiple directories option* is selected. When such configuration is used, the resultant synchronization rules don't populate the sourceAnchorBinary attribute in the Metaverse. The sourceAnchorBinary attribute is used as the source attribute for ms-DS-ConsistencyGuid attribute. As a result, writeback to the ms-DSConsistencyGuid attribute doesn't occur. To fix the issue, following sync rules have been updated to ensure that the sourceAnchorBinary attribute in the Metaverse is always populated:
 * In from AD - InetOrgPerson AccountEnabled.xml
 * In from AD - InetOrgPerson Common.xml
 * In from AD - User AccountEnabled.xml
 * In from AD - User Common.xml
 * In from AD - User Join SOAInAAD.xml

* Previously, even if the [ms-DS-ConsistencyGuid as Source Anchor](./plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor) feature isn’t enabled, the “Out to AD – User ImmutableId” synchronization rule is still added to Microsoft Entra Connect. The effect is benign and doesn't cause writeback of ms-DS-ConsistencyGuid attribute to occur. To avoid confusion, logic has been added to ensure that the sync rule is only added when the feature is enabled.

* Fixed an issue that caused password hash synchronization to fail with error event 611. This issue occurs after one or more domain controllers have been removed from on-premises AD. At the end of each password synchronization cycle, the synchronization cookie issued by on-premises AD contains Invocation IDs of the removed domain controllers with USN (Update Sequence Number) value of 0. The Password Synchronization Manager is unable to persist synchronization cookie containing USN value of 0 and fails with error event 611. During the next synchronization cycle, the Password Synchronization Manager reuses the last persisted synchronization cookie that doesn't contain USN value of 0. This causes the same password changes to be resynchronized. With this fix, the Password Synchronization Manager persists the synchronization cookie correctly.

* Previously, even if Automatic Upgrade has been disabled using the Set-ADSyncAutoUpgrade cmdlet, the Automatic Upgrade process continues to check for upgrade periodically, and relies on the downloaded installer to honor disablement. With this fix, the Automatic Upgrade process no longer checks for upgrade periodically. The fix is automatically applied when upgrade installer for this Microsoft Entra Connect version is executed once.

#### New features and improvements

* Previously, the [ms-DS-ConsistencyGuid as Source Anchor](./plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor) feature was available to new deployments only. Now, it's available to existing deployments. More specifically:
 * To access the feature, start the Microsoft Entra Connect wizard and choose the *Update Source Anchor* option.
 * This option is only visible to existing deployments that are using objectGuid as sourceAnchor attribute.
 * When configuring the option, the wizard validates the state of the ms-DS-ConsistencyGuid attribute in your on-premises Active Directory. If the attribute isn't configured on any user object in the directory, the wizard uses the ms-DS-ConsistencyGuid as the sourceAnchor attribute. If the attribute is configured on one or more user objects in the directory, the wizard concludes the attribute is being used by other applications and isn't suitable as sourceAnchor attribute and doesn't permit the Source Anchor change to proceed. If you're certain that the attribute isn't used by existing applications, you need to contact Support for information on how to suppress the error.

* Specific to **userCertificate** attribute on Device objects, Microsoft Entra Connect now looks for certificates values required for [Connecting domain-joined devices to Microsoft Entra ID for Windows 10 experience](~/identity/devices/hybrid-join-plan.md) and filters out the rest before synchronizing to Microsoft Entra ID. To enable this behavior, the out-of-box sync rule “Out to Microsoft Entra ID - Device Join SOAInAD” has been updated.

* Microsoft Entra Connect now supports writeback of Exchange Online **cloudPublicDelegates** attribute to on-premises AD **publicDelegates** attribute. This enables the scenario where an Exchange Online mailbox can be granted SendOnBehalfTo rights to users with on-premises Exchange mailbox. To support this feature, a new out-of-box sync rule “Out to AD – User Exchange Hybrid PublicDelegates writeback” has been added. This sync rule is only added to Microsoft Entra Connect when Exchange Hybrid feature is enabled.

* Microsoft Entra Connect now supports synchronizing the **altRecipient** attribute from Microsoft Entra ID. To support this change, following out-of-box sync rules have been updated to include the required attribute flow:
 * In from AD – User Exchange
 * Out to Microsoft Entra ID – User ExchangeOnline

* The **cloudSOAExchMailbox** attribute in the Metaverse indicates whether a given user has Exchange Online mailbox or not. Its definition has been updated to include additional Exchange Online RecipientDisplayTypes as such Equipment and Conference Room mailboxes. To enable this change, the definition of the cloudSOAExchMailbox attribute, which is found under out-of-box sync rule “In from Microsoft Entra ID – User Exchange Hybrid”, has been updated from:

  ```
  CBool(IIF(IsNullOrEmpty([cloudMSExchRecipientDisplayType]),NULL,BitAnd([cloudMSExchRecipientDisplayType],&amp;HFF) = 0))
  ```

  ... to the following:

  ```
  CBool(
   IIF(IsPresent([cloudMSExchRecipientDisplayType]),(
    IIF([cloudMSExchRecipientDisplayType]=0,True,(
     IIF([cloudMSExchRecipientDisplayType]=2,True,(
      IIF([cloudMSExchRecipientDisplayType]=7,True,(
       IIF([cloudMSExchRecipientDisplayType]=8,True,(
        IIF([cloudMSExchRecipientDisplayType]=10,True,(
         IIF([cloudMSExchRecipientDisplayType]=16,True,(
          IIF([cloudMSExchRecipientDisplayType]=17,True,(
           IIF([cloudMSExchRecipientDisplayType]=18,True,(
            IIF([cloudMSExchRecipientDisplayType]=1073741824,True,(
             IF([cloudMSExchRecipientDisplayType]=1073741840,True,False)))))))))))))))))))),False))
  ```

* Added the following set of X509Certificate2-compatible functions for creating synchronization rule expressions to handle certificate values in the userCertificate attribute:
 * CertSubject 
 * CertIssuer
 * CertKeyAlgorithm
 * CertSubjectNameDN
 * CertIssuerOid
 * CertNameInfo
 * CertSubjectNameOid
 * CertIssuerDN
 * IsCert
 * CertFriendlyName
 * CertThumbprint
 * CertExtensionOids
 * CertFormat
 * CertNotAfter
 * CertPublicKeyOid 
 * CertSerialNumber
 * CertNotBefore
 * CertPublicKeyParametersOid
 * CertVersion
 * CertSignatureAlgorithmOid
 * Select
 * CertKeyAlgorithmParams
 * CertHashString
 * Where
 * With

* Following schema changes have been introduced to allow customers to create custom synchronization rules to flow sAMAccountName, domainNetBios, and domainFQDN for Group objects, as well as distinguishedName for User objects:

 * Following attributes have been added to MV schema:
  * Group: AccountName
  * Group: domainNetBios
  * Group: domainFQDN
  * Person: distinguishedName

 * Following attributes have been added to Microsoft Entra Connector schema:
  * Group: OnPremisesSamAccountName
  * Group: NetBiosName
  * Group: DnsDomainName
  * User: OnPremisesDistinguishedName

* The ADSyncDomainJoinedComputerSync cmdlet script now has a new optional parameter named AzureEnvironment. The parameter is used to specify which region the corresponding Microsoft Entra tenant is hosted in. Valid values include:
 * AzureCloud (default)
 * AzureChinaCloud
 * AzureGermanyCloud
 * USGovernment

* Updated Sync Rule Editor to use Join (instead of Provision) as the default value of link type during sync rule creation.

### AD FS management

#### Issues fixed

* Following URLs are new WS-Federation endpoints introduced by Microsoft Entra ID to improve resiliency against authentication outage and will be added to on-premises AD FS replying party trust configuration:
 * https:\//ests.login.microsoftonline.com/login.srf
 * https:\//stamp2.login.microsoftonline.com/login.srf
 * https://ccs.login.microsoftonline.com/login.srf


* Fixed an issue that caused AD FS to generate incorrect claim value for IssuerID. The issue occurs if there are multiple verified domains in the Microsoft Entra tenant and the domain suffix of the userPrincipalName attribute used to generate the IssuerID claim is at least 3-levels deep (for example, johndoe@us.contoso.com). The issue is resolved by updating the regex used by the claim rules.

#### New features and improvements
* Previously, the ADFS Certificate Management feature provided by Microsoft Entra Connect can only be used with ADFS farms managed through Microsoft Entra Connect. Now, you can use the feature with ADFS farms that aren't managed using Microsoft Entra Connect.

## 1.1.524.0
Released: May 2017

> [!IMPORTANT]
> There are schema and sync rule changes introduced in this build. Microsoft Entra Connect Synchronization Service will trigger Full Import and Full Sync steps after upgrade. Details of the changes are described below.
>
>
**Fixed issues:**

Microsoft Entra Connect Sync

* Fixed an issue that causes Automatic Upgrade to occur on the Microsoft Entra Connect server even if customer has disabled the feature using the Set-ADSyncAutoUpgrade cmdlet. With this fix, the Automatic Upgrade process on the server still checks for upgrade periodically, but the downloaded installer honors the Automatic Upgrade configuration.
* During DirSync in-place upgrade, Microsoft Entra Connect creates a Microsoft Entra service account to be used by the Microsoft Entra connector for synchronizing with Microsoft Entra ID. After the account is created, Microsoft Entra Connect authenticates with Microsoft Entra ID using the account. Sometimes, authentication fails because of transient issues, which in turn causes DirSync in-place upgrade to fail with error *“An error has occurred executing Configure Azure AD Sync task: AADSTS50034: To sign into this application, the account must be added to the xxx.onmicrosoft.com directory.”* To improve the resiliency of DirSync upgrade, Microsoft Entra Connect now retries the authentication step.
* There was an issue with build 443 that causes DirSync in-place upgrade to succeed but run profiles required for directory synchronization aren't created. Healing logic is included in this build of Microsoft Entra Connect. When customer upgrades to this build, Microsoft Entra Connect detects missing run profiles and creates them.
* Fixed an issue that causes Password Synchronization process to fail to start with Event ID 6900 and error *“An item with the same key has already been added”*. This issue occurs if you update OU filtering configuration to include AD configuration partition. To fix this issue, Password Synchronization process now synchronizes password changes from AD domain partitions only. Non-domain partitions such as configuration partition are skipped.
* During Express installation, Microsoft Entra Connect creates an on-premises AD DS account to be used by the AD connector to communicate with on-premises AD. Previously, the account is created with the PASSWD_NOTREQD flag set on the user-Account-Control attribute and a random password is set on the account. Now, Microsoft Entra Connect explicitly removes the PASSWD_NOTREQD flag after the password is set on the account.
* Fixed an issue that causes DirSync upgrade to fail with error *“a deadlock occurred in sql server which trying to acquire an application lock”* when the mailNickname attribute is found in the on-premises AD schema, but isn't bounded to the AD User object class.
* Fixed an issue that causes Device writeback feature to automatically be disabled when an administrator is updating Microsoft Entra Connect Sync configuration using Microsoft Entra Connect wizard. This issue is caused by the wizard performing a pre-requisite check for the existing Device writeback configuration in on-premises AD and the check fails. The fix is to skip the check if Device writeback is already enabled previously.
* To configure OU filtering, you can either use the Microsoft Entra Connect wizard or the Synchronization Service Manager. Previously, if you use the Microsoft Entra Connect wizard to configure OU filtering, new OUs created afterwards are included for directory synchronization. If you don't want new OUs to be included, you must configure OU filtering using the Synchronization Service Manager. Now, you can achieve the same behavior using Microsoft Entra Connect wizard.
* Fixed an issue that causes stored procedures required by Microsoft Entra Connect to be created under the schema of the installing admin, instead of under the dbo schema.
* Fixed an issue that causes the TrackingId attribute returned by Microsoft Entra ID to be omitted in the Microsoft Entra Connect Server Event Logs. The issue occurs if Microsoft Entra Connect receives a redirection message from Microsoft Entra ID and Microsoft Entra Connect is unable to connect to the endpoint provided. The TrackingId is used by Support Engineers to correlate with service side logs during troubleshooting.
* When Microsoft Entra Connect receives LargeObject error from Microsoft Entra ID, Microsoft Entra Connect generates an event with EventID 6941 and message *“The provisioned object is too large. Trim the number of attribute values on this object.”* At the same time, Microsoft Entra Connect also generates a misleading event with EventID 6900 and message *“Microsoft.Online.Coexistence.ProvisionRetryException: Unable to communicate with the Windows Azure Active Directory service.”* To minimize confusion, Microsoft Entra Connect no longer generates the latter event when LargeObject error is received.
* Fixed an issue that causes the Synchronization Service Manager to become unresponsive when trying to update the configuration for Generic LDAP connector.

**New features/improvements:**

Microsoft Entra Connect Sync
* Sync Rule Changes – The following sync rule changes have been implemented:
 * Updated default sync rule set to not export attributes **userCertificate** and **userSMIMECertificate** if the attributes have more than 15 values.
 * AD attributes **employeeID** and **msExchBypassModerationLink** are now included in the default sync rule set.
 * AD attribute **photo** has been removed from default sync rule set.
 * Added **preferredDataLocation** to the Metaverse schema and Microsoft Entra Connector schema. Customers who want to update either attributes in Microsoft Entra ID can implement custom sync rules to do so. 
 * Added **userType** to the Metaverse schema and Microsoft Entra Connector schema. Customers who want to update either attributes in Microsoft Entra ID can implement custom sync rules to do so.

* Microsoft Entra Connect now automatically enables the use of ConsistencyGuid attribute as the Source Anchor attribute for on-premises AD objects. Further, Microsoft Entra Connect populates the ConsistencyGuid attribute with the objectGuid attribute value if it's empty. This feature is applicable to new deployment only. To find out more about this feature, refer to article section [Microsoft Entra Connect: Design concepts - Using ms-DS-ConsistencyGuid as sourceAnchor](plan-connect-design-concepts.md#using-ms-ds-consistencyguid-as-sourceanchor).
* New troubleshooting cmdlet Invoke-ADSyncDiagnostics has been added to help diagnose Password Hash Synchronization related issues. For information about using the cmdlet, refer to article [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](tshoot-connect-password-hash-synchronization.md).
* Microsoft Entra Connect now supports synchronizing Mail-Enabled Public Folder objects from on-premises AD to Microsoft Entra ID. You can enable the feature using Microsoft Entra Connect wizard under Optional Features. To find out more about this feature, refer to article [Office 365 Directory Based Edge Blocking support for on-premises Mail Enabled Public Folders](https://techcommunity.microsoft.com/t5/exchange/office-365-directory-based-edge-blocking-support-for-on-premises/m-p/74218).
* Microsoft Entra Connect requires an AD DS account to synchronize from on-premises AD. Previously, if you installed Microsoft Entra Connect using the Express mode, you could provide the credentials of an Enterprise Admin account and Microsoft Entra Connect would create the AD DS account required. However, for a custom installation and adding forests to an existing deployment, you were required to provide the AD DS account instead. Now, you also have the option to provide the credentials of an Enterprise Admin account during a custom installation and let Microsoft Entra Connect create the AD DS account required.
* Microsoft Entra Connect now supports SQL AOA. You must enable SQL AOA before installing Microsoft Entra Connect. During installation, Microsoft Entra Connect detects whether the SQL instance provided is enabled for SQL AOA or not. If SQL AOA is enabled, Microsoft Entra Connect further figures out if SQL AOA is configured to use synchronous replication or asynchronous replication. When setting up the Availability Group Listener, it's recommended that you set the RegisterAllProvidersIP property to 0. This recommendation is because Microsoft Entra Connect currently uses SQL Native Client to connect to SQL and SQL Native Client doesn't support the use of MultiSubNetFailover property.
* If you're using LocalDB as the database for your Microsoft Entra Connect server and has reached its 10-GB size limit, the Synchronization Service no longer starts. Previously, you need to perform ShrinkDatabase operation on the LocalDB to reclaim enough DB space for the Synchronization Service to start. After which, you can use the Synchronization Service Manager to delete run history to reclaim more DB space. Now, you can use Start-ADSyncPurgeRunHistory cmdlet to purge run history data from LocalDB to reclaim DB space. Further, this cmdlet supports an offline mode (by specifying the -offline parameter) which can be used when the Synchronization Service isn't running. Note: The offline mode can only be used if the Synchronization Service isn't running and the database used is LocalDB.
* To reduce the amount of storage space required, Microsoft Entra Connect now compresses sync error details before storing them in LocalDB/SQL databases. When upgrading from an older version of Microsoft Entra Connect to this version, Microsoft Entra Connect performs a one-time compression on existing sync error details.
* Previously, after updating OU filtering configuration, you must manually run Full import to ensure existing objects are properly included/excluded from directory synchronization. Now, Microsoft Entra Connect automatically triggers Full import during the next sync cycle. Further, Full import is only be applied to the AD connectors affected by the update. Note: this improvement is applicable to OU filtering updates made using the Microsoft Entra Connect wizard only. It isn't applicable to OU filtering update made using the Synchronization Service Manager.
* Previously, Group-based filtering supports Users, Groups, and Contact objects only. Now, Group-based filtering also supports Computer objects.
* Previously, you can delete Connector Space data without disabling Microsoft Entra Connect Sync scheduler. Now, the Synchronization Service Manager blocks the deletion of Connector Space data if it detects that the scheduler is enabled. Further, a warning is returned to inform customers about potential data loss if the Connector space data is deleted.
* Previously, you must disable PowerShell transcription for Microsoft Entra Connect wizard to run correctly. This issue is partially resolved. You can enable PowerShell transcription if you're using Microsoft Entra Connect wizard to manage sync configuration. You must disable PowerShell transcription if you're using Microsoft Entra Connect wizard to manage ADFS configuration.



## 1.1.486.0
Released: April 2017

**Fixed issues:**
* Fixed the issue where Microsoft Entra Connect won't install successfully on localized version of Windows Server.

## 1.1.484.0
Released: April 2017

**Known issues:**

* This version of Microsoft Entra Connect won't install successfully if the following conditions are all true:
  1. you're performing either DirSync in-place upgrade or fresh installation of Microsoft Entra Connect.
  2. you're using a localized version of Windows Server where the name of built-in Administrator group on the server isn't "Administrators".
  3. you're using the default SQL Server 2012 Express LocalDB installed with Microsoft Entra Connect instead of providing your own full SQL.

**Fixed issues:**

Microsoft Entra Connect Sync
* Fixed an issue where the sync scheduler skips the entire sync step if one or more connectors are missing run profile for that sync step. For example, you manually added a connector using the Synchronization Service Manager without creating a Delta Import run profile for it. This fix ensures that the sync scheduler continues to run Delta Import for other connectors.
* Fixed an issue where the Synchronization Service immediately stops processing a run profile when it's encounters an issue with one of the run steps. This fix ensures that the Synchronization Service skips that run step and continues to process the rest. For example, you have a Delta Import run profile for your AD connector with multiple run steps (one for each on-premises AD domain). The Synchronization Service will run Delta Import with the other AD domains even if one of them has network connectivity issues.
* Fixed an issue that causes the Microsoft Entra Connector update to be skipped during Automatic Upgrade.
* Fixed an issue that causes Microsoft Entra Connect to incorrectly determine whether the server is a domain controller during setup, which in turn causes DirSync upgrade to fail.
* Fixed an issue that causes DirSync in-place upgrade to not create any run profile for the Microsoft Entra Connector.
* Fixed an issue where the Synchronization Service Manager user interface becomes unresponsive when trying to configure Generic LDAP Connector.

AD FS management
* Fixed an issue where the Microsoft Entra Connect wizard fails if the AD FS primary node has been moved to another server.

Desktop SSO
* Fixed an issue in the Microsoft Entra Connect wizard where the Sign-In screen doesn't let you enable Desktop SSO feature if you chose Password Synchronization as your Sign-In option during new installation.

**New features/improvements:**

Microsoft Entra Connect Sync
* Microsoft Entra Connect Sync now supports the use of Virtual Service Account, Managed Service Account and Group Managed Service Account as its service account. This applies to new installation of Microsoft Entra Connect only. When installing Microsoft Entra Connect:
  * By default, Microsoft Entra Connect wizard will create a Virtual Service Account and uses it as its service account.
  * If you're installing on a domain controller, Microsoft Entra Connect falls back to previous behavior where it will create a domain user account and uses it as its service account instead.
  * You can override the default behavior by providing one of the following:
   * A Group Managed Service Account
   * A Managed Service Account
   * A domain user account
   * A local user account
* Previously, if you upgrade to a new build of Microsoft Entra Connect containing connectors update or sync rule changes, Microsoft Entra Connect will trigger a full sync cycle. Now, Microsoft Entra Connect selectively triggers Full Import step only for connectors with update, and Full Synchronization step only for connectors with sync rule changes.
* Previously, the Export Deletion Threshold only applies to exports which are triggered through the sync scheduler. Now, the feature is extended to include exports manually triggered by the customer using the Synchronization Service Manager.
* On your Microsoft Entra tenant, there's a service configuration which indicates whether Password Synchronization feature is enabled for your tenant or not. Previously, it's easy for the service configuration to be incorrectly configured by Microsoft Entra Connect when you have an active and a staging server. Now, Microsoft Entra Connect will attempt to keep the service configuration consistent with your active Microsoft Entra Connect server only.
* Microsoft Entra Connect wizard now detects and returns a warning if on-premises AD doesn't have AD Recycle Bin enabled.
* Previously, Export to Microsoft Entra ID times out and fails if the combined size of the objects in the batch exceeds certain threshold. Now, the Synchronization Service will reattempt to resend the objects in separate, smaller batches if the issue is encountered.
* The Synchronization Service Key Management application has been removed from Windows Start Menu. Management of encryption key will continue to be supported through command-line interface using miiskmu.exe. For information about managing encryption key, refer to article [Abandoning the Microsoft Entra Connect Sync encryption key](./how-to-connect-sync-change-serviceacct-pass.md#abandoning-the-adsync-service-account-encryption-key).
* Previously, if you change the Microsoft Entra Connect Sync service account password, the Synchronization Service won't be able start correctly until you have abandoned the encryption key and reinitialized the Microsoft Entra Connect Sync service account password. Now, this process is no longer required.

Desktop SSO

* Microsoft Entra Connect wizard no longer requires port 9090 to be opened on the network when configuring Pass-through Authentication and Desktop SSO. Only port 443 is required.

## 1.1.443.0
Released: March 2017

**Fixed issues:**

Microsoft Entra Connect Sync
* Fixed an issue which causes Microsoft Entra Connect wizard to fail if the display name of the Microsoft Entra Connector doesn't contain the initial onmicrosoft.com domain assigned to the Microsoft Entra tenant.
* Fixed an issue which causes Microsoft Entra Connect wizard to fail while making connection to SQL database when the password of the Sync Service Account contains special characters such as apostrophe, colon and space.
* Fixed an issue which causes the error "The image has an anchor that is different than the image" to occur on a Microsoft Entra Connect server in staging mode, after you have temporarily excluded an on-premises AD object from syncing and then included it again for syncing.
* Fixed an issue which causes the error “The object located by DN is a phantom” to occur on a Microsoft Entra Connect server in staging mode, after you have temporarily excluded an on-premises AD object from syncing and then included it again for syncing.

AD FS management
* Fixed an issue where Microsoft Entra Connect wizard doesn't update AD FS configuration and set the right claims on the relying party trust after Alternate Login ID is configured.
* Fixed an issue where Microsoft Entra Connect wizard is unable to correctly handle AD FS servers whose service accounts are configured using userPrincipalName format instead of sAMAccountName format.

Pass-through Authentication
* Fixed an issue which causes Microsoft Entra Connect wizard to fail if Pass Through Authentication is selected but registration of its connector fails.
* Fixed an issue which causes Microsoft Entra Connect wizard to bypass validation checks on sign-in method selected when Desktop SSO feature is enabled.

Password Reset
* Fixed an issue which may cause the Microsoft Entra Connect server to not attempt to re-connect if the connection was killed by a firewall or proxy.

**New features/improvements:**

Microsoft Entra Connect Sync
* Get-ADSyncScheduler cmdlet now returns a new Boolean property named SyncCycleInProgress. If the returned value is true, it means that there's a scheduled synchronization cycle in progress.
* Destination folder for storing Microsoft Entra Connect installation and setup logs has been moved from `%localappdata%\AADConnect` to `%programdata%\AADConnect` to improve accessibility to the log files.

AD FS management
* Added support for updating AD FS Farm TLS/SSL Certificate.
* Added support for managing AD FS 2016.
* You can now specify existing gMSA (Group Managed Service Account) during AD FS installation.
* You can now configure SHA-256 as the signature hash algorithm for Microsoft Entra ID relying party trust.

Password Reset
* Introduced improvements to allow the product to function in environments with more stringent firewall rules.
* Improved connection reliability to Azure Service Bus.

## 1.1.380.0
Released: December 2016

**Fixed issue:**

* Fixed the issue where the issuerid claim rule for Active Directory Federation Services (AD FS) is missing in this build.

>[!NOTE]
>This build isn't available to customers through the Microsoft Entra Connect Auto Upgrade feature.
## 1.1.371.0
Released: December 2016

**Known issue:**

* The issuerid claim rule for AD FS is missing in this build. The issuerid claim rule is required if you're federating multiple domains with Microsoft Entra ID. If you're using Microsoft Entra Connect to manage your on-premises AD FS deployment, upgrading to this build removes the existing issuerid claim rule from your AD FS configuration. You can  work-around the issue by adding the issuerid claim rule after the installation/upgrade. For details on adding the issuerid claim rule, refer to this article on [Multiple domain support for federating with Microsoft Entra ID](how-to-connect-install-multiple-domains.md).

**Fixed issue:**

* If Port 9090 isn't opened for the outbound connection, the Microsoft Entra Connect installation or upgrade fails.

>[!NOTE]
>This build isn't available to customers through the Microsoft Entra Connect Auto Upgrade feature.
## 1.1.370.0
Released: December 2016

**Known issues:**

* The issuerid claim rule for AD FS is missing in this build. The issuerid claim rule is required if you're federating multiple domains with Microsoft Entra ID. If you're using Microsoft Entra Connect to manage your on-premises AD FS deployment, upgrading to this build removes the existing issuerid claim rule from your AD FS configuration. You can  work-around the issue by adding the issuerid claim rule after installation/upgrade. For details on adding issuerid claim rule, refer to this article on [Multiple domain support for federating with Microsoft Entra ID](how-to-connect-install-multiple-domains.md).
* Port 9090 must be open outbound to complete installation.

**New features:**

* Pass-through Authentication .

>[!NOTE]
>This build isn't available to customers through the Microsoft Entra Connect Auto Upgrade feature.
## 1.1.343.0
Released: November 2016

**Known issue:**

* The issuerid claim rule for AD FS is missing in this build. The issuerid claim rule is required if you're federating multiple domains with Microsoft Entra ID. If you're using Microsoft Entra Connect to manage your on-premises AD FS deployment, upgrading to this build removes the existing issuerid claim rule from your AD FS configuration. You can  work-around the issue by adding the issuerid claim rule after installation/upgrade. For details on adding issuerid claim rule, refer to this article on [Multiple domain support for federating with Microsoft Entra ID](how-to-connect-install-multiple-domains.md).

**Fixed issues:**

* Sometimes, installing Microsoft Entra Connect fails because it's unable to create a local service account whose password meets the level of complexity specified by the organization's password policy.
* Fixed an issue where join rules aren't reevaluated when an object in the connector space simultaneously becomes out-of-scope for one join rule and become in-scope for another. This can happen if you have two or more join rules whose join conditions are mutually exclusive.
* Fixed an issue where inbound synchronization rules (from Microsoft Entra ID), which don't contain join rules, aren't processed if they have lower precedence values than those containing join rules.

**Improvements:**

* Added support for installing Microsoft Entra Connect on Windows Server 2016 Standard or higher.
* Added support for using SQL Server 2016 as the remote database for Microsoft Entra Connect.

## 1.1.281.0
Released: August 2016

**Fixed issues:**

* Changes to sync interval don't take place until after the next sync cycle is complete.
* Microsoft Entra Connect wizard doesn't accept a Microsoft Entra account whose username starts with an underscore (\_).
* Microsoft Entra Connect wizard fails to authenticate the Microsoft Entra account if the account password contains too many special characters. Error message "Unable to validate credentials. An unexpected error has occurred." is returned.
* Uninstalling staging server disables password synchronization in Microsoft Entra tenant and causes password synchronization to fail with active server.
* Password synchronization fails in uncommon cases when there's no password hash stored on the user.
* When Microsoft Entra Connect server is enabled for staging mode, password writeback isn't temporarily disabled.
* Microsoft Entra Connect wizard doesn't show the actual password synchronization and password writeback configuration when server is in staging mode. It always shows them as disabled.
* Configuration changes to password synchronization and password writeback aren't persisted by Microsoft Entra Connect wizard when server is in staging mode.

**Improvements:**

* Updated the Start-ADSyncSyncCycle cmdlet to indicate whether it's able to successfully start a new sync cycle or not.
* Added the Stop-ADSyncSyncCycle cmdlet to terminate sync cycle and operation, which are currently in progress.
* Updated the Stop-ADSyncScheduler cmdlet to terminate sync cycle and operation, which are currently in progress.
* When configuring [Directory extensions](how-to-connect-sync-feature-directory-extensions.md) in Microsoft Entra Connect wizard, the Microsoft Entra attribute of type "Teletex string" can now be selected.

## 1.1.189.0
Released: June 2016

**Fixed issues and improvements:**

* Microsoft Entra Connect can now be installed on a FIPS-compliant server.
 * For password synchronization, see [Password hash sync and FIPS](how-to-connect-password-hash-synchronization.md#password-hash-synchronization-and-fips).
* Fixed an issue where a NetBIOS name couldn't be resolved to the FQDN in the Active Directory Connector.

## 1.1.180.0
Released: May 2016

**New features:**

* Warns and helps you verify domains if you didn’t do it before running Microsoft Entra Connect.
* Added support for [Microsoft Cloud Germany](reference-connect-instances.md#microsoft-cloud-germany).
* Added support for the latest [Microsoft Azure Government cloud](reference-connect-instances.md#microsoft-azure-government) infrastructure with new URL requirements.

**Fixed issues and improvements:**

* Added filtering to the Sync Rule Editor to make it easy to find sync rules.
* Improved performance when deleting a connector space.
* Fixed an issue when the same object was both deleted and added in the same run (called delete/add).
* A disabled sync rule no longer re-enables included objects and attributes on upgrade or directory schema refresh.

## 1.1.130.0
Released: April 2016

**New features:**

* Added support for multi-valued attributes to [Directory extensions](how-to-connect-sync-feature-directory-extensions.md).
* Added support for more configuration variations for [automatic upgrade](how-to-connect-install-automatic-upgrade.md) to be considered eligible for upgrade.
* Added some cmdlets for [custom scheduler](how-to-connect-sync-feature-scheduler.md#custom-scheduler).

## 1.1.119.0
Released: March 2016

**Fixed issues:**

* Made sure Express installation can't be used on Windows Server 2008 (pre-R2) because password sync isn't supported on this operating system.
* Upgrade from DirSync with a custom filter configuration didn't work as expected.
* When upgrading to a newer release and there are no changes to the configuration, a full import/synchronization shouldn't be scheduled.

## 1.1.110.0
Released: February 2016

**Fixed issues:**

* Upgrade from earlier releases doesn't work if the installation isn't in the default C:\Program Files folder.
* If you install and clear **Start the synchronization process** at the end of the installation wizard, running the installation wizard a second time won't enable the scheduler.
* The scheduler doesn't work as expected on servers where the US-en date/time format isn't used. It will also block `Get-ADSyncScheduler` to return correct times.
* If you installed an earlier release of Microsoft Entra Connect with AD FS as the sign-in option and upgrade, you can't run the installation wizard again.

## 1.1.105.0
Released: February 2016

**New features:**

* [Automatic upgrade](how-to-connect-install-automatic-upgrade.md) feature for Express settings customers.
* Support for the Hybrid Identity Administrator by using Microsoft Entra multifactor authentication and Privileged Identity Management in the installation wizard.
 * You need to allow your proxy to also allow traffic to ```https://secure.aadcdn.microsoftonline-p.com``` if you use multifactor authentication.
 * You need to add ```https://secure.aadcdn.microsoftonline-p.com``` to your trusted sites list for multifactor authentication to properly work.
* Allow changing the user's sign-in method after initial installation.
* Allow [Domain and OU filtering](how-to-connect-install-custom.md#domain-and-ou-filtering) in the installation wizard. This also allows connecting to forests where not all domains are available.
* [Scheduler](how-to-connect-sync-feature-scheduler.md) is built in to the sync engine.

**Features promoted from preview to GA:**

* [Device writeback](how-to-connect-device-writeback.md).
* [Directory extensions](how-to-connect-sync-feature-directory-extensions.md).

**New preview features:**

* The new default sync cycle interval is 30 minutes. Used to be three hours for all earlier releases. Adds support to change the [scheduler](how-to-connect-sync-feature-scheduler.md) behavior.

**Fixed issues:**

* The verify DNS domains page didn't always recognize the domains.
* Prompts for domain admin credentials when configuring AD FS.
* The on-premises AD accounts aren't recognized by the installation wizard if located in a domain with a different DNS tree than the root domain.

## 1.0.9131.0
Released: December 2015

**Fixed issues:**

* Password sync might not work when you change passwords in Active Directory Domain Services (AD DS), but works when you do set a password.
* When you have a proxy server, authentication to Microsoft Entra ID might fail during installation, or if an upgrade is canceled on the configuration page.
* Updating from a previous release of Microsoft Entra Connect with a full SQL Server instance fails if you'ren't a SQL Server system administrator (SA).
* Updating from a previous release of Microsoft Entra Connect with a remote SQL Server shows the “Unable to access the ADSync SQL database” error.

## 1.0.9125.0
Released: November 2015

**New features:**

* Can reconfigure AD FS to Microsoft Entra ID trust.
* Can refresh the Active Directory schema and regenerate sync rules.
* Can disable a sync rule.
* Can define "AuthoritativeNull" as a new literal in a sync rule.

**New preview features:**

* [Microsoft Entra Connect Health for sync](how-to-connect-health-sync.md).
* Support for [Microsoft Entra Domain Services](https://support.microsoft.com/account-billing/reset-your-work-or-school-password-using-security-info-23dde81f-08bb-4776-ba72-e6b72b9dda9e) password synchronization.

**New supported scenario:**

* Supports multiple on-premises Exchange organizations. For more information, see [Hybrid deployments with multiple Active Directory forests](/Exchange/hybrid-deployment/hybrid-with-multiple-forests).

**Fixed issues:**

* Password synchronization issues:
 * An object moved from out-of-scope to in-scope won't have its password synchronized. This includes both OU and attribute filtering.
 * Selecting a new OU to include in sync doesn't require a full password sync.
 * When a disabled user is enabled the password doesn't sync.
 * The password retry queue is infinite and the previous limit of 5,000 objects to be retired has been removed.
* Not able to connect to Active Directory with Windows Server 2016 forest-functional level.
* Not able to change the group that is used for group filtering after the initial installation.
* No longer creates a new user profile on the Microsoft Entra Connect server for every user doing a password change with password writeback enabled.
* Not able to use Long Integer values in sync rules scopes.
* The check box "device writeback" remains disabled if there are unreachable domain controllers.

## 1.0.8667.0
Released: August 2015

**New features:**

* The Microsoft Entra Connect installation wizard is now localized to all Windows Server languages.
* Added support for account unlock when using Microsoft Entra password management.

**Fixed issues:**

* Microsoft Entra Connect installation wizard crashes if another user continues installation rather than the person who first started the installation.
* If a previous uninstallation of Microsoft Entra Connect fails to uninstall Microsoft Entra Connect Sync cleanly, it's not possible to reinstall.
* Can't install Microsoft Entra Connect using Express installation if the user isn't in the root domain of the forest or if a non-English version of Active Directory is used.
* If the FQDN of the Active Directory user account can't be resolved, a misleading error message “Failed to commit the schema” is shown.
* If the account used on the Active Directory Connector is changed outside the wizard, the wizard fails on subsequent runs.
* Microsoft Entra Connect sometimes fails to install on a domain controller.
* Can't enable and disable “Staging mode” if extension attributes have been added.
* Password writeback fails in some configurations because of a bad password on the Active Directory Connector.
* DirSync can't be upgraded if a distinguished name (DN) is used in attribute filtering.
* Excessive CPU usage when using password reset.

**Removed preview features:**

* The preview feature [User writeback](how-to-connect-preview.md#user-writeback) was temporarily removed based on feedback from our preview customers. It will be added again later after we have addressed the provided feedback.

## 1.0.8641.0
Released: June 2015

**Initial release of Microsoft Entra Connect.**

Changed name from Azure AD Sync to Microsoft Entra Connect.

**New features:**

* [Express settings](how-to-connect-install-express.md) installation
* Can [configure AD FS](how-to-connect-install-custom.md#configuring-federation-with-ad-fs)
* Can [upgrade from DirSync](how-to-dirsync-upgrade-get-started.md)
* [Prevent accidental deletes](how-to-connect-sync-feature-prevent-accidental-deletes.md)
* Introduced [staging mode](how-to-connect-sync-staging-server.md)

**New preview features:**

* [User writeback](how-to-connect-preview.md#user-writeback)
* [Device writeback](how-to-connect-device-writeback.md)
* [Directory extensions](how-to-connect-preview.md)

## 1.0.494.0501
Released: May 2015

**New Requirement:**

* Azure AD Sync now requires the .NET Framework version 4.5.1 to be installed.

**Fixed issues:**

* Password writeback from Microsoft Entra ID is failing with an Azure Service Bus connectivity error.

## 1.0.491.0413
Released: April 2015

**Fixed issues and improvements:**

* The Active Directory Connector doesn't process deletes correctly if the recycle bin is enabled and there are multiple domains in the forest.
* The performance of import operations has been improved for the Microsoft Entra Connector.
* When a group has exceeded the membership limit (by default, the limit's set to 50,000 objects), the group was deleted in Microsoft Entra ID. With the new behavior, the group isn't deleted, an error is thrown, and new membership changes aren't exported.
* A new object can't be provisioned if a staged delete with the same DN is already present in the connector space.
* Some objects are marked for synchronization during a delta sync even though there's no change staged on the object.
* Forcing a password sync also removes the preferred DC list.
* CSExportAnalyzer has problems with some objects states.

**New features:**

* A join can now connect to “ANY” object type in the MV.

## 1.0.485.0222
Released: February 2015

**Improvements:**

* Improved import performance.

**Fixed issues:**

* Password Sync honors the cloudFiltered attribute that is used by attribute filtering. Filtered objects are no longer in scope for password synchronization.
* In rare situations where the topology had many domain controllers, password sync doesn’t work.
* “Stopped-server” when importing from the Microsoft Entra Connector after device management has been enabled in Azure AD/Intune.
* Joining Foreign Security Principals (FSPs) from multiple domains in same forest causes an ambiguous-join error.

## 1.0.475.1202
Released: December 2014

**New features:**

* Password synchronization with attribute-based filtering is now supported. For more information, see [Password synchronization with filtering](how-to-connect-sync-configure-filtering.md).
* The ms-DS-ExternalDirectoryObjectID attribute is written back to Active Directory. This feature adds support for Microsoft 365 applications. It uses OAuth2 to access online and on-premises mailboxes in a Hybrid Exchange Deployment.

**Fixed upgrade issues:**

* A newer version of the sign-in assistant is available on the server.
* A custom installation path was used to install Azure AD Sync.
* An invalid custom join criterion blocks the upgrade.

**Other fixes:**

* Fixed the templates for Office Pro Plus.
* Fixed installation issues caused by user names that start with a dash.
* Fixed losing the sourceAnchor setting when running the installation wizard a second time.
* Fixed ETW tracing for password synchronization.

## 1.0.470.1023
Released: October 2014

**New features:**

* Password synchronization from multiple on-premises Active Directory to Microsoft Entra ID.
* Localized installation UI to all Windows Server languages.

**Upgrading from AADSync 1.0 GA**

If you already have Azure AD Sync installed, there's one additional step you have to take in case you have changed any of the out-of-box synchronization rules. After you have upgraded to the 1.0.470.1023 release, the synchronization rules you have modified are duplicated. For each modified sync rule, do the following:

1. Locate the sync rule you have modified and take a note of the changes.
1. Delete the sync rule.
1. Locate the new sync rule that is created by Azure AD Sync and then reapply the changes.

**Permissions for the Active Directory account**

The Active Directory account must be granted additional permissions to be able to read the password hashes from Active Directory. The permissions to grant are named “Replicating Directory Changes” and “Replicating Directory Changes All.” Both permissions are required to be able to read the password hashes.

## 1.0.419.0911
Released: September 2014

**Initial release of Azure AD Sync.**

## Next steps
Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

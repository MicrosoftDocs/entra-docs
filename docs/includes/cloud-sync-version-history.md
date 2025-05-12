This article lists the versions and features of Microsoft Entra provisioning agent releases. The Microsoft Entra team regularly updates the Provisioning Agent with new features and functionality. 

> [!NOTE]
> All new Provisioning Agent releases are made available for download through the Microsoft Entra admin center and only specific releases are pushed for auto upgrade.

>[!NOTE]
> Microsoft Entra provisioning agent follows the [Modern Lifecycle Policy](/lifecycle/policies/modern). Changes for products and services  under the Modern Lifecycle Policy may be more frequent and require customers to be alert for forthcoming modifications to their product or service.
>
> Products governed by the Modern Policy follow a [continuous support and servicing model](/lifecycle/overview/product-end-of-support-overview). Customers must take the latest update to remain supported. 
>
> For products and services governed by the Modern Lifecycle Policy, Microsoft's policy is to provide a minimum 30 days' notification when customers are required to take action in order to avoid significant degradation to the normal use of the product or service.

## Download link

From the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted), select "Cloud Sync" and go to "Agents" to download the "Provisioning Agent."

Get notified about when to revisit this page for updates by copying and pasting this URL: `https://aka.ms/cloudsyncrss` into your ![RSS feed reader icon](media/cloud-sync-version-history/feed-icon-16-x-16.png) feed reader.





## 1.1.1586.0

May 13, 2024: released for download only

### Fixed issues
 
 - Miscellaneous supportability improvements.
 - Improved handling of Active Directory Provider initialization issues.
 - Fixed a bug with removing attributes.
 - Improved group writeback error handling.





## 1.1.1373.0

January 19, 2024: released for download and auto upgrade

### Fixed issues
Fixed an issue with case-sensitive comparison of domain names and enhanced the error handling.




## 1.1.1370.0

Release date: October 16, 2023

### New or changed functionality

- Added Public Preview feature:  [Group provisioning to Active Directory](../identity/hybrid/cloud-sync/govern-on-premises-groups.md)
- Rebranded the agent for Microsoft Entra




## 1.1.1365.0

September 8, 2023: released for download only

### New or changed functionality

- Added support for Applications Kerberos Key synchronization to Provisioning Agent
- Added support for Web Service, Windows PowerShell, and custom ECMA2 connectors
- **Query attribute** of ECMA2Host is no longer in use and removed from the ECMA2 Configuration wizard
- Update AADCloudSyncTools module with function to disable DirSyncConfiguration Accidental Deletion Prevention

### Fixed issues
- Fixed an issue with jobs going into quarantine if an OR name attribute value points to a nonexistent object
- Fixed an issue that caused customizations to AADConnectProvisioningAgent.exe.config to reset when the agent is updated
- Fixed provisioning agent incorrect creds if NTLM traffic is set to 'Deny-All'
- Fixed incorrect file path to trace log
- Fixed an issue that caused Provisioning Agent installer crashing from duplicate schema objects
- Update Windows Server Version check as per documented prerequisites
- Fixed for install page links visibility in 'high contrast black' mode
- Fixed case sensitive comparison and add logging for UPN / role ID checks
- Accessibility fixes for ECMA2 Configuration wizard





## 1.1.1107.0

December 16, 2022: released for download only

### New or changed functionality
-	Added support for [on-premises application provisioning](/azure/active-directory/app-provisioning/on-premises-application-provisioning-architecture) (SCIM, SQL, LDAP) 




## 1.1.977.0

September 23, 2022: released for download only

### New or changed functionality
 - Added support for [cloud sync Self Service Password Reset](../identity/authentication/tutorial-enable-cloud-sync-sspr-writeback.md) General Availability.
 - Added support for password writeback in disconnected forests.
 
### Fixed issues

 - Fixed various bug fixes to support SSPR with cloud sync




## 1.1.972.0

August 8, 2022: released for download only

### New or changed functionality

 - Added a new cmdlet to enable and disable writeback of passwords. For more information about this cmdlet and its use, see [Enable password writeback in Microsoft Entra Connect cloud sync](../identity/authentication/tutorial-enable-cloud-sync-sspr-writeback.md#enable-password-writeback-in-sspr).
 - More info is now returned from 'Get-AADCloudSyncDomains' cmdlet
 - Updated new cmdlets of CloudSync PowerShell module in the unattended agent install script. 
 - Added support for the installation of the provisioning agent using the commandline. 
 - Added support for EX and RX environments.
  
### Fixed issues

 - Remove the app.config file on upgrade of the agent. After the Newtonsoft.Json upgrade, AADConnectProvisioningAgent.exe.config isn't updated after install, which results in a failure of sync.
 - Fixed an issue with DC affinity after an OU is renamed.
 - Fixed several issues in the PowerShell module.
 - Fixed a memory leak due to not disposing HTTP client.
 - Fixed a bug in the code for granting the "logon as a service" right to the GMSA.
 - Refined the permissions on the GMSA for CloudHR.
 - Cloud sync agent is now uninstalled, when the bundle is uninstalled.
 - Fixed a bug that prevents deletion of the Service Principal if not all Jobs are deleted.
 - Fixed an issue with updating of the password of a user with "User must change password at next logon."
 - Fixed an issue with the agent GMSA folder permissions.
 - Fixed an issue where group membership updates aren't always correct.




## 1.1.818.0

April 18, 2022: released for download only

New features and improvements

 - Fixed bug where granting logon as a service right to a gMSA would fail.
 - Updated the agent to honor the preferred Domain Controller list that is configured in the agent to also be used for the Self Service Password Reset feature.




## 1.1.587.0

November 2, 2021: released for download only

New features and improvements

- Added a cmdlet to configure Password Writeback





## 1.1.584.0 

August 20, 2021: released for download only

### Fixed issues

- Fixed a bug where, when a domain is renamed, Password Hash Sync would fail with an error indicating "a specified cast is not valid" in the Event log. This error is a regression from earlier builds.




## 1.1.582.0

August 8, 2021: released for download only

>[!NOTE] 
>This is a security update release of Azure AD Connect. 
>This release addresses a vulnerability as documented in [this CVE](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-36949). For more information about this vulnerability, see the CVE.




## 1.1.359.0

### New features and improvements
- GMSA Cmdlets to set/reset permission

### Fixed issues
- Fixed GMSA folder permissions (originally, the issue resulted in bootstrap issues)
- Fixed the handling of multiple changes to a single value reference attribute (for example, manager)
- Fixed the failure in Initial Enumeration, plus enhanced tracing of the failure
- Optimized group membership updates to a Scoping Group. With this update, customers now can sync a group of up to 50 K members using group scoping filter
- Added support to retrieve a single object by DN with Scoping used by Provisioning On Demand to obey Scoping logic





## 1.1.354.0

January 20, 2021: released for download only

### New features and improvements
- Improvement to GMSA experience including support for pre-custom created GMSA Account
- Added support for GMSA setup with [PowerShell cmdlets](../identity/hybrid/cloud-sync/how-to-gmsa-cmdlets.md)
- Added support for [CLI](../identity/hybrid/cloud-sync/how-to-install-pshell.md) agent install (silent installation)
- Added more diagnostics for agent source quarantine issues
- Reduced memory usage of OU scoping filters, running PHS only for in-scope users, handling of nested objects in OU when using OU scoping etc. 


### Fixed issues
-	Prevent quarantine when scoping group is out of scope
-	PHS job now only operates for in-scope users, when scoping filters are configured
-	Agent would sometime stop responding during upgrade
-	Initial Sync for objects in nested OUs when using OU scoping
-	Make the Repair-AADCloudSyncToolsAccount more robust
-	Reduce large memory usage of OU scoping filters
-	Admin role check fails if the role members contain a security group
-	Fixed GMSA folder permission issue, which prevents Agent Cert renewal





## 1.1.281.0

### Release status

November 23, 2020: released for download only

### New features and improvements

* Added support for [gMSA](../identity/hybrid/cloud-sync/how-to-prerequisites.md#group-managed-service-accounts)
* Added support for groups up to size less than 1500 members during incremental or delta sync cycle. This change is applicable when using group scoping filter
* Added support for large groups with member size up to 15 K
* Added Initial sync improvements
* Added advanced verbose logging
* Added a new [AADCloudSyncTools PowerShell module](../identity/hybrid/cloud-sync/reference-powershell.md)
* Fixed limitations to allow agent to be installed in non-English server
* Added support for PHS filtering only for objects in scope (Originally, we were syncing password hashes for all objects)
* Fixed a memory leak issue in the agent
* Added improvements in provisioning logs
* Added support for configuring [LDAP connection timeout](../identity/hybrid/cloud-sync/how-to-manage-registry-options.md#configure-ldap-connection-timeout) 
* Added support for configuring [referral chasing](../identity/hybrid/cloud-sync/how-to-manage-registry-options.md#configure-referral-chasing) 





## 1.1.96.0

### Release status

December 4, 2019: released for download only

### New features and improvements

* Added support for [Azure AD Connect cloud sync](../identity/hybrid/cloud-sync/what-is-cloud-sync.md) to synchronize user, contact and group data from on-premises Active Directory to Azure AD




## 1.1.67.0

### Release status

September 9, 2019: Released for auto update

### New features and improvements

* Added ability to configure more tracing and logging for debugging Provisioning Agent issues
* Added ability to fetch only those Azure AD attributes that are configured in the mapping to improve performance of sync

### Fixed issues

* Fixed a bug wherein the agent went into an unresponsive state if there were issues with Azure AD connection failures
* Fixed a bug that caused issues when binary data was read from Azure Active Directory
* Fixed a bug wherein the agent failed to renew trust with the cloud hybrid identity service




## 1.1.30.0

### Release status

January 23, 2019: Released for download

### New features and improvements

* Revamped the Provisioning Agent and connector architecture for better performance, stability, and reliability 
* Simplified the Provisioning Agent configuration using UI-driven installation wizard

---
title: Known issues for provisioning in Microsoft Entra ID
description: Learn about known issues when you work with automated application provisioning or cross-tenant synchronization in Microsoft Entra ID.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: troubleshooting
ms.date: 02/02/2024
ms.reviewer: arvinh
zone_pivot_groups: app-provisioning-cross-tenant-synchronization
---

# Known issues for provisioning in Microsoft Entra ID

This article discusses known issues to be aware of when you work with app provisioning or cross-tenant synchronization. To provide feedback about the application provisioning service on UserVoice, see [Microsoft Entra application provision UserVoice](https://aka.ms/appprovisioningfeaturerequest). We watch UserVoice closely so that we can improve the service.

> [!NOTE]
> This article isn't a comprehensive list of known issues. If you know of an issue that isn't listed, provide feedback at the bottom of the page.

::: zone pivot="cross-tenant-synchronization"
## Cross-tenant synchronization

### Unsupported synchronization scenarios

- Synchronizing groups, devices, and contacts into another tenant
- Synchronizing users across clouds
- Synchronizing photos across tenants
- Synchronizing contacts and converting contacts to B2B users
- Synchronizing meeting rooms across tenants

### Updating proxyAddresses

ProxyAddresses is a [read-only property in Microsoft Graph](https://learn.microsoft.com/graph/api/resources/user?view=graph-rest-1.0&preserve-view=true#mail-and-proxyaddresses-properties). It can be included as a source attribute in your mappings, but cannot be set as a target attribute. 

### Microsoft Teams

External / B2B users of type `member` created by cross-tenant synchronization can be added to a shared channel in Microsoft Teams. However, external member users created outside of cross-tenant sync cannot be added to a Teams shared channel.  

 ### Provisioning users

An external user from the source (home) tenant can't be provisioned into another tenant. Internal guest users from the source tenant can't be provisioned into another tenant. Only internal member users from the source tenant can be provisioned into the target tenant. For more information, see [Properties of a Microsoft Entra B2B collaboration user](~/external-id/user-properties.md).

In addition, users that are enabled for SMS sign-in cannot be synchronized through cross-tenant synchronization.


### Updating the showInAddressList property fails

For existing B2B collaboration users, the showInAddressList attribute will be updated as long as the B2B collaboration user doesn't have a mailbox enabled in the target tenant. If the mailbox is enabled in the target tenant, use the [Set-MailUser](/powershell/module/exchange/set-mailuser) PowerShell cmdlet to set the HiddenFromAddressListsEnabled property to a value of $false.

`Set-MailUser [GuestUserUPN] -HiddenFromAddressListsEnabled:$false`

Where [GuestUserUPN] is the calculated UserPrincipalName. Example:  

`Set-MailUser guestuser1_contoso.com#EXT#@fabricam.onmicrosoft.com -HiddenFromAddressListsEnabled:$false`

For more information, see [About the Exchange Online PowerShell module](/powershell/exchange/exchange-online-powershell-v2).

### Configuring synchronization from target tenant

Configuring synchronization from the target tenant isn't supported. All configurations must be done in the source tenant. Note that the target administrator is able to turn off cross-tenant synchronization at any time.

### Two users in the source tenant matched with the same user in the target tenant

When two users in the source tenant have the same mail, and they both need to be created in the target tenant, one user will be created in the target and linked to the two users in the source. Please ensure that the mail attribute is not shared among users in the source tenant. In addition, please ensure that the mail of the user in the source tenant is from a verified domain. The external user will not be created successfully if the mail is from an unverified domain. 

<a name='usage-of-azure-ad-b2b-collaboration-for-cross-tenant-access'></a>

### Usage of Microsoft Entra B2B collaboration for cross-tenant access

- B2B users are unable to manage certain Microsoft 365 services in remote tenants (such as Exchange Online), as there's no directory picker.
- To learn about Azure Virtual Desktop support for B2B users, see [Prerequisites for Azure Virtual Desktop](/azure/virtual-desktop/prerequisites?tabs=portal).
- For the latest status on Power BI support for external member users, see [Distribute Power BI content to external guest users with Microsoft Entra B2B](/power-bi/enterprise/service-admin-azure-ad-b2b#who-can-you-invite)
::: zone-end

## Authorization 

#### Unable to change provisioning mode back to manual

After you've configured provisioning for the first time, you'll notice that the provisioning mode has switched from manual to automatic. You can't change it back to manual. But you can turn off provisioning through the UI. Turning off provisioning in the UI effectively does the same as setting the dropdown to manual.

## Attribute mappings 

#### Attribute SamAccountName or userType not available as a source attribute

The attributes **SamAccountName** and **userType** aren't available as a source attribute by default. Extend your schema to add the attributes. You can add the attributes to the list of available source attributes by extending your schema. To learn more, see [Missing source attribute](user-provisioning-sync-attributes-for-mapping.md). 

#### Source attribute dropdown missing for schema extension

Extensions to your schema can sometimes be missing from the source attribute dropdown in the UI. Go into the advanced settings of your attribute mappings and manually add the attributes. To learn more, see [Customize attribute mappings](customize-application-attributes.md).

#### Null attribute can't be provisioned

Microsoft Entra ID currently can't provision null attributes. If an attribute is null on the user object, it will be skipped. 

#### Maximum characters for attribute-mapping expressions

Attribute-mapping expressions can have a maximum of 10,000 characters. 

#### Unsupported scoping filters

The **appRoleAssignments**, **userType**, and **accountExpires** attributes aren't supported as scoping filters.

::: zone pivot="cross-tenant-synchronization"
#### OtherMails should not be included in your attribute mappings as a target attribute

The otherMails property is automatically computed in the target tenant. Changes to the user object made directly in the target tenant could result in the otherMails property being updated and override the value set by cross-tenant synchronization. As a result, otherMails should not be included in your cross-tenant synchronization attribute mappings as a target attribute. 
::: zone-end

#### Multivalue directory extensions

Multivalue directory extensions can't be used in attribute mappings or scoping filters. 

## Service issues 

#### Unsupported scenarios

- Provisioning passwords isn't supported. 
- Provisioning nested groups isn't supported. 
- Provisioning to B2C tenants isn't supported because of the size of the tenants.
- Not all provisioning apps are available in all clouds. For example, Atlassian isn't yet available in the Government cloud. We're working with app developers to onboard their apps to all clouds.

::: zone pivot="app-provisioning"
#### Automatic provisioning isn't available on my OIDC-based application

If you create an app registration, the corresponding service principal in enterprise apps won't be enabled for automatic user provisioning. You'll need to either request the app be added to the gallery, if intended for use by multiple organizations, or create a second non-gallery app for provisioning.

#### Manager isn't provisioned

If a user and their manager are both in scope for provisioning, the service provisions the user and then updates the manager. If on day one the user is in scope and the manager is out of scope, we'll provision the user without the manager reference. When the manager comes into scope, the manager reference won't be updated until you restart provisioning and cause the service to reevaluate all the users again. 

::: zone-end

#### The provisioning interval is fixed

The [time](./application-provisioning-when-will-provisioning-finish-specific-user.md#how-long-will-it-take-to-provision-users) between provisioning cycles is currently not configurable. 

<a name='changes-not-moving-from-target-app-to-azure-ad'></a>

#### Changes not moving from target app to Microsoft Entra ID

The app provisioning service isn't aware of changes made in external apps. So, no action is taken to roll back. The app provisioning service relies on changes made in Microsoft Entra ID. 

#### Switching from Sync All to Sync Assigned not working

After you change scope from **Sync All** to **Sync Assigned**, make sure to also perform a restart to ensure that the change takes effect. You can do the restart from the UI.

#### Provisioning cycle continues until completion

When you set provisioning to `enabled = off` or select **Stop**, the current provisioning cycle continues running until completion. The service stops executing any future cycles until you turn provisioning on again.

#### Member of group not provisioned

When a group is in scope and a member is out of scope, the group will be provisioned. The out-of-scope user won't be provisioned. If the member comes back into scope, the service won't immediately detect the change. Restarting provisioning addresses the issue. Periodically restart the service to ensure that all users are properly provisioned.

#### Global Reader

The Global Reader role is unable to read the provisioning configuration. Create a custom role with the `microsoft.directory/applications/synchronization/standard/read` permission in order to read the provisioning configuration from the Microsoft Entra admin center. 

#### Microsoft Azure Government Cloud
Credentials, including the secret token, notification email, and SSO certificate notification emails together have a 1KB limit in the Microsoft Azure Government Cloud. 

::: zone pivot="app-provisioning"
## On-premises application provisioning
The following information is a current list of known limitations with the Microsoft Entra ECMA Connector Host and on-premises application provisioning.

### Application and directories
The following applications and directories aren't yet supported.

<a name='active-directory-domain-services-user-or-group-writeback-from-azure-ad-by-using-the-on-premises-provisioning-preview'></a>

#### Active Directory Domain Services (user or group writeback from Microsoft Entra ID by using the on-premises provisioning preview)
   - When a user is managed by Microsoft Entra Connect, the source of authority is on-premises Active Directory Domain Services. So, user attributes can't be changed in Microsoft Entra ID. This preview doesn't change the source of authority for users managed by Microsoft Entra Connect.
   - Attempting to use Microsoft Entra Connect and the on-premises provisioning to provision groups or users into Active Directory Domain Services can lead to creation of a loop, where Microsoft Entra Connect can overwrite a change that was made by the provisioning service in the cloud. Microsoft is working on a dedicated capability for group or user writeback. Upvote the UserVoice feedback on [this website](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789/) to track the status of the preview. Alternatively, you can use [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016) for user or group writeback from Microsoft Entra ID to Active Directory.

<a name='azure-ad'></a>

#### Microsoft Entra ID

   By using on-premises provisioning, you can take a user already in Microsoft Entra ID and provision them into a third-party application. *You can't bring a user into the directory from a third-party application.* Customers will need to rely on our native HR integrations, Microsoft Entra Connect, Microsoft Identity Manager, or Microsoft Graph, to bring users into the directory.

### Attributes and objects 
The following attributes and objects aren't supported:
   - Multivalued attributes.
   - Reference attributes (for example, manager).
   - Groups.
   - Complex anchors (for example, ObjectTypeName+UserName).
   - Attributes that have characters such as "." or "["
   - Binary attributes.
   - On-premises applications are sometimes not federated with Microsoft Entra ID and require local passwords. The on-premises provisioning preview doesn't support password synchronization. Provisioning initial one-time passwords is supported. Ensure that you're using the [Redact](./functions-for-customizing-application-data.md#redact) function to redact the passwords from the logs. In the SQL and LDAP connectors, the passwords aren't exported on the initial call to the application, but rather a second call with set password.   

#### SSL certificates
   The Microsoft Entra ECMA Connector Host currently requires either an SSL certificate to be trusted by Azure or the provisioning agent to be used. The certificate subject must match the host name the Microsoft Entra ECMA Connector Host is installed on.

#### Anchor attributes
   The Microsoft Entra ECMA Connector Host currently doesn't support anchor attribute changes (renames) or target systems, which require multiple attributes to form an anchor. 

#### Attribute discovery and mapping
   The attributes that the target application supports are discovered and surfaced in the Microsoft Entra admin center in **Attribute Mappings**. Newly added attributes will continue to be discovered. If an attribute type has changed, for example, string to Boolean, and the attribute is part of the mappings, the type won't change automatically in the Microsoft Entra admin center. Customers will need to go into advanced settings in mappings and manually update the attribute type.

#### Provisioning agent
- The agent doesn't currently support auto update for the on-premises application provisioning scenario. We're actively working to close this gap and ensure that auto update is enabled by default and required for all customers. 
- The same provisioning agent can't be used for on-premises app provisioning and cloud sync / HR- driven provisioning. 

::: zone-end

## Next steps
[How provisioning works](how-provisioning-works.md)

---
title: 'Attributes synchronized by Microsoft Entra Connect'
description: Lists the attributes that are synchronized to Microsoft Entra ID.

author: omondiatieno
manager: mwongerapk
ms.assetid: c2bb36e0-5205-454c-b9b6-f4990bcedf51
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: reference
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi


---
# Microsoft Entra Connect Sync: Attributes synchronized to Microsoft Entra ID
This topic lists the attributes that are synchronized by Microsoft Entra Connect Sync.  
The attributes are grouped by the related Microsoft Entra app.

## Attributes to synchronize
A common question is *what is the list of minimum attributes to synchronize*. The default and recommended approach is to keep the default attributes so a full GAL (Global Address List) can be constructed in the cloud and to get all features in Microsoft 365 workloads. In some cases, there are some attributes that your organization does not want synchronized to the cloud since these attributes contain sensitive personal data, like in this example:  
![bad attributes](./media/reference-connect-sync-attributes-synchronized/badextensionattribute.png)

In this case, start with the list of attributes in this topic and identify those attributes that would contain personal data and cannot be synchronized. Then deselect those attributes during installation using [Microsoft Entra app and attribute filtering](how-to-connect-install-custom.md#azure-ad-app-and-attribute-filtering).

> [!WARNING]
> When deselecting attributes, you should be cautious and only deselect those attributes absolutely not possible to synchronize. Unselecting other attributes might have a negative impact on features.
>
>

## Microsoft 365 Apps for enterprise
| Attribute Name | User | Comment |
| --- |:---:| --- |
| :::no-loc text="accountEnabled"::: | X | Defines if an account is enabled. |
| :::no-loc text="cn"::: | X |  |
| :::no-loc text="displayName"::: | X |  |
| :::no-loc text="objectSID"::: | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="pwdLastSet"::: | X | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="samAccountName"::: | X |  |
| :::no-loc text="sourceAnchor"::: | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="usageLocation"::: | X | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X | UPN is the login ID for the user. Most often the same as [mail] value. |

## Exchange Online
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="altRecipient"::: | X |  |  | Requires Microsoft Entra Connect build 1.1.552.0 or after. |
| :::no-loc text="authOrig"::: | X | X | X |  |
| :::no-loc text="c"::: | X | X |  |  |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="co"::: | X | X |  |  |
| :::no-loc text="company"::: | X | X |  |  |
| :::no-loc text="countryCode"::: | X | X |  |  |
| :::no-loc text="department"::: | X | X |  |  |
| :::no-loc text="description"::: |  |  | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="dLMemRejectPerms"::: | X | X | X |  |
| :::no-loc text="dLMemSubmitPerms"::: | X | X | X |  |
| :::no-loc text="extensionAttribute1"::: | X | X | X |  |
| :::no-loc text="extensionAttribute10"::: | X | X | X |  |
| :::no-loc text="extensionAttribute11"::: | X | X | X |  |
| :::no-loc text="extensionAttribute12"::: | X | X | X |  |
| :::no-loc text="extensionAttribute13"::: | X | X | X |  |
| :::no-loc text="extensionAttribute14"::: | X | X | X |  |
| :::no-loc text="extensionAttribute15"::: | X | X | X |  |
| :::no-loc text="extensionAttribute2"::: | X | X | X |  |
| :::no-loc text="extensionAttribute3"::: | X | X | X |  |
| :::no-loc text="extensionAttribute4"::: | X | X | X |  |
| :::no-loc text="extensionAttribute5"::: | X | X | X |  |
| :::no-loc text="extensionAttribute6"::: | X | X | X |  |
| :::no-loc text="extensionAttribute7"::: | X | X | X |  |
| :::no-loc text="extensionAttribute8"::: | X | X | X |  |
| :::no-loc text="extensionAttribute9"::: | X | X | X |  |
| :::no-loc text="facsimiletelephonenumber"::: | X | X |  |  |
| :::no-loc text="givenName"::: | X | X |  |  |
| :::no-loc text="homePhone"::: | X | X |  |  |
| :::no-loc text="info"::: | X | X | X | This attribute is currently not consumed for groups. |
| :::no-loc text="Initials"::: | X | X |  |  |
| :::no-loc text="l"::: | X | X |  |  |
| :::no-loc text="legacyExchangeDN"::: | X | X | X |  |
| :::no-loc text="mailNickname"::: | X | X | X |  |
| :::no-loc text="managedBy"::: |  |  | X |  |
| :::no-loc text="manager"::: | X | X |  |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="mobile"::: | X | X |  |  |
| :::no-loc text="msDS-HABSeniorityIndex"::: | X | X | X |  |
| :::no-loc text="msDS-PhoneticDisplayName"::: | X | X | X |  |
| :::no-loc text="msExchArchiveGUID"::: | X |  |  |  |
| :::no-loc text="msExchArchiveName"::: | X |  |  |  |
| :::no-loc text="msExchAssistantName"::: | X | X |  |  |
| :::no-loc text="msExchAuditAdmin"::: | X |  |  |  |
| :::no-loc text="msExchAuditDelegate"::: | X |  |  |  |
| :::no-loc text="msExchAuditDelegateAdmin"::: | X |  |  |  |
| :::no-loc text="msExchAuditOwner"::: | X |  |  |  |
| :::no-loc text="msExchBlockedSendersHash"::: | X | X |  |  |
| :::no-loc text="msExchBypassAudit"::: | X |  |  |  |
| :::no-loc text="msExchBypassModerationLink"::: |  |  | X | Available in Microsoft Entra Connect version 1.1.524.0 |
| :::no-loc text="msExchCoManagedByLink"::: |  |  | X |  |
| :::no-loc text="msExchDelegateListLink"::: | X |  |  |  |
| :::no-loc text="msExchELCExpirySuspensionEnd"::: | X |  |  |  |
| :::no-loc text="msExchELCExpirySuspensionStart"::: | X |  |  |  |
| :::no-loc text="msExchELCMailboxFlags"::: | X |  |  |  |
| :::no-loc text="msExchEnableModeration"::: | X |  | X |  |
| :::no-loc text="msExchExtensionCustomAttribute1"::: | X | X | X | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchExtensionCustomAttribute2"::: | X | X | X | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchExtensionCustomAttribute3"::: | X | X | X | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchExtensionCustomAttribute4"::: | X | X | X | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchExtensionCustomAttribute5"::: | X | X | X | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchHideFromAddressLists"::: | X | X | X |  |
| :::no-loc text="msExchImmutableID"::: | X |  |  |  |
| :::no-loc text="msExchLitigationHoldDate"::: | X | X | X |  |
| :::no-loc text="msExchLitigationHoldOwner"::: | X | X | X |  |
| :::no-loc text="msExchMailboxAuditEnable"::: | X |  |  |  |
| :::no-loc text="msExchMailboxAuditLogAgeLimit"::: | X |  |  |  |
| :::no-loc text="msExchMailboxGuid"::: | X |  |  |  |
| :::no-loc text="msExchModeratedByLink"::: | X | X | X |  |
| :::no-loc text="msExchModerationFlags"::: | X | X | X |  |
| :::no-loc text="msExchRecipientDisplayType"::: | X | X | X |  |
| :::no-loc text="msExchRecipientTypeDetails"::: | X | X | X |  |
| :::no-loc text="msExchRemoteRecipientType"::: | X |  |  |  |
| :::no-loc text="msExchRequireAuthToSendTo"::: | X | X | X |  |
| :::no-loc text="msExchResourceCapacity"::: | X |  |  | This attribute is currently not consumed by Exchange Online. |
| :::no-loc text="msExchResourceDisplay"::: | X |  |  |  |
| :::no-loc text="msExchResourceMetaData"::: | X |  |  |  |
| :::no-loc text="msExchResourceSearchProperties"::: | X |  |  |  |
| :::no-loc text="msExchRetentionComment"::: | X | X | X |  |
| :::no-loc text="msExchRetentionURL"::: | X | X | X |  |
| :::no-loc text="msExchSafeRecipientsHash"::: | X | X |  |  |
| :::no-loc text="msExchSafeSendersHash"::: | X | X |  |  |
| :::no-loc text="msExchSenderHintTranslations"::: | X | X | X |  |
| :::no-loc text="msExchTeamMailboxExpiration"::: | X |  |  |  |
| :::no-loc text="msExchTeamMailboxOwners"::: | X |  |  |  |
| :::no-loc text="msExchTeamMailboxSharePointUrl"::: | X |  |  |  |
| :::no-loc text="msExchUserHoldPolicies"::: | X |  |  |  |
| :::no-loc text="msOrg-IsOrganizational"::: |  |  | X |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="oOFReplyToOriginator"::: |  |  | X |  |
| :::no-loc text="otherFacsimileTelephone"::: | X | X |  |  |
| :::no-loc text="otherHomePhone"::: | X | X |  |  |
| :::no-loc text="otherTelephone"::: | X | X |  |  |
| :::no-loc text="pager"::: | X | X |  |  |
| :::no-loc text="physicalDeliveryOfficeName"::: | X | X |  |  |
| :::no-loc text="postalCode"::: | X | X |  |  |
| :::no-loc text="proxyAddresses"::: | X | X | X |  |
| :::no-loc text="publicDelegates"::: | X | X | X |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password sync and federation. |
| :::no-loc text="reportToOriginator"::: |  |  | X |  |
| :::no-loc text="reportToOwner"::: |  |  | X |  |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sn"::: | X | X |  |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="st"::: | X | X |  |  |
| :::no-loc text="streetAddress"::: | X | X |  |  |
| :::no-loc text="targetAddress"::: | X | X |  |  |
| :::no-loc text="telephoneAssistant"::: | X | X |  |  |
| :::no-loc text="telephoneNumber"::: | X | X |  |  |
| :::no-loc text="thumbnailphoto"::: | X | X |  | Synced to M365 profile photo periodically. Admins can set the frequency of the sync by changing the Microsoft Entra Connect value. Please note that if users change their photo both on-premises and in cloud in a time span that is less than the Microsoft Entra Connect value, we do not guarantee that the latest photo will be served. |
| :::no-loc text="title"::: | X | X |  |  |
| :::no-loc text="unauthOrig"::: | X | X | X |  |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userCertificate"::: | X | X |  |  |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |
| :::no-loc text="userSMIMECertificates"::: | X | X |  |  |
| :::no-loc text="wWWHomePage"::: | X | X |  |  |

## SharePoint Online
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="authOrig"::: | X | X | X |  |
| :::no-loc text="c"::: | X | X |  |  |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="co"::: | X | X |  |  |
| :::no-loc text="company"::: | X | X |  |  |
| :::no-loc text="countryCode"::: | X | X |  |  |
| :::no-loc text="department"::: | X | X |  |  |
| :::no-loc text="description"::: | X | X | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="dLMemRejectPerms"::: | X | X | X |  |
| :::no-loc text="dLMemSubmitPerms"::: | X | X | X |  |
| :::no-loc text="extensionAttribute1"::: | X | X | X |  |
| :::no-loc text="extensionAttribute10"::: | X | X | X |  |
| :::no-loc text="extensionAttribute11"::: | X | X | X |  |
| :::no-loc text="extensionAttribute12"::: | X | X | X |  |
| :::no-loc text="extensionAttribute13"::: | X | X | X |  |
| :::no-loc text="extensionAttribute14"::: | X | X | X |  |
| :::no-loc text="extensionAttribute15"::: | X | X | X |  |
| :::no-loc text="extensionAttribute2"::: | X | X | X |  |
| :::no-loc text="extensionAttribute3"::: | X | X | X |  |
| :::no-loc text="extensionAttribute4"::: | X | X | X |  |
| :::no-loc text="extensionAttribute5"::: | X | X | X |  |
| :::no-loc text="extensionAttribute6"::: | X | X | X |  |
| :::no-loc text="extensionAttribute7"::: | X | X | X |  |
| :::no-loc text="extensionAttribute8"::: | X | X | X |  |
| :::no-loc text="extensionAttribute9"::: | X | X | X |  |
| :::no-loc text="facsimiletelephonenumber"::: | X | X |  |  |
| :::no-loc text="givenName"::: | X | X |  |  |
| :::no-loc text="hideDLMembership"::: |  |  | X |  |
| :::no-loc text="homephone"::: | X | X |  |  |
| :::no-loc text="info"::: | X | X | X |  |
| :::no-loc text="initials"::: | X | X |  |  |
| :::no-loc text="ipPhone"::: | X | X |  |  |
| :::no-loc text="l"::: | X | X |  |  |
| :::no-loc text="mail"::: | X | X | X |  |
| :::no-loc text="mailnickname"::: | X | X | X |  |
| :::no-loc text="managedBy"::: |  |  | X |  |
| :::no-loc text="manager"::: | X | X |  |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="middleName"::: | X | X |  |  |
| :::no-loc text="mobile"::: | X | X |  |  |
| :::no-loc text="msExchTeamMailboxExpiration"::: | X |  |  |  |
| :::no-loc text="msExchTeamMailboxOwners"::: | X |  |  |  |
| :::no-loc text="msExchTeamMailboxSharePointLinkedBy"::: | X |  |  |  |
| :::no-loc text="msExchTeamMailboxSharePointUrl"::: | X |  |  |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="oOFReplyToOriginator"::: |  |  | X |  |
| :::no-loc text="otherFacsimileTelephone"::: | X | X |  |  |
| :::no-loc text="otherHomePhone"::: | X | X |  |  |
| :::no-loc text="otherIpPhone"::: | X | X |  |  |
| :::no-loc text="otherMobile"::: | X | X |  |  |
| :::no-loc text="otherPager"::: | X | X |  |  |
| :::no-loc text="otherTelephone"::: | X | X |  |  |
| :::no-loc text="pager"::: | X | X |  |  |
| :::no-loc text="physicalDeliveryOfficeName"::: | X | X |  |  |
| :::no-loc text="postalCode"::: | X | X |  |  |
| :::no-loc text="postOfficeBox"::: | X | X |  | This attribute is currently not consumed by SharePoint Online. |
| :::no-loc text="preferredLanguage"::: | X |  |  |  |
| :::no-loc text="proxyAddresses"::: | X | X | X |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="reportToOriginator"::: |  |  | X |  |
| :::no-loc text="reportToOwner"::: |  |  | X |  |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sn"::: | X | X |  |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="st"::: | X | X |  |  |
| :::no-loc text="streetAddress"::: | X | X |  |  |
| :::no-loc text="targetAddress"::: | X | X |  |  |
| :::no-loc text="telephoneAssistant"::: | X | X |  |  |
| :::no-loc text="telephoneNumber"::: | X | X |  |  |
| :::no-loc text="thumbnailphoto"::: | X | X |  | Synced to M365 profile photo periodically. Admins can set the frequency of the sync by changing the Microsoft Entra Connect value. Please note that if users change their photo both on-premises and in cloud in a time span that is less than the Microsoft Entra Connect value, we do not guarantee that the latest photo will be served. |
| :::no-loc text="title"::: | X | X |  |  |
| :::no-loc text="unauthOrig"::: | X | X | X |  |
| :::no-loc text="url"::: | X | X |  |  |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region |
. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |
| :::no-loc text="wWWHomePage"::: | X | X |  |  |

## Teams and Skype for Business Online
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="c"::: | X | X |  |  |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="co"::: | X | X |  |  |
| :::no-loc text="company"::: | X | X |  |  |
| :::no-loc text="department"::: | X | X |  |  |
| :::no-loc text="description"::: | X | X | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="facsimiletelephonenumber"::: | X | X | X |  |
| :::no-loc text="givenName"::: | X | X |  |  |
| :::no-loc text="homephone"::: | X | X |  |  |
| :::no-loc text="ipPhone"::: | X | X |  |  |
| :::no-loc text="l"::: | X | X |  |  |
| :::no-loc text="mail"::: | X | X | X |  |
| :::no-loc text="mailNickname"::: | X | X | X |  |
| :::no-loc text="managedBy"::: |  |  | X |  |
| :::no-loc text="manager"::: | X | X |  |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="mobile"::: | X | X |  |  |
| :::no-loc text="msExchHideFromAddressLists"::: | X | X | X |  |
| :::no-loc text="msRTCSIP-ApplicationOptions"::: | X |  |  |  |
| :::no-loc text="msRTCSIP-DeploymentLocator"::: | X | X |  |  |
| :::no-loc text="msRTCSIP-Line"::: | X | X |  |  |
| :::no-loc text="msRTCSIP-OptionFlags"::: | X | X |  |  |
| :::no-loc text="msRTCSIP-OwnerUrn"::: | X |  |  |  |
| :::no-loc text="msRTCSIP-PrimaryUserAddress"::: | X | X |  |  |
| :::no-loc text="msRTCSIP-UserEnabled"::: | X | X |  |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="otherTelephone"::: | X | X |  |  |
| :::no-loc text="physicalDeliveryOfficeName"::: | X | X |  |  |
| :::no-loc text="postalCode"::: | X | X |  |  |
| :::no-loc text="preferredLanguage"::: | X |  |  |  |
| :::no-loc text="proxyAddresses"::: | X | X | X |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sn"::: | X | X |  |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="st"::: | X | X |  |  |
| :::no-loc text="streetAddress"::: | X | X |  |  |
| :::no-loc text="telephoneNumber"::: | X | X |  |  |
| :::no-loc text="thumbnailphoto"::: | X | X |  | Synced to M365 profile photo periodically. Admins can set the frequency of the sync by changing the Microsoft Entra Connect value. Please note that if users change their photo both on-premises and in cloud in a time span that is less than the Microsoft Entra Connect value, we do not guarantee that the latest photo will be served. |
| :::no-loc text="title"::: | X | X |  |  |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |
| :::no-loc text="wWWHomePage"::: | X | X |  |  |

## Azure RMS
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="cn"::: | X |  | X | Common name or alias. Most often the prefix of [mail] value. |
| :::no-loc text="displayName"::: | X | X | X | A string that represents the name often shown as the friendly name (first name last name). |
| :::no-loc text="mail"::: | X | X | X | full email address. |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="proxyAddresses"::: | X | X | X | mechanical property. Used by Microsoft Entra ID. Contains all secondary email addresses for the user. |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | This UPN is the login ID for the user. Most often the same as [mail] value. |

## Intune
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="c"::: | X | X |  |  |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="description"::: | X | X | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="mail"::: | X | X | X |  |
| :::no-loc text="mailnickname"::: | X | X | X |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="proxyAddresses"::: | X | X | X |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |

## Dynamics CRM
| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="c"::: | X | X |  |  |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="co"::: | X | X |  |  |
| :::no-loc text="company"::: | X | X |  |  |
| :::no-loc text="countryCode"::: | X | X |  |  |
| :::no-loc text="description"::: | X | X | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="facsimiletelephonenumber"::: | X | X |  |  |
| :::no-loc text="givenName"::: | X | X |  |  |
| :::no-loc text="l"::: | X | X |  |  |
| :::no-loc text="managedBy"::: |  |  | X |  |
| :::no-loc text="manager"::: | X | X |  |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="mobile"::: | X | X |  |  |
| :::no-loc text="objectSID"::: | X |  | X | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="physicalDeliveryOfficeName"::: | X | X |  |  |
| :::no-loc text="postalCode"::: | X | X |  |  |
| :::no-loc text="preferredLanguage"::: | X |  |  |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sn"::: | X | X |  |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="st"::: | X | X |  |  |
| :::no-loc text="streetAddress"::: | X | X |  |  |
| :::no-loc text="telephoneNumber"::: | X | X |  |  |
| :::no-loc text="title"::: | X | X |  |  |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |

## 3rd party applications
This group is a set of attributes used as the minimal attributes needed for a generic workload or application. It can be used for a workload not listed in another section or for a non-Microsoft app. It is explicitly used for the following:

* Yammer (only User is consumed)
* [Hybrid Business-to-Business (B2B) cross-org collaboration scenarios offered by resources like SharePoint](/sharepoint/create-b2b-extranet)

This group is a set of attributes that can be used if the Microsoft Entra directory is not used to support Microsoft 365, Dynamics, or Intune. It has a small set of core attributes. Note that single sign-on or provisioning to some third-party applications requires configuring synchronization of attributes in addition to the attributes described here. Application requirements are described in the [SaaS app tutorial](~/identity/saas-apps/tutorial-list.md) for each application.

| Attribute Name | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |  | Defines if an account is enabled. |
| :::no-loc text="cn"::: | X |  | X |  |
| :::no-loc text="displayName"::: | X | X | X |  |
| :::no-loc text="employeeID"::: | X |  |  |  |
| :::no-loc text="givenName"::: | X | X |  |  |
| :::no-loc text="mail"::: | X |  | X |  |
| :::no-loc text="managedBy"::: |  |  | X |  |
| :::no-loc text="mailNickName"::: | X | X | X |  |
| :::no-loc text="member"::: |  |  | X |  |
| :::no-loc text="objectSID"::: | X |  |  | mechanical property. AD user identifier used to maintain sync between Microsoft Entra ID and AD. |
| :::no-loc text="proxyAddresses"::: | X | X | X |  |
| :::no-loc text="pwdLastSet"::: | X |  |  | mechanical property. Used to know when to invalidate already issued tokens. Used by both password hash sync, pass-through authentication and federation. |
| :::no-loc text="securityEnabled"::: |  |  | X |  |
| :::no-loc text="sn"::: | X | X |  |  |
| :::no-loc text="sourceAnchor"::: | X | X | X | mechanical property. Immutable identifier to maintain relationship between ADDS and Microsoft Entra ID. |
| :::no-loc text="usageLocation"::: | X |  |  | mechanical property. The user’s country/region. Used for license assignment. |
| :::no-loc text="userPrincipalName"::: | X |  |  | UPN is the login ID for the user. Most often the same as [mail] value. |

## Windows 10
A Windows 10 domain-joined computer(device) synchronizes some attributes to Microsoft Entra ID. For more information on the scenarios, see [Connect domain-joined devices to Microsoft Entra ID for Windows 10 experiences](~/identity/devices/hybrid-join-plan.md). These attributes always synchronize and Windows 10 does not appear as an app you can unselect. A Windows 10 domain-joined computer is identified by having the attribute userCertificate populated.

| Attribute Name | Device | Comment |
| --- |:---:| --- |
| :::no-loc text="accountEnabled"::: | X |  |
| :::no-loc text="deviceTrustType"::: | X | Hardcoded value for domain-joined computers. |
| :::no-loc text="displayName"::: | X |  |
| :::no-loc text="ms-DS-CreatorSID"::: | X | Also called registeredOwnerReference. |
| :::no-loc text="objectGUID"::: | X | Also called deviceID. |
| :::no-loc text="objectSID"::: | X | Also called onPremisesSecurityIdentifier. |
| :::no-loc text="operatingSystem"::: | X | Also called deviceOSType. |
| :::no-loc text="operatingSystemVersion"::: | X | Also called deviceOSVersion. |
| :::no-loc text="userCertificate"::: | X |  |

These attributes for **user** are in addition to the other apps you have selected.  

| Attribute Name | User | Comment |
| --- |:---:| --- |
| :::no-loc text="domainFQDN"::: | X | Also called dnsDomainName. For example, contoso.com. |
| :::no-loc text="domainNetBios"::: | X | Also called netBiosName. For example, CONTOSO. |
| :::no-loc text="msDS-KeyCredentialLink"::: | X | Once the user is enrolled in Windows Hello for Business. |  |

## Exchange hybrid writeback
These attributes are written back from Microsoft Entra ID to on-premises Active Directory when you select to enable **Exchange hybrid**. Depending on your Exchange version, fewer attributes might be synchronized.

| Attribute Name (On-premises AD) | Attribute Name (Connect UI) | User | Contact | Group | Comment |
| --- |:---:|:---:|:---:| --- |---|
| :::no-loc text="msDS-ExternalDirectoryObjectID"::: | ms-DS-External-Directory-Object-Id | X |  |  | Derived from cloudAnchor in Microsoft Entra ID. This attribute is new in Exchange 2016 and Windows Server 2016 AD. |
| :::no-loc text="msExchArchiveStatus"::: | ms-Exch-ArchiveStatus | X |  |  | Online Archive: Enables customers to archive mail. |
| :::no-loc text="msExchBlockedSendersHash"::: | ms-Exch-BlockedSendersHash | X |  |  | Filtering: Writes back on-premises filtering and online safe and blocked sender data from clients. |
| :::no-loc text="msExchSafeRecipientsHash"::: | ms-Exch-SafeRecipientsHash | X |  |  | Filtering: Writes back on-premises filtering and online safe and blocked sender data from clients. |
| :::no-loc text="msExchSafeSendersHash"::: | ms-Exch-SafeSendersHash | X |  |  | Filtering: Writes back on-premises filtering and online safe and blocked sender data from clients. |
| :::no-loc text="msExchUCVoiceMailSettings"::: | ms-Exch-UCVoiceMailSettings | X |  |  | Enable Unified Messaging (UM) - Online voice mail: Used by Microsoft Lync Server integration to indicate to Lync Server on-premises that the user has voice mail in online services. |
| :::no-loc text="msExchUserHoldPolicies"::: | ms-Exch-UserHoldPolicies | X |  |  | Litigation Hold: Enables cloud services to determine which users are under Litigation Hold. |
| :::no-loc text="proxyAddresses"::: | proxyAddresses | X | X | X | Only the x500 address from Exchange Online is inserted. |
| :::no-loc text="publicDelegates"::: | ms-Exch-Public-Delegates | X |  |  | Allows an Exchange Online mailbox to be granted SendOnBehalfTo rights to users with on-premises Exchange mailbox. Requires Microsoft Entra Connect build 1.1.552.0 or after. |

## Exchange Mail Public Folder
These attributes are synchronized from on-premises Active Directory to Microsoft Entra ID when you select to enable **Exchange Mail Public Folder**.

| Attribute Name | PublicFolder | Comment |
| --- | :---:| --- |
| :::no-loc text="displayName"::: | X |  |
| :::no-loc text="mail"::: | X |  |
| :::no-loc text="msExchRecipientTypeDetails"::: | X |  |
| :::no-loc text="objectGUID"::: | X |  |
| :::no-loc text="proxyAddresses"::: | X |  |
| :::no-loc text="targetAddress"::: | X |  |

## Device writeback
Device objects are created in Active Directory. These objects can be devices joined to Microsoft Entra ID or domain-joined Windows 10 computers.

| Attribute Name | Device | Comment |
| --- |:---:| --- |
| :::no-loc text="altSecurityIdentities"::: | X |  |
| :::no-loc text="displayName"::: | X |  |
| :::no-loc text="dn"::: | X |  |
| :::no-loc text="msDS-CloudAnchor"::: | X |  |
| :::no-loc text="msDS-DeviceID"::: | X |  |
| :::no-loc text="msDS-DeviceObjectVersion"::: | X |  |
| :::no-loc text="msDS-DeviceOSType"::: | X |  |
| :::no-loc text="msDS-DeviceOSVersion"::: | X |  |
| :::no-loc text="msDS-DevicePhysicalIDs"::: | X |  |
| :::no-loc text="msDS-KeyCredentialLink"::: | X | Only with Windows Server 2016 AD schema |
| :::no-loc text="msDS-IsCompliant"::: | X |  |
| :::no-loc text="msDS-IsEnabled"::: | X |  |
| :::no-loc text="msDS-IsManaged"::: | X |  |
| :::no-loc text="msDS-RegisteredOwner"::: | X |  |

## Notes
* When using an Alternate ID, the on-premises attribute userPrincipalName is synchronized with the Microsoft Entra attribute onPremisesUserPrincipalName. The Alternate ID attribute, for example mail, is synchronized with the Microsoft Entra attribute userPrincipalName.
* Although there is no enforcement of uniqueness on the Microsoft Entra onPremisesUserPrincipalName attribute, it is not supported to sync the same UserPrincipalName value to the Microsoft Entra onPremisesUserPrincipalName attribute for multiple different Microsoft Entra users.
* In the lists above, the object type **User** also applies to the object type **iNetOrgPerson**.

## Next steps
Learn more about the [Microsoft Entra Connect Sync](how-to-connect-sync-whatis.md) configuration.

Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).

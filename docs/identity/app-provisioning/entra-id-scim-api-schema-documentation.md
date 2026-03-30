---
title: Microsoft Entra ID SCIM API schema documentation
description: This article provides a reference for SCIM schema attributes, including core user and group attributes, enterprise extensions, and Microsoft Entra-specific extensions, along with their mappings to Microsoft Entra ID properties.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 03/30/2026
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As a developer or IT administrator, I want to understand how to integrate with Microsoft Entra ID using the SCIM v2.0 protocol so that I can programmatically provision, manage, and synchronize users and groups between my application and Microsoft Entra ID.

---

# Microsoft Entra ID SCIM API schema 

Microsoft Entra ID SCIM API supports standard SCIM schema elements and Microsoft Entra ID specific extensions. The SCIM schema is published at the endpoint [https://graph.microsoft.com/rp/scim/schemas](https://graph.microsoft.com/rp/scim/schemas)
This article describes how SCIM schema attributes map to Microsoft Entra ID [user properties](/graph/api/resources/user#properties) and [group properties](/graph/api/resources/group#properties).

> [!NOTE] 
> Attribute value constraints enforced by Microsoft Entra ID also apply to the corresponding SCIM attribute.
 

## User - Core

| SCIM Attribute | Entra ID Attribute | Notes / Restrictions |
|---|---|---|
| active | accountEnabled |  |
| addresses[type eq "work"].country | country | Only one *addresses* value is allowed, and it requires a type of "work". |
| addresses[type eq "work"].locality | city |
| addresses[type eq "work"].postalCode | postalCode |
| addresses[type eq "work"].region | state |
| addresses[type eq "work"].streetAddress | streetAddress |
| displayName | displayName |  |
| emails[type eq "other"].value | otherMails | A list of email addresses associated with the user that may not be linked to their Exchange Online recipient object, such as a personal email address. |
| emails[type eq "proxyAddress".value | proxyAddresses - only for values that start with smtp: (case-insensitive) | A read-only list of email addresses(Note: This attribute is currently implemented as type work, primary false and will change in an upcoming release) |
| emails[type eq "work" and primary eq true].value | mail | Only one value of type "work" and primary *true* is allowed. |
| externalId | crossDomainData.scim.v2.externalId | This attribute is persisted in the Graph entity `crossDomainData`. |
| groups.value | *See notes* | Read only. The user’s group memberships. This attribute is never returned in the JSON body of a user and is only usable for filter queries. |
| ims[type eq "work"].value | imAddresses |  |
| name.familyName | surname |  |
| name.givenName | givenName |  |
| password | *See notes* | Required for users with a userName value containing a domain name that is managed (nonfederated). Write only (can't be read). Can only be set on user creation, can't be used to update a user’s password. |
| phoneNumbers[type eq "fax"].value | faxNumber | Only one value of this type is allowed. |
| phoneNumbers[type eq "mobile"].value | mobilePhone | Only one value of this type is allowed. |
| phoneNumbers[type eq "work"].value | businessPhones | Only one value of this type is allowed. |
| preferredLanguage | preferredLanguage | Only allows a single language value and doesn't accept a ranked preference list. |
| title | jobTitle |  |
| userName | userPrincipalName |  |
| userType | employeeType |  |

## User - Enterprise Extension

Attributes in this table are part of namespace ```urn:ietf:params:scim:schemas:extension:enterprise:2.0:User```.

| SCIM Attribute  | Entra ID Attribute          |
|-----------------|-----------------------------|
| costCenter      | employeeOrgData.costCenter  |
| department      | department                  |
| division        | employeeOrgData.division    |
| employeeNumber  | employeeId                  |
| manager.value   | manager                     |
| organization    | companyName                 |

## User - Microsoft Entra Extension

Attributes in this table are part of namespace ```urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User```.

| SCIM Attribute | Entra ID Attribute |
|---|---|
| creationType | creationType |
| employeeHireDate | employeeHireDate |
| employeeLeaveDateTime | employeeLeaveDateTime |
| lastPasswordChangeDateTime | lastPasswordChangeDateTime |
| mailNickname | mailNickname |
| officeLocation | officeLocation |
| onPremisesDistinguishedName | onPremisesDistinguishedName |
| onPremisesDomainName | onPremisesDomainName |
| onPremisesExtensionAttributes.extensionAttribute1 | extensionAttribute1 |
| onPremisesExtensionAttributes.extensionAttribute10 | extensionAttribute10 |
| onPremisesExtensionAttributes.extensionAttribute11 | extensionAttribute11 |
| onPremisesExtensionAttributes.extensionAttribute12 | extensionAttribute12 |
| onPremisesExtensionAttributes.extensionAttribute13 | extensionAttribute13 |
| onPremisesExtensionAttributes.extensionAttribute14 | extensionAttribute14 |
| onPremisesExtensionAttributes.extensionAttribute15 | extensionAttribute15 |
| onPremisesExtensionAttributes.extensionAttribute2 | extensionAttribute2 |
| onPremisesExtensionAttributes.extensionAttribute3 | extensionAttribute3 |
| onPremisesExtensionAttributes.extensionAttribute4 | extensionAttribute4 |
| onPremisesExtensionAttributes.extensionAttribute5 | extensionAttribute5 |
| onPremisesExtensionAttributes.extensionAttribute6 | extensionAttribute6 |
| onPremisesExtensionAttributes.extensionAttribute7 | extensionAttribute7 |
| onPremisesExtensionAttributes.extensionAttribute8 | extensionAttribute8 |
| onPremisesExtensionAttributes.extensionAttribute9 | extensionAttribute9 |
| onPremisesImmutableId | onPremisesImmutableId |
| onPremisesSAMAccountName | onPremisesSAMAccountName |
| onPremisesSecurityIdentifier | onPremisesSecurityIdentifier |
| onPremisesSyncEnabled | onPremisesSyncEnabled |
| onPremisesUserPrincipalName | onPremisesUserPrincipalName |
| passwordForceChangeOnNextSignIn | passwordProfile.forceChangePasswordNextSignIn |
| passwordForceChangeOnNextSignInWithMFA | passwordProfile.forceChangePasswordNextSignInWithMFA |
| preferredDataLocation | preferredDataLocation |
| proxyAddresses | proxyAddresses (all values) |
| usageLocation | usageLocation |
| userType | userType |

> [!NOTE] 
> The Microsoft Entra extension namespace doesn't include Microsoft Entra ID Directory Extensions of the form `extension_{appId-without-hyphens}_{extensionProperty-name}`. The SCIM APIs don't support retrieving these attributes on the user profile.

## Group – Core

| SCIM Attribute | Entra ID Attribute | Notes / Restrictions |
|----|----|----|
| displayName | displayName |  |
| members.value | *See Notes column* | Read only. The group’s members. This attribute is never returned in the JSON body of a user and is only usable for filter queries. |

## Group – Microsoft Entra Extension

Attributes in this table are part of namespace ```urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group```.

| SCIM Attribute               | Entra ID Attribute           |
|------------------------------|------------------------------|
| description                  | description                  |
| expirationDateTime           | expirationDateTime           |
| groupTypes                   | groupTypes                   |
| mailEnabled                  | mailEnabled                  |
| mailNickname                 | mailNickname                 |
| onPremisesSAMAccountName     | onPremisesSAMAccountName     |
| onPremisesSecurityIdentifier | onPremisesSecurityIdentifier |
| onPremisesSyncEnabled        | onPremisesSyncEnabled        |
| proxyAddresses               | proxyAddresses (all values)  |
| securityEnabled              | securityEnabled              |
| securityIdentifier           | securityIdentifier           |

## Custom Security Attributes namespace

If you have Custom Security Attributes defined in your Microsoft Entra ID tenant, then use this namespace `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes` in your SCIM requests.
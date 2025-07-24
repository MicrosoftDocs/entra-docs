---
title: Default user permissions
description: Compare the default user permissions available in Microsoft Entra ID and learn how to restrict access.
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 03/05/2025
ms.author: barclayn
ms.reviewer: vincesm
ms.custom: sfi-ga-nochange, sfi-image-nochange
---
# What are the default user permissions in Microsoft Entra ID?

In Microsoft Entra ID, all users are granted a set of default permissions. A user's access consists of the type of user, their [role assignments](./how-subscriptions-associated-directory.yml), and their ownership of individual objects. 

This article describes those default permissions and compares the member and guest user defaults. The default user permissions can be changed only in user settings in Microsoft Entra ID.

## Member and guest users

The set of default permissions depends on whether the user is a native member of the tenant (member user) or is brought over from another directory, such as a business-to-business (B2B) collaboration guest (guest user). For more information about adding guest users, see [What is Microsoft Entra B2B collaboration?](~/external-id/what-is-b2b.md). Here are the capabilities of the default permissions:

* *Member users* can register applications, manage their own profile photo and mobile phone number, change their own password, and invite B2B guests. These users can also read all directory information (with a few exceptions). 
* *Guest users* have restricted directory permissions. They can manage their own profile, change their own password, and retrieve some information about other users, groups, and apps. However, they can't read all directory information. 

  For example, guest users can't enumerate the list of all users, groups, and other directory objects. Guests can be added to administrator roles, which grant them full read and write permissions. Guests can also invite other guests.

## Compare member and guest default permissions

| **Area** | **Member user permissions** | **Default guest user permissions** | **Restricted guest user permissions** |
| ------------ | --------- | ---------- | ---------- |
| Users and contacts | <ul><li>Enumerate the list of all users and contacts<li>Read all public properties of users and contacts</li><li>Invite guests<li>Change their own password<li>Manage their own mobile phone number<li>Manage their own photo<li>Invalidate their own refresh tokens</li></ul> | <ul><li>Read their own properties<li>Read display name, email, sign-in name, photo, user principal name, and user type properties of other users and contacts<li>Change their own password<li>Search for another user by object ID (if allowed)<li>Read manager and direct report information of other users</li></ul> | <ul><li>Read their own properties<li>Change their own password</li><li>Manage their own mobile phone number</li></ul> |
| Groups | <ul><li>Create security groups<li>Create Microsoft 365 groups<li>Enumerate the list of all groups<li>Read all properties of groups<li>Read nonhidden group membership<li>Read hidden Microsoft 365 group membership for joined groups<li>Manage properties, ownership, and membership of groups that the user owns<li>Add guests to owned groups<li>Manage group membership settings<li>Delete owned groups<li>Restore owned Microsoft 365 groups</li></ul> | <ul><li>Read properties of nonhidden groups, including membership and ownership (even nonjoined groups)<li>Read hidden Microsoft 365 group membership for joined groups<li>Search for groups by display name or object ID (if allowed)</li></ul> | <ul><li>Read object ID for joined groups<li>Read membership and ownership of joined groups in some Microsoft 365 apps (if allowed)</li></ul> |
| Applications | <ul><li>Register (create) new applications<li>Enumerate the list of all applications<li>Read properties of registered and enterprise applications<li>Manage application properties, assignments, and credentials for owned applications<li>Create or delete application passwords for users<li>Delete owned applications<li>Restore owned applications<li>List permissions granted to applications</ul> | <ul><li>Read properties of registered and enterprise applications<li>List permissions granted to applications</ul> | <ul><li>Read properties of registered and enterprise applications</li><li>List permissions granted to applications</li></ul> |
| Devices</li></ul> | <ul><li>Enumerate the list of all devices<li>Read all properties of devices<li>Manage all properties of owned devices</li></ul> | No permissions | No permissions |
| Organization | <ul><li>Read all company information<li>Read all domains<li>Read configuration of certificate-based authentication<li>Read all partner contracts</li><li>Read multitenant organization basic details and active tenants</li></ul> | <ul><li>Read company display name<li>Read all domains<li>Read configuration of certificate-based authentication</li></ul> | <ul><li>Read company display name<li>Read all domains</li></ul> |
| Roles and scopes | <ul><li>Read all administrative roles and memberships<li>Read all properties and membership of administrative units</li></ul> | No permissions | No permissions |
| Subscriptions | <ul><li>Read all licensing subscriptions<li>Enable service plan memberships</li></ul> | No permissions | No permissions |
| Policies | <ul><li>Read all properties of policies<li>Manage all properties of owned policies</li></ul> | No permissions | No permissions |
| Terms of use | Read terms of use a user has accepted. | Read terms of use a user has accepted. | Read terms of use a user has accepted. |

## Restrict member users' default permissions 

It's possible to add restrictions to users' default permissions.

You can restrict default permissions for member users in the following ways:

> [!CAUTION]
> The **Restrict access to Microsoft Entra administration portal** setting limits access to a set of commonly visited admin center pages.  It is **not a security measure**. For more information on the setting, see the following table.

| Permission | Setting explanation |
| ---------- | ------------ |
| **Register applications** | Setting this option to **No** prevents users from creating application registrations. You can then grant the ability back to specific individuals, by adding them to the application developer role. |
| **Allow users to connect work or school account with LinkedIn** | Setting this option to **No** prevents users from connecting their work or school account with their LinkedIn account. For more information, see [LinkedIn account connections data sharing and consent](~/identity/users/linkedin-user-consent.md). |
| **Create security groups** | Setting this option to **No** prevents users from creating security groups. Those users assigned at least the User Administrators role can still create security groups. To learn how, see [Microsoft Entra cmdlets for configuring group settings](~/identity/users/groups-settings-cmdlets.md). |
| **Create Microsoft 365 groups** | Setting this option to **No** prevents users from creating Microsoft 365 groups. Setting this option to **Some** allows a set of users to create Microsoft 365 groups. Anyone assigned at least the [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) role can still create Microsoft 365 groups. To learn how, see [Microsoft Entra cmdlets for configuring group settings](~/identity/users/groups-settings-cmdlets.md). |
| **Restrict access to Microsoft Entra administration portal** | **What does this switch do?** <br>Setting this option to **No** allows non-administrators to sign into the Microsoft Entra admin center. <br>Setting this option to **Yes** adds a layer of friction to casual browsing. This setting restricts non-administrators from loading a set of frequently visited pages in the Microsoft Entra admin center and Azure portal, including home, tenant overview, and the users list. Non-administrators who own groups will be unable to use the Microsoft Entra admin center or Azure portal to manage these resources. Most pages in the admin center remain reachable if the user has a direct (deep) link. </p><p></p><p>**What does it not do?** <br> It **does not block** programmatic access to Microsoft Entra data via PowerShell, Microsoft Graph API, or other tools like Visual Studio. <br>It **does not apply** to users with an administrative role, including custom roles.<br>It **does not prevent** all access to the admin center.  Many areas are still reachable through alternate paths. </p><p></p><p>**When should I use this switch?** <br>Use this setting if you want to add a layer of friction that discourages non-admin users from casually opening the Microsoft Entra admin center. It may help reduce nonessential exploration, but it does not prevent users from accessing or managing their resources through other means. </p><p></p><p>**When should I not use this switch?** <br>Do not rely on this setting as a security control. For stronger enforcement, use a Conditional Access policy targeting the Windows Azure Service Management API [Windows Azure Service Management API](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#windows-azure-service-management-api) to block non-admin access to Azure management endpoints.</p><p></p><p> **How do I grant only a specific non-administrator users the ability to use the Microsoft Entra administration portal?** <br> Set the switch to **Yes**, then assign those users a role such as **Global Reader** or another role that grants appropriate permissions. </p><p></p><p>**Want to restrict access more effectively?** <br>Use Conditional Access to target the Windows Azure Service Management API. This provides broader control over access to all Azure-based management experiences, including the Microsoft Entra admin center. |
| **Restrict non-admin users from creating tenants** | Users can create tenants in the Microsoft Entra ID and Microsoft Entra administration portal under Manage tenant. The creation of a tenant is recorded in the Audit log as category DirectoryManagement and activity Create Company. [!INCLUDE [tenant-installation-account](../includes/definitions/tenant-installation-account.md)] The newly created tenant doesn't inherit any settings or configurations. </p><p></p><p>**What does this switch do?** <br> Setting this option to **Yes** restricts creation of Microsoft Entra tenants to anyone assigned at least the [Tenant Creator](../identity/role-based-access-control/permissions-reference.md#tenant-creator) role. Setting this option to **No** allows nonadmin users to create Microsoft Entra tenants. Tenant create continues to be recorded in the Audit log. </p><p></p><p>**How do I grant only a specific non-administrator users the ability to create new tenants?** <br> Set this option to Yes, then assign them the [Tenant Creator](../identity/role-based-access-control/permissions-reference.md#tenant-creator) role.|
| **Restrict users from recovering the BitLocker key(s) for their owned devices** | This setting can be found in the Microsoft Entra admin center in the Device Settings. Setting this option to **Yes** restricts users from being able to self-service recover BitLocker key(s) for their owned devices. Users must contact their organization's helpdesk to retrieve their BitLocker keys. Setting this option to **No** allows users to recover their BitLocker keys. |
| **Read other users** | This setting is available in Microsoft Graph and PowerShell only. Setting this flag to `$false` prevents all nonadmins from reading user information from the directory. This flag might prevent reading user information in other Microsoft services like Microsoft Teams.</p><p>This setting is meant for special circumstances, so we don't recommend setting the flag to `$false`. |

The **Restricted non-admin users from creating tenants** option is shown in the following screenshot.

:::image type="content" source="media/user-default-permissions/tenant-creation-restriction.png" alt-text="Screenshot showing the option to Restrict nonadmins from creating tenants." lightbox="media/user-default-permissions/tenant-creation-restriction.png":::

## Restrict guest users' default permissions

You can restrict default permissions for guest users in the following ways.

>[!NOTE]
>The **Guest user access restrictions** setting replaced the **Guest users permissions are limited** setting. For guidance on using this feature, see [Restrict guest access permissions in Microsoft Entra ID](~/identity/users/users-restrict-guest-permissions.md).

| Permission | Setting explanation |
| ---------- | ------------ |
| **Guest user access restrictions** | Setting this option to **Guest users have the same access as members** grants all member user permissions to guest users by default.<p>Setting this option to **Guest user access is restricted to properties and memberships of their own directory objects** restricts guest access to only their own user profile by default. Access to other users is no longer allowed, even when they're searching by user principal name, object ID, or display name. Access to group information, including groups memberships, is also no longer allowed.<p>This setting doesn't prevent access to joined groups in some Microsoft 365 services like Microsoft Teams. To learn more, see [Microsoft Teams guest access](/MicrosoftTeams/guest-access).<p>Guest users can still be added to administrator roles regardless of this permission setting. |
| **Guests can invite** | Setting this option to **Yes** allows guests to invite other guests. To learn more, see [Configure external collaboration settings](~/external-id/external-collaboration-settings-configure.md). |

## Object ownership

### Application registration owner permissions

When a user registers an application, they're automatically added as an owner for the application. As an owner, they can manage the metadata of the application, such as the name and permissions that the app requests. They can also manage the tenant-specific configuration of the application, such as the single sign-on (SSO) configuration and user assignments. 

An owner can also add or remove other owners. Unlike those users assigned at least the Application Administrator role, owners can manage only the applications that they own.

### Enterprise application owner permissions

When a user adds a new enterprise application, they're automatically added as an owner. As an owner, they can manage the tenant-specific configuration of the application, such as the SSO configuration, provisioning, and user assignments. 

An owner can also add or remove other owners. Unlike those users assigned at least the Application Administrator role, owners can manage only the applications that they own.

### Group owner permissions

When a user creates a group, they're automatically added as an owner for that group. As an owner, they can manage properties of the group (such as the name) and manage group membership. 

An owner can also add or remove other owners. Unlike those users assigned at least the [Groups Administrator](../identity/role-based-access-control/permissions-reference.md#groups-administrator) role, owners can manage only the groups that they own and they can add or remove group members only if the group's membership type is **Assigned**. 

To assign a group owner, see [Managing owners for a group](./how-to-manage-groups.yml).

To use Privileged Access Management (PIM) to make a group eligible for a role assignment, see [Use Microsoft Entra groups to manage role assignments](~/identity/role-based-access-control/groups-concept.md).

### Ownership permissions

The following tables describe the specific permissions in Microsoft Entra ID that member users have over objects they own. Users have these permissions only on objects that they own.

#### Owned application registrations

Users can perform the following actions on owned application registrations:

| **Action** | **Description** |
| --- | --- |
| microsoft.directory/applications/audience/update | Update the `applications.audience` property in Microsoft Entra ID. |
| microsoft.directory/applications/authentication/update | Update the `applications.authentication` property in Microsoft Entra ID. |
| microsoft.directory/applications/basic/update | Update basic properties on applications in Microsoft Entra ID. |
| microsoft.directory/applications/credentials/update | Update the `applications.credentials` property in Microsoft Entra ID. |
| microsoft.directory/applications/delete | Delete applications in Microsoft Entra ID. |
| microsoft.directory/applications/owners/update | Update the `applications.owners` property in Microsoft Entra ID. |
| microsoft.directory/applications/permissions/update | Update the `applications.permissions` property in Microsoft Entra ID. |
| microsoft.directory/applications/policies/update | Update the `applications.policies` property in Microsoft Entra ID. |
| microsoft.directory/applications/restore | Restore applications in Microsoft Entra ID. |

#### Owned enterprise applications

Users can perform the following actions on owned enterprise applications. An enterprise application consists of a service principal, one or more application policies, and sometimes an application object in the same tenant as the service principal.

| **Action** | **Description** |
| --- | --- |
| microsoft.directory/auditLogs/allProperties/read | Read all properties (including privileged properties) on audit logs in Microsoft Entra ID. |
| microsoft.directory/policies/basic/update | Update basic properties on policies in Microsoft Entra ID. |
| microsoft.directory/policies/delete | Delete policies in Microsoft Entra ID. |
| microsoft.directory/policies/owners/update | Update the `policies.owners` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/appRoleAssignedTo/update | Update the `servicePrincipals.appRoleAssignedTo` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/appRoleAssignments/update | Update the `users.appRoleAssignments` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/audience/update | Update the `servicePrincipals.audience` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/authentication/update | Update the `servicePrincipals.authentication` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/basic/update | Update basic properties on service principals in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/credentials/update | Update the `servicePrincipals.credentials` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/delete | Delete service principals in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/owners/update | Update the `servicePrincipals.owners` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/permissions/update | Update the `servicePrincipals.permissions` property in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/policies/update | Update the `servicePrincipals.policies` property in Microsoft Entra ID. |
| microsoft.directory/signInReports/allProperties/read | Read all properties (including privileged properties) on sign-in reports in Microsoft Entra ID. |
| microsoft.directory/servicePrincipals/synchronizationCredentials/manage |	Manage application provisioning secrets and credentials |
| microsoft.directory/servicePrincipals/synchronizationJobs/manage |	Start, restart, and pause application provisioning synchronization jobs |
| microsoft.directory/servicePrincipals/synchronizationSchema/manage |	Create and manage application provisioning synchronization jobs and schema |
| microsoft.directory/servicePrincipals/synchronization/standard/read |	Read provisioning settings associated with your service principal |

#### Owned devices

Users can perform the following actions on owned devices:

| **Action** | **Description** |
| --- | --- |
| microsoft.directory/devices/bitLockerRecoveryKeys/read | Read the `devices.bitLockerRecoveryKeys` property in Microsoft Entra ID. |
| microsoft.directory/devices/disable | Disable devices in Microsoft Entra ID. |

#### Owned groups

Users can perform the following actions on owned groups.

> [!NOTE]
> Owners of dynamic membership groups must have the Groups Administrator, Intune Administrator, or User Administrator role to edit rules for dynamic membership groups. For more information, see [Create or update a dynamic membership group in Microsoft Entra ID](~/identity/users/groups-create-rule.md).

| **Action** | **Description** |
| --- | --- |
| microsoft.directory/groups/appRoleAssignments/update | Update the `groups.appRoleAssignments` property in Microsoft Entra ID. |
| microsoft.directory/groups/basic/update | Update basic properties on groups in Microsoft Entra ID. |
| microsoft.directory/groups/delete | Delete groups in Microsoft Entra ID. |
| microsoft.directory/groups/members/update | Update the `groups.members` property in Microsoft Entra ID. |
| microsoft.directory/groups/owners/update | Update the `groups.owners` property in Microsoft Entra ID. |
| microsoft.directory/groups/restore | Restore groups in Microsoft Entra ID. |
| microsoft.directory/groups/settings/update | Update the `groups.settings` property in Microsoft Entra ID. |

## Next steps

* To learn more about the **Guest user access restrictions** setting, see [Restrict guest access permissions in Microsoft Entra ID](~/identity/users/users-restrict-guest-permissions.md).
* To learn more about how to assign Microsoft Entra administrator roles, see [Assign a user to administrator roles in Microsoft Entra ID](./how-subscriptions-associated-directory.yml).
* To learn more about how resource access is controlled in Microsoft Azure, see [Understanding resource access in Azure](/azure/role-based-access-control/rbac-and-directory-admin-roles).

* [Manage users](./add-users.md).

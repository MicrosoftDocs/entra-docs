---
title: User default permissions in external tenants
description: Learn about the default permissions for users in an external tenant. 
ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: reference
ms.date: 03/10/2025
ms.custom: it-pro
---

# Default user permissions in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

A Microsoft Entra tenant in an *external* configuration is used exclusively for [Microsoft Entra External ID](overview-customers-ciam.md) scenarios. An external tenant provides clear separation between your corporate workforce directory and your customer-facing app directory. By default, users created in your external tenant are restricted from accessing information about other users, groups, or devices in the external tenant. All users have default permissions unless you assign them an admin role.

To better understand the typical use cases for users in an external tenant, we can categorize them as follows:

- **External users** are consumers and business customers who use the apps registered in your external tenant. They typically retain default user permissions, meaning you don't assign them administrative roles. These users are usually created through self-service sign-up, but you can create them with the [Create new external user](~/fundamentals/how-to-create-delete-users.yml#create-a-new-external-user) option in the Microsoft Entra admin center or with Microsoft Graph. 

- **Internal users** are usually admins to whom you assign [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md). You can create internal users and assign roles using the [Create new user](~/fundamentals/how-to-create-delete-users.yml#create-a-new-user) option in the admin center or with Microsoft Graph.

- **Invited users** are usually admins you invite to the external tenant and to whom you assign [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md). If they're not assigned a role, they have default user permissions. You can invite users and assign roles using the [Invite external user](~/fundamentals/how-to-create-delete-users.yml#invite-an-external-user) option in the admin center or with Microsoft Graph.

When users are created in an external tenant, they all start with default permissions. However, you can assign [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md) to those users who need to perform administrative tasks within the external tenant.

## Default permissions

The following table describes the default permissions assigned to a user in an external tenant, including:

- Users who use self-service sign-up
- Users who are created by administrators
- Users who are invited

| **Area** | **Default user permissions** |
| ------------ | --------- |
| Users and contacts | <ul><li>Read and update their own profile through the app profile management experience<li>Change their own password</li><li>Sign in with a local or social account</li></ul> |
| Applications | <ul><li>Access applications</li><li>Revoke consent to applications</li></ul> |

## Microsoft Graph APIs and permissions

The following table indicates the API operations that enable customers to manage their profile information. The user ID or userPrincipalName is always the signed-in user's.

| User operation  | API operation                                           | Permissions required       |
|-----------------|---------------------------------------------------------|----------------------------|
| Read profile    | [GET /me](/graph/api/user-get) or [GET /users/{id or userPrincipalName}](/graph/api/user-get)     | User.Read                  |
| Update profile  | [PATCH /me](/graph/api/user-update) or [PATCH /users/{id or userPrincipalName}](/graph/api/user-update) <br/><br/> The following properties are updatable: city, country, displayName, givenName, jobTitle, postalCode, state, streetAddress, surname, and preferredLanguage | User.ReadWrite             |
| Change password | [POST /me/changePassword](/graph/api/user-changepassword)   | Directory.AccessAsUser.All |

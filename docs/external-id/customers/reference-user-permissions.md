---
title: User default permissions in external tenants
description: Learn about the default permissions for users in an external tenant. 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: reference
ms.date: 04/22/2024
ms.author: mimart
ms.custom: it-pro
---

# Default user permissions in external tenants

A Microsoft Entra tenant in an *external* configuration is used exclusively for [Microsoft Entra External ID](overview-customers-ciam.md) scenarios. An external tenant provides clear separation between your corporate workforce directory and your customer-facing app directory. Furthermore, users created in your external tenant are restricted from accessing information about other users in the external tenant. By default, customers can’t access information about other users, groups, or devices.

An external tenant can contain the following user types:

- **External users** are consumers and business customers of the apps registered in your external tenant. They have a local account, but authenticate externally. External users are limited to default user permissions and can't be assigned roles. They're typically created through self-service sign-up, but you can create them with the [Create new external user](~/fundamentals/how-to-create-delete-users.md#create-a-new-external-user) option in the Microsoft Entra admin center or with Microsoft Graph.

- **Internal users** are users (typically admins) who authenticate internally and have assigned [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md) in your external tenant. If you don't assign a role, they have default user permissions. You can create internal users with the [Create new user](~/fundamentals/how-to-create-delete-users.md#create-a-new-user) option in the admin center or with Microsoft Graph.

- **Invited users** are users (typically admins) who sign in with their own external credentials and have assigned [Microsoft Entra roles](~/identity/role-based-access-control/permissions-reference.md) in your external tenant. If you don't assign a role, they have default user permissions. You can invite users with the [Invite external user](~/fundamentals/how-to-create-delete-users.md#invite-an-external-user) option in the admin center or with Microsoft Graph.

## Default permissions

The following table describes the default permissions assigned to a user in an external tenant customer:

- Users who use self-service sign-up
- Users who are created by administrators
- Users who are invited

| **Area** | **Customer user permissions** |
| ------------ | --------- |
| Users and contacts | - Read and update their own profile through the app profile management experience  <br>- Change their own password <br>- Sign in with a local or social account |
| Applications | - Access customer-facing applications <br>- Revoke consent to applications |

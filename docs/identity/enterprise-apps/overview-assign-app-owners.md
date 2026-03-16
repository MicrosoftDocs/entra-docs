---
title: Overview of enterprise application ownership
description: Learn about application ownership in Microsoft Entra ID, including default assignments, managing configurations, and handling ownerless apps effectively.
ms.topic: concept-article
ms.date: 12/06/2024
ms.reviewer: saibandaru
ms.custom: enterprise-apps

#customer intent: As an owner of an enterprise application in Microsoft Entra ID, I want to be able to manage the organization-specific configuration of the application, add or remove other owners, and have the same permissions as Application Administrators, so that I can effectively manage and secure the application within my organization.
---

# Overview of enterprise application ownership in Microsoft Entra ID

When a user registers an application in Microsoft Entra ID, they are automatically added as the application owner. Default ownership of an enterprise application is assigned only when a user without any administrator roles creates a new application registration. Additionally, when a Cloud Application Administrator assigns a user as the owner of a service principal through the Enterprise Applications experience, that user is also added as an application owner for single-tenant OpenID Connect (OIDC) and Security Assertion Markup Language (SAML) applications. In all other scenarios, ownership is not assigned by default to an enterprise application. While users can be assigned as owners of enterprise applications, groups cannot be assigned as owners.

As an owner of an enterprise application in Microsoft Entra ID, a user can manage the organization-specific configuration of the application, such as single sign-on, provisioning, and user assignment. An owner can also add or remove other owners. Unlike Privileged Role Administrators, owners can manage only the enterprise applications they own. The owners have the same permissions as Application Administrators scoped to an individual application. To learn more about the permissions that an owner of an application has, see [Ownership permissions](~/fundamentals/users-default-permissions.md#owned-enterprise-applications)

> [!NOTE]
> The application may have more permissions than the owner, and thus would be an elevation of privilege over what the owner has access to as a user. An application owner can create or update users or other objects while impersonating the application. The elevation of privilege to owners can raise a security concern in some cases depending on the application's permissions.

## FAQ

**What do you do with applications where the owner is no longer with the organization?**

If you have an ownerless application in your tenant, you can access the audit log for the application to investigate other users who might be involved in configuring the application. However, there are limitations on how long audit logs are stored. See [Microsoft Entra audit log reporting](~/identity/monitoring-health/reference-reports-data-retention.md).

You might also see other users who scope permissions on the application by navigating to **Roles and Administrators** tab. Once you find the right person to own the application, a user with a highly privileged administrative role in the organization can assign the new owner for the application. See [Assign enterprise application owners](assign-app-owners.md).

As a best practice, we recommend proactive monitoring applications in your environment to ensure there are at least two owners, where possible, to avoid the situation of ownerless apps. Additionally, you should utilize the serviceManagementReference property on the application object to reference the team contact information from your enterprise Service or Asset Management Database. The serviceManagementReference property ensures you have team contact even if an individual leaves the organization.

**How can I find enterprise applications that are ownerless or at risk of being ownerless in my organization?**

To learn how to identify ownerless enterprise apps or apps with only one owner using Microsoft Graph API, see [List ownerless applications](/graph/tutorial-applications-basics#manage-application-ownership).

**How do you add yourself as an owner of an enterprise application?**

Existing owners of an application can add other users as the owners. Also, users with a privileged role such as Application Administrator or the Cloud Application Administrator can assign owners to applications in the organization. If you aren't an administrator, work with an administrator in your organization to [assign you as the owner](assign-app-owners.md) of the application.

**How can you find all the applications that you own?**

- You can navigate to **Enterprise Applications**, then select **All Applications**
- Select **Add filter**, then use **owned by** to search for apps owned by you or any other person.

## Next steps

- [Assign enterprise application owners](assign-app-owners.md)

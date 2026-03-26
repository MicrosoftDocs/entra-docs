---
title: Overview of Enterprise Application Ownership
description: Learn about application ownership in Microsoft Entra ID, including default assignments, managing configurations, and handling ownerless apps effectively.
ms.topic: concept-article
ms.date: 12/06/2024
ms.reviewer: saibandaru
ms.custom: enterprise-apps

#customer intent: As an owner of an enterprise application in Microsoft Entra ID, I want to be able to manage the organization-specific configuration of the application, add or remove other owners, and have the same permissions as application administrators, so that I can effectively manage and secure the application within my organization.
---

# Overview of enterprise application ownership in Microsoft Entra ID

A user who registers an application in Microsoft Entra ID is automatically added as the application owner. Default ownership of an enterprise application is assigned only when a user without any administrator roles creates a new application registration.

When a cloud application administrator assigns a user as the owner of a service principal through an enterprise application, that user is also added as an application owner for single-tenant OpenID Connect (OIDC) and Security Assertion Markup Language (SAML) applications.

In all other scenarios, ownership is not assigned by default to an enterprise application. Although users can be assigned as owners of enterprise applications, groups can't be assigned as owners.

As an owner of an enterprise application in Microsoft Entra ID, a user can manage the organization-specific configuration of the application. This configuration includes single sign-on, provisioning, and user assignment. An owner can also add or remove other owners.

Unlike privileged role administrators, owners can manage only the enterprise applications that they own. Owners have the same permissions as application administrators, scoped to an individual application. To learn more about the permissions that an owner of an application has, see [Ownership permissions](~/fundamentals/users-default-permissions.md#owned-enterprise-applications).

> [!NOTE]
> The application might have more permissions than the owner. This situation is an elevation of privilege over what the owner can access as a user. In that case, an application owner can create or update users or other objects while impersonating the application. The elevation of privilege to owners can raise a security concern in some cases, depending on the application's permissions.

Currently, due to background applications and dependencies for service principal objects' settings, application owners added through methods other than the Microsoft Entra admin center (like Graph API or PowerShell) can't manage some enterprise application settings. These settings include attributes and claims, configured SAML certificate properties, or token encryption settings.

## FAQ

**What should I do with applications where the owner is no longer with the organization?**

If you have an ownerless application in your tenant, you can access the audit log for the application to investigate other users who might be involved in configuring the application. However, there are limitations on how long audit logs are stored. See [Microsoft Entra audit log reporting](~/identity/monitoring-health/reference-reports-data-retention.md).

You might also see other users who scope permissions on the application by going to the **Roles and Administrators** tab. After you find the right person to own the application, a user with a highly privileged administrative role in the organization can assign the new owner for the application. See [Assign enterprise application owners](assign-app-owners.md).

As a best practice, we recommend proactively monitoring applications in your environment to ensure that there are at least two owners, where possible. This monitoring can help you avoid the situation of ownerless apps.

Additionally, you should use the `serviceManagementReference` property on the application object to reference the team contact information from your enterprise service or asset management database. The `serviceManagementReference` property ensures that you have a team contact, even if an individual leaves the organization.

**How can I find enterprise applications that are ownerless or at risk of being ownerless in my organization?**

To learn how to identify ownerless enterprise apps (or apps with only one owner) by using the Microsoft Graph API, see [List ownerless applications](/graph/tutorial-applications-basics#manage-application-ownership).

**How do I add myself as an owner of an enterprise application?**

Existing owners of an application can add other users as the owners. Also, users with a privileged role, such as application administrator or cloud application administrator, can assign owners to applications in the organization. If you aren't an administrator, work with an administrator in your organization to [assign you as the owner](assign-app-owners.md) of the application.

**How can I find all the applications that I own?**

1. Go to **Enterprise Applications**, and then select **All Applications**.

1. Select **Add filter**, and then use **owned by** to search for apps that you or anyone else owns.

## Related content

- [Assign enterprise application owners](assign-app-owners.md)

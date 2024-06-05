---
title: "Configure app management policy preview)"
description: Learn how to increase the security posture of your tenant by configuring app management policy that enforces security best practices for applications in your tenant.
author: omondiatieno 
manager: jesakowi
ms.author: jomondi
ms.date: 06/05/2024
ms.reviewer: saumadan
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to

#Customer intent: As an IT admin, I want to configure app management policies for my organization's app registrations and service principals in Microsoft Entra ID, so that I can enforce best practices for how they use app authentication methods like certificates and password secrets.
---

# Configure app management policy (preview)

In this article, you learn how to configure the tenant default app management policy and create and configure custom application policies in Microsoft Entra ID.

Application authentication methods such as certificates and password secrets allow apps to acquire tokens to access data in Microsoft Entra ID. App management policies allow IT admins to enforce best practices for how apps in their organizations use these application authentication methods. For example, an admin might configure a policy to block the use or limit the lifetime of password secrets, and use the creation date of the object to enforce the policy.

These policies allow organizations to take advantage of the new app security hardening features. By enforcing restrictions that are based on the application registration or service principal created date, an organization can review their current app security posture, inventory apps, and enforce controls per their resourcing schedules and needs. This approach using the created date allows the organization to enforce the policy for new applications and also apply it to existing applications. There are two types of policy controls:

- Tenant default policy that applies to all applications or service principals.
- App (app registration or service principal) management policies that allow inclusion or exclusion of individual applications from the tenant default policy.

## Prerequisites

To configure app management policies, you need:

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- A Workload Identity Premium license. For more information on Workload identity licensing, see [Frequently asked questions about Microsoft Entra Workload ID](~workload-id/workload-identities-faqs.md)
- Security Administrator role.

## Tenant default app management policy

A tenant default policy is a single object that always exists and is disabled by default. It's defined by the [tenantAppManagementPolicy](/graph/api/resources/tenantappmanagementpolicy) resource and enforces restrictions on app registration vs service principal objects. It contains the following two properties:

- **applicationRestrictions** allows targeting applications owned by the tenant (app registration objects).
- **servicePrincipalRestrictions** allows targeting applications provisioned from another tenant (service principal objects).

These properties enable an organization to lock down credential usage in apps that originate from their tenant and provide a mechanism to control credential addition in externally provisioned applications to protect them from credential abuse. The application owner of a multi-tenant app can still use any type of credentials in their app registration object, but the policy only protects the service principal from credential abuse. 

## App management policy for app registrations and service principals

App management policies are defined in the [appManagementPolicy](/graph/api/resources/appmanagementpolicy) resource. This resource contains a collection of policies with varying restrictions or different enforcement dates from what tenant default policy defines. One of these policies can be assigned to an app registration or service principal, excluding them from the tenant default policy.

When both the tenant default policy and an app management policy exist, the app management policy takes precedence. In this case, the assigned app registration or service principal doesn't inherit from the tenant default policy. Only one policy can be assigned to an app registration or service principal.

> [!NOTE]
> Neither the tenant default policies nor the app management policies block token issuance for existing applications. An application that doesn't meet the policy requirements will continue to work until it tries to update the resource to add a new secret.

## Configure the tenant default app management policy

[!INCLUDE [portal updates](~/includes/portal-update.md)]

To configure the tenant default policy app instance lock:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant containing the app registration from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Security** > **Authentication methods** > **Application policies**.
1. Select the **Password restrictions** restriction type under **Default policy restrictions** column.
1. Configure the desired password restrictions.

   :::image type="content" source="media/configure-app-management-policy/default-app-management-policy-appreg-pwdrestrictions.png" alt-text="Screenshot of the tenant app management policy password restrictions.":::

1. Select **Save** to save your changes.
1. Select the **Certificate restrictions** restriction type under **Default policy restrictions** column.
1. Configure the desired certificate restrictions.

   :::image type="content" source="media/configure-app-management-policy/default-app-management-policy-appreg-certrestrictions.png" alt-text="Screenshot of the tenant app management policy certificate restrictions.":::

1. Select **Save** to save your changes.
1. Select the checkbox **Copy settings selection to apply to enterprise apps** if you want the restrictions configured for App registrations to be applied for Enterprise apps. You can also select the **Enterprise apps** tab and use different parameters to configure the same restriction for Enterprise applications.
1.  Select **Save** to save your changes.
1.  Enable the policy for all app registrations and enterprise apps in the tenant by setting the **Policy status** toggle to **Enabled** state.

## Configure the custom application policies

To create and configure custom application policies:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant containing the app registration from the **Directories + subscriptions** menu.
1. Browse to **Identity** > **Security** > **Authentication methods** > **Application policies**.
1. Select the **Custom application policies** tab. 
1. Select **New custom policy** and proceed to fill out the information in the **Basics section**.
1. Select **Next** to configure **Password Restrictions** tab and fill out the information in that section. 
      :::image type="content" source="media/configure-app-management-policy/custom-app-management-policy-appreg-pwdrestrictions.png" alt-text="Screenshot of the custom app management policy password restrictions.":::
1. Select **Next** to configure **Certificate Restrictions** tab and fill out the information in that section. 
1. Select **Next** to review the policy configuration.
1.  Select **Create** to create the policy. 
1. Once the policy is created, select the policy and apply the policy to the desired app registrations or enterprise apps. Enable the policy for all app registrations and enterprise apps attached to the policy  by setting the **Policy status** toggle to **Enabled**.

## Discover available restrictions in the app policy API

The application authentication methods policy API offers the following restrictions:

| Restriction name       | Description                                                            | Examples                                                                                                   |
| :--------------------- | :--------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| passwordAddition       | Restrict password secrets on applications altogether.                  | Block new passwords on applications created on or after '01/01/2019'.                                      |
| passwordLifetime       | Enforce a max lifetime range for a password secret.                    | Restrict all new password secrets to a maximum of 30 days for applications created after 01/01/2015.       |
| customPasswordAddition | Restrict a custom password secret on app registration or service principal. | Restrict all new custom password secrets on applications created after 01/01/2015.                         |
| symmetricKeyAddition   | Restrict symmetric keys on applications.                               | Block new symmetric keys on applications created on or after 01/01/2019.                                   |
| symmetricKeyLifetime   | Enforce a max lifetime range for a symmetric key.                      | Restrict all new symmetric keys to a maximum of 30 days for applications created after 01/01/2019.         |
| asymmetricKeyLifetime  | Enforce a max lifetime range for an asymmetric key (certificate).      | Restrict all new asymmetric key credentials to a maximum of 30 days for applications created after 01/01/2019. |

To learn how to configure app management policies programmatically through the Microsoft Graph API, see [tenant default policy](/graph/api/resources/tenantappmanagementpolicy) or [custom app management policy](/graph/api/resources/appmanagementpolicy) resources.

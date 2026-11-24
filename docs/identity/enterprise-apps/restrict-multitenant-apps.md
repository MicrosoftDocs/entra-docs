---
title: Restrict multitenant Microsoft Entra apps
description: Require multitenant apps to explicitly list the tenants they'll operate in for increased security
ms.reviewer: arcrowe
ms.date: 11/24/2026
ms.topic: how-to
ms.localizationpriority: medium
ms.collection: RestrictedMode
audience: admin
ai-usage: ai-assisted
---

# Restrict multitenant Microsoft Entra apps

Applications that accept tokens from any Microsoft Entra tenant significantly expand their attack surface. When an app doesn't explicitly restrict which tenants it can authenticate, any external tenant - including one controlled by a bad actor - can attempt to obtain tokens and interact with the app. Microsoft recommends that applications explicitly constrain the tenants they trust, limiting authentication to a defined set of known tenants. This reduces lateral movement risk and helps ensure apps are only accessed from environments they're designed to operate in.

Tenant administrators can require applications in their tenant to declare the tenants they're allowed to authenticate from. When this control is enabled, going forward, applications in the tenant must specify an allow list of tenant IDs they'll operate in. Over time, this drives a more secure-by-default posture as apps are created or updated, ensuring tenant boundaries are explicitly enforced. Existing applications aren't automatically restricted when the policy is applied; administrators can accelerate risk reduction by identifying unrestricted apps and updating them to declare their allowed tenants.

## Restrict app audience

Multitenant apps can be restricted in the Microsoft 365 admin center.

For required roles and access instructions, see [Baseline security mode settings](/microsoft-365/baseline-security-mode/baseline-security-mode-settings#before-you-begin).

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com) and go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode**, find the **New apps require assignment of the tenants allowed to access them** setting, and switch the toggle to **On**.

Apps can also be restricted using the [Microsoft Entra admin center](https://aka.ms/app-mgmt-policy-ux). For more information, see [Configure app management policies](configure-app-management-policies.md).

Enabling this setting blocks both new and existing apps from becoming multitenant without restrictions. You can gauge the impact of enabling this setting by identifying recent creations of multitenant apps. From the Microsoft 365 admin center:

1. In the Microsoft 365 admin center, go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode** and find the **New apps require assignment of the tenants allowed to access them** setting.
1. Select **download report** to view recent multitenant app creations in your organization.

## Restrict existing app audiences

Blocking creation of new unrestricted apps doesn't affect existing apps. Existing apps that already allow any tenant can be identified using the Microsoft 365 admin center.

1. In the Microsoft 365 admin center, go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode** and find the **New apps require assignment of the tenants allowed to access them** setting.
1. Select **download report** to view existing unrestricted multitenant apps.

Identify the tenants where an existing multitenant app operates before adding them to its audience restrictions. Existing application audiences can be restricted using the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM), [Microsoft Graph PowerShell](/powershell/module/microsoft.graph.beta.applications/update-mgbetaapplication?view=graph-powershell-beta&preserve-view=true), or the [Microsoft Graph API](/graph/api/resources/signinaudiencerestrictionsbase?view=graph-rest-beta&preserve-view=true).
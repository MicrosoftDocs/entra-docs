---
title: Restrict password usage on Microsoft Entra apps
description: Block the addition of passwords on Microsoft Entra apps to improve security
ms.reviewer: arcrowe
ms.date: 11/24/2026
ms.topic: how-to
ms.localizationpriority: medium
ms.collection: RestrictedMode
audience: admin
ai-usage: ai-assisted
---

# Restrict password usage on Microsoft Entra apps

Passwords are one of the weakest methods of service authentication and are vulnerable to compromise by bad actors. Microsoft recommends that organizations switch applications in their tenant to a [more secure credential method](/entra/identity-platform/security-best-practices-for-app-registration#credentials-including-certificates-and-secrets). This improves security and reduces management overhead.

Tenant administrators can block the addition of new passwords to applications in their tenant. This should eventually deprecate password usage in their organization as apps modernize their credential methods and existing passwords expire. Administrators can also speed up this process by identifying apps with existing passwords and removing them.

## Block password addition

New password addition can be blocked in the Microsoft 365 admin center.

For required roles and access instructions, see [Baseline security mode settings](/microsoft-365/baseline-security-mode/baseline-security-mode-settings#before-you-begin).

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com) and go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode**, find the **Block addition of new password credentials to apps** setting, and switch the toggle to **On**.

Password addition can also be blocked using the [Microsoft Entra admin center](https://aka.ms/app-mgmt-policy-ux). For more information, see [Configure app management policies](configure-app-management-policies.md).

Enabling this setting blocks the addition of passwords to both new and existing apps. You can gauge the impact of enabling this setting by identifying recent password addition activity. From the Microsoft 365 admin center:

1. In the Microsoft 365 admin center, go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode** and find the **Block addition of new password credentials to apps** setting.
1. Select **download report** to view password additions in your organization in the last 30 days.

## Remove existing passwords

Blocking addition of new passwords doesn't affect existing passwords. Existing apps using passwords can be identified using the Microsoft 365 admin center.

1. In the Microsoft 365 admin center, go to **Settings** > **Org settings** > **Security and Privacy**.
1. Select **Baseline Security Mode** and find the **Block addition of new password credentials to apps** setting.
1. Select **download report** to view existing apps with passwords.

Apps using passwords should be modernized before their existing passwords are removed. Developers should follow the [credential guidance](/entra/identity-platform/security-best-practices-for-app-registration#credentials-including-certificates-and-secrets) to modernize the apps they own.  Passwords on existing applications can be removed using the [Microsoft Entra admin center](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM), [Microsoft Graph PowerShell](/powershell/module/microsoft.graph.applications/remove-mgapplicationpassword), or the [Microsoft Graph API](/graph/api/application-removepassword?tabs=http).

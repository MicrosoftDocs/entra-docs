---
title: Use application enforced restrictions to protect access from unmanaged devices
description: Create a custom Conditional Access policy for unmanaged devices.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: lhuangnorth
---
# Use application enforced restrictions for unmanaged devices

This policy can help organizations accomplish the following initiatives:

- [Block or limit access to a specific SharePoint site or OneDrive](/sharepoint/control-access-from-unmanaged-devices#block-or-limit-access-to-a-specific-sharepoint-site-or-onedrive)
- [Limit access to email attachments in Outlook on the web and the new Outlook for Windows](/security/zero-trust/zero-trust-identity-device-access-policies-exchange#limit-access-to-exchange-online-from-outlook-on-the-web)
- [Enforce idle session timeout on unmanaged devices](/microsoft-365/admin/manage/idle-session-timeout-web-apps#idle-session-timeout-on-unmanaged-devices)

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Resources (formerly cloud apps)**, select the following options:
   1. Under **Include**, choose **Select resources**.
   1. Choose **Office 365**, then select **Select**.
1. Under **Access controls** > **Session**, select **Use app enforced restrictions**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Next steps

[Conditional Access templates](concept-conditional-access-policy-common.md)

[Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

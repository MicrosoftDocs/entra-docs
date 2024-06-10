---
title: Require MFA for device registration
description: Improve visibility and enforce more granular control over the device registration process though Conditional Access.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 06/10/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: lhuangnorth
---
# Common Conditional Access policy: Require multifactor authentication for device registration

Use the [Conditional Access user action](concept-conditional-access-cloud-apps.md#user-actions) to enforce policy when users register or join devices to Microsoft Entra ID. This control provides granularity in configuring multifactor authentication for registering or joining devices instead of a tenant-wide policy that currently exists. Administrators can customize this policy to fit the security needs of their organization.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

## Create a Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **User actions**, select **Register or join devices**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require authentication strength**, select **Multifactor authentication**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

> [!WARNING]
> When a Conditional Access policy is configured with the **Register or join devices** user action, you must set **Identity** > **Devices** > **Overview** > **Device Settings** - `Devices to be Microsoft Entra joined or Microsoft Entra registered require multifactor authentication` to **No**. Otherwise, the Conditional Access policy with this user action isn't properly enforced. More information about this device setting can found in [Configure device settings](~/identity/devices/manage-device-identities.md#configure-device-settings).

## Related content

- [Conditional Access authentication strength](../authentication/concept-authentication-strengths.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

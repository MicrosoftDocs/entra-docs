---
title: Block unsupported platforms with Conditional Access
description: Create a custom Conditional Access policy blocking unsupported platforms.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Block unknown or unsupported device platform

Users are blocked from accessing company resources when the device type is unknown or unsupported.

The [device platform condition](concept-conditional-access-conditions.md#device-platforms) is based on user agent strings. Conditional Access policies using this condition should be used with another policy, like one requiring device compliance or app protection policies, to mitigate the risk of user agent spoofing.

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
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions**, select **Device platforms**
   1. Set **Configure** to **Yes**.
   1. Under **Include**, select **Any device**
   1. Under **Exclude**, select **Android**, **iOS**, **Windows**, and **macOS**.
      > [!NOTE]
      > For this exclusion, select any platforms that your organization uses, and leave the others unselected.
   1. Select, **Done**.
1. Under **Access controls** > **Grant**, select **Block access**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Next steps

- [Conditional Access templates](concept-conditional-access-policy-common.md)

- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

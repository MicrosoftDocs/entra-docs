---
title: Conditional Access - Block access by location
description: Create a custom Conditional Access policy to block access to resources by IP location.
author: MicrosoftGuyJFlo
ms.author: joflore
manager: femila
ms.reviewer: lhuangnorth
ms.date: 04/01/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
--- 
# Block access by location

With the location condition in Conditional Access, you can control access to your cloud apps based on the network location of a user. The location condition is commonly used to block access from countries/regions where your organization knows traffic shouldn't come from. For more information about IPv6 support, see the article [IPv6 support in Microsoft Entra ID](/troubleshoot/azure/active-directory/azure-ad-ipv6-support).

> [!NOTE]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Named locations**.
1. Choose the type of location to create.
   - **Countries location** or **IP ranges location**.
   - Give your location a name.
1. Provide the **IP ranges** or select the **Countries/Regions** for the location you're specifying.
   - If you select IP ranges, you can optionally **Mark as trusted location**.
   - If you choose Countries/Regions, you can optionally choose to include unknown areas.
1. Select **Create**

More information about the location condition in Conditional Access can be found in the article, [What is the location condition in Microsoft Entra Conditional Access](location-condition.md)

## Create a Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Network**.
   1. Set **Configure** to **Yes**
   1. Under **Include**, select **Selected networks and locations**
      1. Select the blocked location you created for your organization.
      1. Click **Select**.
1. Under **Access controls** > select **Block Access**, and click **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related Content

- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

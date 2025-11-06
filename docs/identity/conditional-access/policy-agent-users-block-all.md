---
title: Block Agent Users with Conditional Access
description: Discover how to configure a Conditional Access policy to block agent users in Microsoft Entra. Ensure secure access with detailed guidance.

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.date: 11/04/2025

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.reviewer: kvenkit
--- 
# Block all agent users

This Conditional Access policy template blocks all agent users from accessing any resources in your organization, preventing AI agents acting as users from obtaining access tokens.

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to block issuance of access tokens requested using agent users.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include** > **Select agents** > **Select agents acting as users** > **All agents acting as users (Preview)**
      1. Select **Select**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select Create to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related Content

- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

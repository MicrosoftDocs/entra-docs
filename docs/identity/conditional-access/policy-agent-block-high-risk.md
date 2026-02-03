---
title: Conditional Access for High-Risk Agent Identities
description: Learn how to configure Conditional Access policies to block risky agent identities. Follow best practices to enhance security in Microsoft Entra.

ms.author: sarahlipsey
author: shlipsey3
manager: dougeby
ms.date: 11/04/2025
ms.custom: agent-id-ignite

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.reviewer: kvenkit
--- 
# Block access by high-risk agent identities (Preview)

This Conditional Access policy template blocks agent identities that are detected as high risk by [Microsoft Entra ID Protection](/entra/id-protection/concept-risky-agents), helping prevent potentially compromised AI agents from accessing your organization's resources.

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents (Preview) or workload identities**. 
   1. Under **What does this policy apply to?**, select **Agents (Preview)**.
      1. Under **Include**, select **All agent identities (Preview)**.
1. Under **Target resources**, select the following options: 
   1. Select what this policy applies to **Resources (formerly cloud apps)**.
   1. Include, **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Agent risk (Preview)**, set **Configure** to **Yes**.
   1. Under **Configure agent risk levels needed for policy to be enforced**, select **High**. This guidance is based on Microsoft recommendations and might be different for each organization.
1. Under **Access controls** > **Grant**. 
   1. Select **Block**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related Content

- [Conditional Access templates](concept-conditional-access-policy-common.md)
- [Determine effect using Conditional Access report-only mode](howto-conditional-access-insights-reporting.md)
- [Use report-only mode for Conditional Access to determine the results of new policy decisions.](concept-conditional-access-report-only.md)

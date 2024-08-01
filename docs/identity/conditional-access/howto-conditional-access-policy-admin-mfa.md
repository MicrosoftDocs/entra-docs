---
title: Require MFA for administrators with Conditional Access
description: Create a custom Conditional Access policy to require administrators to perform multifactor authentication.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 05/29/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: lhuangnorth
---
# Common Conditional Access policy: Require MFA for administrators

Accounts that are assigned administrative rights are targeted by attackers. Requiring multifactor authentication (MFA) on those accounts is an easy way to reduce the risk of those accounts being compromised.

Microsoft recommends you require MFA on the following roles at a minimum, based on [identity score recommendations](~/identity/monitoring-health/concept-identity-secure-score.md):

[!INCLUDE [conditional-access-admin-roles](../../includes/conditional-access-admin-roles.md)]

Organizations can choose to include or exclude roles as they see fit.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to require those assigned administrative roles to perform multifactor authentication. Some organizations might be ready to move to stronger authentication methods for their administrators. These organizations might choose to implement a policy like the one described in the article [Require phishing-resistant multifactor authentication for administrators](how-to-policy-phish-resistant-admin-mfa.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **Directory roles** and choose at least the previously listed roles.
   
      > [!WARNING]
      > Conditional Access policies support built-in roles. Conditional Access policies are not enforced for other role types including [administrative unit-scoped](~/identity/role-based-access-control/admin-units-assign-roles.md) or [custom roles](~/identity/role-based-access-control/custom-create.yml).

   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Cloud apps** > **Include**, select **All cloud apps**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

## Related content

- [Microsoft Entra built-in roles](../role-based-access-control/permissions-reference.md)
- [Conditional Access templates](concept-conditional-access-policy-common.md)

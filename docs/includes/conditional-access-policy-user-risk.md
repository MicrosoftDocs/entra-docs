---
author: joflore
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: include
ms.date: 09/17/2024
ms.author: joflore
---

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
   1. Select **Done**.
1. Under **Cloud apps or actions** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **User risk**, set **Configure** to **Yes**. 
   1. Under **Configure user risk levels needed for policy to be enforced**, select **High**. [This guidance is based on Microsoft recommendations and might be different for each organization](../id-protection/howto-identity-protection-configure-risk-policies.md#choosing-acceptable-risk-levels)
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Multifactor authentication** authentication strength from the list.
   1. Select **Require password change**.
   1. Select **Select**.
1. Under **Session**.
   1. Select **Sign-in frequency**.
   1. Ensure **Every time** is selected.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](../identity/conditional-access/howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

### Passwordless scenarios

For organizations that adopt [passwordless authentication methods](/entra/identity/authentication/howto-authentication-passwordless-deployment) make the following changes: 

#### Update your passwordless user risk policy

1. Under **Users**:
   1. **Include**, select **Users and groups** and target your passwordless users.
1. Under **Access controls** > **Block** access for passwordless users.

> [!TIP]
> You might need to have two policies for a period of time while deploying passwordless methods. 
> - One that allows self-remediation for those not using passwordless methods. 
> - Another that blocks passwordless users at high risk.

#### Remediate and unblock passwordless user risk

1. Require administrator [investigation and remediation](/entra/id-protection/howto-identity-protection-investigate-risk) of any risk.
1. Unblock the user.
 
---
author: joflore
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: include
ms.date: 02/21/2025
ms.author: joflore
---

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
   1. Select **Done**.
1. Under **Cloud apps or actions** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Sign-in risk**, set **Configure** to **Yes**. 
   1. Under **Select the sign-in risk level this policy will apply to**, select **High** and **Medium**. [This guidance is based on Microsoft recommendations and might be different for each organization](../id-protection/howto-identity-protection-configure-risk-policies.md#choosing-acceptable-risk-levels)
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require authentication strength**, then select the built-in **Multifactor authentication** authentication strength from the list.
   1. Select **Select**.
1. Under **Session**.
   1. Select **Sign-in frequency**.
   1. Ensure **Every time** is selected.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](conditional-access-report-only-mode.md)]

### Passwordless scenarios

For organizations that adopt [passwordless authentication methods](/entra/identity/authentication/howto-authentication-passwordless-deployment) make the following changes: 

#### Update your passwordless sign-in risk policy

1. Under **Users**:
   1. **Include**, select **Users and groups** and target your passwordless users.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
   1. Select **Done**.
1. Under **Cloud apps or actions** > **Include**, select **All resources** (formerly 'All cloud apps').
1. Under **Conditions** > **Sign-in risk**, set **Configure** to **Yes**.
    1. Under **Select the sign-in risk level this policy will apply to**, select **High** and **Medium**. For more information on risk levels, see [Choosing acceptable risk levels](../id-protection/howto-identity-protection-configure-risk-policies.md#choosing-acceptable-risk-levels).
    1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**.
    1. Select **Require authentication strength**, then select the built-in **Passwordless MFA** or **Phishing-resistant MFA** based on which method the targeted users have.
    1. Select **Select**.
1. Under **Session**:
    1. Select **Sign-in frequency**.
    1. Ensure **Every time** is selected.
    1. Select **Select**.

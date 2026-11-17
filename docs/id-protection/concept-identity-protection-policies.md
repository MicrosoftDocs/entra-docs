---
title: Microsoft Entra ID Protection risk-based access policies
description: Identifying risk-based Conditional Access policies
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 11/03/2026
author: tilarso
ms.author: tilarso
ai-usage: ai-assisted
ms.reviewer: ebasseri
ms.custom: sfi-image-nochange, msecd-doc-authoring-108
---
# Risk-based access policies

Risk-based access control policies can be applied to protect organizations when a sign-in or user is detected to be at risk.

![Diagram of user, location, device, application, and risk signals informing Conditional Access decisions, including requiring identity verification.](./media/concept-identity-protection-policies/risk-based-conditional-access-diagram.png)

Microsoft Entra Conditional Access offers two user-specific risk conditions powered by Microsoft Entra ID Protection signals: **[Sign-in risk](../identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)** and **[User risk](../identity/conditional-access/concept-conditional-access-conditions.md#user-risk)**. Organizations can create risk-based Conditional Access policies by configuring these two risk conditions and choosing an access control method. During each sign-in, ID Protection sends the detected risk levels to Conditional Access, and the risk-based policies apply if the policy conditions are satisfied.

> [!VIDEO https://www.youtube.com/embed/cT0RnKQ8VgI?si=ORGAbnuFMu1TyELV]

You might require multifactor authentication when the sign-in risk level is medium or high. Users are only prompted at that level.

![Diagram that shows a conceptual risk-based Conditional Access policy with self-remediation.](./media/concept-identity-protection-policies/risk-based-conditional-access-policy-example.png)

The previous example also demonstrates a main benefit of a risk-based policy: **automatic risk remediation**. When a user successfully completes the required access control, like a secure password change, their risk is remediated. That sign-in session and user account are no longer at risk, and no action is needed from the administrator. 

Allowing users to self-remediate using this process significantly reduces the risk investigation and remediation burden on administrators while protecting your organization from security compromises. More information about risk remediation can be found in the article, [Remediate risks and unblock users](howto-identity-protection-remediate-unblock.md).


> [!NOTE]
> [Microsoft Entra ID P2](https://www.microsoft.com/security/business/microsoft-entra-pricing) is required to use risk-based access policies.

## User risk-based Conditional Access policy

ID Protection analyzes signals about user accounts and calculates a risk score based on the probability that the user is compromised. If a user has risky user sign-in behavior, or their credentials were leaked, ID Protection uses these signals to calculate the user risk level. Administrators can configure risk-based Conditional Access policies to enforce access controls based on user risk, including requirements such as: 

1. Require risk remediation: ID Protection manages the appropriate remediation flow for all authentication methods.
1. Require password change: ID Protection blocks access until user completes a secure password change.
1. Block access: ID Protection blocks the user until risk is addressed.
1. **Require Identity Verification (preview)**: Users complete identity verification to remediate risk in supported scenarios.

Policies requiring either #1 or #2 forces end users to remediate their user risk and unblock themselves.

## Require risk remediation control

This control uses adaptive risk remediation to let you author a Conditional Access risk policy that accommodates all authentication methods, including password-based and passwordless. This means that when you select "Require risk remediation" in your policy's grant controls, Microsoft Entra ID Protection manages the appropriate remediation flow based on the threat observed and the user's authentication method.  For detailed steps on how to enable adaptive risk remediation, see [Configure risk policies](howto-identity-protection-configure-risk-policies.md#microsoft-recommendations).

- **Password authentication**: Risky user has an active risk detection, such as a leaked credential, password spray, or session history involving a compromised password. The user is prompted to perform a secure password change and when completed, their previous sessions are revoked. 
- **Passwordless authentication**: Risky user has an active risk detection, but it doesn't involve a compromised password. Possible risk detections include anomalous token, impossible travel, or unfamiliar sign-in properties. The user's sessions are revoked and they're prompted to sign in again.
- **Attacker-added device**: Risky user is flagged by Microsoft's threat intelligence as having a device added by an attacker. The Entra device object is disabled, blocking new token issuance. The user's sessions are revoked, and they're prompted to sign-in again. 

#### Special considerations

- **Require Risk Remediation** remediates user risk, not sign-in risk.
- If a user is assigned to multiple policies, precedence applies: **Require risk remediation** overrides **Require password change**, and **Block** overrides all others. To avoid conflicts, assign each user to only one of these policies at a time.
- **Require authentication strength** and **Sign-in frequency - Every time** are automatically applied to the policy to ensure that after session revocation, end users are immediately prompted to reauthenticate with the specified authentication strength.
- **Require risk remediation** is not supported for external and guest users because Microsoft Entra ID doesn't support session revocation for those users.
- During risk remediation, Microsoft Entra ID uses a dedicated, secure flow to perform actions such as session revocation. To ensure remediation is not blocked, this flow is allowed to proceed without being impacted by other Conditional Access policies.
  - `AppId`: Public cloud = `93625bc8-bfe2-437a-97e0-3d0060024faa`, Azure for US Government = `00001111-aaaa-2222-bbbb-3333cccc4444`
  - `ResourceId`: `00000003-0000-0000-c000-000000000000`

## Identity verification for risk

The **Require Identity Verification (preview)** grant control lets users remediate risk by verifying their identity in supported scenarios. Use this control in a Conditional Access policy with a **User risk** or **Sign-in risk** condition to require identity verification when the detected risk matches the policy. Create separate policies for the two risk conditions.

An eligible identity verification profile is a prerequisite for a policy that uses this grant control to work. Before configuring the policy, [create and configure an identity verification profile](../identity/authentication/concept-authentication-verified-id.md#create-and-manage-identity-verification-profiles) with **Profile purpose** set to **All** or **Verification** and a provider and credential type that support your risk scenario. For tenant-issued credentials, select **Verification**. Don't use an **Onboarding**- or **Recovery**-purpose profile for the risk-based resource-access policy.

- **Policy configuration:** Select an identity verification profile and credential type that support the risk scenario, and apply the identity verification grant control to your risk-based policy.
- **User experience:** When the policy applies, the user completes the required identity verification challenge. Microsoft Entra ID Protection can use the successful verification result to remediate the applicable risk.
- **Remediation outcome:** Review the verification result, access decision, and relevant risk record separately to confirm the outcome for the scenario.

Successful identity verification remediates user risk when the triggering policy uses a **User risk** condition, or sign-in risk when it uses a **Sign-in risk** condition. Failed verification doesn't remediate risk.

> [!NOTE]
> **Require Identity Verification (preview)** is independent of the **Require risk remediation** control described earlier. **Require risk remediation** manages adaptive remediation based on the observed threat and authentication method; selecting it doesn't automatically require an identity verification challenge.

Follow the existing guidance to [configure identity verification for risk](howto-identity-protection-configure-risk-policies.md#configure-identity-verification-for-risk), [complete the verification journey](concept-identity-protection-user-experience.md#identity-verification-for-risk), and [validate the remediation outcome](howto-identity-protection-remediate-unblock.md#validate-identity-verification-remediation). Review the risk targeted by the triggering policy; don't infer that every risk was cleared.

For licensing specific to this integration, see [identity verification licensing](../fundamentals/licensing.md#identity-verification).

:::image type="content" source="../identity/conditional-access/media/policy-require-identity-verification/require-identity-verification-grant-control.png" alt-text="Screenshot of the Conditional Access Grant pane with Grant access selected and Require identity verification checked." lightbox="../identity/conditional-access/media/policy-require-identity-verification/require-identity-verification-grant-control.png":::

## Sign-in risk-based Conditional Access policy

During each sign-in, ID Protection analyzes hundreds of signals in real-time and calculates a sign-in risk level that represents the probability that the given authentication request isn't authorized. This risk level then gets sent to Conditional Access, where the organization's configured policies are evaluated. Administrators can configure sign-in risk-based Conditional Access policies to enforce access controls based on sign-in risk, including requirements such as:

- Block access
- Allow access
- Require multifactor authentication
- Require reauthentication (Sign-in frequency)
- **Require Identity Verification (preview)**: Users complete identity verification to remediate risk in supported scenarios.

If risks are detected on a sign-in, users can perform the required access control such as multifactor authentication to self-remediate and close the risky sign-in event to prevent unnecessary noise for administrators.

![Screenshot of a sign-in risk-based Conditional Access policy.](./media/concept-identity-protection-policies/sign-in-risk-policy.png)

> [!NOTE] 
> If your sign-in risk policy requires multifactor authentication, users must have registered an authentication method that can satisfy that requirement before triggering the policy.

## Migrate ID Protection risk policies to Conditional Access

If you have the legacy **user risk policy** or **sign-in risk policy** enabled in ID Protection (formerly Identity Protection), [migrate them to Conditional Access](howto-identity-protection-configure-risk-policies.md#migrate-risk-policies-to-conditional-access).

> [!WARNING]
> The legacy risk policies configured in Microsoft Entra ID Protection are retiring on **October 1, 2026**.

Configuring risk policies in Conditional Access provides benefits like the ability to:

- Manage access policies in one location.
- Use report-only mode and Graph APIs.
- Enforce sign-in frequency to require reauthentication every time.
- Provide granular access control combining risk with other conditions like location. 
- Enhance security with multiple risk-based policies targeting different user groups or risk levels. 
- Improve diagnostics experience detailing which risk-based policy applied in sign-in Logs.
- Support the backup authentication system.

## Microsoft Entra multifactor authentication registration policy

ID Protection helps organizations roll out Microsoft Entra multifactor authentication using a policy requiring registration at sign-in. Enabling this policy ensures new users in your organization register for MFA on their first day. Multifactor authentication is one of the self-remediation methods for risk events within ID Protection. Self-remediation allows your users to take action on their own to reduce helpdesk call volume.

Learn more about Microsoft Entra multifactor authentication in the article, [How it works: Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md).

## Related content

- [Enable the Microsoft Entra multifactor authentication registration policy](howto-identity-protection-configure-mfa-policy.md)
- [Enable sign-in and user risk policies](howto-identity-protection-configure-risk-policies.md)

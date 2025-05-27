---
title: Remediate risks and unblock users
description: Learn how to configure user self-remediation and manually remediate risky users in Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 04/10/2025
author: shlipsey3
ms.author: sarahlipsey
manager: femila
ms.reviewer: chuqiaoshi
ms.custom: sfi-image-nochange
# Customer intent: As an IT admin, I want to learn how to remediate risks and unblock users in Microsoft Entra ID Protection.
---
# Remediate risks and unblock users

After completing your [risk investigation](howto-identity-protection-investigate-risk.md), you need to take action to remediate risky users or unblock them. You can enable automated remediation by setting up [risk-based policies](howto-identity-protection-configure-risk-policies.md) or manually updating the user's risk status. Microsoft recommends acting quickly because time matters when working with risks.

This article covers several options for remediating risks. You can enable self-remediation for users or manually remediate risks on the user's behalf. This article also covers scenarios when users were blocked because of user risk, so you know how to unblock them.

## Types of risk remediation

All active risk detections contribute to the calculation of the user's risk level. The user risk level is an indicator (low, medium, high) of the probability that the user's account is compromised. After investigating risky users and the corresponding risky sign-ins and detections, you should remediate the risky users so they're no longer at risk or blocked from access.

When Microsoft Entra ID Protection identifies a risk detection and the corresponding risky sign-in as no longer posing a security threat, the risk state is automatically updated as **Dismissed** and the risk detail as **Microsoft Entra ID Protection assessed sign-in safe**. This automatic remediation reduces noise in risk monitoring so you can focus on the things that require your attention.

As an IT administrator, you can configure the ability for users to self-remediate or manually remediate on behalf of the user.

Self-remediation options include:

- Set up risk-based policies to allow users to self-remediate their risks.
- Allow users to self-remediate their user risks using self-service password reset (SSPR).
- Initiate a password reset for the user to remediate their user risk.

Manual remediation options include:

- Dismiss the user's risk.
- Confirm the user is compromised and take action to secure the account.
- Unblock the user based on user risk or sign-in risk.

You can also [remediate in Microsoft Defender for Identity](/defender-for-identity/remediation-actions).

## User self-remediation

As an IT administrator, you have several options to configure self-remediation for users. 

### Risk-based policy

You can allow users to self-remediate their sign-in risks and user risks by setting up [risk-based policies](howto-identity-protection-configure-risk-policies.md). If users pass the required access control, such as multifactor authentication or secure password change, then their risks are automatically remediated. The corresponding risk detections, risky sign-ins, and risky users are reported with the risk state **Remediated** instead of **At risk**.

For risk-based policies to be applied to allow self-remediation, users must first be able to:

- Perform MFA to self-remediate a sign-in risk: 
   - The user must be registered for Microsoft Entra multifactor authentication.
- Perform secure password change to self-remediate a user risk:
   -  The user must be registered for Microsoft Entra multifactor authentication.
   -  For hybrid users that are synced from on-premises to the cloud, password writeback must be enabled for their password change to sync from the cloud to on-premises.

If a risk-based policy is applied during sign-in where the criteria aren't met, the user is blocked. This block occurs because the user can't perform the required step, so admin intervention is required to unblock the user.

Risk-based policies are configured based on risk levels and only apply if the risk level of the sign-in or user matches the configured level. Some detections might not raise risk to the level where the policy applies, so administrators need to handle those risky users manually. Administrators can determine that extra measures are necessary, such as [blocking access from locations](../identity/conditional-access/policy-block-by-location.md) or lowering the acceptable risk in their policies.

### Self-service password reset

If a user is registered for self-service password reset (SSPR), they can remediate their own user risk by performing a self-service password reset.

### Manual password reset

If requiring a password reset using a user risk policy isn't an option, or time is of the essence, administrators can remediate a risky user by requiring a password reset.

Administrators can generate a temporary password or require the user to reset their password.

#### Generate a temporary password

By generating a temporary password, you can immediately bring an identity back into a safe state. This method requires contacting the affected users because they need to know what the temporary password is. Because the password is temporary, the user is prompted to change the password to something new during the next sign-in.

- You can generate passwords for cloud and hybrid users in the Microsoft Entra admin center.
- You can generate passwords for hybrid users from your on-premises directory if the following settings are in place:
   - Follow the guidance to [implement password hash synchronization](../identity/hybrid/connect/how-to-connect-password-hash-synchronization.md).
   - Enable the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting in Microsoft Entra ID Protection.
   - Enable [Self-service password reset](../identity/authentication/tutorial-enable-sspr.md).
   - In Active Directory, only select the option **User must change password at next logon** if everything in the previous bullets is enabled.

#### Require the user to reset password

Requiring the users to reset passwords enables self-recovery without contacting help desk or an administrator. 

- Cloud and hybrid users can complete a secure password change. This method only applies to users that can perform MFA already. For users that aren't registered, this option isn't available.
- Hybrid users can complete a password change from an on-premises or hybrid joined Windows device, when password hash synchronization and the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting is enabled.

### Allow on-premises password reset to remediate user risks

If your organization has a hybrid environment, you can allow on-premises password changes to reset user risks with [password hash synchronization](../identity/hybrid/connect/whatis-phs.md). You must enable password hash synchronization *before* users can self-remediate in those scenarios.

- Risky hybrid users can self-remediate without administrator intervention. When a password is changed on-premises, user risk is automatically remediated within Microsoft Entra ID Protection, resetting the current user risk state.
- Organizations can proactively deploy [user risk policies that require password changes](howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access) to confidently protect their hybrid users. This option strengthens your organization's security posture and simplifies security management by ensuring that user risks are promptly addressed, even in complex hybrid environments.

:::image type="content" source="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png" alt-text="Screenshot showing the location of the Allow on-premises password change to reset user risk checkbox." lightbox="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png":::

To configure this setting:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **ID Protection** > **Dashboard** > **Settings**.
1. Check the box to **Allow on-premises password change to reset user risk** and select **Save**.

> [!NOTE]
> Allowing on-premises password change to reset user risk is an opt-in only feature. Customers should evaluate this feature before enabling in production environments. We recommend customers secure the on-premises password change or reset flows. For example, requiring multifactor authentication before allowing users to change their password on-premises using a tool like [Microsoft Identity Manager's Self-Service Password Reset Portal](/microsoft-identity-manager/working-with-self-service-password-reset).

## Administrator manual remediation

In some situations, you might need to manually remediate or confirm a user's risk.

### Dismiss user risk

If after investigation you confirm the user account isn't at risk of being compromised, you can dismiss the risky user.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **ID Protection** > **Risky users**, and select the affected user.
1. Select **Dismiss user(s) risk**. When you select **Dismiss user risk**, the user is no longer at risk, and all the risky sign-ins and corresponding risk detections are dismissed.

Because this method doesn't affect the user's existing password, it doesn't bring their identity back into a safe state.

#### Risk state and detail based on dismissal of risk

- Risky user:
   - Risk state: "At risk" -> "Dismissed"
   - Risk detail (the risk remediation detail): "-" -> "Admin dismissed all risk for user"
- All the risky sign-ins of this user and the corresponding risk detections:
   - Risk state: "At risk" -> "Dismissed"
   - Risk detail (the risk remediation detail): "-" -> "Admin dismissed all risk for user"

### Confirm a user to be compromised

If after investigation, an account is confirmed compromised:

1. Select the event or user in the **Risky sign-ins** or **Risky users** reports and choose **Confirm compromised**.
1. If a risk-based policy wasn't triggered, and the risk wasn't self-remediated using one of the methods described in this article, then take one or more of the following actions:
   1. [Request a password reset](#manual-password-reset).
   1. Block the user if you suspect the attacker can reset the password or do multifactor authentication for the user.
   1. [Revoke refresh tokens](/entra/identity/users/users-revoke-access).
   1. [Disable any devices](../identity/devices/manage-device-identities.md) that are considered compromised.
   1. If using [continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation.md), revoke all access tokens.

For more information about what happens when confirming compromise, see [How to give risk feedback on risks](howto-identity-protection-risk-feedback.md#how-to-give-risk-feedback-in-microsoft-entra-id-protection).

### Deleted users

If a user was deleted from the directory that had a risk present, that user still appears in the risk report even though the account was deleted. Administrators can't dismiss risk for users who were deleted from the directory. To remove deleted users, open a Microsoft support case.

## Unblocking users

As an administrator, you can block a sign-in based on the risk policy or investigations. A block can occur based on either sign-in or user risk.

### Unblocking based on user risk

To unblock an account blocked because of user risk, you have the following options:

1. **Reset password** - If a user is compromised or is at risk of being compromised, the user's password should be reset to protect their account and your organization.
1. **Dismiss user risk** - The user risk policy blocks a user when the configured user risk level for blocking access is reached. If after investigation you're confident that the user isn't at risk of being compromised, and it's safe to allow their access, then you can reduce a user's risk level by dismissing their user risk.
1. **Exclude the user from policy** - If you think that the current configuration of your sign-in policy is causing issues for specific users, and it's safe to grant access to these users without applying this policy to them, then you can exclude them from this policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md#policy-exclusions).
1. **Disable policy** - If you think that your policy configuration is causing issues for all your users, you can disable the policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).

### Unblocking based on sign-in risk

To unblock an account based on sign-in risk, you have the following options:

1. **Sign in from a familiar location or device** - A common reason for blocked suspicious sign-ins are sign-in attempts from unfamiliar locations or devices. Your users can quickly determine whether this reason is the blocking reason by trying to sign-in from a familiar location or device.
1. **Exclude the user from policy** - If you think that the current configuration of your sign-in policy is causing issues for specific users, you can exclude the users from it. For more information, see the section Exclusions in the article [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md#policy-exclusions).
1. **Disable policy** - If you think that your policy configuration is causing issues for all your users, you can disable the policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).

### Automatic blocking due to high confidence risk

Microsoft Entra ID Protection automatically blocks sign-ins that have a very high confidence of being risky. This block most commonly occurs on sign-ins performed using legacy authentication protocols or displaying properties of a malicious attempt.

When a user is blocked for either scenario, they receive a 50053 authentication error. The sign-in logs display the following block reason: "Sign-in was blocked by built-in protections due to high confidence of risk."

To unblock an account based on high confidence sign-in risk, you have the following options:

1. **Add the IPs being used to sign in to the Trusted location settings** - If the sign-in is performed from a known location for your company, you can add the IP to the trusted list. For more information, see [Conditional Access: Network assignment](../identity/conditional-access/concept-assignment-network.md#trusted-locations).
1. **Use a modern authentication protocol** - If the sign-in is performed using a legacy protocol, switching to a modern method unblocks the attempt.

## Token theft related detections

With a recent update to our detection architecture, we no longer autoremediate sessions with MFA claims when a token theft related or the Microsoft Threat Intelligence Center (MSTIC) Nation State IP detection triggers during sign-in. 

The following ID Protection detections that identify suspicious token activity or the MSTIC Nation State IP detection are no longer autoremediated: 

- Microsoft Entra threat intelligence  
- Anomalous token
- Attacker in the Middle
- MSTIC Nation State IP
- Token issuer anomaly  

ID Protection now surfaces session details in the Risk Detection Details pane for detections that emit sign-in data. This change ensures we don't close sessions containing detections where there's MFA-related risk. Providing session details with user-level risk details provides valuable information to assist with investigation. This information includes:

- Token Issuer type
- Sign-in time
- IP address
- Sign-in location
- Sign-in client
- Sign-in request ID
- Sign-in correlation ID

If you have [user risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access) configured and one of these detections that denotes suspicious token activity is fired on a user, the end user is required to perform secure password change and reauthenticate their account with multifactor authentication to clear the risk.

## PowerShell preview

Using the Microsoft Graph PowerShell SDK Preview module, organizations can manage risk using PowerShell. The preview modules and sample code can be found in the [Microsoft Entra GitHub repo](https://github.com/AzureAD/IdentityProtectionTools).

The `Invoke-AzureADIPDismissRiskyUser.ps1` script included in the repository allows organizations to dismiss all risky users in their directory.

## Related content

- [Simulate a high user risk](howto-identity-protection-graph-api.md#confirm-users-compromised-using-powershell)

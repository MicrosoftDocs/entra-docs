---
title: Remediate risks and unblock users
description: Learn how to configure user self-remediation and manually remediate risky users in Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 06/02/2025
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.reviewer: chuqiaoshi

# Customer intent: As an IT admin, I want to learn how to remediate risks and unblock users in Microsoft Entra ID Protection.
---
# Remediate risks and unblock users

After completing your [risk investigation](howto-identity-protection-investigate-risk.md), you need to take action to remediate risky users or unblock them. You can set up [risk-based policies](howto-identity-protection-configure-risk-policies.md) to enable automatic remediation or manually update the user's risk status. Microsoft recommends acting quickly because time matters when working with risks.

This article provides several options for automatically and manually remediating risks and covers scenarios when users were blocked because of user risk, so you know how to unblock them.

## Prerequisites

- The [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) role is the least privileged role required to **reset passwords**.
- The [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) role is the least privileged role required to **dismiss user risk**.
- The [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role is the least privileged role required to **create or edit risk-based policies**.
- The [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role is the least privileged role required to **create or edit Conditional Access policies**.

## Types of risk remediation

All active risk detections contribute to the calculation of the user's risk level, which indicates the probability that the user's account is compromised. Depending on the risk level and your tenant's configuration, you might need to investigate and address the risk. 

### Automatic risk remediation

When risk-based Conditional Access policies are configured, remediating user risk and sign-in risk can be a self-service process for users. This self-remediation allows users to resolve their own risks without needing to contact the help desk or an administrator. As an IT administrator, you might not need to take any action to remediate risks, but you do need to know how to configure the policies that allow self-remediation. This article explains the high-level steps to enable self-remediation with risk-based Conditional Access policies and describes how the users's self-remediation experience works. For details on how to configure risk-based policies, see [Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).

### Manual risk remediation

Some situations require an IT administrator to manually remediate sign-in or user risk. If you don't have risk-based policies configured, if the risk level doesn't meet the criteria for self-remediation, or if time is of the essence, you might need to take one of the following actions:

- Generate a temporary password for the user.
- Require the user to reset their password.
- Dismiss the user's risk.
- Confirm the user is compromised and take action to secure the account.
- Unblock the user based on user risk or sign-in risk.

You can also [remediate in Microsoft Defender for Identity](/defender-for-identity/remediation-actions).

### ID Protection risk remediation

In some cases, Microsoft Entra ID Protection can also automatically dismiss a user's risk state. Both the risk detection and the corresponding risky sign-in are identified by ID Protection as no longer posing a security threat. This automatic intervention can happen if the user provides a second factor, such as multifactor authentication (MFA) or if the real-time and offline assessment determines that the sign-in is no longer risky. This automatic remediation reduces noise in risk monitoring so you can focus on the things that require your attention.

- **Risk state**: "At risk" -> "Dismissed"
- **Risk detail**: "-" -> "Microsoft Entra ID Protection assessed sign-in safe"

## Automatic risk remediation

You can allow users to self-remediate their sign-in and user risks by setting up [risk-based policies](howto-identity-protection-configure-risk-policies.md). If users pass the required access control, such as multifactor authentication or secure password change, then their risks are automatically remediated.

For risk-based policies to be applied to allow self-remediation, users must first be able to:

- Perform MFA to self-remediate a sign-in risk: 
   - The user must be registered for Microsoft Entra multifactor authentication.
- Perform secure password change to self-remediate a user risk:
   -  The user must be registered for Microsoft Entra multifactor authentication.
   -  For hybrid users that are synced from on-premises to the cloud, password writeback must be enabled for their password change to sync from the cloud to on-premises.

If a risk-based policy is applied during sign-in where the criteria aren't met, the user is blocked. This block occurs because the user can't perform the required step, so admin intervention is required to [unblock the user](#dismiss-user-risk).

Risk-based policies are configured based on risk levels and only apply if the risk level of the sign-in or user matches the configured level. Some detections might not raise risk to the level where the policy applies, so administrators need to handle those risky users manually. Administrators can determine that extra measures are necessary, such as [blocking access from locations](../identity/conditional-access/policy-block-by-location.md) or lowering the acceptable risk in their policies.

### Self-remediation of sign-in risk

You can require users to perform multifactor authentication (MFA) to remediate sign-in risk. The user must already be registered for MFA. Microsoft recommends requiring MFA when the sign-in risk level is **Medium** or **High**.

1. [Configure the MFA registration policy](howto-identity-protection-configure-mfa-policy.md) to require users to register for MFA.
1. [Configure a sign-in risk policy](howto-identity-protection-configure-risk-policies.md#sign-in-risk-policy-in-conditional-access) to require MFA when the sign-in risk level is **Medium** or **High**.

If a user is prompted to perform MFA to remediate sign-in risk, the risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User passed multifactor authentication"

### Self-remediation of user risk

You can enable Microsoft Entra self-service password reset (SSPR) to allow users to reset their own passwords to remediate user risk. Once enabled, users can perform a [self-service password reset](../identity/authentication/concept-sspr-howitworks.md) to remediate their risk. Requiring users to reset passwords enables self-remediation without contacting the help desk or an administrator. Microsoft recommends requiring a secure password change when the user risk level is **High**. 

1. [Enable users to unlock their account or reset passwords using Microsoft Entra SSPR](../identity/authentication/tutorial-enable-sspr.md).
1. [Configure a user risk policy](howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access) to require a password reset when the user risk level is **High**.

If a user is prompted to use SSPR to remediate user risk, the risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User performed secured password reset"

### Considerations for cloud and hybrid users

- Both cloud and hybrid users can complete a secure password change with SSPR only if they can perform MFA. For users that aren't registered, this option isn't available.
- Hybrid users can complete a password change from an on-premises or hybrid joined Windows device, when password hash synchronization and the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting is enabled.

### Allow on-premises password reset to remediate user risks

If your organization has a hybrid environment, you can allow on-premises password changes to reset user risks with [password hash synchronization](../identity/hybrid/connect/whatis-phs.md). You must enable password hash synchronization *before* users can self-remediate in those scenarios.

- Risky hybrid users can self-remediate without administrator intervention. When the user changes their password on-premises, user risk is automatically remediated within Microsoft Entra ID Protection, resetting the current user risk state.
- Organizations can proactively deploy [user risk policies that require password changes](howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access) to protect their hybrid users. This option strengthens your organization's security posture and simplifies security management by ensuring that user risks are promptly addressed, even in complex hybrid environments.

> [!NOTE]
> Allowing on-premises password change to remediate user risk is an opt-in only feature. Customers should evaluate this feature before enabling it in production environments. We recommend customers secure the on-premises password change process. For example, require multifactor authentication before allowing users to change their password on-premises using a tool like [Microsoft Identity Manager's Self-Service Password Reset Portal](/microsoft-identity-manager/working-with-self-service-password-reset).

To configure this setting:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **Protection** > **Identity Protection** > **Settings**.
1. Check the box to **Allow on-premises password change to reset user risk** and select **Save**.

:::image type="content" source="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png" alt-text="Screenshot showing the location of the Allow on-premises password change to reset user risk checkbox." lightbox="media/howto-identity-protection-remediate-unblock/allow-on-premises-password-reset-user-risk.png":::

## Manual risk remediation

If risk-based policies aren't enabled, or time is of the essence, you can remediate risk manually.

### Generate a temporary password

By generating a temporary password, you can immediately bring an identity back into a safe state. This method requires contacting the affected users because they need to know what the temporary password is. Because the password is temporary, the user is prompted to change the password to something new during the next sign-in.

To generate a temporary password:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) and a [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator).
   - Security Operator is required to access ID Protection and User Administrator is required to reset passwords.
1. Browse to **Protection** > **Identity Protection** > **Risky users**, and select the affected user.
1. Select **Reset password** from the panel that appears.

    :::image type="content" source="media/howto-identity-protection-remediate-unblock/risky-user-details.png" alt-text="Screenshot of the Risky User Details panel with reset password highlighted.":::

1. Review the message and select **Reset password** again.

   :::image type="content" source="media/howto-identity-protection-remediate-unblock/reset-password.png" alt-text="Screenshot of the second reset password button.":::

1. Provide the temporary password to the user. The user must change their password the next time they sign-in.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:
- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "Admin generated temporary password for user"

#### Considerations for cloud and hybrid users

Pay attention to the following considerations when generating a temporary password for cloud and hybrid users:

- You can generate passwords for cloud and hybrid users in the Microsoft Entra admin center.
- You can generate passwords for hybrid users from your on-premises directory if the following settings are in place:
   - Enable password hash synchronization, including the PowerShell script in the [Synchronizing temporary passwords](../identity/hybrid/connect/how-to-connect-password-hash-synchronization.md) section.
   - Enable the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting in Microsoft Entra ID Protection.
   - Enable [Self-service password reset](../identity/authentication/tutorial-enable-sspr.md).
   - In Active Directory, only select the option **User must change password at next logon** if everything in the previous bullets is enabled.

### Require a password reset

You can require risky users to reset their password to remediate their risk. Because these users aren't prompted to change their password through a risk-based policy, you must contact them to reset their password. How the password is reset depends on the type of user:

- **Cloud users and hybrid users with Microsoft Entra-joined devices**: Perform a secure password change after a successful MFA sign-in. Users must already be registered for MFA.
- **Hybrid users with on-premises or hybrid-joined Windows devices**: Perform a secure password change through the Ctrl-Alt-Delete screen on their Windows device.
   - The [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting must be enabled.
   - If the **User must change password at next logon** setting is enabled in Active Directory, the user is prompted to change their password the next time they sign in. This option is available only if the settings in the [Considerations for cloud and hybrid users](#considerations-for-cloud-and-hybrid-users) section are in place.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User performed secure password change"

## Dismiss user risk

If after investigation, you confirm the user account isn't at risk of being compromised, you can dismiss the risky user.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **Protection** > **Identity Protection** > **Risky users**, and select the affected user.
1. Select **Dismiss user risk**.
   - When you select **Dismiss user risk**, the user is no longer at risk, and all the risky sign-ins and corresponding risk detections are dismissed.
   - Because this method doesn't affect the user's existing password, it doesn't bring their identity back into a safe state.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Dismissed"
- Risk detail: "-" -> "Admin dismissed all risk for user"

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

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Confirmed compromised"
- Risk detail: "-" -> "Admin confirmed user compromised"

## Unblocking users

Risk-based policies can be used to block accounts to protect your organization from compromised accounts. You should investigate these scenarios to determine how to unblock the user and then determine why the user was blocked.

### Unblocking based on sign-in risk

To unblock an account based on sign-in risk, you have the following options:

- **Sign in from a familiar location or device**: Sign-ins are often blocked as suspicious if the sign-in attempt appears to come from an unfamiliar location or device. Your users can sign-in from a familiar location or device to try and unblock the sign-in. If the sign-in is successful, Microsoft ID Protection automatically remediates the sign-in risk.
  - Risk state: "At risk" -> "Dismissed"
  - Risk detail: "-" -> "Microsoft Entra ID Protection assessed sign-in safe"

- **Exclude the user from policy**: If you think the current configuration of your sign-in policy is causing issues for *specific* users, you can exclude the users from the policy. The user's risk might need to be manually dismissed so they can sign in.
  - For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md#policy-exclusions).

- **Disable policy**: If you think that your policy configuration is causing issues for *all* users, you can disable the policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).

### Unblocking based on user risk

To unblock an account blocked because of user risk, you have the following options:

- **Reset password**: If a user is compromised or is at risk of being compromised, the user's password should be reset to protect their account and your organization.
- **Dismiss user risk**: The user risk policy blocks a user when the configured user risk level for blocking access is reached. If after investigation you're confident that the user isn't at risk of being compromised, and it's safe to allow their access, then you can reduce a user's risk level by dismissing their user risk.
- **Exclude the user from policy**: If you think that the current configuration of your sign-in policy is causing issues for specific users, and it's safe to grant access to these users without applying this policy to them, then you can exclude them from this policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md#policy-exclusions).
- **Disable policy**: If you think that your policy configuration is causing issues for all your users, you can disable the policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).



### Automatic blocking due to high confidence risk

Microsoft Entra ID Protection automatically blocks sign-ins that have a very high confidence of being risky. This block most commonly occurs on sign-ins performed using legacy authentication protocols or displaying properties of a malicious attempt.

When a user is blocked for either scenario, they receive a 50053 authentication error. The sign-in logs display the following block reason: "Sign-in was blocked by built-in protections due to high confidence of risk."

To unblock an account based on high confidence sign-in risk, you have the following options:

1. **Add the IPs being used to sign in to the Trusted location settings** - If the sign-in is performed from a known location for your company, you can add the IP to the trusted list. For more information, see [Conditional Access: Network assignment](../identity/conditional-access/concept-assignment-network.md#trusted-locations).
1. **Use a modern authentication protocol** - If the sign-in is performed using a legacy protocol, switching to a modern method unblocks the attempt.

### Deleted users

If a user was deleted from the directory that had a risk present, that user still appears in the risk report even though the account was deleted. Administrators can't dismiss risk for users who were deleted from the directory. To remove deleted users, open a Microsoft support case.

## PowerShell preview

Using the Microsoft Graph PowerShell SDK Preview module, organizations can manage risk using PowerShell. The preview modules and sample code can be found in the [Microsoft Entra GitHub repo](https://github.com/AzureAD/IdentityProtectionTools).

The `Invoke-AzureADIPDismissRiskyUser.ps1` script included in the repository allows organizations to dismiss all risky users in their directory.


## Related content

- [Simulate a high user risk](howto-identity-protection-graph-api.md#confirm-users-compromised-using-powershell)

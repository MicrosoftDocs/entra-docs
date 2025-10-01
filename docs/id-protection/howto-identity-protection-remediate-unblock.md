---
title: Remediate risks and unblock users
description: Learn how to configure user self-remediation and manually remediate risky users in Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 06/12/2025
author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera
ms.reviewer: ebasseri

# Customer intent: As an IT admin, I want to learn how to remediate risks and unblock users in Microsoft Entra ID Protection.
---
# Remediate risks and unblock users

After completing your [risk investigation](howto-identity-protection-investigate-risk.md), you need to take action to remediate risky users or unblock them. You can set up [risk-based policies](howto-identity-protection-configure-risk-policies.md) to enable automatic remediation or manually update the user's risk status. Microsoft recommends acting quickly because time matters when working with risks.

This article provides several options for automatically and manually remediating risks and covers scenarios when users were blocked because of user risk, so you know how to unblock them.

## Prerequisites

- The Microsoft Entra ID P2 or Microsoft Entra Suite license is required for full access to Microsoft Entra ID Protection features.
    - For a detailed list of capabilities for each license tier, see [What is Microsoft Entra ID Protection](overview-identity-protection.md).
- The [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) role is the least privileged role required to **reset passwords**.
- The [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) role is the least privileged role required to **dismiss user risk**.
- The [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role is the least privileged role required to **create or edit risk-based policies**.
- The [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role is the least privileged role required to **create or edit Conditional Access policies**.

## How risk remediation works

All active risk detections contribute to the calculation of the user's risk level, which indicates the probability that the user's account is compromised. Depending on the risk level and your tenant's configuration, you might need to investigate and address the risk. You can allow users to self-remediate their sign-in and user risks by setting up [risk-based policies](howto-identity-protection-configure-risk-policies.md). If users pass the required access control, such as multifactor authentication or secure password change, then their risks are automatically remediated.

If a risk-based policy is applied during sign-in where the criteria aren't met, the user is blocked. This block occurs because the user can't perform the required step, so admin intervention is required to [unblock the user](#unblock-users).

Risk-based policies are configured based on risk levels and only apply if the risk level of the sign-in or user matches the configured level. Some detections might not raise risk to the level where the policy applies, so administrators need to handle those situations manually. Administrators can determine that extra measures are necessary, such as [blocking access from locations](../identity/conditional-access/policy-block-by-location.md) or lowering the acceptable risk in their policies.

## End user self-remediation

When risk-based Conditional Access policies are configured, remediating user risk and sign-in risk can be a self-service process for users. This self-remediation allows users to resolve their own risks without needing to contact the help desk or an administrator. As an IT administrator, you might not need to take any action to remediate risks, but you do need to know how to configure the policies that allow self-remediation and what to expect to see in the related reports. For more information, see:

- [Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md)
- [Self-remediation experience with Microsoft Entra ID Protection and Conditional Access](concept-identity-protection-user-experience.md)
- [Require multifactor authentication for all users](../identity/conditional-access/policy-all-users-mfa-strength.md)
- [Implement password hash sync](../identity/hybrid/connect/how-to-connect-password-hash-synchronization.md)

### Self-remediation of sign-in risk

If a user's sign-in risk reaches the level set by your risk-based policy, the user is prompted to perform multifactor authentication (MFA) to remediate sign-in risk. If they successfully complete the MFA challenge, the sign-in risk is remediated. The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User passed multifactor authentication"

Sign-in risks that aren't remediated impact the user risk, so having risk-based policies in place allows users to self-remediate their sign-in risk, so their user risk isn't affected. 

### Self-remediation of user risk

If a user is prompted to use self-service password reset (SSPR) to remediate user risk, they are prompted to update their password as shown in the [Microsoft Entra ID Protection user experience](concept-identity-protection-user-experience.md) article. Once they update their password, the user risk is remediated. The user can then proceed to sign in with their new password. The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User performed secured password reset"

#### Considerations for cloud and hybrid users

- Both cloud and hybrid users can complete a secure password change with SSPR only if they can perform MFA. For users that aren't registered, this option isn't available.
- Hybrid users can complete a password change from an on-premises or hybrid joined Windows device, when password hash synchronization and the [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting is enabled.

## System-based remediation 

In some cases, Microsoft Entra ID Protection can also automatically dismiss a user's risk state. Both the risk detection and the corresponding risky sign-in are identified by ID Protection as no longer posing a security threat. This automatic intervention can happen if the user provides a second factor, such as multifactor authentication (MFA) or if the real-time and offline assessment determines that the sign-in is no longer risky. This automatic remediation reduces noise in risk monitoring so you can focus on the things that require your attention.

- **Risk state**: "At risk" -> "Dismissed"
- **Risk detail**: "-" -> "Microsoft Entra ID Protection assessed sign-in safe"

## Administrator manual remediation

Some situations require an IT administrator to manually remediate sign-in or user risk. If you don't have risk-based policies configured, if the risk level doesn't meet the criteria for self-remediation, or if time is of the essence, you might need to take one of the following actions:

- Generate a temporary password for the user.
- Require the user to reset their password.
- Dismiss the user's risk.
- Confirm the user is compromised and take action to secure the account.
- Unblock the user.

You can also [remediate in Microsoft Defender for Identity](/defender-for-identity/remediation-actions).

### Generate a temporary password

By generating a temporary password, you can immediately bring an identity back into a safe state. This method requires contacting the affected users because they need to know what the temporary password is. Because the password is temporary, the user is prompted to change the password to something new during the next sign-in.

To generate a temporary password:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
   - To generate a temporary password from the user's details, you need the [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) role.
   - To generate a temporary password from ID Protection, you need both the [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) and [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator) roles.
   - Security Operator is required to access ID Protection and User Administrator is required to reset passwords.

1. Browse to **Protection** > **Identity Protection** > **Risky users**, and select the affected user.
   - Alternatively, browse to **Users** > **All users**, and select the affected user.

1. Select **Reset password**.

    :::image type="content" source="media/howto-identity-protection-remediate-unblock/risky-user-details.png" alt-text="Screenshot of the Risky User Details panel with reset password highlighted." lightbox="media/howto-identity-protection-remediate-unblock/risky-user-details.png":::

1. Review the message and select **Reset password** again.

   :::image type="content" source="media/howto-identity-protection-remediate-unblock/reset-password.png" alt-text="Screenshot of the second reset password button." lightbox="media/howto-identity-protection-remediate-unblock/reset-password.png":::

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
   - In Active Directory, only select the option **User must change password at next logon** after you enable everything in the previous bullets.

### Require a password reset

You can require risky users to reset their password to remediate their risk. Because these users aren't prompted to change their password through a risk-based policy, you must contact them to reset their password. How the password is reset depends on the type of user:

- **Cloud users and hybrid users with Microsoft Entra-joined devices**: Perform a secure password change after a successful MFA sign-in. Users must already be registered for MFA.
- **Hybrid users with on-premises or hybrid-joined Windows devices**: Perform a secure password change through the Ctrl-Alt-Delete screen on their Windows device.
   - The [Allow on-premises password change to reset user risk](#allow-on-premises-password-reset-to-remediate-user-risks) setting must be enabled.
   - If the **User must change password at next logon** setting is enabled in Active Directory, the user is prompted to change their password the next time they sign in. This option is available only if the settings in the [Considerations for cloud and hybrid users](#considerations-for-cloud-and-hybrid-users) section are in place.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Remediated"
- Risk detail: "-" -> "User performed secure password change"

### Dismiss risk

If after investigation, you confirm the sign-in or user account isn't at risk of being compromised, you can dismiss the risk.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator).
1. Browse to **Protection** > **Identity Protection** > **Risky sign-ins** or **Risky users**, and select the risky activity.
1. Select **Dismiss risky sign-in(s)** or **Dismiss user risk**.

Because this method doesn't change the user's existing password, it doesn't bring their identity back into a safe state. You might still need to contact the user to inform them of the risk and advise them to change their password.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Dismissed"
- Risk detail: "-" -> "Admin dismissed risk for sign-in" or "Admin dismissed all risk for user"

### Confirm a user to be compromised

If after investigation, you confirm that the sign-in or user *is* at risk, you can manually confirm an account is compromised:

1. Select the event or user in the **Risky sign-ins** or **Risky users** reports and choose **Confirm compromised**.
1. If a risk-based policy wasn't triggered, and the risk wasn't self-remediated using one of the methods described in this article, then take one or more of the following actions:
   1. [Request a password reset](#require-a-password-reset).
   1. Block the user if you suspect the attacker can reset the password or do multifactor authentication for the user.
   1. [Revoke refresh tokens](/entra/identity/users/users-revoke-access).
   1. [Disable any devices](../identity/devices/manage-device-identities.md) that are considered compromised.
   1. If using [continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation.md), revoke all access tokens.

The risk state and risk details for the user, sign-ins, and corresponding risk detections are updated as follows:

- Risk state: "At risk" -> "Confirmed compromised"
- Risk detail: "-" -> "Admin confirmed user compromised"

For more information about what happens when confirming compromise, see [How to give feedback on risks](howto-identity-protection-risk-feedback.md#how-to-give-risk-feedback-in-microsoft-entra-id-protection).

### Unblock users

Risk-based policies can be used to block accounts to protect your organization from compromised accounts. You should investigate these scenarios to determine how to unblock the user and then determine why the user was blocked. 

#### Sign in from a familiar location or device

Sign-ins are often blocked as suspicious if the sign-in attempt appears to come from an unfamiliar location or device. Your users can sign-in from a familiar location or device to try and unblock the sign-in. If the sign-in is successful, Microsoft ID Protection automatically remediates the sign-in risk.

- Risk state: "At risk" -> "Dismissed"
- Risk detail: "-" -> "Microsoft Entra ID Protection assessed sign-in safe"

#### Exclude the user from policy

If you think the current configuration of your sign-in or user risk policy is causing issues for *specific* users, you can exclude the users from the policy. You need to confirm that it's safe to grant access to these users without applying this policy to them. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md#policy-exclusions).

You might need to [manually dismiss](#dismiss-risk) the risk or user so they can sign in.

#### Disable the policy

If you think that your policy configuration is causing issues for *all* users, you can disable the policy. For more information, see [How To: Configure and enable risk policies](howto-identity-protection-configure-risk-policies.md).

You might need to [manually dismiss](#dismiss-risk) the risk or user so they can sign in before addressing the policy.

#### Automatic blocking due to high confidence risk

Microsoft Entra ID Protection automatically blocks sign-ins that have a very high confidence of being risky. This block most commonly occurs on sign-ins performed using legacy authentication protocols or displaying properties of a malicious attempt. When a user is blocked for either scenario, they receive a 50053 authentication error. The sign-in logs display the following block reason: "Sign-in was blocked by built-in protections due to high confidence of risk."

To unblock an account based on high confidence sign-in risk, you have the following options:

- **Add the IPs being used to sign in to the Trusted location settings**: If the sign-in is performed from a known location for your company, you can add the IP to the trusted list. For more information, see [Conditional Access: Network assignment](../identity/conditional-access/concept-assignment-network.md#trusted-locations).
- **Use a modern authentication protocol**: If the sign-in is performed using a legacy protocol, switching to a modern method unblocks the attempt.

## Allow on-premises password reset to remediate user risks

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

## Deleted users

If a user was deleted from the directory that had a risk present, that user still appears in the risk report even though the account was deleted. Administrators can't dismiss risk for users who were deleted from the directory. To remove deleted users, open a Microsoft support case.

## PowerShell preview

Using the Microsoft Graph PowerShell SDK Preview module, organizations can manage risk using PowerShell. The preview modules and sample code can be found in the [Microsoft Entra GitHub repo](https://github.com/AzureAD/IdentityProtectionTools).

The `Invoke-AzureADIPDismissRiskyUser.ps1` script included in the repository allows organizations to dismiss all risky users in their directory.

## Related content

- [Simulate a high user risk](howto-identity-protection-graph-api.md#confirm-users-compromised-using-powershell)

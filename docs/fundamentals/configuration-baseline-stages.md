---
title: Recommended security configurations in Microsoft Entra ID
description: 

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 07/23/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: 
---
# Microsoft Entra security recommendations

The following recommendations are influenced by accepted industry standards like those developed by NIST, the configuration baselines we use internally at Microsoft, and our experiences with customers.

We lay out these recommendations in a multistage manner that allows controls to build on each other.

These controls align with the guidance provided in the [Microsoft Cloud security benchmark](/security/benchmark/azure/overview) including the following Security Controls:

- [Identity management](/security/benchmark/azure/mcsb-identity-management)
- [Privileged access](/security/benchmark/azure/mcsb-privileged-access)
- [Data protection](/security/benchmark/azure/mcsb-data-protection)
- [Logging and threat detection](/security/benchmark/azure/mcsb-logging-threat-detection)

We recommend that all of these controls be implemented where required licenses are available to provide the most robust security capabilities.

## Stage 1: Emergency access accounts

[!INCLUDE [emergency-access-accounts](../includes/definitions/emergency-access-accounts.md)]

## Stage 2: Create administrator accounts

Accounts with administrative access should be governed by the following configurations. These accounts are used to complete the rest of your configuration. Additional capabilities to control and manage these roles is introduced in stages that follow.

| Control | Description and tasks |
| --- | --- |
| Separate distinct accounts must be used for elevated accounts | [Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](/entra/identity/role-based-access-control/security-planning) <br><br> - [Remove all unnecessary licenses from administrator accounts](/entra/fundamentals/license-users-groups) <br> - [Use least privileged roles where possible](/entra/identity/role-based-access-control/permissions-reference) <br> - [Highly privileged roles are treated as equivalent to Global Administrator](/entra/identity/role-based-access-control/privileged-roles-permissions) |
| Restrict non-person accounts and Service Principals from being assigned or eligible for Global Administrator and other highly privileged roles | [Remove role assignments from a group in Microsoft Entra ID](/entra/identity/role-based-access-control/groups-remove-assignment) |

## Stage 3: Tenant configurations

| Control | Description and tasks |
| --- | --- |
| Restrict users from creating additional Microsoft Entra ID tenants | [What are the default user permissions in Microsoft Entra ID?](/entra/fundamentals/users-default-permissions)
| Limit number of devices per user in Entra ID | [Manage device identities using the Microsoft Entra admin center](/entra/identity/devices/manage-device-identities) |
| Enable Microsoft Entra smart lockout | [Protect user accounts from attacks with Microsoft Entra smart lockout](/entra/identity/authentication/howto-password-smart-lockout) |
| Enable AD FS smart lock out (If applicable) | [AD FS Extranet Lockout and Extranet Smart Lockout Overview](/windows-server/identity/ad-fs/operations/configure-ad-fs-extranet-smart-lockout-protection) |

## Stage 4: Configure authentication methods

These authentication methods are used by self-service password reset and Conditional Access policies in the following stages.

| Control | Description and tasks |
| --- | --- |
| Define the authentication methods your organization allows | [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](/entra/identity/authentication/how-to-authentication-methods-manage) |
| Enable phishing-resistant passwordless auth methods for cloud-only accounts | [Passwordless authentication options for Microsoft Entra ID](/entra/identity/authentication/howto-authentication-passwordless-deployment) |
| Create a custom authentication strength | [Custom Conditional Access authentication strengths](/entra/identity/authentication/concept-authentication-strength-advanced-options) |
| Reduce the user-visible password surface-area | [Reduce the user-visible password surface area](/windows/security/identity-protection/passwordless-strategy/journey-step-2) |

## Stage 5: Passwords

| Control | Description and tasks |
| --- | --- |
| Enable Microsoft's password guidance | [Microsoft's password guidance](https://www.microsoft.com/research/publication/password-guidance/) |
| Enable self-service password reset | [Allow users to unlock their account or reset passwords using Microsoft Entra self-service password reset](/entra/identity/authentication/tutorial-enable-sspr) <br><br> - [Require two authentication methods to reset](/entra/identity/authentication/concept-sspr-howitworks#number-of-authentication-methods-required) <br> - [Require users register when signing in](/entra/identity/authentication/concept-sspr-howitworks#require-users-to-register-when-they-sign-in) <br> - [Notify users on password resets](/entra/identity/authentication/concept-sspr-howitworks#notify-users-on-password-resets) <br> - [Notify all admins when other admins reset their password](/entra/identity/authentication/concept-sspr-howitworks#notify-all-admins-when-other-admins-reset-their-passwords) |
| Create an organization specific custom banned password list | [Tutorial: Configure custom banned passwords for Microsoft Entra password protection](/entra/identity/authentication/tutorial-configure-custom-password-protection) |
| Enable Password Protection (if using hybrid identities) | [Plan and deploy on-premises Microsoft Entra Password Protection](/entra/identity/authentication/howto-password-ban-bad-on-premises-deploy) |
| Enable Password Hash Sync (if using hybrid identities) | [Implement password hash synchronization with Microsoft Entra Connect Sync](/entra/identity/hybrid/connect/how-to-connect-password-hash-synchronization) |
| Implement Password Writeback (if using hybrid identities) | [Tutorial: Enable Microsoft Entra self-service password reset writeback to an on-premises environment](/entra/identity/authentication/tutorial-enable-sspr-writeback) |

## Stage 6: Conditional Access

There are two paths to take at this stage depending on the license you hold. Security defaults for Microsoft Entra ID Free customers or Microsoft Entra Conditional Access policies for Microsoft Entra ID P1 and P2 customers. Many Conditional Access policies have dependencies on previous stages being completed.

| Control | Description and tasks |
| --- | --- |
| If you are a Microsoft Entra Free tier customer, you must enable Microsoft Entra ID security defaults. | [Security defaults in Microsoft Entra ID](/entra/fundamentals/security-defaults) |
| The following [Conditional Access policies](/entra/identity/conditional-access/plan-conditional-access) must be deployed if you have Microsoft Entra ID P1 | The following policies apply where customers are licensed with Microsoft Entra ID P1 <br><br> - [Block legacy authentication](/entra/identity/conditional-access/howto-conditional-access-policy-block-legacy) <br> - [Securing security info registration](/entra/identity/conditional-access/howto-conditional-access-policy-registration) <br> - [Require phishing-resistant multifactor authentication for administrators](/entra/identity/conditional-access/how-to-policy-phish-resistant-admin-mfa) <br> - [Require multifactor authentication for all users](/entra/identity/conditional-access/howto-conditional-access-policy-all-users-mfa) <br> - [Require multifactor authentication for device registration](/entra/identity/conditional-access/how-to-policy-mfa-device-register-join) <br> - [Require compliant or Microsoft Entra hybrid joined device for all users](/entra/identity/conditional-access/howto-conditional-access-policy-compliant-device-admin) (\*Requires devices either be [compliant with mobile device management configuration policies](/mem/intune/protect/device-compliance-get-started) or be [hybrid joined to an on-premises directory](/entra/identity/devices/how-to-hybrid-join)) <br> - [Require multifactor authentication for guest access](/entra/identity/conditional-access/howto-policy-guest-mfa) |
| If you have Microsoft Entra ID P2 you must deploy risk-based Conditional Access policies in addition to the Microsoft Entra P1 tier policies. | The following policies apply where customers are licensed with Microsoft Entra ID P2 <br><br> - [How To: Configure the multifactor authentication registration policy](/entra/id-protection/howto-identity-protection-configure-mfa-policy) <br> - [Require multifactor authentication for risky sign-ins](/entra/identity/conditional-access/howto-conditional-access-policy-risk) <br> - [Require password change with MFA for high-risk users](/entra/identity/conditional-access/howto-conditional-access-policy-risk-user) |

## Stage 7: Monitoring

| Control | Description and tasks |
| --- | --- |
| Store at least 2 years of audit and sign-in logs in online storage | [Configure Microsoft Entra diagnostic settings for activity logs](/entra/identity/monitoring-health/howto-configure-diagnostic-settings) |
| Monitor unusual sign ins | [Microsoft Entra security operations for user accounts](/entra/architecture/security-operations-user-accounts#unusual-sign-ins) |
| Monitor attempts to change self-service password reset configuration | []() |
| Monitor and close gaps in Conditional Access policies | [Conditional Access gap analyzer workbook](/entra/identity/monitoring-health/workbook-conditional-access-gap-analyzer) |
| Monitor changes configuration of Entra ID Connect | [Security operations for infrastructure](/entra/architecture/security-operations-infrastructure#microsoft-entra-connect) |
| Monitor attempts to configure staged rollout on federated domains | []() |

## Stage 8: Governance

| Control | Description and tasks |
| --- | --- |
| Enable Privileged Identity Management (PIM) | [What is Microsoft Entra Privileged Identity Management?](/entra/id-governance/privileged-identity-management/pim-configure) |
| Conduct quarterly reviews of users and role assignments | [Create an access review of Azure resource and Microsoft Entra roles in PIM](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) |
| Complete an access review for Microsoft Entra directory roles in PIM | [Create an access review of Azure resource and Microsoft Entra roles in PIM](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) |
| Manage connected organizations in entitlement management | [Manage connected organizations in entitlement management](/entra/id-governance/entitlement-management-organization) |
| Govern access for external users in entitlement management | [Govern access for external users in entitlement management](/entra/id-governance/entitlement-management-external-users) |
| Manage guest access with access reviews | [Manage guest access with access reviews](/entra/id-governance/manage-guest-access-with-access-reviews) |

## Stage X, Y, Z Applications, External collaboration, Credential management

Work in progress based on guidance from [Liquid Entra ID Primary Tenant Baseline](https://liquid.microsoft.com/Web/Views/View/731262) and from internal sources.

## Next steps

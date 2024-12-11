---
title: Providing a default level of security in Microsoft Entra ID
description: Get protected from common identity threats using Microsoft Entra security defaults.

ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 04/15/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: sama
---
# Security defaults in Microsoft Entra ID

Security defaults make it easier to help protect your organization from identity-related attacks like password spray, replay, and phishing common in today's environments. 

Microsoft is making these preconfigured security settings available to everyone, because we know managing security can be difficult. Based on our learnings more than 99.9% of those common identity-related attacks are stopped by using multifactor authentication and blocking legacy authentication. Our goal is to ensure that all organizations have at least a basic level of security enabled at no extra cost.

These basic controls include:

- [Requiring all users to register for multifactor authentication](#require-all-users-to-register-for-azure-ad-multifactor-authentication)
- [Requiring administrators to do multifactor authentication](#require-administrators-to-do-multifactor-authentication)
- [Requiring users to do multifactor authentication when necessary](#require-users-to-do-multifactor-authentication-when-necessary)
- [Blocking legacy authentication protocols](#block-legacy-authentication-protocols)
- [Protecting privileged activities like access to the Azure portal](#protect-privileged-activities-like-access-to-the-azure-portal)

## Who's it for?

- Organizations who want to increase their security posture, but don't know how or where to start.
- Organizations using the free tier of Microsoft Entra ID licensing.

### Who should use Conditional Access?

- If you're an organization with Microsoft Entra ID P1 or P2 licenses, security defaults are probably not right for you.
- If your organization has complex security requirements, you should consider [Conditional Access](/entra/identity/conditional-access/overview).

## Enabling security defaults

If your tenant was created on or after October 22, 2019, security defaults might be enabled in your tenant. To protect all of our users, security defaults are being rolled out to all new tenants at creation. 

To help protect organizations, we're always working to improve the security of Microsoft account services. As part of this protection, customers are periodically notified for the automatic enablement of the security defaults if they: 

- Don't have any Conditional Access policies
- Don't have premium licenses
- Aren’t actively using legacy authentication clients

After this setting is enabled, all users in the organization will need to register for multifactor authentication. To avoid confusion, refer to the email you received and alternatively you can [disable security defaults](#disabling-security-defaults) after it's enabled.

To configure security defaults in your directory, you must be assigned at least the [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role. By default the first account in any directory is assigned a higher privileged role known as [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator). 

To enable security defaults:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Identity** > **Overview** > **Properties**.
1. Select **Manage security defaults**.
1. Set **Security defaults** to **Enabled**.
1. Select **Save**.

:::image type="content" source="media/security-defaults/security-defaults-entra-admin-center.png" alt-text="Screenshot of the Microsoft Entra admin center with the toggle to enable security defaults" lightbox="media/security-defaults/security-defaults-entra-admin-center.png":::

### Revoking active tokens

As part of enabling security defaults, administrators should revoke all existing tokens to require all users to register for multifactor authentication. This revocation event forces previously authenticated users to authenticate and register for multifactor authentication. This task can be accomplished using the [Revoke-AzureADUserAllRefreshToken](/powershell/module/azuread/revoke-azureaduserallrefreshtoken) PowerShell cmdlet.

## Enforced security policies

<a name='require-all-users-to-register-for-azure-ad-multifactor-authentication'></a>

### Require all users to register for Microsoft Entra multifactor authentication

> [!NOTE]
> Starting July 29, 2024, new tenants may not have the 14-day grace period for users to register for MFA. We are making this change to help reduce the risk of account compromise during the 14-day window, as MFA can block over 99.2% of identity-based attacks. 

All users have 14 days to register using the [Microsoft Authenticator app](~/identity/authentication/concept-authentication-authenticator-app.md) or any app supporting [OATH TOTP](~/identity/authentication/concept-authentication-oath-tokens.md). After the 14 days pass, the user can't sign in until registration is completed. A user's 14-day period begins after their first successful interactive sign-in after enabling security defaults.

When users sign in and are prompted to perform multifactor authentication, they see a screen providing them with a number to enter in the Microsoft Authenticator app. This measure helps prevent users from falling for MFA fatigue attacks.

:::image type="content" source="media/security-defaults/approve-sign-in-request.png" alt-text="Screenshot showing an example of the Approve sign in request window with a number to enter.":::

### Require administrators to do multifactor authentication

Administrators have increased access to your environment. Because of the power these highly privileged accounts have, you should treat them with special care. One common method to improve the protection of privileged accounts is to require a stronger form of account verification for sign-in, like requiring multifactor authentication. 

> [!TIP]
> Recommendations for your admins:
> - Ensure all your admins sign in after enabling security defaults so that they can register for authentication methods.
> - Have separate accounts for administration and standard productivity tasks to significantly reduce the number of times your admins are prompted for MFA.

After registration is finished, the following administrator roles will be required to do multifactor authentication every time they sign in:

[!INCLUDE [conditional-access-admin-roles](../includes/conditional-access-admin-roles.md)]
- Authentication Policy Administrator
- Identity Governance Administrator

### Require users to do multifactor authentication when necessary

We tend to think that administrator accounts are the only accounts that need extra layers of authentication. Administrators have broad access to sensitive information and can make changes to subscription-wide settings. But attackers frequently target end users. 

After these attackers gain access, they can request access to privileged information for the original account holder. They can even download the entire directory to do a phishing attack on your whole organization. 

One common method to improve protection for all users is to require a stronger form of account verification, such as multifactor authentication, for everyone. After users complete registration, they'll be prompted for another authentication whenever necessary. Microsoft decides when a user is prompted for multifactor authentication, based on factors such as location, device, role, and task. This functionality protects all registered applications, including SaaS applications.

> [!NOTE]
> In case of [B2B direct connect](~/external-id/b2b-direct-connect-overview.md) users, any multifactor authentication requirement from security defaults enabled in resource tenant will need to be satisfied, including multifactor authentication registration by the direct connect user in their home tenant.

### Block legacy authentication protocols

To give your users easy access to your cloud apps, we support various authentication protocols, including legacy authentication. *Legacy authentication* is a term that refers to an authentication request made by:

- Clients that don't use modern authentication (for example, an Office 2010 client)
- Any client that uses older mail protocols such as IMAP, SMTP, or POP3

Today, most compromising sign-in attempts come from legacy authentication. Legacy authentication doesn't support multifactor authentication. Even if you have a multifactor authentication policy enabled on your directory, an attacker can authenticate by using an older protocol and bypass multifactor authentication. 

After security defaults are enabled in your tenant, all authentication requests made by an older protocol will be blocked. Security defaults blocks Exchange Active Sync basic authentication.

> [!WARNING]
> Before you enable security defaults, make sure your administrators aren't using older authentication protocols. For more information, see [How to move away from legacy authentication](~/identity/conditional-access/policy-block-legacy-authentication.md).

- [How to set up a multifunction device or application to send email using Microsoft 365](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365)

### Protect privileged activities like access to the Azure portal

Organizations use various Azure services managed through the Azure Resource Manager API, including:

- Azure portal 
- Microsoft Entra admin center
- Azure PowerShell 
- Azure CLI

Using Azure Resource Manager to manage your services is a highly privileged action. Azure Resource Manager can alter tenant-wide configurations, such as service settings and subscription billing. Single-factor authentication is vulnerable to various attacks like phishing and password spray. 

It's important to verify the identity of users who want to access Azure Resource Manager and update configurations. You verify their identity by requiring more authentication before you allow access.

After you enable security defaults in your tenant, any user accessing the following services must complete multifactor authentication: 

- Azure portal
- Microsoft Entra admin center
- Azure PowerShell 
- Azure CLI 

This policy applies to all users who are accessing Azure Resource Manager services, whether they're an administrator or a user. This policy applies to Azure Resource Manager APIs such as accessing your subscription, VMs, storage accounts, and so on. This policy doesn't include Microsoft Entra ID or Microsoft Graph.

> [!NOTE]
> Pre-2017 Exchange Online tenants have modern authentication disabled by default. In order to avoid the possibility of a login loop while authenticating through these tenants, you must [enable modern authentication](/exchange/clients-and-mobile-in-exchange-online/enable-or-disable-modern-authentication-in-exchange-online).

> [!NOTE]
> The Microsoft Entra Connect synchronization account is excluded from security defaults and will not be prompted to register for or perform multifactor authentication. Organizations should not be using this account for other purposes.

## Deployment considerations

### Preparing your users

It's critical to inform users about upcoming changes, registration requirements, and any necessary user actions. We provide [communication templates](https://aka.ms/mfatemplates) and [user documentation](https://support.microsoft.com/account-billing/set-up-security-info-from-a-sign-in-page-28180870-c256-4ebf-8bd7-5335571bf9a8) to prepare your users for the new experience and help to ensure a successful rollout. Send users to https://myprofile.microsoft.com to register by selecting the **Security Info** link on that page.

### Authentication methods

Security defaults users are required to register for and use multifactor authentication using the [Microsoft Authenticator app using notifications](~/identity/authentication/concept-authentication-authenticator-app.md). Users might use verification codes from the Microsoft Authenticator app but can only register using the notification option. Users can also use any third party application using [OATH TOTP](~/identity/authentication/concept-authentication-oath-tokens.md) to generate codes.

> [!WARNING]
> Do not disable methods for your organization if you are using security defaults. Disabling methods may lead to locking yourself out of your tenant. Leave all **Methods available to users** enabled in the [MFA service settings portal](~/identity/authentication/howto-mfa-getstarted.md#choose-authentication-methods-for-mfa).

### B2B users

Any [B2B guest](~/external-id/what-is-b2b.md) users or [B2B direct connect](~/external-id/b2b-direct-connect-overview.md) users that access your directory are treated the same as your organization's users.

### Disabled MFA status

If your organization is a previous user of per-user based multifactor authentication, don't be alarmed to not see users in an **Enabled** or **Enforced** status if you look at the multifactor authentication status page. **Disabled** is the appropriate status for users who are using security defaults or Conditional Access based multifactor authentication.

### Disabling security defaults

Organizations that choose to implement Conditional Access policies that replace security defaults must disable security defaults. 

To disable security defaults in your directory:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator).
1. Browse to **Identity** > **Overview** > **Properties**.
1. Select **Manage security defaults**.
1. Set **Security defaults** to **Disabled (not recommended)**.
1. Select **Save**.

### Move from security defaults to Conditional Access

While security defaults are a good baseline to start your security posture from, they don't allow for the customization that many organizations require. Conditional Access policies provide a full range of customization that more complex organizations require.

|| Security defaults | Conditional Access |
| --- | --- | --- |
| **Required licenses**| None | At least Microsoft Entra ID P1 |
| **Customization**| No customization (on or off) | Fully customizable |
| **Enabled by**| Microsoft or administrator | Administrator |
| **Complexity**| Simple to use | Fully customizable based on your requirements |

Recommended steps when moving from security defaults 

Organizations who would like to test out the features of Conditional Access can [sign up for a free trial](get-started-premium.md) to get started.

After administrators disable security defaults, organizations should immediately enable Conditional Access policies to protect their organization. These policies should include at least those policies in the [secure foundations category of Conditional Access templates](~/identity/conditional-access/concept-conditional-access-policy-common.md?tabs=secure-foundation#template-categories). Organizations with Microsoft Entra ID P2 licenses that include Microsoft Entra ID Protection can expand on this list to include [user and sign in risk-based policies](~/id-protection/howto-identity-protection-configure-risk-policies.md) to further strengthen their posture. 

[!INCLUDE [emergency-access-accounts](../includes/definitions/emergency-access-accounts.md)]

## Next steps

- [Blog: Introducing security defaults](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/introducing-security-defaults/ba-p/1061414)
- More information about licensing can be found on the [Microsoft Entra pricing page](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

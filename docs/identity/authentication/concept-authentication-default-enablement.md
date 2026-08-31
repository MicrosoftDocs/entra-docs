---
title: Protecting authentication methods in Microsoft Entra ID
description: Learn how Microsoft Entra ID protects authentication methods with default protection and Microsoft managed settings for registration campaigns.
ms.topic: concept-article
ms.date: 05/04/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-108
# Customer intent: As an identity administrator, I want to understand how default protection and Microsoft managed settings work so that I can improve my organization's security posture.
---

# Protecting authentication methods in Microsoft Entra ID

Microsoft Entra ID adds and improves security features to protect customers against increasing attacks. As new attack vectors emerge, Microsoft Entra ID can respond by enabling protection by default to help customers stay ahead of emerging security threats.

For example, in response to increasing MFA fatigue attacks, Microsoft recommended ways for customers to [defend users](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/defend-your-users-from-mfa-fatigue-attacks/ba-p/2365677). To prevent accidental multifactor authentication (MFA) approvals, enable [number matching](how-to-mfa-number-match.md). As a result, default behavior for number matching is explicitly **Enabled** for all Microsoft Authenticator users. You can learn more about new security features like number matching in the blog post [Advanced Microsoft Authenticator security features are now generally available!](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/advanced-microsoft-authenticator-security-features-are-now/ba-p/2365673).

There are two ways for protection of a security feature to be enabled by default: 

- After a security feature is released, customers can use the Microsoft Entra admin center or Graph API to test and roll out the change on their own schedule. To help defend against new attack vectors, Microsoft Entra ID can enable protection by default for all tenants on a certain date, with no option to disable. Microsoft schedules default protection far in advance to give customers time to prepare. Customers can't opt out if Microsoft schedules protection by default. 
- Protection can be **Microsoft managed**, which means Microsoft Entra ID can enable or disable protection based on the current security threat landscape. Customers can choose whether to allow Microsoft to manage the protection. They can change from **Microsoft managed** to explicitly **Enabled** or **Disabled** at any time. 

> [!NOTE]
> Only a critical security feature will have protection enabled by default.

<a name='default-protection-enabled-by-azure-ad'></a>

## Default protection enabled by Microsoft Entra ID

Number matching is a good example of protection for an authentication method that is currently optional for push notifications in Microsoft Authenticator in all tenants. Customers could choose to enable number matching for push notifications in Microsoft Authenticator for users and groups, or they could leave it disabled. Number matching is already the default behavior for passwordless notifications in Microsoft Authenticator, and users can't opt out.

As MFA fatigue attacks rise, number matching is critical to sign-in security. As a result, Microsoft will change the default behavior for push notifications in Microsoft Authenticator. 

## Microsoft managed settings

In addition to configuring Authentication methods policy settings to be either **Enabled** or **Disabled**, IT admins can configure some settings in the Authentication methods policy to be **Microsoft managed**. A **Microsoft managed** setting lets Microsoft Entra ID enable or disable the feature automatically. 

The option to let Microsoft Entra ID manage the setting is a convenient way for an organization to allow Microsoft to manage feature defaults. Organizations can improve their security posture by trusting Microsoft to determine when a feature should be enabled. By configuring a setting as **Microsoft managed** (named *default* in Graph APIs), IT admins can trust Microsoft to enable a security feature they haven't explicitly disabled. 

For example, an admin can enable [location and application name](how-to-mfa-additional-context.md) in push notifications to give users more context when they approve MFA requests with Microsoft Authenticator. The additional context can also be explicitly disabled, or set as **Microsoft managed**. Today, the **Microsoft managed** configuration for location and application name is **Disabled**, which effectively disables the option for any environment where an admin chooses to let Microsoft Entra ID manage the setting. 

As the security threat landscape changes over time, Microsoft can change the **Microsoft managed** configuration for location and application name to **Enabled**. For customers who want to rely on Microsoft to improve their security posture, setting security features to **Microsoft managed** is an easy way to stay ahead of security threats. Microsoft determines the best configuration based on the current threat landscape.  

The following table lists each setting that can be set to Microsoft managed and whether that setting is enabled or disabled by default. 

| Setting                                                                                         | Configuration |
|-------------------------------------------------------------------------------------------------|---------------|
| [Registration campaign](how-to-mfa-registration-campaign.md)                                    | Enabled       |
| [Location in Microsoft Authenticator notifications](how-to-mfa-additional-context.md)           | Disabled      |
| [Application name in Microsoft Authenticator notifications](how-to-mfa-additional-context.md)   | Disabled      |
| [System-preferred authentication](concept-system-preferred-authentication.md)                  | Enabled       |
| [Authenticator Lite](how-to-mfa-authenticator-lite.md)                                          | Enabled       |  
| [Report suspicious activity](howto-mfa-mfasettings.md#report-suspicious-activity)               | Disabled      |

### Microsoft managed registration campaign

When the registration campaign is set to **Microsoft managed**, Microsoft determines the optimal campaign configuration for your tenant based on best practices. Microsoft evaluates tenant settings and scoped users to determine the targeted authentication method:

- If the tenant has users scoped into the registration campaign who are in a passkey (FIDO2) profile that allows all types of passkeys (both synced and device-bound), the targeted method changes to passkeys.
- If no users meet that criteria, the targeted method stays as Microsoft Authenticator.

For tenants with passkey (FIDO2) enabled and an active registration campaign set to **Microsoft managed**, the campaign settings are incrementally updated as Microsoft rolls out changes to tenants.

> [!NOTE]
> A registration campaign can only target one authentication method at a time. A tenant can't run campaigns for both Microsoft Authenticator and passkeys simultaneously.

The following Microsoft managed registration campaign settings are updated:

| Setting | Previous value | New value |
|---|---|---|
| **Targeted authentication method** | Microsoft Authenticator | Passkeys (FIDO2) |
| **Days allowed to snooze** | 3 days | 1 day (no longer configurable) |
| **Limited number of snoozes** | Enabled | Disabled (no longer configurable) |
| **User targeting** | Voice call or text message users | All multifactor authentication (MFA) capable users |

After these changes take effect, targeted users receive passkey registration nudges during sign-in after they complete multifactor authentication. If your tenant targets specific AAGUIDs (Authenticator Attestation GUIDs) in the passkey (FIDO2) policy, the targeted authentication method won't update to passkeys under Microsoft managed mode. You can still switch to **Enabled** and configure passkey targeting manually.

> [!NOTE]
> If the Microsoft managed settings don't meet your organization's needs, you can switch the registration campaign state to **Enabled** to configure all settings manually, or **Disabled** to turn off the campaign. For example, if you want passkeys enabled but don't want the registration campaign to target passkeys, switch the state to **Enabled** and target Microsoft Authenticator. For more information, see [Run a registration campaign](how-to-mfa-registration-campaign.md).

As threat vectors change, Microsoft Entra ID can announce default protection for a **Microsoft managed** setting in [release notes](~/fundamentals/whats-new.md) and on commonly read forums like [Tech Community](https://techcommunity.microsoft.com/). 

For more information, see the blog post [It's Time to Hang Up on Phone Transports for Authentication](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/it-s-time-to-hang-up-on-phone-transports-for-authentication/ba-p/1751752) which discusses moving away from using text message and voice calls. Microsoft managed registration campaigns help users set up modern authentication methods, including Microsoft Authenticator and passkeys.

## Related content

- [Authentication methods in Microsoft Entra ID - Microsoft Authenticator](concept-authentication-authenticator-app.md)
- [Enable passkeys (FIDO2)](how-to-enable-passkey-fido2.md)

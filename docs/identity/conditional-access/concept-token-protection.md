---
title: How Token Protection Enhances Conditional Access Policies
description: Protect your resources with token protection in Conditional Access policies. Understand requirements, limitations, and deployment best practices.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 03/04/2026
ms.reviewer: sgrandhi
ms.custom:
  - sfi-image-nochange
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:08/20/2025
  - ai-gen-description
---
# Token Protection in Microsoft Entra Conditional Access

Token Protection is a Conditional Access session control that attempts to reduce token replay attacks by ensuring only device bound sign-in session tokens, like [Primary Refresh Tokens (PRTs)](../devices/concept-primary-refresh-token.md), are accepted by Microsoft Entra ID when applications request access to protected resources.  

When a user registers a supported device with Microsoft Entra, a PRT is issued and cryptographically bound to that device. This binding ensures that even if a threat actor steals the token, it can't be used from another device. With Token Protection enforced, Microsoft Entra validates that only these bound sign-in session tokens are used by supported applications. 

> [!NOTE]
> Use Token Protection as part of a broader defense-in-depth strategy against token theft. For more information, see [Protecting tokens in Microsoft Entra](../devices/protecting-tokens-microsoft-entra-id.md). 

## Platform availability

| Platform | Status |
|----------|--------|
| Windows | Generally Available |
| iOS / iPadOS | Preview |
| macOS | Preview |

> [!NOTE]
> Token Protection currently supports native applications only. Browser-based applications are not supported.

## Supported resources

Token Protection policy can be enforced on the following cloud resources:
- Exchange Online
- SharePoint Online
- Microsoft Teams

On Windows, enforcement is also supported for:
- Azure Virtual Desktop
- Windows 365

:::image type="content" source="media/concept-token-protection/complete-policy-components-session.png" alt-text="Screenshot of a Conditional Access policy that requires token protection as the session control.":::

### Supported devices

**Windows**:
- Windows 10 or newer devices that are Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered. See the known limitations section in the appropriate deployment guide for unsupported device types.  
- Windows Server 2019 or newer that are hybrid Microsoft Entra joined.
- For detailed steps on how to register your device, see [Register your personal device on your work or school network](https://support.microsoft.com/account-billing/register-your-personal-device-on-your-work-or-school-network-8803dd61-a613-45e3-ae6c-bd1ab25bf8a8).

**Apple (Preview)**:
- macOS 14.0 or later. Requires the Microsoft Enterprise single sign-on (SSO) plug-in. Alternatively, you can also use Platform SSO. Only MDM-managed devices are supported.
- iOS / iPadOS 16.0 or later. Requires the Microsoft Enterprise SSO plug-in. Only MDM-managed devices are supported.
- For detailed steps on how to setup, see [Enabling Microsoft Enterprise SSO plug-in](../../identity-platform/apple-sso-plugin.md) and configuring [Platform SSO for macOS](/intune/intune-service/configuration/platform-sso-macos).

## Deployment

To minimize the likelihood of user disruption due to app or device incompatibility, follow these recommendations: 

- Start with a pilot group of users and expand over time. 
- Create a Conditional Access policy in [report-only mode](concept-conditional-access-report-only.md) before enforcing token protection. 
- Capture both interactive and non-interactive sign-in logs. 
- Analyze these logs long enough to cover normal application use.
- Add known, reliable users to an enforcement policy. 

This process helps assess your users' client and app compatibility for token protection enforcement. 

### Deployment guides

Select the guide for your target platform:

- **Windows**: [Token Protection deployment guide - Windows](deployment-guide-token-protection-windows.md)
- **iOS, iPadOS, and macOS**: [Token Protection deployment guide - Apple](deployment-guide-token-protection-apple.md)

## Related content 

[What is a Primary Refresh Token?](../devices/concept-primary-refresh-token.md)
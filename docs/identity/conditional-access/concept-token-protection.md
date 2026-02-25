---
title: How Token Protection Enhances Conditional Access Policies
description: Protect your resources with token protection in Conditional Access policies. Understand requirements, limitations, and deployment best practices.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 02/24/2026
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

When a user registers a Windows 10 or later device with Microsoft Entra, a PRT is issued and cryptographically bound to that device. This binding ensures that even if a threat actor steals a token, it can't be used from another device. With Token Protection enforced, Microsoft Entra validates that only these bound sign-in session tokens are used by supported applications. 

> [!NOTE]
> Use Token Protection as part of a broader defense-in-depth strategy against token theft. For more information, see [Protecting tokens in Microsoft Entra](../devices/protecting-tokens-microsoft-entra-id.md). 

## Requirements and availability

The following devices, platforms, and applications support accessing resources where a token protection Conditional Access policy is applied.

### Platform availability

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
- Windows 10 or newer devices that are Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered. See the [known limitations section](#known-limitations) for unsupported device types.  
- Windows Server 2019 or newer that are hybrid Microsoft Entra joined.
- For detailed steps on how to register your device, see [Register your personal device on your work or school network](https://support.microsoft.com/account-billing/register-your-personal-device-on-your-work-or-school-network-8803dd61-a613-45e3-ae6c-bd1ab25bf8a8).

**Apple (Preview)**:
- macOS 11.0 or later. Requires the Microsoft Enterprise SSO plug-in. You can also use Platform SSO. Only MDM-managed devices are supported.
- iOS / iPadOS 14.0 or later. Requires the Microsoft Enterprise SSO plug-in. Only MDM-managed devices are supported.
- For detailed steps on how to setup, see [Enabling Microsoft Enterprise SSO plug-in](../../identity-platform/apple-sso-plugin.md) and configuring [Platform SSO for macOS](/intune/intune-service/configuration/platform-sso-macos).

## Deployment

For users, the deployment of a Conditional Access policy to enforce token protection should be invisible when using compatible client platforms on registered devices and compatible applications.

To minimize the likelihood of user disruption due to app or device incompatibility, follow these recommendations: 

- Start with a pilot group of users and expand over time. 
- Create a Conditional Access policy in [report-only mode](concept-conditional-access-report-only.md) before enforcing token protection. 
- Capture both interactive and non-interactive sign-in logs. 
- Analyze these logs long enough to cover normal application use.
- Add known, reliable users to an enforcement policy. 

This process helps assess your users' client and app compatibility for token protection enforcement. 

Select the guide for your target platform:

- **Windows**: [Token Protection deployment guide - Windows](deployment-guide-token-protection-windows.md)
- **iOS, iPadOS, and macOS**: [Token Protection deployment guide - Apple](deployment-guide-token-protection-apple.md)

### Known limitations
<!--- Should move to deployment guide - but make sure nothing is lost-->
- Office perpetual clients aren't supported.
- The following applications don't support signing in using protected token flows and users are blocked when accessing Exchange and SharePoint: 
   - PowerShell modules accessing SharePoint
   - PowerQuery extension for Excel
   - Extensions to Visual Studio Code which access Exchange or SharePoint 
- The following Windows client devices aren't supported: 
   - Surface Hub 
   - Windows-based Microsoft Teams Rooms (MTR) systems 
- [External users](/entra/external-id/what-is-b2b) who meet the token protection device registration requirements in their home tenant are supported. However, users who don't meet these requirements see an unclear error message with no indication of the root cause.
- Devices registered with Microsoft Entra ID using the following methods are unsupported:
   - Microsoft Entra joined [Azure Virtual Desktop session hosts](/azure/virtual-desktop/azure-ad-joined-session-hosts).
   - Windows devices deployed using [bulk enrollment](/mem/intune-service/enrollment/windows-bulk-enroll). 
   - [Cloud PCs deployed by Windows 365](/windows-365/enterprise/identity-authentication#device-join-types) that are Microsoft Entra joined. 
   - Power Automate hosted machine groups that are [Microsoft Entra joined](/power-automate/desktop-flows/hosted-machine-groups#general-network-requirements). 
   - Windows Autopilot devices deployed using [self-deploying mode](/autopilot/self-deploying). 
   - Windows virtual machines deployed in Azure using the virtual machine (VM) extension that are enabled for [Microsoft Entra ID authentication](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows).

To identify the impacted devices due to unsupported registration types listed previously, inspect the `tokenProtectionStatusDetails` attribute in the sign-in logs. Token requests that are blocked due to an unsupported device registration type, can be identified with a `signInSessionStatusCode` value of 1003. 

To prevent disruption during onboarding, modify the token protection Conditional Access policy by adding a device filter condition that excludes devices in the previously described deployment category. For example, to exclude:

- Cloud PCs that are Microsoft Entra joined, you can use `systemLabels -eq "CloudPC" and trustType -eq "AzureAD"`. 
- Azure Virtual Desktops that are Microsoft Entra joined, you can use `systemLabels -eq "AzureVirtualDesktop" and trustType -eq "AzureAD"`. 
- Power Automate hosted machine groups that are Microsoft Entra joined, you can use `systemLabels -eq "MicrosoftPowerAutomate" and trustType -eq "AzureAD"`.
- Windows Autopilot devices deployed using self-deploying mode, you can use enrollmentProfileName property. As an example, if you have created an enrollment profile in Intune for your Autopilot self-deployment mode devices as "Autopilot self-deployment profile", you can use `enrollmentProfileName -eq "Autopilot self-deployment profile".
- Windows virtual machines in Azure that are Microsoft Entra joined, you can use `profileType -eq "SecureVM" and trustType -eq "AzureAD"`. 

## Related content 

[What is a Primary Refresh Token?](../devices/concept-primary-refresh-token.md)

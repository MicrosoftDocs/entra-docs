---
title: Token Protection Deployment Guide - Windows
description: Deploy Token Protection with Microsoft Entra Conditional Access for Windows
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 02/24/2026
ms.reviewer: sgrandhi
---
# Token Protection Deployment Guide - Windows

This guide covers the steps required to deploy and enforce Token Protection for sign-in session tokens on Windows platform.

Before using this deployment guide, review [Token Protection in Microsoft Entra Conditional Access](concept-token-protection.md) for an overview of the feature and supported platforms.

## Prerequisites

[!INCLUDE [Microsoft Entra ID P1 license](~/includes/entra-p1-license.md)]

## Supported applications and resources

Before enforcing the policy, ensure users are running supported and up-to-date client versions. Older or out-of-support versions may not be compatible and can be blocked.

### Applications

Token Protection can be applied to the following applications:

- Microsoft Teams
- Word, Excel, PowerPoint
- OneNote
- OneDrive
- Power BI desktop
- Exchange PowerShell module
- Microsoft Graph PowerShell with [EnableLoginByWAM](/powershell/module/microsoft.graph.authentication/set-mggraphoption#example-1-set-web-account-manager-support) option
- Windows App
- Visual Studio when using the ‘Windows authentication broker’ Sign-in option
- Microsoft Edge
- Microsoft To Do
- Outlook 
- Microsoft Loop
- PowerQuery extension for Excel (only available for users on [Current Channel](/microsoft-365-apps/updates/overview-update-channels#current-channel-overview))

### Resources

Token Protection on Apple platforms can be used to protect the following resources:

- Exchange Online
- SharePoint Online
- Microsoft Teams
- Azure Virtual Desktop
- Windows 365

### Known limitations

- Office perpetual clients aren't supported.
- The following applications don't support signing in using protected token flows and users are blocked when accessing Exchange and SharePoint:
   - PowerShell modules accessing SharePoint
   - PowerQuery extension for Excel for users not in Current Channel updates
   - Extensions to Visual Studio Code which access Exchange or SharePoint
- The following Windows client devices aren't supported:
   - Surface Hub
   - Windows-based Microsoft Teams Rooms (MTR) systems
- `External users who meet the token protection device registration requirements in their home tenant are supported. However, users who don't meet these requirements see an unclear error message with no indication of the root cause.
- Devices registered with Microsoft Entra ID using the following methods are unsupported:
   - Microsoft Entra joined Azure Virtual Desktop session hosts.
   - Windows devices deployed using bulk enrollment.
   - Cloud PCs deployed by Windows 365 that are Microsoft Entra joined.
   - Power Automate hosted machine groups that are Microsoft Entra joined.
   - Windows Autopilot devices deployed using self-deploying mode.
   - Windows virtual machines deployed in Azure using the virtual machine (VM) extension that are enabled for Microsoft Entra ID authentication.

To identify the impacted devices due to unsupported registration types listed previously, inspect the tokenProtectionStatusDetails attribute in the sign-in logs. Token requests that are blocked due to an unsupported device registration type, can be identified with a signInSessionStatusCode value of 1003.

To prevent disruption during onboarding, modify the token protection Conditional Access policy by adding a device filter condition that excludes devices in the previously described deployment category. For example, to exclude:
- Cloud PCs that are Microsoft Entra joined, you can use systemLabels -eq "CloudPC" and trustType -eq "AzureAD".
- Azure Virtual Desktops that are Microsoft Entra joined, you can use systemLabels -eq "AzureVirtualDesktop" and trustType -eq "AzureAD".
- Power Automate hosted machine groups that are Microsoft Entra joined, you can use systemLabels -eq "MicrosoftPowerAutomate" and trustType -eq "AzureAD".
- Windows Autopilot devices deployed using self-deploying mode, you can use enrollmentProfileName property. As an example, if you have created an enrollment profile in Intune for your Autopilot self-deployment mode devices as "Autopilot self-deployment profile", you can use `enrollmentProfileName -eq "Autopilot self-deployment profile".
- Windows virtual machines in Azure that are Microsoft Entra joined, you can use profileType -eq "SecureVM" and trustType -eq "AzureAD".
Deployment

## How to enable Token Protection on Windows

For users, the deployment of a Conditional Access policy to enforce token protection should be invisible when using compatible client platforms on registered devices and compatible applications.
To minimize the likelihood of user disruption due to app or device incompatibility, follow these recommendations:
- `Start with a pilot group of users and expand over time.
- Create a Conditional Access policy in report-only mode before enforcing token protection.
- Capture both interactive and non-interactive sign-in logs.
- Analyze these logs long enough to cover normal application use.
- Add known, reliable users to an enforcement policy.

This process helps assess your users’ client and app compatibility for token protection enforcement.

### Create a Conditional Access policy

Users who perform specialized roles like those described in [Privileged access security levels](/security/privileged-access-workstations/privileged-access-security-levels#specialized) are possible targets for this functionality. We recommend piloting with a small subset to begin. Before enforcing the policy, deploy it in report-only mode to assess impact and identify non-compliant sign-in sessions.

The following steps help you create a Conditional Access policy to require token protection for Exchange Online and SharePoint Online on Windows devices.

1.	Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1.	Browse to **Protection** > **Conditional Access** > **Policies**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users, agents, or workload identities**.
   1. Under **Include**, select the users or groups to target.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**
   1. Under **Select**, select the following applications:
       1. Office 365 Exchange Online
       1. Office 365 SharePoint Online

    > [!WARNING]
    > Your Conditional Access policy should only be configured for these applications. Selecting the **Office 365** application group might result in unintended failures. This change is an exception to the general rule that the **Office 365** application group should be selected in a Conditional Access policy. 

    1. Choose **Select**.
1. Under **Conditions**:
    1. Under **Device platforms**:
       1. Set **Configure** to **Yes**.
       1. **Include** > **Select device platforms** > **iOS** and **macOS**.
       1. Select **Done**.
    1. Under **Client apps**:
       1. Set **Configure** to **Yes**.

          > [!WARNING] 
          > Not configuring the **Client Apps** condition, or leaving **Browser** selected might cause applications that use MSAL.js, such as Teams Web to be blocked.

       1. Under Modern authentication clients, only select **Mobile apps and desktop clients**. Leave other items unchecked.
       1. Select **Done**.
1. Under **Access controls** > **Session**, select **Require token protection for sign-in sessions** and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.
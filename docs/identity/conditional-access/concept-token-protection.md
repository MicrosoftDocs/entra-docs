---
title: Microsoft Entra Conditional Access token protection explained
description: Learn how to secure your environment with token protection in Microsoft Entra Conditional Access policies.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 05/27/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: sgrandhi
ms.custom: sfi-image-nochange
---
# Microsoft Entra Conditional Access: Token protection (Preview)

Token protection (sometimes referred to as token binding in the industry) attempts to reduce attacks using token theft by ensuring a token is usable only from the intended device. When an attacker is able to steal a token, by hijacking or replay, they can impersonate their victim until the token expires or is revoked. Token theft is thought to be a relatively rare event, but the damage from it can be significant. 

Token protection creates a cryptographically secure tie between the token and the device (client secret) it's issued to. Without the client secret, the bound token is useless. When a user registers a Windows 10 or newer device in Microsoft Entra ID, their primary identity is [bound to the device](~/identity/devices/concept-primary-refresh-token.md#how-is-the-prt-protected). What this means: A policy can ensure that only bound sign-in session (or refresh) tokens, otherwise known as Primary Refresh Tokens (PRTs) are used by applications when requesting access to a resource.

> [!IMPORTANT]
> Token protection is currently in public preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all). With this preview, we're giving you the ability to create a Conditional Access policy to require token protection for sign-in tokens (refresh tokens) for specific services. We support token protection for sign-in tokens in Conditional Access for desktop applications accessing Exchange Online and SharePoint Online on Windows devices.

> [!IMPORTANT]
> The following changes have been made to Token Protection since the initial public preview release:
>
> * **Sign In logs output:** The value of the string used in **enforcedSessionControls** and **sessionControlsNotSatisfied** changed from **Binding** to **SignInTokenProtection** in late June 2023. Queries on Sign In Log data should be updated to reflect this change.
> * Devices that are joined to Microsoft Entra using certain methods are no longer supported. See the [known limitations section](#known-limitations) for a complete list.  
> * Error code change: The Token protection Conditional Access policy error code is changing from 53003 to 530084 to better identify errors related to token protection.
> * Token protection now supports the Windows App, extending protection to Windows 365 and Azure Virtual Desktop.

:::image type="content" source="media/concept-token-protection/complete-policy-components-session.png" alt-text="Screenshot of a Conditional Access policy requiring token protection as the session control.":::

## Requirements

[!INCLUDE [Microsoft Entra ID P1 license](~/includes/entra-p1-license.md)]

The following devices and applications support accessing resources on which a token protection Conditional Access policy is applied:

### Supported devices: 

- Windows 10 or newer devices that are Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered. See the [known limitations section](#known-limitations) for unsupported device types.  
- Windows Server 2019 or newer that are hybrid Microsoft Entra joined.

### Supported applications: 

- OneDrive sync client version 22.217 or newer 
- Teams native client version 1.6.00.1331 or newer 
- Power BI desktop version 2.117.841.0 (May 2023) or newer 
- [Exchange PowerShell module version 3.7.0 or newer](https://www.powershellgallery.com/packages/ExchangeOnlineManagement/3.7.0)
- Microsoft Graph PowerShell version 2.0.0 or newer with [EnableLoginByWAM option](/powershell/module/microsoft.graph.authentication/set-mggraphoption#example-1-set-web-account-manager-support)
- Visual Studio 2022 or newer when using the 'Windows authentication broker' Sign-in option 
- Windows App version 2.0.379.0 or newer

### Known limitations

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
- New [Microsoft Entra registered devices](../devices/concept-device-registration.md) on Windows versions before 24H2 might be blocked if users don't perform a fresh sign-in during registration. If blocked, users must re-register the device.

To identify the impacted devices due to unsupported registration types listed previously, inspect `tokenProtectionStatusDetails` attribute in the Sign-in logs. Token requests that are blocked due to an unsupported device registration type, can be identified with a `signInSessionStatusCode` value of 1003. 

To prevent any disruption for new onboarding, you can modify the token protection Conditional Access policy by adding a device filter condition that excludes any devices that fall in the previously described deployment category. For example, to exclude:

- Cloud PCs that are Microsoft Entra joined, you can use `systemLabels -eq "CloudPC" and trustType -eq "AzureAD"`. 
- Azure Virtual Desktops that are Microsoft Entra joined, you can use `systemLabels -eq "AzureVirtualDesktop" and trustType -eq "AzureAD"`. 
- Power Automate hosted machine groups that are Microsoft Entra joined, you can use `systemLabels -eq "MicrosoftPowerAutomate" and trustType -eq "AzureAD"`.
- Windows Autopilot devices deployed using self-deploying mode, you can use enrollmentProfileName property. As an example, if you have created an enrollment profile in Intune for your Autopilot self-deployment mode devices as "Autopilot self-deployment profile", you can use `enrollmentProfileName -eq "Autopilot self-deployment profile".
- Windows virtual machines in Azure that are Microsoft Entra joined, you can use `profileType -eq "SecureVM" and trustType -eq "AzureAD"`. 

## Deployment

For users, the deployment of a Conditional Access policy to enforce token protection should be invisible when using compatible client platforms on registered devices and compatible applications.

To minimize the likelihood of user disruption due to app or device incompatibility, we highly recommend: 

- Start with a pilot group of users, and expand over time. 
- Create a Conditional Access policy in [report-only mode](concept-conditional-access-report-only.md) before moving to enforcement of token protection. 
- Capture both Interactive and Non-interactive sign in logs. 
- Analyze these logs for long enough to cover normal application use.
- Add known good users to an enforcement policy. 

This process helps to assess your users’ client and app compatibility for token protection enforcement. 

### Create a Conditional Access policy

Users who perform specialized roles like those described in [Privileged access security levels](/security/privileged-access-workstations/privileged-access-security-levels#specialized) are possible targets for this functionality. We recommend piloting with a small subset to begin. 

The steps that follow help create a Conditional Access policy to require token protection for Exchange Online and SharePoint Online on Windows devices.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select the users or groups who are testing this policy.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**
   1. Under **Select**, select the following applications supported by the preview:
       1. Office 365 Exchange Online
       1. Office 365 SharePoint Online
       1. If you deployed Windows App in your environment, include:       
          1. Azure Virtual Desktop
          1. Windows 365
          1. Windows Cloud Login
       
       > [!WARNING]
       > Your Conditional Access policy should only be configured for these applications. Selecting the **Office 365** application group might result in unintended failures. This change is an exception to the general rule that the **Office 365** application group should be selected in a Conditional Access policy. 

    1. Choose **Select**.
1. Under **Conditions**:
    1. Under **Device platforms**:
       1. Set **Configure** to **Yes**.
       1. **Include** > **Select device platforms** > **Windows**.
       1. Select **Done**.
    1. Under **Client apps**:
       1. Set **Configure** to **Yes**.

          > [!WARNING] 
          > Not configuring the **Client Apps** condition, or leaving **Browser** selected might cause applications that use MSAL.js, such as Teams Web to be blocked.

       1. Under Modern authentication clients, only select **Mobile apps and desktop clients**. Leave other items unchecked.
       1. Select **Done**.
1. Under **Access controls** > **Session**, select **Require token protection for sign-in sessions** and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!TIP]
> Since Conditional Access policies requiring token protection are currently only available for Windows devices, it's necessary to secure your environment against potential policy bypass when an attacker might appear to come from a different platform. 
> 
> In addition, you should configure the following policies: 
> 
> - [Block access from unknown platforms](policy-all-users-device-unknown-unsupported.md)
> - [Require device compliance for all known platforms](policy-all-users-device-compliance.md)

### Capture logs and analyze

Monitor Conditional Access enforcement of token protection before and after enforcement using features like [Policy impact (Preview)](concept-conditional-access-report-only.md#policy-impact-preview), [Sign-in logs](#sign-in-logs), or [Log Analytics](#log-analytics).

#### Sign-in logs 

Use Microsoft Entra sign-in log to verify the outcome of a token protection enforcement policy in report only mode or in enabled mode. 

:::image type="content" source="media/concept-token-protection/sign-in-log-sample.png" alt-text="Screenshot showing an example of a policy not being satisfied." lightbox="media/concept-token-protection/sign-in-log-sample.png":::

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Select a specific request to determine if the policy is applied or not.
1. Go to the **Conditional Access** or **Report-Only** pane depending on its state and select the name of your policy requiring token protection.
1. Under **Session Controls** check to see if the policy requirements were satisfied or not.
1. To find more details about the binding state of the request, select the pane **Basic Info** and see the field **Token Protection - Sign In Session**. Possible values are: 
   1. Bound: the request was using bound protocols. Some sign-ins might include multiple requests, and all requests must be bound to satisfy the token protection policy. Even if an individual request appears to be bound, it doesn't ensure compliance with the policy if other requests are unbound. To see all requests for a sign-in, you can filter all requests for a specific user or look by corelationid.
   1. Unbound: the request wasn't using bound protocols. Possible `statusCodes` when request is unbound are:
      1. 1002: The request is unbound due to the lack of Microsoft Entra ID device state. 
      1. 1003: The request is unbound because the Microsoft Entra ID device state doesn't satisfy Conditional Access policy requirements for token protection. This error could be due to an unsupported device registration type, or the device wasn't registered using fresh sign-in credentials. 
      1. 1005: The request is unbound for other unspecified reasons. 
      1. 1006: The request is unbound because the OS version is unsupported. 
      1. 1008: The request is unbound because the client isn't integrated with the platform broker, such as Windows Account Manager (WAM). 

:::image type="content" source="media/concept-token-protection/sign-in-log-sample-unbound-status-code-1002.png" alt-text="Screenshot showing a sample sign-in with the Token Protection - Sign In Session attribute highlighted. " lightbox="media/concept-token-protection/sign-in-log-sample-unbound-status-code-1002.png":::

#### Log Analytics

You can also use [Log Analytics](~/identity/monitoring-health/tutorial-configure-log-analytics-workspace.md) to query the sign-in logs (interactive and non-interactive) for blocked requests due to token protection enforcement failure.

Here's a sample Log Analytics query searching the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by **Application**. These queries are only samples and are subject to change.

> [!NOTE]
> **Sign In logs output:** The value of the string used in "enforcedSessionControls" and "sessionControlsNotSatisfied" changed from "Binding" to "SignInTokenProtection" in late June 2023. Queries on Sign In Log data should be updated to reflect this change. The examples cover both values to include historical data.

```kusto
//Per Apps query 
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs ) 
//SigninLogs 
AADNonInteractiveUserSignInLogs 
// Adjust the time range below 
| where TimeGenerated > ago(7d) 
| project Id,ConditionalAccessPolicies, Status,UserPrincipalName, AppDisplayName, ResourceDisplayName 
| where ConditionalAccessPolicies != "[]" 
| where ResourceDisplayName == "Office 365 Exchange Online" or ResourceDisplayName =="Office 365 SharePoint Online" or ResourceDisplayName =="Azure Virtual Desktop" or ResourceDisplayName =="Windows 365" or ResourceDisplayName =="Windows Cloud Login"
| where ResourceDisplayName == "Office 365 Exchange Online" or ResourceDisplayName =="Office 365 SharePoint Online" 
//Add userPrincipalName if you want to filter  
// | where UserPrincipalName =="<user_principal_Name>" 
| mv-expand todynamic(ConditionalAccessPolicies) 
| where ConditionalAccessPolicies ["enforcedSessionControls"] contains '["Binding"]' or ConditionalAccessPolicies ["enforcedSessionControls"] contains '["SignInTokenProtection"]' 
| where ConditionalAccessPolicies.result !="reportOnlyNotApplied" and ConditionalAccessPolicies.result !="notApplied" 
| extend SessionNotSatisfyResult = ConditionalAccessPolicies["sessionControlsNotSatisfied"] 
| extend Result = case (SessionNotSatisfyResult contains 'SignInTokenProtection' or SessionNotSatisfyResult contains 'SignInTokenProtection', 'Block','Allow')
| summarize by Id,UserPrincipalName, AppDisplayName, Result 
| summarize Requests = count(), Users = dcount(UserPrincipalName), Block = countif(Result == "Block"), Allow = countif(Result == "Allow"), BlockedUsers = dcountif(UserPrincipalName, Result == "Block") by AppDisplayName 
| extend PctAllowed = round(100.0 * Allow/(Allow+Block), 2) 
| sort by Requests desc 
```

The result of the previous query should be similar to the following screenshot:

:::image type="content" source="media/concept-token-protection/log-analytics-results.png" alt-text="Screenshot showing example results of a Log Analytics query looking for token protection policies" lightbox="media/concept-token-protection/log-analytics-results.png":::

The following query example looks at the non-interactive sign-in log for the last seven days, highlighting **Blocked** versus **Allowed** requests by **User**. 
 
```kusto
//Per users query 
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs ) 
//SigninLogs 
AADNonInteractiveUserSignInLogs 
// Adjust the time range below 
| where TimeGenerated > ago(7d) 
| project Id,ConditionalAccessPolicies, UserPrincipalName, AppDisplayName, ResourceDisplayName 
| where ConditionalAccessPolicies != "[]" 
| where ResourceDisplayName == "Office 365 Exchange Online" or ResourceDisplayName =="Office 365 SharePoint Online" or ResourceDisplayName =="Azure Virtual Desktop" or ResourceDisplayName =="Windows 365" or ResourceDisplayName =="Windows Cloud Login"
| where ResourceDisplayName == "Office 365 Exchange Online" or ResourceDisplayName =="Office 365 SharePoint Online" 
//Add userPrincipalName if you want to filter  
// | where UserPrincipalName =="<user_principal_Name>" 
| mv-expand todynamic(ConditionalAccessPolicies) 
| where ConditionalAccessPolicies ["enforcedSessionControls"] contains '["Binding"]' or ConditionalAccessPolicies ["enforcedSessionControls"] contains '["SignInTokenProtection"]'
| where ConditionalAccessPolicies.result !="reportOnlyNotApplied" and ConditionalAccessPolicies.result !="notApplied" 
| extend SessionNotSatisfyResult = ConditionalAccessPolicies.sessionControlsNotSatisfied 
| extend Result = case (SessionNotSatisfyResult contains 'SignInTokenProtection' or SessionNotSatisfyResult contains 'SignInTokenProtection', 'Block','Allow')
| summarize by Id, UserPrincipalName, AppDisplayName, ResourceDisplayName,Result  
| summarize Requests = count(),Block = countif(Result == "Block"), Allow = countif(Result == "Allow") by UserPrincipalName, AppDisplayName,ResourceDisplayName 
| extend PctAllowed = round(100.0 * Allow/(Allow+Block), 2) 
| sort by UserPrincipalName asc   
```

The following query example looks at the non-interactive sign-in log for the last seven days, highlighting users that are using devices, where Microsoft Entra ID device state doesn't satisfy Token protection CA policy requirements. 

```kusto
AADNonInteractiveUserSignInLogs 
// Adjust the time range below 
| where TimeGenerated > ago(7d) 
| where TokenProtectionStatusDetails!= "" 
| extend parsedBindingDetails = parse_json(TokenProtectionStatusDetails) 
| extend bindingStatus = tostring(parsedBindingDetails["signInSessionStatus"]) 
| extend bindingStatusCode = tostring(parsedBindingDetails["signInSessionStatusCode"]) 
| where bindingStatusCode == 1003 
| summarize count() by UserPrincipalName 
```

### End user experience

A user that registered or enrolled their device doesn't experience any differences in the sign in experience on a token protection supported application when the token protection requirement is enabled.

A user that hasn't registered or enrolled their device, or when using an unsupported application when the token protection requirement is enabled will see the following screenshot after authenticating.

:::image type="content" source="media/concept-token-protection/token-protection-register-or-enroll-device.png" alt-text="Screenshot of the token protection error message when your device isn't registered or enrolled.":::

A user that isn't using a supported application when the token protection requirement is enabled will see the following screenshot after authenticating.

:::image type="content" source="media/concept-token-protection/token-protection-required-error-message.png" alt-text="Screenshot of the error message when a token protection policy blocks access.":::

## Related content 

[What is a Primary Refresh Token?](../devices/concept-primary-refresh-token.md)

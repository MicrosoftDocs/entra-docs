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
   - Extensions to Visual Studio Code that access Exchange or SharePoint
- The following Windows client devices aren't supported:
   - Surface Hub
   - Windows-based Microsoft Teams Rooms (MTR) systems
- [External users](../../external-id/what-is-b2b.md) who meet the token protection device registration requirements in their home tenant are supported. Users who don't meet these requirements will see an error message with no clear indication of the root cause.
- Devices registered with Microsoft Entra ID using the following methods are not supported:
   - Microsoft Entra joined [Azure Virtual Desktop session hosts](/azure/virtual-desktop/azure-ad-joined-session-hosts).
   - Windows devices deployed using [bulk enrollment](/intune/intune-service/enrollment/windows-bulk-enroll).
   - [Cloud PCs deployed by Windows 365](/windows-365/enterprise/identity-authentication#device-join-types) that are Microsoft Entra joined.
   - [Power Automate hosted machine groups that are Microsoft Entra joined](/power-automate/desktop-flows/hosted-machine-groups#general-network-requirements).
   - Windows Autopilot devices deployed using [self-deploying mode](/autopilot/self-deploying).
   - Windows virtual machines deployed in Azure using the virtual machine (VM) extension that are enabled for [Microsoft Entra ID authentication](../devices/howto-vm-sign-in-azure-ad-windows.md).

To identify the impacted devices due to unsupported registration types listed previously, inspect the `tokenProtectionStatusDetails` attribute in the sign-in logs. Token requests that are blocked due to an unsupported device registration type, can be identified with a `signInSessionStatusCode` value of 1003.

To prevent disruption during onboarding, modify the token protection Conditional Access policy by adding a device filter condition that excludes devices in the previously described deployment category. For example, to exclude:
- For Cloud PCs that are Microsoft Entra joined, you can use systemLabels `-eq "CloudPC"` and `trustType -eq "AzureAD"`.
- For Azure Virtual Desktops that are Microsoft Entra joined, you can use systemLabels `-eq "AzureVirtualDesktop"` and `trustType -eq "AzureAD`".
- Power Automate hosted machine groups that are Microsoft Entra joined, you can use systemLabels -eq `"MicrosoftPowerAutomate"` and `trustType -eq "AzureAD`".
- Windows Autopilot devices deployed using self-deploying mode, you can use `enrollmentProfileName` property. As an example, if you have created an enrollment profile in Intune for your Autopilot self-deployment mode devices as "Autopilot self-deployment profile", you can use ``enrollmentProfileName -eq "Autopilot self-deployment profile"`.
- Windows virtual machines in Azure that are Microsoft Entra joined, you can use profileType `-eq "SecureVM"` and `trustType -eq "AzureAD`".
Deployment

## How to enable Token Protection on Windows

For users, the deployment of a Conditional Access policy to enforce token protection should be invisible when using compatible client platforms on registered devices and compatible applications.

To minimize the likelihood of user disruption due to app or device incompatibility, follow these recommendations:
- Start with a pilot group of users and expand over time.
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
       1. Microsoft Teams Services
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
1. Select **Create** to enable your policy.

### Review readiness with logs and metrics

After the report-only policy is in place and running, you should review the [Policy impact](concept-conditional-access-report-only.md#policy-impact), analyze your [sign-in logs](../monitoring-health/concept-sign-ins.md), and [investigate with Log Analytics](../monitoring-health/howto-analyze-activity-logs-log-analytics.md) to review enforcement readiness.

### Sign-in logs

To view Token Protection related sign-in events in the admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Select the sign-in event you're investigating.
1. Review the **Conditional Access** and **Report-Only** tabs (depending on the policy state) and select your token protection policy.
1. Under **Session Controls** check to see if the policy requirements were satisfied or not.
    :::image type="content" source="media/concept-token-protection/sign-in-log-sample.png" alt-text="Screenshot showing an example of a policy not being satisfied." lightbox="media/concept-token-protection/sign-in-log-sample.png":::
1. Select the **Basic Info** tab and check the **Token Protection - Sign In Session** field for more information.

To filter the sign-in logs you might need to add the **Token Protection – Sign-in session status code** column to your view.

The sign-in logs include a `tokenProtectionStatusDetails` property that indicates whether a request uses a device-bound token.

```http
"tokenProtectionStatusDetails": {
  "signInSessionStatus": "bound | unbound",
  "signInSessionStatusCode": <code>
}
```
#### Status code definitions

| Status Code | Description | Action Required |
|---|---|---|
| 1002 | Unbound - device is not registered with Microsoft Entra ID | User must register device |
| 1003 | Unbound - device not registered with secure credentials (legacy registration) | User must perform one-time registration upgrade |
| 1004 | Unbound - device registration is not hardware-backed | User must perform one-time registration upgrade |
| 1005 | Unbound - unspecified reason | Varies |
| 1006 | Unbound - OS version is not supported | User must upgrade OS |
| 1007 | Unbound - not hardware-backed; signed-in user is not the registered device owner | User must re-register, or registered owner must perform upgrade |
| 1008 | Unbound - client does not use an identity broker | The request is unbound because the client isn't integrated with the platform broker or broker app is not installed on the device. |

To identify requests that are compliant or upgradeable with user action, filter for:

- `signInSessionStatus` == bound, or
- `signInSessionStatus` == unbound with `signInSessionStatusCode` of 1003 or 1004

Sample Microsoft Graph Query (Non-Interactive Sign-Ins):
`GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=(signInEventTypes/any(t: t eq 'nonInteractiveUser') and (tokenProtectionStatusDetails/signInSessionStatusCode eq 1003 or tokenProtectionStatusDetails/signInSessionStatusCode eq 1004 or tokenProtectionStatusDetails/signInSessionStatus eq 'bound'))`

#### Log Analytics

You can also use Log Analytics to query interactive and non-interactive sign-in logs for blocked requests due to Token Protection enforcement failure.

> [!NOTE]
> The value of the string used in `enforcedSessionControls` and `sessionControlsNotSatisfied` changed from `"Binding"` to `"SignInTokenProtection"` in late June 2023. Queries on sign-in log data should be updated to reflect this change. The examples below cover both values to include historical data.

The following sample query searches the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by application. These queries are samples only and are subject to change.

<details>
<summary>Requests by application</summary>

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
</details>

<details>
<summary>Requests by user</summary>

The following query searches the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by user.

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
</details>

<details>
<summary>Devices don't meet policy requirements</summary>

The following query searches the non-interactive sign-in logs for the last seven days to identify users whose devices do not satisfy Token Protection policy requirements and are candidates for a device registration upgrade. This query is particularly useful during the report-only phase. It surfaces users with status codes 1003 and 1004, those who will be prompted for a one-time registration upgrade when the policy is enforced, allowing you to proactively communicate the change or provide guidance ahead of enforcement.

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
</details>

### Enforce the Policy

After reviewing sign-in log data and confirming that your targeted users and devices are ready, move the **Enable policy** toggle from **Report-only** to **On**.

We recommend communicating the change to affected users and your help desk team in advance, particularly noting:
- Users who will be prompted to upgrade their device registration.
- Users of Apple's native Mail and Calendar apps, who will be blocked.

## End User Experience

There are some end user experiences to be aware of when deploying Token Protection.

### Upgrade device registration

Existing Microsoft Entra ID device registrations that were not created using hardware-backed key storage do not meet Token Protection requirements.

Users on devices that were registered to Microsoft Entra ID before Token Protection policy was enforced will be prompted to re-authenticate once the policy is enforced. They will need to complete a one-time device registration upgrade and then sign in again to access resources. These users can be identified by [status codes 1003 and 1004](#status-code-definitions). Because users in this state can self-remediate, they are eligible for policy enforcement.

A user that registered or enrolled their supported device doesn't experience any differences in the sign-in experience on a token protection supported application when the token protection requirement is enabled.

### Sign-in experience

When the Token Protection policy is enabled, users who haven't registered or enrolled their device will see the following screen after authenticating:

:::image type="content" source="media/concept-token-protection/token-protection-register-or-enroll-device.png" alt-text="Screenshot of the token protection error message when your device isn't registered or enrolled.":::

When the Token Protection policy is enabled, users who aren't using a supported application will see the following screen after authenticating:

:::image type="content" source="media/concept-token-protection/token-protection-required-error-message.png" alt-text="Screenshot of the error message when a token protection policy blocks access.":::
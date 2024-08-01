---
title: Token protection in Microsoft Entra Conditional Access
description: Learn how to use token protection in Conditional Access policies.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 06/27/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: paulgarn
---
# Conditional Access: Token protection (preview)

Token protection (sometimes referred to as token binding in the industry) attempts to reduce attacks using token theft by ensuring a token is usable only from the intended device. When an attacker is able to steal a token, by hijacking or replay, they can impersonate their victim until the token expires or is revoked. Token theft is thought to be a relatively rare event, but the damage from it can be significant. 

Token protection creates a cryptographically secure tie between the token and the device (client secret) it's issued to. Without the client secret, the bound token is useless. When a user registers a Windows 10 or newer device in Microsoft Entra ID, their primary identity is [bound to the device](~/identity/devices/concept-primary-refresh-token.md#how-is-the-prt-protected). What this means: A policy can ensure that only bound sign-in session (or refresh) tokens, otherwise known as Primary Refresh Tokens (PRTs) are used by applications when requesting access to a resource.

> [!IMPORTANT]
> Token protection is currently in public preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).
With this preview, we're giving you the ability to create a Conditional Access policy to require token protection for sign-in tokens (refresh tokens) for specific services. We support token protection for sign-in tokens in Conditional Access for desktop applications accessing Exchange Online and SharePoint Online on Windows devices.

> [!IMPORTANT]
> The following changes have been made to Token Protection since the initial public preview release:
> * **Sign In logs output:** The value of the string used in "enforcedSessionControls" and "sessionControlsNotSatisfied" changed from "Binding" to "SignInTokenProtection" in late June 2023. Queries on Sign In Log data should be updated to reflect this change.

> [!NOTE]
> We may interchange sign in tokens and refresh tokens in this content. This preview doesn't currently support access tokens or web cookies.

:::image type="content" source="media/concept-token-protection/complete-policy-components-session.png" alt-text="Screenshot showing a Conditional Access policy requiring token protection as the session control":::

## Requirements

This preview supports the following configurations for access to resources with Token Protection Conditional Access policies applied:

* Windows 10 or newer devices that are Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered.
* OneDrive sync client version 22.217 or later
* Teams native client version 1.6.00.1331 or later 
* Power BI desktop version 2.117.841.0 (May 2023) or later
* Visual Studio 2022 or later when using the 'Windows authentication broker' Sign-in option
* Office Perpetual clients aren't supported

### Known limitations

- External users (Microsoft Entra B2B) aren't supported and shouldn't be included in your Conditional Access policy.
- The following applications don't support signing in using protected token flows and users are blocked when accessing Exchange and SharePoint:
   - PowerShell modules accessing Exchange, SharePoint, or Microsoft Graph scopes that are served by Exchange or SharePoint
   - PowerQuery extension for Excel
   - Extensions to Visual Studio Code which access Exchange or SharePoint
   - The new Teams 2.1 preview client gets blocked after sign out due to a bug. This bug should be fixed in a future service update.
- The following Windows client devices aren't supported:
   - Windows Server 
   - Surface Hub
   - Windows-based Microsoft Teams Rooms (MTR) systems

## Licensing requirements

[!INCLUDE [Active Directory P2 license](~/includes/entra-p2-license.md)]

> [!NOTE]
> Token Protection enforcement is part of Microsoft Entra ID Protection and will be part of the P2 license at general availability. 

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

:::image type="content" source="media/concept-token-protection/exposed-policy-attributes.png" alt-text="Screenshot of a configured Conditional Access policy and its components." lightbox="media/concept-token-protection/exposed-policy-attributes.png":::

The steps that follow help create a Conditional Access policy to require token protection for Exchange Online and SharePoint Online on Windows devices.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select the users or groups who are testing this policy.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Cloud apps** > **Include** > **Select apps**
   1. Under **Select**, select the following applications supported by the preview:
       1. Office 365 Exchange Online
       1. Office 365 SharePoint Online
       
       > [!WARNING]
       > Your Conditional Access policy should only be configured for these applications. Selecting the **Office 365** application group may result in unintended failures. This is an exception to the general rule that the **Office 365** application group should be selected in a Conditional Access policy. 

    1. Choose **Select**.
1. Under **Conditions**:
    1. Under **Device platforms**:
       1. Set **Configure** to **Yes**.
       1. **Include** > **Select device platforms** > **Windows**.
       1. Select **Done**.
    1. Under **Client apps**:
       1. Set **Configure** to **Yes**.
          > [!WARNING] 
          > Not configuring the Client Apps condition, or leaving **Browser** selected may cause applications that use MSAL.js, such as Teams Web to be blocked.
       1. Under Modern authentication clients, only select **Mobile apps and desktop clients**. Leave other items unchecked.
       1. Select **Done**.
1. Under **Access controls** > **Session**, select **Require token protection for sign-in sessions** and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

### Capture logs and analyze

Monitoring Conditional Access enforcement of token protection before and after enforcement.

#### Sign-in logs 

Use Microsoft Entra sign-in log to verify the outcome of a token protection enforcement policy in report only mode or in enabled mode. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Select a specific request to determine if the policy is applied or not.
1. Go to the **Conditional Access** or **Report-Only** pane depending on its state and select the name of your policy requiring token protection.
1. Under **Session Controls** check to see if the policy requirements were satisfied or not.

:::image type="content" source="media/concept-token-protection/sign-in-log-sample.png" alt-text="Screenshot showing an example of a policy not being satisfied." lightbox="media/concept-token-protection/sign-in-log-sample.png":::

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
| where ResourceDisplayName == "Office 365 Exchange Online" or ResourceDisplayName =="Office 365 SharePoint Online" 
//Add userPrinicpalName if you want to filter  
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

## Next steps

- [What is a Primary Refresh Token?](~/identity/devices/concept-primary-refresh-token.md)

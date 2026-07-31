---
title: Token Protection Deployment Guide - Web Applications (Preview)
description: Deploy Token Protection with Microsoft Entra Conditional Access for web applications that access Azure Resource Manager on Windows and macOS.
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 07/31/2026
ms.reviewer: sgrandhi
---
# Token Protection Deployment Guide - Web Applications (Preview)

## Overview

This guide covers the steps required to deploy and enforce Token Protection for sign-in session tokens for web (browser-based) applications that access Azure Resource Manager (ARM). Token Protection for web applications is currently in Preview.

For an overview of Token Protection and supported platforms, see [Token Protection in Microsoft Entra Conditional Access](concept-token-protection.md). Review the overview documentation before using this deployment guide.

Because web applications introduce more client-side requirements than native applications, we strongly recommend that you first deploy and enforce Token Protection for native applications, at least for a pilot group of users, before you try this preview. For more information, see [Token Protection deployment guide - Windows](deployment-guide-token-protection-windows.md) and [Token Protection deployment guide - Apple platforms](deployment-guide-token-protection-apple.md).

> [!NOTE]
> When Token Protection is enforced for a user, they can access web applications that use Azure Resource Manager only from a supported browser. Access from any other browser is blocked.

## Prerequisites

[!INCLUDE [Microsoft Entra ID P1 license](~/includes/entra-p1-license.md)]

## Supported applications, resources, and browsers

### Applications

Token Protection for web applications can be applied to the following applications:

| Application | URL |
|---|---|
| Azure portal | `portal.azure.com` |
| Microsoft Intune admin center | `intune.microsoft.com` |
| Microsoft Entra admin center | `entra.microsoft.com` |
| Microsoft Engage Center | `engagecenter.microsoft.com` |
| Microsoft Engage Hub | `engagehub.microsoft.com` |

> [!WARNING]
> Only the applications in the preceding table are supported. When the policy is enforced, users are blocked from any other web application that accesses Azure Resource Manager.

The following applications access Azure Resource Manager but don't support Token Protection. This list is a partial list and is subject to change:

- Microsoft 365 security and compliance center
- Microsoft AppSource
- Azure Data Factory
- Azure AI Studio
- Azure Synapse Studio
- Microsoft Power BI
- Microsoft Developer Portal
- Azure OpenAI Studio
- Power Platform admin center

### Resources

Token Protection for web applications can be used to protect Azure Resource Manager.

When you create the Conditional Access policy, select the **Windows Azure Service Management API** resource. In sign-in logs, this resource appears as **Azure Resource Manager**, with the resource ID `797f4846-ba00-4fd7-ba43-dac1f8f63013`.

### Platforms and browsers

| Platform | Supported browsers | Device requirements |
|---|---|---|
| Windows 11, build 26100.8246 or 26200.8246 and later | Microsoft Edge, Google Chrome | Microsoft Entra joined, Microsoft Entra hybrid joined, or Microsoft Entra registered<sup>1</sup> |
| macOS | Microsoft Edge, Google Chrome | MDM-managed devices only |

<sup>1</sup> Some device registration types aren't supported. For more information, see the known limitations in the [Token Protection deployment guide - Windows](deployment-guide-token-protection-windows.md).

> [!NOTE]
> Mozilla Firefox and Apple Safari don't support Token Protection. Users on these browsers are blocked when the policy is enforced.

## How to enable Token Protection for Azure Resource Manager

To minimize the likelihood of user disruption due to app, browser, or device incompatibility, follow these recommendations:

- Start with a pilot group of users and expand over time.
- Create a Conditional Access policy in [report-only mode](concept-conditional-access-report-only.md) before you enforce Token Protection.
- Capture both interactive and non-interactive sign-in logs.
- Analyze these logs long enough to cover normal application use.
- Add known, reliable users to an enforcement policy.

The high-level steps to enable Token Protection for web applications are as follows:

1. [Configure end user devices](#step-1-configure-end-user-devices)
1. [Configure the report-only mode policy](#step-2-configure-the-report-only-mode-policy)
1. [Review readiness with logs and metrics](#step-3-review-readiness-with-logs-and-metrics)
1. [Enforce the policy](#step-4-enforce-the-policy)

## Step 1: Configure end user devices

Complete the following steps for *each* platform you're deploying to. These steps must be completed *before* you enable the Conditional Access policy.

### [Windows](#tab/windows)

1. Confirm that devices are running Windows 11, build 26100.8246 or 26200.8246 or later.
1. Enable platform authentication in the browser by setting the following registry value:

   ```ini
   [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\BrowserCore]
   "EnablePlatformAuth"=dword:00000001
   ```

1. Install the **Microsoft Single Sign On** browser extension.
   - **Google Chrome**: Install the extension from the Chrome Web Store.
   - **Microsoft Edge**: Allow extensions from other stores in `edge://extensions`, and then install the extension from the Chrome Web Store.

### [macOS](#tab/macos)

1. Install the Microsoft Company Portal, or deploy it via your MDM solution. Company Portal serves as the authentication broker for Microsoft Entra sign-ins.
1. Enable hardware-backed device registration using one of the following options:
   - Option A: Enable the [Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md).
   - Option B: Configure [Platform SSO for macOS](/intune/intune-service/configuration/platform-sso-macos). Platform SSO uses hardware-backed storage by default and requires no extra flag configuration.
1. Install the **Microsoft Single Sign On** browser extension in Microsoft Edge or Google Chrome.

---

### What to expect after Step 1

After you complete these steps, the authentication broker on the device handles browser authentication, and users receive device-bound tokens and Primary Refresh Tokens (PRTs).

- Allow at least 24 hours after completing Step 1 before you move to Step 2, so that devices pick up the configuration and users transition to device-bound tokens.
- The transition is automatic. Users don't need to take any action.
- Some users might briefly see a **Signing you in...** dialog. No window appears, and no user action is required.

## Step 2: Configure the report-only mode policy

Before you enforce the policy, deploy it in report-only mode to assess the effect and identify noncompliant sign-in sessions.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**, and create a new policy.
1. Give your policy a name. Create a meaningful standard for the names of your policies.
1. Under **Assignments**, select **Users, agents, or workload identities**.
   1. Under **Include**, select the users or groups in your pilot group.
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**.
   1. Under **Select**, select **Windows Azure Service Management API**.
   1. Choose **Select**.
1. Under **Conditions**:
   1. Under **Device platforms**:
      1. Set **Configure** to **Yes**.
      1. **Include** > **Select device platforms** > **Windows** and **macOS**, depending on the platforms you're deploying to.
      1. Select **Done**.
   1. Under **Client apps**:
      1. Set **Configure** to **Yes**.
      1. Under Modern authentication clients, only select **Browser**. Leave other items unchecked.

         > [!WARNING]
         > Don't select **Mobile apps and desktop clients** in this policy. Use the platform-specific deployment guides to protect native applications.

      1. Select **Done**.
1. Under **Access controls** > **Session**, select **Require token protection for sign-in sessions** and select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to enable your policy.

> [!TIP]
> Because Conditional Access policies requiring token protection are currently only available for Windows and Apple devices, it's necessary to secure your environment against potential policy bypass when an attacker might appear to come from a different platform.
>
> In addition, you should configure the following policies:
>
> - [Block access from unknown platforms](policy-all-users-device-unknown-unsupported.md)
> - [Require device compliance for all known platforms](policy-all-users-device-compliance.md)

## Step 3: Review readiness with logs and metrics

After the report-only policy is in place and running, you should review the [Policy impact](concept-conditional-access-report-only.md#policy-impact), analyze your [sign-in logs](../monitoring-health/concept-sign-ins.md), and [investigate with Log Analytics](../monitoring-health/howto-analyze-activity-logs-log-analytics.md) to review enforcement readiness.

### Sign-in logs

To view Token Protection related sign-in events in the admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
   - Add the **Token Protection – Sign-in session status code** column to your view to quickly see related sign-in events.
   - Filter the view to the **Azure Resource Manager** resource and set **Client app** to **Browser**.
1. Select the sign-in event you're investigating.
1. Review the **Conditional Access** and **Report-Only** tabs (depending on the policy state) and select your token protection policy.
1. Under **Session Controls**, check to see if the policy requirements were satisfied or not.
1. Select the **Basic Info** tab and check the **Token Protection - Sign In Session** field for more information.

The sign-in logs include a `tokenProtectionStatusDetails` property that indicates whether a request uses a device-bound token.

```http
"tokenProtectionStatusDetails": {
  "signInSessionStatus": "bound | unbound",
  "signInSessionStatusCode": <code>
}
```

> [!NOTE]
> On macOS, users on devices that were registered to Microsoft Entra ID before the Token Protection policy was enforced are prompted to reauthenticate once the policy is enforced. They need to complete a one-time device registration upgrade and then sign in again to access resources. These users can be identified by **status codes 1003 and 1004**. Because users in this state can self-remediate, they're eligible for policy enforcement.

To identify which users you can apply the policy to, refer to the following status codes.

| Status Code | Description | Action Required |
|---|---|---|
| 1002 | Unbound - Request is unbound due to the lack of Microsoft Entra ID device state | User must register device |
| 1003 | Unbound - Device not registered with secure credentials (legacy registration) | **Windows**: the device uses an unsupported registration type, or wasn't registered with fresh credentials. The user must re-register the device. <br>**macOS**: the user must perform a one-time registration upgrade. |
| 1004 | Unbound - Device registration isn't hardware-backed (macOS only) | User must perform a one-time registration upgrade |
| 1005 | Unbound - Unspecified reason | Varies |
| 1006 | Unbound - OS version isn't supported | User must upgrade OS |
| 1007 | Unbound - Not hardware-backed; signed-in user isn't the registered device owner | User must re-register, or the registered owner must perform the upgrade |
| 1008 | Unbound - Client doesn't use an identity broker | Request is unbound because the client isn't integrated with the platform broker, or the broker app isn't installed on the device |

> [!TIP]
> Status codes **1008** and **1002** are the most common codes during browser onboarding. They usually indicate that the Microsoft Single Sign On browser extension is missing or disabled, that the `EnablePlatformAuth` registry value isn't set, that the user is on an unsupported browser such as Firefox or Safari, or that the application doesn't support Token Protection.

#### Identify self-remediable users (macOS only)

To identify requests that are compliant or upgradeable with user action, filter for:

- `signInSessionStatus` == bound, or
- `signInSessionStatus` == unbound with `signInSessionStatusCode` of 1003 or 1004

Sample Microsoft Graph query (non-interactive sign-ins):

```http
GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=(signInEventTypes/any(t: t eq 'nonInteractiveUser') and resourceDisplayName eq 'Azure Resource Manager' and (tokenProtectionStatusDetails/signInSessionStatusCode eq 1003 or tokenProtectionStatusDetails/signInSessionStatusCode eq 1004 or tokenProtectionStatusDetails/signInSessionStatus eq 'bound'))
```

### Log Analytics

You can also use Log Analytics to query interactive and non-interactive sign-in logs for blocked requests due to Token Protection enforcement failure. These queries are samples only and are subject to change.

**Sample queries**:

The following sample Log Analytics query searches the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by **Application**.

<details>
<summary>Requests by application</summary>

```kusto
// Per-app query
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs)
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, Status, UserPrincipalName, AppDisplayName, ResourceDisplayName, ClientAppUsed, TokenProtectionStatusDetails
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Azure Resource Manager"
| where ClientAppUsed == "Browser"
// Add UserPrincipalName if you want to filter to a specific user
// | where UserPrincipalName == "<user_principal_name>"
| mv-expand todynamic(ConditionalAccessPolicies)
| where ConditionalAccessPolicies["enforcedSessionControls"] contains '["Binding"]'
    or ConditionalAccessPolicies["enforcedSessionControls"] contains '["SignInTokenProtection"]'
| where ConditionalAccessPolicies.result != "reportOnlyNotApplied"
    and ConditionalAccessPolicies.result != "notApplied"
| extend SessionNotSatisfyResult = ConditionalAccessPolicies["sessionControlsNotSatisfied"]
| extend Result = case(
    SessionNotSatisfyResult contains 'SignInTokenProtection'
        or SessionNotSatisfyResult contains 'Binding', 'Block', 'Allow')
| extend parsedBindingDetails = parse_json(TokenProtectionStatusDetails)
| extend bindingStatusCode = tostring(parsedBindingDetails["signInSessionStatusCode"])
| extend IsSelfRemediable = Result == "Block"
    and (bindingStatusCode == "1003" or bindingStatusCode == "1004")
| summarize by Id, UserPrincipalName, AppDisplayName, Result, IsSelfRemediable
| summarize Requests = count(),
    Users = dcount(UserPrincipalName),
    Allow = countif(Result == "Allow"),
    Block = countif(Result == "Block"),
    BlockSelfRemediable = countif(IsSelfRemediable == true),
    BlockedUsers = dcountif(UserPrincipalName, Result == "Block"),
    BlockedUsersSelfRemediable = dcountif(UserPrincipalName, IsSelfRemediable == true)
    by AppDisplayName
| extend PctAllowed = round(100.0 * Allow / (Allow + Block), 2)
| extend PctEnforceable = round(100.0 * (Allow + BlockSelfRemediable) / (Allow + Block), 2)
| project AppDisplayName, Requests, Users, Allow, Block,
    BlockSelfRemediable,
    BlockedUsers, BlockedUsersSelfRemediable,
    PctAllowed, PctEnforceable
| sort by Requests desc
```
</details>

The following query searches the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by **User**.

<details>
<summary>Requests by user</summary>

```kusto
// Per-user query
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs)
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, UserPrincipalName, AppDisplayName, ResourceDisplayName, ClientAppUsed, TokenProtectionStatusDetails
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Azure Resource Manager"
| where ClientAppUsed == "Browser"
// Add UserPrincipalName if you want to filter to a specific user
// | where UserPrincipalName == "<user_principal_name>"
| mv-expand todynamic(ConditionalAccessPolicies)
| where ConditionalAccessPolicies["enforcedSessionControls"] contains '["Binding"]'
    or ConditionalAccessPolicies["enforcedSessionControls"] contains '["SignInTokenProtection"]'
| where ConditionalAccessPolicies.result != "reportOnlyNotApplied"
    and ConditionalAccessPolicies.result != "notApplied"
| extend SessionNotSatisfyResult = ConditionalAccessPolicies.sessionControlsNotSatisfied
| extend Result = case(
    SessionNotSatisfyResult contains 'SignInTokenProtection'
        or SessionNotSatisfyResult contains 'Binding', 'Block', 'Allow')
| extend parsedBindingDetails = parse_json(TokenProtectionStatusDetails)
| extend bindingStatusCode = tostring(parsedBindingDetails["signInSessionStatusCode"])
| extend IsSelfRemediable = Result == "Block"
    and (bindingStatusCode == "1003" or bindingStatusCode == "1004")
| summarize by Id, UserPrincipalName, AppDisplayName, ResourceDisplayName, Result, IsSelfRemediable
| summarize Requests = count(),
    Allow = countif(Result == "Allow"),
    Block = countif(Result == "Block"),
    BlockSelfRemediable = countif(IsSelfRemediable == true)
    by UserPrincipalName, AppDisplayName, ResourceDisplayName
| extend PctAllowed = round(100.0 * Allow / (Allow + Block), 2)
| extend PctEnforceable = round(100.0 * (Allow + BlockSelfRemediable) / (Allow + Block), 2)
| project UserPrincipalName, AppDisplayName, ResourceDisplayName,
    Requests, Allow, Block, BlockSelfRemediable,
    PctAllowed, PctEnforceable
| sort by UserPrincipalName asc
```
</details>

#### Interpret the readiness metrics

- **PctAllowed** is the percentage of requests that already satisfy Token Protection today.
- **PctEnforceable** is the percentage of requests that either satisfy Token Protection today or are blocked for a reason that the user can self-remediate. Use this value to judge enforcement readiness.

A large gap between **PctAllowed** and **PctEnforceable** indicates that many users need a one-time device registration upgrade. Communicate this change before you enforce the policy.

## Step 4: Enforce the policy

After you review sign-in log data and confirm that your targeted users, browsers, and devices are ready, move the **Enable policy** toggle from **Report-only** to **On**.

Communicate the change to affected users and your help desk team in advance, particularly noting:

- Users who are prompted to upgrade their device registration.
- Users who access Azure Resource Manager from an unsupported browser, such as Firefox or Safari, are blocked.
- Users who access Azure Resource Manager from an unsupported web application are blocked.

## Related content

- [Token Protection in Microsoft Entra Conditional Access](concept-token-protection.md)
- [Token Protection deployment guide - Windows](deployment-guide-token-protection-windows.md)
- [Token Protection deployment guide - Apple platforms](deployment-guide-token-protection-apple.md)
- [What is a Primary Refresh Token?](../devices/concept-primary-refresh-token.md)

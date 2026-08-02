# Token Protection for ARM Public Preview Guide

> Classified as Microsoft Confidential
>
> **Author:** Sindhoor Grandhi

---

## Overview

This guide covers the steps required to deploy and enforce Token Protection for sign-in session tokens used by web (browser-based) applications that access Azure Resource Manager (ARM).

For an overview of Token Protection and supported platforms, see [Token Protection in Microsoft Entra Conditional Access](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-token-protection). Review the overview documentation before using this deployment guide.

> **Note:** Token Protection for web applications is currently in **Preview**. Preview features are still in development, and their capabilities may change over time. These features are available before an official release so that customers can get early access and provide feedback.

> **Note:** Since support for web applications is in preview, we recommend that you first deploy Token Protection for native applications, including enforcing the policy for at least a pilot group of users, before you try this preview for web applications. For guidance, see the deployment guides for [Windows](https://learn.microsoft.com/en-us/entra/identity/conditional-access/deployment-guide-token-protection-windows) and [Apple](https://learn.microsoft.com/en-us/entra/identity/conditional-access/deployment-guide-token-protection-apple) devices.

---

## Prerequisites

Using this feature requires Microsoft Entra ID P1 licenses. To find the right license for your requirements, see [Compare generally available features of Microsoft Entra ID](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

---

## Supported Applications, Resources, and Browsers

### Applications

- Azure Portal
- Microsoft Intune Admin Center
- Microsoft Entra Admin Center
- Microsoft Engage Center
- Microsoft Engage Hub

Only the above web applications are supported. Users' **access to other web applications accessing ARM will be blocked** when policy is enforced. Top web applications that access ARM but are **not supported** include (but are not limited to):

- Microsoft 365 Security and Compliance Center
- Microsoft AppSource
- Azure Data Factory
- Azure AI Studio App
- Azure Synapse Studio
- Microsoft Power BI
- Microsoft Developer Portal
- Azure OpenAI Studio
- Power Platform Admin Center

### Supported Resources

- Azure Resource Manager (ARM), configured in Conditional Access as the **Windows Azure Service Management API** resource.

### Supported Platforms and Browsers

| Platform | Supported browsers | Device requirement |
|---|---|---|
| Windows 11 (build 26100.8246 / 26200.8246 or later) | Microsoft Edge, Google Chrome | Entra joined, hybrid joined, or registered<sup>1</sup> |
| macOS | Microsoft Edge, Google Chrome | MDM-managed only |

<sup>1</sup> Some device registration types are not supported. See the list [here](https://learn.microsoft.com/en-us/entra/identity/conditional-access/deployment-guide-token-protection-windows).

---

## How to Enable Token Protection for ARM on Windows and macOS

To minimize the likelihood of user disruption due to app, browser, or device incompatibility, follow these recommendations:

- Start with a pilot group of users and expand over time.
- Create a Conditional Access policy for Token Protection in [report-only mode](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-report-only) before enforcing it.
- Capture both interactive and non-interactive sign-in logs.
- Analyze these logs long enough to cover normal application use. Instructions for analyzing and understanding user impact are described in the following sections.
- Add known, reliable users to a user group and enforce the policy.

This process helps assess your users' readiness for token protection enforcement.

---

### Step 1: Configure End User Devices

Complete the following on each device either manually or via Group Policy or Intune.

#### Windows

- Ensure the device runs **Windows 11 build 26100.8246 / 26200.8246 or later**.
- Enable this preview by setting the following registry value:

  ```
  [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\BrowserCore]
  "EnablePlatformAuth"=dword:00000001
  ```

- Install the Microsoft Single Sign-On browser extension:
  - **Google Chrome:** Install "[Microsoft Single Sign On](https://chromewebstore.google.com/detail/microsoft-single-sign-on/ppnbnpeolgkicgegkbkbjmhlideopiji)" from the Chrome Web Store, select **Add to Chrome → Add extension**, and confirm it appears in the toolbar.
  - **Microsoft Edge:** Go to `edge://extensions`, turn on **Allow extensions from other stores**, install the Microsoft Single Sign On extension, and confirm it's enabled.

#### macOS

- Install the Microsoft Company Portal or deploy it via your MDM solution. Company Portal serves as the authentication broker for Microsoft Entra sign-ins.
- Enable hardware-backed registration using one of the following options:
  - **Option A:** Enable the [Microsoft Enterprise SSO plug-in](https://learn.microsoft.com/en-us/entra/identity-platform/apple-sso-plugin).
  - **Option B:** Configure **Platform SSO for macOS**. Platform SSO uses hardware-backed storage by default and requires no extra flag configuration. For setup instructions, see [Configure Platform SSO for macOS devices in Microsoft Intune](https://learn.microsoft.com/en-us/intune/intune-service/configuration/platform-sso-macos).
- Install the **Microsoft Single Sign-On** browser extension in Microsoft Edge or Google Chrome (as described in the Windows section above).

#### What to Expect After Step 1

Once the device meets the prerequisites and configuration has propagated, authentication requests from supported applications and browsers stop completing entirely inside the browser and are instead handled by the platform authentication broker. This is what allows those applications to use device-bound sign-in session tokens, such as [Primary Refresh Tokens (PRTs)](https://learn.microsoft.com/en-us/entra/identity/devices/concept-primary-refresh-token), and satisfy the Token Protection Conditional Access policy.

Plan for the following:

- **Allow at least 24 hours for the change to take effect.** The switch to broker-based authentication is not immediate after the registry value, extension, or Platform SSO profile is applied. Don't move to Step 2 until this window has passed, or your report-only data will not accurately show readiness.
- **The transition is automatic in most cases.** Users generally take no action; existing browser sessions continue to work while the change propagates.
- **Some users see a brief sign-in dialog.** During the preview, users accessing the Azure portal may briefly see a "Signing you in…" message stating that a new window is opening. **No new window appears and no user action is required**, and sign-in completes on its own. Optionally, communicate this to your pilot group in advance so it isn't reported as a failure.

---

### Step 2: Create the Conditional Access Policy (in Report-Only)

Once you have waited for twenty-four hours after finishing Step 1, you can continue to set a policy in report-only to review enforcement readiness.

1. Sign in to the Microsoft Entra admin center as at least a **Conditional Access Administrator**.
2. Browse to **Entra ID → Conditional Access → Policies**, then select **New policy** and give it a name.
3. Under **Assignments → Users**, include your pilot/test users. Do not include your organization's emergency access or break-glass accounts.
4. Under **Target resources → Resources (formerly cloud apps) → Include → Select resources**, select **Windows Azure Service Management API**.
5. Under **Conditions → Device platforms**, set **Configure** to **Yes** and include **Windows** and/or **macOS**.
6. Under **Conditions → Client apps**, set **Configure** to **Yes** and include **Browser** (make sure not to select "Mobile apps and desktop clients" for this preview).
7. Under **Access controls → Session**, select **Require token protection for sign-in sessions**, then **Select**.
8. Set **Enable policy** to **Report-only** and select **Create**.

> **Tip**
>
> Because Conditional Access policies requiring token protection are currently only available for Windows and Apple devices, it's necessary to secure your environment against potential policy bypass when an attacker might appear to come from a different platform.
>
> In addition, you should configure the following policies:
>
> - [Block access from unknown platforms](https://learn.microsoft.com/en-us/entra/identity/conditional-access/policy-all-users-device-unknown-unsupported)
> - [Require device compliance for all known platforms](https://learn.microsoft.com/en-us/entra/identity/conditional-access/policy-all-users-device-compliance)

---

### Step 3: Review Readiness for Enforcement with Logs and Metrics

After the report-only policy is in place and running, you should review the [Policy impact](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-report-only), analyze your [sign-in logs](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins), and [investigate with Log Analytics](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics) to review enforcement readiness.

#### Sign-in Logs

To view Token Protection related sign-in events in the admin center:

1. Sign in to the **Microsoft Entra admin center** as at least a **Conditional Access Administrator**.
2. Browse to **Entra ID → Monitoring & health → Sign-in logs**.
3. Add the **Token Protection – Sign-in session status code** column to your view to quickly see related sign-in events. Also, filter to the **Azure Resource Manager** resource and set **Client app** to **Browser** to isolate the sign-in requests related to this preview.
4. Select the sign-in event you're investigating.
5. Review the **Conditional Access** and **Report-only** tabs (depending on the policy state) and select your token protection policy.
6. Under **Session controls**, check whether the policy requirements were satisfied.
7. Select the **Basic info** tab and check the **Token Protection - Sign-in Session** field for more information.

The sign-in logs include a `tokenProtectionStatusDetails` property that indicates whether a request uses a device-bound token:

```json
"tokenProtectionStatusDetails": {
  "signInSessionStatus": "bound | unbound",
  "signInSessionStatusCode": <code>
}
```

> **Note (macOS only):** Users on devices that were registered to Microsoft Entra ID before the Token Protection policy was enforced are prompted to re-authenticate once the policy is enforced. They complete a one-time device registration upgrade (achieved via signing in again) to access resources. These users can be identified by **status codes 1003 and 1004**. Because users in this state can self-remediate, **they're eligible for policy enforcement**.

#### Sign-in Session Status Codes

To understand why a request shows as *unbound* or to identify which users you can apply the policy to, refer to the following status codes.

| Status code | Description | Action required |
|---|---|---|
| 1002 | Unbound – request is unbound due to the lack of Microsoft Entra ID device state. | User must register or join the device. |
| 1003 | Unbound – device not registered with secure credentials (legacy registration). | **Windows:** This error could be due to an [unsupported device registration](https://learn.microsoft.com/en-us/entra/identity/conditional-access/deployment-guide-token-protection-windows) type, or the device wasn't registered using fresh sign-in credentials.<br>**macOS:** User performs a one-time device registration upgrade (self-remediable). |
| 1004 (macOS only) | Unbound – device registration isn't hardware-backed. | User performs a one-time device registration upgrade (self-remediable). |
| 1005 | Unbound – unspecified reason. | Varies; investigate with the correlation ID. |
| 1006 | Unbound – OS version isn't supported. | User upgrades the OS (Windows 11 build 26100.8246 / 26200.8246 or later, or a supported macOS version). |
| 1007 | Unbound – not hardware-backed; the signed-in user isn't the registered device owner. | User re-registers, or the registered owner performs the upgrade. |
| 1008 | Unbound – client doesn't use an authentication broker (such as WAM). | The client isn't integrated with the platform broker, or the broker/extension isn't installed. For browsers, install and enable the Microsoft Single Sign-On extension and enable platform authentication. |

> **Tip:** For the browser scenario, **1008** and **1002** are the codes you'll most often see during onboarding. They usually mean the Microsoft Single Sign-On browser extension is missing or disabled, platform authentication isn't enabled (on Windows, the `EnablePlatformAuth` registry value isn't set), an unsupported browser (Firefox/Safari) is in use, or the app does not support token protection.

#### Identifying Self-Remediable Users (macOS only)

On macOS, codes 1003 and 1004 are self-remediable through a one-time device registration upgrade.

To identify requests that are compliant or upgradeable with user action, filter for:

- `signInSessionStatus == bound`, or
- `signInSessionStatus == unbound` with `signInSessionStatusCode` of `1003` or `1004`.

Sample Microsoft Graph query (non-interactive sign-ins):

```http
GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=(
  signInEventTypes/any(t: t eq 'nonInteractiveUser')
  and resourceDisplayName eq 'Azure Resource Manager'
  and (tokenProtectionStatusDetails/signInSessionStatusCode eq 1003
    or tokenProtectionStatusDetails/signInSessionStatusCode eq 1004
    or tokenProtectionStatusDetails/signInSessionStatus eq 'bound'))
```

When Token Protection is enforced for these users, they will be prompted to sign in again and will be able to access resources once they finish authenticating.

---

## Log Analytics

You can also use Log Analytics to query interactive and non-interactive sign-in logs for requests blocked due to Token Protection enforcement failure. These queries are samples only and are subject to change. They filter on the Azure Resource Manager resource and add readiness metrics so you can distinguish hard blocks from self-remediable ones.

### Requests by Application

The following sample query searches the non-interactive sign-in logs for the last seven days, highlighting Blocked versus Allowed requests to ARM by Application, and flags blocks that users can self-remediate. Swap in `SigninLogs` to review interactive browser sign-ins instead.

```kusto
// Select the log to query (SigninLogs or AADNonInteractiveUserSignInLogs)
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, Status, UserPrincipalName, AppDisplayName,
    ResourceDisplayName, TokenProtectionStatusDetails
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Azure Resource Manager"
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
    BlockSelfRemediable, BlockedUsers, BlockedUsersSelfRemediable,
    PctAllowed, PctEnforceable
| sort by Requests desc
```

### Requests by User

The following query looks at the non-interactive sign-in logs for the last seven days, highlighting Blocked versus Allowed requests to ARM by User, with the same self-remediable / enforceable metrics.

```kusto
// Per-user query for the Azure Portal -> ARM web app scenario
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, UserPrincipalName, AppDisplayName,
    ResourceDisplayName, TokenProtectionStatusDetails
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Azure Resource Manager"
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

---

### Step 4: Enforce the Policy

After reviewing sign-in log data and confirming that your targeted users and devices are ready, move the **Enable policy** toggle from **Report-only** to **On**.

---

*Classified as Microsoft Confidential*

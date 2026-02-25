---
title: Token Protection Deployment Guide - Apple Platforms (Preview)
description: Deploy Token Protection with Microsoft Entra Conditional Access for mac OS, iOS, and iPadOS
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 02/24/2026
ms.reviewer: sgrandhi
---
# Token Protection Deployment Guide - Apple Platforms (Preview)
This guide covers the steps required to deploy and enforce Token Protection for sign-in session tokens on Apple platforms (iOS, iPadOS, and macOS). Token Protection on Apple platforms is currently in Preview.

Before using this deployment guide, review [Token Protection in Microsoft Entra Conditional Access](concept-token-protection.md) for an overview of the feature and supported platforms.

> [!IMPORTANT]
> Apple's native Mail and Calendar apps don't support Token Protection. Users relying on these applications will be blocked when the policy is enforced. Communicate this impact to affected users before deployment.

## Supported applications and resources

Before enforcing the policy, ensure users are running supported and up-to-date client versions. Older or out-of-support versions may not be compatible and can be blocked.

### Applications

Token Protection can be applied to the following applications.

| Application | iOS/iPadOS | macOS |
|---|---|---|
| Intune Company Portal | ✅ | ✅ |
| Microsoft 365 Copilot |  | ✅ |
| Microsoft Authenticator | ✅ |  |
| Microsoft Edge | ✅ | ✅ |
| Microsoft Loop | ✅ | ✅ |
| Microsoft OneNote | ✅ | ✅ |
| Microsoft SharePoint | ✅ |  |
| Microsoft Teams | ✅ | ✅ |
| Microsoft To Do | ✅ | ✅ |
| OneDrive | ✅ | ✅ |
| Outlook | ✅ | ✅ |
| Visual Studio Code |  | ✅ |
| Word, Excel, PowerPoint | ✅ | ✅ |

## Supported Resources

Token Protection on Apple platforms can be used to protect the following resources:

- Exchange Online
- SharePoint Online
- Microsoft Teams

## Known Limitations

- Token Protection currently requires the Microsoft Enterprise SSO plug-in, which requires MDM management. *Unmanaged iOS and macOS devices are not supported at this time.* 
- *Apple's native Mail and Calendar apps don't support Token Protection.* Users will be blocked from accessing these apps when the policy is enforced. 
- In report-only mode, requests that do not use hardware-backed device registration appear as non-compliant, even if the user is eligible for an upgrade to hardware-backed device registration. Use sign-in logs and status codes to assess true readiness. See the [Review Readiness Using Report-Only Mode]() section.
- The **Token Protection – Sign-in Session** column in sign-in logs shows all requests without hardware-backed device identity as "Unbound." These logs include requests from users who are eligible to upgrade their registration.
- External users who meet the token protection device registration requirements in their home tenant are supported. Users who don't meet these requirements will see an error message with no clear indication of the root cause.

## How to enable Token Protection on Apple platforms

Unlike Windows, Apple platforms do not use a Trusted Platform Module (TPM). Instead, Microsoft Entra ID uses Apple Secure Enclave to store proof-of-possession keys.

> [!NOTE]
> On macOS devices without Secure Enclave (for example, some older Mac mini models), Microsoft Entra ID falls back to an enhanced version of the Apple Keychain (Data Protection Keychain). 

This difference means that some prerequisite configuration is required before users can register devices in a way that supports Token Protection enforcement.

### Configure hardware-backed device registration

Complete the steps below for *each* platform you are deploying to. These steps must be completed *before* users register their devices. 

> [!NOTE]
> Users who registered devices before these steps were completed will be prompted to upgrade their device registration to hardware-backed when the policy is enforced: see the [Upgrade Existing Device Registrations]() section.

#### [iOS and iPadOS](#tab/ios-and-ipados)

1. Install Microsoft Authenticator from the Apple App Store, or deploy it via your MDM solution. Authenticator serves as the authentication broker for Microsoft Entra sign-ins.
1. Enable hardware-backed registration using the Microsoft Enterprise SSO plug-in for Apple Devices.
1. Set the `use_most_secure_storage` flag.
   - The flag applies only to new device registrations made after the flag is configured.
   - For Intune-enrolled devices, the flag also applies to registrations made through the Intune Company Portal app, even before the device becomes MDM-managed.
   - For all other registrations, the flag takes effect only after the device is MDM-managed and the Microsoft Enterprise SSO plug-in profile is active.

#### [macOS](#tab/macos)

1. Install the Microsoft Company Portal or deploy it via your MDM solution. Company Portal serves as the authentication broker for Microsoft Entra sign-ins.
1. Enable hardware-backed registration using one of the following options:
   - Option A: Enable the **Microsoft Enterprise SSO plug-in** with the `use_most_secure_storage` flag.
   - Option B: Configure **Platform SSO for macOS**. Platform SSO uses hardware-backed storage by default and requires no additional flag configuration. For setup instructions, see [Configure Platform SSO for macOS devices in Microsoft Intune]().

---

### Configure the report-only mode policy

Before enforcing the policy, deploy it in report-only mode to assess impact and identify non-compliant sign-in sessions.

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
// Per-app query
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs)
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, Status, UserPrincipalName, AppDisplayName, ResourceDisplayName
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Office 365 Exchange Online"
    or ResourceDisplayName == "Office 365 SharePoint Online"
    or ResourceDisplayName == "Microsoft Teams Services"
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
| summarize by Id, UserPrincipalName, AppDisplayName, Result
| summarize Requests = count(),
    Users = dcount(UserPrincipalName),
    Block = countif(Result == "Block"),
    Allow = countif(Result == "Allow"),
    BlockedUsers = dcountif(UserPrincipalName, Result == "Block")
    by AppDisplayName
| extend PctAllowed = round(100.0 * Allow / (Allow + Block), 2)
| sort by Requests desc
```
</details>

<details>
<summary>Requests by user</summary>

The following query searches the non-interactive sign-in logs for the last seven days, highlighting **Blocked** versus **Allowed** requests by user.

```kusto
// Per-user query
// Select the log you want to query (SigninLogs or AADNonInteractiveUserSignInLogs)
// SigninLogs
AADNonInteractiveUserSignInLogs
// Adjust the time range below
| where TimeGenerated > ago(7d)
| project Id, ConditionalAccessPolicies, UserPrincipalName, AppDisplayName, ResourceDisplayName
| where ConditionalAccessPolicies != "[]"
| where ResourceDisplayName == "Office 365 Exchange Online"
    or ResourceDisplayName == "Office 365 SharePoint Online"
    or ResourceDisplayName == "Microsoft Teams Services"
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
| summarize by Id, UserPrincipalName, AppDisplayName, ResourceDisplayName, Result
| summarize Requests = count(),
    Block = countif(Result == "Block"),
    Allow = countif(Result == "Allow")
    by UserPrincipalName, AppDisplayName, ResourceDisplayName
| extend PctAllowed = round(100.0 * Allow / (Allow + Block), 2)
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
| where TokenProtectionStatusDetails != ""
| extend parsedBindingDetails = parse_json(TokenProtectionStatusDetails)
| extend bindingStatus = tostring(parsedBindingDetails["signInSessionStatus"])
| extend bindingStatusCode = tostring(parsedBindingDetails["signInSessionStatusCode"])
// Status code 1003: legacy registration — user can self-remediate with a one-time upgrade
// Status code 1004: not hardware-backed — user can self-remediate with a one-time upgrade
| where bindingStatusCode == "1003" or bindingStatusCode == "1004"
| summarize count() by UserPrincipalName
```
</details>

### Enforce the Policy

After reviewing sign-in log data and confirming that your targeted users and devices are ready, move the **Enable policy** toggle from **Report-only** to **On**.

We recommend communicating the change to affected users and your help desk team in advance, particularly noting:
- Users who will be prompted to upgrade their device registration.
- Users of Apple's native Mail and Calendar apps, who will be blocked.

## End User Experience

Users on devices that were registered to Microsoft Entra ID before Token Protection policy was enforced will be prompted to re-authenticate once policy is enforced. They will need to sign in again to access resources. A user that registered or enrolled their supported device doesn't experience any differences in the sign-in experience on a token protection supported application when the token protection requirement is enabled.

A user who hasn't registered or enrolled their device and if the token protection policy is enabled sees the following screenshot after authenticating.

:::image type="content" source="media/concept-token-protection/token-protection-register-or-enroll-device.png" alt-text="Screenshot of the token protection error message when your device isn't registered or enrolled.":::

A user that isn't using a supported application when the token protection policy is enabled will see the following screenshot after authenticating.

:::image type="content" source="media/concept-token-protection/token-protection-required-error-message.png" alt-text="Screenshot of the error message when a token protection policy blocks access.":::

<!--- This felt out of place above. Can link back up to the status codes. DOes this work here? Also, what is the article mentioned?--->
Existing Microsoft Entra ID device registrations that were not created using hardware-backed key storage do not meet Token Protection requirements. When the policy is enforced, affected users will be required to complete a one-time device registration upgrade before accessing protected resources. This self-service process requires the user to re-authenticate to the tenant (see "Upgrading Device Registration Flow" for user experience details). These users can be identified by status codes 1003 and 1004. Because users in this state can self-remediate, they are eligible for policy enforcement.
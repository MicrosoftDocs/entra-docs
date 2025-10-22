---
title: Resilience defaults for Microsoft Entra Conditional Access
description: Discover how to configure resilience defaults in Microsoft Entra to ensure secure access during outages while balancing real-time policy evaluation needs.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: article
ms.date: 09/12/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: 
---

# Conditional Access: Resilience defaults

If the primary authentication service is unavailable, the Microsoft Entra Backup Authentication Service automatically issues access tokens to applications for existing sessions. This functionality significantly improves Microsoft Entra resilience because reauthentications for existing sessions account for more than 90% of authentications to Microsoft Entra ID. The Backup Authentication Service doesn't support new sessions or authentications by guest users.

For authentications protected by Conditional Access, policies are reevaluated before access tokens are issued to determine:

1. Which Conditional Access policies apply?
1. For policies that do apply, are the required controls satisfied?

During an outage, the Backup Authentication Service can't evaluate all conditions in real time to determine whether a Conditional Access policy applies. Conditional Access resilience defaults are a new session control that let admins decide between:

- Whether to block authentications during an outage whenever a policy condition can’t be evaluated in real-time.
- Allow policies to be evaluated using data collected at the beginning of the user’s session.

> [!IMPORTANT]
> Resilience defaults are automatically enabled for all new and existing policies. Microsoft recommends keeping the resilience defaults enabled to reduce the impact of an outage. Admins can disable resilience defaults for individual Conditional Access policies.

## How does it work

During an outage, the Backup Authentication Service reissues access tokens for specific sessions:

| Session description | Access granted |
| --- | --- |
| New session | No |
| Existing session – No Conditional Access policies are configured | Yes |
| Existing session – Conditional Access policies configured and the required controls, like MFA, were previously satisfied | Yes |
| Existing session – Conditional Access policies configured and the required controls, like MFA, weren't previously satisfied | Determined by resilience defaults |

When an existing session expires during a Microsoft Entra outage, the request for a new access token routes to the Backup Authentication Service, and all Conditional Access policies are reevaluated. If there are no Conditional Access policies, or if all the required controls, such as MFA, were satisfied at the beginning of the session, the Backup Authentication Service issues a new access token to extend the session.

If the required controls of a policy weren't previously satisfied, the policy is reevaluated to determine whether access should be granted or denied. Not all conditions can be reevaluated in real time during an outage. These conditions include:

- Group membership
- Role membership
- Sign-in risk
- User risk
- Country/region location (resolving new IP or GPS coordinates)
- Authentication strengths

When active, the Backup Authentication Service doesn't evaluate authentication methods required by [authentication strengths](~/identity/authentication/concept-authentication-strengths.md). If you used a non-phishing-resistant authentication method before an outage, during an outage you aren't prompted for multifactor authentication even if accessing a resource protected by a Conditional Access policy with a phishing-resistant authentication strength.

## Resilience defaults enabled

When resilience defaults are enabled, the Backup Authentication Service uses data collected at the start of the session to evaluate whether the policy applies without real-time data. By default, resilience defaults are enabled for all policies. You can disable the setting for individual policies when real-time policy evaluation is needed to access sensitive applications during an outage.

**Example**: A policy with resilience defaults enabled requires all users assigned a [privileged role](../role-based-access-control/permissions-reference.md) accessing Microsoft Admin portals to do MFA. Before an outage, if a user without an administrator role accesses the Azure portal, the policy doesn't apply, and the user gets access without an MFA prompt. During an outage, the Backup Authentication Service reevaluates the policy to decide whether the user needs an MFA prompt. **Because the Backup Authentication Service can't evaluate role membership in real-time, it uses data collected at the start of the user’s session to decide that the policy still doesn't apply. As a result, the user is granted access without being prompted for MFA.**

## Resilience defaults disabled

When resilience defaults are disabled, the Backup Authentication Service doesn't use data collected at the beginning of the session to evaluate conditions. During an outage, if a policy condition can't be evaluated in real time, access is denied.

**Example**: A policy with resilience defaults disabled requires all users assigned a [privileged role](../role-based-access-control/permissions-reference.md) accessing Microsoft Admin portals to complete MFA. Before an outage, if a user who isn't assigned an administrator role accesses the Azure portal, the policy doesn't apply, and the user is granted access without being prompted for MFA. During an outage, the Backup Authentication Service would reevaluate the policy to determine whether the user should be prompted for MFA. **Because the Backup Authentication Service can't evaluate role membership in real time, it blocks the user from accessing the Azure portal.**

> [!WARNING]
> Disabling resilience defaults for a policy that applies to a group or role reduces resilience for all users in the tenant. Because group and role membership can't be evaluated in real time during an outage, even users who don't belong to the group or role in the policy assignment are denied access to the application within the scope of the policy. To avoid reducing resilience for all users not within the scope of the policy, apply the policy to individual users instead of groups or roles.

## Testing resilience defaults

You can't conduct a dry run using the Backup Authentication Service or simulate the result of a policy with resilience defaults enabled or disabled. Microsoft Entra runs monthly tests using the Backup Authentication Service. The scope of these tests varies. We do not test every tenant every month. To see if tokens were issued via Backup Authentication Service within your tenant, you can use the sign-in logs. In **Entra ID** > **Monitoring & health** > **Sign-in Logs**, add the filter "Token issuer type == Microsoft Entra Backup Auth" to display the logs processed by Microsoft Entra Backup Authentication Service.

## Configuring resilience defaults

Set up Conditional Access resilience defaults using the Microsoft Entra admin center, Microsoft Graph APIs, or PowerShell.

### Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Create a new policy or select an existing policy.
1. Open the session control settings.
1. Select **Disable resilience defaults** to disable the setting for this policy. Sign-ins within the scope of the policy are blocked during a Microsoft Entra outage.
1. Save changes to the policy.

### Microsoft Graph APIs

Manage resilience defaults for your Conditional Access policies using the MS Graph API and the [Microsoft Graph Explorer](/graph/graph-explorer/graph-explorer-overview).

Sample request URL:

```http
PATCH https://graph.microsoft.com/beta/identity/conditionalAccess/policies/policyId
```

Sample request body:

```json

{
"sessionControls": {
"disableResilienceDefaults": true
}
}
```

### PowerShell

Deploy this patch operation using Microsoft PowerShell after installing the Microsoft.Graph.Authentication module. Install this module by opening an elevated PowerShell prompt and running

```powershell
Install-Module Microsoft.Graph.Authentication
```

Connect to Microsoft Graph and request the required scopes:

```powershell
Connect-MgGraph -Scopes Policy.Read.All,Policy.ReadWrite.ConditionalAccess,Application.Read.All -TenantId <TenantID>
```

Sign in when prompted.

Create a JSON body for the PATCH request:

```powershell
$patchBody = '{"sessionControls": {"disableResilienceDefaults": true}}'
```

Run the patch operation:

```powershell
Invoke-MgGraphRequest -Method PATCH -Uri https://graph.microsoft.com/beta/identity/conditionalAccess/policies/<PolicyID> -Body $patchBody
```

## Recommendations

Microsoft recommends enabling resilience defaults. While there aren't direct security concerns, evaluate whether to let the Backup Authentication Service evaluate Conditional Access policies during an outage using data collected at the beginning of the session instead of in real time.

It's possible that a user’s role or group membership changed since the beginning of the session. With [Continuous Access Evaluation (CAE)](concept-continuous-access-evaluation.md), access tokens remain valid for 24 hours but are subject to instant revocation events. The Backup Authentication Service subscribes to the same revocation events CAE. If a user’s token is revoked as part of CAE, the user can't sign in during an outage. When resilience defaults are enabled, sessions that expire during an outage are extended. Sessions are extended even if the policy is configured with a session control to enforce a sign-in frequency. For example, a policy with resilience defaults enabled might require that users reauthenticate every hour to access a SharePoint site. During an outage, the user’s session is extended even though Microsoft Entra ID might not be available to reauthenticate the user.

## Next steps

- Learn more about [Continuous Access Evaluation (CAE)](concept-continuous-access-evaluation.md)

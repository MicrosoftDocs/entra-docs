---
title: Enable channel binding for Kerberos sign-in
description: Learn how channel binding protects Kerberos-based sign-in to Microsoft Entra ID, prepare your clients and network, and configure enforcement with Microsoft Graph.
ms.topic: how-to
ms.date: 11/24/2026
ai-usage: ai-generated
# Customer intent: As an identity administrator, I want to enable Kerberos channel binding so that I can protect sign-in against authentication relay attacks without disrupting users.
---

# Enable channel binding for Kerberos sign-in

Channel binding helps protect Kerberos-based sign-in to Microsoft Entra ID against authentication relay attacks. Use the authentication feature toggle policy in Microsoft Graph to configure channel binding for your tenant.

The policy controls channel-binding enforcement. It doesn't create CBTs or enable CBT evaluation.

This article describes channel binding for Kerberos authentication to Microsoft Entra ID for [Microsoft Entra seamless single sign-on (Seamless SSO)](~/identity/hybrid/connect/how-to-connect-sso.md), also called Desktop SSO. It doesn't describe how to configure channel binding on your own application servers or domain controllers, or how to configure Microsoft Entra Kerberos access to resources such as file shares.

<!--
Publication review required:
- Confirm API availability, release status, and supported clouds before publishing.
- Confirm permission names, delegated/application permission support, consent requirements, and supported administrator roles.
- Confirm the complete set of affected sign-in flows. Don't imply that all Microsoft Entra Kerberos scenarios are covered.
- Add an engineering-approved browser/OS/authentication-stack compatibility reference with supported versions. Ordinary Seamless SSO support isn't evidence of CBT compatibility.
- Confirm reporting delays and diagnostic coverage limitations for report-only results.
- Confirm policy propagation guidance. Do not equate a successful PATCH or GET with verified runtime enforcement.
-->

## What is a channel binding token?

For Kerberos authentication over HTTPS, the client includes channel-binding information derived from the TLS server certificate in its Kerberos authentication message. The service compares this information with the channel-binding information derived from the certificate used by the HTTPS endpoint that received the request. If the values don't match, authentication fails because the request isn't bound to the expected TLS server endpoint.

Kerberos authenticates the user, TLS protects the connection, and channel binding ensures that the Kerberos authentication is associated with the expected TLS server endpoint. For background, see [Extended Protection for Authentication overview](/dotnet/framework/wcf/feature-details/extended-protection-for-authentication-overview).

## Why enable channel binding with Kerberos?

TLS protects data in transit, but TLS alone doesn't bind the Kerberos authentication exchange to the TLS server endpoint. An attacker might relay an authentication exchange to another endpoint. Without channel binding, the receiving service doesn't have the additional binding information needed to detect that the authentication exchange was presented to a different TLS server endpoint.

Channel binding provides this additional protection by including information derived from the TLS server certificate in the authentication exchange. The service validates this information against the certificate for its TLS endpoint. Requiring a valid CBT helps the service reject authentication that is relayed to an endpoint with different channel-binding information. This corresponds to the tls-server-end-point model, which is based on the server certificate rather than a unique TLS session.

Enable enforcement after you prepare and test your clients and network paths. Channel binding complements your existing authentication and TLS protections; it doesn't replace them.

## Prerequisites

Seamless SSO is supported in the global Azure cloud, Azure Government, and Microsoft Azure operated by 21Vianet (Azure China). For the Seamless SSO domains and setup requirements for each cloud, see the following guidance:

| Cloud | Guidance |
| --- | --- |
| Global Azure cloud | [Get started with Seamless SSO](~/identity/hybrid/connect/how-to-connect-sso-quick-start.md). |
| Azure Government cloud | [Hybrid identity considerations for Azure Government](~/identity/hybrid/connect/reference-connect-government-cloud.md#single-sign-on). |
| Azure China | [Get started with Seamless SSO in Azure China](https://docs.azure.cn/en-us/entra/identity/hybrid/connect/how-to-connect-sso-quick-start). |

Before you change the policy:

- Identify the clients and applications that use Kerberos-based sign-in to Microsoft Entra ID. For Seamless SSO requirements, see [Get started with Seamless SSO](~/identity/hybrid/connect/how-to-connect-sso-quick-start.md).
- Verify that the client operating system, browser, or application supports sending a valid CBT, or that fallback to cloud authentication is acceptable for your scenario. Kerberos support alone doesn't guarantee CBT support. If the client doesn't support CBT, users can still authenticate, but they might be prompted to sign in instead of receiving Seamless SSO.
- Preserve end-to-end TLS between the client and the Microsoft Entra authentication service. Review any proxy, security appliance, or endpoint software that decrypts HTTPS traffic and substitutes a certificate.
- Obtain an access token for Microsoft Graph with the required [permissions](#permissions-and-administrator-roles).
- Record the current `kerberosChannelBinding` value so that you can restore the previous configuration if needed.

The browser configuration in the Seamless SSO quickstart isn't a channel-binding compatibility matrix; validate each browser/OS version and network path before enforcing this policy.

The examples in this article use the Microsoft Graph `/beta` endpoint.

### Permissions and administrator roles

The policy supports delegated permissions for work or school accounts and application permissions. Both require administrator consent.

| Operation | Least-privileged delegated permission | Least-privileged application permission |
| --- | --- | --- |
| Read the policy. | `Policy.Read.AuthFeatureToggle` | `Policy.Read.AuthFeatureToggle` |
| Update or reset the policy. | `Policy.ReadWrite.AuthFeatureToggle` | `Policy.ReadWrite.AuthFeatureToggle` |

`Policy.ReadWrite.AuthFeatureToggle` permits both reading and updating the policy. You don't need both permissions.

For delegated reads, the signed-in user also needs Directory Readers, Authentication Policy Administrator, Global Administrator, or eligible inherited read permissions. Updates and resets require Authentication Policy Administrator, Global Administrator, or eligible inherited update permissions. Directory Readers doesn't authorize updates. An administrative-unit-scoped role doesn't authorize tenant-wide updates.

Application access doesn't require a signed-in user or directory role. A directory role doesn't replace the required Microsoft Graph permission. Unrelated permissions, such as `Directory.Read.All` or `Directory.ReadWrite.All`, don't grant access to this policy.

## Unsupported scenarios

Firefox doesn't currently support CBT for this Kerberos authentication scenario. You can continue using Firefox if fallback to cloud authentication is acceptable for your users. Enforcement prevents these clients from using Seamless SSO, not from signing in through another authentication method. Test the fallback experience, which might include a sign-in prompt, before enabling enforcement.

## What can cause channel binding to fail?

Enforcement requires a valid binding between Kerberos authentication and the TLS channel. The following conditions can prevent that binding.

| Condition | Effect on channel binding | What to check |
| --- | --- | --- |
| TLS inspection or a break-and-inspect proxy substitutes a certificate. | The client authenticates over a TLS channel that differs from the channel seen by Microsoft Entra ID. The binding values can differ, causing validation to fail. | Configure the affected authentication traffic to preserve end-to-end TLS. Work with your network security team to exclude that traffic from TLS decryption, then test the path again. |
| A client doesn't send a CBT. | The request doesn't provide the channel-binding information required by enforcement. | Verify CBT support in the operating system and the browser or application. Update or reconfigure the affected client, or confirm that fallback to cloud authentication is acceptable before enforcing the policy. |
| A client sends an invalid or mismatched CBT. | The authentication message can't be validated against the expected TLS channel. | Check the client implementation, EPA configuration, and certificate substitution along the network path. |
| Client settings suppress Extended Protection. | The client might not provide the channel-binding information needed for enforcement. | Review client security policies and settings that disable EPA. For Windows background, see [Extended Protection for Authentication](https://support.microsoft.com/en-us/servicing/os/windows/2022/11/kb5021989-extended-protection-for-authentication). |

A proxy's presence alone doesn't establish that channel binding fails. Check whether it intercepts TLS and changes the binding seen by the client and the service. Test each network path, including VPNs, branch offices, and endpoint-based inspection.

For Seamless SSO, a Kerberos request rejected by channel-binding enforcement can fall back to cloud authentication. The user might then enter credentials and sign in successfully, but that success comes from the fallback method, not from Kerberos. Review the Kerberos authentication step in the [sign-in logs](#how-does-reportonly-mode-work) to verify channel-binding behavior.

## Policy states

Set the `kerberosChannelBinding` property directly to one of the following exact, case-sensitive enum values.

| State | Meaning |
| --- | --- |
| `enabled` | Explicitly enable Kerberos channel-binding enforcement. |
| `disabled` | Explicitly disable Kerberos channel-binding enforcement, even if the service default would enforce it. |
| `reportOnly` | Evaluate and log the would-be enforcement outcome without enforcing this feature. |
| `notConfigured` | Remove the tenant override for this setting and use the service default. |

The enum also defines `unknownFutureValue` for responses. Don't send this response-only value in a PATCH request.

`notConfigured` doesn't mean `disabled`. The service default determines the effective behavior when there's no tenant override and can require enforcement. GET returns `notConfigured` when no override exists; a failed read doesn't establish that there's no override.

The policy applies at the tenant level, without user or group targeting. Plan your change around the clients and network paths that use the affected authentication flow.

## Supported policy requests

Each tenant has one policy. Currently, the policy exposes only the `kerberosChannelBinding` setting.

| Operation | Request |
| --- | --- |
| Read the policy. | `GET /beta/policies/authenticationFeatureTogglePolicy` |
| Update or reset a setting. | `PATCH /beta/policies/authenticationFeatureTogglePolicy` |

Don't append a policy ID or a feature name to the URL. The API doesn't support POST, DELETE, UPSERT, child feature routes, collection listing, or paging. To reset this setting, use PATCH with `kerberosChannelBinding` set to `notConfigured`.

PATCH updates only supplied settings; omitted settings retain their values. An empty JSON object (`{}`) makes no change and doesn't reset the policy. Null doesn't reset a setting. Null or malformed setting values, invalid enum values, duplicate JSON members, unsupported properties, and read-only input return `400 Bad Request` without partially applying the update.

The API doesn't expose ETags or support conditional updates. Don't rely on `If-Match` or other conditional headers to prevent concurrent changes from overwriting one another.

## Read the current policy

Use the following request to read the tenant's authentication feature toggle policy.

```http
GET https://graph.microsoft.com/beta/policies/authenticationFeatureTogglePolicy
Authorization: Bearer {token}
```

A successful request returns `200 OK`. The following abbreviated response shows a tenant configured for report-only mode:

```json
{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#policies/authenticationFeatureTogglePolicy",
  "@odata.type": "#microsoft.graph.authenticationFeatureTogglePolicy",
  "id": "034bbe5e-0fd2-4d4a-bff2-583ccc349251",
  "kerberosChannelBinding": "reportOnly"
}
```

The policy `id` is server-owned and read-only. Don't copy it into PATCH requests. `kerberosChannelBinding` is a scalar enum value, not an object containing a `state` property or display metadata.

To return only the named setting, use the supported `$select` query option:

```http
GET https://graph.microsoft.com/beta/policies/authenticationFeatureTogglePolicy?$select=kerberosChannelBinding
Authorization: Bearer {token}
```

The setting is a property of the policy, not a child resource. Query options other than `$select`, including `$filter` and `$expand`, aren't supported.

## Prepare for enforcement

Before enforcing channel binding, check compatibility across representative client and network combinations.

1. Read the policy and record the current `kerberosChannelBinding` value.
1. Identify and remediate TLS interception on the affected authentication paths.
1. Verify that representative clients send a valid CBT. Include each operating system, browser, application, and network path used in your environment. If the client doesn't support CBT, users can still authenticate, but they might be prompted to sign in instead of receiving Seamless SSO.
1. If you need a reporting-only evaluation, set `kerberosChannelBinding` to `reportOnly`:

    ```http
    PATCH https://graph.microsoft.com/beta/policies/authenticationFeatureTogglePolicy
    Authorization: Bearer {token}
    Content-Type: application/json

    {
      "kerberosChannelBinding": "reportOnly"
    }
    ```

1. For each client and network combination, initiate a Seamless SSO attempt and record the user, application, test time, browser/OS versions, and network path. Collect the corresponding sign-in records by following [How to customize and filter identity activity logs](~/identity/monitoring-health/howto-customize-filter-logs.md). Access to these logs requires at least the Reports Reader role; the policy permission alone doesn't grant log access.
1. Verify the CBT-specific outcome for the Kerberos attempt before changing `kerberosChannelBinding` to `enabled`. Follow the sign-in-log procedure in [How does reportOnly mode work?](#how-does-reportonly-mode-work). Inspect **Authentication details** > **Result detail** for the report-only message that the sign-in would have been blocked; don't filter only for failed sign-ins. Remediate unexpected failures before repeating the test. For clients without CBT support, confirm that fallback to cloud authentication is acceptable. If the records don't expose a CBT-specific result, work with Microsoft support to obtain diagnostic evidence rather than treating the test as passed.

Report-only mode doesn't enforce this protection. A successful sign-in, a fallback to another authentication method, or an absence of recorded failures isn't proof that enforcement will succeed. General sign-in records help correlate a test but aren't a substitute for its channel-binding result.

## Enable channel-binding enforcement

After you prepare your clients and network, enable enforcement.

1. Send the following update:

    ```http
    PATCH https://graph.microsoft.com/beta/policies/authenticationFeatureTogglePolicy
    Authorization: Bearer {token}
    Content-Type: application/json

    {
      "kerberosChannelBinding": "enabled"
    }
    ```

    A successful update returns `204 No Content`. Only settings included in the request change. Other feature settings are preserved.

1. Read the policy again and verify that `kerberosChannelBinding` is `enabled`. An immediate read can lag behind the update.
1. Test Kerberos-based sign-in with representative clients and network paths. For clients that support CBT, verify that silent SSO succeeds and [confirm in the sign-in logs that the request used Seamless SSO](#how-can-i-determine-whether-a-sign-in-used-seamless-sso-instead-of-another-sso-mechanism), not a PRT or another authentication method. For clients without CBT support, verify that users can complete the expected fallback authentication.

Changes propagate asynchronously, without a documented timing guarantee. A successful PATCH confirms the policy update, not that every authentication service has applied it. Reading back `enabled` confirms the stored configuration. Validate authentication behavior separately to confirm the effect of the change.

## Troubleshoot policy requests

Use the response status to distinguish a request or access problem from an authentication compatibility problem.

| Status | What to check |
| --- | --- |
| `400 Bad Request` | Set `kerberosChannelBinding` directly to a supported, case-sensitive enum string, not an object or null. Remove duplicate members, read-only fields, and unsupported properties. An empty JSON object is a no-op, not an error. |
| `403 Forbidden` | Verify administrator consent, the required Microsoft Graph permission, and, for delegated access, the user's role permissions. |
| `404 Not Found` | Verify that the policy is available to the authenticated tenant and that you're using the singleton URL without an ID or child path. |
| `503 Service Unavailable` | The backing policy service is temporarily unavailable. Follow any retry guidance in the response. |

A failed or lost update response can leave the outcome uncertain. Read the policy before deciding whether to retry, allowing for asynchronous propagation. Don't interpret a failed read as `notConfigured` or as confirmation that a reset succeeded.

## Troubleshoot failures after enforcement

If Kerberos-based sign-in stops working after you enable enforcement:

1. Compare an affected client's behavior on the usual network path with a controlled path that preserves end-to-end TLS to the authentication service. Check whether TLS inspection substitutes the service certificate.
1. Verify that the affected browser or application sends a CBT and that client settings don't suppress EPA.
1. Check whether the Kerberos attempt fails even if the user can complete sign-in through another method. For general Seamless SSO checks, see [Troubleshoot Seamless SSO](~/identity/hybrid/connect/tshoot-connect-sso.md).
1. Correct the client or network configuration, and repeat the authentication test.

If you need to restore the previous policy state while you investigate, send a `PATCH` with the state you recorded before the change. For example, if the previous state was `notConfigured`, use:

```http
PATCH https://graph.microsoft.com/beta/policies/authenticationFeatureTogglePolicy
Authorization: Bearer {token}
Content-Type: application/json

{
  "kerberosChannelBinding": "notConfigured"
}
```

This update removes only the `kerberosChannelBinding` tenant override. It preserves other settings and uses the service default for Kerberos channel binding. To explicitly disable enforcement, set `kerberosChannelBinding` to `disabled` instead. Neither disabling enforcement nor returning to report-only mode resolves the underlying compatibility issue.

## Frequently asked questions

Find answers to common questions about protection, compatibility, and diagnostics for Kerberos channel binding.

### What does Kerberos channel binding protect against?

Kerberos channel binding helps protect Microsoft Entra Seamless SSO against credential relay attacks by binding the Kerberos authentication exchange to the TLS connection. This helps prevent Kerberos authentication obtained through a different connection or endpoint from being successfully relayed to the Seamless SSO endpoint.

### Does Kerberos channel binding affect all Microsoft Entra authentication?

No. Kerberos channel binding applies only to the Kerberos authentication flow used by Microsoft Entra Seamless SSO. It doesn't affect other Microsoft Entra authentication mechanisms, such as authentication that uses a primary refresh token (PRT).

A user can therefore experience single sign-on even when the Seamless SSO Kerberos flow isn't used.

### How should I test compatibility before enabling channel-binding enforcement?

Set Kerberos channel binding to `reportOnly` before changing it to `enabled`.

In `reportOnly` mode, Microsoft Entra evaluates whether Seamless SSO authentication meets the channel-binding requirement without blocking authentication. Review the results in the Microsoft Entra sign-in logs to identify affected clients or network configurations before enabling enforcement.

### How does `reportOnly` mode work?

When Kerberos channel binding is set to `reportOnly`, Microsoft Entra evaluates channel binding without blocking authentication.

To review the result:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Filter by the test user, application, and test time. Select the record for the Kerberos attempt, rather than a later fallback sign-in. If needed, [verify which SSO mechanism was used](#how-can-i-determine-whether-a-sign-in-used-seamless-sso-instead-of-another-sso-mechanism).
1. Select **Authentication details**.
1. Review **Result detail** for the Seamless SSO authentication step, not just the overall sign-in **Status** or the step's **Succeeded** value.

For an affected sign-in, the authentication details indicate:

> Kerberos channel binding: report-only; this sign-in would have been blocked.

Because `reportOnly` doesn't block authentication, the sign-in doesn't fail because of the channel-binding evaluation. The report-only diagnostic isn't a blocking sign-in error, so don't use **Sign-in error code** alone to assess CBT compatibility. In Microsoft Graph sign-in records, step-level result descriptions are exposed in `authenticationDetails[].authenticationStepResultDetail`; see [Authentication details](/graph/api/resources/authenticationdetail?view=graph-rest-beta&preserve-view=true).

Review the method and result together: an overall successful sign-in or a successful authentication step doesn't override a CBT diagnostic that enforcement would have blocked the attempt. This information is available in the sign-in logs, not the directory audit logs.

### How can I determine whether a sign-in used Seamless SSO instead of another SSO mechanism?

A successful or silent sign-in doesn't necessarily mean that Seamless SSO was used. Windows devices can obtain single sign-on through other mechanisms, including a PRT.

To investigate a specific sign-in:

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Filter by the test user, application, and test time. Use **Correlation ID** together with these details to identify related sign-in records.
1. Select **Authentication details**.
1. Review the authentication methods and step-level results for the Seamless SSO attempt and its Kerberos channel-binding evaluation. **Satisfied by token** or **Previously satisfied** alone doesn't establish that this request performed Kerberos authentication.
1. On **Basic info**, check **Incoming token type**. **Primary refresh token** identifies a PRT-based request; don't count it as a successful Seamless SSO test.

For an explicit protocol identifier in a Microsoft Graph [sign-in record](/graph/api/resources/signin?view=graph-rest-beta&preserve-view=true), inspect `authenticationProtocol`. The value `seamlessSso` identifies Seamless SSO; `prtGrant`, `prtBrokerBased`, and `prtNonBrokerBased` identify PRT flows. Include the `Prefer: include-unknown-enum-members` header when retrieving records through Microsoft Graph to receive these protocol values. If the record doesn't identify the flow or expose the CBT result, don't treat the test as verified.

On a Windows device, you can also run:

```console
dsregcmd /status
```

Under **SSO State**, `AzureAdPrt : YES` indicates that a PRT is available on the device.

> [!NOTE]
> The presence of a PRT doesn't indicate that a specific sign-in used the PRT. Use the sign-in's authentication details to investigate the authentication method for a specific sign-in.

### Which browsers support Kerberos channel binding?

Microsoft Edge and Google Chrome provide the channel-binding information required for this Seamless SSO flow. Firefox doesn't currently provide the required channel-binding information and can be affected when channel-binding enforcement is enabled.

### Can TLS inspection or a corporate proxy affect channel-binding validation?

Yes. TLS inspection can affect channel-binding validation.

If an intermediary terminates the TLS connection and establishes a separate TLS connection to Microsoft Entra, the TLS information available to the client can differ from the information validated by Microsoft Entra. As a result, channel-binding validation can fail.

Use `reportOnly` before enabling enforcement to identify potential compatibility issues with proxies, VPNs, security appliances, or TLS inspection configurations.

### What should I check if `reportOnly` identifies channel-binding failures?

Check whether the affected sign-ins have common characteristics, such as:

- The same browser or client application is used.
- TLS inspection or HTTPS interception is enabled.
- Traffic passes through the same corporate proxy.
- The same VPN configuration is used.
- Traffic follows the same network path.

Verify that the client supports channel binding and determine whether HTTPS traffic to the Seamless SSO endpoint is intercepted or terminated by an intermediary. If possible, compare the affected sign-in with a test from a network path that doesn't use TLS inspection.

### Do I need to change the `AZUREADSSOACC` account or rotate its Kerberos key before enabling channel binding?

No additional `AZUREADSSOACC` configuration or Kerberos key rotation is required specifically for channel-binding enforcement.

Continue to follow the existing Microsoft Entra Seamless SSO guidance for managing the `AZUREADSSOACC` computer account and [rotating its Kerberos decryption key](~/identity/hybrid/connect/how-to-connect-sso-quick-start.md#roll-over-keys).

### What should I do if I discover compatibility issues?

Keep the policy set to `reportOnly` while you address incompatible clients or network configurations.

After making the necessary changes, review the sign-in logs again to verify that affected Seamless SSO sign-ins meet the channel-binding requirement. When your environment is ready, change the policy from `reportOnly` to `enabled`.

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md).
- [How Seamless SSO works](~/identity/hybrid/connect/how-to-connect-sso-how-it-works.md).
- [Troubleshoot Seamless SSO](~/identity/hybrid/connect/tshoot-connect-sso.md).
- [Integrated Windows Authentication with Extended Protection](/dotnet/framework/network-programming/integrated-windows-authentication-with-extended-protection).

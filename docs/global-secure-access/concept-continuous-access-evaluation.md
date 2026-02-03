---
title: Learn about Continuous Access Evaluation (CAE) for Application Proxy (preview)
description: Learn about Continuous Access Evaluation (CAE) for Application Proxy (preview)
author: kenwith
ms.author: kenwith
ms.topic: concept-article
ms.date: 10/07/2025
ms.service: global-secure-access
ms.subservice: entra-internet-access 
ms.reviewer: dhruvinshah
ai-usage: ai-assisted
---

# Learn about Continuous Access Evaluation (CAE) for Application Proxy (preview)

Continuous Access Evaluation (CAE) is a security feature designed to provide real-time access control based on policy changes and user risk. CAE enables enforcement of access policies in near real-time by continuously evaluating session validity. When a policy change, user risk update, or other critical security event occurs, CAE can revoke or refresh tokens, ensuring that user access is always in compliance with the latest security requirements. Traditionally Entra ID CAE requires each workload to adopt special libraries and is limited to first-party applications only. 

CAE for Application Proxy, extends benefits of CAE to any on-premises applications published through the application proxy, without requiring the application to be CAE aware.

## Benefits of CAE for Application Proxy (preview)
CAE for Application Proxy responds to critical identity and security events so administrators can limit access promptly. The following are common triggers where enforcement occurs in near real time:

- User termination or password change/reset — user sessions and refresh tokens are revoked in near real time to prevent continued access.
- Network location change — Conditional Access location policies are re-evaluated and enforced in near real time when a user's network context changes.
- Token export to a machine outside of a trusted network — Conditional Access location policies can prevent token use or require additional controls to block access from untrusted machines.

## Understand how CAE for Application Proxy (preview) works
When you enable CAE for Application Proxy, the request and enforcement flow proceeds as follows:

1. User requests access to an on-premises application through Application Proxy.
2. Entra ID authenticates the request.
3. After successful authentication, the user receives access tokens that are typically valid for 60–90 minutes.
4. CAE continuously evaluates the active session for policy changes, risk signals, and revocation events.
5. If a trigger occurs (for example, password reset, account disablement, or elevated risk), CAE revokes the session and requires the user to sign in again.

This workflow enables near-real-time enforcement of access policies for published applications without requiring application changes.

## Microsoft Entra ID signals that trigger CAE reauthentication

Application Proxy receives signals from Microsoft Entra ID in near real time for these events:

- A user account is deleted or disabled.
- A user’s password is changed or reset.
- Multifactor authentication (MFA) is enabled for the user.
- An administrator revokes all refresh tokens for the user.
- Microsoft Entra ID Protection detects high user risk.

When Application Proxy receives any of these signals, it prompts the user to re-authenticate. If re-authentication succeeds, the user regains access to resources published through Application Proxy.

## Disabling CAE for Application Proxy (preview)

### Disable CAE for specific Application Proxy applications

You can disable Continuous Access Evaluation (CAE) for individual Application Proxy applications by updating the application's onPremisesPublishing settings in Microsoft Graph.

HTTP request
```
PATCH https://graph.microsoft.com/beta/applications/{objectId}/onPremisesPublishing
Content-Type: application/json

{
    "isContinuousAccessEvaluationEnabled": false
}
```

Response
```
HTTP/1.1 204 No Content
```

Make sure you call Microsoft Graph with an account or app that has permission to update the application (for example, Application.ReadWrite.All).

### Disable CAE for the whole tenant

Tenant-wide CAE behavior is controlled by Microsoft Entra ID Conditional Access. By default, CAE is enabled for all applications that support it. To disable CAE for all services, update your Conditional Access configuration. For steps, see the Conditional Access documentation.

> [!NOTE]
> CAE is opportunistic unless you enable Strict Enforcement in Conditional Access and apply it to the Application Proxy application. With a non-strict policy, Application Proxy can fall back to issuing a regular access token on re-authentication. Because of this fallback behavior, disabling tenant-wide CAE is rarely necessary.

 

## Known limitations 

For detailed information about known issues and limitations, see the [Application proxy FAQ](/entra/identity/app-proxy/application-proxy-faq). 

## Next steps

- [Continuous Access Evaluation in Microsoft Entra](/entra/identity/conditional-access/concept-continuous-access-evaluation)
- [Application Proxy Overview](/entra/identity/app-proxy/overview-what-is-app-proxy)

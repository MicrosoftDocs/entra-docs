---
title: Prepare apps for Microsoft Entra COOP policy
description: Learn how to make your app compatible with Microsoft Entra Cross-Origin-Opener-Policy and manage policy enforcement while you migrate.
author: ahmemohamed
ms.author: ahmemohamed
manager: pmwongera
ms.service: identity-platform
ms.topic: how-to
ms.custom: msecd-doc-authoring-1026
ms.date: 09/24/2026
ai-usage: ai-generated

#customer intent: As an application developer, I want to make my apps compatible with Microsoft Entra COOP policy so that users can keep signing in and my apps mitigate popup-based social engineering threats.
---

# Prepare your app for Microsoft Entra Cross-Origin-Opener-Policy

Cross-Origin-Opener-Policy (COOP) is a browser security rule that isolates a top-level document from cross-origin windows. This isolation prevents social engineering attacks in which a malicious page opens a legitimate application. After the application navigates to sign-in, the malicious page can hijack the sign-in flow and mislead the user about which application is being accessed.

This article helps you make your app compatible with Microsoft Entra COOP policy so that users can keep signing in without interruption. It's for developers whose apps use Microsoft Authentication Library for JavaScript (MSAL.js) popup methods or a similar SDK.

## How the COOP policy affects sign-in

Microsoft Entra COOP policy is a breaking change for new applications that depend on popup-based sign-in. Microsoft Entra disconnects popups from their openers. This change prevents a malicious page from opening a legitimate application and then hijacking its sign-in flow.

## Check the new app enforcement timeline

Microsoft Entra COOP policy applies to all Microsoft Entra web protocols on new apps created after January 31, 2027. If you create new applications, make sure they're compatible before January 31, 2027.

## Update the authentication method

The recommended fix is to become COOP-compatible by updating your authentication method to avoid parent-window messaging. If you use MSAL.js, upgrade to the latest supported version (v5). MSAL.js v5 uses COOP-compatible window communication.

For migration instructions, see [Migrate from MSAL Browser v4 to v5](/entra/msal/javascript/browser/v4-migration).

1. Update your MSAL.js package to the latest supported version (v5).
1. Test interactive sign-in to confirm that popups complete successfully with COOP enabled.

## Manage COOP policy enforcement

If you can't upgrade to MSAL.js v5 right away or use a different library, temporarily continue using your existing flow by managing COOP enforcement. Use the Microsoft Graph self-service API while you implement a COOP-compatible authentication flow or upgrade to MSAL.js v5.

The `coopEnforcement` application property lets you opt out of enforcement without opening a support request. After your application is COOP-ready, use the same property to opt back in.

> [!WARNING]
> Opting out of the COOP policy doesn't fix the underlying vulnerability. While the policy is disabled, the application remains exposed to the cross-origin attacks that the COOP headers help prevent.
>
> Only opt out if the application severs the parent-window relationship before redirecting to sign-in and ensures that only trusted sites can open the sign-in popup. Re-enable enforcement as soon as the application uses a compatible flow.

1. Follow [Configure application authentication behaviors by using Microsoft Graph](/graph/applications-authenticationbehaviors?tabs=http) to opt out while you migrate.
1. Implement a COOP-compatible authentication flow or upgrade to MSAL.js v5.
1. Test the application's authentication flows.
1. Use the `coopEnforcement` property to opt back in.

## Related content

- [Overview of the Microsoft Authentication Library (MSAL)](msal-overview.md)
- [Handle third-party cookie blocking in browsers](reference-third-party-cookies-spas.md)
- [Content Security Policy overview for Microsoft Entra ID](content-security-policy.md)

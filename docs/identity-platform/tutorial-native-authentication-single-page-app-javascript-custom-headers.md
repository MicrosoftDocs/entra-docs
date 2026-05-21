---
title: Add custom headers to native auth requests in JavaScript SPAs
description: Learn how to attach custom x-* headers to native authentication requests in a React or Angular SPA to integrate fraud-detection SDKs with Microsoft Entra External ID.
author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: identity-platform
ms.subservice: external
ms.topic: tutorial
ms.date: 05/20/2026
ms.custom: msecd-doc-authoring-1012
ai-usage: ai-assisted
#Customer intent: As a JavaScript SPA developer using native authentication, I want to attach custom headers to native auth network requests so that I can integrate fraud and bot-detection SDKs with my Microsoft Entra External ID app.
---

# Tutorial: Attach custom x-* headers to native authentication requests in a React or Angular SPA

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial shows you how to attach custom `x-*` headers to native authentication network requests in a React or Angular single-page app (SPA). Use the `CustomAuthRequestInterceptor` from the native authentication JavaScript SDK to integrate third-party fraud and bot-detection SDKs such as Akamai, HUMAN, Prove, or ThreatMetrix.

The same interceptor pattern applies to both React and Angular apps. The code is identical; only the location of your app configuration file differs.

In this tutorial, you:

> [!div class="checklist"]
>
> - Understand the header naming rules that MSAL enforces.
> - Implement a `CustomAuthRequestInterceptor`.
> - Register the interceptor on your `CustomAuthConfiguration`.
> - Verify that your headers reach the intended endpoints.

## Prerequisites

- A React or Angular SPA that uses native authentication. If you don't have one, complete one of the following tutorials first:
    - [Sign in users into a React single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md)
    - [Sign in users in an Angular single-page app by using native authentication](tutorial-native-authentication-single-page-app-angular-sign-in.md)

## Understand header naming rules

The Microsoft Authentication Library (MSAL) applies the following rules when it evaluates the headers that you provide. Use these rules to verify your vendor-required header names before you implement the interceptor:

- Headers **must** start with `x-` (case-insensitive). MSAL ignores headers that don't start with `x-`.
- MSAL ignores headers that start with any of the following reserved prefixes, because they're owned by the SDK:
    - `x-client-`
    - `x-ms-`
    - `x-broker-`
    - `x-app-`

MSAL adds any header that passes both rules to the network request. If a header name you provide conflicts with one the SDK would set, your value takes precedence.

## Implement the request interceptor

The `CustomAuthRequestInterceptor` interface declares a single method, `addAdditionalHeaderFields`, that MSAL calls before it sends each native authentication network request. Your implementation receives the request URL and returns a dictionary of headers to add, or `null` if no headers are needed for that request.

Open your app configuration file:

- **Angular**: `src/app/config/auth-config.ts`
- **React (Next.js)**: `src/config/auth-config.ts`

Add the following interceptor above your existing `customAuthConfig` definition:

```typescript
import { CustomAuthConfiguration, LogLevel } from "@azure/msal-browser/custom-auth";
import type { CustomAuthRequestInterceptor } from "@azure/msal-browser/custom-auth";

const requestInterceptor: CustomAuthRequestInterceptor = {
    addAdditionalHeaderFields(requestUrl: URL) {
        // Scope headers to specific endpoints only.
        if (requestUrl.pathname.endsWith("/oauth2/v2.0/initiate")) {
            return {
                value_1: "customer_header_1",            // Ignored: doesn't start with "x-".
                "x-client-header": "customer_header_2",  // Ignored: starts with reserved prefix "x-client-".
                "X-my-custom-header": "my data",         // Added to the network request.
            };
        }

        // Return null for all other requests to avoid over-sending signals.
        return null;
    },
};
```

The `addAdditionalHeaderFields` method receives the full URL of the outgoing request in `requestUrl`. Use the URL to scope your headers to the specific endpoints that your fraud or bot-detection vendor requires, such as sign-in or sign-up initiation endpoints. Sending headers to unrelated endpoints can degrade signal quality and increase false positives.

> [!NOTE]
> MSAL evaluates the naming rules *after* your interceptor returns. Logging from inside `addAdditionalHeaderFields` shows only the headers that you provided, not the final set that MSAL sends. Inspect the actual network request to verify the final headers.

## Register the interceptor

After you implement the interceptor, assign it to the `requestInterceptor` property on the `customAuth` block of your `CustomAuthConfiguration`:

```typescript
export const customAuthConfig: CustomAuthConfiguration = {
    customAuth: {
        challengeTypes: ["password", "oob", "redirect"],
        authApiProxyUrl: "http://localhost:3001/api",
        requestInterceptor: requestInterceptor,
    },
    auth: {
        clientId: "Enter_the_Application_Id_Here",
        // ...
    },
};
```

The configuration shape is identical for the React and Angular samples.

## Verify headers are applied

To confirm that your headers reach the intended endpoints, inspect the outgoing network traffic by using your browser's developer tools (Network tab) or a network proxy tool such as Fiddler. Check that:

- Headers that start with `x-` and don't use a reserved prefix appear in the request.
- Headers that use reserved prefixes (`x-client-`, `x-ms-`, `x-broker-`, `x-app-`) don't appear in the request.
- Headers appear only on the endpoints you targeted in your interceptor.

## Related content

- [Native authentication overview](concept-native-authentication.md)
- [Sign in users into a React single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md)
- [Sign in users in an Angular single-page app by using native authentication](tutorial-native-authentication-single-page-app-angular-sign-in.md)
- [Tutorial: Add custom headers to native auth network requests in iOS (Swift)](tutorial-native-authentication-ios-swift-custom-headers.md)

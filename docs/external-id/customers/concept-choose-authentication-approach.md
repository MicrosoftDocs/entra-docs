---
title: Choose your authentication approach
description: Compare browser-delegated and native authentication in Microsoft Entra External ID to decide the right approach for your app.
ai-usage: ai-assisted

author: garrodonnell
manager: dougeby
ms.service: entra-external-id
ms.subservice: customers
ms.topic: concept-article
ms.date: 04/16/2026
ms.author: godonnell
---

# Choose your authentication approach

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

When you build customer-facing apps with Microsoft Entra External ID, you choose between two authentication approaches: browser-delegated authentication and native authentication. Both are fully supported, but they differ in user experience, development effort, and security model.

## Browser-delegated vs. native authentication

With **browser-delegated authentication**, your app redirects users to a Microsoft-hosted sign-in page in a system browser or embedded web view. Microsoft Entra handles the entire authentication flow — your app receives tokens after sign-in completes. This approach requires minimal code and offers built-in branding customization.

With **native authentication**, you build the sign-in screens directly into your app using the Microsoft Authentication Library (MSAL) SDK or the native authentication API. Users never leave your app. You control every aspect of the UI, but your team is responsible for building and maintaining the authentication experience.

## When to use browser-delegated authentication

Browser-delegated authentication is the better fit when:

- You need single sign-on (SSO) across multiple apps.
- You want to support the broadest range of platforms and languages with less code.
- Your app can accommodate a browser redirect during sign-in without disrupting the user experience.
- You prefer lower implementation and maintenance effort — Microsoft manages security updates and new features automatically.

## When to use native authentication

Native authentication is the better fit when:

- You need a fully branded, pixel-perfect sign-in experience embedded in your app.
- Your app is mobile-first and a browser redirect would disrupt the user experience.
- Your organization operates both the app and the authorization server, and your users perceive them as a single entity.
- Your development team can take on the additional security responsibility and ongoing maintenance.

## Feature comparison

The following table shows which features are available in each approach.

| Feature | Browser-delegated | Native |
|---|---|---|
| Sign up and sign in with email OTP | ✔️ | ✔️ |
| Sign up and sign in with email and password | ✔️ | ✔️ |
| Self-service password reset (SSPR) | ✔️ | ✔️ |
| Multifactor authentication (email OTP) | ✔️ | ✔️ |
| Multifactor authentication (SMS OTP) | ✔️ | ✔️ |
| Social identity providers (Apple, Facebook, Google) | ✔️ | ✔️ |
| Single sign-on (SSO) | ✔️ | ❌ |
| Custom claims provider | ✔️ | ✔️ |

## Security considerations

Browser-delegated authentication is the more secure option. Microsoft manages the sign-in surface, which reduces your app's exposure to phishing and credential-harvesting attacks.

With native authentication, your development team shares security responsibility with Microsoft Entra. Your team must follow security best practices for handling user credentials, and SSO isn't available. Before you choose native authentication, discuss the security implications with your app's business owner and development team.

## Next steps

- [Native authentication overview](/entra/identity-platform/concept-native-authentication)
- [Register an app](/entra/identity-platform/quickstart-register-app)
- [Android native authentication tutorial](/entra/external-id/customers/how-to-run-native-authentication-sample-android-app)
- [iOS native authentication tutorial](/entra/external-id/customers/how-to-run-native-authentication-sample-ios-app)
- [Native authentication in React SPA](/entra/identity-platform/quickstart-native-authentication-single-page-app-sdk-sign-in)

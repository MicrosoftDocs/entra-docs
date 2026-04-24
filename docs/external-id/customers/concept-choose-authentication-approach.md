---
title: Choose an authentication approach
description: Compare browser-delegated and native authentication in Microsoft Entra External ID to decide the right approach for your app.
ai-usage: ai-assisted

author: garrodonnell
manager: dougeby
ms.service: entra-external-id
ms.subservice: customers
ms.topic: concept-article
ms.date: 04/16/2026
ms.author: godonnell

#Customer intent: As a developer, I want to understand the differences between browser-delegated and native authentication so that I can choose the right approach for my customer-facing app.
---

# Choose an authentication approach

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Browser-delegated authentication and native authentication are two sign-in approaches in Microsoft Entra External ID that define how your customer-facing app handles the authentication experience. Both approaches are fully supported, but they differ in user experience, development effort, and security model. Understanding these differences helps you choose the approach that best fits your app.

With **browser-delegated authentication**, your app redirects users to a Microsoft-hosted sign-in page in a system browser or embedded web view. Microsoft Entra handles the entire authentication flow, and your app receives tokens after sign-in completes. This approach requires minimal code and offers built-in branding customization.

With **native authentication**, you build the sign-in UI experience directly into your app by using the Microsoft Authentication Library (MSAL) SDK or the native authentication API. Users never leave your app. You control every aspect of the UI, but your team is responsible for building and maintaining the authentication experience.

## When to use browser-delegated authentication

Browser-delegated authentication is the better fit when:

- Your app can accommodate a browser redirect during sign-in without disrupting the user experience.
- You prefer lower implementation and maintenance effort. Microsoft manages security updates and new features automatically.
- You want to support the broadest range of platforms and languages with less code.

For specific feature availability, see the [feature comparison](#feature-comparison).

## When to use native authentication

Native authentication is the better fit when:

- You need full control over the sign-in UI so it blends seamlessly into your app.
- A browser redirect would disrupt the user experience for your target platform.
- Your organization operates both the app and the authorization server, and your users perceive them as a single entity.
- Your development team can take on the additional implementation effort and ongoing maintenance.

For specific feature availability, see the [feature comparison](#feature-comparison).

## Feature comparison

The following table shows which features are available in each approach.

| Feature | Browser-delegated | Native authentication |
|---|---|---|
| Sign up and sign in with email one-time passcode (OTP) | :heavy_check_mark: | :heavy_check_mark: |
| Sign up and sign in with email and password | :heavy_check_mark: | :heavy_check_mark: |
| Sign in with email and password can use username (alias) and password | :heavy_check_mark: | :heavy_check_mark: |
| Self-service password reset (SSPR) | :heavy_check_mark: | :heavy_check_mark: |
| Custom claims provider | :heavy_check_mark: | :heavy_check_mark: |
| Multifactor authentication with email one-time passcode (OTP) | :heavy_check_mark: | :heavy_check_mark: |
| Multifactor authentication with SMS one-time passcode (OTP) | :heavy_check_mark: | :heavy_check_mark: |
| Social identity provider sign-in (Apple, Facebook, and Google with browser-delegated) | :heavy_check_mark: | :heavy_check_mark: |
| Single sign-on (SSO)<sup>1</sup> | :heavy_check_mark: | :heavy_check_mark: |

<sup>1</sup> Native authentication supports SSO for embedded web views only. Cross-app SSO through system browsers isn't available with native authentication.

## Security considerations

Browser-delegated authentication is the more secure option. Microsoft manages the sign-in surface, which reduces your app's exposure to phishing and credential-harvesting attacks.

With native authentication, your development team shares security responsibility with Microsoft Entra. Your team must follow security best practices for handling user credentials. Before you choose native authentication, discuss the security implications with your app's business owner and development team.

## Next steps

- [Native authentication overview](/entra/identity-platform/concept-native-authentication)
- [Register an app](/entra/identity-platform/quickstart-register-app)
- [Android native authentication tutorial](/entra/external-id/customers/how-to-run-native-authentication-sample-android-app)
- [iOS native authentication tutorial](/entra/external-id/customers/how-to-run-native-authentication-sample-ios-app)
- [Native authentication in React SPA](/entra/identity-platform/quickstart-native-authentication-single-page-app-sdk-sign-in)

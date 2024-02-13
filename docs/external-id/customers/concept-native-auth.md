---
title: Native authentication
description: Learn 
 
author: csmulligan
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: conceptual
ms.date:  02/12/2023
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, 
---
# Native authentication for customer apps

Developers can create seamless authentication experiences for customer-facing mobile and desktop applications using the private preview Microsoft Authentication Library (MSAL) for iOS and Android. Native authentication enables you to host the user interface in the client application instead of delegating authentication to browsers, resulting in a natively integrated authentication experience. You also have the flexibility to choose from different authentication methods to create the authentication experience that suits your needs.

   ![Image of available native authentication experiences.](media/native-auth-experiences.png)

With native authentication, the application code controls the authentication experience. As the developer, you have full control over the look and feel of the user interface using the language of your choice. For example, you can define the background design, logo placement, layouts, and other elements that give your app a consistently branded look.

Watch this [video](https://www.youtube.com/embed/20Tp0CM55rw) for an overview of native authentication capabilities.

## When should I use native authentication?

Whether you choose native authentication over browser-delegated authentication depends on your requirements. In general, native authentication is an ideal solution for any of the following conditions:

- Streamlined sign-up and sign-in experiences are critical, and any friction encountered by users may impact revenue, retention, etc.
- A consistently branded experience across touchpoints and applications is of paramount importance.
- Your onboarding transactions are low risk, and acquisition far outweighs governance.
- Your browser-delegated capabilities don’t meet all of your UI customization and layout needs.
- The features you require are currently available via native authentication.

Native authentication is not a supported solution for:

- Third-party or multi-tenant applications
- Microsoft first-party client applications
- B2B or B2E apps (only Entra External ID for customers applications are in scope)

## What's available in private preview?

In this private preview, you can create fully native experiences for local account sign-up, sign-in, and sign-out for your first party applications.

The following capabilities for local accounts are available in this private preview:

- Passwordless authentication with email one-time passcode (OTP) (for sign-up, sign-in, and sign-out)
- Password authentication (for sign-up, sign-in, and sign-out)  
- Self-service password reset with email OTP verification  
- Collection of user attributes

## Capabilities that are out of scope 

The following capabilities are out of scope:

- Multi factor authentication during sign-in
- Conditional Access
- Some of the [Custom authentication extensions (preview)](https://learn.microsoft.com/entra/identity-platform/custom-extension-overview) events are not triggered when Microsoft Entra ID does not  render the UI. For example, when using native authentication the following event will not trigger:
   - [Custom authentication extensions for attribute collection start and submit events](https://learn.microsoft.com/entra/identity-platform/custom-extension-attribute-collection?tabs=start-continue%2Csubmit-continue). For applications that use native authentication, it's up to app developer to call the REST API directly from their applications.
   - [Brand your apps via custom authentication extensions](https://github.com/microsoft/entra-previews/blob/PP4/docs/Branding-per-app-via-custom-auth-extension.md). For applications that use native authentication, the developer of the app has full control on the UI.
  
## Samples and documentation for native authentication

This private preview contains samples and documentation for the languages and platforms listed in the following table.

For a demonstration of sample application using iOS MSAL native authentication, see the following [video](https://www.youtube.com/embed/ykf3sm5nxRc).

### Recommended path for this preview:

1. Start with the **Code sample guide** below in your preferred language and explore the sample application.
2. Follow the **Build and integrate guide** to add login experience to your app.
3. Optionally, explore the API reference in Postman.

### Mobile and desktop apps

| Language/Platform   | Code sample guide | Build and integrate guide |
| ------------------- |  ---------------- | ------------------------- |
| **Android (Kotlin)    | [Sign in users in a sample native Android mobile application](Developer-guides/0-Android-Kotlin/0-Run-code-sample.md) | [Add authentication to your Android app](Developer-guides/0-Android-Kotlin/1-Add-authentication-prepare-app.md) |
| **iOS (Swift)         | [Sign in users in a sample native iOS mobile application](Developer-guides/1-iOS-Swift/0-Run-code-sample.md) | [Add authentication to your native iOS mobile application](Developer-guides/1-iOS-Swift/1-Add-authentication-prepare-app.md) |

### API and SDK Reference

|  Documentation  | 
|   ---------------- |
|  [Native Authentication REST API Reference](Developer-guides/3-REST-API-reference/0-API-reference-overview.md)   |
|  [MSAL Android Native Auth SDK reference](./Developer-guides/2-Native-SDK-reference/1-Android-SDK-reference.md)   |
|  [MSAL iOS Native Auth SDK reference](./Developer-guides/2-Native-SDK-reference/iOS/msal-ios-sdk-reference.md)   |

## Known issues

The following table describes known issues and important considerations related to this preview release. We don't currently have a preview target or timeline to share regarding when individual issues will be resolved.

| Issue | Impact | Workaround(s) |To be fixed | 
| ----- | ------ | ------------- | ------| 
| When specifying a custom attribute, the required key syntax is </br>`extension_<b2c-extensions-app-id>_<custom-attribute-name>` </br>where: </br>- `<b2c-extensions-app-id>` is the ID of the *b2c-extensions-app* registered in your customer tenant with no hyphens </br>- `<custom-attribute-name>` is the name you assigned to the custom attribute      | This key syntax is required for custom attributes.        |  NA             |  NA     |
| When signing in with an SLT after sign-up with email and password, the ID token `username` claim will show the principal username instead of the email address the user entered during sign-up.      |  Creates confusion.      |   If the username claim is needed, then sign in through email + password instead of SLT            | yes, timeline TBD      |
| Unconfigured attributes that are sent by the client are silently ignored by the API.      | No indication is given that attributes are being ignored.       | NA               | yes, timeline TBD       |
| When using the MSAL Native Auth SDKs, an access token can't be requested for multiple scopes belonging to multiple API resources.      | NA       | NA              | yes, timeline TBD      |
| When you enable native authentication APIs in the Microsoft Entra Admin center, you might experience some delays. | Delay in changing configuration       | NA              | TBD      |

<!--
## Frequently asked questions

### Question...
Answer...
-->
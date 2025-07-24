---
title: Set up QR Code and PIN Authentication in iOS/macOS App
description: Learn how to configure your iOS app to use QR code and PIN authentication using the Microsoft Authentication Library for iOS and macOS.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.service: msal
ms.subservice: msal-ios-mac
ms.topic: concept-article
ms.date: 07/24/2025
ms.reviewer: akgoel

#Customer intent: As a developer, I want to learn how to configure your iOS app to have optimized QR code authentication experience using the Microsoft Authentication Library for iOS and macOS. 
---

# Set up optimized QR code authentication experience in iOS/macOS app

QR code authentication method enables frontline workers to sign in quickly and easily in apps on shared device. Users are able to use unique QR code provided by their admins and enter their PIN to sign in, eliminating the need to enter usernames and passwords.

You can use QR code web sign-in experience available at *login.microsoft.com*. This user entry point doesn't require any developer changes. Users select **Sign in options** > **Sign in to an organization** > **Sign in with a QR code**. You can optimize QR code sign-in experience by providing the entry point at your sign in page, eliminating two user clicks. To take advantage of QR code authentication method, app developers and [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference) work together:

- App developers integrate QR code authentication's optimized entry point in their app using the Microsoft Authentication Library (MSAL) for iOS and macOS.
- Authentication Policy Administrator configures the [authentication method](/entra/identity/authentication/how-to-authentication-qr-code) in Microsoft Entra ID.

## Configure your app to use QR code authentication

To configure your app to use QR code authentication, you can call the `getDeviceInformationWithParameters` API in MSAL to receive the `MSALDeviceInformation` object. In this object, a new flag is available to reflect the admin configured QR code authentication in the single sign-on (SSO) extension configuration. The following code snippet shows how to retrieve the preferred authentication method:

```objectivec

@property (nonatomic, readonly) MSALPreferredAuthMethod configuredPreferredAuthMethod; 

```

`MSALPreferredAuthMethod` is an enumeration that describes the different authentication methods available. The `configuredPreferredAuthMethod` property allows you to retrieve the preferred authentication method for the application. Currently, QR code is private enum value of 1. When released to general availability (GA), it's `MSALPreferredAuthMethodQRPIN`.

`MSALInteractiveTokenParameters` also define a new, optional parameter of type `MSALPreferredAuthMethod: preferredAuthMethod`. When this parameter is set for QR code authentication, the resulting interactive sign-in UI takes the user directly to the QR code authentication entry page. The following code snippet shows how to configure your app to use QR code authentication:



```objectivec
MSALWebviewParameters *webParameters = [[MSALWebviewParameters alloc] initWithAuthPresentationViewController:viewController]; 

     

MSALInteractiveTokenParameters *interactiveParams = [[MSALInteractiveTokenParameters alloc] initWithScopes:scopes webviewParameters:webParameters]; 

 

interactiveParams.preferredAuthMethod = 1; //Currently need to use the private enum value 

 

[application acquireTokenWithParameters:interactiveParams completionBlock:^(MSALResult *result, NSError *error) { 

    // When token acquisition completes 

}]; 

```

This code snippet configures and acquires a token using the MSAL in an iOS app, focusing on QR code authentication. It initializes `MSALWebviewParameters` with a view controller for the authentication web view and creates `MSALInteractiveTokenParameters` with the required scopes and web parameters. The preferred authentication method is set to QR code authentication. 

Finally, it calls `acquireTokenWithParameters` on the `MultipleAccountPublicClientApplication` instance, using the configured parameters and a completion block to handle the result. This setup ensures the authentication flow uses the QR code authentication method for secure and convenient user authentication.

It's advised to call the `getDeviceInformationWithParameters` API in MSAL to find out if the admin has configured QR code authentication method. If it has, an app can update its UI to indicate that QR code authentication method is available as a sign-in option.

## Suppress camera consent prompt

By default, QR code authentication prompts users for camera permission every time they need to use the camera to scan a QR code. 

:::image type="content" border="true" source="./media/ios-qr-code-pin-authentication/allow-camera.png" alt-text="Screenshot of a how to allow camera access on iOS.":::

Administrators can suppress this behavior and skip the request for camera permission. The request is configured by setting the following SSO extension configuration:

**Key**: suppress_camera_consent
**Type**: Integer 
**Value**: 1 or 0. This value is set to 0 by default.

The location is the same as where you can configure preferred_auth_method. For more information about SSO extension configuration, see [More configuration options for Microsoft Enterprise SSO plug-in for Apple devices](/entra/identity-platform/apple-sso-plugin#more-configuration-options).

>[!NOTE] 
>The camera consent prompt shows one time because of operating system requirements.

## Related content

- [Set up QR code authentication in Android app](android-qr-code-pin-authentication.md)
- [Authentication methods in Microsoft Entra ID - QR code authentication method](/entra/identity/authentication/how-to-authentication-qr-code)

---
title: Set up QR Code and PIN Authentication in iOS App
description: Learn how to configure your iOS app to use QR code and PIN authentication using the Microsoft Authentication Library for iOS and macOS.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.service: msal
ms.subservice: msal-ios-mac
ms.topic: concept-article
ms.date: 02/05/2025
ms.reviewer: amgusain, akgoel, dmwendia

#Customer intent: As a developer, I want to learn how to configure your iOS app to use QR code and PIN authentication using the Microsoft Authentication Library for iOS and macOS.
---

# Set up QR code authentication in iOS app

QR code authentication method enables frontline workers to sign in quickly and easily in apps on shared device. Users are able to use unique QR code provided by their admins and enter their PIN to sign in, eliminating the need to enter usernames and passwords.

To take advantage of QR code and PIN authentication method, app developers and [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference) work together:

- App developers integrate the QR code and PIN authentication method in their app using the Microsoft Authentication Library for iOS and macOS.
- Authentication Policy Administrator configures the [authentication method](/entra/identity/authentication/how-to-authentication-qr-code) in Microsoft Entra ID.

## Configure your app to use QR code authentication

To configure your app to use QR code authentication, you can call the `getDeviceInformationWithParameters` API in MSAL to receive the `MSALDeviceInformation` object. In this object, a new flag will be available to reflect the admin configured QR code and PIN in the single sign-on (SSO) extension configuration. The following code snippet shows how to retrieve the preferred authentication method:

```objectivec

@property (nonatomic, readonly) MSALPreferredAuthMethod configuredPreferredAuthMethod; 

```

`MSALPreferredAuthMethod` is an enumeration that describes the different authentication methods available. The `configuredPreferredAuthMethod` property allows you to retrieve the preferred authentication method that has been set for the application. Currently QR code and PIN is a private enum value of 1. When released to general availability (GA), it will be `MSALPreferredAuthMethodQRPIN`.

`MSALInteractiveTokenParameters` will also define a new, optional parameter of type `MSALPreferredAuthMethod: preferredAuthMethod`. When this parameter is set for QR code and PIN, the resulting interactive sign-in UI will take the user directly to the QR code and PIN entry page. The following code snippet shows how to configure your app to use QR code authentication:



```objectivec
MSALWebviewParameters *webParameters = [[MSALWebviewParameters alloc] initWithAuthPresentationViewController:viewController]; 

     

MSALInteractiveTokenParameters *interactiveParams = [[MSALInteractiveTokenParameters alloc] initWithScopes:scopes webviewParameters:webParameters]; 

 

interactiveParams.preferredAuthMethod = 1; //Currently need to use the private enum value 

 

[application acquireTokenWithParameters:interactiveParams completionBlock:^(MSALResult *result, NSError *error) { 

    // When token acquisition completes 

}]; 

```

This code snippet configures and acquires a token using the Microsoft Authentication Library (MSAL) in an iOS app, focusing on QR code and PIN authentication. It initializes `MSALWebviewParameters` with a view controller for the authentication web view and creates `MSALInteractiveTokenParameters` with the required scopes and web parameters. The preferred authentication method is set to QR code and PIN. 

Finally, it calls `acquireTokenWithParameters` on the `MultipleAccountPublicClientApplication` instance, using the configured parameters and a completion block to handle the result. This setup ensures the authentication flow uses the QR code and PIN method for secure and convenient user authentication.

It is advised to call the `getDeviceInformationWithParameters` API in MSAL to find out if the admin has configured QR code and PIN method. If it has, an app can update its UI to indicate that QR code and PIN method is available as a sign-in option.

## Related content

- [Set up QR code authentication in Android app](msal-android-qr-code-pin-authentication.md)
- [Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)](/entra/identity/authentication/how-to-authentication-qr-code)

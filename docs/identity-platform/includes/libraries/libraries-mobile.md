---
author: henrymbuguakiarie
ms.service: identity-platform
ms.topic: include
ms.date: 09/25/2023
ms.author: henrymbugua
manager: CelesteDG 
---


| Platform          | Project on<br/>GitHub                                                                          | Package                                                                               | Getting<br/>started                    | Sign in users                                         | Access web APIs                                                 | Generally available (GA) *or*<br/>Public preview<sup>1</sup> |
|-------------------|------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|:--------------------------------------:|:-----------------------------------------------------:|:---------------------------------------------------------------:|:------------------------------------------------------------:|
| Android (Java)    | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android)        | [MSAL](https://mvnrepository.com/artifact/com.microsoft.identity.client/msal)         | [Quickstart](../../quickstart-mobile-app-android-sign-in.md) | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] | GA                                                           |
| Android (Kotlin)  | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android)        | [MSAL](https://mvnrepository.com/artifact/com.microsoft.identity.client/msal)         | —                                      | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] | GA                                                           |
| iOS (Swift/Obj-C) | [MSAL for iOS and macOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) | [MSAL](https://cocoapods.org/pods/MSAL)                                               | [Tutorial](../../tutorial-v2-ios.md)         | ![Library can request ID tokens for user sign-in.][y] | ![Library can request access tokens for protected web APIs.][y] | GA |
<!--
| React Native |[React Native App Auth](https://github.com/FormidableLabs/react-native-app-auth/blob/main/docs/config-examples/azure-active-directory.md) | [react-native-app-auth](https://www.npmjs.com/package/react-native-app-auth) | ![X indicating no.][n] | ![Green check mark.][y] | ![Green check mark.][y] | -- |
-->

<sup>1</sup> [Universal License Terms for Online Services][preview-tos] apply to libraries in *Public preview*.

<!--Image references-->

[y]: ~/identity-platform/media/common/yes.png
[n]: ~/identity-platform/media/common/no.png

<!--Reference-style links -->

[preview-tos]: https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all

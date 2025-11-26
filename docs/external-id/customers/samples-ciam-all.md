---
title: Samples and guides for integrating apps with External ID
description: Learn how to build and integrate apps with external tenants with scenarios such as sign-up, sign in, and getting an access token to call an API.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: sample
ms.date: 03/11/2025
ms.custom: it-pro, seo-july-2024

---

# Samples and guides for integrating apps with External ID

Microsoft maintains code samples that demonstrate how to integrate various application types with Microsoft Entra External ID. We provide instructions for downloading and using samples or building your own app based on common authentication and authorization scenarios, development languages, and platforms. Included are instructions for building the project (if applicable) and running the sample application. Within the sample code, comments help you understand how these libraries are used in the application to perform authentication and authorization in an external tenant.

## Samples and guides

Use the tabs to sort samples either by app type or your preferred language or platform.

# [**By app type**](#tab/apptype)

### Single-page application (SPA)

These samples and how-to guides demonstrate how to integrate a single-page application with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | JavaScript | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=javascript-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-javascript-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |
> | Angular | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=angular-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-apps-angular-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |
> | React | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=react-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-react-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### Web app

These samples and how-to guides demonstrate how to write a web application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Node.js (Express) | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-web-app-node-sign-in-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)  |  &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-node-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-prepare-tenant.md)  |
> | ASP.NET Core | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external)   | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-dotnet-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)   |
> | Python Django | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-django-external)   | --- |
> | Python Flask | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-flask-external)   | --- |

### Web API

These samples and how-to guides demonstrate how to protect a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | ASP.NET Core | ---  | &#8226; [Secure an ASP.NET web API](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)   |

### Desktop

These samples and how-to guides demonstrate how to write a desktop application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Electron | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-js-external) | ---   |
> | ASP.NET (MAUI) | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-maui-external) |&#8226; [Sign in users](/entra/identity-platform/tutorial-desktop-app-maui-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|
> | .NET (MAUI) WPF | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-wpf-external) | ---   |

### Mobile: Browser delegated authentication

These samples and how-to guides show you how to write a public client mobile application with browser-delegated authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | ASP.NET Core MAUI | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-netmaui-external) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)|
> | Android (Kotlin) | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-mobile-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-external) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> | iOS (Swift) | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=ios-macos-external)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](/entra/identity-platform/tutorial-mobile-app-ios-swift-prepare-tenant?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external) |


### Desktop: Native authentication

These samples and how-to guides demonstrate how to write a desktop application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> macOS (Swift) | &#8226; [Sign in users](/entra/identity-platform/quickstart-native-authentication-macos-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)| &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-ios-macos-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|

### Mobile: Native authentication

These samples and how-to guides demonstrate how to write a public client mobile application with native authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> |Android (Kotlin) | &#8226; [Sign in users](/entra/identity-platform/quickstart-native-authentication-android-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-native-authentication-android-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-android-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|
> |iOS (Swift) | &#8226; [Sign in users](/entra/identity-platform/quickstart-native-authentication-ios-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-native-authentication-ios-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-ios-macos-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|


### Daemon

These samples and how-to guides demonstrate how to write a daemon application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | Node.js | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external) |  &#8226; [Call an API](/entra/identity-platform/tutorial-daemon-node-call-api-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external)  |
> | .NET |  &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external)  |  &#8226; [Call an API](/entra/identity-platform/tutorial-dotnet-daemon-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)  |


# [**By language/platform**](#tab/language)

### .NET

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Daemon |  &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external)  | &#8226; [Call an API](/entra/identity-platform/tutorial-dotnet-daemon-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)   |

### Android (Kotlin)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> |Mobile: Browser delegated authentication | &#8226; [Sign in users](sample-mobile-app-android-kotlin-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-android-kotlin-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> |Mobile: Native authentication | &#8226; [Sign in users](/entra/identity-platform/quickstart-native-authentication-android-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-native-authentication-android-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-android-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|

### ASP.NET Core

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | Web API| ---  | &#8226; [Secure an ASP.NET web API](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)   |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external)   | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-dotnet-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)   |

### .NET (MAUI)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-maui-external) |&#8226; [Sign in users](/entra/identity-platform/tutorial-desktop-app-maui-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)  |
> | Mobile: Browser delegated authentication |  &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-netmaui-external) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)   |

### Python, Django

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-django-external) | ---   |

### Python, Flask

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-flask-external) | ---   |

### iOS/macOS (Swift)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | Mobile: Browser delegated authentication | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=ios-macos-external)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](/entra/identity-platform/tutorial-mobile-app-ios-swift-prepare-tenant?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external) |
> |Mobile: Native authentication | &#8226; iOS (Swift)  [Sign in users](/entra/identity-platform/quickstart-native-authentication-ios-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-native-authentication-ios-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-ios-macos-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|
> |Desktop: Native authentication | &#8226; macOS (Swift) [Sign in users](/entra/identity-platform/quickstart-native-authentication-macos-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)| &#8226; [Sign in users](/entra/identity-platform/tutorial-native-authentication-prepare-ios-macos-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)|

### JavaScript

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=javascript-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-javascript-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### JavaScript, Angular

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=angular-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-apps-angular-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### JavaScript, React

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application| &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=react-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-react-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### JavaScript, Node

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Daemon | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external) |  &#8226; [Call an API](/entra/identity-platform/tutorial-daemon-node-call-api-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) |


### JavaScript, Node.js (Express)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app |&#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-web-app-node-sign-in-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)  |  &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-node-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-prepare-tenant.md)  |

### JavaScript, Electron

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-js-external) | ---   |

---
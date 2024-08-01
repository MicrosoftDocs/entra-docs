---
title: Code samples for external tenants
description: Find code samples for applications you can run in an external tenant. Find samples by app type or language.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 05/20/2024
ms.author: mimart
ms.custom: it-pro

---

# Samples for External ID developers

Microsoft maintains code samples that demonstrate how to integrate various application types with Microsoft Entra External ID. We provide instructions for downloading and using samples or building your own app based on common authentication and authorization scenarios, development languages, and platforms. Included are instructions for building the project (if applicable) and running the sample application. Within the sample code, comments help you understand how these libraries are used in the application to perform authentication and authorization in an external tenant.

## Samples and guides

Use the tabs to sort samples either by app type or your preferred language or platform.

# [**By app type**](#tab/apptype)

### Single-page application (SPA)

These samples and how-to guides demonstrate how to integrate a single-page application with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | JavaScript, Vanilla | &#8226; [Sign in users](./sample-single-page-app-vanillajs-sign-in.md) | &#8226; [Sign in users](tutorial-single-page-app-vanillajs-prepare-tenant.md) |
> | JavaScript, Angular | &#8226; [Sign in users](./sample-single-page-app-angular-sign-in.md) |  ---  |
> | JavaScript, React | &#8226; [Sign in users](./sample-single-page-app-react-sign-in.md) | &#8226; [Sign in users](./tutorial-single-page-app-react-sign-in-prepare-tenant.md)   |

### Web app

These samples and how-to guides demonstrate how to write a web application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Node.js (Express) | &#8226; [Sign in users](./sample-web-app-node-sign-in.md)<br/> &#8226; [Sign in users and call an API](./sample-web-app-node-sign-in-call-api.md)  |  &#8226; [Sign in users](tutorial-web-app-node-sign-in-prepare-tenant.md)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-overview.md)  |
> | ASP.NET Core | &#8226; [Sign in users](./sample-web-app-dotnet-sign-in.md)   | &#8226; [Sign in users](tutorial-web-app-dotnet-sign-in-prepare-tenant.md)   |
> | Python Django | &#8226; [Sign in users](./sample-web-app-python-django-sign-in.md)   | --- |
> | Python Flask | &#8226; [Sign in users](./sample-web-app-python-flask-sign-in.md)   | --- |

### Web API

These samples and how-to guides demonstrate how to protect a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | ASP.NET Core | ---  | &#8226; [Secure an ASP.NET web API](tutorial-protect-web-api-dotnet-core-build-app.md)   |

### Desktop

These samples and how-to guides demonstrate how to write a desktop application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Electron | &#8226; [Sign in users](how-to-desktop-app-electron-sample-sign-in.md) | ---   |
> | ASP.NET (MAUI) | &#8226; [Sign in users](how-to-desktop-app-maui-sample-sign-in.md) |&#8226; [Sign in users](tutorial-desktop-app-maui-sign-in-prepare-tenant.md)|

### Desktop: Native Authentication

These samples and how-to guides demonstrate how to write a public client desktop application with native authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> macOS (Swift) | &#8226; [Sign in users](sample-mobile-app-macos-swift-sign-in.md)| &#8226; [Sign in users, call an API](tutorial-app-ios-macos-swift-prepare-tenant.md) |

### Mobile: Browser delegated authentication

These samples and how-to guides demonstrate how to write a public client mobile application with browser delegated authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | ASP.NET Core MAUI | &#8226; [Sign in users](how-to-mobile-app-maui-sample-sign-in.md) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)|
> | Android (Kotlin) | &#8226; [Sign in users](sample-mobile-app-android-kotlin-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-android-kotlin-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> | iOS (Swift) | &#8226; [Sign in users](sample-mobile-app-ios-swift-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-ios-swift-prepare-tenant.md) |


### Mobile: Native authentication

These samples and how-to guides demonstrate how to write a public client mobile application with native authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> |Android (Kotlin) | &#8226; [Sign in users](how-to-run-native-authentication-sample-android-app.md)<br/> &#8226; [Sign in users and call an API](sample-native-authentication-android-sample-app-call-web-api.md) | &#8226; [Sign in users](tutorial-native-authentication-prepare-android-app.md)|
> |iOS (Swift) | &#8226; [Sign in users](how-to-run-native-authentication-sample-ios-app.md)<br/> &#8226; [Sign in users and call an API](sample-native-authentication-ios-sample-app-call-web-api.md) | &#8226; [Sign in users](tutorial-native-authentication-prepare-ios-app.md)|

### Daemon

These samples and how-to guides demonstrate how to write a daemon application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | Node.js | &#8226; [Call an API](./sample-daemon-node-call-api.md) |  &#8226; [Call an API](tutorial-daemon-node-call-api-prepare-tenant.md)  |
> | .NET |  &#8226; [Call an API](sample-daemon-dotnet-call-api.md)  |  &#8226; [Call an API](tutorial-daemon-dotnet-call-api-prepare-tenant.md)  |


# [**By language/platform**](#tab/language)

### .NET

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Daemon |  &#8226; [Call an API](sample-daemon-dotnet-call-api.md)  | &#8226; [Call an API](tutorial-daemon-dotnet-call-api-prepare-tenant.md)   |

### Android (Kotlin)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> |Mobile: Browser delegated authentication | &#8226; [Sign in users](sample-mobile-app-android-kotlin-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-android-kotlin-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> |Mobile: Native authentication | &#8226; [Sign in users](how-to-run-native-authentication-sample-android-app.md)<br/> &#8226; [Sign in users and call an API](sample-native-authentication-android-sample-app-call-web-api.md) | &#8226; [Sign in users](tutorial-native-authentication-prepare-android-app.md)|

### ASP.NET Core

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | Web API| ---  | &#8226; [Secure an ASP.NET web API](tutorial-protect-web-api-dotnet-core-build-app.md)   |
> | Web app | &#8226; [Sign in users](sample-web-app-dotnet-sign-in.md)   | &#8226; [Sign in users](tutorial-web-app-dotnet-sign-in-prepare-tenant.md)   |

### .NET (MAUI)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](how-to-desktop-app-maui-sample-sign-in.md) | &#8226; [Sign in users](tutorial-desktop-app-maui-sign-in-prepare-tenant.md)   |
> | Mobile: Browser delegated authentication |  &#8226; [Sign in users](how-to-mobile-app-maui-sample-sign-in.md) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)   |

### Python, Django

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](./sample-web-app-python-django-sign-in.md) | ---   |

### Python, Flask

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](./sample-web-app-python-flask-sign-in.md) | ---   |

### iOS (Swift)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | Mobile: Browser delegated authentication | &#8226; [Sign in users](sample-mobile-app-ios-swift-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-ios-swift-prepare-tenant.md) |
> |Mobile: Native authentication | &#8226; [Sign in users](how-to-run-native-authentication-sample-ios-app.md)<br/> &#8226; [Sign in users and call an API](sample-native-authentication-ios-sample-app-call-web-api.md) | &#8226; [Sign in users](tutorial-native-authentication-prepare-ios-app.md)|

### JavaScript, Vanilla

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](./sample-single-page-app-vanillajs-sign-in.md) | &#8226; [Sign in users](tutorial-single-page-app-vanillajs-prepare-tenant.md) |

### JavaScript, Angular

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](./sample-single-page-app-angular-sign-in.md) |  ---  |

### JavaScript, React

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Single-page application| &#8226; [Sign in users](./sample-single-page-app-react-sign-in.md) | &#8226; [Sign in users](./tutorial-single-page-app-react-sign-in-prepare-tenant.md)   |

### JavaScript, Node

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Daemon | &#8226; [Call an API](./sample-daemon-node-call-api.md) |  &#8226; [Call an API](./tutorial-daemon-node-call-api-prepare-tenant.md)  |


### JavaScript, Node.js (Express)

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Web app |&#8226; [Sign in users](./sample-web-app-node-sign-in.md)<br/> &#8226; [Sign in users and call an API](./sample-web-app-node-sign-in-call-api.md)  | &#8226; [Sign in users](tutorial-web-app-node-sign-in-prepare-tenant.md)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-overview.md)   |

### JavaScript, Electron

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](how-to-desktop-app-electron-sample-sign-in.md) | ---   |

---

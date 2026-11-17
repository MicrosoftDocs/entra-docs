---
title: Microsoft Entra External ID app samples and guides
description: Learn how to build and integrate apps with Microsoft Entra External ID for scenarios such as sign-up, sign-in, and getting an access token to call an API.
ms.topic: sample
ms.date: 11/13/2026
ms.custom: it-pro, seo-july-2024, msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an application developer, I want to find samples and guides for Microsoft Entra External ID so that I can integrate authentication into my apps.
---

# Microsoft Entra External ID app samples and guides

Use these samples and guides to integrate authentication and authorization with Microsoft Entra External ID. Choose by app type, language, or platform. Each guide explains how to build and run a sample or develop your own app, with code comments that explain the integration.

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

[!INCLUDE [covers-authentication-samples](../includes/covers-authentication-samples.md)]

For Embedded native authentication, start with the [quickstart](~/identity-platform/quickstart-native-authentication.md) and [application configuration guide](~/identity-platform/how-to-native-authentication-configure-app.md). For an existing integration, review [SDK compatibility and migration requirements](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility).

## Embedded native authentication

Use the following onboarding guidance for the Microsoft Authentication Library (MSAL) interfaces. Check the [SDK compatibility table](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility) for the documented package versions and supported continuation interfaces. For direct HTTP integration, use the [Native Authentication API reference](~/identity-platform/reference-native-authentication.md).

| Platform | SDK | Guidance |
| --- | --- | --- |
| **JavaScript and TypeScript** | `@azure/msal-browser`. | [React Next.js quickstart](~/identity-platform/quickstart-native-authentication.md) and [browser CORS requirements](~/identity-platform/concept-native-authentication-cors.md#proxy-contract). |
| **Android** | `com.microsoft.identity.client:msal`. | [Android sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/tree/adacfe21414333128300c722c9031d4663938d7c) and [Android SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#android-migration). |
| **Apple** | MSAL for iOS and macOS. | [iOS sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/tree/85ef82afd59572ade876011bad516fd631761dd4) and [Apple SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#ios-migration). |

Existing V1 integrations can use the [V1 API reference and SDK library links](~/identity-platform/reference-native-authentication-api-v1.md). The passkey samples are separate credential-management integrations, not passkey sign-in through the Native Authentication API.

CORS and proxy guidance applies to cross-origin browser API calls from SPAs with Embedded native authentication and BYO UX websites. Android and iOS apps using native HTTP transports don't need a CORS proxy.

## Samples and guides

Use the tabs to sort samples either by app type or your preferred language or platform.

These tables list examples, not overall feature support. A missing sample doesn't mean a feature is unsupported. Check the [authentication support matrix](concept-supported-features-customers.md#authentication-approach-supportability) for availability.

# [**By app type**](#tab/apptype)

### Single-page application (SPA)

These samples and how-to guides demonstrate how to integrate a single-page application with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | JavaScript | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=javascript-external)<br/> &#8226; [List, register, and delete passkeys (GitHub sample)](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/main/passkey-sample) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-javascript-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)<br/> &#8226; [Sign in with passkeys](how-to-sign-in-with-passkey.md) |
> | Angular | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=angular-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-apps-angular-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |
> | React | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=react-external)<br/> &#8226; [List, register, and delete passkeys (GitHub sample)](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/main/passkey-sample) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-react-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)<br/> &#8226; [Sign in with passkeys](how-to-sign-in-with-passkey.md) |

### Web app

These samples and how-to guides demonstrate how to write a web application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- | 
> | JavaScript, Node.js (Express) | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-web-app-node-sign-in-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-node-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-prepare-tenant.md) |
> | ASP.NET Core | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-dotnet-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |
> | Python Django | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-django-external) | --- |
> | Python Flask | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-flask-external) | --- |

### Web API

These samples and how-to guides demonstrate how to protect a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | ASP.NET Core | --- | &#8226; [Secure an ASP.NET web API](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |

### Desktop

These samples and how-to guides demonstrate how to write a desktop application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- | 
> | JavaScript, Electron | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-js-external) | --- |
> | ASP.NET (MAUI) | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-maui-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-desktop-app-maui-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |
> | .NET (MAUI) WPF | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-wpf-external) | --- |

<a name="mobile-browser-delegated-authentication"></a>

### Mobile: Microsoft-hosted authentication

These samples and how-to guides show you how to write a public client mobile application with browser-delegated authentication that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- | ----------- |
> | ASP.NET Core MAUI | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-netmaui-external) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md) |
> | Android (Kotlin) | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-mobile-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-external) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> | iOS (Swift) | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=ios-macos-external)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](/entra/identity-platform/tutorial-mobile-app-ios-swift-prepare-tenant?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external) |


<a name="desktop-native-authentication"></a>

### Desktop: Embedded native authentication

For macOS, use the [MSAL iOS/macOS SDK reference](https://azuread.github.io/microsoft-authentication-library-for-objc/) and [Apple SDK compatibility and migration guidance](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#ios-migration).

<a name="mobile-native-authentication"></a>

### Mobile: Embedded native authentication

Use these samples with the [onboarding guidance](#embedded-native-authentication) for the response-driven integration.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- | ----------- |
> | Android (Kotlin) | &#8226; [Android sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/tree/adacfe21414333128300c722c9031d4663938d7c) | &#8226; [SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#android-migration) |
> | iOS (Swift) | &#8226; [iOS sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/tree/85ef82afd59572ade876011bad516fd631761dd4) | &#8226; [SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#ios-migration) |


### Daemon

These samples and how-to guides demonstrate how to write a daemon application that integrates with Microsoft Entra External ID.

> [!div class="mx-tdCol2BreakAll"]
>
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- | ----------- |
> | Node.js | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external) | &#8226; [Call an API](/entra/identity-platform/tutorial-daemon-node-call-api-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) |
> | .NET | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) | &#8226; [Call an API](/entra/identity-platform/tutorial-dotnet-daemon-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |


# [**By language/platform**](#tab/language)

### .NET

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Daemon | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) | &#8226; [Call an API](/entra/identity-platform/tutorial-dotnet-daemon-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |

### Android (Kotlin)

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- | ----------- |
> | Mobile: Microsoft-hosted authentication | &#8226; [Sign in users](sample-mobile-app-android-kotlin-sign-in.md)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-android-kotlin-sign-in-call-api.md) | &#8226; [Sign in users, call an API](tutorial-mobile-app-android-kotlin-prepare-tenant.md) |
> | Mobile: Embedded native authentication | &#8226; [Android sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-android-sample/tree/adacfe21414333128300c722c9031d4663938d7c) | &#8226; [SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#android-migration) |

### ASP.NET Core

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- | 
> | Web API | --- | &#8226; [Secure an ASP.NET web API](/entra/identity-platform/tutorial-web-api-dotnet-core-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-dotnet-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### .NET (MAUI)

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=wpfdotnet-maui-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-desktop-app-maui-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) |
> | Mobile: Microsoft-hosted authentication | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=android-netmaui-external) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md) |

### Python, Django

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-django-external) | --- |

### Python, Flask

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=python-flask-external) | --- |

### iOS/macOS (Swift)

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ----------- | ----------- | ----------- |
> | Mobile: Microsoft-hosted authentication | &#8226; [Sign in users](/entra/identity-platform/quickstart-mobile-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=ios-macos-external)<br/> &#8226; [Sign in users and call an API](sample-mobile-app-ios-swift-sign-in-call-api.md) | &#8226; [Sign in users, call an API](/entra/identity-platform/tutorial-mobile-app-ios-swift-prepare-tenant?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external) |
> | Mobile: Embedded native authentication | &#8226; [iOS sample](https://github.com/Azure-Samples/ms-identity-ciam-native-auth-ios-sample/tree/85ef82afd59572ade876011bad516fd631761dd4) | &#8226; [SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#ios-migration) |
> | Desktop: Embedded native authentication | --- | &#8226; [MSAL iOS/macOS SDK reference](https://azuread.github.io/microsoft-authentication-library-for-objc/)<br/> &#8226; [SDK compatibility and migration](~/identity-platform/how-to-migrate-native-authentication-v1-v2.md#ios-migration) |

### JavaScript

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=javascript-external)<br/> &#8226; [List, register, and delete passkeys (GitHub sample)](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/main/passkey-sample) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-javascript-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)<br/> &#8226; [Sign in with passkeys](how-to-sign-in-with-passkey.md) |

### JavaScript, Angular

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=angular-external) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-apps-angular-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant) |

### JavaScript, React

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Single-page application | &#8226; [Sign in users](/entra/identity-platform/quickstart-single-page-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=react-external)<br/> &#8226; [List, register, and delete passkeys (GitHub sample)](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/main/passkey-sample) | &#8226; [Sign in users](/entra/identity-platform/tutorial-single-page-app-react-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&tabs=external-tenant)<br/> &#8226; [Sign in with passkeys](how-to-sign-in-with-passkey.md) |

### JavaScript, Node

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Daemon | &#8226; [Call an API](/entra/identity-platform/quickstart-daemon-app-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external) | &#8226; [Call an API](/entra/identity-platform/tutorial-daemon-node-call-api-build-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=asp-dot-net-core-external) |


### JavaScript, Node.js (Express)

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Web app | &#8226; [Sign in users](/entra/identity-platform/quickstart-web-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-external)<br/> &#8226; [Sign in users and call an API](/entra/identity-platform/quickstart-web-app-node-sign-in-call-api?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json) | &#8226; [Sign in users](/entra/identity-platform/tutorial-web-app-node-sign-in-prepare-app?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-prepare-tenant.md) |

### JavaScript, Electron

> [!div class="mx-tdCol2BreakAll"]
>
> | App type | Code sample guide | Build and integrate guide |
> | ------- | -------- | ------------- |
> | Desktop | &#8226; [Sign in users](/entra/identity-platform/quickstart-desktop-app-sign-in?toc=/entra/external-id/toc.json&bc=/entra/external-id/breadcrumb/toc.json&pivots=external&tabs=node-js-external) | --- |

---
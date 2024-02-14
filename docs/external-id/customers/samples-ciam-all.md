---
title: Code samples for customer tenants
description: Find code samples for applications you can run in a customer tenant. Find samples by app type or language.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: sample
ms.date: 08/17/2023
ms.author: mimart
ms.custom: it-pro

---

# Samples for customer identity and access management (CIAM) in Microsoft Entra External ID

Microsoft maintains code samples that demonstrate how to integrate various application types with Microsoft Entra ID for customers. We provide instructions for downloading and using samples or building your own app based on common authentication and authorization scenarios, development languages, and platforms. Included are instructions for building the project (if applicable) and running the sample application. Within the sample code, comments help you understand how these libraries are used in the application to perform authentication and authorization in a customer tenant.

## Samples and guides

Use the tabs to sort samples either by app type or your preferred language/platform.

# [**By app type**](#tab/apptype)

### Single-page application (SPA)

These samples and how-to guides demonstrate how to integrate a single-page application with Microsoft Entra ID for customers.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | JavaScript, Vanilla | &#8226; [Sign in users](./sample-single-page-app-vanillajs-sign-in.md) | &#8226; [Sign in users](tutorial-single-page-app-vanillajs-prepare-tenant.md) |
> | JavaScript, Angular | &#8226; [Sign in users](./sample-single-page-app-angular-sign-in.md) |  ---  |
> | JavaScript, React | &#8226; [Sign in users](./sample-single-page-app-react-sign-in.md) | &#8226; [Sign in users](./tutorial-single-page-app-react-sign-in-prepare-tenant.md)   |

### Web app

These samples and how-to guides demonstrate how to write a web application that integrates with Microsoft Entra ID for customers.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Node.js (Express) | &#8226; [Sign in users](./sample-web-app-node-sign-in.md)<br/> &#8226; [Sign in users and call an API](./sample-web-app-node-sign-in-call-api.md)  |  &#8226; [Sign in users](tutorial-web-app-node-sign-in-prepare-tenant.md)<br/> &#8226; [Sign in users and call an API](how-to-web-app-node-sign-in-call-api-overview.md)  |
> | ASP.NET Core | &#8226; [Sign in users](./sample-web-app-dotnet-sign-in.md)   | &#8226; [Sign in users](tutorial-web-app-dotnet-sign-in-prepare-tenant.md)   |
> | Python | &#8226; [Sign in users](./sample-web-app-python-sign-in.md)   | --- |

### Web API

These samples and how-to guides demonstrate how to protect a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- |
> | ASP.NET Core | ---  | &#8226; [Secure an ASP.NET web API](tutorial-protect-web-api-dotnet-core-build-app.md)   |

###  Browserless

These samples and how-to guides demonstrate how to write a browserless application that integrates with Microsoft Entra ID for customers.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Node | &#8226; [Sign in users](./sample-browserless-app-node-sign-in.md)   | &#8226; [Sign in users](how-to-browserless-app-node-sign-in-overview.md)   |
> | .NET | &#8226; [Sign in users](./sample-browserless-app-dotnet-sign-in.md)  | &#8226; [Sign in users](./tutorial-browserless-app-dotnet-sign-in-prepare-tenant.md)   |


### Desktop

These samples and how-to guides demonstrate how to write a desktop application that integrates with Microsoft Entra ID for customers.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide  |
> | ------- | -------- | ------------- | 
> | JavaScript, Electron | &#8226; [Sign in users](how-to-desktop-app-electron-sample-sign-in.md) | ---   |
> | ASP.NET (MAUI) | &#8226; [Sign in users](how-to-desktop-app-maui-sample-sign-in.md) |&#8226; [Sign in users](tutorial-desktop-app-maui-sign-in-prepare-tenant.md)|

### Mobile

These samples and how-to guides demonstrate how to write a public client mobile application that integrates with Microsoft Entra ID for customers.

> [!div class="mx-tdCol2BreakAll"]
> | Language/<br/>Platform | Code sample guide | Build and integrate guide |
> | ----------- | ----------- |----------- |
> | ASP.NET Core MAUI | &#8226; [Sign in users](how-to-mobile-app-maui-sample-sign-in.md) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)|

### Daemon

These samples and how-to guides demonstrate how to write a daemon application that integrates with Microsoft Entra ID for customers.

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
> | Browserless | &#8226; [Sign in users](./sample-browserless-app-dotnet-sign-in.md)  | &#8226; [Sign in users](./tutorial-browserless-app-dotnet-sign-in-prepare-tenant.md)   |
> | Daemon |  &#8226; [Call an API](sample-daemon-dotnet-call-api.md)  | &#8226; [Call an API](tutorial-daemon-dotnet-call-api-prepare-tenant.md)   |


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
> | Mobile |  &#8226; [Sign in users](how-to-mobile-app-maui-sample-sign-in.md) | &#8226; [Sign in users](tutorial-mobile-app-maui-sign-in-prepare-tenant.md)   |


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
> | Browserless | &#8226; [Sign in users](./sample-browserless-app-node-sign-in.md)   | &#8226; [Sign in users](how-to-browserless-app-node-sign-in-overview.md)   |
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

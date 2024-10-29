---
title: Code samples for Microsoft identity platform authentication and authorization
description: An index of Microsoft-maintained code samples demonstrating authentication and authorization in several application types, development languages, and frameworks.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 10/15/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: sample
#Customer intent: As a developer working with the Microsoft identity platform, I want to access code samples that demonstrate how to implement authentication and authorization scenarios in different application types and languages, so that I can understand how to integrate the Microsoft identity platform into my own applications.
---

# Microsoft identity platform code samples

These code samples are built and maintained by Microsoft to demonstrate usage of our authentication libraries with the Microsoft identity platform. Common authentication and authorization scenarios are implemented in several [application types](v2-app-types.md), development languages, and frameworks.

- Sign in users to web applications and provide authorized access to protected web APIs.
- Protect a web API by requiring an access token to perform API operations.

Each code sample includes a *README.md* file describing how to build the project (if applicable) and run the sample application. Comments in the code help you understand how these libraries are used in the application to perform authentication and authorization by using the identity platform.

## Samples and guides

Use the tabs to sort the samples by application type, or your preferred language/framework. 

# [**By app type**](#tab/apptype)

### Single-page applications

These samples show how to write a single-page application secured with Microsoft identity platform. These samples use one of the flavors of MSAL.js.

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | React | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/react-spa) | [MSAL React](/javascript/api/@azure/msal-react) |  Authorization code with PKCE | [Quickstart](quickstart-single-page-app-react-sign-in.md) | [Tutorial](tutorial-single-page-app-react-register-app.md) |
> | Angular | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/angular-spa) | [MSAL Angular](/javascript/api/@azure/msal-angular) | Authorization code with PKCE | [Quickstart](quickstart-single-page-app-angular-sign-in.md) | [Tutorial](tutorial-v2-angular-auth-code.md) |
> | JavaScript | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/vanillajs-spa) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/2-Authorization-I/1-call-graph/README.md)<br/>&#8226; [Call Node.js web API](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/3-Authorization-II/1-call-api/README.md) <br/>&#8226; [Deploy to Azure Storage and App Service](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/4-Deployment/README.md) | [MSAL.js](/javascript/api/overview/msal-overview) | Authorization code with PKCE | [Quickstart](quickstart-single-page-app-javascript-sign-in.md) | |
> | Blazor WebAssembly | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/spa-blazor-wasm) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-blazor-wasm/blob/main/WebApp-graph-user/Call-MSGraph/README.md)<br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-blazor-wasm/blob/main/Deploy-to-Azure/README.md) | [MSAL.js](/javascript/api/overview/msal-overview) | Authorization code with PKCE | [Quickstart](quickstart-single-page-app-blazor-wasm-sign-in.md)|  |

### Web applications

The following samples illustrate web applications that sign in users. Some samples also demonstrate the application calling Microsoft Graph, or your own web API with the user's identity.

| Language / Platform | Code sample(s) on GitHub | Auth libraries | Auth flow | Quickstart | Tutorial |
| ------------------- | ------------------------ | -------------- | --------- | ---------- | -------- |
| ASP.NET | &#8226; [Microsoft Graph Training Sample](https://github.com/microsoftgraph/msgraph-training-aspnetmvcapp) <br/> &#8226; [Sign in users and call Microsoft Graph with admin restricted scope](https://github.com/azure-samples/active-directory-dotnet-admin-restricted-scopes-v2) | &#8226; [MSAL.NET](/entra/msal/dotnet) <br/>&#8226; [Microsoft.Identity.Web](/dotnet/api/microsoft-authentication-library-dotnet/confidentialclient) <br/>&#8226; [Advanced Token Cache Scenarios](https://github.com/Azure-Samples/ms-identity-dotnet-advanced-token-cache) | &#8226; OpenID connect <br/>&#8226; Authorization code <br/>&#8226; On-Behalf-Of (OBO) | [Quickstart](https://github.com/AzureAdQuickstarts/AppModelv2-WebApp-OpenIDConnect-DotNet)  | |
| ASP.NET Core | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/web-app-aspnet) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-1-Call-MSGraph/README.md) <br/>&#8226; [Customize token cache](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-2-TokenCache/README.md) <br/>&#8226; [Use the Conditional Access auth context to perform step-up authentication](https://github.com/Azure-Samples/ms-identity-dotnetcore-ca-auth-context-app/blob/main/README.md) <br/>&#8226; [Call Graph (multitenant)](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-3-Multi-Tenant/README.md) <br/>&#8226; [Call Azure REST APIs](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/3-WebApp-multi-APIs/README.md) <br/>&#8226; [Protect web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/4-WebApp-your-API/4-1-MyOrg/README.md) <br/>&#8226; [Protect multitenant web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/4-WebApp-your-API/4-3-AnyOrg/Readme.md) <br/>&#8226; [Use App Roles for access control](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/5-WebApp-AuthZ/5-1-Roles/README.md) <br/>&#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/5-WebApp-AuthZ/5-2-Groups/README.md) <br/>&#8226; [Deploy to Azure Storage and App Service](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/6-Deploy-to-Azure/README.md) <br/>&#8226; [Active Directory Federation Services to Microsoft Entra migration](https://github.com/Azure-Samples/ms-identity-dotnet-adfs-to-aad) | [Microsoft.Identity.Web](/dotnet/api/microsoft-authentication-library-dotnet/confidentialclient) | &#8226; OpenID connect <br/>&#8226; Authorization code <br/>&#8226; On-Behalf-Of Flow (OBO) | [Quickstart](quickstart-web-app-dotnet-core-sign-in.md)| [Tutorial](tutorial-web-app-dotnet-prepare-app.md) |
| Blazor | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/spa-blazor-wasm) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-blazor-server/tree/main/WebApp-graph-user/Call-MSGraph) <br/>&#8226; [Call web API](https://github.com/Azure-Samples/ms-identity-blazor-server/tree/main/WebApp-your-API/MyOrg) | [MSAL.NET](/entra/msal/dotnet) | Hybrid flow | | |
| Java Spring | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/1-Authentication/sign-in) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/2-Authorization-I/call-graph) <br/>&#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/roles) <br/>&#8226; [Use Groups for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/groups) <br/>&#8226; [Protect a web API](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/protect-web-api) <br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/4-Deployment/deploy-to-azure-app-service) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Authorization code | |[Tutorial](/azure/developer/java/spring-framework/configure-spring-boot-starter-java-app-with-azure-active-directory) |
| Java Servlets | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/1-Authentication/sign-in) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/2-Authorization-I/call-graph) <br/>&#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/3-Authorization-II/roles) <br/>&#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/3-Authorization-II/groups) <br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/4-Deployment/deploy-to-azure-app-service) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Authorization code |[Quickstart](quickstart-web-app-java-sign-in.md) | |
| Node.js Express | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/1-Authentication/1-sign-in/README.md) <br/>&#8226; [Express web application built with MSAL Node and Microsoft identity platform](https://github.com/Azure-Samples/ms-identity-node/blob/main/README.md) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/2-Authorization/1-call-graph/README.md) <br/>&#8226; [Call Microsoft Graph via BFF proxy](https://github.com/Azure-Samples/ms-identity-node) <br/>&#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/4-AccessControl/1-app-roles/README.md) <br/>&#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/4-AccessControl/2-security-groups/README.md) <br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/3-Deployment/README.md)  | [MSAL Node](/javascript/api/@azure/msal-node) | &#8226; Authorization code <br/>&#8226; Backend-for-Frontend (BFF) proxy | [Quickstart](quickstart-web-app-nodejs-sign-in.md)| [Tutorial](tutorial-v2-nodejs-webapp-msal.md) |
| Python Flask | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-python/tree/main/flask-web-app) <br/>&#8226; [Template to sign in Microsoft Entra ID, and optionally call a downstream API (Microsoft Graph)](https://github.com/Azure-Samples/ms-identity-python-webapp) <br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-python-flask-tutorial) | [MSAL Python](/entra/msal/python) | Authorization code | [Quickstart](quickstart-web-app-python-flask.md)| [Tutorial](tutorial-web-app-python-register-app.md) |
| Python Django | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-python/tree/main/django-web-app) | [MSAL Python](/entra/msal/python) | Authorization code | | |
| Ruby | &#8226; [Sign in users and call Microsoft Graph](https://github.com/microsoftgraph/msgraph-training-rubyrailsapp) | OmniAuth OAuth2 | Authorization code | | |

### Web API

The following samples show how to protect a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | ASP.NET | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-aspnet-webapi-onbehalfof) | [MSAL.NET](/entra/msal/dotnet) | On-Behalf-Of (OBO) | [Quickstart](quickstart-web-api-aspnet-protect-api.md) |  |
> | ASP.NET Core | &#8226; [Access control (protected routes) with the Microsoft identity platform](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/web-api) | [MSAL.NET](/entra/msal/dotnet) | On-Behalf-Of (OBO) | [Quickstart](quickstart-web-api-aspnet-core-protect-api.md) |[Tutorial](tutorial-web-api-dotnet-register-app.md) |
> | Java | &#8226; [Protect your Java Spring Boot web API with the Microsoft identity platform](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/protect-web-api) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | On-Behalf-Of (OBO) | | |
> | Node.js | &#8226; [Protect a Node.js web API](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/3-Authorization-II/1-call-api) | [MSAL Node](/javascript/api/@azure/msal-node) | Authorization bearer | | |

### Desktop

The following samples show public client desktop applications that access the Microsoft Graph API, or your own web API in the name of the user. Apart from the *Desktop (Console) with Web Authentication Manager (WAM)* sample, all these client applications use the Microsoft Authentication Library (MSAL).

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | .NET Core | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/1-Calling-MSGraph/1-1-AzureAD) <br/> &#8226; [Call Microsoft Graph with token cache](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/2-TokenCache) <br/> &#8226; [Call Microsoft Graph with custom web UI HTML](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/3-CustomWebUI/3-1-CustomHTML) <br/> &#8226; [Call Microsoft Graph with custom web browser](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/3-CustomWebUI/3-2-CustomBrowser) <br/> &#8226; [Sign in users with device code flow](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/4-DeviceCodeFlow) <br/>&#8226; [Call Microsoft Graph by signing in users using username/password](https://github.com/azure-samples/active-directory-dotnetcore-console-up-v2) <br/>&#8226; [Authenticate users with MSAL.NET in a WinUI desktop application](https://github.com/Azure-Samples/ms-identity-netcore-winui) | [MSAL.NET](/entra/msal/dotnet) |&#8226; Authorization code with PKCE <br/> &#8226; Device code <br/> &#8226; Resource owner password credentials | | |
> | Java | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/2-client-side/Integrated-Windows-Auth-Flow) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Integrated Windows authentication | | |
> | Node.js | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-desktop) | [MSAL Node](/javascript/api/@azure/msal-node) | Authorization code with PKCE |[Quickstart](quickstart-desktop-app-nodejs-electron-sign-in.md) | [Tutorial](tutorial-v2-nodejs-desktop.md) |
> | Python | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-python-desktop) | [MSAL Python](/entra/msal/python) | Resource owner password credentials |
> | Windows Presentation Foundation (WPF) | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-dotnet-native-aspnetcore-v2/tree/master/2.%20Web%20API%20now%20calls%20Microsoft%20Graph) <br/>&#8226; [Windows Presentation Foundation (WPF) user sign-in, protected web API access (Microsoft Graph)](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/desktop-wpf) <br/>&#8226; [Sign in users and call ASP.NET Core web API](https://github.com/Azure-Samples/active-directory-dotnet-native-aspnetcore-v2/tree/master/1.%20Desktop%20app%20calls%20Web%20API) <br/> &#8226; [Sign in users and call Microsoft Graph](https://github.com/azure-samples/active-directory-dotnet-desktop-msgraph-v2) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE | [Quickstart](quickstart-desktop-app-uwp-sign-in.md) | [Tutorial](quickstart-desktop-app-wpf-sign-in.md) |

### Mobile

The following samples show public client mobile applications that access the Microsoft Graph API. These client applications use the Microsoft Authentication Library (MSAL).

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | .NET Core | &#8226; [Call Microsoft Graph using MAUI](https://github.com/Azure-Samples/ms-identity-dotnetcore-maui/tree/main/MauiAppBasic) <br/> &#8226; [Call Microsoft Graph using MAUI with broker](https://github.com/Azure-Samples/ms-identity-dotnetcore-maui/tree/main/MauiAppWithBroker) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE | | |
> | iOS | &#8226; [Call Microsoft Graph native](https://github.com/Azure-Samples/ms-identity-mobile-apple-swift-objc) | [MSAL iOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) | Authorization code with PKCE |[Quickstart](quickstart-mobile-app-ios-sign-in.md) |[Tutorial](tutorial-v2-ios.md) |
> | Java | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-android-java) | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) | Authorization code with PKCE | [Quickstart](quickstart-mobile-app-android-sign-in.md) |[Tutorial](tutorial-v2-android.md) |
> | Kotlin | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-android-kotlin) | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) | Authorization code with PKCE | | |
> | Xamarin | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-xamarin-native-v2/tree/main/1-Basic) <br/>&#8226; [Sign in users with broker and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-xamarin-native-v2/tree/main/2-With-broker) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE | | |

### Service / daemon

The following samples show an application that accesses the Microsoft Graph API with its own identity (with no user).

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | .NET | &#8226; [.NET console app that accesses a protected web API](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/console-daemon) <br/> &#8226; [Multitenant with Microsoft identity platform endpoint](https://github.com/Azure-Samples/ms-identity-aspnet-daemon-webapp) | [MSAL.NET](/entra/msal/dotnet) | Client credentials grant|[Quickstart](quickstart-daemon-dotnet-acquire-token.md) | [Tutorial](tutorial-v2-aspnet-daemon-web-app.md) |
> | .NET Core | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/1-Call-MSGraph) <br/> &#8226; [Call web API](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/2-Call-OwnApi) <br/> &#8226; [Using managed identity to call MSGraph](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/5-Call-MSGraph-ManagedIdentity) <br/> &#8226; [Using managed identity to call an API](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/6-Call-OwnApi-ManagedIdentity) <br/> &#8226; [Worker role calling an API](https://github.com/AzureAD/microsoft-identity-web/tree/master/tests/DevApps/ContosoWorker) | Microsoft.Identity.Web | Client credentials grant|
> | Java | &#8226; [Call Microsoft Graph with Secret](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/1-server-side/msal-client-credential-secret) <br/> &#8226; [Call Microsoft Graph with Certificate](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/1-server-side/msal-client-credential-certificate)| [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Client credentials grant| [Quickstart](quickstart-daemon-app-java-acquire-token.md) | |
> | Node.js | &#8226; [Call Microsoft Graph with secret](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-console) | [MSAL Node](/javascript/api/@azure/msal-node) | Client credentials grant | [Quickstart](quickstart-console-app-nodejs-acquire-token.md)|[Tutorial](tutorial-v2-nodejs-console.md) |
> | Python | &#8226; [Call Microsoft Graph with secret](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/1-Call-MsGraph-WithSecret) <br/> &#8226; [Call Microsoft Graph with certificate](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/2-Call-MsGraph-WithCertificate) | [MSAL Python](/entra/msal/python)| Client credentials grant| [Quickstart](quickstart-daemon-app-python-acquire-token.md) | |

### Browserless (Headless)

The following sample shows a public client application running on a device without a web browser. The app can be a command-line tool, an app running on Linux or Mac, or an IoT application. The sample features an app accessing the Microsoft Graph API, in the name of a user who signs in interactively on another device (such as a mobile phone). This client application uses the Microsoft Authentication Library (MSAL).

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | .NET Core | &#8226; [Invoke protected API from text-only device](https://github.com/azure-samples/active-directory-dotnetcore-devicecodeflow-v2) | [MSAL.NET](/entra/msal/dotnet) | Device code| | |
> | Java | &#8226; [Sign in users and invoke protected API from text-only device](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/2-client-side/Device-Code-Flow) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Device code | | |
> | Python | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-python-devicecodeflow) | [MSAL Python](/entra/msal/python) | Device code | | |

### Azure Functions as web APIs

The following samples show how to protect an Azure Function using HttpTrigger and exposing a web API with the Microsoft identity platform, and how to call a downstream API from the web API.

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Python | &#8226; [Python Azure function web API secured by Microsoft Entra ID](https://github.com/Azure-Samples/ms-identity-python-webapi-azurefunctions) | [MSAL Python](/entra/msal/python) | Authorization code | | |

### Microsoft Teams applications

The following sample illustrates Microsoft Teams Tab application that signs in users. Additionally it demonstrates how to call Microsoft Graph API with the user's identity using the Microsoft Authentication Library (MSAL).

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Node.js | &#8226; [Teams Tab app: single sign-on (SSO) and call Microsoft Graph](https://github.com/OfficeDev/Microsoft-Teams-Samples/tree/main/samples/tab-sso/nodejs) | [MSAL Node](/javascript/api/@azure/msal-node) |  On-Behalf-Of (OBO) | | |

### Multitenant SaaS

The following samples show how to configure your application to accept sign-ins from any Microsoft Entra tenant. Configuring your application to be *multitenant* means that you can offer a **Software as a Service** (SaaS) application to many organizations, allowing their users to be able to sign-in to your application after providing consent.

> [!div class="mx-tdCol2BreakAll"]
> | Language /<br/>Platform | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | ----------------------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | ASP.NET Core | &#8226; [ASP.NET Core MVC web application calls Microsoft Graph API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/2-WebApp-graph-user/2-3-Multi-Tenant) <br/> &#8226; [ASP.NET Core MVC web application calls ASP.NET Core web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/4-WebApp-your-API/4-3-AnyOrg) | [MSAL.NET](/entra/msal/dotnet) | &#8226; OpenID connect <br/> &#8226; Authorization code| | |

# [**By language/framework**](#tab/framework)

### C# 

The following samples show how to build applications using the C# language and frameworks

#### .NET Core

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Desktop | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/1-Calling-MSGraph/1-1-AzureAD) <br/> &#8226; [Call Microsoft Graph with token cache](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/2-TokenCache) <br/> &#8226; [Call Microsoft Graph with custom web UI HTML](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/3-CustomWebUI/3-1-CustomHTML) <br/> &#8226; [Call Microsoft Graph with custom web browser](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/3-CustomWebUI/3-2-CustomBrowser) <br/> &#8226; [Sign in users with device code flow](https://github.com/Azure-Samples/ms-identity-dotnet-desktop-tutorial/tree/master/4-DeviceCodeFlow) <br/>&#8226; [Call Microsoft Graph by signing in users using username/password](https://github.com/azure-samples/active-directory-dotnetcore-console-up-v2) <br/>&#8226; [Authenticate users with MSAL.NET in a WinUI desktop application](https://github.com/Azure-Samples/ms-identity-netcore-winui) | [MSAL.NET](/entra/msal/dotnet) | &#8226; Authorization code with PKCE <br/> &#8226; Device code | | |
> | Mobile | &#8226; [Call Microsoft Graph using MAUI](https://github.com/Azure-Samples/ms-identity-dotnetcore-maui/tree/main/MauiAppBasic) <br/> &#8226; [Call Microsoft Graph using MAUI with broker](https://github.com/Azure-Samples/ms-identity-dotnetcore-maui/tree/main/MauiAppWithBroker) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE | | |
> | Service/</div>daemon | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/1-Call-MSGraph) <br/> &#8226; [Call web API](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/2-Call-OwnApi) <br/> &#8226; [Using managed identity and Azure key vault](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/tree/master/3-Using-KeyVault)| [MSAL.NET](/entra/msal/dotnet) | Client credentials grant| | |
> | Headless | &#8226; [Invoke protected API from text-only device](https://github.com/azure-samples/active-directory-dotnetcore-devicecodeflow-v2) | [MSAL.NET](/entra/msal/dotnet) | Device code | | |

#### ASP.NET 

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | &#8226; [Microsoft Graph Training Sample](https://github.com/microsoftgraph/msgraph-training-aspnetmvcapp) <br/> &#8226; [Sign in users and call Microsoft Graph with admin restricted scope](https://github.com/azure-samples/active-directory-dotnet-admin-restricted-scopes-v2) | [MSAL.NET](/entra/msal/dotnet) | &#8226; OpenID connect <br/> &#8226; Authorization code | [Quickstart](https://github.com/AzureAdQuickstarts/AppModelv2-WebApp-OpenIDConnect-DotNet)  | |
> | Web API | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-aspnet-webapi-onbehalfof) | [MSAL.NET](/entra/msal/dotnet) | On-Behalf-Of (OBO) |
> | Service/</br>daemon | &#8226; [Multitenant with Microsoft identity platform endpoint](https://github.com/Azure-Samples/ms-identity-aspnet-daemon-webapp) | [MSAL.NET](/entra/msal/dotnet) | Client credentials grant| | |

#### ASP.NET Core

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/web-app-aspnet) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-1-Call-MSGraph/README.md) <br/>&#8226; [Customize token cache](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-2-TokenCache/README.md) <br/>&#8226; [Use the Conditional Access auth context to perform step-up authentication](https://github.com/Azure-Samples/ms-identity-dotnetcore-ca-auth-context-app/blob/main/README.md) <br/>&#8226; [Call Graph (multitenant)](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/2-WebApp-graph-user/2-3-Multi-Tenant/README.md) <br/>&#8226; [Call Azure REST APIs](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/3-WebApp-multi-APIs/README.md) <br/>&#8226; [Protect web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/4-WebApp-your-API/4-1-MyOrg/README.md) <br/>&#8226; [Protect multitenant web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/4-WebApp-your-API/4-3-AnyOrg/Readme.md) <br/>&#8226; [Use App Roles for access control](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/5-WebApp-AuthZ/5-1-Roles/README.md) <br/>&#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/5-WebApp-AuthZ/5-2-Groups/README.md) <br/>&#8226; [Deploy to Azure Storage and App Service](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/blob/master/6-Deploy-to-Azure/README.md) <br/>&#8226; [Active Directory Federation Services to Microsoft Entra migration](https://github.com/Azure-Samples/ms-identity-dotnet-adfs-to-aad) <br/>&#8226; [Active Directory Federation Services to Microsoft Entra migration](https://github.com/Azure-Samples/ms-identity-dotnet-adfs-to-aad) [Use the Conditional Access auth context to perform step\-up authentication](https://github.com/Azure-Samples/ms-identity-dotnetcore-ca-auth-context-app/blob/main/README.md) [Advanced Token Cache Scenarios](https://github.com/Azure-Samples/ms-identity-dotnet-advanced-token-cache)| [Microsoft.Identity.Web](/dotnet/api/microsoft-authentication-library-dotnet/confidentialclient) | &#8226; OpenID connect <br/> &#8226; Authorization code <br/>&#8226; On-Behalf-Of | [Quickstart](quickstart-web-app-dotnet-core-sign-in.md)| [Tutorial](tutorial-web-app-dotnet-prepare-app.md) |
> | Web API | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-dotnet-native-aspnetcore-v2/tree/master/2.%20Web%20API%20now%20calls%20Microsoft%20Graph) | [MSAL.NET](/entra/msal/dotnet) | On-Behalf-Of (OBO) | [Quickstart](quickstart-web-api-aspnet-core-protect-api.md)  | [Tutorial](tutorial-web-api-dotnet-register-app.md) |
> | Multitenant SaaS | &#8226; [ASP.NET Core MVC web application calls Microsoft Graph API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/2-WebApp-graph-user/2-3-Multi-Tenant) <br/>&#8226; [ASP.NET Core MVC web application calls ASP.NET Core web API](https://github.com/Azure-Samples/active-directory-aspnetcore-webapp-openidconnect-v2/tree/master/4-WebApp-your-API/4-3-AnyOrg) | [MSAL.NET](/entra/msal/dotnet) | OpenID connect | | |

#### Blazor 

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Single-page application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/tree/main/spa-blazor-wasm) <br/>&#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-blazor-wasm/blob/main/WebApp-graph-user/Call-MSGraph/README.md)<br/>&#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-blazor-wasm/blob/main/Deploy-to-Azure/README.md) | [MSAL.js](/javascript/api/overview/msal-overview) | Implicit Flow | [Quickstart](quickstart-single-page-app-blazor-wasm-sign-in.md)| |
> | Web application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-blazor-server/tree/main/WebApp-OIDC/MyOrg) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-blazor-server/tree/main/WebApp-graph-user/Call-MSGraph) <br/> &#8226; [Call web API](https://github.com/Azure-Samples/ms-identity-blazor-server/tree/main/WebApp-your-API/MyOrg) | [MSAL.NET](/entra/msal/dotnet) | Implicit/Hybrid flow | | |

#### Xamarin

The following samples show how to build applications for the Xamarin platform.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Mobile | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-xamarin-native-v2/tree/main/1-Basic) <br/>&#8226; [Sign in users with broker and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-xamarin-native-v2/tree/main/2-With-broker) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE | | |

### iOS

The following samples show how to build applications for the iOS platform.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Mobile | &#8226; [Call Microsoft Graph native](https://github.com/Azure-Samples/ms-identity-mobile-apple-swift-objc) | [MSAL iOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) | Authorization code with PKCE |[Quickstart](quickstart-mobile-app-ios-sign-in.md) |[Tutorial](tutorial-v2-ios.md) |

### JavaScript

#### Vanilla JavaScript

The following samples show how to build applications for the JavaScript language and platform. 

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Single-page application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/vanillajs-spa) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/2-Authorization-I/1-call-graph/README.md)<br/>&#8226; [Call Node.js web API](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/3-Authorization-II/1-call-api/README.md) <br/>&#8226; [Deploy to Azure Storage and App Service](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/4-Deployment/README.md) | [MSAL.js](/javascript/api/overview/msal-overview) | Authorization code with PKCE | [Quickstart](quickstart-single-page-app-javascript-sign-in.md) | |

#### Angular

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/> on GitHub |Auth<br/> libraries |Auth flow | Quickstart | Tutorial |
> | -------- | ------------------------------ |------------------- |--------- |----------- |--------- |
> | Single-page application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/angular-spa) | [MSAL Angular](/javascript/api/@azure/msal-angular) | Authorization code with PKCE | [Quickstart](quickstart-single-page-app-angular-sign-in.md) | [Tutorial](tutorial-v2-angular-auth-code.md) |

#### Node.js

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web API | &#8226; [Protect a Node.js web API](https://github.com/Azure-Samples/ms-identity-javascript-tutorial/tree/main/3-Authorization-II/1-call-api) | [MSAL Node](/javascript/api/@azure/msal-node) | Authorization bearer |
> | Desktop | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-desktop) | [MSAL Node](/javascript/api/@azure/msal-node) | Authorization code with PKCE | | [Tutorial](tutorial-v2-nodejs-desktop.md) |
> | Service, daemon | &#8226; [Call Microsoft Graph with secret](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-console) | [MSAL Node](/javascript/api/@azure/msal-node) | Client credentials grant | [Quickstart](quickstart-console-app-nodejs-acquire-token.md) | |
> | Microsoft Teams applications | &#8226; [Teams Tab app: single sign-on (SSO) and call Microsoft Graph](https://github.com/OfficeDev/Microsoft-Teams-Samples/tree/main/samples/tab-sso/nodejs) | [MSAL Node](/javascript/api/@azure/msal-node) |  On-Behalf-Of (OBO) | | |

#### Node.js (Express) 

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/1-Authentication/1-sign-in/README.md) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/2-Authorization/1-call-graph/README.md)<br/> &#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/3-Deployment/README.md)<br/> &#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/4-AccessControl/1-app-roles/README.md)<br/> &#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/ms-identity-javascript-nodejs-tutorial/blob/main/4-AccessControl/2-security-groups/README.md) <br/> &#8226; [Web app that sign in users](https://github.com/Azure-Samples/ms-identity-node) | [MSAL Node](/javascript/api/@azure/msal-node) | Authorization code | [Quickstart](quickstart-web-app-nodejs-sign-in.md) | [Tutorial](tutorial-v2-nodejs-webapp-msal.md)  |

#### React

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Single-page application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-javascript/tree/main/react-spa) | [MSAL React](/javascript/api/@azure/msal-react) | &#8226; Authorization code with PKCE<br/> | [Quickstart](quickstart-single-page-app-react-sign-in.md) | [Tutorial](tutorial-single-page-app-react-register-app.md) |

### Java

The following samples show how to build applications for the Java language and platform.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web API | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/protect-web-api) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | On-Behalf-Of (OBO) |
> | Desktop | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/2-client-side/Integrated-Windows-Auth-Flow) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Integrated Windows authentication |
> | Mobile | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-android-java) | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) | Authorization code with PKCE |
> | Service/</br>daemon | &#8226; [Call Microsoft Graph with Secret](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/1-server-side/msal-client-credential-secret) <br/> &#8226; [Call Microsoft Graph with Certificate](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/1-server-side/msal-client-credential-certificate)| [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Client credentials grant| [Quickstart](quickstart-daemon-app-java-acquire-token.md) | |

#### Java Spring

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application |Microsoft Entra Spring Boot Starter Series <br/> &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/1-Authentication/sign-in) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/2-Authorization-I/call-graph) <br/> &#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/roles) <br/> &#8226; [Use Groups for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/groups) <br/> &#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/4-Deployment/deploy-to-azure-app-service) <br/> &#8226; [Protect a web API](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/4-spring-web-app/3-Authorization-II/protect-web-api) | &#8226; [MSAL Java](/java/api/com.microsoft.aad.msal4j) <br/> &#8226; Microsoft Entra ID Boot Starter | Authorization code | | [Tutorial](/azure/developer/java/spring-framework/configure-spring-boot-starter-java-app-with-azure-active-directory) |

#### Java Servlet

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | Spring-less Servlet Series <br/> &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/1-Authentication/sign-in) <br/> &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/2-Authorization-I/call-graph) <br/> &#8226; [Use App Roles for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/3-Authorization-II/roles) <br/> &#8226; [Use Security Groups for access control](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/3-Authorization-II/groups) <br/> &#8226; [Deploy to Azure App Service](https://github.com/Azure-Samples/ms-identity-msal-java-samples/tree/main/3-java-servlet-web-app/4-Deployment/deploy-to-azure-app-service) | [MSAL Java](/java/api/com.microsoft.aad.msal4j) | Authorization code | | |

### Python 

The following samples show how to build applications for the Python language and platform.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Azure Functions as web APIs | &#8226; [Python Azure function web API secured by Microsoft Entra ID](https://github.com/Azure-Samples/ms-identity-python-webapi-azurefunctions) | [MSAL Python](/entra/msal/python) | Authorization code |
> | Desktop | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-python-desktop) | [MSAL Python](/entra/msal/python) | Resource owner password credentials |
> | Headless | &#8226; [Call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-python-devicecodeflow) | [MSAL Python](/entra/msal/python) | Device code |
> | Daemon | &#8226; [Call Microsoft Graph with secret](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/1-Call-MsGraph-WithSecret) <br/> &#8226; [Call Microsoft Graph with certificate](https://github.com/Azure-Samples/ms-identity-python-daemon/tree/master/2-Call-MsGraph-WithCertificate) | [MSAL Python](/entra/msal/python)| Client credentials grant| [Quickstart](quickstart-daemon-app-python-acquire-token.md) | |

#### Flask

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-python/tree/main/flask-web-app) <br/>&#8226; [A template to sign in Microsoft Entra ID, and optionally call a downstream API (Microsoft Graph)](https://github.com/Azure-Samples/ms-identity-python-webapp) | [MSAL Python](/entra/msal/python) | Authorization code | [Quickstart](quickstart-web-app-python-flask.md)| [Tutorial](tutorial-web-app-python-register-app.md) |

#### Django

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | &#8226; [Sign in users](https://github.com/Azure-Samples/ms-identity-docs-code-python/tree/main/django-web-app) <br/> &#8226; [Integrating Microsoft Entra ID with a Python web application written in Django](https://github.com/Azure-Samples/ms-identity-python-webapp-django) | [MSAL Python](/entra/msal/python/) | Authorization code | | |

### Kotlin 

The following samples show how to build applications with Kotlin.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Mobile   | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/ms-identity-android-kotlin) | [MSAL Android](https://github.com/AzureAD/microsoft-authentication-library-for-android) | Authorization code with PKCE | | |

### Ruby 

The following samples show how to build applications with Ruby.

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Web application | Graph Training <br/> &#8226; [Sign in users and call Microsoft Graph](https://github.com/microsoftgraph/msgraph-training-rubyrailsapp) | OmniAuth OAuth2 | Authorization code | | |

### Windows Presentation Foundation (WPF) 

The following samples show how to build applications with Windows Presentation Foundation (WPF).

> [!div class="mx-tdCol2BreakAll"]
> | App type | Code sample(s) <br/>on GitHub | Auth <br/>libraries | Auth flow | Quickstart | Tutorial |
> | -------- | ----------------------------- | ------------------- | --------- | ---------- | -------- |
> | Desktop | &#8226; [Sign in users and call Microsoft Graph](https://github.com/Azure-Samples/active-directory-dotnet-native-aspnetcore-v2/tree/master/2.%20Web%20API%20now%20calls%20Microsoft%20Graph) | [MSAL.NET](/entra/msal/dotnet) | Authorization code with PKCE |
> | Desktop | &#8226; [Sign in users and call ASP.NET Core web API](https://github.com/Azure-Samples/active-directory-dotnet-native-aspnetcore-v2/tree/master/1.%20Desktop%20app%20calls%20Web%20API) <br/> &#8226; [Sign in users and call Microsoft Graph](https://github.com/azure-samples/active-directory-dotnet-desktop-msgraph-v2) | [MSAL.NET](/entra/msal/dotnet/) | Authorization code with PKCE | [Quickstart](quickstart-desktop-app-uwp-sign-in.md) | [Tutorial](quickstart-desktop-app-wpf-sign-in.md) |

---

## Related content

If you'd like to delve deeper into more sample code, see:

- [Sign in users and call the Microsoft Graph API from an Angular](tutorial-v2-angular-auth-code.md)
- [Sign in users in a Node.js and Express web app](tutorial-v2-nodejs-webapp-msal.md)
- [Call the Microsoft Graph API from a Universal Windows Platform](tutorial-v2-windows-uwp.md)

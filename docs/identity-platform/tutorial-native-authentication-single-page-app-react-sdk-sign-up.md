---
title: Sign up users into a React SPA by using native authentication SDK
description: Learn how to build a React single-page application that uses native authentication API to sign up users.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 02/07/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication's JavaScript SDK so that I can sign up users with a username (email) and password.
---

# Tutorial: Sign up users into a React single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to build a React single-page app that signs up users by using native authentication's JavaScript SDK.

In this tutorial, you:

>[!div class="checklist"]
> - Create a React Next.js project.
> - Add MSAL JS SDK to it.
> - Add UI components of the app.
> - Setup the project to sign up user using username (email) and password.

## Prerequisites

- Complete the steps in [Quickstart: Sign in users in a React single-page app by using native authentication JavaScript SDK ](quickstart-native-authentication-single-page-app-react-sdk-sign-in.md). This quickstart shows you run a sample React code sample.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).



## Create a React project and install dependencies

In a location of choice in your computer, run the following commands to create a new React project with the name *reactspa*, navigate into the project folder, then install packages:

```console
npx create-next-app@latest
cd reactspa
npm install
```

## Add JavaScript SDK to your project

To use the native authentication JavaScript SDK into your project, opent the *package.json* file, then add the following dependencies:

```typescript
"dependencies": {
        "@azure/msal-common": "https://raw.githubusercontent.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/main/typescript/native-auth/azure-msal-common-15.2.1.tgz",
        "@azure/msal-browser": "https://raw.githubusercontent.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/main/typescript/native-auth/azure-msal-browser-4.7.0.tgz",
        ...
}
```

The native authentication capabilities are part of the `azure-msal-browser` library.

## Add client configuration

In this section, you define a configuration for native authentication public client application to enable it to interact with the interface of the SDK. To do so, create a file called *src/config/auth-config.ts*, then add the following code:

```typescript
export const customAuthConfig: CustomAuthConfiguration = {
    customAuth: {
        challengeTypes: ["password", "oob", "redirect"],
        authApiProxyUrl: "http://localhost:3001/api",
    },
    auth: {
        clientId: "Enter_the_Application_Id_Here",
        authority: "https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com",
        redirectUri: "/",
        postLogoutRedirectUri: "/",
        navigateToLoginRequestUrl: false,
    },
    cache: {
        cacheLocation: "sessionStorage",
        storeAuthStateInCookie: false,
    },
    system: {
        loggerOptions: {
            loggerCallback: (level: LogLevel, message: string, containsPii: boolean) => {
                if (containsPii) {
                    return;
                }
                switch (level) {
                    case LogLevel.Error:
                        console.error(message);
                        return;
                    case LogLevel.Info:
                        console.info(message);
                        return;
                    case LogLevel.Verbose:
                        console.debug(message);
                        return;
                    case LogLevel.Warning:
                        console.warn(message);
                        return;
                }
            },
        },
    },
};
```


In the code, find the placeholder:

* `Enter_the_Application_Id_Here` then replace it with the Application (client) ID of the app you registered earlier.

* `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

## Create UI components


---
title: Sign up users into a Angular SPA by using native authentication SDK
description: Learn how to build a Angular single-page application that uses native authentication JavaScript SDK to sign up users.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 07/30/2025
#Customer intent: As a developer, I want to build a Angular single-page application that uses native authentication's JavaScript SDK so that I can sign up users with email with password or email one-timepasscode authentication menthods
---

# Tutorial: Sign up users into a Angular single-page app by using native authentication JavaScript SDK (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to build a Angular single-page app that signs up users by using native authentication's JavaScript SDK.

In this tutorial, you:

>[!div class="checklist"]
> - Create a Angular Next.js project.
> - Add MSAL JS SDK to it.
> - Add UI components of the app.
> - Setup the project to sign up users.

## Prerequisites

- Complete the steps in [Quickstart: Sign in users in a Angular single-page app by using native authentication JavaScript SDK](quickstart-native-authentication-single-page-app-sdk-sign-in.md?tabs=angular). This quickstart shows you run a sample Angular code sample.
- Complete the steps in [Set up CORS proxy server to manage CORS headers for native authentication](how-to-native-authentication-single-page-app-javascript-sdk-set-up-local-cors.md).
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).
- [Angular CLI](https://angular.dev/tools/cli).


## Create a React project and install dependencies

In a location of choice in your computer, run the following commands to create a new Angular project with the name *reactspa*, navigate into the project folder, then install packages:

```console
ng new angularspa
cd angularspa
```

After you successfully run the commands, you should have an app with the following structure:

```console
angularspa/
└──node_modules/
   └──...
└──public/
   └──...
└──src/
   └──app/
      └──app.component.html
      └──app.component.scss
      └──app.component.ts
      └──app.modules.ts
      └──app.config.ts
      └──app.routes.ts
   └──index.html
   └──main.ts
   └──style.scss
└──angular.json
└──package-lock.json
└──package.json
└──README.md
└──tsconfig.app.json
└──tsconfig.json
└──tsconfig.spec.json
```

## Add JavaScript SDK to your project

To use the native authentication JavaScript SDK in your app, use your terminal to install it by using the following command:

```console
npm intall @azure/msal-browser
```

The native authentication capabilities are part of the `azure-msal-browser` library. To use native authentication features, you import from `@azure/msal-browser/custom-auth`. For example:

```typescript
  import CustomAuthPublicClientApplication from "@azure/msal-browser/custom-auth";
```


## Add client configuration

In this section, you define a configuration for native authentication public client application to enable it to interact with the interface of the SDK. To do so, 

1. Create a file called *src/app/config/auth-config.ts*, then add the following code: 

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
    
    - `Enter_the_Application_Id_Here` then replace it with the Application (client) ID of the app you registered earlier.
    
    - `Enter_the_Tenant_Subdomain_Here` then replace it with the tenant subdomain in your Microsoft Entra admin center. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 

1. Create a file called *src/app/services/auth.service.ts*, then add the following code: 

    ```typescript
    import { Injectable } from '@angular/core';
    import { CustomAuthPublicClientApplication, ICustomAuthPublicClientApplication } from '@azure/msal-browser/custom-auth';
    import { customAuthConfig } from '../config/auth-config';
    
    @Injectable({ providedIn: 'root' })
    export class AuthService {
      private authClientPromise: Promise<ICustomAuthPublicClientApplication>;
      private authClient: ICustomAuthPublicClientApplication | null = null;
    
      constructor() {
        this.authClientPromise = this.init();
      }
    
      private async init(): Promise<ICustomAuthPublicClientApplication> {
        this.authClient = await CustomAuthPublicClientApplication.create(customAuthConfig);
        return this.authClient;
      }
    
      getClient(): Promise<ICustomAuthPublicClientApplication> {
        return this.authClientPromise;
      }
    }
    ```
    
## Create a sign-up component

1. Create a directory called */app/components*.

1. Use Angular CLI to generate a new component for the sign-up page inside the *components* folder by running the following command:

    ```console
    cd components
    ng generate component sign-up
    ```

3. Open *src/app/components/sign-up/sign-up.component.ts* file, then replace its contents with the contents in [sign-up.component](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.ts)

4. Open *src/app/components/sign-up/sign-up.component.html* file and add the code in [html file](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html).

    - The following logic in the *sign-up.component.ts* file determines what the user needs to do next after starting the sign-up process. Depending on the result, it shows either the password form or the verification code form in *sign-up.component.html* so the user can continue with the sign-up flow:
         ```typescript
            const attributes: UserAccountAttributes = {
                        givenName: this.firstName,
                        surname: this.lastName,
                        jobTitle: this.jobTitle,
                        city: this.city,
                        country: this.country,
                    };
            const result = await client.signUp({
                        username: this.email,
                        attributes,
                    });
        
            if (result.isPasswordRequired()) {
                this.showPassword = true;
                this.showCode = false;
            } else if (result.isCodeRequired()) {
                this.showPassword = false;
                this.showCode = true;
            }
        ```

    - If you want the user to start sign-in flow immeditaely after sign-up is completed, use this snippet:

        ```html
        <div *ngIf="isSignedUp">
            <p>The user has been signed up, please click <a href="/sign-in">here</a> to sign in.</p>
        </div>
        ```

5. Open the *src/app/components/sign-up/sign-up.component.scss* file, then add the following [styles file](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.scss).


### Automatically sign-in after sign-up (optional)

- You can automatically sign in your users after a successful sign-up without starting a fresh sign-in flow. To do so, use the following code snippet. See a complete example at [/app/components/sign-up/sign-up.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.ts):

    ```typescript
    if (this.signUpState instanceof SignUpCompletedState) {
        const result = await this.signUpState.signIn();
    
        if (result.isFailed()) {
            this.error = result.error?.errorData?.errorDescription || "An error occurred during auto sign-in";
        }
    
        if (result.isCompleted()) {
            this.userData = result.data;
            this.signUpState = result.state;
            this.isSignedUp = true;
            this.showCode = false;
            this.showPassword = false;
        }
    }
    ```

- When you autosign in a user, use the following snippet in your [/app/components/sign-up/sign-up.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-up/sign-up.component.html) html file.

    ```html
    <div *ngIf="userData && !isSignedIn">
        <p>Signed up complete, and signed in as {{ userData?.getAccount()?.username }}</p>
    </div>
    <div *ngIf="isSignedUp && !userData">
        <p>Sign up completed! Signing you in automatically...</p>
    </div>
    ```

## Update app routing

1. Open the *src/app/app.route.ts* file, then add the route for the sign-up component:

    ```typescript
    import { NgModule } from '@angular/core';
    import { RouterModule, Routes } from '@angular/router';
    import { SignUpComponent } from './components/sign-up/sign-up.component';
    import { AuthService } from './services/auth.service';
    import { AppComponent } from './app.component';
    
    export const routes: Routes = [
        { path: 'sign-up', component: SignUpComponent },
    ];
    
    @NgModule({
        imports: [
            RouterModule.forRoot(routes),
            SignUpComponent,
        ],
        providers: [AuthService],
        bootstrap: [AppComponent]
    })
    export class AppRoutingModule { }
    ```

## Test the sign-up flow

1. To start the CORS proxy server, run the following command in your terminal:
    ```console
    npm run cors
    ```
1. To start your application, run the following command in your terminal:

    ```console
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:4200/sign-up`. A sign-up form appears.

1. To sign up for an account, input your details, select the **Continue** button, then follow the prompts.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Sign in users into a React single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-sign-in.md).
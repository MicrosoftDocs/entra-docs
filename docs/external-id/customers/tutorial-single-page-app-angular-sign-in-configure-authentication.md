---
title: Tutorial - Handle authentication flows in an Angular single-page app
description: Learn how to configure authentication for an Angular single-page app (SPA) with your Microsoft Entra External ID for customers tenant.
services: active-directory
author: garrodonnell
manager: CelesteDG

ms.author: godonnell
ms.service: active-directory
ms.subservice: ciam
ms.topic: tutorial
ms.date: 10/27/2023

#Customer intent: As a developer, I want to learn how to configure an Angular single-page app (SPA) to sign in and sign out users with my Microsoft Entra External ID for customers tenant.
---

# Tutorial: Handle authentication flows in an Angular single-page app 

In the previous article, [Prepare an Angular single-page app for authentication](./tutorial-single-page-app-angular-sign-in-prepare-app.md), you created an Angular single-page app (SPA) and prepared it for authentication with your Microsoft Entra External ID for customers tenant. In this article, you'll learn how to handle authentication flows in your app by adding components.

In this tutorial;

> [!div class="checklist"]
> * Add authentication flows to your application
> * Import MSAL components
> * Add routes to home and guarded components of the application.

## Prerequisites

* Completion of the prerequisites and steps in [Prepare your customer tenant to authenticate users in an Angular single-page app (SPA)](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md).



## Create the authentication configuration file, auth-config.ts

1. Open _src/app/auth-config.ts_ and add the following code snippet. This file contains authentication parameters. These parameters are used to initialize Angular and MSAL Angular configurations.

    ```JavaScript

    ```JavaScript
    /**
     * This file contains authentication parameters. Contents of this file
     * is roughly the same across other MSAL.js libraries. These parameters
     * are used to initialize Angular and MSAL Angular configurations in
     * in app.module.ts file.
     */
    
    import {
      LogLevel,
      Configuration,
      BrowserCacheLocation,
    } from '@azure/msal-browser';
    
    /**
     * Configuration object to be passed to MSAL instance on creation.
     * For a full list of MSAL.js configuration parameters, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/configuration.md
     */
    export const msalConfig: Configuration = {
      auth: {
        clientId: 'Enter_the_Application_Id_Here', // This is the ONLY mandatory field that you need to supply.
        authority: 'https://login.microsoftonline.com/Enter_the_Tenant_Info_Here', // Defaults to "https://login.microsoftonline.com/common"
        redirectUri: '/', // Points to window.location.origin by default. You must register this URI on Azure portal/App Registration.
        postLogoutRedirectUri: '/', // Points to window.location.origin by default.
      },
      cache: {
        cacheLocation: BrowserCacheLocation.LocalStorage, // Configures cache location. "sessionStorage" is more secure, but "localStorage" gives you SSO between tabs.
      },
      system: {
        loggerOptions: {
          loggerCallback(logLevel: LogLevel, message: string) {
            console.log(message);
          },
          logLevel: LogLevel.Verbose,
          piiLoggingEnabled: false,
        },
      },
    };
    
    /**
     * Scopes you add here will be prompted for user consent during sign-in.
     * By default, MSAL.js will add OIDC scopes (openid, profile, email) to any login request.
     * For more information about OIDC scopes, visit:
     * https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-permissions-and-consent#openid-connect-scopes
     */
    export const loginRequest = {
      scopes: [],
    }; 
    ```

1. Replace the following values with the values from the Microsoft Entra admin center:
    - Find the `Enter_the_Application_Id_Here` value and replace it with the **Application ID (clientId)** of the app you registered in the Microsoft Entra admin center.
    - In **Authority**, find `Enter_the_Tenant_Subdomain_Here` and replace it with the subdomain of your tenant. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, [learn how to read your tenant details](how-to-create-customer-tenant-portal.md#get-the-customer-tenant-details).
1. Save the file.

## Import MSAL components

1. Open _src/app/app.module.ts_. MSAL components need to be added to `imports`. You will also add the material modules. Replace the entire contents of the file with the following snippet. This snippet imports the MSAL components and material modules.

    ```JavaScript
    import { NgModule } from '@angular/core';
    import { BrowserModule } from '@angular/platform-browser';
    import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
    
    import { MatToolbarModule } from "@angular/material/toolbar";
    import { MatButtonModule } from '@angular/material/button';
    import { MatCardModule } from '@angular/material/card';
    import { MatTableModule } from '@angular/material/table';
    import { MatMenuModule } from '@angular/material/menu';
    import { MatDialogModule } from '@angular/material/dialog';
    import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
    import { MatIconModule } from '@angular/material/icon';
    
    import { AppRoutingModule } from './app-routing.module';
    import { AppComponent } from './app.component';
    import { HomeComponent } from './home/home.component';
    import { GuardedComponent } from './guarded/guarded.component';
    
    import {
        IPublicClientApplication,
        PublicClientApplication,
        InteractionType,
    } from '@azure/msal-browser';
    
    import {
        MSAL_INSTANCE,
        MsalGuardConfiguration,
        MSAL_GUARD_CONFIG,
        MsalService,
        MsalBroadcastService,
        MsalGuard,
        MsalRedirectComponent,
        MsalInterceptor,
        MsalModule,
    } from '@azure/msal-angular';
    
    import { msalConfig, loginRequest } from './auth-config';
    
    /**
     * Here we pass the configuration parameters to create an MSAL instance.
        * For more info, visit: https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-angular/docs/v2-docs/configuration.md
        */
    export function MSALInstanceFactory(): IPublicClientApplication {
        return new PublicClientApplication(msalConfig);
    }
    
    /**
     * Set your default interaction type for MSALGuard here. If you have any
        * additional scopes you want the user to consent upon login, add them here as well.
        */
    export function MsalGuardConfigurationFactory(): MsalGuardConfiguration {
        return {
        interactionType: InteractionType.Redirect,
        authRequest: loginRequest
        };
    }
    
    @NgModule({
        declarations: [
        AppComponent,
        HomeComponent,
        GuardedComponent,
        ],
        imports: [
        BrowserModule,
        BrowserAnimationsModule,
        AppRoutingModule,
        MatToolbarModule,
        MatButtonModule,
        MatCardModule,
        MatTableModule,
        MatMenuModule,
        HttpClientModule,
        BrowserAnimationsModule,
        MatDialogModule,
        MatIconModule,
        MsalModule,
        ],
        providers: [
        {
            provide: HTTP_INTERCEPTORS,
            useClass: MsalInterceptor,
            multi: true,
        },
        {
            provide: MSAL_INSTANCE,
            useFactory: MSALInstanceFactory,
        },
        {
            provide: MSAL_GUARD_CONFIG,
            useFactory: MsalGuardConfigurationFactory,
        },
        MsalService,
        MsalBroadcastService,
        MsalGuard,
        ],
        bootstrap: [AppComponent, MsalRedirectComponent],
    })
    export class AppModule { }
    ```
1. Open _src/app/app-routing.module.ts_ and add routes to the `home` and `guarded` components. Replace the entire contents of the file with the following snippet. 

    ```JavaScript	
    import { NgModule } from '@angular/core';
    import { RouterModule, Routes } from '@angular/router';
    import { BrowserUtils } from '@azure/msal-browser';
    import { MsalGuard } from '@azure/msal-angular';
    
    import { HomeComponent } from './home/home.component';
    import { GuardedComponent } from './guarded/guarded.component';
    
    /**
     * MSAL Angular can protect routes in your application
        * using MsalGuard. For more info, visit:
        * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-angular/docs/v2-docs/initialization.md#secure-the-routes-in-your-application
        */
    const routes: Routes = [
        {
        path: 'guarded',
        component: GuardedComponent,
        canActivate: [
            MsalGuard
        ]
        },
        {
        path: '',
        component: HomeComponent,
        },
    ];
    
    @NgModule({
        imports: [
        RouterModule.forRoot(routes, {
            // Don't perform initial navigation in iframes or popups
            initialNavigation:
            !BrowserUtils.isInIframe() && !BrowserUtils.isInPopup()
                ? 'enabledNonBlocking'
                : 'disabled', // Set to enabledBlocking to use Angular Universal
        }),
        ],
        exports: [RouterModule],
    })
    export class AppRoutingModule { }

    ```

## Next steps

> [!div class="nextstepaction"]
> [Add sign-in and sign-out](./tutorial-single-page-app-angular-sign-in-sign-out.md)
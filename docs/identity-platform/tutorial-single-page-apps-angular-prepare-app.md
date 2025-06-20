---
title: "Tutorial: Prepare an Angular single-page app (SPA) for authentication"
description: Prepare an Angular single-page app (SPA) in a Microsoft Entra tenant to manage authentication and secure user access.
author: garrodonnell
manager: dougeby
ms.author: godonnell
ms.date: 02/20/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to create a new Angular project in an IDE and add authentication.
---

# Tutorial: Create an Angular single-page app and prepare it for authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial is the first part of a series that demonstrates building an Angular single-page application (SPA), adding authentication and extracting user data using Microsoft identity platform.

In this tutorial, you: 

> [!div class="checklist"]
> * Create a new Angular project
> * Configure the settings for the application
> * Add authentication code to the application

## Prerequisites

### [Workforce tenant](#tab/workforce-tenant)

* A workforce tenant. You can use your [Default Directory](quickstart-create-new-tenant.md) or set up a new tenant.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:4200/`.

### [External tenant](#tab/external-tenant)

* An external tenant. To create one, choose from the following methods:
  * (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/tutorials/marketplace) to set up an external tenant directly in Visual Studio Code.
  * [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:4200/`.
* Associate your app with a user flow in the Microsoft Entra admin center. This user flow can be used across multiple applications. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

---

* [Angular CLI](https://v17.angular.io/cli#installing-angular-cli)
* [Node.js 18.19 or newer](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

## Create a new Angular project

In this section, you'll create a new Angular project using the Angular CLI in Visual Studio Code. Choose the appropriate tab based on your tenant type.

### [Workforce tenant](#tab/workforce-tenant)

To build the Angular project from scratch, follow these steps:

1. Open a terminal window and run the following command to create a new Angular project:

    ```console
    ng new msal-angular-tutorial --routing=true --style=css --strict=false
    ```

    The command creates a new Angular project named `msal-angular-tutorial` with routing enabled, CSS for styling, and strict mode disabled.

1. Change to the project directory:

    ```console
    cd msal-angular-tutorial
    ```
1. Install app dependencies:

    ```console
    npm install @azure/msal-browser @azure/msal-angular bootstrap
    ```

    The command `npm install @azure/msal-browser @azure/msal-angular bootstrap` installs the Azure MSAL browser, Azure MSAL Angular, and Bootstrap packages.

1. Open `angular.json` and add Bootstrap's CSS path to the `styles` array:

    ```json
    "styles": [
        "src/styles.css",
        "node_modules/bootstrap/dist/css/bootstrap.min.css"
    ],
    ```

    The code adds the Bootstrap CSS to the styles array in the `angular.json` file.

1. Generate Home and Profile components:

    ```console
    ng generate component home
    ng generate component profile
    ```

    The commands generate the Home and Profile components in the Angular project.

1. Remove unnecessary files and code from the project:

    ```console
    rm src/app/app.component.css
    rm src/app/app.component.spec.ts
    rm src/app/home/home.component.css
    rm src/app/home/home.component.spec.ts
    rm src/app/profile/profile.component.css
    rm src/app/profile/profile.component.spec.ts
    ```

    The commands remove unnecessary files and code from the project.

1. Rename `app.routes.ts` to `app-routing.module.ts` using Visual Studio Code and update all references of `app.routes.ts` throughout the application.
1. Rename `app.config.ts` to `app.module.ts` using Visual Studio Code and update all references to `app.config.ts` throughout the application.

After you complete these steps, the project structure should look like:

  ```console
  .
  ├── README.md
  ├── angular.json
  ├── package-lock.json
  ├── package.json
  ├── src
  │   ├── app
  │   │   ├── app-routing.module.ts
  │   │   ├── app.component.html
  │   │   ├── app.component.ts
  │   │   ├── app.module.ts
  │   │   ├── home
  │   │   │   ├── home.component.html
  │   │   │   └── home.component.ts
  │   │   └── profile
  │   │       ├── profile.component.html
  │   │       └── profile.component.ts
  │   ├── index.html
  │   ├── main.ts
  │   ├── polyfills.ts
  │   └── styles.css
  ├── tsconfig.app.json
  └── tsconfig.json
  ```

### [External tenant](#tab/external-tenant)

1. Open Visual Studio Code, select **File** > **Open Folder...**. Navigate to and select the location in which you want to create your project.
1. Open a new terminal by selecting **Terminal** > **New Terminal**.
1. Run the following commands to create a new Angular project with the name `angularspalocal`, install Angular Material component libraries, MSAL Browser, MSAL Angular and generate home and guarded components.

    ```powershell
    npm install -g @angular/cli@14.2.0
    ng new angularspalocal --routing=true --style=css --strict=false
    cd angularspalocal
    npm install @angular/material@13.0.0 @angular/cdk@13.0.0
    npm install @azure/msal-browser@2.37.0 @azure/msal-angular@2.5.7
    ng generate component home
    ng generate component guarded
    ```
--- 

## Configure application settings

In this section, you'll configure the application settings for authentication. We'll use the values recorded during the app registration to configure the application for authentication. Choose the appropriate tab based on your tenant type.

### [Workforce tenant](#tab/workforce-tenant)

We'll use the values recorded during the app registration to configure the application for authentication. Follow these steps:

1. Open the `src/app/app.module.ts` file and replace the contents with the following code:

    ```typescript
    // Required for Angular multi-browser support
    import { BrowserModule } from '@angular/platform-browser';
    
    // Required for Angular
    import { NgModule } from '@angular/core';
    
    // Required modules and components for this application
    import { AppRoutingModule } from './app-routing.module';
    import { AppComponent } from './app.component';
    import { ProfileComponent } from './profile/profile.component';
    import { HomeComponent } from './home/home.component';
    
    // HTTP modules required by MSAL
    import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
    
    // Required for MSAL
    import { IPublicClientApplication, PublicClientApplication, InteractionType, BrowserCacheLocation, LogLevel } from '@azure/msal-browser';
    import { MsalGuard, MsalInterceptor, MsalBroadcastService, MsalInterceptorConfiguration, MsalModule, MsalService, MSAL_GUARD_CONFIG, MSAL_INSTANCE, MSAL_INTERCEPTOR_CONFIG, MsalGuardConfiguration, MsalRedirectComponent } from '@azure/msal-angular';
    
    const isIE = window.navigator.userAgent.indexOf('MSIE ') > -1 || window.navigator.userAgent.indexOf('Trident/') > -1;
    
    export function MSALInstanceFactory(): IPublicClientApplication {
      return new PublicClientApplication({
        auth: {
          // 'Application (client) ID' of app registration in the Microsoft Entra admin center - this value is a GUID
          clientId: "Enter_the_Application_Id_Here",
          // Full directory URL, in the form of https://login.microsoftonline.com/<tenant>
          authority: "https://login.microsoftonline.com/Enter_the_Tenant_Info_Here",
          // Must be the same redirectUri as what was provided in your app registration.
          redirectUri: "http://localhost:4200",
        },
        cache: {
          cacheLocation: BrowserCacheLocation.LocalStorage,
          storeAuthStateInCookie: isIE
        }
      });
    }

    // MSAL Interceptor is required to request access tokens in order to access the protected resource (Graph)
    export function MSALInterceptorConfigFactory(): MsalInterceptorConfiguration {
      const protectedResourceMap = new Map<string, Array<string>>();
      protectedResourceMap.set('https://graph.microsoft.com/v1.0/me', ['user.read']);
    
      return {
        interactionType: InteractionType.Redirect,
        protectedResourceMap
      };
    }
    
    // MSAL Guard is required to protect routes and require authentication before accessing protected routes
    export function MSALGuardConfigFactory(): MsalGuardConfiguration {
      return { 
        interactionType: InteractionType.Redirect,
        authRequest: {
          scopes: ['user.read']
        }
      };
    }
    
    // Create an NgModule that contains the routes and MSAL configurations
    @NgModule({
      declarations: [
        AppComponent,
        HomeComponent,
        ProfileComponent
      ],
      imports: [
        BrowserModule,
        AppRoutingModule,
        HttpClientModule,
        MsalModule
      ],
      providers: [
        {
          provide: HTTP_INTERCEPTORS,
          useClass: MsalInterceptor,
          multi: true
        },
        {
          provide: MSAL_INSTANCE,
          useFactory: MSALInstanceFactory
        },
        {
          provide: MSAL_GUARD_CONFIG,
          useFactory: MSALGuardConfigFactory
        },
        {
          provide: MSAL_INTERCEPTOR_CONFIG,
          useFactory: MSALInterceptorConfigFactory
        },
        MsalService,
        MsalGuard,
        MsalBroadcastService
      ],
      bootstrap: [AppComponent, MsalRedirectComponent]
    })
    export class AppModule { }
    ```
    
    The code sets up MSAL for user authentication and API protection. It configures the app with `MsalInterceptor` to secure API requests and `MsalGuard` to protect routes, while defining key components and services for authentication. Replace the following values with the values from the Microsoft Entra admin center.

    - Replace `Enter_the_Application_Id_Here` with the `Application (client) ID` from the app registration.
    - Replace `Enter_the_Tenant_Info_Here` with the `Directory (tenant) ID` from the app registration.

1. Save the file.

### [External tenant](#tab/external-tenant)

1. Create a new file called *auth-config.ts* in the folder *src/app/* and add the following code snippet. This file contains authentication parameters. These parameters are used to initialize Angular and MSAL Angular configurations.

    ```javascript

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
        authority: 'https://Enter_the_Tenant_Subdomain_Here.ciamlogin.com/', // Replace the placeholder with your tenant subdomain
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
     * https://learn.microsoft.com/entra/identity-platform/permissions-consent-overview#openid-connect-scopes
     */
    export const loginRequest = {
      scopes: [],
    };
    ```

1. Replace the following values with the values from the Microsoft Entra admin center:
    - Find the `Enter_the_Application_Id_Here` value and replace it with the **Application ID (clientId)** of the app you registered in the Microsoft Entra admin center.
    - In **authority**, find `Enter_the_Tenant_Subdomain_Here` and replace it with the subdomain of your tenant. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, [learn how to read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
1. Save the file.

1. Open *src/app/app.module.ts* and add the following code snippet.

    ```javascript
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
    This code initializes the MSAL instance and sets the default interaction type for MSALGuard. It also provides the necessary services and components for authentication.
---

## Add authentication code to the application

In this section, you'll add authentication code to the application to handle user authentication and session management. Choose the appropriate tab based on your tenant type.

### [Workforce tenant](#tab/workforce-tenant)

1. Open `src/app/app.component.ts` file and replace the contents with the following code:

    ```typescript
    // Required for Angular
    import { Component, OnInit, Inject, OnDestroy } from '@angular/core';
    
    // Required for MSAL
    import { MsalService, MsalBroadcastService, MSAL_GUARD_CONFIG, MsalGuardConfiguration } from '@azure/msal-angular';
    import { EventMessage, EventType, InteractionStatus, RedirectRequest } from '@azure/msal-browser';
    
    // Required for RJXS
    import { Subject } from 'rxjs';
    import { filter, takeUntil } from 'rxjs/operators';
    
    @Component({
      selector: 'app-root',
      templateUrl: './app.component.html'
    })
    export class AppComponent implements OnInit, OnDestroy {
      title = 'Angular - MSAL Example';
      loginDisplay = false;
      tokenExpiration: string = '';
      private readonly _destroying$ = new Subject<void>();
    
      constructor(
        @Inject(MSAL_GUARD_CONFIG) private msalGuardConfig: MsalGuardConfiguration,
        private authService: MsalService,
        private msalBroadcastService: MsalBroadcastService
      ) { }
    
      // On initialization of the page, display the page elements based on the user state
      ngOnInit(): void {
        this.msalBroadcastService.inProgress$
            .pipe(
            filter((status: InteractionStatus) => status === InteractionStatus.None),
            takeUntil(this._destroying$)
          )
          .subscribe(() => {
            this.setLoginDisplay();
          });
    
          // Used for storing and displaying token expiration
          this.msalBroadcastService.msalSubject$.pipe(filter((msg: EventMessage) => msg.eventType === EventType.ACQUIRE_TOKEN_SUCCESS)).subscribe(msg => {
          this.tokenExpiration=  (msg.payload as any).expiresOn;
          localStorage.setItem('tokenExpiration', this.tokenExpiration);
        });
      }
    
      // If the user is logged in, present the user with a "logged in" experience
      setLoginDisplay() {
        this.loginDisplay = this.authService.instance.getAllAccounts().length > 0;
      }
    
      // Log the user in and redirect them if MSAL provides a redirect URI otherwise go to the default URI
      login() {
        if (this.msalGuardConfig.authRequest) {
          this.authService.loginRedirect({ ...this.msalGuardConfig.authRequest } as RedirectRequest);
        } else {
          this.authService.loginRedirect();
        }
      }
    
      // Log the user out
      logout() {
        this.authService.logoutRedirect();
      }
    
      ngOnDestroy(): void {
        this._destroying$.next(undefined);
        this._destroying$.complete();
      }
    }
    ```

    The code integrates MSAL with Angular to manage user authentication. It listens for sign in status changes, displays the sign in state, handles token acquisition events, and provides methods to log users in or out based on Microsoft Entra configuration.

1. Save the file.

## [External tenant](#tab/external-tenant)

1. Open *src/app/app.component.ts* and replace the code with the following to sign in a user using a point of presence (POP)-up. This code uses the MSAL Angular library to sign in a user.

    ```javascript	
      import { Component, OnInit, Inject, OnDestroy } from '@angular/core';
      import {
        MsalService,
        MsalBroadcastService,
        MSAL_GUARD_CONFIG,
        MsalGuardConfiguration,
      } from '@azure/msal-angular';
      import {
        AuthenticationResult,
        InteractionStatus,
        InteractionType,
        PopupRequest,
        RedirectRequest,
        EventMessage,
        EventType
      } from '@azure/msal-browser';
      import { Subject } from 'rxjs';
      import { filter, takeUntil } from 'rxjs/operators';

      @Component({
        selector: 'app-root',
        templateUrl: './app.component.html',
        styleUrls: ['./app.component.css'],
      })
      export class AppComponent implements OnInit, OnDestroy {
        title = 'Microsoft identity platform';
        loginDisplay = false;
        isIframe = false;

        private readonly _destroying$ = new Subject<void>();

        constructor(
          @Inject(MSAL_GUARD_CONFIG) private msalGuardConfig: MsalGuardConfiguration,
          private authService: MsalService,
          private msalBroadcastService: MsalBroadcastService,
        ) { }

        ngOnInit(): void {
          this.isIframe = window !== window.parent && !window.opener;
          this.setLoginDisplay();
          this.authService.instance.enableAccountStorageEvents(); // Optional - This will enable ACCOUNT_ADDED and ACCOUNT_REMOVED events emitted when a user logs in or out of another tab or window

          /**
           * You can subscribe to MSAL events as shown below. For more info,
           * visit: https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-angular/docs/v2-docs/events.md
           */
          this.msalBroadcastService.inProgress$
            .pipe(
              filter(
                (status: InteractionStatus) => status === InteractionStatus.None
              ),
              takeUntil(this._destroying$)
            )
            .subscribe(() => {
              this.setLoginDisplay();
              this.checkAndSetActiveAccount();
            });

          this.msalBroadcastService.msalSubject$
            .pipe(
              filter(
                (msg: EventMessage) => msg.eventType === EventType.LOGOUT_SUCCESS
              ),
              takeUntil(this._destroying$)
            )
            .subscribe((result: EventMessage) => {
              this.setLoginDisplay();
              this.checkAndSetActiveAccount();
            });

          this.msalBroadcastService.msalSubject$
            .pipe(
              filter(
                (msg: EventMessage) => msg.eventType === EventType.LOGIN_SUCCESS
              ),
              takeUntil(this._destroying$)
            )
            .subscribe((result: EventMessage) => {
              const payload = result.payload as AuthenticationResult;
              this.authService.instance.setActiveAccount(payload.account);
            });
        }

        setLoginDisplay() {
          this.loginDisplay = this.authService.instance.getAllAccounts().length > 0;
        }

        checkAndSetActiveAccount() {
          /**
           * If no active account set but there are accounts signed in, sets first account to active account
           * To use active account set here, subscribe to inProgress$ first in your component
           * Note: Basic usage demonstrated. Your app may require more complicated account selection logic
           */
          let activeAccount = this.authService.instance.getActiveAccount();

          if (!activeAccount && this.authService.instance.getAllAccounts().length > 0) {
            let accounts = this.authService.instance.getAllAccounts();
            // add your code for handling multiple accounts here
            this.authService.instance.setActiveAccount(accounts[0]);
          }
        }

        login() {
          if (this.msalGuardConfig.interactionType === InteractionType.Popup) {
            if (this.msalGuardConfig.authRequest) {
              this.authService.loginPopup({
                ...this.msalGuardConfig.authRequest,
              } as PopupRequest)
                .subscribe((response: AuthenticationResult) => {
                  this.authService.instance.setActiveAccount(response.account);
                });
            } else {
              this.authService.loginPopup()
                .subscribe((response: AuthenticationResult) => {
                  this.authService.instance.setActiveAccount(response.account);
                });
            }
          } else {
            if (this.msalGuardConfig.authRequest) {
              this.authService.loginRedirect({
                ...this.msalGuardConfig.authRequest,
              } as RedirectRequest);
            } else {
              this.authService.loginRedirect();
            }
          }
        }

        logout() {

          if (this.msalGuardConfig.interactionType === InteractionType.Popup) {
            this.authService.logoutPopup({
              account: this.authService.instance.getActiveAccount(),
            });
          } else {
            this.authService.logoutRedirect({
              account: this.authService.instance.getActiveAccount(),
            });
          }
        }

        // unsubscribe to events when component is destroyed
        ngOnDestroy(): void {
          this._destroying$.next(undefined);
          this._destroying$.complete();
        }
      }
    ```
    This code listens for sign-in status changes, displays the sign-in state, and provides methods to log users in or out based on Microsoft Entra configuration.
---


## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Add sign in and sign out functional components in an Angular app](tutorial-single-page-apps-angular-sign-in-users-app.md)

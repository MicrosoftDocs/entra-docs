---
title: "Tutorial: Prepare an Angular Single-page Application"
description: Prepare an Angular Single-page Application in a Microsoft Entra tenant to manage authentication and secure user access.
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.date: 11/11/2024
ms.reviewer: ejahjaloo
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to create a new Angular project in an IDE and add authentication.
---

# Tutorial: Create an Angular application and prepare it for authentication

After registration is complete, an Angular project can be created using Angular CLI (Command Line Interface). This tutorial demonstrates how to create a single-page Angular application using the Angular CLI and create files needed for authentication and authorization.

In this tutorial:

> [!div class="checklist"]
> * Create a new Angular project
> * Configure the settings for the application
> * Add authentication code to the application

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Register an application](tutorial-single-page-apps-angular-register-app.md).
* [Install Agular CLI](https://v17.angular.io/cli#installing-angular-cli)
* [Install Node.js](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/)

## Create a new Angular project

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

## Configure the settings for the application

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

## Add authentication code to the application

To handle user authentication and session management using [MSAL Angular](/javascript/api/%40azure/msal-angular/), you'll need to update `src/app/app.component.ts`.

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

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Add sign in and sign out functional components in an Angular app](tutorial-single-page-apps-angular-sign-in-users-app.md)

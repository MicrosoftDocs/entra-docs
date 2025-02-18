---
title: "Tutorial: Prepare an Angular Single-page Application"
description: Prepare an Angular Single-page Application in a Microsoft Entra tenant to manage authentication and secure user access.
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.date: 01/20/2025
ms.reviewer: ejahjaloo
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to create a new Angular project in an IDE and add authentication.
---

# Tutorial: Create an Angular application and prepare it for authentication

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll build a Angular single-page application (SPA) and prepare it for authentication using the Microsoft identity platform. This tutorial demonstrates how to create a single-page Angular application using the Angular CLI and create files needed for authentication and authorization. 

In this tutorial: 

> [!div class="checklist"]
> * Create a new Angular project
> * Configure the settings for the application
> * Add authentication code to the application

## Prerequisites

* [Angular CLI](https://v17.angular.io/cli#installing-angular-cli)
* [Node.js](https://nodejs.org/en/download/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* A new app registration in the Microsoft Entra admin center with the following configuration. For more information, see [Register an application](quickstart-register-app.md).
    * **Name**: identity-client-spa
    * **Supported account types**: *Accounts in this organizational directory only (Single tenant).*
    * **Platform configuration**: Single-page application (SPA).
    * **Redirect URI**: `http://localhost:3000/`.
* (External Only) A user flow which has been associated with your app registration. For more information, see [Create self-service sign-up user flows for apps in external tenants](../external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) and [Add your application to the user flow](../external-id/customers/how-to-user-flow-add-application.md).

### [Workforce tenant](#tab/workforce-tenant)

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

###

## Create an Angular project

In this section we will create a new Angular project using the Angular CLI in Visual Studio Code.

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

## Configure UI elements

The following steps configure the UI elements of the application. CSS styling is added to the application to define the colors and fonts. The application header and footer are defined in the HTML file and CSS styling is added to the home page of the application.

1. Open *src/styles.css* and replace the existing code with the following code snippet.

    ```css
    @import '~@angular/material/prebuilt-themes/deeppurple-amber.css';
    html, body { height: 100%; }
    body { margin: 0; font-family: Roboto, "Helvetica Neue", sans-serif; }
    ```

1. Open *src/app/app.component.html* and replace the existing code with the following code snippet.

    ```html
      <mat-toolbar color="primary">
          <a class="title" href="/">{{ title }}</a>
          <div class="toolbar-spacer"></div>
          <a mat-button [routerLink]="['guarded']">Guarded Component</a>
          <button mat-raised-button *ngIf="!loginDisplay" (click)="login()">Login</button>
          <button mat-raised-button color="accent" *ngIf="loginDisplay" (click)="logout()">Logout</button>
        </mat-toolbar>
        <div class="container">
          <!--This is to avoid reload during acquireTokenSilent() because of hidden iframe -->
          <router-outlet *ngIf="!isIframe"></router-outlet>
        </div>
        <footer *ngIf="loginDisplay">
          <mat-toolbar>
            <div class="footer-text"> How did we do? <a
                href="https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR_ivMYEeUKlEq8CxnMPgdNZUNDlUTTk2NVNYQkZSSjdaTk5KT1o4V1VVNS4u"
                target="_blank"> Share your experience with us!</a>
            </div>
          </mat-toolbar>
        </footer>
    ```

1. Open *src/app/app.component.css* and replace the code with the following snippet.

    ```css
    .toolbar-spacer {
      flex: 1 1 auto;
    }

    a.title {
      color: white;
    }

    footer {
      position: fixed;
      left: 0;
      bottom: 0;
      width: 100%;
      color: white;
      text-align: center;
    }

    .footer-text {
      font-size: small;
      text-align: center;
      flex: 1 1 auto;
    }
    ```

## Configure application components

In this section you'll configure the home and guarded components of the application. The home component is the landing page of the application and the guarded component is the page that is only accessible to authenticated users.

1. Open *src/app/home/home.component.ts* and replace the existing code with the following code snippet.

    ```javascript
    import { Component, Inject, OnInit } from '@angular/core';
    import { Subject } from 'rxjs';
    import { filter } from 'rxjs/operators';

    import { MsalBroadcastService, MsalGuardConfiguration, MsalService, MSAL_GUARD_CONFIG } from '@azure/msal-angular';
    import { AuthenticationResult, InteractionStatus, InteractionType } from '@azure/msal-browser';

    import { createClaimsTable } from '../claim-utils';

    @Component({
      selector: 'app-home',
      templateUrl: './home.component.html',
      styleUrls: ['./home.component.css'],
    })
    export class HomeComponent implements OnInit {
      loginDisplay = false;
      dataSource: any = [];
      displayedColumns: string[] = ['claim', 'value', 'description'];

      private readonly _destroying$ = new Subject<void>();

      constructor(
        @Inject(MSAL_GUARD_CONFIG)
        private msalGuardConfig: MsalGuardConfiguration,
        private authService: MsalService,
        private msalBroadcastService: MsalBroadcastService
      ) { }

      ngOnInit(): void {

        this.msalBroadcastService.inProgress$
          .pipe(
            filter((status: InteractionStatus) => status === InteractionStatus.None)
          )
          .subscribe(() => {
            this.setLoginDisplay();
            this.getClaims(
              this.authService.instance.getActiveAccount()?.idTokenClaims
            );
          });
      }

      setLoginDisplay() {
        this.loginDisplay = this.authService.instance.getAllAccounts().length > 0;
      }

      getClaims(claims: any) {
        if (claims) {
          const claimsTable = createClaimsTable(claims);
          this.dataSource = [...claimsTable];
        }
      }

      signUp() {
        if (this.msalGuardConfig.interactionType === InteractionType.Popup) {
          this.authService.loginPopup({
            scopes: [],
            prompt: 'create',
          })
            .subscribe((response: AuthenticationResult) => {
              this.authService.instance.setActiveAccount(response.account);
            });
        } else {
          this.authService.loginRedirect({
            scopes: [],
            prompt: 'create',
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

1. Open *src/app/home/home.component.html* and replace the existing code with the following code snippet. This code defines the HTML elements of the home page of the application.

    ```html
    <mat-card class="card-section" *ngIf="!loginDisplay">
      <mat-card-title>Angular single-page application built with MSAL Angular</mat-card-title>
      <mat-card-subtitle>Sign in with Microsoft Entra External ID</mat-card-subtitle>
      <mat-card-content>This sample demonstrates how to configure MSAL Angular to sign up, sign in and sign out with Microsoft Entra External ID</mat-card-content>
      <button mat-raised-button color="primary" (click)="signUp()">Sign up</button>
    </mat-card>
    <br>
    <p class="text-center" *ngIf="loginDisplay"> See below the claims in your <strong> ID token </strong>. For more
      information, visit: <span>
        <a href="https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens#claims-in-an-id-token">
          docs.microsoft.com </a>
      </span>
    </p>
    <div id="table-container">
      <table mat-table [dataSource]="dataSource" class="mat-elevation-z8" *ngIf="loginDisplay">
        <!-- Claim Column -->
        <ng-container matColumnDef="claim">
          <th mat-header-cell *matHeaderCellDef> Claim </th>
          <td mat-cell *matCellDef="let element"> {{element.claim}} </td>
        </ng-container>
        <!-- Value Column -->
        <ng-container matColumnDef="value">
          <th mat-header-cell *matHeaderCellDef> Value </th>
          <td mat-cell *matCellDef="let element"> {{element.value}} </td>
        </ng-container>
        <!-- Value Column -->
        <ng-container matColumnDef="description">
          <th mat-header-cell *matHeaderCellDef> Description </th>
          <td mat-cell *matCellDef="let element"> {{element.description}} </td>
        </ng-container>
        <tr mat-header-row *matHeaderRowDef="displayedColumns sticky: true"></tr>
        <tr mat-row *matRowDef="let row; columns: displayedColumns;"></tr>
      </table>
    </div>
    ```

1. Open *src/app/home/home.component.css*. Replace any existing code with the following code snippet.

    ```css
    #table-container {
      height: '100vh';
      overflow: auto;
    }

    table {
      margin: 3% auto 1% auto;
      width: 70%;
    }

    .mat-row {
      height: auto;
    }

    .mat-cell {
      padding: 8px 8px 8px 0;
    }

    p {
      text-align: center;
    }

    .card-section {
      margin: 10%;
      padding: 5%;
    }
    ```

1. Open *src/app/guarded/guarded.component.ts* and replace the existing code with the following code snippet.

    ```javascript
    import { Component, OnInit } from '@angular/core';

    @Component({
      selector: 'app-guarded',
      templateUrl: './guarded.component.html',
      styleUrls: ['./guarded.component.css']
    })
    export class GuardedComponent implements OnInit {

      constructor() { }

      ngOnInit(): void {
      }

    }
    ```

1. Create a file called *claim-utils.ts* in the *src/app/* folder and paste the following code snippet into it.

    ```javascript
    /**
     * Populate claims table with appropriate description
     * @param {Record} claims ID token claims
     * @returns claimsTable
     */
    export const createClaimsTable = (claims: Record<string, string>): any[] => {
      const claimsTable: any[] = [];

      Object.keys(claims).map((key) => {
        switch (key) {
          case 'aud':
            populateClaim(
              key,
              claims[key],
              "Identifies the intended recipient of the token. In ID tokens, the audience is your app's Application ID, assigned to your app in the Azure portal.",
              claimsTable
            );
            break;
          case 'iss':
            populateClaim(
              key,
              claims[key],
              'Identifies the issuer, or authorization server that constructs and returns the token. It also identifies the Azure AD tenant for which the user was authenticated. If the token was issued by the v2.0 endpoint, the URI will end in /v2.0.',
              claimsTable
            );
            break;
          case 'iat':
            populateClaim(
              key,
              changeDateFormat(+claims[key]),
              '"Issued At" indicates the timestamp (UNIX timestamp) when the authentication for this user occurred.',
              claimsTable
            );
            break;
          case 'nbf':
            populateClaim(
              key,
              changeDateFormat(+claims[key]),
              'The nbf (not before) claim dictates the time (as UNIX timestamp) before which the JWT must not be accepted for processing.',
              claimsTable
            );
            break;
          case 'exp':
            populateClaim(
              key,
              changeDateFormat(+claims[key]),
              "The exp (expiration time) claim dictates the expiration time (as UNIX timestamp) on or after which the JWT must not be accepted for processing. It's important to note that in certain circumstances, a resource may reject the token before this time. For example, if a change in authentication is required or a token revocation has been detected.",
              claimsTable
            );
            break;
          case 'name':
            populateClaim(
              key,
              claims[key],
              "The name claim provides a human-readable value that identifies the subject of the token. The value isn't guaranteed to be unique, it can be changed, and it's designed to be used only for display purposes. The 'profile' scope is required to receive this claim.",
              claimsTable
            );
            break;
          case 'preferred_username':
            populateClaim(
              key,
              claims[key],
              'The primary username that represents the user. It could be an email address, phone number, or a generic username without a specified format. Its value is mutable and might change over time. Since it is mutable, this value must not be used to make authorization decisions. It can be used for username hints, however, and in human-readable UI as a username. The profile scope is required in order to receive this claim.',
              claimsTable
            );
            break;
          case 'nonce':
            populateClaim(
              key,
              claims[key],
              'The nonce matches the parameter included in the original /authorize request to the IDP.',
              claimsTable
            );
            break;
          case 'oid':
            populateClaim(
              key,
              claims[key],
              'The oid (user object id) is the only claim that should be used to uniquely identify a user in an Azure AD tenant.',
              claimsTable
            );
            break;
          case 'tid':
            populateClaim(
              key,
              claims[key],
              'The id of the tenant where this application resides. You can use this claim to ensure that only users from the current Azure AD tenant can access this app.',
              claimsTable
            );
            break;
          case 'upn':
            populateClaim(
              key,
              claims[key],
              'upn (user principal name) might be unique amongst the active set of users in a tenant but tend to get reassigned to new employees as employees leave the organization and others take their place or might change to reflect a personal change like marriage.',
              claimsTable
            );
            break;
          case 'email':
            populateClaim(
              key,
              claims[key],
              'Email might be unique amongst the active set of users in a tenant but tend to get reassigned to new employees as employees leave the organization and others take their place.',
              claimsTable
            );
            break;
          case 'acct':
            populateClaim(
              key,
              claims[key],
              'Available as an optional claim, it lets you know what the type of user (homed, guest) is. For example, for an individual's access to their data you might not care for this claim, but you would use this along with tenant id (tid) to control access to say a company-wide dashboard to just employees (homed users) and not contractors (guest users).',
              claimsTable
            );
            break;
          case 'sid':
            populateClaim(
              key,
              claims[key],
              'Session ID, used for per-session user sign-out.',
              claimsTable
            );
            break;
          case 'sub':
            populateClaim(
              key,
              claims[key],
              'The sub claim is a pairwise identifier - it is unique to a particular application ID. If a single user signs into two different apps using two different client IDs, those apps will receive two different values for the subject claim.',
              claimsTable
            );
            break;
          case 'ver':
            populateClaim(
              key,
              claims[key],
              'Version of the token issued by the Microsoft identity platform',
              claimsTable
            );
            break;
          case 'login_hint':
            populateClaim(
              key,
              claims[key],
              'An opaque, reliable login hint claim. This claim is the best value to use for the login_hint OAuth parameter in all flows to get SSO.',
              claimsTable
            );
            break;
          case 'idtyp':
            populateClaim(
              key,
              claims[key],
              'Value is app when the token is an app-only token. This is the most accurate way for an API to determine if a token is an app token or an app+user token',
              claimsTable
            );
            break;
          case 'uti':
          case 'rh':
            break;
          default:
            populateClaim(key, claims[key], '', claimsTable);
        }
      });

      return claimsTable;
    };

    /**
     * Populates claim, description, and value into an claimsObject
     * @param {String} claim
     * @param {String} value
     * @param {String} description
     * @param {Array} claimsObject
     */
    const populateClaim = (
      claim: string,
      value: string,
      description: string,
      claimsTable: any[]
    ): void => {
      claimsTable.push({
        claim: claim,
        value: value,
        description: description,
      });
    };

    /**
     * Transforms Unix timestamp to date and returns a string value of that date
     * @param {number} date Unix timestamp
     * @returns
     */
    const changeDateFormat = (date: number) => {
      let dateObj = new Date(date * 1000);
      return `${date} - [${dateObj.toString()}]`;
    };
    ```

1. Open *src/index.html* and replace the code with the following snippet.

    ```html
    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Microsoft identity platform</title>
      <base href="/">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="icon" type="image/x-icon" href="favicon.svg">
      <link rel="preconnect" href="https://fonts.gstatic.com">
      <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body class="mat-typography">
      <app-root></app-root>
      <app-redirect></app-redirect>
    </body>
    </html>
    ```

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Add sign in and sign out functional components in an Angular app](tutorial-single-page-apps-angular-sign-in-users-app.md)

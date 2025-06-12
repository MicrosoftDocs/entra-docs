---
title: "Tutorial: Sign in user in Angular single-page app (SPA)"
description: Sign in user in an Angular single-page app (SPA) in a Microsoft Entra tenant to manage authentication and secure user access.
author: garrodonnell
manager: dougeby
ms.author: godonnell
ms.date: 02/20/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to use functional components to add sign in and sign out experiences in my Angular application.
---

# Tutorial: Add sign in and sign out in your Angular single-page application

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial is part 2 of a series that demonstrates building an Angular single-page application (SPA) and adding authentication using the Microsoft identity platform.  In [Part 1 of this series](tutorial-single-page-apps-angular-prepare-app.md), you created an Angular SPA and added initial configurations. 

In this tutorial, you:

> [!div class="checklist"]
>
> * Add sign-in and sign-out

## Prerequisites

- Completion of the prerequisites and steps in [Tutorial: Create an Angular single-page application](tutorial-single-page-apps-angular-prepare-app.md)

## Add sign-in and sign-out functionality to your app

In this section you'll add components to support sign-in and sign-out functionality in your Angular application. These components enable users to authenticate and manage their sessions. You'll add routing to the application to direct users to the appropriate components based on their authentication status.

### [Workforce tenant](#tab/workforce-tenant)

To enable sign-in and sign-out functionality in your Angular application, follow these steps:

1. Open the `src/app/app.component.html` file and replace the contents with the following code. 

    ```html
    <a class="navbar navbar-dark bg-primary" variant="dark" href="/">
        <a class="navbar-brand"> Microsoft Identity Platform </a>
        <a>
            <button *ngIf="!loginDisplay" class="btn btn-secondary" (click)="login()">Sign In</button>
            <button *ngIf="loginDisplay" class="btn btn-secondary" (click)="logout()">Sign Out</button>
        </a>
    </a>
    <a class="profileButton">
        <a [routerLink]="['profile']" class="btn btn-secondary" *ngIf="loginDisplay">View Profile</a> 
    </a>
    <div class="container">
        <router-outlet></router-outlet>
    </div>
    ```

    The code implements a navigation bar in an Angular app. It dynamically displays **Sign In** and **Sign Out** buttons based on user authentication status and includes a **View Profile** button for logged-in users, enhancing the application's user interface. The `login()` and `logout()` methods in `src/app/app.component.ts` are called when the buttons are selected.

1. Open the `src/app/app-routing.module.ts` file and replace the contents with the following code.
    
    ```typescript
    // Required for Angular
    import { NgModule } from '@angular/core';
    
    // Required for the Angular routing service
    import { Routes, RouterModule } from '@angular/router';
    
    // Required for the "Profile" page
    import { ProfileComponent } from './profile/profile.component';
    
    // Required for the "Home" page
    import { HomeComponent } from './home/home.component';
    
    // MsalGuard is required to protect routes and require authentication before accessing protected routes
    import { MsalGuard } from '@azure/msal-angular';
    
    // Define the possible routes
    // Specify MsalGuard on routes to be protected
    // '**' denotes a wild card
    const routes: Routes = [
      {
        path: 'profile',
        component: ProfileComponent,
        canActivate: [
          MsalGuard
        ]
      },
      {
        path: '**',
        component: HomeComponent
      }
    ];
    
    // Create an NgModule that contains all the directives for the routes specified above
    @NgModule({
      imports: [RouterModule.forRoot(routes, {
        useHash: true
      })],
      exports: [RouterModule]
    })
    export class AppRoutingModule { }
    ```

    The code snippet configures routing in an Angular application by establishing paths for the **Profile** and **Home** components. It uses `MsalGuard` to enforce authentication on the **Profile** route, while all unmatched paths redirect to the **Home** component.

1. Open the `src/app/home/home.component.ts` file and replace the contents with the following code.

    ```typescript
    // Required for Angular
    import { Component, OnInit } from '@angular/core';
    
    // Required for MSAL
    import { MsalBroadcastService, MsalService } from '@azure/msal-angular';
    
    // Required for Angular multi-browser support
    import { EventMessage, EventType, AuthenticationResult } from '@azure/msal-browser';
    
    // Required for RJXS observables
    import { filter } from 'rxjs/operators';
    
    @Component({
      selector: 'app-home',
      templateUrl: './home.component.html'
    })
    export class HomeComponent implements OnInit {
      constructor(
        private authService: MsalService,
        private msalBroadcastService: MsalBroadcastService
      ) { }
    
      // Subscribe to the msalSubject$ observable on the msalBroadcastService
      // This allows the app to consume emitted events from MSAL
      ngOnInit(): void {
        this.msalBroadcastService.msalSubject$
          .pipe(
            filter((msg: EventMessage) => msg.eventType === EventType.LOGIN_SUCCESS),
          )
          .subscribe((result: EventMessage) => {
            const payload = result.payload as AuthenticationResult;
            this.authService.instance.setActiveAccount(payload.account);
          });
      }
    }
    ```
    
    The code sets up an Angular component called `HomeComponent` that integrates with the Microsoft Authentication Library (MSAL). In the `ngOnInit` lifecycle hook, the component subscribes to the `msalSubject$` observable from `MsalBroadcastService`, filtering for login success events. When a login event occurs, it retrieves the authentication result and sets the active account in the `MsalService`, enabling the application to manage user sessions.

1. Open the `src/app/home/home.component.html` file and replace the contents with the following code.

    ```html
    <div class="title">
        <h5>
            Welcome to the Microsoft Authentication Library For JavaScript - Angular SPA
        </h5>
        <p >View your data from Microsoft Graph by clicking the "View Profile" link above.</p>
    </div>
    ```
  
    The code welcomes users to the app and prompts them to view their Microsoft Graph data by clicking the **View Profile** link.

1. Open the `src/main.ts` file and replace the contents with the following code.

    ```typescript
    import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

    import { AppModule } from './app/app.module';
    
    platformBrowserDynamic().bootstrapModule(AppModule)
      .catch(err => console.error(err));
    ```
    
    The code snippet imports `platformBrowserDynamic` from Angular's platform browser dynamic module and `AppModule` from the application's module file. It then uses `platformBrowserDynamic()` to bootstrap the `AppModule`, initializing the Angular application. Any errors that occur during the bootstrap process are caught and logged to the console.

1. Open the `src/index.html` file and replace the contents with the following code.

    ```html
    <!doctype html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <title>MSAL For JavaScript - Angular SPA</title>
      </head>
      <body>
        <app-root></app-root>
        <app-redirect></app-redirect>
      </body>
    </html>
    ```

    The code snippet defines an HTML5 document with English as the language and UTF-8 character encoding. It sets the title to "MSAL For JavaScript - Angular SPA." The body includes the `<app-root>` component as the main entry point and the `<app-redirect>` component for redirection functionalities.

1. Open the `src/styles.css` file and replace the contents with the following code.

    ```css
    body {
      margin: 0;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
        'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
        sans-serif;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
    
    code {
      font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
        monospace;
    }
    
    .app {
      text-align: center;
      padding: 8px;
    }
    
    .title{
      text-align: center;
      padding: 18px;
    }
    
    
    .profile{
      text-align: center;
      padding: 18px;
    }
    
    .profileButton{
      display: flex;
      justify-content: center;
      padding: 18px;
    }
    ```

    The CSS code styles the webpage by setting the body font to a modern sans-serif stack, removing default margins, and applying font smoothing for enhanced readability. It centers text and adds padding to the `.app`, `.title`, and `.profile` classes, while the `.profileButton` class uses flexbox to center its elements.

### [External tenant](#tab/external-tenant)

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
    This code snippet adds a navigation bar to the Angular application. The navigation bar includes a title and **Login** and **Logout** buttons which enable users to sign in and out of the application.

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
    This code snippet styles the navigation bar and footer of the Angular application. It sets the color of the title to white, aligns the footer text to the center, and adjusts the size of the footer text. 

1. Open *src/app/app-routing.module.ts* and replace the entire contents of the file with the following snippet. This will add routes to the `home` and `guarded` components.

    ```javascript	
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
1. Open *src/styles.css* and replace the existing code with the following code snippet.

    ```css
    @import '~@angular/material/prebuilt-themes/deeppurple-amber.css';
    html, body { height: 100%; }
    body { margin: 0; font-family: Roboto, "Helvetica Neue", sans-serif; }
    ```
    This code snippet imports the Angular Material prebuilt theme and sets the height of the HTML and body elements. It removes the default margin and sets the font family.

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

    This code snippet defines the `HomeComponent` class, which is responsible for managing the home page of the Angular application. The component subscribes to the `inProgress$` observable from `MsalBroadcastService` to monitor the authentication status of the application. When the authentication status changes, the component updates the login display and retrieves the claims from the active account's ID token. The `signUp()` method is called when the user clicks the **Sign up** button, initiating the authentication process.

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
    This code snippet defines the HTML elements of the home page of the Angular application. It includes a card section with a **Sign up** button for users to authenticate with Microsoft Entra External ID. 

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
    This code snippet styles the HTML elements of the home page of the Angular application. It sets the height and overflow properties of the table container, adjusts the margin and width of the table, and aligns the text in the paragraph element.
---
    
## Next step

> [!div class="nextstepaction"]
> [Tutorial: Tutorial: Extract user data with an Angular SPA](tutorial-single-page-apps-angular-extract-user-data.md)

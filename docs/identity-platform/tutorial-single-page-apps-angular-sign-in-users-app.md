---
title: "Tutorial: Sign in user in Angular Single-page Application"
description: Sign in user in an Angular Single-page Application in a Microsoft Entra tenant to manage authentication and secure user access.
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.date: 10/22/2024
ms.reviewer: emilylauber
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to use functional components to add sign in and sign out experiences in my Angular application.
---

# Tutorial: Add sign in and sign out in your Angular single-page application

This tutorial is part 3 of a series that demonstrates building an Angular single-page app (SPA), which uses the Microsoft identity platform for authentication. In this tutorial, you'll add sign in and sign out experiences to your Angular SPA. 

In this tutorial:

> [!div class="checklist"]
>
> * Add sign-in and sign-out functionality to your app.

## Prerequisites

- [Tutorial: Create an Angular single-page application](tutorial-single-page-apps-angular-prepare-app.md)

## Add sign-in and sign-out functionality to your app

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
            Welcome to the Microsoft Authentication Library For Javascript - Angular SPAx
        </h5>
        <p >View your data from Microsoft Graph by clicking the "View Profile" link above.</p>
    </div>
    ```

    
    The code welcomes users to the MSAL for JavaScript and prompts them to view their Microsoft Graph data by clicking the **View Profile** link.

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
        <title>MSAL For Javascript - Angular SPA</title>
      </head>
      <body>
        <app-root></app-root>
        <app-redirect></app-redirect>
      </body>
    </html>
    ```

    The code snippet defines an HTML5 document with English as the language and UTF-8 character encoding. It sets the title to "MSAL For Javascript - Angular SPA." The body includes the `<app-root>` component as the main entry point and the `<app-redirect>` component for redirection functionalities.

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

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Call an API from an Angular single-page app](tutorial-single-page-apps-angular-call-api.md)

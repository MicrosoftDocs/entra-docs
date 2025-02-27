---
title: "Tutorial: Prepare an Angular SPA for authentication in an external tenant"
description: Learn how to prepare an Angular single-page app (SPA) for authentication with your external tenant.
author: garrodonnell
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 10/27/2023
ms.author: godonnell
#Customer intent: As a dev, DevOps, or IT admin, I want to learn how to create an Angular single-page app and define basic components and UI elements
---

# Tutorial: Prepare an Angular SPA for authentication in an external tenant

This tutorial is part 2 of a series that demonstrates building an Angular single-page application (securing privileged access (SPA)) and preparing it for authentication using the Microsoft Entra admin center. In [Part 1 of this series](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md), you registered an application and configured user flows in your external tenant. This tutorial demonstrates how to create an Angular SPA using `npm` and create files needed for authentication and authorization.

In this tutorial;

> [!div class="checklist"]
> - Create an Angular project in Visual Studio Code
> - Configure the user interface for the application
> - Configure the home and guarded components

## Prerequisites

- [Tutorial: Prepare your external tenant to authenticate users in an Angular SPA](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md).
- Although any integrated development environment (IDE) that supports React applications can be used, this tutorial uses [Visual Studio Code](https://visualstudio.microsoft.com/downloads/).
- [Node.js](https://nodejs.org/en/download/).

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

## Next step

> [!div class="nextstepaction"]
> [Part 3: Handle authentication flows in an Angular SPA](tutorial-single-page-app-angular-sign-in-configure-authentication.md)

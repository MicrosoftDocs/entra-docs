---
title: "Tutorial: Extract user data with an Angular single-page app (SPA)"
description: Learn how extract user data using an Angular single-page app (SPA).
author: garrodonnell
manager: celested
ms.author: godonnell
ms.date: 02/20/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to call an API from an Angular single-page app in a Microsoft Entra tenant.
---

# Tutorial: Extract user data with an Angular SPA

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial is the final part of a series that demonstrates building an Angular single-page application (SPA) and adding authentication using the Microsoft identity platform. In [Part 2 of this series](tutorial-single-page-apps-angular-sign-in-users-app.md), you created an Angular SPA and prepared it for authentication with your workforce tenant. 

In this tutorial, you

> [!div class="checklist"]
> * Add data processing to your Angular application.
> * Test the application and extract user data.

## Prerequisites

- [Tutorial: Add sign in and sign out in your Angular single-page application](tutorial-single-page-apps-angular-sign-in-users-app.md)

## Extract data to view in the application UI

### [Workforce tenant](#tab/workforce-tenant)

To configure your Angular application to interact with the Microsoft Graph API, complete the following steps:

1. Open the `src/app/profile/profile.component.ts` file and replace the contents with the following code snippet:

    ```typescript
    // Required for Angular
    import { Component, OnInit } from '@angular/core';
    
    // Required for the HTTP GET request to Graph
    import { HttpClient } from '@angular/common/http';
    
    type ProfileType = {
      businessPhones?: string,
      displayName?: string,
      givenName?: string,
      jobTitle?: string,
      mail?: string,
      mobilePhone?: string,
      officeLocation?: string,
      preferredLanguage?: string,
      surname?: string,
      userPrincipalName?: string,
      id?: string
    }
    
    @Component({
      selector: 'app-profile',
      templateUrl: './profile.component.html'
    })
    export class ProfileComponent implements OnInit {
      profile!: ProfileType;
      tokenExpiration!: string;
    
      constructor(
        private http: HttpClient
      ) { }
    
      // When the page loads, perform an HTTP GET request from the Graph /me endpoint
      ngOnInit() {
        this.http.get('https://graph.microsoft.com/v1.0/me')
          .subscribe(profile => {
            this.profile = profile;
          });
    
        this.tokenExpiration = localStorage.getItem('tokenExpiration')!;
      }
    }
    ```
    
    The `ProfileComponent` in Angular fetches user profile data from Microsoft Graph's `/me` endpoint. It defines `ProfileType` to structure properties like `displayName` and `mail`. In `ngOnInit`, it uses `HttpClient` to send a GET request, assigning the response to `profile`. It also retrieves and stores the token expiration time from `localStorage` in `tokenExpiration`.

1. Open the `src/app/profile/profile.component.html` file and replace the contents with the following code snippet:

    ```html
    <div class="profile">
        <p><strong>Business Phones:</strong> {{profile?.businessPhones}}</p>
        <p><strong>Display Name:</strong> {{profile?.displayName}}</p>
        <p><strong>Given Name:</strong> {{profile?.givenName}}</p>
        <p><strong>Job Title:</strong> {{profile?.jobTitle}}</p>
        <p><strong>Mail:</strong> {{profile?.mail}}</p>
        <p><strong>Mobile Phone:</strong> {{profile?.mobilePhone}}</p>
        <p><strong>Office Location:</strong> {{profile?.officeLocation}}</p>
        <p><strong>Preferred Language:</strong> {{profile?.preferredLanguage}}</p>
        <p><strong>Surname:</strong> {{profile?.surname}}</p>
        <p><strong>User Principal Name:</strong> {{profile?.userPrincipalName}}</p>
        <p><strong>Profile Id:</strong> {{profile?.id}}</p>
        <br><br>
        <p><strong>Token Expiration:</strong> {{tokenExpiration}}</p>
        <br><br>
        <p>Refreshing this page will continue to use the cached access token until it nears expiration, at which point a new access token will be requested.</p>
    </div>
    ```
    
    This code defines an HTML template that displays user profile information, using Angular's interpolation syntax to bind properties from the `profile` object (For example., `businessPhones`, `displayName`, `jobTitle`). It also shows the `tokenExpiration` value and includes a note stating that refreshing the page will use the cached access token until it nears expiration, after which a new token will be requested.

### [External tenant](#tab/external-tenant)

You will configure your Angular app to display the claims in your ID token upon signing in. 

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
              'Available as an optional claim, it lets you know what the type of user (homed, guest) is. For example, for an individuals access to their data you might not care for this claim, but you would use this along with tenant id (tid) to control access to say a company-wide dashboard to just employees (homed users) and not contractors (guest users).',
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
---

## Test the application

For the application to work, you need to run the Angular application and sign in to authenticate with your Microsoft Entra tenant and extract user data.

### [Workforce tenant](#tab/workforce-tenant)

To test the application, complete the following steps:

1. Run the Angular application by executing the following command in the terminal:

    ```bash
    ng serve --open
    ```

1. Select the **Sign in** button to authenticate with your Microsoft Entra tenant.
1. After signing in, select the **View Profile** link to navigate to the **Profile** page. Verify that the user profile information is displayed, including the user's name, email, job title, and other details.

    :::image type="content" source="./media/tutorial/angular-spa/tutorial-angular-spa-sign-in.png" alt-text="Screenshot of JavaScript App depicting the results of the API call.":::

1. Select the **Sign out** button to sign out of the application.

## [External tenant](#tab/external-tenant)

1. Start the web server by running the following commands at a command-line prompt from the application folder:

    ```bash	
    npm install
    npm start
    ```

1. In your browser, enter `http://localhost:4200` to open the application.

    :::image type="content" source="./media/single-page-app-tutorial-04-call-api/angular-01-not-signed-in.png" alt-text="Screenshot of a web browser displaying sign-in dialog":::

1. Select the **Login** button in the top right corner of the screen.
1. After you're signed in, you'll see your profile information displayed on the page.

    :::image type="content" source="./media/single-page-app-tutorial-04-call-api/angular-02-signed-in.png" alt-text="Web browser displaying signed in app":::

1. Select the **Logout** button in the top right corner of the screen to sign out.

---

## Next steps

Learn how to use the Microsoft identity platform by trying out the following tutorial series on how to build a web API.

> [!div class="nextstepaction"]
> [Tutorial: Register a web API with the Microsoft identity platform](web-api-tutorial-01-register-app.md)

---
title: "Tutorial: Call an API from an Angular single-page app"
description: Call an API from an Angular single-page app in a Microsoft Entra tenant. Learn secure access and data retrieval steps.
author: henrymbuguakiarie
manager: mwongerapk
ms.author: henrymbugua
ms.date: 10/22/2024
ms.reviewer: emilylauber
ms.service: identity-platform

ms.topic: tutorial
#Customer intent: As an Angular developer, I want to know how to call an API from an Angular single-page app in a Microsoft Entra tenant.
---

# Tutorial: Call an API from an Angular single-page app

This tutorial is part 4 of a series that demonstrates building an Angular single-page app (SPA), which uses the Microsoft identity platform for authentication. In this tutorial, you call Microsoft Graph API from your Angular SPA.

In this tutorial:

> [!div class="checklist"]
> * Create the API call to Microsoft Graph


## Prerequisites

- [Tutorial: Add sign in and sign out in your Angular single-page application](tutorial-single-page-apps-angular-sign-in-users-app.md)

## Create the API call to Microsoft Graph

To configure your Angular application to interact with the Microsoft Graph API, complete the following steps:

1. Open the `src/app/app.module.ts` file and add the following code snippet:

    ```typescript
    // MSAL Interceptor is required to request access tokens in order to access the protected resource (Graph)
    export function MSALInterceptorConfigFactory(): MsalInterceptorConfiguration {
      const protectedResourceMap = new Map<string, Array<string>>();
      protectedResourceMap.set('https://graph.microsoft.com/v1.0/me', ['user.read']);
    
      return {
        interactionType: InteractionType.Redirect,
        protectedResourceMap
      };
    }
    ```
    
    The `MSALInterceptorConfigFactory` function configures the MSAL Interceptor to request access tokens for protected resources. It creates a `protectedResourceMap`, linking the Microsoft Graph API endpoint `https://graph.microsoft.com/v1.0/me` with the `user.read` permission. The function then returns an `MsalInterceptorConfiguration` that specifies `Redirect` for `interactionType` and includes the `protectedResourceMap`, allowing the interceptor to add access tokens to API requests automatically.

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

## Next steps

Learn how to use the Microsoft identity platform by trying out the following tutorial series on how to build a web API.

> [!div class="nextstepaction"]
> [Tutorial: Register a web API with the Microsoft identity platform](web-api-tutorial-01-register-app.md)

---
title: Tutorial - Add sign-in and sign-out to an Angular single-page app (SPA) for a customer tenant
description: Learn how to configure an Angular single-page app (SPA) to sign in and sign out users with your Microsoft Entra External ID for customers tenant.
services: active-directory
author: godonnell
manager: celestedg

ms.service: active-directory
ms.subservice: ciam
ms.topic: tutorial
ms.date: 27/10/2023
ms.author: godonnell

#Customer intent: As a developer I want to add sign-in and sign-out functionality to my Angular single-page app
---

# Tutorial: Add sign-in and sign-out to an Angular single-page app (SPA) for a customer tenant

In the [previous article](./tutorial-single-page-app-angular-sign-in-configure-authentication.md), you added authentication flows to your Angular single page application and configured them to work with your Microsoft Entra External ID for customers tenant. In this article, you'll learn how to add sign-in and sign-out functionality to the application. Finally, you'll test the application.

In this tutorial;

> [!div class="checklist"]
> * Add sign-in and sign-out functionality to your app.
> * Test the application

## Sign in using pop-ups
      
1. Open _src/app/app.component.ts_ and replace the code with the following to sign in a user using a pop-up:

    ```javascript	
    import { Component, OnInit, Inject, OnDestroy } from '@angular/core';
    import { MsalService, MsalBroadcastService, MSAL_GUARD_CONFIG, MsalGuardConfiguration } from '@azure/msal-angular';
    import { AuthenticationResult, InteractionStatus, InteractionType, PopupRequest, RedirectRequest } from '@azure/msal-browser';
    import { Subject } from 'rxjs';
    import { filter, takeUntil } from 'rxjs/operators';
    
    @Component({
      selector: 'app-root',
      templateUrl: './app.component.html',
      styleUrls: ['./app.component.css']
    })
    export class AppComponent implements OnInit, OnDestroy {
      title = 'Angular 14 - MSAL v2 Quickstart Sample';
      isIframe = false;
      loginDisplay = false;
      private readonly _destroying$ = new Subject<void>();
    
      constructor(
        @Inject(MSAL_GUARD_CONFIG) private msalGuardConfig: MsalGuardConfiguration,
        private authService: MsalService,
        private msalBroadcastService: MsalBroadcastService
      ) { }
    
      ngOnInit(): void {
        this.isIframe = window !== window.parent && !window.opener;
    
        this.msalBroadcastService.inProgress$
          .pipe(
            filter((status: InteractionStatus) => status === InteractionStatus.None),
            takeUntil(this._destroying$)
          )
          .subscribe(() => {
            this.setLoginDisplay();
          });
      }
    
      setLoginDisplay() {
        this.loginDisplay = this.authService.instance.getAllAccounts().length > 0;
      }
    
      login() {
        if (this.msalGuardConfig.interactionType === InteractionType.Popup) {
          if (this.msalGuardConfig.authRequest) {
            this.authService.loginPopup({ ...this.msalGuardConfig.authRequest } as PopupRequest)
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
            this.authService.loginRedirect({ ...this.msalGuardConfig.authRequest } as RedirectRequest);
          } else {
            this.authService.loginRedirect();
          }
        }
      }
    
      logout() {
        if (this.msalGuardConfig.interactionType === InteractionType.Popup) {
          this.authService.logoutPopup({
            postLogoutRedirectUri: "/",
            mainWindowRedirectUri: "/"
          });
        } else {
          this.authService.logoutRedirect({
            postLogoutRedirectUri: "/",
          });
        }
      }
    
      ngOnDestroy(): void {
        this._destroying$.next(undefined);
        this._destroying$.complete();
      }
    }
    ```

## Sign out using pop-ups

1. Update the code in _src/app/app.component.ts_ to sign out a user using pop-ups:

    ```javascript	
    import { Component, OnInit, OnDestroy, Inject } from '@angular/core';
    import { MsalService, MsalBroadcastService, MSAL_GUARD_CONFIG, MsalGuardConfiguration } from '@azure/msal-angular';
    import { InteractionStatus, PopupRequest } from '@azure/msal-browser';
    import { Subject } from 'rxjs';
    import { filter, takeUntil } from 'rxjs/operators';
    
    @Component({
      selector: 'app-root',
      templateUrl: './app.component.html',
      styleUrls: ['./app.component.css']
    })
    export class AppComponent implements OnInit, OnDestroy {
      title = 'msal-angular-tutorial';
      isIframe = false;
      loginDisplay = false;
      private readonly _destroying$ = new Subject<void>();
    
      constructor(@Inject(MSAL_GUARD_CONFIG) private msalGuardConfig: MsalGuardConfiguration, private broadcastService: MsalBroadcastService, private authService: MsalService) { }
    
      ngOnInit() {
        this.isIframe = window !== window.parent && !window.opener;
    
        this.broadcastService.inProgress$
        .pipe(
          filter((status: InteractionStatus) => status === InteractionStatus.None),
          takeUntil(this._destroying$)
        )
        .subscribe(() => {
          this.setLoginDisplay();
        })
      }
    
      login() {
        if (this.msalGuardConfig.authRequest){
          this.authService.loginPopup({...this.msalGuardConfig.authRequest} as PopupRequest)
            .subscribe({
              next: (result) => {
                console.log(result);
                this.setLoginDisplay();
              },
              error: (error) => console.log(error)
            });
        } else {
          this.authService.loginPopup()
            .subscribe({
              next: (result) => {
                console.log(result);
                this.setLoginDisplay();
              },
              error: (error) => console.log(error)
            });
        }
      }
    
      logout() { // Add log out function here
        this.authService.logoutPopup({
          mainWindowRedirectUri: "/"
        });
      }
    
      setLoginDisplay() {
        this.loginDisplay = this.authService.instance.getAllAccounts().length > 0;
      }
    
      ngOnDestroy(): void {
        this._destroying$.next(undefined);
        this._destroying$.complete();
      }
    }
    ```

## Test your application

1. Start the web server by running the following commands at a command-line prompt from the application folder:

    ```bash	
    npm install
    npm start
    ```

1. In your browser, enter `http://localhost:4200` to open the application.

       :::image type="content" source="media/tutorial-single-page-app-angular-sign-in-sign-out/angular-01-not-signed-in.png" alt-text="Web browser displaying sign-in dialog":::
    
1. Click the **Login** button in the top right corner of the screen.
1. Select **Accept** to grant the application access to your profile information.
1. After you're signed in, you'll see your profile information displayed on the page.
1. Select the **Logout** button in the top right corner of the screen to sign out.
## See also

After completing this tutorial, you can may want to learn more about how to:

- [Customize the default branding](how-to-customize-branding-customers.md)

- [Configure sign-in with Google](how-to-google-federation-customers.md)

- [Enable self-service password reset](./how-to-enable-password-reset-customers.md)
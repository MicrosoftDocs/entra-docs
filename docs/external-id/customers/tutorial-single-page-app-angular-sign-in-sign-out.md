---
title: "Tutorial: Add sign-in and sign-out to an Angular SPA for an external tenant"
description: Learn how to configure an Angular single-page app (SPA) to sign in and sign out users with your external tenant.
services: active-directory
author: godonnell
manager: celestedg

ms.service: entra-external-id
ms.subservice: customers
ms.topic: tutorial
ms.date: 10/27/2023
ms.author: godonnell

#Customer intent: As a developer I want to add sign-in and sign-out functionality to my Angular single-page app
---

# Tutorial: Add sign-in and sign-out to an Angular SPA for an external tenant

This tutorial is the final part of a series that demonstrates building an Angular single-page application (SPA) and preparing it for authentication using the Microsoft Entra admin center. In [Part 3 of this series](./tutorial-single-page-app-angular-sign-in-configure-authentication.md), you added authentication flows to your Angular single-page application and configured the flows to work with your external tenant. In this article, you'll learn how to add sign in and sign out functionality to the application. Finally, you'll test the application.

In this tutorial;

> [!div class="checklist"]
> - Add sign-in and sign-out functionality to your app.
> - Test the application

## Prerequisites

- [Tutorial: Prepare your external tenant to authenticate users in an Angular SPA](./tutorial-single-page-app-angular-sign-in-prepare-tenant.md).

## Sign in and sign out users

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

## Test your application

1. Start the web server by running the following commands at a command-line prompt from the application folder:

    ```bash	
    npm install
    npm start
    ```

1. In your browser, enter `http://localhost:4200` to open the application.

    :::image type="content" source="media/tutorial-single-page-app-angular-sign-in-sign-out/angular-01-not-signed-in.png" alt-text="Screenshot of a web browser displaying sign-in dialog":::

1. Select the **Login** button in the top right corner of the screen.
1. After you're signed in, you'll see your profile information displayed on the page.

    :::image type="content" source="media/tutorial-single-page-app-angular-sign-in-sign-out/angular-02-signed-in.png" alt-text="Web browser displaying signed in app":::

1. Select the **Logout** button in the top right corner of the screen to sign out.

## See also

After completing this tutorial, you might want to learn more about how to:

- [Customize the default branding](how-to-customize-branding-customers.md)

- [Configure sign-in with Google](how-to-google-federation-customers.md)

- [Enable self-service password reset](./how-to-enable-password-reset-customers.md)

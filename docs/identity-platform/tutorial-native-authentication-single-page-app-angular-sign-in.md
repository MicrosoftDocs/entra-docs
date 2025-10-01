---
title: Sign In Users in Angular SPA by Using Native Authentication JavaScript SDK
description: Learn how to build Angular single-page app that signs in users into an external tenant by using native authentication JavaScript SDK.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 07/30/2025
#Customer intent: As a developer, I want to build an Angular single-page application that uses native authentication JavaScript SDK so that I can sign in users with a username (email) and password or email with one-time passcode.
---

# Tutorial: Sign in users in Angular SPA by using native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to sign in users into an Angular single-page app (SPA) by using native authentication JavaScript SDK. 

In this tutorial, you:

>[!div class="checklist"]
>
> - Update Angular app to sign in users.
> - Test the sign-in flow.

## Prerequisites

- Complete the steps in [Sign up users into Angular single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-sign-up.md).

## Create a sign-in component

1. Use Angular CLI to generate a new component for sign-in page inside the *components* folder by running the following command:

    ```console
    cd components
    ng generate component sign-in
    ```

1. Open the *sign-in/sign-in.component.ts* file and replace its contents with content from [sign-in.component.ts](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.ts)

1. Open the  *sign-in/sign-in.component.html* file and add the contents from [sign-in.component.html](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.html).

    - The following logic in *sign-in.component.ts* determines the next step after the initial sign-in attempt. Depending on the result, it displays either the password or one-time code form in *sign-in.component.html* to guide the user through the appropriate part of the sign-in process:     

        ```typescript
            const result: SignInResult = await client.signIn({ username: this.username });
        
            if (result.isPasswordRequired()) {
                this.showPassword = true;
                this.showCode = false;
            } else if (result.isCodeRequired()) {
                this.showPassword = false;
                this.showCode = true;
            } else if (result.isCompleted()) {
                this.isSignedIn = true;
                this.userData = result.data;
            }
        ```
        - The SDK's instance method, `signIn()` starts the sign-in flow.

        - In the *sign-in.component.html* file:

        ```html
        <form *ngIf="showPassword" (ngSubmit)="submitPassword()">
            <input type="password" [(ngModel)]="password" name="password" placeholder="Password" required />
            <button type="submit" [disabled]="loading">{{ loading ? 'Verifying...' : 'Submit Password' }}</button>
        </form>
        <form *ngIf="showCode" (ngSubmit)="submitCode()">
            <input type="text" [(ngModel)]="code" name="code" placeholder="OTP Code" required />
            <button type="submit" [disabled]="loading">{{ loading ? 'Verifying...' : 'Submit Code' }}</button>
        </form>
        ```

4. Open the *sign-in/sign-in.component.scss* file and add the content from [sign-in.component.scss](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/typescript/native-auth/angular-sample/src/app/components/sign-in/sign-in.component.scss).

## Update the routing module

Open the *src/app/app.routes.ts* file, then add the route for the sign-in component:

```typescript
import { SignInComponent } from './components/sign-in/sign-in.component';

export const routes: Routes = [
    ...
    { path: 'sign-in', component: SignInComponent },
];
```

## Test the sign-in functionality

1. To start the CORS proxy server, run the following command in your terminal:

    ```console
    npm run cors
    ```

1. To start the Angular app, open another terminal window, then run the following command:

    ```console
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:4200/sign-in`. A sign-in form appears.

1. To sign in into an existing account, input your details, select the Sign In button, then follow the prompts.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Reset password in Angular single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-reset-password.md)
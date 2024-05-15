---
title: Single-page app sign-in & sign-out
description: Learn how to build a single-page application (sign-in)
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: 
ms.date: 04/30/2022
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to know how to write a single-page application by using the Microsoft identity platform.
---

# Single-page application: sign-in and sign-out

Before you can get tokens to access APIs in your application, you need an authenticated user context. To authenticate a user, you can use a [Pop-up window](#sign-in-with-a-pop-up-window) and/or a [Redirect](#sign-in-with-a-redirect) sign in method.

If your application has access to an authenticated user context or ID token, you can skip the sign in step, and directly acquire tokens. For details, see [Single sign-on (SSO) with user hint](msal-js-sso.md#with-user-hint).

## Choosing between a pop-up or redirect experience

The choice between a pop-up or redirect experience depends on your application flow.

- Use a pop-up window if you don't want users to move away from your main application page during authentication. Because the authentication redirect happens in a pop-up window, the state of the main application is preserved.

- Use a redirect if users have browser constraints or policies where pop-up windows are disabled. For example, there are [known issues with pop-up windows on Internet Explorer](./msal-js-use-ie-browser.md).

## Sign in with a pop-up window

# [JavaScript (MSAL.js v2)](#tab/javascript2)

```javascript
const config = {
  auth: {
    clientId: "your_app_id",
    redirectUri: "your_app_redirect_uri", //defaults to application start page
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  },
};

const loginRequest = {
  scopes: ["User.ReadWrite"],
};

let accountId = "";

const myMsal = new PublicClientApplication(config);

myMsal
  .loginPopup(loginRequest)
  .then(function (loginResponse) {
    accountId = loginResponse.account.homeAccountId;
    // Display signed-in user content, call API, etc.
  })
  .catch(function (error) {
    //login failure
    console.log(error);
  });
```

# [Angular (MSAL.js v2)](#tab/angular2)

To invoke a sign in experience for a specific route, import `@angular/router` and add `MsalGuard` to the route definition.

```javascript
// In app-routing.module.ts
import { NgModule } from "@angular/core";
import { Routes, RouterModule } from "@angular/router";
import { ProfileComponent } from "./profile/profile.component";
import { MsalGuard } from "@azure/msal-angular";
import { HomeComponent } from "./home/home.component";

const routes: Routes = [
  {
    path: "profile",
    component: ProfileComponent,
    canActivate: [MsalGuard],
  },
  {
    path: "",
    component: HomeComponent,
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: false })],
  exports: [RouterModule],
})
export class AppRoutingModule {}
```

To enable a pop-up window experience, set the `interactionType` configuration to `InteractionType.Popup` in the `MsalGuardConfiguration`. You can also pass the scopes that require consent.

```javascript
// In app.module.ts
import { PublicClientApplication, InteractionType } from "@azure/msal-browser";
import { MsalModule } from "@azure/msal-angular";

@NgModule({
  imports: [
    MsalModule.forRoot(
      new PublicClientApplication({
        auth: {
          clientId: "your_app_id",
        },
        cache: {
          cacheLocation: "localStorage",
          storeAuthStateInCookie: isIE,
        },
      }),
      {
        interactionType: InteractionType.Popup, // MsalGuard Configuration
        authRequest: {
          scopes: ["User.Read"],
        },
      },
      null
    ),
  ],
})
export class AppModule {}
```

# [React](#tab/react)

To invoke a sign in experience when a user isn't already signed in, use the `MsalAuthenticationTemplate` function from `@azure/msal-react`. The MSAL React wrapper protects specific components by wrapping them in the `MsalAuthenticationTemplate` component.

```javascript
import { InteractionType } from "@azure/msal-browser";
import { MsalAuthenticationTemplate, useMsal } from "@azure/msal-react";

function WelcomeUser() {
  const { accounts } = useMsal();
  const username = accounts[0].username;

  return <p>Welcome, {username}</p>;
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <MsalAuthenticationTemplate interactionType={InteractionType.Popup}>
      <p>This will only render if a user is not signed-in.</p>
      <WelcomeUser />
    </MsalAuthenticationTemplate>
  );
}
```

To invoke a specific sign in experience based on user interaction (for example, button select), use the `AuthenticatedTemplate` and/or `UnauthenticatedTemplate` function from `@azure/msal-react`.

```javascript
import {
  useMsal,
  AuthenticatedTemplate,
  UnauthenticatedTemplate,
} from "@azure/msal-react";

function signInClickHandler(instance) {
  instance.loginPopup();
}

// SignInButton Component returns a button that invokes a popup sign in when clicked
function SignInButton() {
  // useMsal hook will return the PublicClientApplication instance you provided to MsalProvider
  const { instance } = useMsal();

  return <button onClick={() => signInClickHandler(instance)}>Sign In</button>;
}

function WelcomeUser() {
  const { accounts } = useMsal();
  const username = accounts[0].username;

  return <p>Welcome, {username}</p>;
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <>
      <AuthenticatedTemplate>
        <p>This will only render if a user is signed-in.</p>
        <WelcomeUser />
      </AuthenticatedTemplate>
      <UnauthenticatedTemplate>
        <p>This will only render if a user is not signed-in.</p>
        <SignInButton />
      </UnauthenticatedTemplate>
    </>
  );
}
```

---

## Sign in with a redirect

# [JavaScript (MSAL.js v2)](#tab/javascript2)

```javascript
const config = {
  auth: {
    clientId: "your_app_id",
    redirectUri: "your_app_redirect_uri", //defaults to application start page
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  },
};

const loginRequest = {
  scopes: ["User.ReadWrite"],
};

let accountId = "";

const myMsal = new PublicClientApplication(config);

function handleResponse(response) {
  if (response !== null) {
    accountId = response.account.homeAccountId;
    // Display signed-in user content, call API, etc.
  } else {
    // In case multiple accounts exist, you can select
    const currentAccounts = myMsal.getAllAccounts();

    if (currentAccounts.length === 0) {
      // no accounts signed-in, attempt to sign a user in
      myMsal.loginRedirect(loginRequest);
    } else if (currentAccounts.length > 1) {
      // Add choose account code here
    } else if (currentAccounts.length === 1) {
      accountId = currentAccounts[0].homeAccountId;
    }
  }
}

myMsal.handleRedirectPromise().then(handleResponse);
```

# [Angular (MSAL.js v2)](#tab/angular2)

To enable a redirect experience, set the `interactionType` configuration to `InteractionType.Redirect` in the `MsalGuardConfiguration`, and then bootstrap `MsalRedirectComponent` to handle redirects.

```javascript
// In app.module.ts
import { PublicClientApplication, InteractionType } from "@azure/msal-browser";
import { MsalModule, MsalRedirectComponent } from "@azure/msal-angular";

@NgModule({
  imports: [
    MsalModule.forRoot(
      new PublicClientApplication({
        auth: {
          clientId: "Enter_the_Application_Id_Here",
        },
        cache: {
          cacheLocation: "localStorage",
          storeAuthStateInCookie: isIE,
        },
      }),
      {
        interactionType: InteractionType.Redirect, // Msal Guard Configuration
        authRequest: {
          scopes: ["user.read"],
        },
      },
      null
    ),
  ],
  bootstrap: [AppComponent, MsalRedirectComponent],
})
export class AppModule {}
```

# [React](#tab/react)

To invoke a sign in experience when a user isn't signed in, use the `MsalAuthenticationTemplate` function from `@azure/msal-react`.

```javascript
import { InteractionType } from "@azure/msal-browser";
import { MsalAuthenticationTemplate, useMsal } from "@azure/msal-react";

function WelcomeUser() {
  const { accounts } = useMsal();
  const username = accounts[0].username;

  return <p>Welcome, {username}</p>;
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <MsalAuthenticationTemplate interactionType={InteractionType.Redirect}>
      <p>This will only render if a user is not signed-in.</p>
      <WelcomeUser />
    </MsalAuthenticationTemplate>
  );
}
```

To invoke a specific sign in experience based on user interaction (for example, button select), use the `AuthenticatedTemplate` and/or `UnauthenticatedTemplate` function from `@azure/msal-react`.

```javascript
import {
  useMsal,
  AuthenticatedTemplate,
  UnauthenticatedTemplate,
} from "@azure/msal-react";

function signInClickHandler(instance) {
  instance.loginRedirect();
}

// SignInButton Component returns a button that invokes a popup login when clicked
function SignInButton() {
  // useMsal hook will return the PublicClientApplication instance you provided to MsalProvider
  const { instance } = useMsal();

  return <button onClick={() => signInClickHandler(instance)}>Sign In</button>;
}

function WelcomeUser() {
  const { accounts } = useMsal();
  const username = accounts[0].username;

  return <p>Welcome, {username}</p>;
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <>
      <AuthenticatedTemplate>
        <p>This will only render if a user is signed-in.</p>
        <WelcomeUser />
      </AuthenticatedTemplate>
      <UnauthenticatedTemplate>
        <p>This will only render if a user is not signed-in.</p>
        <SignInButton />
      </UnauthenticatedTemplate>
    </>
  );
}
```

---
## Sign out behavior on browsers

To ensure secure sign out of one or more apps, the following methods are recommended: 

* On shared devices, users should use a browser's private/incognito mode and close all browser windows before they step away from the device. 

* On devices that aren't shared, users should use an operating system lock screen to lock or sign out of their entire operating system session on the device. Microsoft uses its sign out page to remind users of these privacy and security best practices.

For more information, see Microsoft's [internet privacy best practices](https://support.microsoft.com/en-us/windows/protect-your-privacy-on-the-internet-ffe36513-e208-7532-6f95-a3b1c8760dfa).

If a user chooses not to sign out using the recommendations, the following are other methods to enable sign out functionality:

* Microsoft's OpenID Connect's [Front Channel Logout](https://openid.net/specs/openid-connect-frontchannel-1_0.html) for federated sign out. You can use this option when an app shares a sign in state with a new app, but manages its own session tokens/cookies. There are some limitations to this implementation where content is blocked, for example when browsers block third-party cookies. 

* [Pop-up window](#sign-out-with-a-pop-up-window) and/or a [Redirect](#sign-out-with-a-redirect) for local app sign out. The pop-up and redirect methods end the user's session at the endpoint and for the local app. But, these methods might not immediately clear the session for other federated applications if front-channel communication is blocked.

## Sign out with a pop-up window

MSAL.js v2 and higher provides a `logoutPopup` method that clears the cache in browser storage and opens a pop-up window to the Microsoft Entra sign out page. After sign out, the redirect defaults to the sign in start page, and the pop-up is closed.

For the after sign out experience, you can set the `postLogoutRedirectUri` to redirect the user to a specific URI. This URI should be registered as a redirect URI in your application registration. You can also configure `logoutPopup` to redirect the main window to a different page, such as the home page or sign in page by passing `mainWindowRedirectUri` as part of the request.

# [JavaScript (MSAL.js v2)](#tab/javascript2)

```javascript
const config = {
  auth: {
    clientId: "your_app_id",
    redirectUri: "your_app_redirect_uri", // defaults to application start page
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  },
};

const myMsal = new PublicClientApplication(config);

// you can select which account application should sign out
const logoutRequest = {
  account: myMsal.getAccountByHomeId(homeAccountId),
  mainWindowRedirectUri: "your_app_main_window_redirect_uri",
};

await myMsal.logoutPopup(logoutRequest);
```

# [Angular (MSAL.js v2)](#tab/angular2)

```javascript
// In app.module.ts
@NgModule({
    imports: [
        MsalModule.forRoot( new PublicClientApplication({
            auth: {
                clientId: 'your_app_id',
                postLogoutRedirectUri: 'your_app_logout_redirect_uri'
            }
        }), null, null)
    ]
})

// In app.component.ts
logout() {
    this.authService.logoutPopup({
        mainWindowRedirectUri: "/"
    });
}
```

# [React](#tab/react)

```javascript
import {
  useMsal,
  AuthenticatedTemplate,
  UnauthenticatedTemplate,
} from "@azure/msal-react";

function signOutClickHandler(instance) {
  const logoutRequest = {
    account: instance.getAccountByHomeId(homeAccountId),
    mainWindowRedirectUri: "your_app_main_window_redirect_uri",
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  };
  instance.logoutPopup(logoutRequest);
}

// SignOutButton component returns a button that invokes a pop-up sign out when clicked
function SignOutButton() {
  // useMsal hook will return the PublicClientApplication instance you provided to MsalProvider
  const { instance } = useMsal();

  return (
    <button onClick={() => signOutClickHandler(instance)}>Sign Out</button>
  );
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <>
      <AuthenticatedTemplate>
        <p>This will only render if a user is signed-in.</p>
        <SignOutButton />
      </AuthenticatedTemplate>
      <UnauthenticatedTemplate>
        <p>This will only render if a user is not signed-in.</p>
      </UnauthenticatedTemplate>
    </>
  );
}
```

---

## Sign out with a redirect

MSAL.js provides a `logout` method in v1, and a `logoutRedirect` method in v2 that clears the cache in browser storage and redirects to the Microsoft Entra sign out page. After sign out, the redirect defaults to the sign in start page.

For the after sign out experience, you can set the `postLogoutRedirectUri` to redirect the user to a specific URI. This URI should be registered as a redirect URI in your application registration.

Because the Microsoft's reminder of [internet privacy best practices](https://support.microsoft.com/en-us/windows/protect-your-privacy-on-the-internet-ffe36513-e208-7532-6f95-a3b1c8760dfa) about using a private browser and lock screen isn't shown in this method, you might want to describe best practices and remind users to close all browser windows.

# [JavaScript (MSAL.js v2)](#tab/javascript2)

```javascript
const config = {
  auth: {
    clientId: "your_app_id",
    redirectUri: "your_app_redirect_uri", //defaults to application start page
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  },
};

const myMsal = new PublicClientApplication(config);

// you can select which account application should sign out
const logoutRequest = {
  account: myMsal.getAccountByHomeId(homeAccountId),
};

myMsal.logoutRedirect(logoutRequest);
```

# [Angular (MSAL.js v2)](#tab/angular2)

```javascript
// In app.module.ts
@NgModule({
    imports: [
        MsalModule.forRoot( new PublicClientApplication({
            auth: {
                clientId: 'your_app_id',
                postLogoutRedirectUri: 'your_app_logout_redirect_uri'
            }
        }), null, null)
    ]
})

// In app.component.ts
logout() {
    this.authService.logoutRedirect();
}
```

# [React](#tab/react)

```javascript
import {
  useMsal,
  AuthenticatedTemplate,
  UnauthenticatedTemplate,
} from "@azure/msal-react";

function signOutClickHandler(instance) {
  const logoutRequest = {
    account: instance.getAccountByHomeId(homeAccountId),
    postLogoutRedirectUri: "your_app_logout_redirect_uri",
  };
  instance.logoutRedirect(logoutRequest);
}

// SignOutButton Component returns a button that invokes a redirect logout when clicked
function SignOutButton() {
  // useMsal hook will return the PublicClientApplication instance you provided to MsalProvider
  const { instance } = useMsal();

  return (
    <button onClick={() => signOutClickHandler(instance)}>Sign Out</button>
  );
}

// Remember that MsalProvider must be rendered somewhere higher up in the component tree
function App() {
  return (
    <>
      <AuthenticatedTemplate>
        <p>This will only render if a user is signed-in.</p>
        <SignOutButton />
      </AuthenticatedTemplate>
      <UnauthenticatedTemplate>
        <p>This will only render if a user is not signed-in.</p>
      </UnauthenticatedTemplate>
    </>
  );
}
```

---

## Next steps

Move on to the next article in this scenario, [Acquiring a token for the app](scenario-spa-acquire-token.md).

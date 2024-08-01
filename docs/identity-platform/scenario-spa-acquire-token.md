---
title: Acquire a token to call a web API (single-page apps)
description: Learn how to acquire a token in a single-page app and call a web API using the Microsoft identity platform.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom: 
ms.date: 06/27/2024
ms.service: identity-platform

ms.topic: concept-article
s.reviewer: negoe
#Customer intent: As an application developer, I want to know how to write a single-page application by using the Microsoft identity platform.
---

# Single-page application: Acquire a token to call an API

The pattern for acquiring tokens for APIs with [MSAL.js](https://github.com/AzureAD/microsoft-authentication-library-for-js) is to first attempt a silent token request by using the `acquireTokenSilent` method. When this method is called, the library first checks the cache in browser storage to see if a non-expired access token exists and returns it. If no access token is found or the access token found has expired, it attempts to use its refresh token to get a fresh access token. If the refresh token's 24-hour lifetime has also expired, MSAL.js opens a hidden iframe to silently request a new authorization code by using the existing active session with Microsoft Entra ID (if any), which will then be exchanged for a fresh set of tokens (access *and* refresh tokens). For more information about single sign-on (SSO) session and token lifetime values in Microsoft Entra ID, see [Token lifetimes](configurable-token-lifetimes.md). For more information on MSAL.js cache lookup policy, see: [Acquiring an Access Token](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-browser/docs/acquire-token.md#acquiring-an-access-token).

The silent token requests to Microsoft Entra ID might fail for reasons like a password change or updated Conditional Access policies. More often, failures are due to the refresh token's 24-hour lifetime expiring and [the browser blocking third party cookies](reference-third-party-cookies-spas.md), which prevents the use of hidden iframes to continue authenticating the user. In these cases, you should invoke one of the interactive methods (which may prompt the user) to acquire tokens:

- [Pop-up window](#acquire-a-token-with-a-pop-up-window), by using `acquireTokenPopup`
- [Redirect](#acquire-a-token-with-a-redirect), by using `acquireTokenRedirect`

## Choose between a pop-up or redirect experience

The choice between a pop-up or redirect experience depends on your application flow:

- If you don't want users to move away from your main application page during authentication, we recommend the pop-up method. Because the authentication redirect happens in a pop-up window, the state of the main application is preserved.

- If users have browser constraints or policies where pop-up windows are disabled, you can use the redirect method. Use the redirect method with the Internet Explorer browser, because there are [known issues with pop-up windows on Internet Explorer](msal-js-known-issues-ie-edge-browsers.md).

You can set the API scopes that you want the access token to include when it's building the access token request. All requested scopes might not be granted in the access token. That depends on the user's consent.

## Acquire a token with a pop-up window

# [JavaScript (MSAL.js v2)](#tab/javascript2)

The following code combines the previously described pattern with the methods for a pop-up experience:

```javascript
// MSAL.js v2 exposes several account APIs, logic to determine which account to use is the responsibility of the developer
const account = publicClientApplication.getAllAccounts()[0];

const accessTokenRequest = {
  scopes: ["user.read"],
  account: account,
};

publicClientApplication
  .acquireTokenSilent(accessTokenRequest)
  .then(function (accessTokenResponse) {
    // Acquire token silent success
    let accessToken = accessTokenResponse.accessToken;
    // Call your API with token
    callApi(accessToken);
  })
  .catch(function (error) {
    //Acquire token silent failure, and send an interactive request
    if (error instanceof InteractionRequiredAuthError) {
      publicClientApplication
        .acquireTokenPopup(accessTokenRequest)
        .then(function (accessTokenResponse) {
          // Acquire token interactive success
          let accessToken = accessTokenResponse.accessToken;
          // Call your API with token
          callApi(accessToken);
        })
        .catch(function (error) {
          // Acquire token interactive failure
          console.log(error);
        });
    }
    console.log(error);
  });
```

# [JavaScript (MSAL.js v1)](#tab/javascript1)

The following code combines the previously described pattern with the methods for a pop-up experience:

```javascript
const accessTokenRequest = {
  scopes: ["user.read"],
};

userAgentApplication
  .acquireTokenSilent(accessTokenRequest)
  .then(function (accessTokenResponse) {
    // Acquire token silent success
    // Call API with token
    let accessToken = accessTokenResponse.accessToken;
  })
  .catch(function (error) {
    //Acquire token silent failure, and send an interactive request
    if (error.errorMessage.indexOf("interaction_required") !== -1) {
      userAgentApplication
        .acquireTokenPopup(accessTokenRequest)
        .then(function (accessTokenResponse) {
          // Acquire token interactive success
        })
        .catch(function (error) {
          // Acquire token interactive failure
          console.log(error);
        });
    }
    console.log(error);
  });
```

# [Angular (MSAL.js v2)](#tab/angular2)

The MSAL Angular wrapper provides the HTTP interceptor, which will automatically acquire access tokens silently and attach them to the HTTP requests to APIs.

You can specify the scopes for APIs in the `protectedResourceMap` configuration option. `MsalInterceptor` requests the specified scopes when automatically acquiring tokens.

```javascript
// In app.module.ts
import { PublicClientApplication, InteractionType } from "@azure/msal-browser";
import { MsalInterceptor, MsalModule } from "@azure/msal-angular";

@NgModule({
  declarations: [
    // ...
  ],
  imports: [
    // ...
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
        interactionType: InteractionType.Popup,
        authRequest: {
          scopes: ["user.read"],
        },
      },
      {
        interactionType: InteractionType.Popup,
        protectedResourceMap: new Map([
          ["https://graph.microsoft.com/v1.0/me", ["user.read"]],
        ]),
      }
    ),
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: MsalInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
```

For success and failure of the silent token acquisition, MSAL Angular provides events that you can subscribe to. It's also important to remember to unsubscribe.

```javascript
import { MsalBroadcastService } from '@azure/msal-angular';
import { EventMessage, EventType } from '@azure/msal-browser';

import { filter, Subject, takeUntil } from 'rxjs';

// In app.component.ts
export class AppComponent implements OnInit {
  private readonly _destroying$ = new Subject<void>();

  constructor(private broadcastService: MsalBroadcastService) { }

  ngOnInit() {
    this.broadcastService.msalSubject$
    .pipe(
      filter((msg: EventMessage) => msg.eventType === EventType.ACQUIRE_TOKEN_SUCCESS),
      takeUntil(this._destroying$)
    )
    .subscribe((result: EventMessage) => {
      // Do something with event payload here
    });
  }

  ngOnDestroy(): void {
    this._destroying$.next(undefined);
    this._destroying$.complete();
  }
}
```

Alternatively, you can explicitly acquire tokens by using the acquire-token methods as described in the core MSAL.js library.

# [Angular (MSAL.js v1)](#tab/angular1)

The MSAL Angular wrapper provides the HTTP interceptor, which will automatically acquire access tokens silently and attach them to the HTTP requests to APIs.
You can specify the scopes for APIs in the `protectedResourceMap` configuration option. `MsalInterceptor` requests the specified scopes when automatically acquiring tokens.

```javascript
// app.module.ts
@NgModule({
  declarations: [
    // ...
  ],
  imports: [
    // ...
    MsalModule.forRoot(
      {
        auth: {
          clientId: "Enter_the_Application_Id_Here",
        },
      },
      {
        popUp: !isIE,
        consentScopes: ["user.read", "openid", "profile"],
        protectedResourceMap: [
          ["https://graph.microsoft.com/v1.0/me", ["user.read"]],
        ],
      }
    ),
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: MsalInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
```

For success and failure of the silent token acquisition, MSAL Angular provides callbacks that you can subscribe to. It's also important to remember to unsubscribe.

```javascript
// In app.component.ts
 ngOnInit() {
    this.subscription = this.broadcastService.subscribe("msal:acquireTokenFailure", (payload) => {
    });
}
ngOnDestroy() {
   this.broadcastService.getMSALSubject().next(1);
   if (this.subscription) {
     this.subscription.unsubscribe();
   }
 }
```

Alternatively, you can explicitly acquire tokens by using the acquire-token methods as described in the core MSAL.js library.

# [React](#tab/react)

The following code combines the previously described pattern with the methods for a pop-up experience:

```javascript
import {
  InteractionRequiredAuthError,
  InteractionStatus,
} from "@azure/msal-browser";
import { AuthenticatedTemplate, useMsal } from "@azure/msal-react";

function ProtectedComponent() {
  const { instance, inProgress, accounts } = useMsal();
  const [apiData, setApiData] = useState(null);

  useEffect(() => {
    if (!apiData && inProgress === InteractionStatus.None) {
      const accessTokenRequest = {
        scopes: ["user.read"],
        account: accounts[0],
      };
      instance
        .acquireTokenSilent(accessTokenRequest)
        .then((accessTokenResponse) => {
          // Acquire token silent success
          let accessToken = accessTokenResponse.accessToken;
          // Call your API with token
          callApi(accessToken).then((response) => {
            setApiData(response);
          });
        })
        .catch((error) => {
          if (error instanceof InteractionRequiredAuthError) {
            instance
              .acquireTokenPopup(accessTokenRequest)
              .then(function (accessTokenResponse) {
                // Acquire token interactive success
                let accessToken = accessTokenResponse.accessToken;
                // Call your API with token
                callApi(accessToken).then((response) => {
                  setApiData(response);
                });
              })
              .catch(function (error) {
                // Acquire token interactive failure
                console.log(error);
              });
          }
          console.log(error);
        });
    }
  }, [instance, accounts, inProgress, apiData]);

  return <p>Return your protected content here: {apiData}</p>;
}

function App() {
  return (
    <AuthenticatedTemplate>
      <ProtectedComponent />
    </AuthenticatedTemplate>
  );
}
```

Alternatively, if you need to acquire a token outside of a React component you can call `acquireTokenSilent` but shouldn't fall back to interaction if it fails. All interactions should take place underneath the `MsalProvider` component in your component tree.

```javascript
// MSAL.js v2 exposes several account APIs, logic to determine which account to use is the responsibility of the developer
const account = publicClientApplication.getAllAccounts()[0];

const accessTokenRequest = {
  scopes: ["user.read"],
  account: account,
};

// Use the same publicClientApplication instance provided to MsalProvider
publicClientApplication
  .acquireTokenSilent(accessTokenRequest)
  .then(function (accessTokenResponse) {
    // Acquire token silent success
    let accessToken = accessTokenResponse.accessToken;
    // Call your API with token
    callApi(accessToken);
  })
  .catch(function (error) {
    //Acquire token silent failure
    console.log(error);
  });
```

---

## Acquire a token with a redirect

# [JavaScript (MSAL.js v2)](#tab/javascript2)

The following pattern is as described earlier but shown with a redirect method to acquire tokens interactively. You need to call and await `handleRedirectPromise` on page load.

```javascript
const redirectResponse = await publicClientApplication.handleRedirectPromise();
if (redirectResponse !== null) {
  // Acquire token silent success
  let accessToken = redirectResponse.accessToken;
  // Call your API with token
  callApi(accessToken);
} else {
  // MSAL.js v2 exposes several account APIs, logic to determine which account to use is the responsibility of the developer
  const account = publicClientApplication.getAllAccounts()[0];

  const accessTokenRequest = {
    scopes: ["user.read"],
    account: account,
  };

  publicClientApplication
    .acquireTokenSilent(accessTokenRequest)
    .then(function (accessTokenResponse) {
      // Acquire token silent success
      // Call API with token
      let accessToken = accessTokenResponse.accessToken;
      // Call your API with token
      callApi(accessToken);
    })
    .catch(function (error) {
      //Acquire token silent failure, and send an interactive request
      console.log(error);
      if (error instanceof InteractionRequiredAuthError) {
        publicClientApplication.acquireTokenRedirect(accessTokenRequest);
      }
    });
}
```

# [JavaScript (MSAL.js v1)](#tab/javascript1)

The following pattern is as described earlier but shown with a redirect method to acquire tokens interactively. You need to register the redirect callback as mentioned earlier.

```javascript
function authCallback(error, response) {
  // Handle redirect response
}

userAgentApplication.handleRedirectCallback(authCallback);

const accessTokenRequest: AuthenticationParameters = {
  scopes: ["user.read"],
};

userAgentApplication
  .acquireTokenSilent(accessTokenRequest)
  .then(function (accessTokenResponse) {
    // Acquire token silent success
    // Call API with token
    let accessToken = accessTokenResponse.accessToken;
  })
  .catch(function (error) {
    //Acquire token silent failure, and send an interactive request
    console.log(error);
    if (error.errorMessage.indexOf("interaction_required") !== -1) {
      userAgentApplication.acquireTokenRedirect(accessTokenRequest);
    }
  });
```

## Request optional claims

You can use optional claims for the following purposes:

- Include extra claims in tokens for your application.
- Change the behavior of certain claims that Microsoft Entra ID returns in tokens.
- Add and access custom claims for your application.

To request optional claims in `IdToken`, you can send a stringified claims object to the `claimsRequest` field of the `AuthenticationParameters.ts` class.

```javascript
var claims = {
  optionalClaims: {
    idToken: [
      {
        name: "auth_time",
        essential: true,
      },
    ],
  },
};

var request = {
  scopes: ["user.read"],
  claimsRequest: JSON.stringify(claims),
};

myMSALObj.acquireTokenPopup(request);
```

To learn more, see [Optional claims](./optional-claims.md).

# [Angular (MSAL.js v2)](#tab/angular2)

This code is the same as described earlier, except we recommend bootstrapping the `MsalRedirectComponent` to handle redirects. `MsalInterceptor` configurations can also be changed to use redirects.

```javascript
// In app.module.ts
import { PublicClientApplication, InteractionType } from "@azure/msal-browser";
import {
  MsalInterceptor,
  MsalModule,
  MsalRedirectComponent,
} from "@azure/msal-angular";

@NgModule({
  declarations: [
    // ...
  ],
  imports: [
    // ...
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
        interactionType: InteractionType.Redirect,
        authRequest: {
          scopes: ["user.read"],
        },
      },
      {
        interactionType: InteractionType.Redirect,
        protectedResourceMap: new Map([
          ["https://graph.microsoft.com/v1.0/me", ["user.read"]],
        ]),
      }
    ),
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: MsalInterceptor,
      multi: true,
    },
  ],
  bootstrap: [AppComponent, MsalRedirectComponent],
})
export class AppModule {}
```

# [Angular (MSAL.js v1)](#tab/angular1)

This code is the same as described earlier.

# [React](#tab/react)

If `acquireTokenSilent` fails, fallback to `acquireTokenRedirect`. This method initiates a full-frame redirect and the response will be handled when returning to the application. When this component is rendered after returning from the redirect, `acquireTokenSilent` should now succeed as the tokens will be pulled from the cache.

```javascript
import {
  InteractionRequiredAuthError,
  InteractionStatus,
} from "@azure/msal-browser";
import { AuthenticatedTemplate, useMsal } from "@azure/msal-react";

function ProtectedComponent() {
  const { instance, inProgress, accounts } = useMsal();
  const [apiData, setApiData] = useState(null);

  useEffect(() => {
    const accessTokenRequest = {
      scopes: ["user.read"],
      account: accounts[0],
    };
    if (!apiData && inProgress === InteractionStatus.None) {
      instance
        .acquireTokenSilent(accessTokenRequest)
        .then((accessTokenResponse) => {
          // Acquire token silent success
          let accessToken = accessTokenResponse.accessToken;
          // Call your API with token
          callApi(accessToken).then((response) => {
            setApiData(response);
          });
        })
        .catch((error) => {
          if (error instanceof InteractionRequiredAuthError) {
            instance.acquireTokenRedirect(accessTokenRequest);
          }
          console.log(error);
        });
    }
  }, [instance, accounts, inProgress, apiData]);

  return <p>Return your protected content here: {apiData}</p>;
}

function App() {
  return (
    <AuthenticatedTemplate>
      <ProtectedComponent />
    </AuthenticatedTemplate>
  );
}
```

Alternatively, if you need to acquire a token outside of a React component you can call `acquireTokenSilent` but shouldn't fall back to interaction if it fails. All interactions should take place underneath the `MsalProvider` component in your component tree.

```javascript
// MSAL.js v2 exposes several account APIs, logic to determine which account to use is the responsibility of the developer
const account = publicClientApplication.getAllAccounts()[0];

const accessTokenRequest = {
  scopes: ["user.read"],
  account: account,
};

// Use the same publicClientApplication instance provided to MsalProvider
publicClientApplication
  .acquireTokenSilent(accessTokenRequest)
  .then(function (accessTokenResponse) {
    // Acquire token silent success
    let accessToken = accessTokenResponse.accessToken;
    // Call your API with token
    callApi(accessToken);
  })
  .catch(function (error) {
    //Acquire token silent failure
    console.log(error);
  });
```

---

## Next steps

Move on to the next article in this scenario, [Calling a web API](scenario-spa-call-api.md).

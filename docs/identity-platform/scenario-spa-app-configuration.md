---
title: Configure single-page app
description: Learn how to build a single-page application (app's code configuration)
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: 
ms.date: 05/12/2025
ms.service: identity-platform

ms.topic: how-to
#Customer intent: As an application developer, I want to know how to write a single-page application by using the Microsoft identity platform.
---

# Single-page application: Code configuration

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

Learn how to configure the code for your single-page application (SPA).

## Prerequisites

* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add the following redirect URIs using the **Single-page application** platform configuration. Refer to [How to add a redirect URI in your application](./how-to-add-redirect-uri.md) for more details.
    * **Redirect URI**: `http://localhost:3000/`.

## Microsoft libraries supporting single-page apps

The following Microsoft libraries support single-page apps:

[!INCLUDE [active-directory-develop-libraries-spa](./includes/libraries/libraries-spa.md)]

## Application code configuration

In an MSAL library, the application registration information is passed as configuration during the library initialization.

# [React](#tab/react)

```javascript
import { PublicClientApplication } from "@azure/msal-browser";
import { MsalProvider } from "@azure/msal-react";

// Configuration object constructed.
const config = {
    auth: {
        clientId: 'your_client_id'
    }
};

// create PublicClientApplication instance
const publicClientApplication = new PublicClientApplication(config);

// Wrap your app component tree in the MsalProvider component
ReactDOM.render(
    <React.StrictMode>
        <MsalProvider instance={publicClientApplication}>
            <App />
        </ MsalProvider>
    </React.StrictMode>,
    document.getElementById('root')
);
```

# [JavaScript](#tab/javascript2)

```javascript
import * as Msal from "@azure/msal-browser"; // if using CDN, 'Msal' will be available in global scope

// Configuration object constructed.
const config = {
    auth: {
        clientId: 'your_client_id'
    }
};

// create PublicClientApplication instance
const publicClientApplication = new Msal.PublicClientApplication(config);
```

# [Angular](#tab/angular2)

```javascript
// In app.module.ts
import { MsalModule } from '@azure/msal-angular';
import { PublicClientApplication } from '@azure/msal-browser';

@NgModule({
    imports: [
        MsalModule.forRoot( new PublicClientApplication({
            auth: {
                clientId: 'Enter_the_Application_Id_Here',
            }
        }), null, null)
    ]
})
export class AppModule { }
```

---

For more information on the configurable options, see [Initializing application with MSAL.js](msal-js-initializing-client-applications.md).

## Next step

- [Add Sign-in and sign-out code](scenario-spa-sign-in.md).

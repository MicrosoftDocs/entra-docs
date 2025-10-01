---
title: "Tutorial: Sign in and sign out of a React single-page app (SPA)"
description: Learn how to test sign-in and sign-out in a React single-page app (SPA) using the Microsoft identity platform.
author: OwenRichards1
ms.author: owenrichards
ms.date: 09/25/2023
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As a React developer, I want to know how to create a user interface and access the Microsoft Graph API
---

# Tutorial: Sign in and sign out of a React single-page app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

This tutorial is the final part of a series that demonstrates building a React single-page application (SPA) and preparing it for authentication using the Microsoft identity platform. In [part 2 of this series](tutorial-single-page-app-react-configure-authentication.md), you added functional components to a React SPA and built a responsive UI. This final step shows you how to test sign-in and sign-out functionality in your app.

In this tutorial, you:

> [!div class="checklist"]
> * Add code to the *claimUtils.js* file to create the claims table
> * Sign in and sign out of the application
> * View the claims returned from the ID token

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Create components for sign in and sign out in a React single-page app](tutorial-single-page-app-react-configure-authentication.md).

## Add code to the *claimUtils.js* file (optional)

To add the feature of a table that can display claims returned from the ID token, you can add code to *claimUtils.js* file. This code snippet will populate the claims table with the appropriate description and corresponding value.

1. Open *utils/claimUtils.js* and add the following code snippet:

```javascript
export const createClaimsTable = (claims) => {
    let claimsObj = {};
    let index = 0;

    Object.keys(claims).forEach((key) => {
        if (typeof claims[key] !== 'string' && typeof claims[key] !== 'number') return;
        switch (key) {
            case 'aud':
                populateClaim(
                    key,
                    claims[key],
                    "Identifies the intended recipient of the token. In ID tokens, the audience is your app's Application ID, assigned to your app in the Microsoft Entra admin center.",
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'iss':
                populateClaim(
                    key,
                    claims[key],
                    'Identifies the issuer, or authorization server that constructs and returns the token. It also identifies the external tenant for which the user was authenticated. If the token was issued by the v2.0 endpoint, the URI will end in /v2.0. The GUID that indicates that the user is a consumer user from a Microsoft account is 9188040d-6c67-4c5b-b112-36a304b66dad.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'iat':
                populateClaim(
                    key,
                    changeDateFormat(claims[key]),
                    'Issued At indicates when the authentication for this token occurred.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'nbf':
                populateClaim(
                    key,
                    changeDateFormat(claims[key]),
                    'The nbf (not before) claim identifies the time (as UNIX timestamp) before which the JWT must not be accepted for processing.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'exp':
                populateClaim(
                    key,
                    changeDateFormat(claims[key]),
                    "The exp (expiration time) claim identifies the expiration time (as UNIX timestamp) on or after which the JWT must not be accepted for processing. It's important to note that in certain circumstances, a resource may reject the token before this time. For example, if a change in authentication is required or a token revocation has been detected.",
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'name':
                populateClaim(
                    key,
                    claims[key],
                    "The name claim provides a human-readable value that identifies the subject of the token. The value isn't guaranteed to be unique, it can be changed, and it's designed to be used only for display purposes. The profile scope is required to receive this claim.",
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'preferred_username':
                populateClaim(
                    key,
                    claims[key],
                    'The primary username that represents the user. It could be an email address, phone number, or a generic username without a specified format. Its value is mutable and might change over time. Since it is mutable, this value must not be used to make authorization decisions. It can be used for username hints, however, and in human-readable UI as a username. The profile scope is required in order to receive this claim.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'nonce':
                populateClaim(
                    key,
                    claims[key],
                    'The nonce matches the parameter included in the original /authorize request to the IDP. If it does not match, your application should reject the token.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'oid':
                populateClaim(
                    key,
                    claims[key],
                    'The oid (user’s object id) is the only claim that should be used to uniquely identify a user in an external tenant. The token might have one or more of the following claim, that might seem like a unique identifier, but is not and should not be used as such.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'tid':
                populateClaim(
                    key,
                    claims[key],
                    'The tenant ID. You will use this claim to ensure that only users from the current external tenant can access this app.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'upn':
                populateClaim(
                    key,
                    claims[key],
                    '(user principal name) – might be unique amongst the active set of users in a tenant but tend to get reassigned to new employees as employees leave the organization and others take their place or might change to reflect a personal change like marriage.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'email':
                populateClaim(
                    key,
                    claims[key],
                    'Email might be unique amongst the active set of users in a tenant but tend to get reassigned to new employees as employees leave the organization and others take their place.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'acct':
                populateClaim(
                    key,
                    claims[key],
                    'Available as an optional claim, it lets you know what the type of user (homed, guest) is. For example, for an individual’s access to their data you might not care for this claim, but you would use this along with tenant id (tid) to control access to say a company-wide dashboard to just employees (homed users) and not contractors (guest users).',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'sid':
                populateClaim(key, claims[key], 'Session ID, used for per-session user sign-out.', index, claimsObj);
                index++;
                break;
            case 'sub':
                populateClaim(
                    key,
                    claims[key],
                    'The sub claim is a pairwise identifier - it is unique to a particular application ID. If a single user signs into two different apps using two different client IDs, those apps will receive two different values for the subject claim.',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'ver':
                populateClaim(
                    key,
                    claims[key],
                    'Version of the token issued by the Microsoft identity platform',
                    index,
                    claimsObj
                );
                index++;
                break;
            case 'uti':
            case 'rh':
                index++;
                break;
            case '_claim_names':
            case '_claim_sources':
            default:
                populateClaim(key, claims[key], '', index, claimsObj);
                index++;
        }
    });

    return claimsObj;
};

/**
 * Populates claim, description, and value into an claimsObject
 * @param {String} claim
 * @param {String} value
 * @param {String} description
 * @param {Number} index
 * @param {Object} claimsObject
 */
const populateClaim = (claim, value, description, index, claimsObject) => {
    let claimsArray = [];
    claimsArray[0] = claim;
    claimsArray[1] = value;
    claimsArray[2] = description;
    claimsObject[index] = claimsArray;
};

/**
 * Transforms Unix timestamp to date and returns a string value of that date
 * @param {String} date Unix timestamp
 * @returns
 */
const changeDateFormat = (date) => {
    let dateObj = new Date(date * 1000);
    return `${date} - [${dateObj.toString()}]`;
};
```

## Run your project and sign in

Now that all the required code snippets have been added, the application can be called and tested in a web browser.

1. Open a new terminal and run the following command to start your express web server.

    ```console
    npm start
    ```

1. Copy the `http` URL that appears in the terminal, for example, `http://localhost:3000`, and paste it into a browser. We recommend using a private or incognito browser session.
1. Sign-in with an account registered to the tenant.
1. An interface similar to the following screenshot appears, indicating that you have signed in to the application. If you have added the claims table, you can view the claims returned from the ID token.

    :::image type="content" source="./media/common-spa/react-spa/display-api-call-results-react-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/react-spa/display-api-call-results-react-spa.png":::

## Sign out from the application

1. Find the **Sign out** button on the page, and select it.
1. You'll be prompted to pick an account to sign out from. Select the account you used to sign in.

A message appears indicating that you have signed out. You can now close the browser window.

## Related content

- [Quickstart: Protect an ASP.NET Core web API with the Microsoft identity platform](./quickstart-web-api-aspnet-core-protect-api.md).
- [Learn more by building a React SPA that signs in users in the following multi-part tutorial series](./tutorial-single-page-app-react-prepare-app.md).
- [Enable password reset](../external-id/customers/how-to-enable-password-reset-customers.md).
- [Customize the default branding](../external-id/customers/how-to-customize-branding-customers.md).
- [Configure sign-in with Google](../external-id/customers/how-to-google-federation-customers.md).

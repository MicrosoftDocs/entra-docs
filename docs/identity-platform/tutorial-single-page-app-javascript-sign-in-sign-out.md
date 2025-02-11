---
title: "Tutorial: Add sign-in and sign-out to a Vanilla JavaScript SPA for an external tenant"
description: Learn how to configure a Vanilla JavaScript single-page app (SPA) to sign in and sign out users with your external tenant.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.service: entra-external-id
ms.subservice: external
ms.custom: devx-track-js
ms.topic: tutorial
ms.date: 02/11/2024
#Customer intent: As a developer, I want to learn how to configure Vanilla JavaScript single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Add sign-in and sign-out to a Vanilla JavaScript SPA for an external tenant

This tutorial is the final part of a series that demonstrates building a Vanilla JS single-page application (SPA) and preparing it for authentication using the Microsoft Entra admin center. In [part 3 of this series](tutorial-single-page-app-javascript-configure-authentication.md), you created a Vanilla JS in Visual Studio Code and configured it for authentication. This final step shows you how to add sign-in and sign-out functionality to the app.

In this tutorial, you'll;

> [!div class="checklist"]
> * Add code to the *index.html* file to create the user interface
> * Add code to the *signout.html* file to create the sign-out page
> * Sign in and sign out of the application

## Prerequisites

* [Tutorial: Prepare your external tenant to authenticate users in a Vanilla JavaScript SPA](tutorial-single-page-app-javascript-prepare-app.md).

## Add code to the *claimUtils.js* file

1. Open *public/claimUtils.js* and add the following code snippet:
    
    ```javascript
        /**
     * Populate claims table with appropriate description
     * @param {Object} claims ID token claims
     * @returns claimsObject
     */
    const createClaimsTable = (claims) => {
        let claimsObj = {};
        let index = 0;
    
        Object.keys(claims).forEach((key) => {
            if (typeof claims[key] !== 'string' && typeof claims[key] !== 'number') return;
            switch (key) {
                case 'aud':
                    populateClaim(
                        key,
                        claims[key],
                        "Identifies the intended recipient of the token. In ID tokens, the audience is your app's Application ID, assigned to your app in the Azure portal.",
                        index,
                        claimsObj
                    );
                    index++;
                    break;
                case 'iss':
                    populateClaim(
                        key,
                        claims[key],
                        'Identifies the issuer, or authorization server that constructs and returns the token. It also identifies the Azure AD tenant for which the user was authenticated. If the token was issued by the v2.0 endpoint, the URI will end in /v2.0. The GUID that indicates that the user is a consumer user from a Microsoft account is 9188040d-6c67-4c5b-b112-36a304b66dad.',
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
                        "The principal about which the token asserts information, such as the user of an application. This value is immutable and can't be reassigned or reused. It can be used to perform authorization checks safely, such as when the token is used to access a resource. By default, the subject claim is populated with the object ID of the user in the directory",
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
                        'The oid (user’s object id) is the only claim that should be used to uniquely identify a user in an Azure AD tenant. The token might have one or more of the following claim, that might seem like a unique identifier, but is not and should not be used as such.',
                        index,
                        claimsObj
                    );
                    index++;
                    break;
                case 'tid':
                    populateClaim(
                        key,
                        claims[key],
                        'The tenant ID. You will use this claim to ensure that only users from the current Azure AD tenant can access this app.',
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
                case 'auth_time':
                    populateClaim(
                        key,
                        claims[key],
                        'The time at which a user last entered credentials, represented in epoch time. There is no discrimination between that authentication being a fresh sign-in, a single sign-on (SSO) session, or another sign-in type.',
                        index,
                        claimsObj
                    );
                    index++;
                    break;
                case 'at_hash':
                    populateClaim(
                        key,
                        claims[key],
                        'An access token hash included in an ID token only when the token is issued together with an OAuth 2.0 access token. An access token hash can be used to validate the authenticity of an access token',
                        index,
                        claimsObj
                    );
                    index++;
                    break;
                case 'uti':
                case 'rh':
                    index++;
                    break;
                default:
                    populateClaim(key, claims[key], '', index, claimsObj);
                    index++;
            }
        });
    
        return claimsObj;
    };
    
        /**
         * Populates claim, description, and value into an claimsObject
         * @param {string} claim
         * @param {string} value
         * @param {string} description
         * @param {number} index
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
         * @param {string} date Unix timestamp
         * @returns
         */
        const changeDateFormat = (date) => {
            let dateObj = new Date(date * 1000);
            return `${date} - [${dateObj.toString()}]`;
    };
    ```

1. Save the file.

## Run your project and sign in

Now that all the required code snippets have been added, the application can be called and tested in a web browser.

1. Open a new terminal and run the following command to start your express web server.
    ```powershell
    npm start
    ```
1. Open a new private browser, and enter the application URI into the browser, `http://localhost:3000/`.
1. Select **No account? Create one**, which starts the sign-up flow.
1. In the **Create account** window, enter the email address registered to your external tenant, which starts the sign-up flow as a user for your application.
1. After entering a one-time passcode from the external tenant, enter a new password and more account details, this sign-up flow is completed.

    1. If a window appears prompting you to **Stay signed in**, choose either **Yes** or **No**.

1. The SPA will now display a button saying **Request Profile Information**. Select it to display profile data.

    :::image type="content" source="./media/common-spa/react-spa/display-api-call-results-react-spa.png" alt-text="Screenshot of JavaScript App depicting the results of the API call." lightbox="./media/common-spa/react-spa/display-api-call-results-react-spa.png":::

## Sign out of the application

1. To sign out of the application, select **Sign out** in the navigation bar.
1. A window appears asking which account to sign out of.
1. Upon successful sign out, a final window appears advising you to close all browser windows.

## Related content

- [Enable self-service password reset](../external-id/customers/how-to-enable-password-reset-customers.md) 

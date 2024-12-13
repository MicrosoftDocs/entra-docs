---
title: "Tutorial: Handle authentication flows in a React SPA"
description: Learn how to configure authentication for a React single-page app (SPA) with your external tenant.

author: garrodonnell
manager: CelesteDG

ms.author: godonnell
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/09/2023

#Customer intent: As a developer, I want to learn how to configure a React single-page app (SPA) to sign in and sign out users with my external tenant.
---

# Tutorial: Handle authentication flows in a React SPA

This tutorial is part 3 of a series that demonstrates building a React single-page application (SPA) and preparing it for authentication. In [Part 2 of this series](./tutorial-single-page-app-react-sign-in-prepare-app.md), you created a React SPA and prepared it for authentication with your external tenant. In this tutorial, you'll learn how to handle authentication flows in your app by adding Microsoft Authentication Library (MSAL) components.

In this tutorial;

> [!div class="checklist"]
>
> - Add a *DataDisplay* component to the app
> - Add a *ProfileContent* component to the app
> - Add a *PageLayout* component to the app
> - Add a *claimUtils* file to the app

## Prerequisites

- [Tutorial: Prepare your external tenant to authenticate users in a React SPA](./tutorial-single-page-app-react-sign-in-prepare-tenant.md).

## Add components to the application

Functional components are the building blocks of React apps, and are used to build the sign-in and sign-out experiences in your React SPA.

### Add the DataDisplay component

1. Open *src/components/DataDisplay.jsx* and add the following code snippet

    ```jsx
    import { Table } from 'react-bootstrap';
    import { createClaimsTable } from '../utils/claimUtils';

    import '../styles/App.css';

    export const IdTokenData = (props) => {
        const tokenClaims = createClaimsTable(props.idTokenClaims);

        const tableRow = Object.keys(tokenClaims).map((key, index) => {
            return (
                <tr key={key}>
                    {tokenClaims[key].map((claimItem) => (
                        <td key={claimItem}>{claimItem}</td>
                    ))}
                </tr>
            );
        });
        return (
            <>
                <div className="data-area-div">
                    <p>
                        See below the claims in your <strong> ID token </strong>. For more information, visit:{' '}
                        <span>
                            <a href="https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens#claims-in-an-id-token">
                                docs.microsoft.com
                            </a>
                        </span>
                    </p>
                    <div className="data-area-div">
                        <Table responsive striped bordered hover>
                            <thead>
                                <tr>
                                    <th>Claim</th>
                                    <th>Value</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>{tableRow}</tbody>
                        </Table>
                    </div>
                </div>
            </>
        );
    };
    ```

1. Save the file.

### Add the NavigationBar component

1. Open *src/components/NavigationBar.jsx* and add the following code snippet

    ```jsx
    import { AuthenticatedTemplate, UnauthenticatedTemplate, useMsal } from '@azure/msal-react';
    import { Navbar, Button } from 'react-bootstrap';
    import { loginRequest } from '../authConfig';

    export const NavigationBar = () => {
        const { instance } = useMsal();

        const handleLoginRedirect = () => {
            instance.loginRedirect(loginRequest).catch((error) => console.log(error));
        };

        const handleLogoutRedirect = () => {
            instance.logoutRedirect().catch((error) => console.log(error));
        };

        /**
         * Most applications will need to conditionally render certain components based on whether a user is signed in or not.
         * msal-react provides 2 easy ways to do this. AuthenticatedTemplate and UnauthenticatedTemplate components will
         * only render their children if a user is authenticated or unauthenticated, respectively.
         */
        return (
            <>
                <Navbar bg="primary" variant="dark" className="navbarStyle">
                    <a className="navbar-brand" href="/">
                        Microsoft identity platform
                    </a>
                    <AuthenticatedTemplate>
                        <div className="collapse navbar-collapse justify-content-end">
                            <Button variant="warning" onClick={handleLogoutRedirect}>
                                Sign out
                            </Button>
                        </div>
                    </AuthenticatedTemplate>
                    <UnauthenticatedTemplate>
                        <div className="collapse navbar-collapse justify-content-end">
                            <Button onClick={handleLoginRedirect}>Sign in</Button>
                        </div>
                    </UnauthenticatedTemplate>
                </Navbar>
            </>
        );
    };
    ```

1. Save the file.

### Add the PageLayout component

1. Open *src/components/PageLayout.jsx* and add the following code snippet

    ```jsx
    import { AuthenticatedTemplate } from '@azure/msal-react';

    import { NavigationBar } from './NavigationBar.jsx';

    export const PageLayout = (props) => {
        /**
         * Most applications will need to conditionally render certain components based on whether a user is signed in or not.
         * msal-react provides 2 easy ways to do this. AuthenticatedTemplate and UnauthenticatedTemplate components will
         * only render their children if a user is authenticated or unauthenticated, respectively.
         */
        return (
            <>
                <NavigationBar />
                <br />
                <h5>
                    <center>Welcome to the Microsoft Authentication Library For React Tutorial</center>
                </h5>
                <br />
                {props.children}
                <br />
                <AuthenticatedTemplate>
                    <footer>
                        <center>
                            How did we do?
                            <a
                                href="https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR_ivMYEeUKlEq8CxnMPgdNZUNDlUTTk2NVNYQkZSSjdaTk5KT1o4V1VVNS4u"
                                rel="noopener noreferrer"
                                target="_blank"
                            >
                                {' '}
                                Share your experience!
                            </a>
                        </center>
                    </footer>
                </AuthenticatedTemplate>
            </>
        );
    }
    ```

1. Save the file.

### Add the claimUtils file

1. Open *src/utils/claimUtils.js* and add the following code snippet:

    ```javascript
    /**
     * Populate claims table with appropriate description
     * @param {Object} claims ID token claims
     * @returns claimsObject
     */
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
                        "The oid (user's object id) is the only claim that should be used to uniquely identify a user in an Azure AD tenant. The token might have one or more of the following claim, that might seem like a unique identifier, but is not and should not be used as such.",
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
                        "Available as an optional claim, it lets you know what the type of user (homed, guest) is. For example, for an individual's access to their data you might not care for this claim, but you would use this along with tenant id (tid) to control access to say a company-wide dashboard to just employees (homed users) and not contractors (guest users).",
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

1. Save the file.

## Next step

> [!div class="nextstepaction"]
> [Part 4: Sign in and sign out of the React SPA](./tutorial-single-page-app-react-sign-in-sign-out.md)

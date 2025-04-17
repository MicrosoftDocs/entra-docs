---
title: "Tutorial: Add sign-in and sign-out components to a React single-page app (SPA)"
description: Learn how to add authentication to a React single-page app (SPA) using the Microsoft identity platform.
author: OwenRichards1
ms.author: owenrichards
ms.custom:
ms.date: 02/25/2025
ms.service: identity-platform
ms.topic: tutorial
#Customer intent: As a React developer, I want to know how to use functional components to add sign in and sign out experiences in my React application.
---

# Tutorial: Add sign in and sign out functional components in a React single-page app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this tutorial you'll configure a React single-page application (SPA) for authentication. In [part 1 of this series](tutorial-single-page-app-react-prepare-app.md), you created a React SPA and prepared it for authentication. In this tutorial, you'll learn how to add authentication flows by adding [Microsoft Authentication Library (MSAL)](msal-overview.md) functional components to your app and build a responsive user interface (UI) for your app.

In this tutorial, you:

> [!div class="checklist"]
> - Add functional components to the application
> - Create a way of displaying the user's profile information
> - Create a layout that displays the sign in and sign out experience
> - Add the sign in and sign out experiences

## Prerequisites

* Completion of the prerequisites and steps in [Tutorial: Prepare an application for authentication](tutorial-single-page-app-react-prepare-app.md).

## Add functional components to the application

Functional components are the building blocks of React apps, and are used to build the sign-in and sign-out experiences in your application. 

### Add the NavigationBar component

The navigation bar will provide the sign-in and sign-out experience for the app. The instance variable previously set in the *index.js* file will be used to call the sign-in and sign-out methods, which will redirect the user to the back to the sign-in page. 

1. Open *src/components/NavigationBar.jsx* and add the following code snippet;

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

The PageLayout component will be used to display the main content of the app and can be customized to include any additional content you want to display on every page of your app. The user's profile information will is displayed by passing the information via props.

1. Open *src/components/PageLayout.jsx* and add the following code snippet;

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

### Add the DataDisplay component

The `DataDisplay` component will be used to display the user's profile information and a table of claims, which will be created in the next section of the tutorial. The `IdTokenData` component will be used to display the claims in the ID token.

1. Open *src/components/DataDisplay.jsx* and add the following code snippet;

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

## Next steps

> [!div class="nextstepaction"]
> [Tutorial: Sign in and sign out of a React SPA](tutorial-single-page-app-react-sign-in-sign-out.md)










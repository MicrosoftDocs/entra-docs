---
title: "Tutorial: Add sign-in and sign-out to a React SPA for an external tenant"
description: Learn how to configure a React single-page app (SPA) to sign in and sign out users with your external tenant.
author: godonnell
manager: celestedg
ms.service: entra-external-id
ms.subservice: customers
ms.topic: tutorial
ms.date: 07/03/2024
ms.author: godonnell

#Customer intent: As a developer I want to add sign-in and sign-out functionality to my React single-page app
---

# Tutorial: Add sign-in and sign-out to a React SPA for an external tenant

This tutorial is the final part of a series that demonstrates building a React single-page application (SPA) and preparing it for authentication using the Microsoft Entra admin center. In [part 3 of this series](./tutorial-single-page-app-react-sign-in-configure-authentication.md), you created a React SPA in Visual Studio Code and configured it for authentication. This final step shows you how to add sign-in and sign-out functionality to the app.

In this tutorial;

> [!div class="checklist"]
>
> * Create a page layout and add the sign in and sign out experience
> * Replace the default function to render authenticated information
> * Sign in and sign out of the application using the user flow

## Prerequisites

* [Tutorial: Prepare your external tenant to authenticate users in a React SPA](./tutorial-single-page-app-react-sign-in-prepare-tenant.md).

## Change filename and add function to render authenticated information

By default, the application runs via a JavaScript file called *App.js*. It needs to be changed to *.jsx*, which is an extension that allows a developer to write HTML in React.

1. Ensure *App.js* has been renamed to *App.jsx*.
1. Replace the existing code with the following snippet:

   ```javascript
    import { MsalProvider, AuthenticatedTemplate, useMsal, UnauthenticatedTemplate } from '@azure/msal-react';
    import { Container, Button } from 'react-bootstrap';
    import { PageLayout } from './components/PageLayout';
    import { IdTokenData } from './components/DataDisplay';
    import { loginRequest } from './authConfig';
    
    import './styles/App.css';
    
    /**
     * Most applications will need to conditionally render certain components based on whether a user is signed in or not. 
     * msal-react provides 2 easy ways to do this. AuthenticatedTemplate and UnauthenticatedTemplate components will 
     * only render their children if a user is authenticated or unauthenticated, respectively. For more, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/getting-started.md
     */
    const MainContent = () => {
        /**
         * useMsal is hook that returns the PublicClientApplication instance,
         * that tells you what msal is currently doing. For more, visit:
         * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/hooks.md
         */
        const { instance } = useMsal();
        const activeAccount = instance.getActiveAccount();
    
        const handleRedirect = () => {
            instance
                .loginRedirect({
                    ...loginRequest,
                    prompt: 'create',
                })
                .catch((error) => console.log(error));
        };
        return (
            <div className="App">
                <AuthenticatedTemplate>
                    {activeAccount ? (
                        <Container>
                            <IdTokenData idTokenClaims={activeAccount.idTokenClaims} />
                        </Container>
                    ) : null}
                </AuthenticatedTemplate>
                <UnauthenticatedTemplate>
                    <Button className="signInButton" onClick={handleRedirect} variant="primary">
                        Sign up
                    </Button>
                </UnauthenticatedTemplate>
            </div>
        );
    };
    
    
    /**
     * msal-react is built on the React context API and all parts of your app that require authentication must be 
     * wrapped in the MsalProvider component. You will first need to initialize an instance of PublicClientApplication 
     * then pass this to MsalProvider as a prop. All components underneath MsalProvider will have access to the 
     * PublicClientApplication instance via context as well as all hooks and components provided by msal-react. For more, visit:
     * https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-react/docs/getting-started.md
     */
    const App = ({ instance }) => {
        return (
            <MsalProvider instance={instance}>
                <PageLayout>
                    <MainContent />
                </PageLayout>
            </MsalProvider>
        );
    };
    
    export default App;
    ```

## Run your project and sign in

All the required code snippets have been added, so the application can now be tested in a web browser.

1. The application should already be running in your terminal. If not, run the following command to start your app.

    ```powershell
    npm start
    ```

1. Open a web browser and navigate to `http://localhost:3000/` if you aren't automatically redirected.
1. For the purposes of this tutorial, choose the **Sign in using Popup** option.
1. After the popup window appears with the sign-in options, select the account with which to sign-in.
1. A second window may appear indicating that a code will be sent to your email address. If this happens, select **Send code**. Open the email from the sender Microsoft account team, and enter the seven digit single-use code. Once entered, select **Sign in**.
1. For **Stay signed in**, you can select either **No** or **Yes**.
1. The app asks for permission to sign-in and access data. Select **Accept** to continue.

## Sign out of the application

1. To sign out of the application, select **Sign out** in the navigation bar.
1. A window appears asking which account to sign out of.
1. Upon successful sign out, a final window appears advising you to close all browser windows.

## See also

> - [Enable self-service password reset](./how-to-enable-password-reset-customers.md)
> - [Customize the default branding](/entra/external-id/customers/how-to-customize-branding-customers)
> - [Configure sign-in with Google](/entra/external-id/customers/how-to-google-federation-customers)

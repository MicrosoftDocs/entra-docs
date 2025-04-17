---
title: Sign in users in React SPA by using native authentication
description: Learn how to build a React single-page app that signs in users in a React single-page app into an external tenant by using native authentication.

author: kengaderdus
manager: mwongerapk
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 02/07/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication API so that I can sign in users with a username (email) and password.
---

# Tutorial: Sign in users into a React single-page app by using native authentication (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to sign in users into a React single-page app (SPA) by using native authentication. 

In this tutorial, you:

>[!div class="checklist"]
>
> - Update the React app to sign in users with username(email) and password.
> - Test sign-in flow.

## Prerequisites

- Complete the steps in [Tutorial: Setup CORS Proxy server to manage CORS headers for native authentication](tutorial-native-authentication-single-page-app-react-set-up-local-cors.md).

## Define types of calls the app makes to the native authentication API

During the sign-in flow, the app makes multiple calls to the native authentication API such as starting a sign-in request, selecting an authentication method, and requesting for security tokens.

To define these calls, open the *scr/client/RequestTypes.ts* file, then append following code snippet:

```typescript
   export interface TokenRequestType {
        continuation_token: string;
        client_id: string;
        grant_type: string;
        scope: string;
        password?: string;
        oob?: string;
        challenge_type?: string;
    }

    // Sign in
    export interface TokenSignInType {
        continuation_token: string;
        grant_type: string;
        password?: string;
        oob?: string;
    }

    export interface ChallengeRequest {
        client_id: string;
        challenge_type: string;
        continuation_token: string;
    }

    export interface SignInStartRequest {
        client_id: string;
        challenge_type: string;
        username: string;
    }

    export interface SignInTokenRequest {
        client_id: string;
        grant_type: string;
        continuation_token: string;
        scope: string;
        challenge_type?: string;
        password?: string;
        oob?: string;
    }
```

## Define the type of responses app receives from the native authentication API

To define the type of responses the app can receive from the native authentication API for the sign-in operation, open the *src/client/ResponseTypes.ts* file, then append the following code snippet:

```typescript
    export interface TokenResponseType {
        token_type: string;
        scope: string;
        expires_in: number;
        access_token: string;
        refresh_token: string;
        id_token: string;
    }
```

## Process sign-in requests

In this section, you add code that processes sign-in flow requests. Examples of these requests are start a sign-in flow, select an authentication method or request a security token.

To do so, create a file called *src/client/SignInService.ts*, then add the following code snippet:

```typescript
    import { CLIENT_ID, ENV } from "../config";
    import { postRequest } from "./RequestClient";
    import { ChallengeRequest, SignInStartRequest, TokenRequestType, TokenSignInType } from "./RequestTypes";
    import { TokenResponseType } from "./ResponseTypes";

    export const signInStart = async ({ username }: { username: string }) => {
        const payloadExt: SignInStartRequest = {
            username,
            client_id: CLIENT_ID,
            challenge_type: "password oob redirect",
        };

        return await postRequest(ENV.urlOauthInit, payloadExt);
    };

    export const signInChallenge = async ({ continuation_token }: { continuation_token: string }) => {
        const payloadExt: ChallengeRequest = {
            continuation_token,
            client_id: CLIENT_ID,
            challenge_type: "password oob redirect",
        };

        return await postRequest(ENV.urlOauthChallenge, payloadExt);
    };

    export const signInTokenRequest = async (request: TokenSignInType): Promise<TokenResponseType> => {
        const payloadExt: TokenRequestType = {
            ...request,
            client_id: CLIENT_ID,
            challenge_type: "password oob redirect",
            scope: "openid offline_access",
        };

        if (request.grant_type === "password") {
            payloadExt.password = request.password;
        }

        if (request.grant_type === "oob") {
            payloadExt.oob = request.oob;
        }

        return await postRequest(ENV.urlOauthToken, payloadExt);
    };
```

The `challenge_type` property shows the authentication methods that the client app supports. This app signs is using email with password, so the challenge type value is *password oob redirect*. Read more about [challenge types](concept-native-authentication-challenge-types.md).

## Create UI components

During sign-in flow, this app collects the user's credentials, username (email), and password, to sign in the user. After the user successfully signs in, the app displays the user's details.

1. Create a folder called */pages/signin* in the *src* folder.

1. To create, display and submit the sign-in form, create a file *src/pages/signin/SignIn.tsx*, then add the following code:

    ```typescript
        import React, { useState } from "react";
        import { Link as LinkTo, useNavigate } from "react-router-dom";
        import { signInStart, signInChallenge, signInTokenRequest } from "../../client/SignInService";
        import { ErrorResponseType } from "../../client/ResponseTypes";
        
        export const SignIn: React.FC = () => {
          const [email, setEmail] = useState<string>("");
          const [password, setPassword] = useState<string>("");
          const [error, setError] = useState<string>("");
          const [isLoading, setIsloading] = useState<boolean>(false);
        
          const navigate = useNavigate();
          const validateEmail = (email: string): boolean => {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(String(email).toLowerCase());
          };
        
          const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
            e.preventDefault();
            if (!validateEmail(email)) {
              setError("Invalid email format");
              return;
            }
            setError("");
            setIsloading(true);
            try {
              const res1 = await signInStart({
                username: email,
              });
              const res2 = await signInChallenge({ continuation_token: res1.continuation_token });
              const res3 = await signInTokenRequest({
                continuation_token: res2.continuation_token,
                grant_type: "password",
                password: password,
              });
              navigate("/user", { state: res3 });
            } catch (err) {
              setError("An error has occured " + (err as ErrorResponseType).error_description);
            } finally {
              setIsloading(false);
            }
          };
        
          return (
            <div className="login-form">
              <form onSubmit={handleSubmit}>
                <h2>Login</h2>
                <div className="form-group">
                  <label>Email:</label>
                  <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
                </div>
                <div className="form-group">
                  <label>Password:</label>
                  <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
                </div>
                {error && <div className="error">{error}</div>}
                {isLoading && <div className="warning">Sending request...</div>}
                <button type="submit" disabled={isLoading}>Login</button>
              </form>
            </div>
          );
        };
    ```

1. To display the user's details after a successful sign-in:

    1. Create a file called *client/Utils.ts*, then add the following code snippet:

        ```typescript
            export function parseJwt(token: string) {
                var base64Url = token.split(".")[1];
                var base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
                var jsonPayload = decodeURIComponent(
                    window
                    .atob(base64)
                    .split("")
                    .map(function (c) {
                        return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
                    })
                    .join("")
                );
                return JSON.parse(jsonPayload);
            }
        ```

    1. Create a folder called *user* in the *src/pages* folder.

    1. Create a file called *src/pages/user/UserInfo.tsx*, then add the following code snippet:

        ```typescript
        // User.tsx
        import React from "react";
        import { useLocation } from "react-router-dom";
        import { parseJwt } from "../../client/Utils";
        
        export const UserInfo: React.FC = () => {
          const { state } = useLocation();
          const decodedToken = parseJwt(state.access_token);
          const { given_name, scp, family_name, unique_name: email } = decodedToken;
        
          console.log(decodedToken);
          const familyName = family_name;
          const givenName = given_name;
          const tokenExpireTime = state.expires_in;
          const scopes = state.scope;
        
          return (
            <div className="user-info">
              <h2>User Information</h2>
              <div className="info-group">
                <label>Given Name:</label>
                <span>{givenName}</span>
              </div>
              <div className="info-group">
                <label>Family Name:</label>
                <span>{familyName}</span>
              </div>
              <div className="info-group">
                <label>Email:</label>
                <span>{email}</span>
              </div>
              <div className="info-group">
                <label>Token Expire Time:</label>
                <span>{tokenExpireTime}</span>
              </div>
              <div className="info-group">
                <label>Scopes:</label>
                <span>{scopes}</span>
              </div>
              <div className="info-group">
                <label>Token payload:</label>
                <span><pre>{JSON.stringify(decodedToken, null, 2)}</pre></span>
              </div>
            </div>
          );
        };
        ```

## Add app routes

Open the *src/AppRoutes.tsx* file, then replace its contents with the following code:

```typescript
import { Route, Routes } from "react-router-dom";
import { SignIn } from "./pages/SignIn/SignIn";
import { UserInfo } from "./pages/User/UserInfo";
import { SignUp } from "./pages/SignUp/SignUp";
import { SignUpChallenge } from "./pages/SignUp/SignUpChallenge";
import { SignUpCompleted } from "./pages/SignUp/SignUpCompleted";
//For password reset
//import { ResetPassword } from "./pages/ResetAccount/ResetPassword";

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<SignUp />} />
      <Route path="/signin" element={<SignIn />} />
      <Route path="/user" element={<UserInfo />} />
      <Route path="/signup" element={<SignUp />} />
      <Route path="/signup/challenge" element={<SignUpChallenge />} />
      <Route path="/signup/completed" element={<SignUpCompleted />} />
      //For password reset
      //<Route path="/reset" element={<ResetPassword />} />
    </Routes>
  );
};
```

## Run and test your app

Use the steps in [Run and test you app](tutorial-native-authentication-single-page-app-react-set-up-local-cors.md#run-and-test-you-app) to run your app, but this time, test the sign in flow by using the user account that you signed up earlier.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Reset password in a React app for users in an external tenant using native authentication](tutorial-native-authentication-single-page-app-react-reset-password.md)
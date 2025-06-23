---
title: Sign up users in a React SPA by using native authentication
description: Learn how to build a React single-page application that uses native authentication API to sign up users.

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 02/07/2025
#Customer intent: As a developer, I want to build a React single-page application that uses native authentication so that I can sign up users with a username (email) and password.
---

# Tutorial: Sign up users into a React single-page app by using native authentication (preview)

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

In this tutorial, you learn how to build a React single-page app that signs up users by using native authentication.

In this tutorial, you:

>[!div class="checklist"]
> - Create a React project.
> - Add UI components of the app.
> - Setup the project to sign up user using username (email) and password.

## Prerequisites

- Complete the steps in [Quickstart: Sign in users in a sample React single-page application by using native authentication API](quickstart-native-authentication-single-page-app-react-sign-in.md). This quickstart shows you how to prepare your external tenant and run a sample React code sample.
- [Visual Studio Code](https://visualstudio.microsoft.com/downloads/) or another code editor.
- [Node.js](https://nodejs.org/en/download/).

## Create a React project and install dependencies

In a location of choice in your computer, run the following commands to create a new React project with the name *reactspa*, navigate into the project folder, then install packages:

  ```console
  npm config set legacy-peer-deps true
  npx create-react-app reactspa --template typescript
  cd reactspa
  npm install ajv
  npm installreact-router-dom
  npm install
  ```

## Add configuration file for your app

Create a file called *src/config.js*, then add the following code:

```typescript
// App Id obatained from the Microsoft Entra portal 
export const CLIENT_ID = "Enter_the_Application_Id_Here";

// URL of the CORS proxy server
const BASE_API_URL = `http://localhost:3001/api`;

// Endpoints URLs for Native Auth APIs
export const ENV = {
    urlSignupStart: `${BASE_API_URL}/signup/v1.0/start`,
    urlSignupChallenge: `${BASE_API_URL}/signup/v1.0/challenge`,
    urlSignupContinue: `${BASE_API_URL}/signup/v1.0/continue`,
}
```

- Find the `Enter_the_Application_Id_Here` value and replace it with the **Application ID (clientId)** of the app you registered in the Microsoft Entra admin center.

- The `BASE_API_URL` points to a [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/docs/Web/HTTP/CORS) proxy server, which we set up later in this tutorial series. Native authentication API doesn't support  CORS, so we set up a CORS proxy server between the React SPA and the Native authentication API to manage the CORS headers.

## Set up React app to call native authentication API and handle response

To complete an authentication flow, such as a sign-up flow, with the native authentication APIs, the app makes calla dn handles response. For example, the app initiates a sign-up flow and waits for a response then it submits user attributes and waits again until the user is successfully signed up.

### Set up client call to the native authentication API

In this section, you define how to make calls to the native authentication and handle responses:

1. Create a folder called *client* in the *src*.

1. Create a file called *scr/client/RequestClient.ts*, then add the following code snippet:

    ```typescript
    import { ErrorResponseType } from "./ResponseTypes";

    export const postRequest = async (url: string, payloadExt: any) => {
    const body = new URLSearchParams(payloadExt as any);

    const response = await fetch(url, {
        method: "POST",
        headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        },
        body,
    });

    if (!response.ok) {
        try {
        const errorData: ErrorResponseType = await response.json();
        throw errorData;
        } catch (jsonError) {
        const errorData = {
            error: response.status,
            description: response.statusText,
            codes: [],
            timestamp: "",
            trace_id: "",
            correlation_id: "",
        };
        throw errorData;
        }
    }

    return await response.json();
    };
    ```

    This code defines how the app makes calls to the native authentication API and handling the responses. Whenever the app needs to initiate an authentication flow, it uses the `postRequest` function by specifying the URL and payload data.

### Define types of calls the app makes to the native authentication API

During the sign-up flow, the app makes multiple calls to the native authentication API.

To define these calls, create a file called *scr/client/RequestTypes.ts*, then add the following code snippet:

```typescript
    //SignUp 
    export interface SignUpStartRequest {
        client_id: string;
        username: string;
        challenge_type: string;
        password?: string;
        attributes?: Object;
    }
    
    export interface SignUpChallengeRequest {
        client_id: string;
        continuation_token: string;
        challenge_type?: string;
    }
    
    export interface SignUpFormPassword {
        name: string;
        surname: string;
        username: string;
        password: string;
    }
    
    //OTP
    export interface ChallengeForm {
        continuation_token: string;
        oob?: string;
        password?: string;
    }
```

### Define the type of responses app receives from the native authentication API

To define the type of responses the app can receive from the native authentication API for the sign-up operation, create a file called *src/client/ResponseTypes.ts*, then add the following code snippet:

```typescript
    export interface SuccessResponseType {
    continuation_token?: string;
    challenge_type?: string;
    }
    
    export interface ErrorResponseType {
        error: string;
        error_description: string;
        error_codes: number[];
        timestamp: string;
        trace_id: string;
        correlation_id: string;
    }
        
    export interface ChallengeResponse {
        binding_method: string;
        challenge_channel: string;
        challenge_target_label: string;
        challenge_type: string;
        code_length: number;
        continuation_token: string;
        interval: number;
    }
```

### Process sign-up requests

In this section, you add code that processes sign-up flow requests. Examples of these requests are starting a sign-up flow, selecting an authentication method, and submitting a one-time passcode.

To do so, create a file called *src/client/SignUpService.ts*, then add the following code snippet:

```typescript
import { CLIENT_ID, ENV } from "../config";
import { postRequest } from "./RequestClient";
import { ChallengeForm, SignUpChallengeRequest, SignUpFormPassword, SignUpStartRequest } from "./RequestTypes";
import { ChallengeResponse } from "./ResponseTypes";

//handle start a sign-up flow
export const signupStart = async (payload: SignUpFormPassword) => {
const payloadExt: SignUpStartRequest = {
    attributes: JSON.stringify({
    given_name: payload.name,
    surname: payload.surname,
    }),
    username: payload.username,
    password: payload.password,
    client_id: CLIENT_ID,
    challenge_type: "password oob redirect",
};

return await postRequest(ENV.urlSignupStart, payloadExt);
};

//handle selecting an authentication method
export const signupChallenge = async (payload: ChallengeForm):Promise<ChallengeResponse> => {
    const payloadExt: SignUpChallengeRequest = {
        client_id: CLIENT_ID,
        challenge_type: "password oob redirect",
        continuation_token: payload.continuation_token,
    };

    return await postRequest(ENV.urlSignupChallenge, payloadExt);
};

//handle submit one-time passcode
export const signUpSubmitOTP = async (payload: ChallengeForm) => {
    const payloadExt = {
        client_id: CLIENT_ID,
        continuation_token: payload.continuation_token,
        oob: payload.oob,
        grant_type: "oob",
    };

    return await postRequest(ENV.urlSignupContinue, payloadExt);
};
```

The `challenge_type` property shows the authentication methods that the client app supports. This app signs is using email with password, so the challenge type value is *password oob redirect*. Read more about [challenge types](concept-native-authentication-challenge-types.md).

### Create UI components

This app collects user details such as given name, username (email), and  password and a one-time passcode from the user. So, the app needs to have a sign-up and a one-time passcode collection form.

1. Create a folder called */pages/SignUp* in the *src* folder.

1. To create, display and submit the sign-up form, create a file *src/pages/SignUp/SignUp.tsx*, then add the following code:

    ```typescript
        import React, { useState } from 'react';
        import { signupChallenge, signupStart } from '../../client/SignUpService';
        import { useNavigate } from 'react-router-dom';
        import { ErrorResponseType } from "../../client/ResponseTypes";
        
        export const SignUp: React.FC = () => {
            const [name, setName] = useState<string>('');
            const [surname, setSurname] = useState<string>('');
            const [email, setEmail] = useState<string>('');
            const [error, setError] = useState<string>('');
            const [isLoading, setIsloading] = useState<boolean>(false);
            const navigate = useNavigate();
            const validateEmail = (email: string): boolean => {
              const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
              return re.test(String(email).toLowerCase());
            };
          
            const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
              e.preventDefault();
              if (!name || !surname || !email) {
                setError('All fields are required');
                return;
              }
              if (!validateEmail(email)) {
                setError('Invalid email format');
                return;
              }
              setError('');
              try {
                setIsloading(true);
                const res1 = await signupStart({ name, surname, username: email, password });
                const res2 = await signupChallenge({ continuation_token: res1.continuation_token });
                navigate('/signup/challenge', { state: { ...res2} });
              } catch (err) {
                setError("An error occurred during sign up " + (err as ErrorResponseType).error_description);
              } finally {
                setIsloading(false);
              }
            };
          
            return (
              <div className="sign-up-form">
                <form onSubmit={handleSubmit}>
                  <h2>Sign Up</h2>
                  <div className="form-group">
                    <label>Name:</label>
                    <input
                      type="text"
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      required
                    />
                  </div>
                  <div className="form-group">
                    <label>Last Name:</label>
                    <input
                      type="text"
                      value={surname}
                      onChange={(e) => setSurname(e.target.value)}
                      required
                    />
                  </div>
                  <div className="form-group">
                    <label>Email:</label>
                    <input
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                    />
                  </div>
                  {error && <div className="error">{error}</div>}
                  {isLoading && <div className="warning">Sending request...</div>}
                  <button type="submit">Sign Up</button>
                </form>
              </div>
            );
          };
    ```

1. To create, display and submit the one-time passcode form, create a file *src/pages/signup/SignUpChallenge.tsx*, then add the following code:

    ```typescript
    import React, { useState } from "react";
    import { useNavigate, useLocation } from "react-router-dom";
    import { signUpSubmitOTP } from "../../client/SignUpService";
    import { ErrorResponseType } from "../../client/ResponseTypes";
    
    export const SignUpChallenge: React.FC = () => {
      const { state } = useLocation();
      const navigate = useNavigate();
      const { challenge_target_label, challenge_type, continuation_token, code_length } = state;
    
      const [code, setCode] = useState<string>("");
      const [error, setError] = useState<string>("");
      const [isLoading, setIsloading] = useState<boolean>(false);
    
      const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        if (!code) {
          setError("All fields are required");
          return;
        }
    
        setError("");
        try {
          setIsloading(true);
          const res = await signUpSubmitOTP({ continuation_token, oob: code });
          navigate("/signup/completed");
        } catch (err) {
          setError("An error occurred during sign up " + (err as ErrorResponseType).error_description);
        } finally {
          setIsloading(false);
        }
      };
    
      return (
        <div className="sign-up-form">
          <form onSubmit={handleSubmit}>
            <h2>Insert your one time code received at {challenge_target_label}</h2>
            <div className="form-group">
              <label>Code:</label>
              <input maxLength={code_length} type="text" value={code} onChange={(e) => setCode(e.target.value)} required />
            </div>
            {error && <div className="error">{error}</div>}
            {isLoading && <div className="warning">Sending request...</div>}
            <button type="submit">Sign Up</button>
          </form>
        </div>
      );
    };
    ```

1. Create a file *src/pages/signup/SignUpCompleted.tsx*, then add the following code:

    ```typescript
    import React from 'react';
    import { Link } from 'react-router-dom';
    
    export const SignUpCompleted: React.FC = () => {
      return (
        <div className="sign-up-completed">
          <h2>Sign Up Completed</h2>
          <p>Your sign-up process is complete. You can now log in.</p>
          <Link to="/signin" className="login-link">Go to Login</Link>
        </div>
      );
    };
    ```

    This page displays a success message and a button to take the user to the sign-in page after they successfully sign up.

1. Open the *src/App.tsx* file, then replace its contents with the following code:

    ```typescript
    import React from "react";
    import { BrowserRouter, Link } from "react-router-dom";
    import "./App.css";
    import { AppRoutes } from "./AppRoutes";
    
    function App() {
      return (
        <div className="App">
          <BrowserRouter>
            <header>
              <nav>
                <ul>
                  <li>
                    <Link to="/signup">Sign Up</Link>
                  </li>
                  <li>
                    <Link to="/signin">Sign In</Link>
                  </li>
                  <li>
                    <Link to="/reset">Reset Password</Link>
                  </li>
                </ul>
              </nav>
            </header>
            <AppRoutes />
          </BrowserRouter>
        </div>
      );
    }
    
    export default App;
    ```

      

1. To display the React app properly:

    1. Open the *src/App.css* file, then add the following property in the `App-header` class:

        ```css
        min-height: 100vh;
        ```

    1. Open the *src/Index.css* file, then replace its contents with code from [src/index.css](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/blob/main/API/React/ReactAuthSimple/src/index.css)

### Add app routes

Create a file called *src/AppRoutes.tsx*, then add the following code:

```typescript
import { Route, Routes } from "react-router-dom";
import { SignUp } from "./pages/SignUp/SignUp";
import { SignUpChallenge } from "./pages/SignUp/SignUpChallenge";
import { SignUpCompleted } from "./pages/SignUp/SignUpCompleted";

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<SignUp />} />
      <Route path="/signup" element={<SignUp />} />
      <Route path="/signup/challenge" element={<SignUpChallenge />} />
      <Route path="/signup/completed" element={<SignUpCompleted />} />
   
    </Routes>
  );
};
```

At this point, your React app can send sign-up requests to the native authentication API, but we need to set up the CORS proxy server to manage the CORS headers.

## Next step

> [!div class="nextstepaction"]
> [Tutorial: Setup CORS Proxy server to manage CORS headers for native authentication](tutorial-native-authentication-single-page-app-react-set-up-local-cors.md)
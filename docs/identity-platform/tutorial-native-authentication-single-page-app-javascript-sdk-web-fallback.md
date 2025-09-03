---
title: Support web fallback in native authentication JavaScript SDK
description: Learn how to handle web fallback in native authentication JavaScript SDK

author: kengaderdus
manager: dougeby
ms.author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.date: 06/30/2025
#Customer intent: As a developer or DevOps engineer, I want to handle web fallback in a React or Angular SPA that uses native authentication JavaScript SDK so that the client app continues to work by using browser-based authentication if native authentication fails.
---

# Tutorial: Support web fallback in native authentication JavaScript SDK

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

This tutorial demonstrates how to acquire security tokens through a browser-based authentication where native authentication isn't sufficient to complete the authentication flow by using a mechanism called *web fallback*.

Web fallback allows a client app that uses native authentication to use browser-delegated authentication as a fallback mechanism to improve resilience. This scenario happens when native authentication isn't sufficient to complete the authentication flow. For example, if the authorization server requires capabilities that the client can't provide. Learn more about [web fallback](concept-native-authentication-web-fallback.md).

In this tutorial, you:

>[!div class="checklist"]
>
> - Check `isRedirectRequired` error.
> - Handle `isRedirectRequired` error.


## Prerequisites

#### [React](#tab/react)

- Complete the steps in [Tutorial: Sign in users into a React single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-react-sdk-sign-in.md).

#### [Angular](#tab/angular)

- Complete the steps in [Tutorial: Sign in users into Angular single-page app by using native authentication JavaScript SDK](tutorial-native-authentication-single-page-app-angular-sign-in.md).

--- 

## Check and handle web fallback

One of the errors you can encounter when you use the JavaScript SDK's `signIn()` or `SignUp()` method is `result.error?.isRedirectRequired()`. The utility method `isRedirectRequired()` checks the need to fall back to browser-delegated authentication. Use the following code snippet to support web fallback:


   ```typescript
   const result = await authClient.signIn({
            username,
        });

   if (result.isFailed()) {
      if (result.error?.isRedirectRequired()) {
         // Fallback to the delegated authentication flow.
         const popUpRequest: PopupRequest = {
            authority: customAuthConfig.auth.authority,
            scopes: [],
            redirectUri: customAuthConfig.auth.redirectUri || "",
            prompt: "login", // Forces the user to enter their credentials on that request, negating single-sign on.
         };

         try {
            await authClient.loginPopup(popUpRequest);

            const accountResult = authClient.getCurrentAccount();

            if (accountResult.isFailed()) {
               setError(
                     accountResult.error?.errorData?.errorDescription ??
                        "An error occurred while getting the account from cache"
               );
            }

            if (accountResult.isCompleted()) {
               result.state = new SignInCompletedState();
               result.data = accountResult.data;
            }
         } catch (error) {
            if (error instanceof Error) {
               setError(error.message);
            } else {
               setError("An unexpected error occurred while logging in with popup");
            }
         }
      } else {
            setError(`An error occurred: ${result.error?.errorData?.errorDescription}`);
      }
   }
   ```

When the app uses the fallback mechanism, the app acquires security tokens by using the `loginPopup()` method.


## Related content

- Learn more about [web fallback](concept-native-authentication-web-fallback.md).
- Learn more about [Native authentication challenge types](concept-native-authentication-challenge-types.md).
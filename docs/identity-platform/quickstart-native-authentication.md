---
title: "Quickstart: Sign in with Embedded native authentication"
description: Configure the React Next.js sample for Embedded native authentication with the JavaScript SDK and CORS at a tenant-verified custom-domain edge.
ms.topic: quickstart
ms.custom: msecd-doc-authoring-1030
ms.date: 11/13/2026
ai-usage: ai-generated
#customer intent: As an application developer, I want to run an Embedded native authentication sample so that I can verify sign-in with my application configuration.
---

# Quickstart: Sign in with embedded native authentication

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

[!INCLUDE [applies-to-authentication-native](../external-id/includes/applies-to-authentication-native.md)]

In this quickstart, you configure a React Next.js sample for Embedded native authentication with Microsoft Authentication Library (MSAL) for JavaScript 5.29.1. The email-and-password journey uses a tenant-verified custom domain with Cross-Origin Resource Sharing (CORS) at the edge.

[!INCLUDE [native-authentication-public-preview](~/external-id/includes/native-authentication-public-preview.md)]

## Prerequisites

- An external tenant and a public client application configured for Embedded native authentication. Complete [Configure an application](how-to-native-authentication-configure-app.md).
- A tenant-verified custom domain, the application ID, and the directory tenant GUID.
- CORS at the custom-domain edge configured for the sample's browser origin, `http://localhost:3000`. Apply the [shared proxy contract](concept-native-authentication-cors.md#proxy-contract) for origins, preflight, SDK headers, and success and error responses.
- A customer account with email and password. If tenant policy requires multifactor authentication (MFA), prepare an enabled email or SMS factor for this sample journey.
- Node.js 20.9.0 or later, npm, Git, and a code editor.
- Port 3000 available for the application.

## Get the sample

The sample has a unified launcher for V1 and V2. Use the pinned revision and SDK version below to follow this quickstart:

1. Clone the repository, check out the sample revision, and open its React Next.js application:

    ```bash
    git clone https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples
    cd ms-identity-ciam-native-javascript-samples
    git checkout --detach 49c4e250a1e6eb97e2b813e9fce6670c996a2808
    cd typescript/native-auth/react-nextjs-sample
    ```

1. Install the exact SDK version with the sample dependencies:

    ```bash
    npm install --save-exact "@azure/msal-browser@5.29.1"
    ```

<a id="configure-the-application-and-proxy"></a>

## Configure the application

Use `https://<tenant-verified-custom-domain>/<tenant-GUID>` for both the service authority and the SDK API transport base in this edge route. Keep opaque absolute HAL links for that authority unchanged. Don't add a client secret to browser configuration.

1. Open `src/config/auth-config.ts`.
1. Replace `Enter_the_Application_Id_Here` with the application ID.
1. Replace the complete `auth.authority` value with `https://<tenant-verified-custom-domain>/<tenant-GUID>`, substituting your verified hostname and tenant GUID.
1. Add `auth.knownAuthorities` as an array containing the verified hostname, without a scheme or path.
1. Set the required `customAuth.authApiProxyUrl` string to the same full `https://<tenant-verified-custom-domain>/<tenant-GUID>` authority. Include the tenant GUID in both SDK URL settings.
1. Save the configuration file. The V2 sample uses the SDK's default scopes without custom claims. MFA requirements come from your tenant policy, not from selecting V2.

## Run the sample

Run the application from the sample directory. This custom-domain edge configuration doesn't use the sample's local CORS proxy:

1. Start the application:

    ```bash
    npm run dev
    ```

1. Open `http://localhost:3000` in a browser and select **V2**. Keep the application process running while you test.

## Sign in the test customer

Use the sample's unified launcher to test only methods enabled for the current transaction.

1. Enter the test customer's email address and select **Sign In**.
1. If the service offers multiple first-factor methods, select the password method. Enter the password when requested and select **Sign In**.
1. If the service requests MFA, select a returned email or SMS method and enter its verification code.
1. Confirm that the sample reports completed sign-in. Don't expose tokens in screenshots, logs, or support output.

Email one-time passcode sign-in uses a customer account and user flow configured for that method. This quickstart follows the email-and-password journey.

## Clean up the session

End the local test without deleting shared tenant configuration.

Signing out of the sample doesn't terminate other application or browser sessions.

1. Sign out of the sample and clear the account-related application UI.
1. Stop the application process in its terminal.

## Related content

- [SDK compatibility and migration from V1](how-to-migrate-native-authentication-v1-v2.md#sdk-compatibility).
- [The Native Authentication API reference](reference-native-authentication.md).
- [Browser CORS and edge requirements](concept-native-authentication-cors.md#proxy-contract).

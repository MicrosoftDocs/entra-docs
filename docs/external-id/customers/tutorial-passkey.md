---
title: Sign in users and manage passkeys in a React single-page application
description: Learn how to build a React single-page application that signs in users with Microsoft Entra External ID and manages passkey (FIDO2) credentials by using Microsoft Graph.
ms.topic: tutorial
ms.date: 04/28/2026
ai-usage: ai-assisted
ms.author: godonnell
author: garrodonnell

#CustomerIntent: As a developer, I want to build a React single-page application that lets users sign in with Microsoft Entra External ID and register, view, and delete their passkeys, so that my customers can use phishing-resistant, passwordless authentication.
---
# Tutorial: Sign in users and manage passkeys in a React single-page application

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This tutorial shows you how to build a React single-page application (SPA) that signs in users with Microsoft Entra External ID and manages passkey (FIDO2) credentials by using the Microsoft Graph API. The sample application demonstrates how to register, list, and delete passkey credentials for authenticated users.

This tutorial is supported on Windows only. The sample isn't tested on macOS or Linux.

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Configure a local development environment with HTTPS and a custom domain.
> - Configure Microsoft Authentication Library (MSAL) authentication in a React SPA.
> - Manage passkey credentials by using the Microsoft Graph API.

## Supported scenarios

The sample application supports the following scenarios:

- Tenant administrators enable device-bound passkeys, synced passkeys, or both for their users.
- Administrators deploy the sample app to provide a passkey credential management experience.
- End users register the following passkey types:
    - Windows Hello (device-bound passkey).
    - Security key (device-bound passkey).
    - iOS iCloud Keychain (synced passkey).
    - Google Password Manager (synced passkey).
    - Third-party passkey providers, including 1Password and Bitwarden.
- End users (email and password users) manage their passkey credentials through the sample app:
    - Register a passkey on the same device.
    - Register a passkey across devices.
    - Delete a passkey.
    - View existing passkeys.
- End users sign in with a passkey:
    - As a single-factor replacement that satisfies multifactor authentication (MFA) requirements.
    - As a follow-up factor after signing in with email and password to satisfy MFA requirements.
    - By using autofill.

The following scenario isn't supported:

- External ID users can't register a passkey by using the Microsoft Authenticator app.

## Prerequisites

### Development environment

- A Microsoft Entra External ID tenant. If you don't have one, [start a free trial](https://aka.ms/ciam-free-trial).
- The Windows operating system. The sample isn't tested on macOS or Linux, and several steps in this tutorial (the `hosts` file edit, `New-SelfSignedCertificate`, and elevated PowerShell) are Windows-specific.
- [Visual Studio Code](https://code.visualstudio.com/download).
- [Node.js](https://nodejs.org/en/download/) version 20.x or later.
- [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm).
- [Win32 OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) (recommended).
- Windows administrator access (required to modify the `hosts` file).

### Application registration

1. [Register a new app](/entra/identity-platform/quickstart-register-app) in the [Microsoft Entra admin center](https://entra.microsoft.com/) with the following configuration:

    - **Platform**: Single-page application.
    - **Supported account types**: Accounts in this organizational directory only.

1. Record the following values from the application **Overview** page:

    - Application (client) ID.
    - Directory (tenant) ID.

1. Add `https://<your-subdomain>:3000` as a redirect URI, where `<your-subdomain>` is the custom domain you configure later in this tutorial.

1. [Create a client secret](/entra/identity-platform/how-to-add-credentials?tabs=client-secret) and record the value.

1. Grant the [`UserAuthMethod-Passkey.ReadWrite.All` application permission](/entra/identity-platform/quickstart-configure-app-access-web-apis#application-permission-to-microsoft-graph) to Microsoft Graph and grant admin consent.

1. Configure MFA for testing. For details, see [Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md).

> [!NOTE]
> The Microsoft Authenticator app doesn't support passkeys for Microsoft Entra External ID tenants. To complete this tutorial, use a physical FIDO2 security key or a password manager such as Bitwarden, iCloud Keychain, or Google Password Manager.

## Download the sample application

1. Clone or download the sample from [Azure-Samples/ms-eeid-passkey-sample-app](https://github.com/Azure-Samples/ms-eeid-passkey-sample-app).

1. Open the SPA folder:

    ```cmd
    cd scripts/1-PasskeysSampleApp/SPA
    ```

## Configure a local domain for passkey compliance

WebAuthn requires that the relying party identifier (`rp.id`) match the domain where passkey creation occurs. Map a custom subdomain to your local machine so that the SPA runs on a domain that matches your tenant's authentication endpoint.

### Update the Windows hosts file

1. Open `C:\Windows\System32\drivers\etc\hosts` as an administrator.

1. Add the following entry, where `<tenant-name>` is your tenant's subdomain:

    ```text
    127.0.0.1 auth.<tenant-name>.ciamlogin.com
    ```

    For example:

    ```text
    127.0.0.1 auth.contoso.ciamlogin.com
    ```

## Generate SSL certificates for HTTPS

Create a self-signed certificate and export it as a PFX file, then convert it to PEM format for use with the development server.

1. In an elevated PowerShell prompt, run the following commands. Replace `<your-subdomain>` and `<your-password>` with your values:

    ```powershell
    $cert = New-SelfSignedCertificate -DnsName "<your-subdomain>" `
        -CertStoreLocation "cert:\LocalMachine\My" `
        -NotAfter (Get-Date).AddYears(1) `
        -FriendlyName "authCiamCert"

    $pwd = ConvertTo-SecureString -String "<your-password>" -Force -AsPlainText

    Export-PfxCertificate -Cert $cert -FilePath ".\auth-cert.pfx" -Password $pwd
    ```

1. Convert the PFX file to PEM format by using OpenSSL:

    ```cmd
    openssl pkcs12 -in auth-cert.pfx -out auth-cert.pem -clcerts -nokeys
    openssl pkcs12 -in auth-cert.pfx -out auth-key.pem -nocerts -nodes
    ```

## Configure environment variables

Create a `.env` file in the SPA project root with the following content:

```ini
HTTPS=true
HOST=<your-subdomain>
PORT=3000
SSL_CRT_FILE=./auth-cert.pem
SSL_KEY_FILE=./auth-key.pem
```

## Configure MSAL authentication

Update the MSAL configuration with values from your app registration.

1. In `authConfig.js`, set the MSAL configuration:

    ```javascript
    export const msalConfig = {
        auth: {
            clientId: "<your-client-id>",
            authority: "https://<tenant>.ciamlogin.com/<tenant>.onmicrosoft.com",
            redirectUri: "https://<your-subdomain>:3000"
        }
    };
    ```

1. In `appConfig`, set the application configuration:

    ```javascript
    export const appConfig = {
        proxyDomain: "http://localhost:3001/api",
        appId: "<your-client-id>",
        appSecret: "<your-client-secret>",
        tenantId: "<your-tenant-id>",
        customDomain: "<your-subdomain>"
    };
    ```

> [!CAUTION]
> This configuration is for local development only. Don't expose client secrets in production code or commit them to source control. In production, store secrets in [Azure Key Vault](/azure/key-vault/general/overview) or another secure secret store.

## Run the application

1. Install dependencies and start the local CORS proxy and the SPA:

    ```cmd
    npm install
    npm run cors
    npm start
    ```

1. Open the application in your browser:

    ```text
    https://<your-subdomain>:3000
    ```

## Test passkey management

After you sign in, the sample app supports the following operations:

- List existing passkeys.
- Register a passkey on the same device or across devices.
- Delete a passkey.

> [!NOTE]
> The sample app limits registration to one passkey per device. This is a sample-app limitation, not a Microsoft Entra External ID or WebAuthn limit.

## Application structure

The sample uses the following structure:

```text
SPA/
├── public/
├── src/
│   ├── components/
│   ├── hooks/
│   ├── services/
│   ├── utils/
│   ├── styles/
│   ├── App.jsx
│   ├── authConfig.js
│   └── index.js
├── auth-cert.pem
├── auth-key.pem
├── cors.js
├── package.json
└── README.md
```

## Clean up resources

If you no longer need the resources you created in this tutorial:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Browse to **Microsoft Entra ID** > **App registrations**.
1. Select the app you registered for this tutorial.
1. Select **Delete**.

## Related content

- [Sample on GitHub: ms-eeid-passkey-sample-app](https://github.com/Azure-Samples/ms-eeid-passkey-sample-app)
- [Enable passkeys (FIDO2) for your organization](/entra/identity/authentication/how-to-enable-passkey-fido2)
- [Plan a passwordless authentication deployment in Microsoft Entra ID](/entra/identity/authentication/howto-authentication-passwordless-deployment)
- [fido2AuthenticationMethod resource type (Microsoft Graph)](/graph/api/resources/fido2authenticationmethod)
- [Overview of the Microsoft Authentication Library (MSAL)](/entra/identity-platform/msal-overview)

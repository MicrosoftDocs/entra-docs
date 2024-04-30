---
title: Secure APIs used as API connectors in Microsoft Entra External ID self-service sign-up user flows
description: Secure your custom RESTful APIs used as API connectors in self-service sign-up user flows.
 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 01/23/2024

ms.author: mimart
author: msmimart
manager: celestedg
ms.custom: "it-pro"
ms.collection: M365-identity-device-management

#customer intent: As a developer integrating a REST API within a Microsoft Entra External ID self-service sign-up user flow, I want to secure my API endpoint with authentication, so that only authorized services, such as Microsoft Entra ID, can make calls to my endpoint.
---

# Secure your API used an API connector in Microsoft Entra External ID self-service sign-up user flows

When integrating a REST API within a Microsoft Entra External ID self-service sign-up user flow, you must protect your REST API endpoint with authentication. The REST API authentication ensures that only services that have proper credentials, such as Microsoft Entra ID, can make calls to your endpoint. This article explores how to secure REST API. 

## Prerequisites
Complete the steps in the [Walkthrough: Add an API connector to a sign-up user flow](self-service-sign-up-add-api-connector.md) guide.

You can protect your API endpoint by using either HTTP basic authentication or HTTPS client certificate authentication. In either case, you provide the credentials that Microsoft Entra ID uses when calling your API endpoint. Your API endpoint then checks the credentials and performs authorization decisions.

## HTTP basic authentication

[!INCLUDE [portal updates](~/includes/portal-update.md)]

HTTP basic authentication is defined in [RFC 2617](https://tools.ietf.org/html/rfc2617). Basic authentication works as follows: Microsoft Entra ID sends an HTTP request with the client credentials (`username` and `password`) in the `Authorization` header. The credentials are formatted as the base64-encoded string `username:password`. Your API then is responsible for checking these values to perform other authorization decisions.

To configure an API Connector with HTTP basic authentication, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **External Identities** > **Overview**.
1. Select **All API connectors**, and then select the **API Connector** you want to configure.
1. For the **Authentication type**, select **Basic**.
1. Provide the **Username**, and **Password** of your REST API endpoint.
    :::image type="content" source="media/secure-api-connector/api-connector-config.png" alt-text="Screenshot of basic authentication configuration for an API connector.":::
1. Select **Save**.

## HTTPS client certificate authentication

Client certificate authentication is a mutual certificate-based authentication, where the client, Microsoft Entra ID, provides its client certificate to the server to prove its identity. This happens as a part of the SSL handshake. Your API is responsible for validating the certificates belong to a valid client, such as Microsoft Entra ID, and performing authorization decisions. The client certificate is an X.509 digital certificate. 

> [!IMPORTANT]
> In production environments, the certificate must be signed by a certificate authority.

### Create a certificate

#### Option 1: Use Azure Key Vault (recommended)

To create a certificate, you can use [Azure Key Vault](/azure/key-vault/certificates/create-certificate), which has options for self-signed certificates and integrations with certificate issuer providers for signed certificates. Recommended settings include:
- **Subject**: `CN=<yourapiname>.<tenantname>.onmicrosoft.com`
- **Content Type**: `PKCS #12`
- **Lifetime Acton Type**: `Email all contacts at a given percentage lifetime` or `Email all contacts a given number of days before expiry`
- **Key Type**: `RSA`
- **Key Size**: `2048`
- **Exportable Private Key**: `Yes` (in order to be able to export `.pfx` file)

You can then [export the certificate](/azure/key-vault/certificates/how-to-export-certificate).

#### Option 2: prepare a self-signed certificate using PowerShell

[!INCLUDE [active-directory-b2c-create-self-signed-certificate](~/includes/azure-docs-pr/active-directory-b2c-create-self-signed-certificate.md)]

### Configure your API Connector

To configure an API Connector with client certificate authentication, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **External Identities** > **Overview**.
1. Select **All API connectors**, and then select the **API Connector** you want to configure.
1. For the **Authentication type**, select **Certificate**.
1. In the **Upload certificate** box, select your certificate's .pfx file with a private key.
1. In the **Enter Password** box, type the certificate's password.
  :::image type="content" source="media/secure-api-connector/api-connector-upload-cert.png" alt-text="Screenshot of certificate authentication configuration for an API connector.":::
1. Select **Save**.

### Perform authorization decisions 
Your API must implement the authorization based on sent client certificates in order to protect the API endpoints. For Azure App Service and Azure Functions, see [configure TLS mutual authentication](/azure/app-service/app-service-web-configure-tls-mutual-auth) to learn how to enable and *validate the certificate from your API code*.  You can alternatively use Azure API Management as a layer in front of any API service to [check client certificate properties](/azure/api-management/api-management-howto-mutual-certificates-for-clients) against desired values.

### Renewing certificates
It's recommended you set reminder alerts for when your certificate expires. You'll need to generate a new certificate and repeat the steps above when used certificates are about to expire. To "roll" the use of a new certificate, your API service can continue to accept old and new certificates for a temporary amount of time while the new certificate is deployed. 

To upload a new certificate to an existing API connector, select the API connector under **API connectors** and select on **Upload new certificate**. The most recently uploaded certificate that isn't expired and whose start date has passed will automatically be used by Microsoft Entra ID.

  :::image type="content" source="media/secure-api-connector/api-connector-renew-cert.png" alt-text="Screenshot of a new certificate, when one already exists.":::

## API key authentication

Some services use an "API key" mechanism to obfuscate access to your HTTP endpoints during development by requiring the caller to include a unique key as an HTTP header or HTTP query parameter. For [Azure Functions](/azure/azure-functions/functions-bindings-http-webhook-trigger#authorization-keys), you can accomplish this by including the `code` as a query parameter in the **Endpoint URL** of your API connector. For example, `https://contoso.azurewebsites.net/api/endpoint`<b>`?code=0123456789`</b>). 

This isn't a mechanism that should be used alone in production. Therefore, configuration for basic or certificate authentication is always required. If you don't wish to implement any authentication method (not recommended) for development purposes, you can select 'basic' authentication in the API connector configuration and use temporary values for `username` and `password` that your API can disregard while you implement proper authorization.

## Next steps
- Get started with our [quickstart samples](code-samples-self-service-sign-up.md#api-connector-azure-function-quickstarts).

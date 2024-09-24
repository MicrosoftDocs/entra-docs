---
title: Exchange a SAML token issued by Active Directory Federation Services (AD FS) for a Microsoft Graph access token
description: Learn how to fetch data from Microsoft Graph without prompting an AD FS-federated user for credentials by using the SAML bearer assertion flow.
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.date: 09/24/2024
ms.reviewer: nickludwig, paulgarn
ms.service: identity-platform
ms.topic: how-to

#Customer intent: As a developer integrating SSO with AD FS and Microsoft Graph, I want to exchange a SAML token issued by AD FS for an OAuth 2.0 access token, so that I can enable SSO in my application and access Microsoft Graph APIs.
---

# Exchange a SAML token issued by AD FS for a Microsoft Graph access token

To enable single sign-on (SSO) in applications that use SAML tokens issued by Active Directory Federation Services (AD FS) and also require access to Microsoft Graph, follow the steps in this article.

You'll enable the SAML bearer assertion flow to exchange a SAMLv1 token issued by the federated AD FS instance for an OAuth 2.0 access token for Microsoft Graph. When the user's browser is redirected to Microsoft Entra ID to authenticate them, the browser picks up the session from the SAML sign-in instead of asking the user to enter their credentials.

> [!IMPORTANT]
> This scenario works **only** when AD FS is the federated identity provider that issued the original SAMLv1 token. You **cannot** exchange a SAMLv2 token issued by Microsoft Entra ID for a Microsoft Graph access token.

## Prerequisites

- AD FS federated as an identity provider for single sign-on; see [Setting up AD FS and Enabling Single Sign-On to Office 365](/archive/blogs/canitpro/step-by-step-setting-up-ad-fs-and-enabling-single-sign-on-to-office-365) for an example.
- A rest client to make HTTP requests.

## Scenario overview

The OAuth 2.0 SAML bearer assertion flow allows you to request an OAuth access token using a SAML assertion when a client needs to use an existing trust relationship. The signature applied to the SAML assertion provides authentication of the authorized app. A SAML assertion is an XML security token issued by an identity provider and consumed by a service provider. The service provider relies on its content to identify the assertion's subject for security-related purposes.

The SAML assertion is posted to the OAuth token endpoint. The endpoint processes the assertion and issues an access token based on prior approval of the app. The client isn't required to have or store a refresh token, nor is the client secret required to be passed to the token endpoint.

## Register the application with Microsoft Entra ID

Start by registering the application in the [portal](https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade):

1. Sign in to the [app registration page of the portal](https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade) (Please note that we are using the v2.0 endpoints for Graph API and hence need to register the application in Microsoft Entra admin center. Otherwise we could have used the registrations in Microsoft Entra ID).
1. Select **New registration**.
1. When the **Register an application** page appears, enter your application's registration information:
    1. **Name** - Enter a meaningful application name that will be displayed to users of the app.
    1. **Supported account types** - Select which accounts you would like your application to support.
    1. **Redirect URI (optional)** - Select the type of app you're building, Web, or Public client (mobile & desktop), and then enter the redirect URI (or reply URL) for your application.
    1. When finished, select **Register**.
1. Make a note of the application (client) ID.
1. In the left pane, select **Certificates & secrets**. Click **New client secret** in the **Client secrets** section. Copy the new client secret, you won't be able to retrieve when you leave the page.
1. In the left pane, select **API permissions** and then **Add a permission**. Select **Microsoft Graph**, then **delegated permissions**, and then select **Tasks.read** since we intend to use the Outlook Graph API.

## Get the SAML assertion from AD FS

Create a POST request to the AD FS endpoint using SOAP envelope to fetch the SAML assertion:

`POST https://ADFSFQDN/adfs/services/trust/2005/usernamemixed`

**Parameter values:**

| Key | Value |
| --- | ----- |
| client-request-id | CLIENT_ID |

**Header values:**

| Key | Value |
| --- | ----- |
| SOAPAction | http://schema.xlmsoap.org/ws/2005/02/trust/RST/Issue |
| Content-Type | application/soap+xml |
| client-request-id | CLIENT_ID |
| return-client-request-id | true |
| Accept | application/json |

**AD FS request body:**

```xml
<s:Envelope xmlns:s="http://www.w3.org/2003/05/soap-envelope">
  <s:Header>
    <a:Action s:mustUnderstand="1" xmlns:a="http://schemas.xmlsoap.org/ws/2004/08/addressing">http://schemas.xmlsoap.org/ws/2005/02/trust/RST/Issue</a:Action>
    <a:MessageID>urn:uuid:9af3303f-1f9e-466c-9938-c9a982822557</a:MessageID>
    <a:ReplyTo>
      <a:Address>http://www.w3.org/2005/08/addressing/anonymous</a:Address>
    </a:ReplyTo>
    <o:Security s:mustUnderstand="1" xmlns:o="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
      <o:UsernameToken u:Id="uuid-2525825F-6A4A-44D8-83BA-68E26F4DD99">
        <o:Username>USERNAME</o:Username>
        <o:Password>PASSWORD</o:Password>
      </o:UsernameToken>
    </o:Security>
  </s:Header>
  <s:Body>
    <trust:RequestSecurityToken xmlns:trust="http://schemas.xmlsoap.org/ws/2005/02/trust">
      <wsp:AppliesTo xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy">
        <a:EndpointReference>
          <a:Address>urn:federation:MicrosoftOnline</a:Address>
        </a:EndpointReference>
      </wsp:AppliesTo>
      <trust:KeyType>http://schemas.xmlsoap.org/ws/2005/05/identity/NoProofKey</trust:KeyType>
      <trust:RequestType>http://schemas.xmlsoap.org/ws/2005/02/trust/Issue</trust:RequestType>
      <trust:TokenType>http://schemas.xmlsoap.org/ws/2005/02/sc/sct</trust:TokenType>
    </trust:RequestSecurityToken>
  </s:Body>
</s:Envelope>
```

Once the request is posted successfully, you should receive a SAML assertion from AD FS. Only the **SAML:Assertion** tag data is required, convert it to base64 encoding to use in further requests.

### Get the OAuth 2.0 token using the SAML assertion

Fetch an OAuth 2.0 token using the AD FS assertion response.

1. Create a POST request with the header values:

| Key           | Value                        | Description                           |
|---------------|------------------------------|---------------------------------------|
| Host          | login.microsoftonline.com    |                                       |
| Content-Type  | application/x-www-form-urlencoded |                                       |

1. In the body of the request, replace client_id, client_secret, and assertion (the base64 encoded SAML assertion obtained the previous step):

| Key           | Value                                                | Description                           |
|---------------|------------------------------------------------------|---------------------------------------|
| grant_type    | urn:ietf:params:oauth:grant-type:saml2-bearer        | Specifies the type of grant           |
| client_id     | CLIENTID                                             | Your application's client ID          |
| client_secret | CLIENTSECRET                                         | Your application's client secret      |
| assertion     | ASSERTION                                            | The base64 encoded SAML assertion     |
| scope         | openid https://graph.microsoft.com/.default          | The scopes for which the token is valid|

3. Upon successful request, you'll receive an access token from Microsoft Entra ID.

### Get the data with the OAuth 2.0 token

After receiving the access token, call the Graph APIs (Outlook tasks in this example).

1. Create a GET request with the access token fetched in the previous step:

| Key           | Value                            | Description                             |
|---------------|----------------------------------|-----------------------------------------|
| Content-Type  | application/x-www-form-urlencoded |                                         |
| Authorization | Bearer ACCESS_TOKEN              | Access token obtained from the OAuth 2.0 token request |

1. Upon successful request, you'll receive a JSON response.

## Next steps

For more information about app registration and authentication flow, see:

- [Register an application with the Microsoft identity platform](quickstart-register-app.md)
- [Authentication flows and application scenarios](authentication-flows-app-scenarios.md)

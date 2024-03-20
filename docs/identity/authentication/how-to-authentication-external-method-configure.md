---
title: Configure a new external identity provider with Microsoft Entra ID
description: Learn how to configure a new external identity provider with Microsoft Entra ID


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/27/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa
---
# Configure a new external identity provider with Microsoft Entra ID

An application representing the integration is required for external authentication methods to issue the id_token_hint.  This application can either be created in each tenant that will use the external provider, it can be created as single multi-tenant application that admins enabling the integration will consent for their tenant.  

Using a multi-tenant application reduces the liklihood of misconfiguration in each tenant and enables providers to make changes to metadata (for example, reply URLs) in one place, rather than requiring each tenant to make changes. To configure as a multi-tenant application, the provider admin must first:

1. Create an Entra ID tenant if they don't have one yet.
1. Using that tenant, register an application in Entra ID. 
1. Set the app’s Supported Account types to: Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant). 

   Failure to set up the app as multitenant causes the following error:
   AADSTS900491: Service principal `<your App id>` not found.

1. Add the delegated permission openid and profile of Microsoft.Graph to the app.
1. Do not publish any scopes in this application. 
1. Add the external identity provider’s valid authorization_endpoint URLs to that application as Reply URLs. 
   
   >[!NOTE]
   >The authorization_endpoint provided in the provider’s discovery document should be added as a redirect url in the app registration. 
   >Otherwise, you get the following error:
   >*ENTRA IDSTS50161: Failed to validate authorization url of external claims provider!*

The application registration process will result in the creation of an application with several properties. The following properties are required for our scenario.

Property | Description
---------|------------
Object Id | This can be used with Microsoft Graph to query the application info. <br>The provider could use this id to retrieve and edit the application information programmatically.
Application ID | This will be used by the external identity provider as their app’s ClientId.
Home page URL | The provider home page url. This is not used for anything but is required as part of application registration.
Reply URLs | Valid redirect URLs for the provider. One of these should match the provider host URL that was set for the provider’s Entra ID tenant. One of the reply URLs registered must match the prefix of the authorization_endpoint that Entra ID will retrieve through OIDC discovery for the host url.
 

## Configure optional claims

If a provider needs upn or email claims for discovery, then you can configure these [optional claims for id_token](/entra/identity-platform/optional-claims).

>[!NOTE]
>The preceding steps need to be done for each cloud environment, whether the approach is a multi-tenant app or apps created per-tenant. For the public Azure and Azure US Government clouds, if a multi-tenant app is being used rather than an app per tenant, then a different application which includes AppId is required for each environment.

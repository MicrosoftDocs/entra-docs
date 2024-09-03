---
title: Custom claims provider overview
description: Conceptual article describing the custom claims provider as part of the custom authentication extension framework.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 04/10/2023
ms.reviewer: JasSuri
ms.service: identity-platform

ms.topic: concept-article
titleSuffix: Microsoft identity platform
#Customer intent: As a developer, I want to learn about custom claims provider so that I can augment tokens with claims from an external identity system or role management system.
---

# Custom claims provider

This article provides an overview to the Microsoft Entra custom claims provider.
When a user authenticates to an application, a custom claims provider can be used to add  claims into the token. A custom claims provider is made up of a custom authentication extension that calls an external REST API, to fetch claims from external systems. A custom claims provider can be assigned to one or many applications in your directory.

Key data about a user is often stored in systems external to Microsoft Entra ID. For example, secondary email, billing tier, or sensitive information. Some applications may rely on these attributes for the application to function as designed. For example, the application may block access to certain features based on a claim in the token.

The following video provides an excellent overview of the Microsoft Entra custom authentication extensions and custom claims providers:

> [!VIDEO https://www.youtube.com/embed/1tPA7B9ztz0]

Use a custom claims provider for the following scenarios:

- **Migration of legacy systems** - You may have legacy identity systems such as Active Directory Federation Services (AD FS) or data stores (such as LDAP directory) that hold information about users. You'd like to migrate these applications, but can't fully migrate the identity data into Microsoft Entra ID. Your apps may depend on certain information on the token, and can't be rearchitected.
- **Integration with other data stores that can't be synced to the directory** - You may have third-party systems, or your own systems that store user data. Ideally this information could be consolidated, either through [synchronization](~/identity/hybrid/cloud-sync/what-is-cloud-sync.md) or direct migration, in the Microsoft Entra directory. However, that isn't always feasible. The restriction may be because of data residency, regulations, or other requirements.

## Token issuance start event listener

An event listener is a procedure that waits for an event to occur. The custom authentication extension uses the **token issuance start** event listener. The  event is triggered when a token is about to be issued to your application. When the event is triggered the custom authentication extension REST API is called to fetch attributes from external systems.

To set up a custom claims provider, you'll need to [create a REST API with a token issuance start event](./custom-extension-tokenissuancestart-setup.md), then [configure a custom claim provider for a token issuance event](./custom-extension-tokenissuancestart-configuration.md).

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=TokenAugmentation)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Add claims to security tokens from a REST API” use case.

## Authentication events trigger for Azure Functions client library for .NET

<!--As an API developer, to be able to handle token issuance start custom extensions, I need to easily interact with the request object and easily build a response object without necessarily needing to know the exact format of the request or response

I should be able to build an Azure function in minutes as a basic function structure is there, the request is read for a particular event and there's no need to specify the format. As long as you know its token issuance event, once the request is parsed automatically into a tokenissuancestart event request and the response you are responding with, you can respond for that particular event.

For local testing of a URL, you'd get one similar to https://localhost:7071/api/onTokenIssuanceStart

AuthenticationEventResponse -> Whatever is coming in, parse it to the correct response
-->

The authentication events trigger for Azure Functions allows you to implement a custom extension to handle Microsoft Entra ID authentication events. The authentication events trigger handles all the backend processing for incoming HTTP requests for authentication events.

- Token validation for securing the API call
- Object model, typing and IDE intellisense
- Inbound and outbound validation of the API request and response schemas

## See also

- [Create a REST API with a token issuance start event](custom-extension-tokenissuancestart-setup.md)
- [Configure a SAML app to receive tokens with claims from an external store](custom-extension-configure-saml-app.md)
- [Custom claims provider reference](custom-claims-provider-reference.md) article.
---
title: Custom authentication extensions overview 
description: Use Microsoft Entra custom authentication extensions to customize your user's sign-in experience by using REST APIs or outbound webhooks.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 10/27/2023
ms.reviewer: JasSuri
ms.service: identity-platform

ms.topic: concept-article
titleSuffix: Microsoft identity platform

#Customer intent: As a developer integrating external systems with Microsoft Entra ID, I want to create custom authentication extensions using a REST API, so that I can customize the authentication experience and add business logic based on event types and HTTP response payloads.
---

# Custom authentication extensions overview

This article provides a high-level, technical overview of [custom authentication extensions](~/external-id/customers/concept-custom-extensions.md) for Microsoft Entra ID. Custom authentication extensions allow you to customize the Microsoft Entra authentication experience by integrating with external systems.

The following diagram depicts the sign-in flow integrated with a custom authentication extension.

:::image type="content" source="media/custom-extension-overview/workflow.png" alt-text="Diagram that shows a token being augmented with claims from an external source." border="false" lightbox="media/custom-extension-overview/workflow.png":::

1. A user attempts to sign into an app and is redirected to the Microsoft Entra sign-in page.
1. Once a user completes a certain step in the authentication, an **event listener** is triggered.
1. Your **custom authentication extension** sends an HTTP request to your **REST API endpoint**. The request contains information about the event, the user profile, session data, and other context information.
1. The **REST API** performs a custom workflow.
1. The **REST API** returns an HTTP response to Microsoft Entra ID.
1. The Microsoft Entra **custom authentication extension** processes the response and customizes the authentication based on the event type and the HTTP response payload.
1. A **token** is returned to the **app**.

## Custom authentication extension REST API endpoint

When an event fires, Microsoft Entra ID calls a REST API endpoint that you own. The request to the REST API contains information about the event, the user profile, authentication request data, and other context information.

You can use any programming language, framework, and hosting environment to create and host your custom authentication extensions REST API. For a quick way to get started, use a C# Azure Function. Azure Functions lets you run your code in a serverless environment without having to first create a virtual machine (VM) or publish a web application.

Your REST API must handle:

- Token validation for securing the REST API calls.
- Business logic
- Incoming and outgoing validation of HTTP request and response schemas.
- Auditing and logging.
- Availability, performance and security controls.

For developers running the REST API on Azure Functions, consider using the [Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/entra/Microsoft.Azure.WebJobs.Extensions.AuthenticationEvents) NuGet library, which helps with token validation implementation using Microsoft Azure's built-in authentication capabilities. It provides a data model for different event types, initiates incoming and outgoing request and response processing, so more focus can be put on the business logic.  

### Protect your REST API

To ensure the communications between the custom authentication extension and your REST API are secured appropriately, multiple security controls must be applied.

1. When the custom authentication extension calls your REST API, it sends an HTTP `Authorization` header with a bearer token issued by Microsoft Entra ID.
1. The bearer token contains an `appid` or `azp` claim. Validate that the respective claim contains the  `99045fe1-7639-4a75-9d4a-577b6ca3810f` value. This value ensures that the Microsoft Entra ID is the one who calls the REST API.
    1. For **V1** Applications, validate the `appid` claim.
    1. For **V2** Applications, validate the `azp` claim.
1. The bearer token `aud` audience claim contains the ID of the associated application registration. Your REST API endpoint needs to validate that the bearer token is issued for that specific audience.
1. The bearer token `iss` issuer claim contains the Microsoft Entra issuer URL. Depending on your tenant configuration, the issuer URL will be one of the following;
    - Workforce: `https://login.microsoftonline.com/{tenantId}/v2.0`.
    - Customer: `https://{domainName}.ciamlogin.com/{tenantId}/v2.0`.

## Custom claims provider

A custom claims provider is a type of custom authentication extension that calls a REST API to fetch claims from external systems. A custom claims provider maps claims from external systems into tokens and can be assigned to one or many applications in your directory.

Learn more about [custom claims providers](custom-claims-provider-overview.md).

## Attribute collection start and submit events

Attribute collection start and submit events can be used with custom authentication extensions to add logic before and after attributes are collected from a user. For example, you can add a workflow to validate the attributes a user enters during sign-up.  The **OnAttributeCollectionStart** event occurs at the beginning of the attribute collection step, before the attribute collection page renders. It lets you add actions such as prefilling values and displaying a blocking error. The **OnAttributeCollectionSubmit** event triggers after the user enters and submits attributes, allowing you to add actions like validating entries or modifying attributes.

> [!NOTE]
> Attribute collection start and submit events are currently available only for user flows in Microsoft Entra External ID in external tenants. For details, see [Add your own business logic](~/external-id/customers/concept-custom-extensions.md).

## See also

- Learn how to [create custom authentication extensions for attribute collection start and submit events](custom-extension-attribute-collection.md) with a sample OpenID Connect application.

---
title: Custom authentication extensions overview 
description: Use Microsoft Entra custom authentication extensions to customize your user's sign-in experience by using REST APIs or outbound webhooks.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 05/04/2025
ms.reviewer: jasuri
ms.service: identity-platform

ms.topic: concept-article
titleSuffix: Microsoft identity platform

#Customer intent: As a developer integrating external systems with Microsoft Entra ID, I want to create custom authentication extensions using a REST API, so that I can customize the authentication experience and add business logic based on event types and HTTP response payloads.
---

# Custom authentication extensions overview

The Microsoft Entra ID authentication pipeline consists of several built-in authentication events, like the validation of user credentials, conditional access policies, multifactor authentication, self-service password reset, and more.

Microsoft Entra custom authentication extensions allow you to extend authentication flows with your own business logic at specific points within the authentication flow. A custom authentication extension is essentially an event listener that, when activated, makes an HTTP call to a REST API endpoint where you define a workflow action. 

For example, you could use a custom claims provider to add external user data to the security token before the token is issued. You could add an attribute collection workflow to validate the attributes a user enters during sign-up. This article provides a high-level, technical overview of Microsoft Entra ID custom authentication extensions.


The [Microsoft Entra Custom Authentication Extension Overview](https://youtu.be/ZU90avf0Qyc?si=Gf77u4HS_5uw6Qjp) video provides a comprehensive outline of the key features and capabilities of the custom authentication extensions.

> [!VIDEO https://www.youtube.com/embed/ZU90avf0Qyc?si=N-kzaOC7KgeZmpKk]

## Components overview

There are two components you need to configure: a custom authentication extension in Microsoft Entra and a REST API. The custom authentication extension specifies your REST API endpoint, when the REST API should be called, and the credentials to call the REST API. 

This video provides detailed instructions on configuring Microsoft Entra custom authentication extensions and offers best practices and valuable tips for optimal implementation.

> [!VIDEO https://www.youtube.com/embed/EamkX9aFTYw?si=k0ziK2thbJ6V4BtZ]


## Sign-in flow

The following diagram depicts the sign-in flow integrated with a custom authentication extension.

:::image type="content" source="media/custom-extension-overview/workflow.png" alt-text="Diagram that shows a token being augmented with claims from an external source." border="false" lightbox="media/custom-extension-overview/workflow.png":::

1. A user attempts to sign into an app and is redirected to the Microsoft Entra sign-in page.
1. Once a user completes a certain step in the authentication, an **event listener** is triggered.
1. Your **custom authentication extension** sends an HTTP request to your **REST API endpoint**. The request contains information about the event, the user profile, session data, and other context information.
1. The **REST API** performs a custom workflow.
1. The **REST API** returns an HTTP response to Microsoft Entra ID.
1. The Microsoft Entra **custom authentication extension** processes the response and customizes the authentication based on the event type and the HTTP response payload.
1. A **token** is returned to the **app**.

## REST API endpoints

When an event is triggered, Microsoft Entra ID invokes a REST API endpoint that you own. The REST API must be publicly accessible. It can be hosted using Azure Functions, Azure App Service, Azure Logic Apps, or another publicly available API endpoint.
 
You have the flexibility to use any programming language, framework, or  low-code-no-code solution, such as Azure Logic Apps to develop and deploy your REST API. For a quick way to get started, consider employing Azure Function. It lets you run your code in a serverless environment without having to first create a virtual machine (VM) or publish a web application.

Your REST API must handle:

- [Token validation for securing the REST API calls](#protect-your-rest-api).
- Business logic
- [Return data and action type](#return-data-and-action-type) 
- Incoming and outgoing validation of HTTP request and response schemas.
- Auditing and logging.
- Availability, performance, and security controls.

### Request payload

The request to the REST API includes a JSON payload containing details about the event, user profile, authentication request data, and other context information. The attributes within the JSON payload can be used to perform logic by your API.

For example, in the [Token issuance start](#token-issuance-start) event, the request payload may include the user's unique identifier, allowing you to retrieve the user profile from your own database. The request payload data must follow the schema as specified in the event  document.


### Return data and action type

After your web API performs the workflow with your business logic, it must return an **action type** that directs Microsoft Entra on how to proceed with the authentication process.

For example, in the case of the [attribute collection start](#attribute-collection-start) and [attribute collection submit](#attribute-collection-submit) events, the **action type** returned by your web API indicates whether the account can be created in the directory, show a validation error, or completely block the sign-up flow.

The REST API response may include data. For example, the [on token issuance start](#token-issuance-start) event may provide a set of attributes that can be mapped to the security token.

### Protect your REST API

To ensure the communications between the custom authentication extension and your REST API are secured appropriately, multiple security controls must be applied.

1. When the custom authentication extension calls your REST API, it sends an HTTP `Authorization` header with a bearer token issued by Microsoft Entra ID.
1. The bearer token contains an `appid` or `azp` claim. Validate that the respective claim contains the  `99045fe1-7639-4a75-9d4a-577b6ca3810f` value. This value ensures that the Microsoft Entra ID is the one who calls the REST API.
    1. For **V1** Applications, validate the `appid` claim.
    1. For **V2** Applications, validate the `azp` claim.
1. The bearer token `aud` audience claim contains the ID of the associated application registration. Your REST API endpoint needs to validate that the bearer token is issued for that specific audience.
1. The bearer token `iss` issuer claim contains the Microsoft Entra issuer URL. Depending on your tenant configuration, the issuer URL is one of the following;
    - Workforce: `https://login.microsoftonline.com/{tenantId}/v2.0`.
    - Customer: `https://{domainName}.ciamlogin.com/{tenantId}/v2.0`.

## Custom authentication event types

This section lists the custom authentication extensions events available in Microsoft Entra ID workforce and external tenants. For detailed information about the events, refer to the respective documentation.

|Event  |Workforce tenant|External tenant|
|---------|---------|---------|
| [Token issuance start](#token-issuance-start)  | :::image type="icon" source="./media/common/yes.png" border="false"::: | :::image type="icon" source="./media/common/yes.png" border="false"::: |
| [Attribute collection start](#attribute-collection-start)||:::image type="icon" source="./media/common/yes.png" border="false":::|
| [Attribute collection submit](#attribute-collection-submit)||:::image type="icon" source="./media/common/yes.png" border="false":::|
| [One time passcode send](#one-time-passcode-send)||:::image type="icon" source="./media/common/yes.png" border="false":::|

### Token issuance start

The token issuance start event, **OnTokenIssuanceStart** is triggered when a token is about to be issued to an application. It is an event type set up within a [custom claims provider](custom-claims-provider-overview.md). The custom claims provider is a custom authentication extension that calls a REST API to fetch claims from external systems. A custom claims provider maps claims from external systems into tokens and can be assigned to one or many applications in your directory.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=TokenAugmentation)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Add claims to security tokens from a REST API” use case.

### Attribute collection start 

[Attribute collection start](./custom-extension-attribute-collection.md) events can be used with custom authentication extensions to add logic before attributes are collected from a user. The **OnAttributeCollectionStart** event occurs at the beginning of the attribute collection step, before the attribute collection page renders. It lets you add actions such as prefilling values and displaying a blocking error. 

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=PreAttributeCollection)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “[Prepopulate sign-up attributes](https://woodgrovedemo.com/#usecase=PreAttributeCollection)” use case.

### Attribute collection submit

[Attribute collection submit](./custom-extension-attribute-collection.md) events can be used with custom authentication extensions to add logic after attributes are collected from a user. The **OnAttributeCollectionSubmit** event triggers after the user enters and submits attributes, allowing you to add actions like validating entries or modifying attributes.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=PostAttributeCollection)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “[Validate sign-up attributes](https://woodgrovedemo.com/#usecase=PostAttributeCollection)” use case, or the “[Block a user from continuing the sign-up process](https://woodgrovedemo.com/#usecase=BlockSignUp)” use case.

### One time passcode send
 
The **OnOtpSend** event is triggered when a one time passcode email is activated. It allows you to [call a REST API to use your own email provider](./custom-extension-email-otp-get-started.md). This event can be used to send customized emails to users who sign up with email address, sign in with email one-time passcode (Email OTP), reset their password using Email OTP, or use Email OTP for multifactor authentication (MFA).
 
When the **OnOtpSend** event is activated, Microsoft Entra sends a one-time passcode to the specified REST API you own. The REST API then uses your chosen email provider, such as Azure Communication Service or SendGrid, to send the one-time passcode with your custom email template, from address, and email subject, while also supporting localization.

> [!TIP]
> [![Try it now](media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CustomEmail)
>
> To try out this feature, go to the Woodgrove Groceries demo and start the “Use a custom Email Provider for One Time code” use case.


## Related content

- Learn more about [custom claims providers](custom-claims-provider-overview.md)
- [Create custom authentication extensions for attribute collection start and submit events](custom-extension-attribute-collection.md) with a sample OpenID Connect application
- [Configure a custom email provider for one time passcode send events](custom-extension-email-otp-get-started.md)

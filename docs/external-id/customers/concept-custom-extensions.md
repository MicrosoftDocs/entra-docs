---
title: Custom authentication extensions
description: Learn how to use custom authentication extensions in Microsoft Entra External ID. Integrate with external systems, add custom logic to authentication flows, and enhance user experiences.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 10/21/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to know 

---
# Extend authentication flows with your own business logic

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID user flows are designed for flexibility. Within a sign-up and sign-in user flow, there are built-in authentication events. You can also add custom authentication extensions at specific points within the authentication flow. A custom authentication extension is essentially an event listener that, when activated, makes an HTTP call to a REST API endpoint where you define a workflow action. For example, you could add an [attribute collection](#attribute-collection-start-and-submit-events) workflow to validate the attributes a user enters during sign-up, or you could use a [custom claims provider](#token-issuance-start-event) to add external user data to the token before the token is issued.

There are two components you need to configure: a custom authentication extension and a REST API. The custom authentication extension specifies your REST API endpoint, when the REST API should be called, and the credentials to call the REST API. You can create custom authentication extensions at the following points in the authentication flow:

- During sign-up, before or after attribute collection:
  - The **OnAttributeCollectionStart** event occurs at the beginning of the attribute collection step, before the attribute collection page renders.
  - The **OnAttributeCollectionSubmit** event occurs after the user enters and submits attributes.
- Upon token issuance using the **OnTokenIssuanceStart** event, which triggers just before a token is issued to the application.

:::image type="content" source="media/concept-custom-extensions/authentication-flow-events-inline.png" alt-text="Diagram showing extensibility points in the authentication flow." lightbox="media/concept-custom-extensions/authentication-flow-events-expanded.png" border="false":::

If you have a custom authentication extension configured at one of these points, Microsoft Entra ID makes a call to the REST API you define. The request to the REST API contains information about the event, the user profile, authentication request data, and other context information. In turn, the REST API performs the workflow actions.

This article provides an overview of custom authentication extensions in Microsoft Entra External ID.

## Attribute collection start and submit events

You can use custom authentication extensions to add workflows to attribute collection in your self-service sign-up user flows. For example, you can prefill attribute fields with custom values, validate a user's entries, and modify attributes, and display errors. Two events are enabled:

- **OnAttributeCollectionStart** - The OnAttributeCollectionStart event occurs at the beginning of the attribute collection process before the attribute collection page renders. This event can be used for scenarios like preventing the user from signing up based on their domain or adding attributes to be collected. The following scenarios are configurable for the OnAttributeCollectionStart event:

  - **continueWithDefaultBehavior** - Render the attribute collection page as usual.
  - **setPreFillValues** - Prefill attributes in the sign-up form.
  - **showBlockPage** - Show an error message and block the user from signing up.

- **OnAttributeCollectionSubmit** - The OnAttributeCollectionSubmit event occurs after the user enters and submits attributes. This event can be used for scenarios like validating or modifying the information provided by the user. For example, you can validate an invitation code or partner number, modify an address format, or return an error.

  - **continueWithDefaultBehavior** - Continue with the sign-up flow.
  - **modifyAttributeValues** - Overwrite the values the user submitted in the sign-up form.
  - **showValidationError** - Return an error based on the submitted values.
  - **showBlockPage** - Show an error message and block the user from signing up.

To configure the attribute collection start and submit events, you create a custom authentication extension REST API. When an event fires, Microsoft Entra ID sends an HTTP request to your REST API endpoint. The REST API can be an Azure Function, Azure Logic App, or another publicly available API endpoint. Your REST API endpoint is responsible for defining the workflow actions to take.

For details, see [Add attribute collection custom extensions to your user flow](~/identity-platform/custom-extension-attribute-collection.md?context=/entra/external-id/customers/context/customers-context).

## Token issuance start event

The token issuance start event is triggered once a user completes all of their authentication challenges and a security token is about to be issued.

When users authenticate to your application with Microsoft Entra ID, a security token is returned to your application. The security token contains claims that are statements about the user, such as name, unique identifier, or application roles. Beyond the default set of claims that are contained in the security token, you can define your own custom claims from external systems using a REST API you develop.  

In some cases, key data might be stored in systems external to Microsoft Entra, such as a secondary email, billing tier, or sensitive information. It's not always feasible for the information in the external system to be stored in the Microsoft Entra directory. For these scenarios, you can use a custom authentication extension and a custom claims provider to add this external data into tokens returned to your application.

A token issuance event extension involves the following components:

- **Custom claims provider**. A custom claims provider is a type of custom authentication extension that fetches data from external systems. The custom claims provider specifies the attributes to be added to the security token that is returned to your application. Multiple claims providers can share the same custom extension, so a different set of attributes can be added to the security token for each application.

- **REST API endpoint**. When an event fires, Microsoft Entra ID sends an HTTP request to your REST API endpoint. The REST API can be an Azure Function, Azure Logic App, or some other publicly available API endpoint. Your REST API endpoint interfaces with various data stores, including downstream databases, existing APIs, Lightweight Directory Access Protocol (LDAP) directories, or other stores that contain the attributes you want to add to the token configuration.

   The REST API returns an HTTP response, or action, back to Microsoft Entra ID containing the attributes. These attributes aren't automatically added to a token. Instead, an application's claims mapping policy must be configured for any attribute to be included in the token.

For details, see:

- [About custom authentication extensions](~/identity-platform/custom-extension-overview.md?context=/entra/external-id/customers/context/customers-context).
- [Configure a custom claims provider for a token issuance event](~/identity-platform/custom-extension-tokenissuancestart-configuration.md?context=/azure/active-directory/external-identities/customers/context/customers-context) using a custom claims provider.

## See also

- To learn more about how custom extensions work, see [Custom authentication extensions](~/identity-platform/custom-extension-overview.md?context=/entra/external-id/customers/context/customers-context).
- [Create a REST API with a token issuance start event](~/identity-platform/custom-extension-tokenissuancestart-setup.md?context=/azure/active-directory/external-identities/customers/context/customers-context).
- [Configure a custom claims provider for a token issuance event](~/identity-platform/custom-extension-tokenissuancestart-configuration.md?context=/azure/active-directory/external-identities/customers/context/customers-context).
- [Configure custom authentication extensions for attribute collection start and submit events](~/identity-platform/custom-extension-attribute-collection.md?context=/entra/external-id/customers/context/customers-context) with a sample OpenID Connect application.
- See the [Microsoft Entra External ID Developer Center](https://aka.ms/ciam/dev) for the latest developer content and resources.

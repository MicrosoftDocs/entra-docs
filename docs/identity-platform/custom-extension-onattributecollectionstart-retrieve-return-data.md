---
title: Retrieve and return data from an OnAttributeCollectionStart event
description: Reference documentation for a custom authentication extension that invokes the OnAttributeCollectionStart event for External ID customer configurations.
author: msmimart
manager: CelesteDG
ms.author: mimart
ms.date: 06/26/2025
ms.service: identity-platform

ms.topic: how-to
titleSuffix: Microsoft identity platform
#customer intent: As a developer creating a custom authentication extension for user sign-up flows, I want to understand the REST API schema for the OnAttributeCollectionStart event, so that I can design and implement my own REST API to handle attribute collection requests and responses before the user enters attributes.
---

# Retrieve and return data from an OnAttributeCollectionStart event

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

To modify the sign-up experience for your customer self-service sign-up user flows, you can create a custom authentication extension and invoke it at specific points in the user flow. The OnAttributeCollectionStart event occurs at the beginning of the attribute collection step, before the attribute collection page renders. This event allows you to define actions before attributes are collected from the user. For example, you can block a user from continuing the sign-up flow based on their federated identity or email, or prefill attributes with specified values. The following actions can be configured:

- **continueWithDefaultBehavior** - Render the attribute collection page as usual.
- **setPreFillValues** - Prefill attributes in the sign-up form.
- **showBlockPage** - Show an error message and block the user from signing up.

This article describes the REST API schema for the OnAttributeCollectionStart event. (See also the related article [Custom Extension for OnAttributeCollectionSubmit event](custom-extension-OnAttributeCollectionSubmit-reference.md).)

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=PreAttributeCollection)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “[Prepopulate sign-up attributes](https://woodgrovedemo.com/#usecase=PreAttributeCollection)” use case.
    
## REST API schema

To develop your own REST API for the attribute collection start event, use the following REST API data contract. The schema describes the contract to design the request and response handler.

Your custom authentication extension in Microsoft Entra ID makes an HTTP call to your REST API with a JSON payload. The JSON payload contains user profile data, authentication context attributes, and information about the application the user wants to sign in to. The JSON attributes can be used to perform extra logic by your API.

### Request to the external REST API

The request to your REST API is in the format shown below. In this example, the request includes user identities information along with built-in attributes (givenName and companyName) and custom attributes (universityGroups, graduationYear, and onMailingList).

The request contains the user attributes that are selected in the user flow for collection during self-service sign-up, including built-in attributes (for example, givenName and companyName) and [custom attributes that have already been defined](~/external-id/customers/how-to-define-custom-attributes.md) (for example, universityGroups, graduationYear, and onMailingList). Your REST API can't add new attributes.

The request also contains user identities, including the user's email if it was used as a verified credential to sign up. The password isn't sent.

Attributes in the start request contain their default values. For attributes with multiple values, the values are sent as a comma-delimited string. Because attributes haven't been collected from the user yet, most attributes won't have values assigned. The following HTTP request demonstrates how Microsoft Entra invokes your REST API. 

```http
POST https://example.azureWebsites.net/api/functionName
Content-Type: application/json
[Request payload]
```

The following JSON document provides an example of a request payload:

#### JSON

```json
{
  "type": "microsoft.graph.authenticationEvent.attributeCollectionStart",
  "source": "/tenants/aaaabbbb-0000-cccc-1111-dddd2222eeee/applications/<resourceAppguid>",
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartCalloutData",
    "tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
    "authenticationEventListenerId": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "customAuthenticationExtensionId": "11112222-bbbb-3333-cccc-4444dddd5555",
    "authenticationContext": {
        "correlationId": "<GUID>",
        "client": {
            "ip": "30.51.176.110",
            "locale": "en-us",
            "market": "en-us"
        },
        "protocol": "OAUTH2.0",
        "clientServicePrincipal": {
            "id": "<Your Test Applications servicePrincipal objectId>",
            "appId": "<Your Test Application App Id>",
            "appDisplayName": "My Test application",
            "displayName": "My Test application"
        },
        "resourceServicePrincipal": {
            "id": "<Your Test Applications servicePrincipal objectId>",
            "appId": "<Your Test Application App Id>",
            "appDisplayName": "My Test application",
            "displayName": "My Test application"
        }
    },
    "userSignUpInfo": {
      "attributes": {
        "givenName": {
          "@odata.type": "microsoft.graph.stringDirectoryAttributeValue",
          "value": "Larissa Price",
          "attributeType": "builtIn"
        },
        "companyName": {
          "@odata.type": "microsoft.graph.stringDirectoryAttributeValue",
          "value": "Contoso University",
          "attributeType": "builtIn"
        },
        "extension_<appid>_universityGroups": {
          "@odata.Type": "microsoft.graph.stringDirectoryAttributeValue",
          "value": "Alumni,Faculty",
          "attributeType": "directorySchemaExtension"
        },
        "extension_<appid>_graduationYear": {
          "@odata.type": "microsoft.graph.int64DirectoryAttributeValue",
          "value": 2010,
          "attributeType": "directorySchemaExtension"
        },
        "extension_<appid>_onMailingList": {
          "@odata.type": "microsoft.graph.booleanDirectoryAttributeValue",
          "value": false,
          "attributeType": "directorySchemaExtension"
        }
      },
      "identities": [
        {
          "signInType": "email",
          "issuer": "contoso.onmicrosoft.com",
          "issuerAssignedId": "larissa.price@contoso.onmicrosoft.com"
        }
      ]
    }
  }
}
```

### Response from the external REST API

The response value types match the request value types, for example:

- If the request contains an attribute `graduationYear` with an `@odata.type` of `int64DirectoryAttributeValue`, the response should include a `graduationYear` attribute with an integer value, such as `2010`.
- If the request contains an attribute with multiple values specified as a comma-delimited string, the response should contain the values in a comma-delimited string.

Microsoft Entra ID expects a REST API response in the following format. 

```http
HTTP/1.1 200 OK

Content-Type: application/json

[JSON document]
```

In the HTTP response, provide one of following JSON documents. The **continueWithDefaultBehavior** action specifies that your external REST API is returning a continuation response.

```json
{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionStart.continueWithDefaultBehavior"
      }
    ]
  }
}
```

The **setPrefillValues** action specifies that the external REST API is returning a response to prefill attributes with default values. Your REST API can't add new attributes. Any extra attributes that are returned but that aren't part of the attribute collection are ignored.

```json
{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionStart.setPrefillValues",
        "inputs": {
          "key1": "value1,value2,value3",
          "key2": true
        }
      }
    ]
  }
}
```

The **showBlockPage** action specifies that your external REST API is returning a blocking response.

```json
{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionStart.showBlockPage",
        "title": "Hold tight...",
        "message": "Your access request is already processing. You'll be notified when your request has been approved."
      }
    ]
  }
}
```

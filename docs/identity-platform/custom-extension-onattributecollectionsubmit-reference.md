---
title: OnAttributeCollectionSubmit reference
titleSuffix: Microsoft identity platform
description: Reference documentation for a custom authentication extension that invokes the OnAttributeCollectionSubmit event for External ID customer configurations.

author: msmimart
manager: CelesteDG

ms.service: active-directory
ms.subservice: develop

ms.topic: reference
ms.date: 10/27/2023
ms.author: mimart 

#Customer intent: As a developer, I want to learn about the REST API schema so that I can add workflows to the attribute collection submit event in the sign-up flow.

---
# Custom Extension for OnAttributeCollectionSubmit event (preview)

**Applies to:** Microsoft Entra External ID customer configurations

To modify the sign-up experience for your customer self-service sign-up user flows, you can create a custom authentication extension and invoke it at specific points in the user flow. The OnAttributeCollectionSubmit event occurs after the user enters and submits attributes and can be used to validate the information provided by the user. For example, you can validate an invitation code or partner number, modify an address format, allow the user to continue, or show a validation or block page. The following actions can be configured:

- **continueWithDefaultBehavior** - Continue with the sign-up flow.
- **modifyAttributeValues** - Overwrite the values the user submitted in the sign-up form.
- **showValidationError** - Return an error based on the submitted values.
- **showBlockPage** - Show an error message and block the user from signing up.

This article describes the REST API schema for the OnAttributeCollectionSubmit event. (See also the related article [Custom Extension for OnAttributeCollectionStart event](custom-extension-OnAttributeCollectionStart-reference.md).)

## REST API schema

To develop your own REST API for the attribute collection submit event, use the following REST API data contract. The schema describes the contract to design the request and response handler.

Your custom authentication extension in Microsoft Entra ID makes an HTTP call to your REST API with a JSON payload. The JSON payload contains user profile data, authentication context attributes, and information about the application the user wants to sign in to. The JSON attributes can be used to perform extra logic by your API.

### Request to the external REST API

The request to your REST API is in the format shown below. In this example, the request includes user identities information along with built-in attributes (givenName and companyName) and custom attributes (universityGroups, graduationYear, and onMailingList).

The request contains the user attributes that are selected in the user flow for collection during self-service sign-up, including built-in attributes (for example, givenName and companyName) and [custom attributes that have already been defined](~/external-id/customers/how-to-define-custom-attributes.md) (for example, universityGroups, graduationYear, and onMailingList). Your REST API can't add new attributes.

The request also contains user identities, including the user's email if it was used as a verified credential to sign up. The password is not sent. For attributes with multiple values, the values are sent as a comma-delimited string.

#### JSON

```json
POST https://exampleAzureFunction.azureWebsites.net/api/functionName

{
  "type": "microsoft.graph.authenticationEvent.attributeCollectionSubmit",
  "source": "/tenants/30000000-0000-0000-0000-000000000003/applications/<resourceAppguid>",
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionSubmitCalloutData",
    "tenantId": "30000000-0000-0000-0000-000000000003",
    "authenticationEventListenerId": "10000000-0000-0000-0000-000000000001",
    "customAuthenticationExtensionId": "10000000-0000-0000-0000-000000000002",
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
        },
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

Microsoft Entra ID expects a REST API response in the following format. The response value types match the request value types, for example:

- If the request contains an attribute `graduationYear` with an `@odata.type` of `int64DirectoryAttributeValue`, the response should include a `graduationYear` attribute with an integer value, such as `2010`.
- If the request contains an attribute with multiple values specified as a comma-delimited string, the response should contain the values in a comma-delimited string.

The **continueWithDefaultBehavior** action specifies that your external REST API is returning a continuation response.

```json
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionSubmitResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionSubmit.continueWithDefaultBehavior"
      }
    ]
  }
}
```

The **modifyAttributeValues** action specifies that your external REST API returns a response to modify and override attributes with default values after the attributes are collected. Your REST API can't add new attributes. Any extra attributes that are returned but that aren't part of the attribute collection are ignored.


```json
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionSubmitResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionSubmit.modifyAttributeValues",
        "attributes": {
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
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionSubmitResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionSubmit.showBlockPage",
        "message": "Your access request is already processing. You'll be notified when your request has been approved."
      }
    ]
  }
}
```

The **showValidationError** action specifies that your REST API is returning a validation error and an appropriate message and status code.

```json
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionSubmitResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionSubmit.showValidationError",
        "message": "Please fix the below errors to proceed.",
        "attributeErrors": {
          "city": "City cannot contain any numbers",
          "extension_<appid>_graduationYear": "Graduation year must be at least 4 digits"
        }
      }
    ]
  }
}
```

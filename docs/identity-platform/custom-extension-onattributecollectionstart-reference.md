---
title: OnAttributeCollectionStart reference
titleSuffix: Microsoft identity platform
description: Reference documentation for a custom authentication extension that invokes the OnAttributeCollectionStart event for External ID customer configurations.
services: active-directory
author: msmimart
manager: CelesteDG

ms.service: active-directory
ms.subservice: develop
ms.workload: identity
ms.topic: reference
ms.date: 10/15/2023
ms.author: mimart

#Customer intent: As a developer, I want to learn about the REST API schema so that I can add workflows to the attribute collection start event in the sign-up flow.

---

# Custom Extension for OnAttributeCollectionStart event

**Applies to:** Microsoft Entra External ID customer configurations

To modify the sign-up experience for your customer self-service sign-up user flows, you can create a custom authentication extension and invoke it at specific points in the user flow. The OnAttributeCollectionStart event occurs at the beginning of the attribute collection step, before the attribute collection page is rendered. This event allows you to define actions before attributes are collected from the user. For example, you can block a user from continuing the sign-up flow based on their federated identity or email, or prefill attributes with specified values. The following actions can be configured:

- **continueWithDefaultBehavior** - Render the attribute collection page as usual.
- **setPreFillValues** - Prefill attributes in the sign-up form.
- **showBlockPage** - Show an error message and block the user from signing up.

This article describes the REST API schema for the OnAttributeCollectionStart event. (See also the related article [Custom Extension for OnAttributeCollectionSubmit event](custom-extension-OnAttributeCollectionSubmit-reference.md).)

## REST API schema

To develop your own REST API for the attribute collection start event, use the following REST API data contract. The schema describes the contract to design the request and response handler.

Your custom authentication extension in Microsoft Entra ID makes an HTTP call to your REST API with a JSON payload. The JSON payload contains user profile data, authentication context attributes, and information about the application the user wants to sign in to. The JSON attributes can be used to perform extra logic by your API.

### Request to the external REST API

The request to your REST API is in the format shown below. In this example, the request includes user identities information along with built-in attributes (givenName and companyName) and custom attributes (universityGroups, graduationYear, and onMailingList).

The request contains the user attributes that are selected in the user flow for collection during self-service sign-up, including built-in attributes (for example, givenName and companyName) and [custom attributes](~/external-id/customers/how-to-define-custom-attributes) (for example, universityGroups, graduationYear, and onMailingList).

The request also contains user identities, including the user's email if it was used as a verified credential to sign up. The password is not sent.

Attributes in the start request contain their default values. For attributes with multiple values, the values are sent as a comma-delimited string. Because attributes haven't been collected from the user yet, most attributes won't have values assigned.

#### Properties

|Property |Type     |Description  |Key  |Required  |ReadOnly Value  |
|---------|---------|-------------|-----|----------|----------------|
|`userSignUpInfo` |`microsoft.graph.userSignUpInfo` | The UserSignUpInfo object that is sent to your external REST API when a custom extension is configured for the OnAttributeCollection Events only. | No  | Yes      | Yes      |
| `attributes` | `Core.Dictionary` | A dictionary of name/attribute pairs sent in the pipeline data, before the attribute collection is done.  | No  | Yes      | Yes      |
| `identities` | `Collection(microsoft.graph.objectIdentity)` | Represents the identities that can be used to sign in to this user account. An identity can be provided by Microsoft (also known as a local account), by organizations, or by social identity providers such as Facebook, Google, and Microsoft, and tied to a user account. May contain multiple items with the same signInType value. | No  | Yes      | Yes      |

#### JSON

```json
POST https://exampleAzureFunction.azureWebsites.net/api/functionName

{
  "type": "microsoft.graph.authenticationEvent.attributeCollectionStart",
  "source": "/tenants/{tenantId}/applications/{resourceAppId}",
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartCalloutData",
    "tenantId": "30000000-0000-0000-0000-000000000003",
    "authenticationEventListenerId": "10000000-0000-0000-0000-000000000001",
    "customAuthenticationExtensionId": "10000000-0000-0000-0000-000000000002",
    "authenticationContext": {
        "correlationId": "<GUID>",
        "client": {
            "ip": "30.51.176.110",
            "locale": "en-us",
            "market": "en-us"
      /*
      Note: The User has not been created at the point of this extension firing, which means that User object and Roles will not be present in the request.
      */
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
          "value": ["Alumni", "Faculty"],
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
          "signInType": "userPrincipalName",
          "issuer": "contoso.onmicrosoft.com",
          "issuerAssignedId": "larissa.price@contoso.onmicrosoft.com"
        },
        {
          "signInType": "userName",
          "issuer": "contoso.onmicrosoft.com",
          "issuerAssignedId": "larissa_price"
        },
        {
          "signInType": "federated",
          "issuer": "facebook.com",
          "issuerAssignedId": "0000000000"
        }
      ]
    }
  }
}
```
### Response from the external REST API

Microsoft Entra ID expects a REST API response in the following format. The response value types should match the request value types, for example:

- If the request contains an attribute `graduationYear` with an `@odata.type` of `int64DirectoryAttributeValue`, the response should include a `graduationYear` attribute with an integer value, such as `2010`. 
- If the request contains an attribute with multiple values specified as a comma-delimited string, the response should contain the values in a comma-delimited string.

### onAttributeCollectionStartResponseData

The event specific response data expected by Microsoft Entra ID from your external REST API.

#### Properties

| Property  | Type            | Description     | Key | Required | ReadOnly |
| --------- | --------------- | --------------- | --- | -------- | -------- |
| `actions` | `Collection(microsoft.graph.attributeCollectionStart.responseAction)` | The actions sent back to Microsoft Entra ID by the custom extension for the AttributeCollectionStart event. | No  | Yes      | Yes      |

#### JSON

```json
HTTP/1.1 200 OK

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


### continueWithDefaultBehavior action

This action specifies that your external REST API is returning a continuation response.

#### JSON

```json
HTTP/1.1 200 OK

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

### setPrefillValues action

This action specifies that the your external REST API is returning a response to prefill attributes with default values. The specified values in the input array will prefill attributes already collected in the `onAttributeCollection` managed handler. This action doesn't add attributes to be collected.

#### Properties

| Property | Type              |  Description  | Required | ReadOnly Value |
| -------- | ------------------| ------------- | -------- | -------------- |
| `inputs` | `Core.Dictionary` | A dictionary of attributes with default values to prefill during sign-up. | `Yes`    | `N/A`          |

#### JSON

```json
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionStart.setPrefillValues",
        "inputs": {
          "key1": ["value1", "false", "false"],
          "key2": true
        }
      }
    ]
  }
}
```

### showBlockPage action

This action specifies that your external REST API is returning a blocking response.

#### Properties

| Property  | Type         | Description              | Required | ReadOnly Value |
| --------- | ------------ | ------------------------ | -------- | -------------- |
| `message` | `Edm.String` | Description for the block page. If a string isn't provided, the default is "You are not permitted to sign up. Please contact the owner of the application/website." | `No`     | `N/A`          |

#### JSON

```json
HTTP/1.1 200 OK

{
  "data": {
    "@odata.type": "microsoft.graph.onAttributeCollectionStartResponseData",
    "actions": [
      {
        "@odata.type": "microsoft.graph.attributeCollectionStart.showBlockPage",
        "message": "Your access request is already processing. You'll be notified when your request has been approved."
      }
    ]
  }
}
```
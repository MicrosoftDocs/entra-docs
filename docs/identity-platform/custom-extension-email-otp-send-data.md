---
title: Retrieve and return data from an emailOtpSend event
description: Reference documentation for a custom authentication extension that invokes the emailOtpSend event for External ID customer configurations.
author: msmimart
manager: CelesteDG
ms.author: mimart
ms.date: 05/20/2025
ms.service: identity-platform

ms.topic: how-to
titleSuffix: Microsoft identity platform
#customer intent: As developer creating a custom authentication extension for user sign-up and password rest flows, I want to understand the REST API schema for the emailOtpSend event in order to design and implement a REST API to customize the verification email.
---

# Email OTP send event reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

To configure a custom email provider for [email one time passcode (OTP) send](custom-extension-email-otp-get-started.md) events, you  create a custom authentication extension and invoke it at specific points in the user flow. When the **emailOtpSend** event is activated, Microsoft Entra sends a one-time passcode to the specified REST API you own. 

The REST API then uses your chosen email provider, such as Azure Communication Service or SendGrid to send the one-time passcode with your custom email template, from address, email subject and more. This article describes the REST API schema for the emailOtpSend event.

## Request to the external REST API

The custom authentication extension you defined in Microsoft Entra ID makes an HTTP call to your REST API with a JSON payload. The JSON payload contains the user's email address and the one-time-passcode. The request also includes authentication context attributes and information about the application the user intends to sign in.

The following HTTP request demonstrates how Microsoft Entra invokes your REST API. This HTTP request can be used to debug your REST API by simulating a request from Microsoft Entra.

```http
POST https://example.azureWebsites.net/api/functionName

Content-Type: application/json

[Request payload]
```


The following JSON document provides an example of a request payload:

```json
{
    "type": "microsoft.graph.authenticationEvent.emailOtpSend",
    "source": "/tenants/ffff5f5f-aa6a-bb7b-cc8c-dddddd9d9d9d/applications/bbbbbbbb-cccc-dddd-2222-333333333333",
    "data": {
        "@odata.type": "microsoft.graph.onOtpSendCalloutData",
        "otpContext": {
            "identifier": "someone@example.com",
            "oneTimeCode": "12345678"
        },
        "tenantId": "ffff5f5f-aa6a-bb7b-cc8c-dddddd9d9d9d",
        "authenticationEventListenerId": "00001111-aaaa-2222-bbbb-3333cccc4444",
        "customAuthenticationExtensionId": "11112222-bbbb-3333-cccc-4444dddd5555",
        "authenticationContext": {
            "correlationId": "3333dddd-44ee-ffff-aa55-bbbbbbbb6666",
            "client": {
                "ip": "192.168.0.0",
                "locale": "en-us",
                "market": "en-us"
            },
            "protocol": "OAUTH2.0",
            "requestType": "signUp",
            "clientServicePrincipal": {
                "id": "aaaaaaaa-bbbb-cccc-1111-222222222222",
                "appId": "bbbbbbbb-cccc-dddd-2222-333333333333",
                "appDisplayName": "My Test application",
                "displayName": "My Test application"
            },
            "resourceServicePrincipal": {
                "id": "aaaaaaaa-bbbb-cccc-1111-222222222222",
                "appId": "bbbbbbbb-cccc-dddd-2222-333333333333",
                "appDisplayName": "My Test application",
                "displayName": "My Test application"
            }
        }
    }
}
```


### Response from the external REST API

Microsoft Entra ID expects a REST API response in the following HTTP.

```http
HTTP/1.1 200 OK

Content-Type: application/json

[JSON document]
```
 
In the HTTP response, provide the following JSON document:

```json
{
    "data": {
        "@odata.type": "microsoft.graph.OnOtpSendResponseData",
        "actions": [
            {
                "@odata.type": "microsoft.graph.OtpSend.continueWithDefaultBehavior"
            }
        ]
    }
}
```

## Next steps

Lean how to [configure a custom email provider for one time passcode send events](custom-extension-email-otp-get-started.md).

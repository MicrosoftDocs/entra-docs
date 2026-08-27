---
title: Microsoft Entra External ID credential management API reference
description: Use the Microsoft Entra External ID credential management API to let signed-in customers list, register, and delete their passkeys.
author: mmacy-msft
manager: dougeby
ms.author: marshmacy
ms.service: identity-platform
ms.subservice: external
ms.topic: reference
ms.date: 07/23/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1017
#Customer intent: As an identity developer, I want to learn how to integrate the credential management API into my customer-facing app so that customers can list, register, and delete their own credential methods.
---

# Microsoft Entra External ID credential management API reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

The Microsoft Entra External ID credential management API lets your application give signed-in customers a self-service flow for listing, registering, and deleting passkeys. Your application owns the client experience and calls the API on the customer's behalf.

The credential management API complements Microsoft Entra [native authentication](concept-native-authentication.md), where your application hosts the sign-in experience instead of delegating it to a browser. Use the credential management API after a customer signs in.

Successful resource responses use HAL+JSON (`application/hal+json`). Activation requests use JSON (`application/json`), delete success responses have no body, and errors use JSON.

## Prerequisites

- A Microsoft Entra external tenant. If you don't already have one, [create an external tenant](../external-id/customers/how-to-create-external-tenant-portal.md).

- An application [registered in the Microsoft Entra admin center](quickstart-register-app.md). Record the **Application (client) ID** and **Directory (tenant) ID** for later use.

## Configure credential management API access

Before your app can acquire access tokens for the credential management API, provision the API's service principal and add a delegated permission:

1. Provision the credential management API's service principal in your tenant. The credential management API is a Microsoft-published resource. Until automatic provisioning is available, you must create its service principal manually. In [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), sign in as an administrator of the tenant where you want to provision it, then run:

    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals
    Content-Type: application/json

    {
      "appId": "6bf38b3c-a70f-49aa-a1d9-10e4cc74dde9"
    }
    ```

1. Add a delegated permission to your app for the credential management API. For passkeys, the least-privileged choice is `Me.UserAuthenticationMethod.Passkey.Read` (read) or `Me.UserAuthenticationMethod.Passkey.ReadWrite` (write). See [Authentication and authorization](#authentication-and-authorization) for the full list of accepted permissions. Grant admin consent if your tenant requires it.

## Authentication and authorization

The credential management API acts on behalf of a signed-in customer. Every endpoint URL has the form `https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/...`, where `{tenant-subdomain}` is your external tenant's subdomain, `{tenant-id}` is your external tenant's ID, and `me` is the customer whose access token you send with the request. Your application:

1. Signs the customer in.
1. Obtains an access token for the credential management API.
1. Includes that token on every call.

Without a signed-in customer, `me` has no meaning and the call can't be authenticated. If you've worked with Microsoft Graph or other Microsoft Entra REST APIs, this follows the same model: standard OAuth 2.0 with delegated permissions.

Include the access token in the standard HTTP `Authorization` header on every request:

```http
Authorization: Bearer <access_token>
```

### Acquire a delegated access token

Use a delegated access token to call the credential management API on behalf of the signed-in customer. The API rejects app-only tokens, including tokens acquired through the client credentials flow. When the customer signs in, request one of the permissions listed in [Required permissions](#required-permissions). The requested permission determines the token audience; you don't set the audience separately.

The following diagram shows how a call is authenticated, from signing the customer in to calling the API with the resulting token.

:::image type="content" source="media/reference-credential-management-api/authentication-authorization-flow.png" alt-text="Sequence diagram that shows your app signing the customer in to get an access token for the credential management API, then calling the API with that token while Microsoft Entra External ID validates it." lightbox="media/reference-credential-management-api/authentication-authorization-flow.png":::

Acquire the delegated token through the Microsoft Entra sign-in flow that applies to your application:

- Single-page, mobile, and desktop apps: use the [Microsoft Authentication Library (MSAL)](msal-overview.md).
- Server-side web apps: use the [OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md) with PKCE.
- Apps using native authentication: use the [native authentication API](reference-native-authentication-api.md) to sign in or sign up the customer, then redeem the result for an access token at the `/token` endpoint.

> [!NOTE]
> For native authentication, only the web experience is supported for now. Native authentication on mobile platforms (Android and iOS) isn't currently supported for the credential management API.

Pass the resulting token as `Authorization: Bearer <access_token>` on every credential management API call.

### Required permissions

All permissions are delegated permissions exposed by the credential management API. Add one to your app registration and request it when you sign the customer in. Because this release supports passkeys only, the passkey-scoped permissions are the least-privileged choice.

| Operation | Accepted delegated permissions (least privileged first) |
|-----------|---------------------------------------------------------|
| Read (for example, listing the customer's passkeys) | `Me.User.Read`, `Me.UserAuthenticationMethod.Passkey.Read`, `Me.UserAuthenticationMethod.Read`, `Me.UserAuthenticationMethod.Passkey.ReadWrite`, `Me.UserAuthenticationMethod.ReadWrite` |
| Write (for example, registering or deleting a passkey) | `Me.UserAuthenticationMethod.Passkey.ReadWrite`, `Me.UserAuthenticationMethod.ReadWrite` |

Application-only access (the client credentials flow) isn't supported.

## Continuation token

When you call a multi-step operation such as registering a passkey, the credential management API returns a continuation token in the response. This token uniquely identifies the current flow and lets Microsoft Entra maintain state across its endpoints. Include the token in every subsequent request in that flow. It's valid only for a limited time and can only be used for the subsequent requests within the same flow.

## Supported credential methods

In this release, the credential management API supports one type of credential method:

| Method | URL segment (`{type}`) | Description |
|--------|------------------------|-------------|
| Passkey | `fido` | A phishing-resistant credential based on the WebAuthn standard. |

Other credential methods, such as software OATH one-time passcodes, email, phone, and recovery methods, aren't supported by this API yet.

## List user credential methods

Returns the credential methods the signed-in customer has currently registered, along with the method types they can still register. For example, your app calls this endpoint when rendering a page where the customer can review their existing passkeys and start registering a new one.

The following sequence diagram shows the list flow.

:::image type="content" source="media/reference-credential-management-api/list-credential-methods.png" alt-text="Sequence diagram that shows your app calling the list endpoint with the customer's access token and Microsoft Entra External ID returning the registered and available-to-register methods in HAL+JSON." lightbox="media/reference-credential-management-api/list-credential-methods.png":::

See [Authentication and authorization](#authentication-and-authorization) for the access token your application needs to call this endpoint. This endpoint accepts any of the read or write permissions listed in [Required permissions](#required-permissions).

### HTTP request

```http
GET https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain, for example *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
GET https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access_token>
```

### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access_token>` |

This endpoint doesn't perform `Accept`-header content negotiation. The response is always `application/hal+json` regardless of the `Accept` header value.

### Success response

Here's an example of a successful response:

```http
HTTP/1.1 200 OK
Content-Type: application/hal+json
```

```json
{
  "_embedded": {
    "methods": [
      {
        "aaGuid": "<authenticator-aaguid>",
        "attestationLevel": "notAttested",
        "model": "Windows Hello VBS Hardware Authenticator",
        "passkeyType": "deviceBound",
        "displayName": "<display-name>",
        "id": "<credential-id-1>",
        "type": "fido",
        "createdDateTime": "<timestamp>",
        "_links": {
          "self": {
            "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-1}",
            "name": "self"
          },
          "delete": {
            "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-1}",
            "name": "delete"
          }
        }
      },
      {
        "aaGuid": "<authenticator-aaguid>",
        "attestationCertificates": [
          "<certificate-thumbprint>"
        ],
        "attestationLevel": "attested",
        "model": "YubiKey 5 FIPS Series with NFC",
        "passkeyType": "deviceBound",
        "displayName": "<display-name>",
        "id": "<credential-id-2>",
        "type": "fido",
        "createdDateTime": "<timestamp>",
        "_links": {
          "self": {
            "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-2}",
            "name": "self"
          },
          "delete": {
            "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-2}",
            "name": "delete"
          }
        }
      }
    ]
  },
  "_links": {
    "self": {
      "href": "/{tenant-id}/api/v1.0/me/methods",
      "name": "self"
    },
    "enroll": [
      {
        "href": "/{tenant-id}/api/v1.0/me/methods/fido",
        "name": "fido"
      }
    ],
    "methods": [
      {
        "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-1}",
        "name": "<credential-id-1>"
      },
      {
        "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id-2}",
        "name": "<credential-id-2>"
      }
    ]
  }
}
```

Follow the returned HAL links instead of constructing operation URLs from identifiers.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `_embedded.methods` | array of objects | Yes | Registered credential methods. The array is present even when the customer has no registered methods. |
| `_links.self` | object | Yes | Link to the credential-method collection. |
| `_links.enroll` | array of objects | No | Enrollment links, one for each credential type the customer can register. |
| `_links.methods` | array of objects | No | Links to the customer's registered methods. |

#### Registered passkey properties

Authenticator-specific properties can vary or be absent. For example, a nonattested passkey can omit `attestationCertificates`, while an attested device-bound passkey can include certificate values.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Durable, case-sensitive base64url identifier for the registered passkey. |
| `type` | string | Yes | Credential method type. The value is `fido`. |
| `createdDateTime` | string | No | Time when the passkey was registered. |
| `lastUsedDateTime` | string | No | Time when the passkey was last used. |
| `aaGuid` | string | No | Authenticator Attestation GUID (AAGUID), when returned by the authenticator. |
| `attestationCertificates` | array of strings | No | Attestation certificate values, when the authenticator provides attestation. |
| `attestationLevel` | string | No | Attestation level reported for the authenticator. |
| `model` | string | No | Authenticator model. |
| `passkeyType` | string | No | Passkey classification reported by the service. |
| `displayName` | string | No | Customer-provided passkey name. |
| `_links` | object | Yes | `self` and `delete` links for the registered passkey. |

This endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Provisioning

Provisioning a passkey for the signed-in customer takes two HTTP calls. First, your application calls the begin registration endpoint, which returns WebAuthn creation options, a continuation token, and an `activate` link. The customer's authenticator uses the creation options to create a new passkey. Your application then calls the activate endpoint with the result to complete registration. Start this flow when the customer chooses to add a passkey in your application's credential-management experience.

The following sequence diagram shows the two-step provisioning flow.

:::image type="content" source="media/reference-credential-management-api/provision-passkey.png" alt-text="Sequence diagram that shows begin registration returning a WebAuthn challenge and continuation token, the authenticator creating the passkey, and the activate call registering the passkey with Microsoft Entra External ID." lightbox="media/reference-credential-management-api/provision-passkey.png":::

See [Authentication and authorization](#authentication-and-authorization) for the access token your application needs to call these endpoints. Both calls require a write permission, `Me.UserAuthenticationMethod.Passkey.ReadWrite` or `Me.UserAuthenticationMethod.ReadWrite` (see [Required permissions](#required-permissions)).

### Step 1: Begin registration

#### HTTP request

```http
POST https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods/{type}
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain, for example *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
POST https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods/fido HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access_token>
```

#### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `type` | Yes | The credential method type to register. Currently only `fido` (passkey) is supported. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access_token>` |

This endpoint doesn't take a request body. All inputs are carried in the URL path and the `Authorization` header.

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 202 Accepted
Content-Type: application/hal+json
```

```json
{
  "publicKey": {
    "rp": {
      "id": "<relying-party-id>",
      "name": "Microsoft"
    },
    "user": {
      "id": "<user-handle>",
      "name": "<user-name>",
      "displayName": "<user-display-name>"
    },
    "challenge": "<challenge>",
    "pubKeyCredParams": [
      {
        "type": "public-key",
        "alg": -7
      },
      {
        "type": "public-key",
        "alg": -257
      }
    ],
    "timeout": 0,
    "excludeCredentials": [
      {
        "type": "public-key",
        "id": "<excluded-credential-id>",
        "transports": []
      }
    ],
    "authenticatorSelection": {
      "authenticatorAttachment": "cross-platform",
      "requireResidentKey": true,
      "userVerification": "required"
    },
    "attestation": "direct",
    "extensions": {
      "hmacCreateSecret": true,
      "enforceCredentialProtectionPolicy": true,
      "credentialProtectionPolicy": "userVerificationOptional"
    }
  },
  "challengeTimeout": "<timestamp>",
  "id": "<registration-id>",
  "type": "fido",
  "continuationToken": "<continuation-token>",
  "state": "interactionRequired",
  "action": "activate",
  "_links": {
    "self": {
      "href": "/{tenant-id}/api/v1.0/me/methods/fido/{registration-id}",
      "name": "self"
    },
    "activate": {
      "href": "/{tenant-id}/api/v1.0/me/methods/fido/{registration-id}/activate",
      "name": "activate"
    }
  }
}
```

The response has the following properties:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Transient identifier for the in-progress registration. |
| `type` | string | Yes | Credential method type. The value is `fido`. |
| `publicKey` | object | No | WebAuthn credential creation options for the client ceremony. |
| `challengeTimeout` | string | No | Time when the challenge expires. |
| `state` | string | Yes | Flow state. The value is `interactionRequired`. |
| `action` | string | Yes | Next action. The value is `activate`. |
| `continuationToken` | string | Yes | Opaque state that must be returned during activation. |
| `_links` | object | Yes | `self` and `activate` links for the in-progress registration. |

The `publicKey` object aligns with the common fields in [webauthnPublicKeyCredentialCreationOptions](/graph/api/resources/webauthnpublickeycredentialcreationoptions). The service can also preserve additional WebAuthn properties for forward compatibility.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `rp` | object | No | Relying-party information. |
| `user` | object | No | User information for the registration ceremony. |
| `challenge` | string | No | Base64url-encoded WebAuthn challenge. |
| `pubKeyCredParams` | array of objects | No | Supported public-key credential types and algorithms. |
| `timeout` | integer | No | Ceremony timeout in milliseconds. |
| `excludeCredentials` | array of objects | No | Existing credentials that the authenticator should exclude. |
| `authenticatorSelection` | object | No | Authenticator selection requirements. |
| `attestation` | string | No | Requested attestation conveyance preference. |
| `hints` | array of strings | No | Optional authenticator hints. |
| `extensions` | object | No | WebAuthn extension inputs. |

Pass `publicKey` to the customer's authenticator to create the passkey. Preserve `continuationToken` exactly, and follow `_links.activate.href` for the activation request.

The begin registration endpoint can return `400`, `401`, `403`, or `500`. For the shared envelope and caller actions, see [Error responses](#error-responses).

### Step 2: Activate the passkey

#### HTTP request

```http
POST https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods/{type}/{id}/activate
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain, for example *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
POST https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods/fido/{registration-id}/activate HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "continuationToken": "<continuation-token>",
  "displayName": "My laptop",
  "publicKeyCredential": {
    "id": "<credential-id>",
    "attestationObject": "<attestation-object>",
    "clientDataJSON": "<client-data-json>"
  }
}
```

#### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `type` | Yes | The credential method type being registered. Currently only `fido` (passkey) is supported. Must match the value used in the begin registration step. |
| `id` | Yes | The in-progress registration identifier returned by the begin registration step. Take it from `_links.activate.href` in the begin registration response rather than constructing it yourself. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access_token>` |
| `Content-Type` | Yes | `application/json` |

#### Request body

A JSON object with the following fields:

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `continuationToken` | string | Yes | The opaque token returned by the begin registration response. It carries the server-side state of the in-progress registration so Microsoft Entra can resume exactly where it left off. Treat it as opaque and don't parse or modify it. See [Continuation token](#continuation-token). |
| `displayName` | string | No | A friendly name the customer gives the passkey, for example *My laptop*. |
| `publicKeyCredential` | object | No | WebAuthn credential data produced by the customer's authenticator. |

The `publicKeyCredential` value is derived from the WebAuthn [PublicKeyCredential](https://www.w3.org/TR/webauthn-2/#iface-publickeycredential). The API flattens the credential ID, attestation response, and extension results into the following properties:

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `id` | string | No | Base64url-encoded credential identifier returned by the authenticator. |
| `attestationObject` | string | No | Base64url-encoded attestation object returned by the authenticator. |
| `clientDataJSON` | string | No | Base64url-encoded client data returned by the authenticator. |
| `clientExtensionResults` | string | No | Serialized WebAuthn client extension results. |

#### Success response

Here's an example of a successful response:

```http
HTTP/1.1 201 Created
Content-Type: application/hal+json
```

```json
{
  "aaGuid": "<authenticator-aaguid>",
  "attestationLevel": "notAttested",
  "model": "Windows Hello VBS Hardware Authenticator",
  "passkeyType": "deviceBound",
  "displayName": "<display-name>",
  "id": "<credential-id>",
  "type": "fido",
  "createdDateTime": "<timestamp>",
  "_links": {
    "self": {
      "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id}",
      "name": "self"
    },
    "delete": {
      "href": "/{tenant-id}/api/v1.0/me/methods/fido/{credential-id}",
      "name": "delete"
    }
  }
}
```

The activation response has the following properties:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Identifier returned for the registered passkey. |
| `type` | string | Yes | Credential method type. The value is `fido`. |
| `createdDateTime` | string | No | Time when registration completed. |
| `displayName` | string | No | Customer-provided passkey name. |
| `aaGuid` | string | No | Authenticator Attestation GUID (AAGUID), when returned by the authenticator. |
| `attestationCertificates` | array of strings | No | Attestation certificate values, when the authenticator provides attestation. |
| `attestationLevel` | string | No | Attestation level reported for the authenticator. |
| `model` | string | No | Authenticator model. |
| `passkeyType` | string | No | Passkey classification reported by the service. |
| `_links` | object | Yes | `self` and `delete` links for the registered passkey. |

Authenticator-specific properties can vary or be absent. The activation endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Delete a credential method

Permanently deletes one of the signed-in customer's registered passkeys. Use this endpoint after [listing the customer's credential methods](#list-user-credential-methods) and when the customer chooses to remove a passkey in your application's credential-management flow. Deletion is immediate and can't be undone. A replacement passkey is a new credential with no relation to the deleted passkey.

The following sequence diagram shows the delete flow.

:::image type="content" source="media/reference-credential-management-api/delete-credential-method.png" alt-text="Sequence diagram that shows your app calling the delete endpoint with the customer's access token and Microsoft Entra External ID removing the passkey and returning 204 No Content." lightbox="media/reference-credential-management-api/delete-credential-method.png":::

See [Authentication and authorization](#authentication-and-authorization) for the access token your application needs to call this endpoint. This endpoint requires a write permission, `Me.UserAuthenticationMethod.Passkey.ReadWrite` or `Me.UserAuthenticationMethod.ReadWrite` (see [Required permissions](#required-permissions)).

### HTTP request

```http
DELETE https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods/{type}/{id}
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain, for example *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
DELETE https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods/fido/{id} HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access_token>
```

### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `type` | Yes | The credential method type to delete. Currently only `fido` (passkey) is supported. |
| `id` | Yes | The identifier of the registered passkey to delete. Use the `id` (or follow the `delete` link) from [List user credential methods](#list-user-credential-methods), the source of truth for the customer's registered methods. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access_token>` |

This endpoint doesn't take a request body. The passkey to delete is identified entirely by the URL.

### Success response

A successful delete returns an empty response:

```http
HTTP/1.1 204 No Content
```

This endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Error responses

Error responses use a shared JSON envelope. The following example shows the required properties:

```json
{
  "error": {
    "code": "invalidRequest",
    "message": "<error-message>",
    "timestamp": "<timestamp>",
    "traceId": "<trace-id>",
    "correlationId": "<correlation-id>"
  }
}
```

The error response has the following properties:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `error` | object | Yes | Error details. |
| `error.code` | string | Yes | Machine-readable error code. |
| `error.message` | string | Yes | Human-readable description of the failure. Don't use this value for programmatic branching. |
| `error.timestamp` | string | Yes | Time when the error occurred. |
| `error.traceId` | string | Yes | Identifier used to trace the request. |
| `error.correlationId` | string | Yes | Identifier used to correlate the request across components. |
| `error.target` | string | No | Request element associated with the error. |
| `error.innerError` | object | No | Additional error details. |
| `clientHints` | array of strings | No | Optional response-wide hint tokens. |

The following status and code combinations are confirmed for these endpoints:

| HTTP status | Error code | Confirmed causes |
|-------------|------------|------------------|
| `400 Bad Request` | `invalidRequest` | Missing or malformed bearer token, invalid token signature, expired token, app-only token, insufficient delegated scope, a non-specific tenant route, or invalid registration state such as a malformed continuation token. |
| `401 Unauthorized` | `invalidRequest` | The token wasn't issued for the credential management API. |
| `403 Forbidden` | `forbidden` | The tenant in the request URL doesn't match the tenant in the access token. |
| `500 Internal Server Error` | `serverError` | The begin registration endpoint received an invalid WebAuthn creation-options response from an upstream component. |

The shared error model also defines `unknown`, `invalidGrant`, `expiredToken`, `tooManyRequests`, and `unsupportedRedirect`. Don't assume that every endpoint emits every code.

Handle confirmed errors as follows:

| Response | Caller action |
|----------|---------------|
| `400 invalidRequest` | Use `error.message` to diagnose the invalid input. Acquire a new delegated token when the token is missing, malformed, invalid, expired, app-only, or lacks an accepted scope. Use a tenant-specific route value. If registration state is invalid, restart the two-step registration flow. |
| `401 invalidRequest` | Request an accepted credential management API permission when acquiring the token, then retry the request. |
| `403 forbidden` | Verify that the `{tenant-id}` in the request URL matches the tenant represented by the access token. |
| `500 serverError` | Record `traceId` and `correlationId` for diagnostics. Don't assume that the operation succeeded. |

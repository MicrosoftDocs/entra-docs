---
title: Microsoft Entra External ID credential management API reference
description: Let signed-in users manage passkeys and update passwords with the Microsoft Entra External ID credential management API.
author: mmacy-msft
manager: dougeby
ms.author: marshmacy
ms.service: identity-platform
ms.subservice: external
ms.topic: reference
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1030
#Customer intent: As an identity developer, I want to integrate the credential management API into my customer-facing app so that users can manage their own passkeys and update their passwords.
---

# Microsoft Entra External ID credential management API reference

[!INCLUDE [applies-to-external-only](../external-id/includes/applies-to-external-only.md)]

The Microsoft Entra External ID credential management API lets you add self-service credential management to your customer-facing application by using low-privilege delegated permissions. Through your application, signed-in users can list, register, and delete their passkeys, and update their existing password. Your application owns the client experience and calls the API on the user's behalf.

The credential management API complements Microsoft Entra [native authentication](concept-native-authentication.md), where your application hosts the sign-in experience instead of delegating it to a browser. Use the credential management API after a user signs in.

To support credential management in your app, use the [credential management sample app](https://github.com/Azure-Samples/ms-identity-ciam-native-javascript-samples/tree/main/passkey-sample). The sample calls the API by using delegated permissions. Follow the sample's README to configure and run the app.

Successful resource responses use HAL+JSON (`application/hal+json`). Requests with a body, including passkey activation and password update requests, use JSON (`application/json`). Responses with status `204 No Content` have no body, and errors use JSON.

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

1. Add a delegated permission to your app for the credential management API. For passkeys, the least-privileged choice is `Me.UserAuthenticationMethod.Passkey.Read` (read) or `Me.UserAuthenticationMethod.Passkey.ReadWrite` (write). For passwords, use `Me.UserAuthenticationMethod.Password.Read` (read) or `Me.UserAuthenticationMethod.Password.ReadWrite` (write). See [Authentication and authorization](#authentication-and-authorization) for the full list of accepted permissions. Grant admin consent if your tenant requires it.

## Authentication and authorization

The credential management API acts on behalf of a signed-in user. Every endpoint URL has the form `https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/...`, where `{tenant-subdomain}` is your external tenant's subdomain, `{tenant-id}` is your external tenant's ID, and `me` is the user whose access token you send with the request. Your application:

1. Signs the user in.
1. Obtains an access token for the credential management API.
1. Includes that token on every call.

Without a signed-in user, `me` has no meaning and the call can't be authenticated. If you've worked with Microsoft Graph or other Microsoft Entra REST APIs, this follows the same model: standard OAuth 2.0 with delegated permissions.

Include the access token in the standard HTTP `Authorization` header on every request:

```http
Authorization: Bearer <access_token>
```

### Acquire a delegated access token

Use a delegated access token to call the credential management API on behalf of the signed-in user. The API rejects app-only tokens, including tokens acquired through the client credentials flow. When the user signs in, request one of the permissions listed in [Required permissions](#required-permissions). The requested permission determines the token audience; you don't set the audience separately.

The following diagram shows how a call is authenticated, from signing the user in to calling the API with the resulting token.

:::image type="content" source="media/reference-credential-management-api/authentication-authorization-flow.png" alt-text="Sequence diagram that shows your app signing the user in to get an access token for the credential management API, then calling the API with that token while Microsoft Entra External ID validates it." lightbox="media/reference-credential-management-api/authentication-authorization-flow.png":::

Acquire the delegated token through the Microsoft Entra sign-in flow that applies to your application:

- Single-page, mobile, and desktop apps: use the [Microsoft Authentication Library (MSAL)](msal-overview.md).
- Server-side web apps: use the [OAuth 2.0 authorization code flow](v2-oauth2-auth-code-flow.md) with PKCE.

> [!NOTE]
> Access tokens acquired through [native authentication](reference-native-authentication-api.md) are currently supported by this API only for web apps. Mobile apps can use MSAL's browser-based sign-in to acquire tokens to [list authentication methods](#list-user-credential-methods), [delete passkeys](#delete-a-credential-method), and [update passwords](#update-a-password).
>
> Native passkey registration with Microsoft Entra External ID isn't currently supported on mobile platforms. Use the system browser to register passkeys.

Pass the resulting token as `Authorization: Bearer <access_token>` on every credential management API call.

### Required permissions

All permissions are delegated permissions exposed by the credential management API. Choose the least-privileged permission for each operation. Use a higher-privileged permission only if your app needs the additional access it provides. Add the permission your app needs to its registration and request it when you sign the user in.

| Operation | Least privileged permissions | Higher privileged permissions |
| --- | --- | --- |
| Read passkey methods | `Me.UserAuthenticationMethod.Passkey.Read` | `Me.UserAuthenticationMethod.Read`, `Me.UserAuthenticationMethod.Passkey.ReadWrite`, `Me.UserAuthenticationMethod.ReadWrite` |
| Register or delete a passkey | `Me.UserAuthenticationMethod.Passkey.ReadWrite` | `Me.UserAuthenticationMethod.ReadWrite` |
| Read password method | `Me.UserAuthenticationMethod.Password.Read` | `Me.UserAuthenticationMethod.Read`, `Me.UserAuthenticationMethod.Password.ReadWrite`, `Me.UserAuthenticationMethod.ReadWrite` |
| Update a password or poll for its update status | `Me.UserAuthenticationMethod.Password.ReadWrite` | `Me.UserAuthenticationMethod.ReadWrite` |

Application-only access (the client credentials flow) isn't supported.

## Continuation token

When you call a multi-step operation such as registering a passkey or updating a password, the credential management API returns a continuation token in the response. This token uniquely identifies the current flow and lets Microsoft Entra maintain state across its endpoints. Include the most recently returned token in each subsequent request in that flow. It's valid only for a limited time and can only be used for the subsequent requests within the same flow. Don't reuse it for another user, credential method, or operation.

## Supported credential methods

The credential management API supports the following credential methods. The operations available for each method differ:

| Method | URL segment (`{type}`) | Description | Operations |
|--------|------------------------|-------------|------------|
| Passkey | `fido` | A phishing-resistant credential based on the WebAuthn standard. | [List](#list-user-credential-methods), [provision](#provisioning), and [delete](#delete-a-credential-method). |
| Password | `password` | The signed-in user's existing password credential method. | [List](#list-user-credential-methods) and [update](#update-a-password). |

Other credential methods, such as software OATH one-time passcodes, email, phone, and recovery methods, aren't supported by this API yet.

Listing and authorization are shared across credential methods. The provisioning and delete flows in this article apply to passkeys. Password updates use the separate [update flow](#update-a-password).

## List user credential methods

This endpoint returns the signed-in user's credential methods, along with the method types they can still register. Call this endpoint when rendering a page where the user can review credential information and choose an available action, such as adding a passkey, deleting a passkey, or changing their password.

The following sequence diagram shows the list flow.

:::image type="content" source="media/reference-credential-management-api/list-credential-methods.png" alt-text="Sequence diagram that shows your app calling the list endpoint with the user's access token and Microsoft Entra External ID returning the registered and available-to-register methods in HAL+JSON." lightbox="media/reference-credential-management-api/list-credential-methods.png":::

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

The credential methods returned in the response can vary based on the delegated permissions (scopes) in the access token. See [Required permissions](#required-permissions).

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
      },
      {
        "id": "<password-method-id>",
        "type": "password",
        "lastUpdatedDateTime": "<timestamp>",
        "_links": {
          "self": {
            "href": "/{tenant-id}/api/v1.0/me/methods/password/{password-method-id}",
            "name": "self"
          },
          "update": {
            "href": "/{tenant-id}/api/v1.0/me/methods/password/{password-method-id}",
            "name": "update"
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
      },
      {
        "href": "/{tenant-id}/api/v1.0/me/methods/password/{password-method-id}",
        "name": "<password-method-id>"
      }
    ]
  }
}
```

Follow the returned HAL links instead of constructing operation URLs from identifiers.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `_embedded.methods` | array of objects | Yes | Registered credential methods. The array is present even when the user has no registered methods. |
| `_links.self` | object | Yes | Link to the credential-method collection. |
| `_links.enroll` | array of objects | No | Enrollment links, one for each credential type the user can register. |
| `_links.methods` | array of objects | No | Links to the user's registered methods. |

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
| `displayName` | string | No | User-provided passkey name. |
| `_links` | object | Yes | `self` and `delete` links for the registered passkey. |

#### Password method properties

A password method contains information about the credential, not the password value. Follow its `update` link to [update the password](#update-a-password).

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Identifier of the existing password credential method. Treat it as opaque. |
| `type` | string | Yes | Credential method type. The value is `password`. |
| `lastUpdatedDateTime` | string | Yes | Time when the password was last updated. |
| `_links.self` | object | Yes | Link to the registered password method. |
| `_links.update` | object | Yes | Link to update the password. Use its `href` for the update request. |

This endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Provisioning

Provisioning a passkey for the signed-in user takes two HTTP calls. First, your application calls the begin registration endpoint, which returns WebAuthn creation options, a continuation token, and an `activate` link. The user's authenticator uses the creation options to create a new passkey. Your application then calls the activate endpoint with the result to complete registration. Start this flow when the user chooses to add a passkey in your application's credential-management experience.

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

Pass `publicKey` to the user's authenticator to create the passkey. Preserve `continuationToken` exactly, and follow `_links.activate.href` for the activation request.

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
| `displayName` | string | No | A friendly name the user gives the passkey; for example, *My laptop*. |
| `publicKeyCredential` | object | No | WebAuthn credential data produced by the user's authenticator. |

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
| `aaGuid` | string | No | Authenticator Attestation GUID (AAGUID), when returned by the authenticator. |
| `attestationCertificates` | array of strings | No | Attestation certificate values, when the authenticator provides attestation. |
| `attestationLevel` | string | No | Attestation level reported for the authenticator. |
| `model` | string | No | Authenticator model. |
| `passkeyType` | string | No | Passkey classification reported by the service. |
| `_links` | object | Yes | `self` and `delete` links for the registered passkey. |

Authenticator-specific properties can vary or be absent. The activation endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Delete a credential method

Permanently deletes one of the signed-in user's registered passkeys. Use this endpoint after [listing the user's credential methods](#list-user-credential-methods) and when the user chooses to remove a passkey in your application's credential-management flow. Deletion is immediate and can't be undone. A replacement passkey is a new credential with no relation to the deleted passkey.

> [!WARNING]
> If the user deletes the passkey they used to sign in to their current session, that session ends.

The following sequence diagram shows the delete flow.

:::image type="content" source="media/reference-credential-management-api/delete-credential-method.png" alt-text="Sequence diagram that shows your app calling the delete endpoint with the user's access token and Microsoft Entra External ID removing the passkey and returning 204 No Content." lightbox="media/reference-credential-management-api/delete-credential-method.png":::

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
| --- | --- | --- |
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `type` | Yes | The credential method type to delete. Currently only `fido` (passkey) is supported. |
| `id` | Yes | The identifier of the registered passkey to delete. Use the `id` (or follow the `delete` link) from [List user credential methods](#list-user-credential-methods), the source of truth for the user's registered methods. |

Request headers:

| Name | Required | Value |
| --- | --- | --- |
| `Authorization` | Yes | `Bearer <access_token>` |

This endpoint doesn't take a request body. The passkey to delete is identified entirely by the URL.

### Success response

A successful delete returns an empty response:

```http
HTTP/1.1 204 No Content
```

This endpoint can return `400`, `401`, or `403`. For the shared envelope and caller actions, see [Error responses](#error-responses).

## Update a password

This flow updates the signed-in user's existing password. Use this flow when the user knows their current password and chooses to change it in your application's credential-management experience.

This flow isn't a forgotten-password recovery flow. For password recovery in native authentication, see [Self-service password reset](reference-native-authentication-api.md#self-service-password-reset-sspr).

Password updates require polling to confirm completion. The following flowchart shows the two-step update flow.

:::image type="content" source="media/reference-credential-management-api/update-password.png" alt-text="Flowchart that shows the user entering their current and new passwords, the app submitting the update, waiting for the polling interval, and polling with a continuation token to confirm completion." lightbox="media/reference-credential-management-api/update-password.png":::

See [Authentication and authorization](#authentication-and-authorization) for the access token your application needs. Both the update and polling requests require `Me.UserAuthenticationMethod.Password.ReadWrite` or `Me.UserAuthenticationMethod.ReadWrite` (see [Required permissions](#required-permissions)).

### Step 1: Submit the password update

Start by [listing the user's credential methods](#list-user-credential-methods) and following the password method's `_links.update.href`.

#### HTTP request

```http
PUT https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods/password/{id}
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain; for example, *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
PUT https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods/password/{password-method-id} HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access-token>
Content-Type: application/json

{
  "currentPassword": "<current-password>",
  "newPassword": "<new-password>"
}
```

#### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `id` | Yes | The identifier of the password method returned by [List user credential methods](#list-user-credential-methods). Follow `_links.update.href` rather than constructing the URL. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access-token>` |
| `Content-Type` | Yes | `application/json` |

#### Request body

A JSON object with the following fields:

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `currentPassword` | string | Yes | The user's current password |
| `newPassword` | string | Yes | The user's new password |

> [!IMPORTANT]
> Don't log or persist the user's password values. Send them over HTTPS.

#### Success response

A successful update request returns `202 Accepted` with a continuation token and a link to poll for completion:

```http
HTTP/1.1 202 Accepted
Content-Type: application/hal+json
```

```json
{
  "id": "<password-method-id>",
  "type": "password",
  "status": "running",
  "pollInterval": "2",
  "continuationToken": "<continuation-token>",
  "state": "interactionRequired",
  "action": "poll",
  "_links": {
    "self": {
      "href": "/{tenant-id}/api/v1.0/me/methods/password/{password-method-id}",
      "name": "self"
    },
    "pollUpdate": {
      "href": "/{tenant-id}/api/v1.0/me/methods/password/{password-method-id}/pollUpdate",
      "name": "pollUpdate"
    }
  }
}
```

The response has the following properties:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Identifier of the password method being updated. |
| `type` | string | Yes | Credential method type. The value is `password`. |
| `status` | string | Yes | Update status. `running` indicates that the update hasn't completed. |
| `pollInterval` | string | Yes | Number of seconds to wait before the next polling request, represented as a string. |
| `continuationToken` | string | Yes | Opaque state for the next polling request. Preserve it exactly and use the most recently returned value. |
| `state` | string | Yes | Flow state. The value is `interactionRequired`. |
| `action` | string | Yes | Next action. The value is `poll`. |
| `_links` | object | Yes | `self` and `pollUpdate` links for the password-update flow. |

The update endpoint can return `400`. For the shared envelope and caller actions, see [Error responses](#error-responses).

### Step 2: Poll for the password update status

Wait for the response's `pollInterval`, then follow `_links.pollUpdate.href`. Polling requests carry the continuation token, not the user's password values.

#### HTTP request

```http
POST https://{tenant-subdomain}.ciamlogin.com/{tenant-id}/api/v1.0/me/methods/password/{id}/pollUpdate
```

`{tenant-subdomain}` in the URL is your external tenant's subdomain; for example, *contoso* in *contoso.ciamlogin.com*.

Sample request:

```http
POST https://contoso.ciamlogin.com/8f1c8e2a-1234-4abc-9876-1f1e1d1c1b1a/api/v1.0/me/methods/password/{password-method-id}/pollUpdate HTTP/1.1
Host: contoso.ciamlogin.com
Authorization: Bearer <access-token>
Content-Type: application/json

{
  "continuationToken": "<continuation-token>"
}
```

#### Request parameters

Path parameters:

| Name | Required | Description |
|------|----------|-------------|
| `tenant-id` | Yes | Your external tenant identifier, either the tenant ID (GUID) or a verified domain. Use a tenant-specific value, not `common`, `client`, `organizations`, or `consumers`. A GUID value must match the tenant in the access token. |
| `id` | Yes | The password method identifier from the update response. Follow `_links.pollUpdate.href` rather than constructing the URL. |

Request headers:

| Name | Required | Value |
|------|----------|-------|
| `Authorization` | Yes | `Bearer <access-token>` |
| `Content-Type` | Yes | `application/json` |

#### Request body

A JSON object with the following field:

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `continuationToken` | string | Yes | The latest continuation token returned by the update. See [Continuation token](#continuation-token). |

#### Success response

Here's an example of a successful response after the update completes:

```http
HTTP/1.1 200 OK
Content-Type: application/hal+json
```

```json
{
  "id": "<password-method-id>",
  "type": "password",
  "status": "succeeded"
}
```

The response has the following properties:

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `id` | string | Yes | Identifier of the password method that was updated. |
| `type` | string | Yes | Credential method type. The value is `password`. |
| `status` | string | Yes | Update status. The value `succeeded` confirms that the password update completed. |

Don't report success for a pending status, an unexpected response, or a failed request. Don't automatically resend the original password-update request if polling fails.

The polling endpoint can return `400`. For the shared envelope and caller actions, see [Error responses](#error-responses).

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
| `error.innerError.code` | string | No | Machine-readable detail code for the failure, when returned. |
| `clientHints` | array of strings | No | Optional response-wide hint tokens. |

The following generic errors are confirmed for these endpoints:

| HTTP status | Error code | Confirmed causes |
|-------------|------------|------------------|
| `400 Bad Request` | `invalidRequest` | Missing or malformed bearer token, invalid token signature, expired token, app-only token, insufficient delegated scope (`AADSTS10040176`), a non-specific tenant route, or invalid registration state such as a malformed continuation token. |
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

### Password update errors

The following status and code combinations are confirmed for the password-update and polling endpoints:

| HTTP status | Error code | Confirmed causes |
|-------------|------------|------------------|
| `400 Bad Request` | `invalidRequest` | The update request body is malformed. |
| `400 Bad Request` | `invalidRequest` | The polling request fails because the current password is incorrect. `error.innerError.code` is `invalidUserNameOrPassword`. |
| `400 Bad Request` | `invalidRequest` | The polling request fails because the new password doesn't meet the tenant's password policy. `error.innerError.code` is `passwordTooWeak`. |

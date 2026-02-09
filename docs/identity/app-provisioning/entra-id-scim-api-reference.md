---
title: Microsoft Entra ID SCIM API 
description: Build custom integrations to provision users and groups to Microsoft Entra ID using the System for Cross-domain Identity Management (SCIM) v2.0 protocol.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 02/09/2026
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As a developer or IT administrator, I want to understand how to integrate with Microsoft Entra ID using the SCIM v2.0 protocol so that I can programmatically provision, manage, and synchronize users and groups between my application and Microsoft Entra ID.
---

# Build custom integrations with Microsoft Entra ID SCIM API

This reference guide helps software developers build custom integrations to provision (synchronize) users and groups into Microsoft Entra ID using the System for Cross-domain Identity Management (SCIM) v2.0 protocol. This guide is also useful to IT administrators who need to understand or debug SCIM API operations.

The Microsoft Entra ID SCIM implementation is based on the following IETF drafts:

- [RFC 7642: System for Cross-domain Identity Management: Definitions, Overview, Concepts, and Requirements](https://www.rfc-editor.org/rfc/rfc7642)

- [RFC 7643: System for Cross-domain Identity Management: Core Schema](https://www.rfc-editor.org/rfc/rfc7643)

- [RFC 7644: System for Cross-domain Identity Management: Protocol](https://www.rfc-editor.org/rfc/rfc7644)

- [Cursor-based Pagination of SCIM Resources](https://www.ietf.org/archive/id/draft-ietf-scim-cursor-pagination-05.html)

The following sections contain examples of API requests and responses currently supported in the Microsoft Entra ID SCIM implementation, along with important notes and constraints to consider in your design.

## Invoking the SCIM APIs

To invoke the SCIM APIs listed in this document, the SCIM client app must obtain an access token from the Microsoft identity platform. This access token includes information about whether the app is authorized to access the SCIM APIs with its own identity using a flow called the [OAuth 2.0 client credentials grant flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow). 

Use these steps to register your SCIM client app in your Microsoft Entra ID tenant and grant the app appropriate permissions for invoking the APIs.

1)  Register the app with Microsoft Entra ID. For more information, see [Register an application with the Microsoft identity platform](/graph/auth-register-app-v2). Save the following values from the app registration:

    1.  The application ID (referred to as Object ID on the Microsoft Entra admin center).

    2.  A client secret (application password), a certificate, or a federated identity credential.

2)  Under **API permissions** -\> select Microsoft Graph “Application permissions” and grant one or more of the following permissions:

    1.  ```User.Read.All``` -\> To only provide “user” read access to your SCIM client.
    2.  ```User.ReadWrite.All``` -\> To provide both “user” read and write access to your SCIM client.
    3.  ```Group.Read.All``` -\> To only provide “group” read access to your SCIM client.
    4.  ```Group.ReadWrite.All``` -\> To provide both “group” read and write access to your SCIM client.
    5.  ```CustomSecAttributeAssignment.Read.All``` -\> To only provide “user” read access to Custom Security Attributes
    6.  ```CustomSecAttributeAssignment.ReadWrite.All``` -\> To provide “user” read and write access to Custom Security Attributes
    7.  ```CustomSecAttributeDefinition.Read.All``` -> To provide read access to Custom Security Attributes Schema 

3)  Grant **Admin consent** to the permissions.

Once the client registration is successful, use the following HTTP call to get a valid access token, replacing the highlighted variables to match your environment settings.

| Example request for valid access token | Request/Body | 
| -------------------------|---------------------------- |
| **Request** | `POST https://login.microsoftonline.com/{{tenant_id}}/oauth2/v2.0/token HTTP/1.1` <br> `Host: login.microsoftonline.com` <br> `Content-Type: application/x-www-form-urlencoded` |
| **Body** | `client_id={{client_id}}&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret={{client_secret}}&grant_type=client_credentials` |


| Example of Successful Response with valid access token | Response | 
| -------------------------|---------------------------- |
| **HTTP 200/OK** | `{` <br>`"token_type": "Bearer",` <br> `"expires_in": 3599,` <br>  `"access_token": "eyJhbGciOiJIUzI1NiJ9…"` <br> `}` <br> _(Note: Actual JWT access value will be much larger)_   |



Reference: </graph/auth-v2-service?tabs=http#token-request>

You can use the access token in the HTTP Authorization header (Bearer authentication scheme) to invoke the SCIM API.

| Example Authorization Request with valid access token | Call |
|----------------------|
| **Request** | `GET https://graph.microsoft.com/rp/scim/users?filter=displayName%20eq%20%22John%20Doe%22` <br> `Authorization: Bearer eyJ0eXAiO...0X2tnSQLEANnSPHY0gKcgw` <br> `Host: graph.microsoft.com` |

## Get Service Provider Config

Use the ```/ServiceProviderConfig``` endpoint to view additional information about Microsoft Entra ID SCIM implementation. The ```/ServiceProviderConfig``` endpoint is read only.

**API endpoint:** <https://graph.microsoft.com/rp/scim/serviceproviderconfig>

Upon success, the API returns HTTP Status 200.

### Errors for Get Service Provide Config

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Requesting service provider config

**Request:**

GET <https://graph.microsoft.com/rp/scim/serviceproviderconfig>

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": ["urn:ietf:params:scim:schemas:core:2.0:ServiceProviderConfig"],
  "documentationUri": "/graph/overview",
  "pagination": {
    "cursor": true,
    "index": false,
    "defaultPaginationMethod": "cursor",
    "defaultPageSize": 100,
    "maxPageSize": 1000
  },
  "patch": {
    "supported": true
  },
  "bulk": {
    "supported": false,
    "maxOperations": 0,
    "maxPayloadSize": 0
  },
  "filter": {
    "supported": true,
    "maxResults": 200
  }
}
```

## List Resource Types

Information about supported resource types can be retrieved by making a request to the /resourcetypes endpoint.

**API endpoints:**

[https://graph.microsoft.com/rp/scim/resourcetypes](https://graph.microsoft.com/rp/scim/resourcetypes)

[https://graph.microsoft.com/rp/scim/resourcetypes/{identifier}](https://graph.microsoft.com/rp/scim/resourcetypes/%7bidentifier%7d)

Upon success, the API returns HTTP Status 200.

### Errors for List Resource Types

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Requesting all resource types

**Request:**

GET [https://graph.microsoft.com/rp/scim/resourcetypes](https://graph.microsoft.com/rp/scim/resourcetypes)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:ListResponse"],
  "totalResults": 2,
  "Resources": [
    {
      "schemas": ["urn:ietf:params:scim:schemas:core:2.0:ResourceType"],
      "id": "User",
      "name": "User",
      "endpoint": "/Users",
      "description": "User Account",
      "schema": "urn:ietf:params:scim:schemas:core:2.0:User",
      "schemaExtensions": [
        {
          "schema": "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User",
          "required": true
        },
        {
          "schema": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User",
          "required": true
        }
      ],
      "meta": {
        "location": "/resourcetypes/user",
        "resourceType": "resourceType"
      }
    },
    {
      "schemas": ["urn:ietf:params:scim:schemas:core:2.0:ResourceType"],
      "id": "Group",
      "name": "Group",
      "endpoint": "/Groups",
      "description": "Group",
      "schema": "urn:ietf:params:scim:schemas:core:2.0:Group",
      "schemaExtensions": [
        {
          "schema": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group",
          "required": true
        }
      ],
      "meta": {
        "location": "/resourcetypes/group",
        "resourceType": "resourceType"
      }
    }
  ]
}
```

#### Example 2 – Requesting user resource type

**Request:**

GET [https://graph.microsoft.com/rp/scim/resourcetype/User](https://graph.microsoft.com/rp/scim/resourcetype/User)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": ["urn:ietf:params:scim:schemas:core:2.0:ResourceType"],
  "id": "User",
  "name": "User",
  "endpoint": "/Users",
  "description": "User Account",
  "schema": "urn:ietf:params:scim:schemas:core:2.0:User",
  "schemaExtensions": [
    {
      "schema": "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User",
      "required": true
    }
  ],
  "meta": {
    "location": "/resourcetypes/user",
    "resourceType": "resourceType"
  }
}
```

## Get Schema

Information about supported SCIM schemas can be retrieved by making a request to the /schemas endpoint. 

Custom Security Attributes Schema Identifier: ```"urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes"```

**API endpoints:**

[https://graph.microsoft.com/rp/scim/schemas](https://graph.microsoft.com/rp/scim/schemas)

[https://graph.microsoft.com/rp/scim/schemas/{identifier}](https://graph.microsoft.com/rp/scim/schemas/%7bidentifier%7d)

Upon success, the API returns HTTP Status 200.

### Errors for Get Schema

If there is an error, then one of the following error codes is returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Requesting all schemas

**Request:**

GET [https://graph.microsoft.com/rp/scim/schemas](https://graph.microsoft.com/rp/scim/schemas)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:ListResponse"],
  "totalResults": 5,
  "Resources": [
    {
      "id": "urn:ietf:params:scim:schemas:core:2.0:User",
      "name": "User",
      "description": "User Account",
      "attributes": [...]
    },
    {
      "id": "urn:ietf:params:scim:schemas:core:2.0:Group",
      "name": "Group",
      "description": "Group",
      "attributes": [...]
    }
  ]
}
```

#### Example 2 – Requesting user schema

**Request:**

GET [https://graph.microsoft.com/rp/scim/schemas/urn:ietf:params:scim:schemas:core:2.0:User](https://graph.microsoft.com/rp/scim/schemas/urn:ietf:params:scim:schemas:core:2.0:User)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "id": "urn:ietf:params:scim:schemas:core:2.0:User",
  "name": "User",
  "description": "User Account",
  "attributes": [...]
}
```

## List users 

Use the ```/users``` endpoint to perform the following operations:

- Get all users in the tenant (with pagination).

- Get users that match specific filter criteria.

**API endpoints:**

[https://graph.microsoft.com/rp/scim/users](https://graph.microsoft.com/rp/scim/users)

Upon success, the API returns HTTP Status 200.

If the response contains multiple pages, use [cursor-based pagination](https://datatracker.ietf.org/doc/draft-ietf-scim-cursor-pagination/) to retrieve all pages in the result.

### Query parameters for List users

The following SCIM query parameters can be used with this API endpoint:

- **filter** – to specify filter criteria to apply

- **attributes** – to specify which user attributes should be returned by the server.

- **excludedAttributes** – to specify which user attributes should be excluded by the server.

- **count** – to specify number of results to retrieve

- **cursor** – to advance to the next result page

### Constraints for List users

The Microsoft Entra ID SCIM implementation has the following constraints:

- When multiple pages are involved in the result:

  - The default page size of 10 entries per page.

  - The max page size is 100 entries per page.

- In the “filter” query parameter, only the “and” logic operator is supported. The following user attributes are allowed for “eq” compare operator:

  - ```displayName```

  - ```username```

  - ```externalId```

  - ```id```

  - ```groups.value```

  - ```urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:```**mailNickname**
- The following user attributes are allowed for “ew” compare operator. 

  - username  
  - ```urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:```**mailNickname**
- In the ```filter``` query parameter, only the *and* logical operator is supported for combining filters.

- Any whitespaces encoded or unencoded in the query string around the "=" leads to rejecting the request with a “BadRequest” error. This applies to all query params - filter, attributes, excludedAttributes, count and cursor.

- Combination filter is not supported for use with ```externalId``` attribute. Example the following combination filter cannot be used:

GET https://graph.microsoft.com/rp/scim/users?filter=externalId eq '12345' and userName eq 'user@contoso.com'

### Errors for List Users

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |


The following examples only include the request details. The response isn't included for brevity. It conforms to the standard SCIM response payload.

#### Example 1 – Get all users

**Request:**

GET [https://graph.microsoft.com/rp/scim/users](https://graph.microsoft.com/rp/scim/users)

Authorization: Bearer \<bearer_token\>

#### Example 2 – Get user by id with specific attributes

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?filter=id eq "1234"&attributes=name.familyName,displayName](https://graph.microsoft.com/rp/scim/users?filter=id%20eq%20%221234%22&attributes=name.familyName,displayName)

Authorization: Bearer \<bearer_token\>

#### Example 3 – Get users with custom security attribute set

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?attributes=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes:attributeSetName](https://graph.microsoft.com/rp/scim/users?attributes=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes:attributeSetName)

Authorization: Bearer \<bearer_token\>

#### Example 4 - Get user by id with excluded attributes

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?filter=id eq "1234"& excludedAttributes=name.familyName,displayName](https://graph.microsoft.com/rp/scim/users?filter=id%20eq%20%221234%22&%20excludedAttributes=name.familyName,displayName)

Authorization: Bearer \<bearer_token\>

#### Example 5 – Get user by displayName

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?filter=displayName eq "John Doe"](https://graph.microsoft.com/rp/scim/users?filter=displayName%20eq%20%22John%20Doe%22)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "totalResults": 1,
  "itemsPerPage": 10,
  "startIndex": 1,
  "Resources": [
    {
      "id": "123",
      "userName": "johndoe@remarks.com",
      "displayName": "John Doe",
      "schemas": ["urn:ietf:params:scim:schemas:core:2.0:User"]
    }
  ]
}
```

#### Example 5 – Get user by userName

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?filter=userName eq "JDoe"](https://graph.microsoft.com/rp/scim/users?filter=userName%20eq%20%22JDoe%22)

Authorization: Bearer \<bearer_token\>

#### Example 6 – Get user by user id and group id

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?filter=groups.value eq "GroupA" and id eq "1234"](https://graph.microsoft.com/rp/scim/users?filter=groups.value%20eq%20%22GroupA%22%20and%20id%20eq%20%221234%22)

Authorization: Bearer \<bearer_token\>

#### Example 7 – Get next page by cursor

**Request:**

GET [https://graph.microsoft.com/rp/scim/users?cursor=\<cursorValueFromPreviousPage\>](https://graph.microsoft.com/rp/scim/users?cursor=%3ccursorValueFromPreviousPage%3e)

Authorization: Bearer \<bearer_token\>

#### Example 8 – Get a specific number of users

**Request:**

GET <https://graph.microsoft.com/rp/scim/users?count=15>

Authorization: Bearer \<bearer_token\>

## Get user by ID

Existing users can be retrieved by making a GET request to the /users endpoint with a user ID.

**API endpoints:**

[https://graph.microsoft.com/rp/scim/users/{id}](https://graph.microsoft.com/rp/scim/users/%7bid%7d)

Upon success, the API returns HTTP Status 200.

### Query parameters for Get user by ID

The following SCIM query parameters can be used with this API endpoint:

- attributes – to specify which user attributes should be returned by the server.

- excludedAttributes – to specify which user attributes should be excluded by the server.

### Errors Get user by ID

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Get user by ID with specific attributes

**Request:**

GET [https://graph.microsoft.com/rp/scim/users/123?attributes=displayName,userName](https://graph.microsoft.com/rp/scim/users/123?attributes=displayName,userName)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "id": "123",
  "userName": "johndoe@example.com",
  "displayName": "John Doe",
  "schemas": ["urn:ietf:params:scim:schemas:core:2.0:User"]
}
```

## Create a user

You can create a new user in Microsoft Entra ID by sending a POST request to the /users endpoint.

**API endpoints:**

POST [https://graph.microsoft.com/rp/scim/users](https://graph.microsoft.com/rp/scim/users)

Set HTTP header Content-Type: application/scim+json

Upon success, the API returns HTTP Status 201.

### Required attributes for Create a user

The following attributes are required for successful user creation:

- ```userName```

- ```password```

- ```name.familyName```

- ```name.givenName```

- ```active```

- ```displayName```

- urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname

### Errors for Create a user

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| BadRequest | Required attributes are missing | 400 |
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |


#### Example 1 – Create a new user

**Request:**

POST

[https://graph.microsoft.com/rp/scim/users](https://graph.microsoft.com/rp/scim/users)

Authorization: Bearer \<bearer_token\>

Content-Type: application/scim+json

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:User",
    "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User"
  ],
  "active": true,
  "displayName": "Example User",
  "userName": "abc123@msfttenant.com",
  "password": "password",
  "name": {
    "familyName": "Example familyName",
    "givenName": "Example givenName"
  },
  "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User": {
    "mailNickname": "abc123"
  }
}
```

**Response (201 OK):**

Returns the SCIM representation of the user created.

## Update a user

The /users endpoint allows a PATCH request to be made for updating an existing user profile.

**API endpoints:**

PATCH [https://graph.microsoft.com/rp/scim/users/{id}](https://graph.microsoft.com/rp/scim/users/%7bid%7d)

Set HTTP header Content-Type: application/scim+json

Upon success, the API returns HTTP Status 200.

### Constraints for Update a user

- For PATCH operations, while updating complex multi-valued attributes like addresses, the path property only supports “[type eq \" work\"]" filter.

- Mandatory attribute ```mailNickname``` can't be removed using PATCH operation.

### Errors for Update a user

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| BadRequest | Required attributes are missing | 400 |
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Update an attribute value

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/users/123](https://graph.microsoft.com/rp/scim/users/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "Operations": [
    {
      "op": "replace",
      "path": "displayName",
      "value": "Johnathan Doe"
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 2 – Update a complex value

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/users/123](https://graph.microsoft.com/rp/scim/users/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "urn:ietf:params:scim:schemas:core:2.0:User:name",
      "value": {
        "familyName": "Jane",
        "givenName": "Doe"
      }
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 3 – Update complex multi-valued attribute

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/users/123](https://graph.microsoft.com/rp/scim/users/123)

Authorization: Bearer \<bearer_token\>

Content-Type: application/scim+json

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "urn:ietf:params:scim:schemas:core:2.0:User:addresses",
      "value": [
        {
          "type": "work",
          "streetAddress": "2 Microsoft Way",
          "locality": "Redmond",
          "region": "King County",
          "postalCode": "98052",
          "country/region": "United States"
        }
      ]
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 4 – Update complex multi-valued attribute with filter

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/users/123](https://graph.microsoft.com/rp/scim/users/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "emails[type eq \"work\" and primary eq true]",
      "value": {
        "value": "<edited username>@{{tenant_domain}}"
      }
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 5 – Update user manager

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/users/123](https://graph.microsoft.com/rp/scim/users/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager",
      "value": {
        "value": "915f96af-ea85-4687-b972-b26f69d719f9"
      }
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

## Delete a user

A user can be deleted by making a DELETE request to the /users endpoint with an existing user ID.

**API endpoints:**

DELETE [https://graph.microsoft.com/rp/scim/users/{id}](https://graph.microsoft.com/rp/scim/users/%7bid%7d)

Set HTTP header Content-Type: ```application/scim+json```

Upon success, the API returns HTTP Status 204.

### Errors for Delete a user

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Delete a user

**Request:**

DELETE

<https://graph.microsoft.com/rp/scim/users/123>

Authorization: Bearer \<bearer_token\>

**Response (204 OK):**

The response conforms to SCIM specification.

## List groups

Use the /groups endpoint to perform the following operations:

- Get all groups in the tenant (with pagination).

- Get groups that match specific filter criteria.

**API endpoints:**

[https://graph.microsoft.com/rp/scim/groups](https://graph.microsoft.com/rp/scim/groups)

Upon success, the API returns HTTP Status 200.

If the response contains multiple pages, use [cursor-based pagination](https://datatracker.ietf.org/doc/draft-ietf-scim-cursor-pagination/) to retrieve all pages in the result.

### Query parameters for List groups

The following SCIM query parameters can be used with this API endpoint:

- ```filter``` – to specify filter criteria to apply

- ```attributes``` – to specify which group attributes should be returned by the server

- ```excludedAttributes``` – to specify which group attributes should be excluded by the server

- ```count``` – to specify number of results to retrieve

- ```cursor``` – to advance to the next result page

### Constraints for List groups

The Microsoft Entra ID SCIM implementation has the following constraints:

- When multiple pages are involved in the result:

  - The default page size of 10 entries per page.

  - The max page size is 100 entries per page.

- In the ```filter``` query parameter, only the “and” logic operator is supported. The following group attributes are allowed for “eq” compare operator.  

  - ```displayName```

  - ```id```

  - ```members.value```
- The following group attributes are allowed for "ew" compare operator
  - displayName
- Nested group membership is not evaluated when using the ```member.value``` filter. Only direct memberships are evaluated.

### Errors for List groups

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

### Examples

The following examples only include the request details. The response is not included for brevity. It conforms to the standard SCIM response payload.

#### Example 1 – Get all groups

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups](https://graph.microsoft.com/rp/scim/groups)

Authorization: Bearer \<bearer_token\>

#### Example 2 – Get group by id with specific attributes

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?filter=id eq "1234"&attributes=displayName](https://graph.microsoft.com/rp/scim/groups?filter=id%20eq%20%221234%22&attributes=displayName)

Authorization: Bearer \<bearer_token\>

#### Example 3 – Get group by id with excluded attributes

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?filter=id eq "1234"&excludedAttributes=displayName](https://graph.microsoft.com/rp/scim/groups?filter=id%20eq%20%221234%22&excludedAttributes=displayName)

Authorization: Bearer \<bearer_token\>

#### Example 4 – Get group by displayName

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?filter=displayName eq "GroupA"](https://graph.microsoft.com/rp/scim/groups?filter=displayName%20eq%20%22GroupA%22)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "totalResults": 1,
  "itemsPerPage": 10,
  "startIndex": 1,
  "Resources": [
    {
      "id": "123",
      "userName": "johndoe@remarks.com",
      "displayName": "John Doe",
      "schemas": ["urn:ietf:params:scim:schemas:core:2.0:User"]
    }
  ]
}
```

#### Example 5 – Get group by member

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?filter=members.value eq "JDoe"](https://graph.microsoft.com/rp/scim/groups?filter=members.value%20eq%20%22JDoe%22)

Authorization: Bearer \<bearer_token\>

#### Example 6 – Get next page by cursor

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?cursor=\<cursorValueFromPreviousPage\>](https://graph.microsoft.com/rp/scim/groups?cursor=%3ccursorValueFromPreviousPage%3e)

Authorization: Bearer \<bearer_token\>

#### Example 7 – Get a specific number of groups

**Request:**

GET [https://graph.microsoft.com/rp/scim/groups?count=15](https://graph.microsoft.com/rp/scim/groups?count=15)

Authorization: Bearer \<bearer_token\>

## Get group by ID

Existing groups are retrieved by making a GET request to the /groups endpoint with a group ID.

**API endpoints:**

[https://graph.microsoft.com/rp/scim/groups/{id}](https://graph.microsoft.com/rp/scim/groups/%7bid%7d)

Upon success, the API returns HTTP Status 200.

### Constraints for Get group by ID

- Group members are not returned by this API call. Use GET ```/groups``` with members.value filter to retrieve groups where user is a member.

### Query parameters for Get group by ID

The following SCIM query parameters can be used with this API endpoint:

- ```attributes``` – to specify which group attributes should be returned by the server.

- ```excludedAttributes``` – to specify which group attributes should be excluded by the server.

### Errors for Get group by ID

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Get group by ID 

**Request:**

GET

[https://graph.microsoft.com/rp/scim/groups/456](https://graph.microsoft.com/rp/scim/groups/456)

Authorization: Bearer \<bearer_token\>

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "id": "456",
  "displayName": "Admin Group",
  "schemas": ["urn:ietf:params:scim:schemas:core:2.0:Group"]
}
```

## Create a group

You can create a new group in Microsoft Entra ID by sending a POST request to the /groups endpoint.

**API endpoints:**

POST [https://graph.microsoft.com/rp/scim/groups](https://graph.microsoft.com/rp/scim/groups)

Set HTTP header Content-Type: ```application/scim+json```

Upon success, the API returns HTTP Status 201.

### Required attributes for Create a group

The following attributes are required for successful user creation:

- ```displayName```

### Errors for Create a group

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| BadRequest | Required attributes are missing | 400 |
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Create a new group

**Request:**

POST

[https://graph.microsoft.com/rp/scim/group](https://graph.microsoft.com/rp/scim/group)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "displayName": "Example Group",
  "members": [
    {
      "value": "user-123",
      "$ref": "https://graph.microsoft.com/v1.0/users/user-123"
    }
  ]
}
```

**Response (201 OK):**

Returns the SCIM representation of the user created.

## Update a group

The ```/users``` endpoint allows a PATCH request to be made for updating an existing group.

**API endpoints:**

PATCH [https://graph.microsoft.com/rp/scim/groups/{id}](https://graph.microsoft.com/rp/scim/groups/%7bid%7d)

Set HTTP header Content-Type: application/scim+json

Upon success, the API returns HTTP Status 200.

### Constraints for Update a group

- Adding members to groups must be done in a single PATCH **Operation** object.  

- When using the API to add multiple members in one request, you can add up to only 20 members. 

- Only one member can be removed from a group per PATCH call.  

- Removing group members must be done without any other attribute changes included in the same PATCH call (including adding members).  

- Adding members to groups must be done without any other attribute changes (including removing members).  

- Add group members is treated as an **idempotent** operation. If a specific member is already present in the group, then no error is returned, and the operation succeeds as long as all group **memberIds** point to valid user objects.

- If a **memberId** passed either in group membership add or remove operation is invalid, then the entire operation fails with the error message ```“Resource '00000000-0000-0000-0000-000000000000'``` does not exist or one of its queried reference-property objects are not present.”

### Errors for Update a group

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| BadRequest | Required attributes are missing | 400 |
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |


#### Example 1 – Update Group display name

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/groups/123](https://graph.microsoft.com/rp/scim/groups/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "displayName",
      "value": "SCIM Testing Group Edited"
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 2 – Update Group description

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/groups/123](https://graph.microsoft.com/rp/scim/groups/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:PatchOp"],
  "operations": [
    {
      "op": "replace",
      "path": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:description",
      "value": "Finance group"
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 3 – Add Group members

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/groups/123](https://graph.microsoft.com/rp/scim/groups/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:PatchOp"
  ],
  "Operations": [
    {
      "op": "add",
      "path": "members",
      "value": [
        {
          "value": "756b18d2-023a-4fa8-845e-9ac8b524100f"
        },
        {
          "value": "0e4c70dd-c015-48db-bb5a-6264d215ca8e"
        }
      ]
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

#### Example 4 – Remove Group members

**Request:**

PATCH

[https://graph.microsoft.com/rp/scim/groups/123](https://graph.microsoft.com/rp/scim/groups/123)

Authorization: Bearer \<bearer_token\>

Content-Type: ```application/scim+json```

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:PatchOp"
  ],
  "Operations": [
    {
      "op": "remove",
      "path": "members",
      "value": [
        {
          "value": "756b18d2-023a-4fa8-845e-9ac8b524100f"
        }
      ]
    }
  ]
}
```

**Response (200 OK):**

The response conforms to SCIM specification.

## Delete a group

A user can be deleted by making a DELETE request to the /groups endpoint with an existing group ID.

**API endpoints:**

DELETE [https://graph.microsoft.com/rp/scim/groups/{id}](https://graph.microsoft.com/rp/scim/groups/%7bid%7d)

Set HTTP header Content-Type: ```application/scim+json```

Upon success, the API returns HTTP Status 204.

### Errors for Delete a group

If there is an error, then one of the following error codes are returned.

| Error | Condition | HTTP Status Code |
|----|----|----|
| InvalidAuthenticationToken | Access token is empty or invalid. | 401 |
| InsufficientPrivileges | Insufficient permission to complete the operation | 403 |
| ResourceNotFound | Invalid URN | 404 |
| InternalServerException | Service failed to process the request | 500 |

#### Example 1 – Delete a group

**Request:**

DELETE

[https://graph.microsoft.com/rp/scim/groups/123](https://graph.microsoft.com/rp/scim/groups/123)

Authorization: Bearer \<bearer_token\>

**Response (204 OK):**

The response conforms to SCIM specification.

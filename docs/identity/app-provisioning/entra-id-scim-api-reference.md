---
title: Microsoft Entra ID SCIM API 
description: Build custom integrations to provision users and groups to Microsoft Entra ID using the System for Cross-domain Identity Management (SCIM) v2.0 protocol.
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 09/04/2026
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As a developer or IT administrator, I want to understand how to integrate with Microsoft Entra ID using the SCIM v2.0 protocol so that I can programmatically provision, manage, and synchronize users and groups between my application and Microsoft Entra ID.
---

# Microsoft Entra ID SCIM API reference

Use this reference guide to provision (synchronize) users and groups into Microsoft Entra ID using the System for Cross-domain Identity Management (SCIM) v2.0 protocol.

## SCIM API overview

The Microsoft Entra ID SCIM implementation is based on the following IETF drafts:

- [RFC 7642: System for Cross-domain Identity Management: Definitions, Overview, Concepts, and Requirements](https://www.rfc-editor.org/rfc/rfc7642)
- [RFC 7643: System for Cross-domain Identity Management: Core Schema](https://www.rfc-editor.org/rfc/rfc7643)
- [RFC 7644: System for Cross-domain Identity Management: Protocol](https://www.rfc-editor.org/rfc/rfc7644)
- [RFC 9865: Cursor-based pagination of SCIM resources](https://datatracker.ietf.org/doc/rfc9865/)

All SCIM API endpoints are under the base URL: `https://graph.microsoft.com/rp/scim`

| Endpoint | Supported HTTP methods | Description |
|---|---|---|
| `/serviceproviderconfig` | GET | Fetch configuration details about the Microsoft Entra ID SCIM implementation, such as supported authentication schemes, available endpoints, and compliance with SCIM protocols. |
| `/resourcetypes` | GET | Retrieve information about the resource types (Users and Groups) supported by Microsoft Entra ID. |
| `/schemas` | GET | Retrieve detailed information about the schemas supported by Microsoft Entra ID. |
| `/users` | GET, POST, PATCH, DELETE | Read, create, update, and delete user data in Microsoft Entra ID. |
| `/groups` | GET, POST, PATCH, DELETE | Read, create, update, and delete group and group membership data in Entra ID. |

The following sections contain examples of API requests and responses currently supported in the Microsoft Entra ID SCIM implementation, along with important notes and constraints to consider in your design.

## Invoking the SCIM APIs

Before you can call the SCIM API endpoints described in this article, you must enable the SCIM Provisioning API feature, configure billing, set up credentials, and obtain an access token. For step-by-step instructions, see [Enable the SCIM Provisioning API in Microsoft Entra ID](enable-scim-api.md).

If you're using the Microsoft Graph endpoint in the US Government cloud, use `https://graph.microsoft.us/rp/scim` as the base URL for SCIM API requests. The examples in this article use `https://graph.microsoft.com` to illustrate the global cloud endpoint.

> [!NOTE]
> SCIM APIs operate exclusively in application context (app-only token) and do not support delegated, user-on-behalf-of scenarios.

## Mapping to Graph User and Group properties

To learn how Microsoft Graph user and group properties map to SCIM user and group attributes, refer to [Microsoft Entra ID SCIM API schema reference](entra-id-scim-api-schema-documentation.md).

## Throttling

The same throttling guidance and service-specific throttling limits that apply to Microsoft Graph APIs also apply to Microsoft Entra ID SCIM APIs. For the throttling policies that apply to Microsoft Graph user and group APIs, see [Microsoft Graph throttling guidance](/graph/throttling) and [Microsoft Graph service-specific throttling limits for identity and access APIs](/graph/throttling-limits#identity-and-access-service-limits).

## Errors

For a list of common error codes returned by SCIM API endpoints, see [SCIM API error code reference](troubleshoot-scim-api-errors.md#scim-api-error-code-reference).

## Get Service Provider Config

Use the ```/ServiceProviderConfig``` endpoint to view additional information about Microsoft Entra ID SCIM implementation. The ```/ServiceProviderConfig``` endpoint is read only.

**API endpoint:** `https://graph.microsoft.com/rp/scim/serviceproviderconfig`

Upon success, the API returns HTTP Status 200.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.Read.All` and `Group.Read.All`, `User.ReadWrite.All` and `Group.ReadWrite.All` |

#### Example 1 – Requesting service provider config

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/serviceproviderconfig
Authorization: Bearer {token}
Accept: application/json
```

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

- `https://graph.microsoft.com/rp/scim/resourcetypes`
- `https://graph.microsoft.com/rp/scim/resourcetypes/{identifier}`

Upon success, the API returns HTTP Status 200.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.Read.All` and `Group.Read.All`, `User.ReadWrite.All` and `Group.ReadWrite.All` |

#### Example 1 – Requesting all resource types

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/resourcetypes
Authorization: Bearer {token}
Accept: application/json
```

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
          "required": false
        },
        {
          "schema": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User",
          "required": false
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

```http
GET https://graph.microsoft.com/rp/scim/resourcetype/User
Authorization: Bearer {token}
Accept: application/json
```

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
      "required": false
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

**API endpoints:**

- `https://graph.microsoft.com/rp/scim/schemas`
- `https://graph.microsoft.com/rp/scim/schemas/{identifier}`

Upon success, the API returns HTTP Status 200.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.Read.All` and `Group.Read.All`, `User.ReadWrite.All` and `Group.ReadWrite.All` |

> [!NOTE]
> To read the Custom Security Attributes schema, the app also requires `CustomSecAttributeDefinition.Read.All`.

#### Example 1 – Requesting all schemas

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/schemas
Authorization: Bearer {token}
Accept: application/json
```

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

```http
GET https://graph.microsoft.com/rp/scim/schemas/urn:ietf:params:scim:schemas:core:2.0:User
Authorization: Bearer {token}
Accept: application/json
```

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
#### Example 3 – Requesting custom security attributes schema

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/schemas/urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes
Authorization: Bearer {token}
Accept: application/json
```
**Response (200 OK):**

Response is truncated for readability.

```json
{
  "id": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes",
  "name": "MicrosoftEntraCustomSecurityAttributes",
  "description": "Microsoft Entra Custom Security Attributes",
  "attributes": [
    {
      "name": "Project",
      "type": "complex",
      "multiValued": false,
      "description": "Projects assigned to the user",
      "required": false,
      "caseExact": false,
      "subAttributes": [
        {
          "name": "ProjectName",
          "type": "String",
          "multiValued": false,
          "description": "Name of the project",
          "required": false,
          "caseExact": false,
          "mutability": "readWrite",
          "returned": "default",
          "uniqueness": "none"
        }
      ],
      "mutability": "readWrite",
      "returned": "request",
      "uniqueness": "none"
    }, …
]
}
```


## List users 

Use the `/users` endpoint to perform the following operations:

- Get all users in the tenant (with pagination).

- Get users that match specific filter criteria.

**API endpoint:**

`https://graph.microsoft.com/rp/scim/users`

Upon success, the API returns HTTP Status 200.

If the response contains multiple pages, use [cursor-based pagination](https://datatracker.ietf.org/doc/draft-ietf-scim-cursor-pagination/) to retrieve all pages in the result.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.ReadBasic.All`, `User.Read.All`, `User.ReadWrite.All` |

> [!NOTE]
> To read Custom Security Attributes on users, the app also requires `CustomSecAttributeAssignment.Read.All` or `CustomSecAttributeAssignment.ReadWrite.All`.
>
> [`User.ReadBasic.All`](/graph/permissions-reference#userreadbasicall) limits responses to basic profile properties and supports filtering only on properties in the basic profile. Of the filters supported by this endpoint, `id` and `userName` meet this requirement. To use filters on `active`, `externalId`, `groups.value`, `mailNickname`, or `ownedGroups.value`, grant `User.Read.All` or `User.ReadWrite.All`.

### Query parameters for List users

The following SCIM query parameters can be used with this API endpoint:

- **filter** – to specify filter criteria to apply

- **attributes** – to specify which user attributes should be returned by the server.

- **excludedAttributes** – to specify which user attributes should be excluded by the server.

- **count** – to specify the number of results to retrieve. The default value is 100. Larger projected requests support a value of up to 999, subject to the constraints in the next section.

- **cursor** – to advance to the next result page

### Constraints for List users

The Microsoft Entra ID SCIM implementation has the following constraints:

- The default page size is 100 entries per page.
- To request between 101 and 999 users per page, specify `attributes` and don't include `urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager` in the projection.
- If the `attributes` projection includes `urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager`, the service ignores a `count` value greater than 100 and uses the default page size of 100.

- The following user attributes are allowed for the `eq` comparison operator:
  - `active`. Boolean values are case-insensitive, including `true`, `false`, `TRUE`, and `FALSE`.
  - `userName`
  - `externalId`
  - `id`
  - `groups.value`
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname`
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:ownedGroups.value`

- The following user attributes are allowed for the `ew` (ends with) comparison operator:
  - `userName`
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname`

- Use the `not` operator to negate an `ew` comparison on `userName` or `mailNickname`. Use the `and` logical operator to combine supported filters.

- Any whitespaces encoded or unencoded in the query string around the "=" leads to rejecting the request with a “BadRequest” error. This applies to all query params - filter, attributes, excludedAttributes, count and cursor.

- Combination filter is not supported for use with `externalId` attribute. For example, the following combination filter cannot be used:

```http 
GET https://graph.microsoft.com/rp/scim/users?filter=externalId eq '12345' and userName eq 'user@contoso.com' 
```

The following examples only include the request details. The response isn't included for brevity. It conforms to the standard SCIM response payload.

#### Example 1A – Get all users

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users
Authorization: Bearer {token}
Accept: application/json
```

**Response (200 OK):**

```json

{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:ListResponse"],
  "itemsPerPage": 100,
  "nextCursor": "RFNwdAIAAQAAAB06MTAyMDE4QHhmcDFiLm9ubWljcm9zb2Z0LmNvbS...",
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User",
        "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User",
        "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User"
      ],
      "id": "d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4",
      "active": true,
      "displayName": "Ellen Reckert",
      "name": {
        "familyName": "Reckert",
        "givenName": "Ellen"
      },
      "userName": "100009@contoso.com",
      "urn:ietf:params:scim:schemas:extension:enterprise:2.0:User": {
        "department": "Human Resources US",
        "employeeNumber": "100009",
        "manager": {
          "value": "bbbbbbbb-7777-8888-9999-cccccccccccc"
        }
      },
      "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User": {
        "mailNickname": "100009",
        "userType": "Member"
      },
      "meta": {
        "location": "/users/d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4",
        "resourceType": "user"
      }
    },
    { ... }
  ]
}

```

#### Example 1B – Retrieving next page for get all users

The above query by default returns 100 users per page. If you have more than 100 users in your tenant, use pagination to retrieve the next set of users by setting the `cursor` query parameter to the value of `nextCursor` received in the response.

```http
GET https://graph.microsoft.com/rp/scim/users?cursor=RFNwdAIAAQAAAB06MTAyMDE4QHhmcDFiLm9ubWljcm9zb2Z0LmNvbS...
Authorization: Bearer {token}
Accept: application/json
```

#### Example 1C – Using count parameter to control users returned

You can request up to 999 users per page when you specify an `attributes` projection that doesn't include the  `urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager` attribute.

```http
GET https://graph.microsoft.com/rp/scim/users?filter=active eq true&count=999&attributes=userName,id,displayName
Authorization: Bearer {token}
Accept: application/json
```

```http
GET https://graph.microsoft.com/rp/scim/users?filter=active eq true&count=999&attributes=userName,id,displayName&cursor=RFNwdAIAAQAAAB06MTAyMDE4QHhmcDFiLm9ubWljcm9zb2Z0LmNvbS...
Authorization: Bearer {token}
Accept: application/json
```

#### Example 2 – Get user by ID with specific attributes

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=id eq "97c0abe1-14f7-417b-951c-bc8e2a17f200"&attributes=name.familyName,displayName
Authorization: Bearer {token}
```

#### Example 3 – Get users with custom security attribute set

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?attributes=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes:attributeSetName
Authorization: Bearer {token}
```

#### Example 4 - Get user by ID with excluded attributes

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=id eq "97c0abe1-14f7-417b-951c-bc8e2a17f200"&excludedAttributes=name.familyName,displayName
Authorization: Bearer {token}
```

#### Example 5 – Get user by mailNickname

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname eq "100009"&attributes=displayName
Authorization: Bearer {token}
```

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:ListResponse"
  ],
  "totalResults": 1,
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User",
        "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User"
      ],
      "id": "f5f5f5f5-aaaa-bbbb-cccc-d6d6d6d6d6d6",
      "displayName": "Ellen Reckert",
      "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User": {
        "mailNickname": "100009"
      },
      "meta": {
        "location": "/users/f5f5f5f5-aaaa-bbbb-cccc-d6d6d6d6d6d6",
        "resourceType": "user"
      }
    }
  ]
}
```

#### Example 6 – Get user by userName

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=userName eq "AdeleV@contoso.com"
Authorization: Bearer {token}
```

#### Example 7 – Get active users

The `active` Boolean filter is case-insensitive.

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=active eq true
Authorization: Bearer {token}
```

#### Example 8 – Exclude users by mailNickname suffix and filter by userName suffix

Use `not` to negate supported `ew` comparisons and `and` to combine the filters.

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=not(urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname ew "-admin") and not(urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname ew "-ga") and userName ew "@contoso.com"
Authorization: Bearer {token}
```

#### Example 9 – Get users by group ID

**Request:**

Use the Microsoft Entra group object ID for the `groups.value` property to retrieve the direct members of a group. Use this query instead of requesting the `members` attribute from `GET /groups/{id}`.

```http
GET https://graph.microsoft.com/rp/scim/users?filter=groups.value eq "c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3"&attributes=displayName
Authorization: Bearer {token}
```

**Response (200 OK)**
Response truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:ListResponse"
  ],
  "totalResults": 1,
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User"
      ],
      "id": "d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4",
      "displayName": "Ellen Reckert",
      "meta": {
        "location": "/users/d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4",
        "resourceType": "user"
      }
    }
  ]
}
```

#### Example 10 – Get users who own a group

Although `ownedGroups` isn't returned in user response bodies, you can use its `value` subattribute as a filter target. Specify the full Microsoft Entra user extension namespace.

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users?filter=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:ownedGroups.value eq "c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3"
Authorization: Bearer {token}
```

#### Example 11 - Retrieve specific custom security attributes for a user

```http
GET https://graph.microsoft.com/rp/scim/users?filter=userName eq "AdeleV@contoso.com"&attributes=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes:Project
Authorization: Bearer {token}
```

**Response (200 OK)**
Response truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:ListResponse"
  ],
  "totalResults": 1,
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:User",
        "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes"
      ],
      "id": "b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2",
      "userName": "AdeleV@contoso.com",
      "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes": {
        "Project": {
          "ProjectName": "IdentityHub"
        }
      },
      "meta": {
        "location": "/users/b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2",
        "resourceType": "user"
      }
    }
  ]
}
```

## Get user by ID

Existing users can be retrieved by making a GET request to the /users endpoint with a user ID.

**API endpoints:**

`https://graph.microsoft.com/rp/scim/users/{id}`

Upon success, the API returns HTTP Status 200.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.ReadBasic.All`, `User.Read.All`, `User.ReadWrite.All` |

> [!NOTE]
> [`User.ReadBasic.All`](/graph/permissions-reference#userreadbasicall) limits responses to basic profile properties. To retrieve other user properties, grant `User.Read.All` or `User.ReadWrite.All`.

### Query parameters for Get user by ID

The following SCIM query parameters can be used with this API endpoint:

- attributes – to specify which user attributes should be returned by the server.

- excludedAttributes – to specify which user attributes should be excluded by the server.

#### Example 1 – Get user by ID with specific attributes

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/users/aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb?attributes=displayName,userName
Authorization: Bearer {token}
```

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:User"
  ],
  "id": "aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb",
  "displayName": "Adele Vance",
  "userName": "AdeleV@contoso.com",
  "meta": {
    "location": "/users/aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb",
    "resourceType": "user"
  }
}
```

## Create a user

You can create a new user in Microsoft Entra ID by sending a POST request to the /users endpoint.

**API endpoints:**

POST `https://graph.microsoft.com/rp/scim/users`

Upon success, the API returns HTTP Status 201.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.Create` or `User.ReadWrite.All` |

### Required attributes for Create a user

The following attributes are required for successful user creation:

- `userName`

- `password`

- ```name.familyName```

- ```name.givenName```

- `active`

- `displayName`

> [!NOTE]
> The `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:User:mailNickname` attribute is optional when you create a user. If you omit it, set it to `null`, or provide an empty value, Microsoft Entra ID derives `mailNickname` from `userName`. It uses the characters before the first `@`. If `userName` doesn't contain `@`, it uses the complete value. For example, `abc123@contoso.com` produces a `mailNickname` value of `abc123`.

#### Example 1 – Create a new user

**Request:**

```http
POST https://graph.microsoft.com/rp/scim/users
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:User"
  ],
  "active": true,
  "displayName": "Example User",
  "userName": "abc123@contoso.com",
  "password": "password",
  "name": {
    "familyName": "Example familyName",
    "givenName": "Example givenName"
  }
}
```

**Response (201 Created):**

Returns the SCIM representation of the user created.

In this example, Microsoft Entra ID derives the `mailNickname` value `abc123` from `userName`.

## Update a user

The /users endpoint allows a PATCH request to be made for updating an existing user profile.

**API endpoints:**

PATCH `https://graph.microsoft.com/rp/scim/users/{id}`

Upon success, the API returns HTTP Status 204.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.ReadUpdate.All` or `User.ReadWrite.All` |

> [!NOTE]
> If your app only needs to update specific user attributes, use the least-privileged permission for those attributes. For details, see the [SCIM API application permissions](enable-scim-api.md#option-1-register-an-application-client-credentials-flow).

### Constraints for Update a user

- For PATCH operations, while updating complex multi-valued attributes like addresses, the path property only supports “[type eq \" work\"]" filter.

- After a user is created, the `mailNickname` attribute can't be removed by using a PATCH operation.

#### Example 1 – Update an attribute value

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 2 – Update a complex value

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 3 – Update complex multi-valued attribute

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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
          "streetAddress": "4567 Main Street",
          "locality": "Buffalo",
          "region": "NY",
          "postalCode": "98052",
          "country/region": "United States"
        }
      ]
    }
  ]
}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 4 – Update complex multi-valued attribute with filter

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [ "urn:ietf:params:scim:api:messages:2.0:PatchOp" ],
  "operations": [
    {
      "op": "replace",
      "path": "emails[type eq \"work\" and primary eq true].value",         
      "value": "{edited_username}@{{tenant_domain}}"      
    }
  ]
}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 5 – Update user manager

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 6 - Update custom security attributes

**Request:**
```http
PATCH https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [ "urn:ietf:params:scim:api:messages:2.0:PatchOp" ],
  "operations": [
    {
      "op": "add",
      "path": "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:CustomSecurityAttributes:Project.ProjectName",
      "value": "IdentityHubV2"
    }
  ]
}
```

**Response (204 No Content):**
The response conforms to SCIM specification.

## Delete a user

A user can be deleted by making a DELETE request to the /users endpoint with an existing user ID.

**API endpoints:**

DELETE `https://graph.microsoft.com/rp/scim/users/{id}`

Upon success, the API returns HTTP Status 204.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `User.ReadWrite.All` |

#### Example 1 – Delete a user

**Request:**

```http
DELETE https://graph.microsoft.com/rp/scim/users/ec3f07a3-2aa4-4666-b2fd-90e479428791
Authorization: Bearer {token}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

## List groups

Use the /groups endpoint to perform the following operations:

- Get all groups in the tenant (with pagination).

- Get groups that match specific filter criteria.

**API endpoints:**

`https://graph.microsoft.com/rp/scim/groups`

Upon success, the API returns HTTP Status 200.

If the response contains multiple pages, use [cursor-based pagination](https://datatracker.ietf.org/doc/draft-ietf-scim-cursor-pagination/) to retrieve all pages in the result.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `Group.Read.All`, `Group.ReadWrite.All` |

### Query parameters for List groups

The following SCIM query parameters can be used with this API endpoint:

- `filter` – to specify filter criteria to apply

- `attributes` – to specify which group attributes should be returned by the server

- `excludedAttributes` – to specify which group attributes should be excluded by the server

- `count` – to specify number of results to retrieve (default=100)

- `cursor` – to advance to the next result page

### Constraints for List groups

The Microsoft Entra ID SCIM implementation has the following constraints:

- When multiple pages are involved in the result:

  - The default page size of 100 entries per page.

  - The max page size is 1000 entries per page.

- In the `filter` query parameter, only the `and` logical operator is supported for combining filters. The following group attributes are allowed for the `eq` comparison operator:

  - `displayName`: Set this attribute to a valid Microsoft Entra group display name.
  - `id`: Set this attribute to a valid Microsoft Entra group object ID (GUID) in your tenant.
  - `members.value`: Set this attribute to a valid Microsoft Entra user object ID (GUID) in your tenant.
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:securityEnabled`: Set this attribute to a case-insensitive Boolean value, including `true`, `false`, `TRUE`, or `FALSE`.
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:mailEnabled`: Set this attribute to a case-insensitive Boolean value, including `true`, `false`, `TRUE`, or `FALSE`.
  - `urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:owners.value`: Set this attribute to a valid Microsoft Entra user object ID (GUID) in your tenant.

- The following group attributes are allowed for "ew" (endsWith) compare operator
  - displayName
- Nested group membership is not evaluated when using the `member.value` filter. Only direct memberships are evaluated.

### Examples

The following examples only include the request details. The response is not included for brevity. It conforms to the standard SCIM response payload.

#### Example 1 – Get all groups

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups
Authorization: Bearer {token}
```

**Response (200 OK):**

If the number of groups is more than 100, then the response will include the `itemsPerPage` and `nextCursor` property. Use the `nextCursor` value to retrieve the next page of the result.

```json
{
  "schemas": ["urn:ietf:params:scim:api:messages:2.0:ListResponse"],
  "itemsPerPage": 100,
  "nextCursor": "RFNwdAIAAQAAACpHcm91cF8zMDhiMzNkOC0wNjkxLTQzZTktOTA4Mi1kNG...",
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:Group",
        "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group"
      ],
      "id": "c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3",
      "displayName": "Sales and Marketing",
      "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group": {
        "description": "Description of Sales and Marketing",
        "groupTypes": [
          "Unified"
        ],
        "mailEnabled": true,
        "mailNickname": "SalesandMarketing",
        "securityEnabled": false,
        "securityIdentifier": "ffffffff-5a5a-6b6b-7c7c-888888888888"
      },
      "meta": {
        "created": "2022-01-11T01:23:26+00:00",
        "location": "/groups/c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3",
        "resourceType": "group"
      }
    },    
    { ... }
  ]
}

```

#### Example 1B – Retrieving next page for get all groups

The above query by default returns 100 groups per page. If you have more than 100 groups in your tenant, use pagination to retrieve the next set of groups by setting the `cursor` query parameter to the value of `nextCursor` received in the response.

```http
GET https://graph.microsoft.com/rp/scim/groups?cursor=RFNwdAIAAQAAACpHcm91cF8zMDhiMzNkOC0wNjkxLTQzZTktOTA4Mi1kNG...
Authorization: Bearer {token}
Accept: application/json
```

#### Example 1C – Using count parameter to control groups returned

You can use the `count` parameter to retrieve a certain number of groups.

```http
GET https://graph.microsoft.com/rp/scim/groups?count=1000
Authorization: Bearer {token}
Accept: application/json
```

```http
GET https://graph.microsoft.com/rp/scim/groups?count=1000&cursor=RFNwdAIAAQAAACpHcm91cF8zMDhiMzNkOC0wNjkxLTQzZTktOTA4Mi1kNG...
Authorization: Bearer {token}
Accept: application/json
```

#### Example 2 – Get group by ID with specific attributes

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=id eq "dddddddd-3333-4444-5555-eeeeeeeeeeee"&attributes=displayName
Authorization: Bearer {token}
```

#### Example 3 – Get group by ID with excluded attributes

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=id eq "dddddddd-3333-4444-5555-eeeeeeeeeeee"&excludedAttributes=displayName
Authorization: Bearer {token}
```

#### Example 4 – Get group by displayName

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=displayName eq "GroupA"
Authorization: Bearer {token}
```

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:ListResponse"
  ],
  "totalResults": 1,
  "resources": [
    {
      "schemas": [
        "urn:ietf:params:scim:schemas:core:2.0:Group"
      ],
      "id": "a6a6a6a6-bbbb-cccc-dddd-e7e7e7e7e7e7",
      "displayName": "GroupA",
      "meta": {
        "location": "/groups/a6a6a6a6-bbbb-cccc-dddd-e7e7e7e7e7e7",
        "resourceType": "group"
      }
    }
  ]
}
```

#### Example 5 – Get group by member

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=members.value eq "d4b34e9e-0ad7-42df-b1f6-401b41fe1bee"
Authorization: Bearer {token}
```

**Response (200 OK):**

The response includes both assigned and dynamic groups where the user is a member.

#### Example 6 – Get security-enabled groups

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:securityEnabled eq true
Authorization: Bearer {token}
```

#### Example 7 – Get mail-enabled groups

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:mailEnabled eq true
Authorization: Bearer {token}
```

#### Example 8 – Get groups owned by a user

Although `owners` isn't returned in group response bodies, you can use its `value` subattribute as a filter target. Specify the full Microsoft Entra group extension namespace.

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups?filter=urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group:owners.value eq "d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4"
Authorization: Bearer {token}
```

## Get group by ID

Existing groups are retrieved by making a GET request to the /groups endpoint with a group ID.

**API endpoints:**

`https://graph.microsoft.com/rp/scim/groups/{id}`

Upon success, the API returns HTTP Status 200.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `Group.Read.All`, `Group.ReadWrite.All` |

### Constraints for Get group by ID

- Group members aren't returned by this API call. Attribute-level pagination isn't supported by the cursor-based pagination specification, so the API can't use it to return large member collections. To retrieve the direct members of a group, use `GET /users?filter=groups.value eq "{groupId}"`.

### Query parameters for Get group by ID

The following SCIM query parameters can be used with this API endpoint:

- `attributes` – to specify which group attributes should be returned by the server.

- `excludedAttributes` – to specify which group attributes should be excluded by the server.

#### Example 1 – Get group by ID 

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/groups/dddddddd-3333-4444-5555-eeeeeeeeeeee
Authorization: Bearer {token}
```

**Response (200 OK):**

Response is truncated for readability.

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:Group",
    "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group"
  ],
  "id": "dddddddd-3333-4444-5555-eeeeeeeeeeee",
  "displayName": "GroupA",
  "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group": {
    "description": "Group for All Employees - Baseline access",
    "mailEnabled": false,
    "mailNickname": "3c998a58-6",
    "securityEnabled": true,
    "securityIdentifier": "ffffffff-5a5a-6b6b-7c7c-888888888888"
  },
  "meta": {
    "created": "2024-05-23T17:21:41+00:00",
    "location": "/groups/dddddddd-3333-4444-5555-eeeeeeeeeeee",
    "resourceType": "group"
  }
}
```

## Create a group

You can create a new group in Microsoft Entra ID by sending a POST request to the /groups endpoint.

**API endpoints:**

POST `https://graph.microsoft.com/rp/scim/groups`

Upon success, the API returns HTTP Status 201.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `Group.Create` or `Group.ReadWrite.All` |

### Required attributes for Create a group

The following attributes are required for successful group creation:

- `displayName`

#### Example 1 – Create a new group

**Request:**

```http
POST https://graph.microsoft.com/rp/scim/groups
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:Group",
    "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group"
  ],
  "displayName": "Test SCIM Group",
  "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group": { 
    "mailEnabled": false, 
    "mailNickname": "test-scim-group", 
    "securityEnabled": true 
  }
}
```

**Response (201 Created):**

Returns the SCIM representation of the group created.

```json
{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:Group",
    "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group"
  ],
  "id": "66aa66aa-bb77-cc88-dd99-00ee00ee00ee",
  "displayName": "Test SCIM Group",
  "urn:ietf:params:scim:schemas:extension:Microsoft:Entra:2.0:Group": {
    "mailEnabled": false,
    "mailNickname": "test-scim-group",
    "securityEnabled": true,
    "securityIdentifier": "ffffffff-5a5a-6b6b-7c7c-888888888888"
  },
  "meta": {
    "created": "2026-03-30T16:28:37+00:00",
    "location": "/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee",
    "resourceType": "group"
  }
}
```

## Update a group

The `/groups` endpoint allows a PATCH request to be made for updating an existing group.

**API endpoints:**

PATCH `https://graph.microsoft.com/rp/scim/groups/{id}`

Upon success, the API returns HTTP Status 204.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `GroupMember.ReadWrite.All` or `Group.ReadWrite.All` for membership changes; `Group.ReadWrite.All` for group property changes. |

> [!NOTE]
> `GroupMember.ReadWrite.All` supports only requests that add or remove members. To update group properties such as `displayName` or `description`, grant `Group.ReadWrite.All`.

### Constraints for Update a group

- Adding members to groups must be done in a single PATCH **Operation** object.  

- When using the API to add multiple members in one request, you can add up to only 20 members. 

- Only one member can be removed from a group per PATCH call.  

- Removing group members must be done without any other attribute changes included in the same PATCH call (including adding members).  

- Adding members to groups must be done without any other attribute changes (including removing members).  

- Add group members is treated as an **idempotent** operation. If a specific member is already present in the group, then no error is returned, and the operation succeeds as long as all group **memberIds** point to valid user objects.

- If a **memberId** passed either in group membership add or remove operation is invalid, then the entire operation fails with the error message ```“Resource '00000000-0000-0000-0000-000000000000'``` does not exist or one of its queried reference-property objects are not present.”

#### Example 1 – Update Group display name

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [ "urn:ietf:params:scim:api:messages:2.0:PatchOp" ],
  "operations": [
    {
      "op": "replace",
      "path": "displayName",
      "value": "SCIM Testing Group Edited"
    }
  ]
}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 2 – Update Group description

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 3 – Add Group members

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee
Authorization: Bearer {token}
Content-Type: application/scim+json
```

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

**Response (204 No Content):**

The response conforms to SCIM specification.

#### Example 4 – Remove Group members

**Request:**

```http
PATCH https://graph.microsoft.com/rp/scim/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee
Authorization: Bearer {token}
Content-Type: application/scim+json
```

```json
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:PatchOp"
  ],
  "Operations": [
    {
      "op": "remove",
      "path": "members[value eq \"aaaaaaaa-6666-7777-8888-bbbbbbbbbbbb\"]"
    }
  ]
}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

## Delete a group

A group can be deleted by making a DELETE request to the /groups endpoint with an existing group ID.

**API endpoints:**

DELETE `https://graph.microsoft.com/rp/scim/groups/{id}`

Upon success, the API returns HTTP Status 204.

### Permissions

| Permission type | Permissions (least to most privileged) |
|---|---|
| Application | `Group.ReadWrite.All` |

#### Example 1 – Delete a group

**Request:**

```http
DELETE https://graph.microsoft.com/rp/scim/groups/66aa66aa-bb77-cc88-dd99-00ee00ee00ee
Authorization: Bearer {token}
```

**Response (204 No Content):**

The response conforms to SCIM specification.

## Related content

- [Enable the SCIM Provisioning API in Microsoft Entra ID](enable-scim-api.md)
- [SCIM support in Microsoft Entra ID](scim-support-in-entra-id.md)
- [Troubleshoot Microsoft Entra ID SCIM API errors](troubleshoot-scim-api-errors.md)
---
title: User default permissions in customer tenants
description: Learn about the default permissions for users in a customer tenant.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: reference
ms.date: 05/01/2023
ms.author: mimart
ms.custom: it-pro
---

# Default user permissions in customer tenants

A customer tenant provides clear separation between your corporate workforce directory and your customer-facing app directory. Furthermore, users created in your customer tenant are restricted from accessing information about other users in the customer tenant. By default, customers can’t access information about other users, groups, or devices.

The following table describes the default permissions assigned to a customer.

| **Area** | **Customer user permissions** |
| ------------ | --------- |
| Users and contacts | - Read and update their own profile through the app profile management experience  <br>- Change their own password <br>- Sign in with a local or social account |
| Applications | - Access customer-facing applications <br>- Revoke consent to applications |

## Microsoft Graph APIs and permissions

The following table indicates the API operations that enable customers to manage their profile information. The user ID or userPrincipalName is always the signed-in user's.

| User operation  | API operation                                           | Permissions required       |
|-----------------|---------------------------------------------------------|----------------------------|
| Read profile    | [GET /me](/graph/api/user-get) or [GET /users/{id or userPrincipalName}](/graph/api/user-get)     | User.Read                  |
| Update profile  | [PATCH /me](/graph/api/user-update) or [PATCH /users/{id or userPrincipalName}](/graph/api/user-update) <br/><br/> The following properties are updatable: city, country, displayName, givenName, jobTitle, postalCode, state, streetAddress, surname, and preferredLanguage | User.ReadWrite             |
| Change password | [POST /me/changePassword](/graph/api/user-changepassword)   | Directory.AccessAsUser.All |

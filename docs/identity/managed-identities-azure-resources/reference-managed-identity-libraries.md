---
title: Client libraries for managed identities authentication
description: Get to know the client libraries that you can use to authenticate your apps using managed identities for Azure resources.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: reference
ms.date: 11/11/2024
ms.author: shermanouko
ms.reviewer: rwike77

#Customer intent: As a developer, I'd like to know the available libraries that I can use when authenticating my apps using managed identities.
---

# Client libraries for managed identities authentication

This document provides an overview of the client libraries available for authenticating your applications using managed identities for Azure resources. These libraries include the Azure Identity libraries and Microsoft Authentication Libraries (MSAL). This article focuses on accessing resources using these two libraries.

Some Azure services have built client libraries on top of these libraries. For example, the `Microsoft.Data.SqlClient` package can be used to authenticate to an Azure SQL database using managed identities.

## Choosing the right library

MSAL libraries offer lower-level APIs that are closer to the OAuth2 and OIDC protocols. Both MSAL and Azure SDK allow you to acquire tokens via managed identity. Internally, Azure SDK uses MSAL and provides a higher-level API through its `DefaultAzureCredential` and `ManagedIdentityCredential` abstractions.

- If your application already uses one of the SDKs, continue using the same SDK.
- Use Azure SDK if you are developing a new application and plan to call other Azure resources. This SDK provides a better developer experience by allowing the app to run on private developer machines where managed identity doesn't exist.
- Use MSAL if you need to call other downstream web APIs like Microsoft Graph or your own web API.

In cases where an Azure service has built a client library on top of these libraries, consider using the service-specific client library. For example, for Azure SQL, use the [`Microsoft.Data.SqlClient`](/sql/connect/ado-net/sql/azure-active-directory-authentication#using-managed-identity-authentication) package.

## Language-Specific API References

| Language | Azure Identity | MSAL |
|----------|----------------|------|
| .NET | [Azure Identity client library for .NET](/dotnet/api/overview/azure/identity-readme#managed-identity-support) | [MSAL .NET](/entra/msal/dotnet/advanced/managed-identity) |
| Java | [Azure Identity client library for Java](/java/api/overview/azure/identity-readme#managed-identity-support) | [MSAL Java](/entra/msal/java/advanced/managed-identity) |
| JavaScript | [Azure Identity client library for JavaScript](/javascript/api/overview/azure/identity-readme#managed-identity-support) | [MSAL JavaScript](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/docs/managed-identity.md) |
| Python | [Azure Identity client library for Python](/python/api/overview/azure/identity-readme#managed-identity-support) | [MSAL Python](/entra/msal/python/advanced/managed-identity) |
| Go | Work in progress | Work in progress |

---
title: Client libraries for managed identities authentication
description: Get to know the client libraries that you can use to authenticate your apps using managed identities for Azure resources.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: overview
ms.date: 11/11/2024
ms.author: shermanouko
ms.reviewer: rwike77


#Customer intent: As a developer, I'd like to know the available libraries that I can use when authenticating my apps using managed identities.
---

# Client libraries for managed identities authentication

We provide you with two client libraries to help you authenticate your apps with managed identities for Azure resources. These libraries are available in multiple languages.These libraries are Azure identity libraires and Microsoft Authentication Libraries (MSAL) This article only covers accessing resources using the two libraries. For more info on other ways of accessing resources using managed identities, see []().

It's important to note that certain Azure service have built client libraries on top of these libraries. For example, you can use the `Microsoft.Data.SqlClient` package to authenticate to an Azure SQL database using managed identities.

## Which library should I use?

MSAL libraries provide lower level APIs that are closer to the OAuth2 and OIDC protocols. Both MSAL and Azure SDK allow you to acquire tokens via managed identity. Internally, Azure SDK uses MSAL, and it provides a higher-level API via its `DefaultAzureCredential` and `ManagedIdentityCredential` abstractions.

- If your application already uses one of the SDKs, continue using the same SDK.
- Use Azure SDK if you are writing a new application and plan to call other Azure resources, as this SDK provides a better developer experience by allowing the app to run on private developer machines where managed identity doesn't exist.
- Use MSAL if you need to call other downstream web APIs like Microsoft Graph or your own web API.

In cases where an Azure service has built a client library on top of these libraries, you should consider using the service specific client library where possible. For example in the case of Azure SQL, you should use the [`Microsoft.Data.SqlClient`](/sql/connect/ado-net/sql/azure-active-directory-authentication?view=sql-server-ver16#using-managed-identity-authentication) package.

## Azure identity library API references

| Language | Reference |
|----------|-----------|
| .NET | [Azure Identity client library for .NET](/dotnet/api/overview/azure/identity-readme?view=azure-dotnet#managed-identity-support) |
| Java | [Azure Identity client library for Java](/java/api/overview/azure/identity-readme?view=azure-java-stable#managed-identity-support) |
| JavaScript | [Azure Identity client library for JavaScript](/javascript/api/overview/azure/identity-readme?view=azure-node-latest#managed-identity-support) |
| Python | [Azure Identity client library for Python](/python/api/overview/azure/identity-readme?view=azure-python#managed-identity-support) |
| Go | This is still a work in progress |

## MSAL API references

| Language | Reference |
|----------|-----------|
| .NET | [MSAL .NET](/entra/msal/dotnet/advanced/managed-identity) |
| Java | [MSAL Java](/entra/msal/java/advanced/managed-identity) |
| JavaScript | [MSAL JavaSccript](https://azuresdkdocs.blob.core.windows.net/$web/javascript/msal/1.0.0/classes/publicclientapplication.html) |
| Python | [MSAL Python](/entra/msal/python/advanced/managed-identity) |
| Go | This is still a work in progress |

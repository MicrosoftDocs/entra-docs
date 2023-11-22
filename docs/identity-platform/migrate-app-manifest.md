---
title: Migrate to Microsoft Graph format app manifest
description: 
services: active-directory
author: rwike77
manager: CelesteDG
ms.service: active-directory
ms.subservice: develop
ms.topic: reference
ms.workload: identity
ms.date: 11/13/2023
ms.author: ryanwi
ms.custom: aaddev
ms.reviewer: sureshja
---

# Migrate your app manifest to Microsoft Graph format

Azure Active Directory (Azure AD) Graph is deprecated and you must migrate your app and app manifest from Azure AD Graph format to Microsoft Graph format.  Microsoft Graph is our latest offering and represents our best-in-breed API surface. To learn more about Azure AD Graph deprecation, please read [Migrate your apps to Microsoft Graph](/graph/migrate-azure-ad-graph-overview).

## Migration date

On [date], the **App registrations** manifest page in the Microsoft Entra Admin center launched a new tabbed experience that allows you to view, edit, upload, download the app manifest in both Azure AD Graph format and Microsoft Graph format.

[Screenshot]

Starting [date], you won't be able to view, save, upload or download the Azure AD Graph app manifest in the **App registrations** manifest page in the Microsoft Entra Admin center.

## How does manifest migration impact the user experience?

If you do not view, edit or save app manifests, this migration doesn't impact your workflow.

If you view or edit app manifests, you will notice the [attribute differences between Azure AD Graph format and Microsoft Graph format](#attribute-differences-between-azure-ad-graph-and-microsoft-graph-formats). We recommend that you start viewing and editing app manifests following the [Microsoft Graph format reference](/entra/identity-platform/reference-microsoft-graph-app-manifest).

If your workflow requires you to save the manifests in your source repository for use later, you will need to [convert an app manifest in Azure AD Graph format to Microsoft Graph format](#convert-an-app-manifest-in-azure-ad-graph-format-to-microsoft-graph-format).

## Attribute differences between Azure AD Graph and Microsoft Graph formats

Most Azure AD Graph app manifest attributes stay the same. However, the following Azure AD Graph app manifest attributes have been deprecated, renamed, or relocated in the Microsoft Graph manifest.

| Azure AD manifest attribute | Microsoft Graph manifest |
| --- | --- |
| `acceptMappedClaims` | Relocated as `acceptMappedClaims` property of the `api` attribute |
| `accessTokenAcceptedVersion` | Relocated and renamed as `requestedAccessTokenVersion` property of the `api` attribute |
| `allowPublicClient` | Renamed as `isFallbackPublicClient` |
| `errorUrl` | Deprecated/no longer support |
| `informationalUrls` | Renamed as `info` |
| `knownClientApplications` | Relocated as a property of the `api` attribute |
| `logoUrl` | Relocated as a property of the `info` attribute |
| `logoutUrl` | Relocated as property `logoutUrl` of the `web` attribute |
| `name` | `displayName` |
| `oauth2AllowIdTokenImplicitFlow` | Relocated and renamed as property `enableAccessTokenIssuance` of property `enableIdTokenIssuance` in the `web` attribute |
| `oauth2AllowImplicitFlow` | Relocated and renamed as property `enableAccessTokenIssuance` of property `implicitGrantSettings`  in the `web` attribute |
| `oauth2Permissions` | Relocated and renamed as `oauth2PermissionScopes` property of the `api` attribute |
| `preAuthorizedApplications` | Relocated as `preAuthorizedApplications` property of the `api` attribute |
| `replyUrlsWithType` | Renamed as property `redirectUris` in multiple attributes: `web` attribute, `spa` attribute, `publicClient` attribute |
| `signInUrl` | Relocated and renamed as property `homePageUrl` of the `web` attribute |

## How do I tell if I have an Azure AD Graph app manifest or Microsoft Graph app manifest?

You can tell whether an app manifest is an Azure AD Graph format or Microsoft Graph format by the attributes it contains. For example,

- If an app manifest has the attribute `replyUrlsWithType`, then it is in Azure AD Graph format.

- If an app manifest has the attribute `implicitGrantSettings`, it is in Microsoft Graph format.

## Convert an app manifest in Azure AD Graph format to Microsoft Graph format

If you have stored an app manifest in Azure AD Graph format and want to convert it to Microsoft Graph formt:

Between [date1] and [date2], you can follow the steps below and use the portal to convert an app manifest in Azure AD Graph format to Microsoft format:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Application Developer](/entra/identity/role-based-access-control/permissions-reference#application-developer). 

1. Browse to **Identity** > **Applications** > **App registrations**.

1. Select **New registration** and create a new app registration.

2. In the **Manifest** page for that application, select **Azure AD Graph app manifest** tab.

4. Upload the app manifest in Azure AD Graph format that you have.

5. Select the **Microsoft Graph app manifest** tab.

6. Select **download**.

Starting [date2], the Microsoft Entra admin center will no longer support app manifests in Azure AD Graph format. However, you can perform the conversion manually.

1. Browse to **Identity** > **Applications** > **App registrations**.

1. Select **New registration** and create a new app registration.

1. Go through each attribute in Azure AD Graph formatted app manifest one by one and edit the corresponding attribute in the Microsoft Graph formatted app manifest to match its value.

    1. If the attribute is listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest](link), you need to understand the syntax and semantics of old and new attributes so that you can successfully edit the new attribute's value in Microsoft Graph app manifest.

    1. If the attribute is not listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest](link) but you cannot find a corresponding attribute in Microsoft Graph app manifest, this attribute is likely to have been deprecated and you can discard this attribute.

    1. For all other attributes, you can copy the value of the attribute in Azure AD Graph app manifest and paste it into the value of the attribute in Microsoft Graph app manifest.

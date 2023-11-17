---
title: Migrate to Microsoft Graph app manifest
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

# Migrate to Microsoft Graph app manifest

This migration is due to the fact that Azure Active Directory (Azure AD) Graph is deprecated. Microsoft Graph is our latest offering and represents our best-in-breed API surface. To learn more about Azure AD Graph
deprecation, please read [Migrate your apps from Azure AD Graph to Microsoft
Graph](/graph/migrate-azure-ad-graph-overview)

## Migration date

On [date], Entra App Registration manifest page launched a new tabbed experience that allows you to view, edit, upload, download both  Azure AD Graph app manifest and Microsoft Graph app manifest.

[Screenshot]

Starting [date], you won't be able to view, save, upload or download Azure AD Graph app manifest in Entra App Registration.

## How does manifest migration impact the user experience?

If you do not view, edit or save app manifests, then this migration doesn't impact your workflow.

If you view or edit app manifests, you will notice the [attribute differences between Azure AD Graph manifest and Microsoft Graph app manifests](link). You recommend that you start viewing and editing Microsoft Graph app manifests following the [manifest reference](link) of Microsoft Graph App Registration manifest.

If your workflow requires you to save the manifests in your source repository for use later, you will need to [convert an Azure AD Graph app manifest to Microsoft Graph app manifest](link).

## Attribute differences between Azure AD Graph manifest and Microsoft Graph app manifest

Most Azure AD Graph app manifest attributes stay the same. However, the following Azure AD Graph app manifest attributes have been deprecated, renamed, or relocated in Microsoft Graph manifest.

| Azure AD manifest attribute | Microsoft Graph manifest |
| --- | --- |
| acceptMappedClaims | Relocated as "acceptMappedClaims" property of the "api" attribute |
| accessTokenAcceptedVersion | Relocated and renamed as "requestedAccessTokenVersion" property of the "api" attribute |
| allowPublicClient | Renamed as "isFallbackPublicClient" |
| errorUrl | Deprecated/no longer support |
| informationalUrls | Renamed as "info" |
| knownClientApplications | Relocated as a property of the "api" attribute |
| logoUrl | Relocated as a property of the "info" attribute |
| logoutUrl | Relocated as property "logoutUrl" of the "web" attribute |
| name | displayName |
| oauth2AllowIdTokenImplicitFlow | Relocated and renamed as property "enableAccessTokenIssuance" of property "enableIdTokenIssuance" in the "web" attribute |
| oauth2AllowImplicitFlow | Relocated and renamed as property "enableAccessTokenIssuance" of property "implicitGrantSettings " in the "web" attribute |
| oauth2Permissions | Relocated and renamed as "oauth2PermissionScopes" property of the "api" attribute |
| preAuthorizedApplications | Relocated as "preAuthorizedApplications" property of the "api" attribute |
| replyUrlsWithType | Renamed as property "redirectUris" in multiple attributes: "web" attribute, "spa" attribute, "publicClient" attribute |
| signInUrl | Relocated and renamed as property "homePageUrl" of the "web" attribute |

## How do I tell if I have an Azure AD Graph app manifest or Microsoft Graph app manifest?

You can tell whether an app manifest is an Azure AD Graph app manifest or Microsoft Graph app manifest by the attributes it contains. For example,

- If an app manifest has the attribute "replyUrlsWithType", then it must be an Azure AD Graph app manifest.

- If an app manifest has the attribute "implicitGrantSettings", it must be a Microsoft Graph app manifest.

## How to convert an Azure AD Graph app manifest to Microsoft Graph app manifest?

If you have stored an Azure AD Graph app manifest and want to convert it to Microsoft Graph app manifest:

Between [date1] and [date2], you can follow the steps below and use the portal to convert an Azure AD Graph app manifest to Microsoft app manifest:

1. Create a new app registration

2. Go to manifest page

3. Select Azure AD Graph App Manifest tab

4. Use upload button to upload the Azure AD Graph app manifest you have

5. Select Microsoft Graph App Manifest tab

6. Select download

Starting [date2], the Entra app registration portal will no longer support Azure AD Graph app manifest. However, you can perform the conversion manually.

1. Create a new app registration in the portal

2. Go through each attribute in Azure AD Graph app manifest one by one and edit the corresponding attribute in Microsoft Graph app manifest to match its value

    a.  If the attribute is listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest] (link), you need to understand the syntax and semantics of old and new attributes so that you can successfully edit the new attribute's value in Microsoft Graph app manifest.

    b.  If the attribute is not listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest] (link) but you cannot find a corresponding attribute in Microsoft Graph app manifest, this attribute is likely to have been deprecated and you can discard this attribute.

    c.  For all other attributes, you can copy the value of the attribute in Azure AD Graph app manifest and paste it into the value of the attribute in Microsoft Graph app manifest.

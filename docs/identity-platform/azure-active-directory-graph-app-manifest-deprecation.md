---
title: App manifest (Azure AD Graph format) deprecation
description: Describes the deprecation of the app manifest (Azure AD Graph format) and attribute differences in the new format.
author: rwike77
manager: CelesteDG
ms.service: identity-platform
ms.topic: concept-article
ms.workload: identity
ms.date: 09/18/2024
ms.author: ryanwi
ms.custom: aaddev
ms.reviewer: 

# Customer intent: As an application developer, I want to learn about the new app manifest format, so that I can update the application object and define permissions and roles for the app.
---

# App manifest (Azure AD Graph format) deprecation

Following the Azure AD Graph deprecation, the Azure AD Graph format of application manifests is deprecated and the Microsoft Entra admin center displays app manifests in Microsoft Graph format.  Read this article to learn more about how the app manifest migration impacts your user experience.

> [!IMPORTANT] 
> Apps registered with your personal Microsoft account (MSA account) are not in scope for this deprecation. Apps registered with your personal MSA account will continue to manage app manifests in the Azure AD Graph format in the Microsoft Entra admin center until further notice.

## Migration date

From June 13 to September 16 2024, the **App registrations** manifest page in the Microsoft Entra admin center launched a new tabbed experience that allows you to view, edit, upload, download the app manifest in both Azure AD Graph format and Microsoft Graph format.

> [!IMPORTANT] 
> The new tabbed experience is rolling out to Microsoft Entra users in batches to ensure the quality of your experience.  You may not see the new experience immediately.

Starting January 7 2025, you won't be able to view, save, upload, or download the Azure AD Graph app manifest in the **App registrations** manifest page in the Microsoft Entra admin center.

## How does app manifest migration impact your user experience?

If you don't view, edit, or save app manifests, this migration doesn't impact your workflow.

If you view or edit app manifests, you notice the [attribute differences between Azure AD Graph format and Microsoft Graph format](#attribute-differences-between-azure-ad-graph-and-microsoft-graph-formats). We recommend that you start viewing and editing app manifests following the [Microsoft Graph format reference](reference-microsoft-graph-app-manifest.md).

If your workflow requires you to save the manifests in your source repository for use later, you need to [convert an app manifest in Azure AD Graph format to Microsoft Graph format](#convert-an-app-manifest-in-azure-ad-graph-format-to-microsoft-graph-format).

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
| `trustedCertificateSubjects` | This is a Microsoft internal property. The portal shows v1.0 version of MS Graph app manifest while this property is only present in beta version of MS Graph app manifest. Continue to edit this property using Azure AD Graph app manifest in Microsoft Entra admin center. We will expose MS Graph app manifest beta version in Microsoft Entra admin center before deprecating Azure AD Graph app manifest |

## How do I tell the format of my app manifest?

You can tell whether an app manifest is an Azure AD Graph format or Microsoft Graph format by the attributes it contains. For example,

- If an app manifest has the attribute `replyUrlsWithType`, then it is in Azure AD Graph format.

- If an app manifest has the attribute `implicitGrantSettings`, it is in Microsoft Graph format.

## Convert an app manifest in Azure AD Graph format to Microsoft Graph format

If you have stored an app manifest in Azure AD Graph format and want to convert it to Microsoft Graph format:

Between June 13 2024 and January 7 2025, you can follow the steps below and use the portal to convert an app manifest in Azure AD Graph format to Microsoft format:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Application Developer](/entra/identity/role-based-access-control/permissions-reference#application-developer). 

1. Browse to **Entra ID** > **App registrations**.

1. Select **New registration** and create a new app registration.

2. In the **Manifest** page for that application, select **Azure AD Graph app manifest** tab.

4. Upload the app manifest in Azure AD Graph format that you have.

5. Select the **Microsoft Graph app manifest** tab.

6. Select **download**.

Starting January 7 2025, the Microsoft Entra admin center will no longer support app manifests in Azure AD Graph format. However, you can perform the conversion manually.

1. Browse to **Entra ID** > **App registrations**.

1. Select **New registration** and create a new app registration.

1. An app manifest is created in the new format with default values.

1. Go through each attribute in Azure AD Graph formatted app manifest one by one and edit the corresponding attribute in the Microsoft Graph formatted app manifest to match its value.

    1. If the attribute is listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest](#attribute-differences-between-azure-ad-graph-and-microsoft-graph-formats), you need to understand the syntax and semantics of old and new attributes so that you can successfully edit the new attribute's value in Microsoft Graph app manifest.

    1. If the attribute isn't listed in [Attribute differences between Azure AD Graph manifest and Microsoft Graph manifest](#attribute-differences-between-azure-ad-graph-and-microsoft-graph-formats) but you can't find a corresponding attribute in Microsoft Graph app manifest, this attribute is likely to have been deprecated and you can discard this attribute.

    1. For all other attributes, you can copy the value of the attribute in Azure AD Graph app manifest and paste it into the value of the attribute in Microsoft Graph app manifest.

## Next steps

Learn about the [app manifest (Microsoft Graph format)](reference-microsoft-graph-app-manifest.md)

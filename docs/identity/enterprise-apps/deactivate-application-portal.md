---
title: Deactivate an enterprise application
description: Learn how to deactivate an enterprise application in Microsoft Entra ID to prevent token issuance while preserving application configuration.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 11/25/2025
ms.author: jomondi
ms.reviewer: ariels
ms.custom: enterprise-apps, no-azure-ad-ps-ref, sfi-image-nochange
#Customer intent: As an IT admin, I want to immediately stop a suspicious or unused application from accessing resources in my organization while keeping all its settings intact so I can investigate potential security issues and easily restore access if needed.
---

# Deactivate an enterprise application

Deactivating an enterprise application provides a reversible way to prevent the application from accessing protected resources without permanently removing it from your tenant. When you deactivate an application, it immediately stops receiving new access tokens, but existing tokens remain valid until they expire. This approach is useful for security investigations, temporary suspension of suspicious applications, or when you need to maintain application configuration data.

Unlike permanently deleting an application, deactivation preserves all application metadata, permissions, and configuration settings, making it easy to reactivate the application if needed. The application remains visible in your tenant's enterprise applications list, but users can't sign in and no new tokens are issued.

This article shows you how to deactivate an enterprise application, view deactivated applications, and reactivate them when necessary.

## Prerequisites

Before you can deactivate an application, ensure you meet the following requirements:

- One of the following Microsoft Entra roles:
    - [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator)  
    - [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator)
- The following API permissions if using Microsoft Graph:
    - `Application.ReadWrite.All` (delegated or application)
    - `Application.ReadWrite.OwnedBy` (application, for owned apps only)

## Understand application deactivation

When an application is deactivated, the following behavior occurs:

- Immediate effects:

    - New access token requests are denied
    - Users can't sign in to the application
    - Application can't access protected resources with new tokens

- Preserved elements:
    - Existing access tokens remain valid until their configured lifetime expires
    - Application configuration, permissions, and metadata are preserved
    - Application remains visible in Enterprise applications list
    - Service principal object is maintained in the tenant

When users attempt to sign in to a deactivated application, they receive an error message indicating the application has been disabled by its owner. This is different from other error messages like invalid credentials or access denied.

### Comparison with other options

Microsoft Entra apps and service principals can be prevented from usage in four ways:

- **isDisabled** (deactivate) property is set on apps that have been disabled globally by the app owner or administrator.
- **disabledByMicrosoftStatus** (disabled by Microsoft) property is set on apps that have been disabled globally by Microsoft.
- **accountEnabled** (disable sign-in) property is set on service principals disabled in the tenant by the app owner or administrator.
- **DELETE** (delete) operation is completed as an operation on apps or service principals by the app owner or administrator.

The following table outlines the different approaches in more detail:

| Action | Token issuance | Configuration preserved | Reversible | Scope |
|--------|---------------|------------------------|------------|-------|
| Deactivate | Blocked | Yes | Yes | Global (all tenants) |
| Disabled by Microsoft | Blocked | Yes | Yes | Global (all tenants) |
| Disable sign-in | Blocked in tenant | Yes | Yes | Single tenant only |
| Delete | Blocked | No (30-day recycle bin) | Yes (30 days) | Global |

## Deactivate an application

To deactivate an application using Microsoft Graph API, you need at least **[Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator)** role.

1. Deactivate the application

    ```http
    PATCH https://graph.microsoft.com/beta/applications/{applicationObjectId}
    Content-Type: application/json

    {
        "isDisabled": true
    }
    ```

1. Verify deactivation
 
    ```http
    GET https://graph.microsoft.com/beta/applications/{applicationObjectId}
    ```

    The response includes `"isDisabled": true`.

## View deactivated applications

1. List all deactivated applications

    ```http
    GET https://graph.microsoft.com/beta/applications?$filter=isDisabled eq true
    ```

1. Get specific application status

    ```http
    GET https://graph.microsoft.com/beta/applications/{applicationObjectId}?$select=displayName,isDisabled,appId
    ```

## Investigate deactivated applications

When handling deactivated applications, conduct a thorough investigation by examining the application's configuration, including API permissions, authentication settings, certificates, and sign-in logs. Document your findings carefully, noting the reason for deactivation, any suspicious activity or security concerns, affected users, and dependencies that might impact your organization.

Based on your investigation, take appropriate action such as escalating to security teams if compromise is suspected, removing unnecessary permissions before reactivation, or updating the application configuration to address identified security issues. If the application is no longer needed or poses ongoing security risks, consider permanent deletion instead of reactivation.

## Reactivate an application

To reactivate an application using Microsoft Graph API, you need at least **[Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator)** role.

1. Reactivate the application

    ```http
    PATCH https://graph.microsoft.com/v1.0/applications/{application-id}
    Content-Type: application/json

    {
        "isDisabled": false
    }
    ```

1. Verify reactivation

    ```http
    GET https://graph.microsoft.com/v1.0/applications/{application-id}?$select=displayName,isDisabled
    ```

    The response shows `"isDisabled": false`.

## Prevent reactivation by nonadministrators

Before deactivating the application, remove all owners from the application. This ensures only users with tenant-wide `microsoft.directory/applications/enable` scope can reactivate the application. This scope is restricted to administrative roles.

## Related content

- [Delete an enterprise application](delete-application-portal.md) for permanent removal
- [Disable user sign-in](disable-user-sign-in-portal.md) for tenant-specific blocking
- [Restore an enterprise application](restore-application.md) from the recycle bin
- [Monitor application usage](../monitoring-health/concept-audit-logs.md) with audit logs

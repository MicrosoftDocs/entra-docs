---
title: 'Restore a soft deleted enterprise application'
description: Restore a soft deleted enterprise application in Microsoft Entra ID.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to

ms.date: 03/19/2024
ms.author: jomondi
ms.reviewer: sureshja
ms.custom: enterprise-apps, has-azure-ad-ps-ref
zone_pivot_groups: enterprise-apps-minus-portal

#Customer intent: As an IT admin managing enterprise applications in Microsoft Entra ID, I want to restore a soft deleted enterprise application, so that I can recover its previous configurations and policies within the 30-day window after deletion.
---

# Restore an enterprise application in Microsoft Entra ID

In this article, you learn how to restore a soft deleted enterprise application in your Microsoft Entra tenant. Soft deleted enterprise applications can be restored from the recycle bin within the first 30 days after their deletion. After the 30-day window, the enterprise application is permanently deleted and can't be restored.

If you deleted an [application registration](~/identity-platform/howto-remove-app.md) in its home tenant through app registrations in the Microsoft Entra admin center, the enterprise application, which is its corresponding service principal also got deleted. 

If you restore the deleted application registration through the Microsoft Entra admin center, its corresponding service principal, is also restored. You'll therefore be able to recover the service principal's previous configurations, except its previous policies such as Conditional Access policies, which aren't restored.

## Prerequisites

To restore an enterprise application, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal.
- A [soft deleted enterprise application](delete-application-portal.md) in your tenant.

Take the following steps to recover a recently deleted enterprise application. For more information on frequently asked questions about deletion and recovery of applications, see [Deleting and recovering applications FAQs](delete-recover-faq.yml).

:::zone pivot="aad-powershell"

## View restorable enterprise applications using Azure AD PowerShell

Make sure you're using the Azure AD PowerShell module. This is important if you've installed both the [Azure AD PowerShell](/powershell/module/azuread/?preserve-view=true&view=azureadps-2.0) module and the AzureADPreview module. 

You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Run the following commands.

    ```powershell
    Remove-Module AzureADPreview
    Import-Module AzureAD
    ```

1. Connect to Azure AD PowerShell.

   ```powershell
   Connect-AzureAD
   ```

1. Run the following command to view the recently deleted enterprise application.

   ```powershell
   Get-AzureADMSDeletedDirectoryObject -Id <id>
   ```

Replace ID with the object ID of the service principal that you want to restore.

:::zone-end

:::zone pivot="ms-powershell"

## View restorable enterprise applications using Microsoft Graph PowerShell

1. Run `connect-MgGraph -Scopes "Application.ReadWrite.All"`. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. To view the recently deleted enterprise applications, run the following command.

   ```powershell
   Get-MgDirectoryDeletedItem -DirectoryObjectId <id>
   ```

Replace ID with the object ID of the service principal that you want to restore.

:::zone-end

:::zone pivot="ms-graph"

## View restorable enterprise applications using Microsoft Graph API

View and restore recently deleted enterprise applications using [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer). You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

To get the list of deleted enterprise applications in your tenant, run the following query.

   ```http
   GET https://graph.microsoft.com/v1.0/directory/deletedItems/microsoft.graph.servicePrincipal
   ```

From the list of deleted service principals generated, record the ID of the enterprise application you want to restore.

Alternatively, if you want to get the specific enterprise application that was deleted, fetch the deleted service principal and filter the results by the client's application ID (appId) property using the following syntax:

`https://graph.microsoft.com/v1.0/directory/deletedItems/microsoft.graph.servicePrincipal?$filter=appId eq '{appId}'`. Once you retrieved the object ID of the deleted service principal, proceed to restore it.

:::zone-end

:::zone pivot="aad-powershell"

## Restore an enterprise application using Azure AD PowerShell

1. To restore the enterprise application, run the following command:

   ```powershell  
   Restore-AzureADMSDeletedDirectoryObject -Id <id>
   ```

Replace ID with the object ID of the service principal that you want to restore.

:::zone-end

:::zone pivot="ms-powershell"

## Restore an enterprise application using Microsoft Graph PowerShell

1. To restore the enterprise application, run the following command:

   ```powershell
   Restore-MgDirectoryDeletedItem -DirectoryObjectId <id>
   ```

Replace ID with the object ID of the service principal that you want to restore.

:::zone-end

:::zone pivot="ms-graph"

## Restore an enterprise application using Microsoft Graph API

To restore the enterprise application, run the following query:

   ```http
   POST https://graph.microsoft.com/v1.0/directory/deletedItems/{id}/restore
   ```

Replace ID with the object ID of the service principal that you want to restore.

:::zone-end

Soft-deleted managed identity service principals can be viewed but can't be recovered or permanently deleted by customers.

>[!WARNING]
> Permanently deleting an enterprise application is an irreversible action. Any present configurations on the app will be completely lost. Carefully review the details of the enterprise application to be sure you still want to hard delete it.

:::zone pivot="aad-powershell"

## Permanently delete an enterprise application using Azure AD PowerShell

To permanently delete a soft deleted enterprise application, run the following command:

```powershell
Remove-AzureADMSDeletedDirectoryObject -Id <id>

```

:::zone-end

:::zone pivot="ms-powershell"

## Permanently delete an enterprise application using Microsoft Graph PowerShell

1. To permanently delete the soft deleted enterprise application, run the following command:

   ```powershell
   Remove-MgDirectoryDeletedItem -DirectoryObjectId <id>
   ```

:::zone-end

:::zone pivot="ms-graph"

## Permanently delete an enterprise application using Microsoft Graph API

To permanently delete a soft deleted enterprise application, run the following query in Microsoft Graph explorer.

```http
DELETE https://graph.microsoft.com/v1.0/directory/deletedItems/{object-id}
```

:::zone-end

## Next steps

- [Recovery and deletion FAQ](delete-recover-faq.yml)
- [Applications and service principals](~/identity-platform/app-objects-and-service-principals.md)

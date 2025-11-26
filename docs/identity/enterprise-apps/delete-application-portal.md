---
title: Delete an enterprise application
description: Delete an enterprise application in Microsoft Entra ID.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 03/06/2025
ms.author: jomondi
ms.reviewer: sureshja
zone_pivot_groups: enterprise-apps-all
ms.custom: enterprise-apps, no-azure-ad-ps-ref, sfi-image-nochange
#Customer intent: As an IT admin, I want to delete an enterprise application from my Microsoft Entra tenant, so that I can remove unnecessary applications and manage my tenant efficiently.
---

# Delete an enterprise application

In this article, you learn how to delete an enterprise application that was added to your Microsoft Entra tenant.

When you delete and enterprise application, it remains in a suspended state in the recycle bin for 30 days. During the 30 days, you can [Restore the application](restore-application.md). Deleted items are automatically hard deleted after the 30-day period. For more information on frequently asked questions about deletion and recovery of applications, see [Deleting and recovering applications FAQs](delete-recover-faq.yml).

## Prerequisites

To delete an enterprise application, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
   - One of the following roles: 
   - Cloud Application Administrator
   - Application Administrator
   - Owner of the service principal
- An [enterprise application added to your tenant](add-application-portal.md).

:::zone pivot="portal"

## Delete an enterprise application using Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps | All applications** 
1. Enter the name of the existing application in the search box, and then select the application from the search results. In this article, we use the **Microsoft Graph Command Line Tools** as an example.
1. In the **Manage** section of the left menu, select **Properties**.
1. At the top of the **Properties** pane, select **Delete**, and then select **Yes** to confirm you want to delete the application from your Microsoft Entra tenant.

    :::image type="content" source="media/delete-application-portal/delete-application.png" alt-text="screenshot of how to delete an enterprise application." lightbox="media/delete-application-portal/delete-application.png":::

:::zone-end

:::zone pivot="entra-powershell"

## Delete an enterprise application using Microsoft Entra PowerShell

Make sure you're using the [Microsoft Entra PowerShell](/powershell/entra-powershell/?preserve-view=true&view=entra-powershell) module.

1. Connect to Microsoft Entra PowerShell and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Get the application you want to delete by filtering by the application name, then delete the application.

   ```powershell
   Connect-Entra -Scopes 'Application.ReadWrite.All'
   Get-EntraServicePrincipal -Filter "displayName eq 'Test-app1'" | Remove-EntraServicePrincipal
   ```

:::zone-end

:::zone pivot="ms-powershell"

## Delete an enterprise application using Microsoft Graph PowerShell

1. Connect to Microsoft Graph PowerShell and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator):

   ```powershell
   Connect-MgGraph -Scopes 'Application.ReadWrite.All'
   ```

1. Get the list of enterprise applications in your tenant.

   ```powershell
   Get-MgServicePrincipal
   ```

1. Record the object ID of the enterprise app you want to delete.

1. Delete the enterprise application.

   ```powershell
   Remove-MgServicePrincipal -ServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222'
   ```

:::zone-end

:::zone pivot="ms-graph"

## Delete an enterprise application using Microsoft Graph API

To delete an enterprise application using [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), you need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. To get the list of service principals in your tenant, run the following query.

   ```http
   GET https://graph.microsoft.com/v1.0/servicePrincipals
   ```

2. Record the ID of the enterprise app you want to delete.
3. Delete the enterprise application.

   ```http
   DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipal-id}
   ```

:::zone-end

## Related content

- [Restore a deleted enterprise application](restore-application.md)

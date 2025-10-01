---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 03/14/2025
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom: sfi-image-nochange
---
<!-- zone pivots doesn't support YML files -->

## View the service principal for a managed identity using the Azure portal
    
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Browse to **Entra ID** > **Enterprise apps**.
1. In the **Manage** section select **All applications**.
1. Set a filter for "Application type == Managed Identities" and select **Apply**.
1. (Optional) In the search filter box, enter the name of the Azure resource that has system managed identities enabled or the name of the user assigned managed identity.

   :::image type="content" border="true" source="../media/how-to-view-managed-identity-service-principal-portal/view-managed-identity-service-principal-portal.png" alt-text="Screenshot of the View managed identity service principal."  lightbox="../media/how-to-view-managed-identity-service-principal-portal/view-managed-identity-service-principal-portal.png":::

## Next steps

For more information about managed identities, see [Managed identities for Azure resources](~/identity/managed-identities-azure-resources/overview.md).

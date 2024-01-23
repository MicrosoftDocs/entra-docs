---
title: Map directory extensions in cross-tenant synchronization
description: Learn how to map directory extensions in cross-tenant synchronization using the Microsoft Entra admin center.
services: active-directory
author: rolyon
manager: amycolannino
ms.service: active-directory
ms.workload: identity
ms.subservice: multi-tenant-organizations
ms.topic: how-to
ms.date: 07/21/2023
ms.author: rolyon
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to
---

# Map directory extensions in cross-tenant synchronization

Directory extensions enable you to extend the schema in Microsoft Entra ID with your own attributes. You can map these directory extensions when provisioning users in cross-tenant synchronization. [Custom security attributes](../../fundamentals/custom-security-attributes-overview.md) are not supported in cross-tenant synchronization.

This article describes how to map directory extensions in cross-tenant synchronization.

## Prerequisites

- [Hybrid Identity Administrator](../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role to configure cross-tenant synchronization.
- [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator) or [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role to assign users to a configuration and to delete a configuration.

## Create directory extensions

If you don't already have directory extensions, you must create one or more directory extensions in the source or target tenant. You can create extensions using Microsoft Entra Connect or Microsoft Graph API. For information on how to create directory extensions, see [Syncing extension attributes for Microsoft Entra Application Provisioning](../app-provisioning/user-provisioning-sync-attributes-for-mapping.md).

## Map directory extensions

![Icon for the source tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Source tenant**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) of the source tenant.

1. Browse to **Identity** > **External Identities** > **Cross-tenant synchronization**.

1. Select **Configurations** and then select your configuration.

1. Select **Provisioning** and expand the **Mappings** section.

    :::image type="content" source="./media/common/provisioning-mappings.png" alt-text="Screenshot that shows the Provisioning page with the Mappings section expanded." lightbox="./media/common/provisioning-mappings.png":::

1. Select **Provision Microsoft Entra ID Users** to open the **Attribute Mapping** page.

1. Scroll to the bottom of the page and select **Add new mapping**.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-new-mapping.png" alt-text="Screenshot that shows the Attribute Mappings page with the Add new mapping link." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-new-mapping.png":::

1. In the **Source attribute** drop-down list, select a source attribute.

    If you created a directory extension in the source tenant, select the directory extension.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-source-attribute.png" alt-text="Screenshot that shows the Edit attribute page with the directory extension listed in Source Attribute." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-source-attribute.png":::

1. In the **Target attribute** drop-down list, select a target attribute.

    If you created a directory extension in the target tenant, select the directory extension.

1. Select **Ok** to save the mapping.

## Troubleshooting tips

#### Symptom - Directory extension is not listed

When you try to select the directory extension on the **Edit attribute** page, it's not listed in the **Source attribute** or **Target attribute** drop-down lists.

**Cause 1**

The directory extension was not created successfully.

**Solution 1**

Make sure that the directory extension was created successfully.

**Cause 2**

The directory extension was not automatically discovered.

**Solution 2**

Follow these steps to manually add the directory extension to the schema.

1. Sign in to the Microsoft Entra admin center of the source tenant using the following link:

    https://entra.microsoft.com/?Microsoft_AAD_Connect_Provisioning_forceSchemaEditorEnabled=true

1. Browse to **Identity** > **External Identities** > **Cross-tenant synchronization**.

1. Select **Configurations** and then select your configuration.

1. Select **Provisioning** and expand the **Mappings** section.

1. Select **Provision Microsoft Entra ID Users** to open the **Attribute Mapping** page.

1. On the **Attribute Mapping** page, scroll to the bottom and select the **Show advanced settings** check box.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png" alt-text="Screenshot that shows the Attribute Mapping page with the advanced options." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png":::

1. If you created a directory extension in the source tenant, select the **Edit attribute list for Microsoft Entra ID** link.

1. If you created an extension in the target tenant, select the **Edit attribute list for Azure Active Directory (target tenant)** link.

1. Add the directory extension and select the appropriate options.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings-directory-extension.png" alt-text="Screenshot that shows the Attribute Mapping page with the advanced options." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings-directory-extension.png":::

1. Select **Save**.

1. Refresh the browser.

1. Browse to the **Attribute mappings** page and try to add the attribute as described earlier in this article.

## Next steps

- [Syncing extension attributes for Microsoft Entra Application Provisioning](../app-provisioning/user-provisioning-sync-attributes-for-mapping.md)
- [Configure cross-tenant synchronization](./cross-tenant-synchronization-configure.md)

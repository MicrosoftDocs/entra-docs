---
title: Map directory extensions in cross-tenant synchronization
description: Learn how to map directory extensions in cross-tenant synchronization using the Microsoft Entra admin center.
author: kenwith
manager: dougeby
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: how-to
ms.date: 01/30/2024
ms.author: kenwith
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# Map directory extensions in cross-tenant synchronization

Directory extensions enable you to extend the schema in Microsoft Entra ID with your own attributes. You can map these directory extensions when provisioning users in cross-tenant synchronization. [Custom security attributes](../../fundamentals/custom-security-attributes-overview.md) are different and aren't supported in cross-tenant synchronization.

This article describes how to map directory extensions in cross-tenant synchronization.

## Prerequisites

- [Hybrid Identity Administrator](../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role to configure cross-tenant synchronization.
- [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator) or [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role to assign users to a configuration and to delete a configuration.

## Create directory extensions

If you don't already have directory extensions, you must create one or more directory extensions in the source or target tenant. You can create extensions using Microsoft Entra Connect or Microsoft Graph API. For information on how to create directory extensions, see [Syncing extension attributes for Microsoft Entra Application Provisioning](../app-provisioning/user-provisioning-sync-attributes-for-mapping.md).

## Map directory extensions

![Icon for the source tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Source tenant**

Once you have one or more directory extensions, you can use them when mapping attributes in cross-tenant synchronization.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) of the source tenant.

1. Browse to **Entra ID** > **External Identities** > **Cross-tenant synchronization**.

1. Select **Configurations** and then select your configuration.

1. Select **Provisioning** and expand the **Mappings** section.

    :::image type="content" source="./media/common/provisioning-mappings.png" alt-text="Screenshot that shows the Provisioning page with the Mappings section expanded." lightbox="./media/common/provisioning-mappings.png":::

1. Select **Provision Microsoft Entra ID Users** to open the **Attribute Mapping** page.

1. Scroll to the bottom of the page and select **Add new mapping**.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-new-mapping.png" alt-text="Screenshot that shows the Attribute Mappings page with the Add new mapping link." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-new-mapping.png":::

1. In the **Source attribute** drop-down list, select a source attribute.

    If you created a directory extension in the source tenant, select the directory extension.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-source-attribute.png" alt-text="Screenshot that shows the Edit attribute page with the directory extension listed in Source Attribute." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-source-attribute.png":::

    If the directory extension isn't listed, make sure that the directory extension was created successfully. You can also try to manually add the directory extension to the attribute list as described in the next section.

1. In the **Target attribute** drop-down list, select a target attribute.

    If you created a directory extension in the target tenant, select the directory extension.

1. Select **Ok** to save the mapping.

## Manually add directory extensions to the attribute list

![Icon for the source tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Source tenant**

If your directory extension wasn't automatically discovered, you can try the following steps to manually add the directory extension to the attribute list.

1. Sign in to the Microsoft Entra admin center of the source tenant using the following link:

    https://entra.microsoft.com/?Microsoft_AAD_Connect_Provisioning_forceSchemaEditorEnabled=true

1. Browse to **Entra ID** > **External Identities** > **Cross-tenant synchronization**.

1. Select **Configurations** and then select your configuration.

1. Select **Provisioning** and expand the **Mappings** section.

1. Select **Provision Microsoft Entra ID Users** to open the **Attribute Mapping** page.

1. Scroll to the bottom and select the **Show advanced settings** checkbox.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png" alt-text="Screenshot of the Attribute Mapping page with advanced options displayed." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png":::

    > [!TIP]
    > If you don't see the **Edit attribute list** links, be sure that you are signed in to the Microsoft Entra admin center using the link in Step 1.

1. If you created a directory extension in the source tenant, select the **Edit attribute list for Microsoft Entra ID** link.

1. If you created an extension in the target tenant, select the **Edit attribute list for Azure Active Directory (target tenant)** link.

1. Add the directory extension and select the appropriate options.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings-directory-extension.png" alt-text="Screenshot of Edit Attributes List page with a directory extension added." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings-directory-extension.png":::

1. Select **Save**.

1. Refresh the browser.

1. Browse to the **Attribute mappings** page and try to map the directory extension as described earlier in this article.

## Manually add directory extensions by editing the schema

![Icon for the source tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Source tenant**

Follow these steps to manually add directory extensions to the schema by using the schema editor.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) of the source tenant.

1. Browse to **Entra ID** > **External Identities** > **Cross-tenant synchronization**.

1. Select **Configurations** and then select your configuration.

1. Select **Provisioning** and expand the **Mappings** section.

1. Select **Provision Microsoft Entra ID Users** to open the **Attribute Mapping** page.

1. Scroll to the bottom and select the **Show advanced settings** checkbox.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png" alt-text="Screenshot of the Attribute Mapping page with link to schema editor." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-advanced-settings.png":::

1. Select the **Review your schema here** link to open the **Schema editor** page.

    :::image type="content" source="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-schema-editor.png" alt-text="Screenshot of the Schema editor page the options to edit the schema in JSON." lightbox="./media/cross-tenant-synchronization-directory-extensions/provisioning-mappings-schema-editor.png":::

1. Download an original copy of the schema as a backup.

1. Modify the schema following your required configuration.

1. Select **Save**.

1. Refresh the browser.

1. Browse to the **Attribute mappings** page and try to map the directory extension as described earlier in this article.

## Next steps

- [Syncing extension attributes for Microsoft Entra Application Provisioning](../app-provisioning/user-provisioning-sync-attributes-for-mapping.md)
- [Configure cross-tenant synchronization](./cross-tenant-synchronization-configure.md)

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

1. Select **Provision Azure Active Directory Users** to open the **Attribute Mapping** page.

1. Scroll to the bottom of the page and select **Add new mapping**.

1. If you created a directory extension in the source tenant, select the directory extension from the **Source Attribute** drop-down list.

1. If you created a directory extension in the target tenant, select the directory extension from the **Target Attribute** drop-down list.

## Troubleshooting tips

#### Symptom - Directory extension is not listed

When you try to select the directory extension on the **Edit attribute** page, it's not listed in the **Source Attribute** or **Target Attribute** drop-down lists.

**Cause 1**

The directory extension was not created successfully.

**Solution 1**

Make sure that the directory extension was created successfully.

**Cause 2**

The directory extension was not automatically discovered.

**Solution 2**

Follow these steps to manually add the directory extension to the schema.

1. Select **Show advanced settings**.

1. If you created a directory extension in the source tenant, select the first link **Edit attribute list for Azure Active Directory**.

1. If you created an extension in the target tenant, select the second link **Edit attribute list for Azure Active Directory**.

1. Add the directory extension to the list and select **Save**.

1. Refresh the browser.

1. Browse to the **Attribute mappings** page and try to add the attribute as described earlier in this article.

## Next steps

- [Syncing extension attributes for Microsoft Entra Application Provisioning](../app-provisioning/user-provisioning-sync-attributes-for-mapping.md)
- [Configure cross-tenant synchronization](./cross-tenant-synchronization-configure.md)

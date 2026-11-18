---
title: Manage dynamic permissions settings for a catalog
description: Learn how to enable or disable dynamic permissions remediation for a catalog in Microsoft Entra ID Governance using the Microsoft Entra admin center.
ms.topic: how-to
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to enable or disable dynamic permissions remediation for a catalog so that I can control permission remediation for that catalog.
---

# Manage dynamic permissions settings for a catalog

As an Identity Governance Administrator, you can enable or disable dynamic permissions remediation for a catalog in Microsoft Entra ID Governance. This article describes how to change the **Permission remediation** setting in the Microsoft Entra admin center.

For more information about dynamic permissions and its permission remediation capabilities, see [What is dynamic permissions?](dynamic-permissions-overview.md).

Permission remediation is available for specific resources in a catalog. If you're getting started, see [Tutorial: Mitigate permission risk of agents in Snowflake with Microsoft Entra dynamic permissions](tutorial-dynamic-permissions-prevent-excessive-permissions.md).

## Prerequisites

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

## Enable dynamic permissions remediation for a catalog

[!INCLUDE [Dynamic permissions reporting phase](~/includes/dynamic-permissions-reporting-phase.md)]

To enable permission remediation for a catalog, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)**.
1. Select **Resources**, and then select **Enable dynamic permissions**.

    :::image type="content" source="media/dynamic-permissions-manage-catalog-settings/enable-dynamic-permissions.png" alt-text="Screenshot of the Dynamic permissions Resources page with the Enable dynamic permissions button highlighted." lightbox="media/dynamic-permissions-manage-catalog-settings/enable-dynamic-permissions.png" border="true":::

1. Select the catalog for which you want to enable permission remediation.
1. Confirm the catalog has the correct resources, and set **Permission remediation** to **Enabled**.
1. Select **Enable dynamic permissions**.

    :::image type="content" source="media/dynamic-permissions-manage-catalog-settings/confirm-enable-dynamic-permissions.png" alt-text="Screenshot of permission remediation enabled for a catalog with the final Enable dynamic permissions button highlighted." lightbox="media/dynamic-permissions-manage-catalog-settings/confirm-enable-dynamic-permissions.png" border="true":::

## Disable dynamic permissions remediation for a catalog

To disable permission remediation for a catalog, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Entitlement management**.
1. Select **Catalogs**.
1. Select the catalog for which you want to disable dynamic permissions capabilities.
1. Select **Edit**.
1. Change **Permission remediation** from **Enabled** to **Disabled**.

    :::image type="content" source="media/dynamic-permissions-manage-catalog-settings/disable-permission-remediation.png" alt-text="Screenshot of catalog settings with the Permission remediation setting highlighted in the Disabled state." lightbox="media/dynamic-permissions-manage-catalog-settings/disable-permission-remediation.png" border="true":::

1. Select **Save**.

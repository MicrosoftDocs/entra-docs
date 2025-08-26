---
title: View audit log report for Microsoft Entra roles in Microsoft Entra PIM
description: Learn how to view the audit log history for Microsoft Entra roles in
  Microsoft Entra Privileged Identity Management (PIM).
author: barclayn
manager: pmwongera
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 08/26/2025
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim
---
# View audit history for Microsoft Entra roles in Privileged Identity Management

You can use the Microsoft Entra Privileged Identity Management (PIM) audit history to see role assignments changes and activations done through PIM. Data is available for the past 30 days. If you want to retain audit data for longer than the default retention period, you can use Azure Monitor to route it to an Azure storage account. For more information, see [Archive Microsoft Entra logs to an Azure storage account](~/identity/monitoring-health/howto-archive-logs-to-storage-account.md). To see full audit history of Microsoft Entra ID activity including administrator, end user, and synchronization activity, you can use the [Microsoft Entra security and activity reports](~/identity/monitoring-health/overview-monitoring-health.md).

Follow these steps to view the audit history for Microsoft Entra roles.

## View resource audit history

Use **Resource audit** blade to view all activity associated with your Microsoft Entra role assignment and PIM Policy management in PIM.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Global Administrator, Global Reader, Privileged Role Administrator, Security Administrator, or Security Reader.

1. Browse to **ID Governance** > **Privileged Identity Management** > **Microsoft Entra roles**.

1. Select **Resource audit**.

1. Filter the history using a predefined date or custom range.

    :::image type="content" source="media/azure-pim-resource-rbac/rbac-resource-audit.png" alt-text="Screenshot showing the Microsoft Entra role audit list with filters.":::

## View my audit

Use **My audit** blade to view your role activity for Microsoft Entra role assignment and PIM Policy management.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Microsoft Entra roles**.

1. Select **My audit**.

1. Filter the history using a predefined date or custom range.

    :::image type="content" source="media/azure-pim-resource-rbac/my-audit-time.png" alt-text="Screenshot showing the Audit list page for the current user.":::

## Next steps

- [View activity and audit history for Azure resource roles in Privileged Identity Management](azure-pim-resource-rbac.md)
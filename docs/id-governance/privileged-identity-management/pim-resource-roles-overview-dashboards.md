---
title: Resource dashboards for access reviews in PIM
description: Describes how to use a resource dashboard to perform an access review in Microsoft Entra Privileged Identity Management (PIM).

author: barclayn
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 09/13/2023
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim

---

# Use a resource dashboard to perform an access review in Privileged Identity Management

You can use a resource dashboard to perform an access review in Privileged Identity Management (PIM). The Admin View dashboard in Microsoft Entra ID, part of Microsoft Entra, has three primary components:

- A graphical representation of resource role activations
- Charts that display the distribution of role assignments by assignment type
- A data area containing information to new role assignments

:::image type="content" source="media/pim-resource-roles-overview-dashboards/rbac-overview-top.png" alt-text="Screenshot of the Admin View dashboard, showing graphs and charts.":::

:::image type="content" source="media/pim-resource-roles-overview-dashboards/role-settings.png" alt-text="Screenshot of the Admin View dashboard, showing data lists.":::

The graphical representation of resource role activations covers the past seven days. This data is scoped to the selected resource, and displays activations for the most common roles (owner, contributor, user access administrator), and for all roles combined.

On one side of the activations graph, two charts display the distribution of role assignments by assignment type, for both users and groups. You can change the value to a percentage (or vice versa), by selecting a slice of the chart.

Below the charts are listed the number of users and groups with new role assignments over the last 30 days, and roles sorted by total assignments in descending order.

## Next steps

- [Start an access review for Azure resource roles in Privileged Identity Management](./pim-create-roles-and-resource-roles-review.md)

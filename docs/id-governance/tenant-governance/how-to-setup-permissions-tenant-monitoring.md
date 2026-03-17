---
title: Set up permissions for tenant monitoring (preview)
description: Learn how to set up the required permissions for tenant monitoring in Microsoft Entra Tenant Governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/05/2026
---

# Set up permissions for tenant monitoring (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes how to manage the permissions that the configuration management service needs to access resources identified in a monitor. An administrator must assign these permissions manually. Two types of permissions can be managed in the Microsoft Entra admin center: application permissions and Microsoft Entra roles.

The permission type you assign depends on the services you need to monitor:

- **Microsoft Entra ID and Intune**: Assign application permissions. This approach is the least-privileged way to enable monitoring. For example, to monitor conditional access policies, the configuration management service needs the `Policy.Read.All` application permission. If your policies reference other resource types, you might also need permissions like `User.Read.All` or `RoleManagement.Read.All`.
- **Teams**: Assign the Teams Reader role. Teams doesn't have granular application permissions, so assigning the configuration management service to the Teams Reader role is the least-privileged way to enable monitoring.
- **Exchange, Security, and Compliance (Purview and Defender)**: Assign permissions locally within the admin experiences for those services. Built-in Microsoft Entra roles grant more permissions than needed for these monitoring scenarios.

> [!NOTE]
> Monitoring Exchange also requires that you assign the `Exchange.ManageAsApp` permission to the configuration management service, which enables a service principal to authenticate to Exchange APIs. This assignment is independent of any permissions you assign locally to the configuration management service.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) or [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

## Browse to configuration management permissions

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Tenant Governance** > **Configuration management permissions**.

## Manage application permissions

To manage application permissions that the configuration management service uses to access resources:

1. Select the **Application permissions** tab at the top of the page.

### Add application permissions

1. Select **Add permissions** in the command bar.
1. Search for and select the application permissions that the configuration management service needs to access the resources you want to monitor.
1. Select **Save** at the bottom of the context pane.

### Remove application permissions

1. Select the checkbox next to the permission name, then select the **Delete** button in the command bar. Alternatively, hover over the permission and select the delete icon that appears.
1. In the confirmation dialog, select **Remove**.

## Manage Microsoft Entra roles

To manage Microsoft Entra roles assigned to the configuration management service:

1. Select the **Entra roles** tab at the top of the page.

### Add a Microsoft Entra role

1. Select **Add Entra role** in the command bar.
1. Select the Microsoft Entra role that the configuration management service needs.
1. Select **Save** at the bottom of the context pane.

### Remove a Microsoft Entra role

1. Select the checkbox next to the role name, then select the **Delete** button in the command bar. Alternatively, hover over the role and select the delete icon that appears.
1. In the confirmation dialog, select **Remove**.

## Related content

- [Create a monitor](how-to-create-monitor.md)
- [See monitor results and configuration drifts](how-to-see-monitor-results.md)
- [Configuration management](configuration-management.md)

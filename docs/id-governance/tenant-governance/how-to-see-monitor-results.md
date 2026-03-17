---
title: See monitor results and configuration drifts (preview)
description: Learn how to view monitor results and detect configuration drifts in Microsoft Entra Tenant Governance using the admin center
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/05/2026
---

# See monitor results and configuration drifts (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article describes how to view monitor results and configuration drifts in the [Microsoft Entra admin center](https://entra.microsoft.com). Each time the monitoring service runs (currently every six hours), it publishes run statistics as a monitor result. When the monitoring service detects that a resource's actual state differs from the configuration baseline, it creates a configuration drift.

## Prerequisites

- Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
- Your tenant must have a license for Microsoft Entra Tenant Governance.
- At least one configuration monitor must exist in your tenant and must have run at least once.

## Browse to monitors

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Tenant Governance** > **Configuration management** > **Monitors**.

## View monitor results

1. Select the **Monitor results** tab at the top of the page. All monitor results for all monitors in your tenant appear.
1. Use the filter control to narrow the list by monitor name, start time, or completion time.
1. If a monitor has associated configuration drifts, select the numeric value in the **Drifts detected** column to see the drifts for that monitor.

## View configuration drifts

1. Select the **Configuration drifts** tab at the top of the page. All configuration drifts for all monitors in your tenant appear.
1. Use the filter control to narrow the list by monitor, resource type, resource name, or the time the drift was first detected.
1. To see drift details, select the value in the **Drifted properties** column. A context pane opens with all properties of the configuration drift.

The bottom of the context pane lists each drifted property along with its actual and expected values. When a resource defined in the configuration baseline is entirely absent from the tenant, the **Ensure** property displays a value of **Absent** instead of **Present**.

## Address a configuration drift

To fix a configuration drift, use the administration tool of your choice to update the resource so it matches the value defined in the monitor's configuration baseline. For example:

- For a conditional access policy drift, use the Microsoft Entra admin center, Microsoft Graph PowerShell, or Microsoft Graph API.
- For an Exchange transport rule drift, use Exchange Admin Center or Exchange PowerShell.

Alternatively, if the actual state of the resource is acceptable, update the configuration baseline for the monitor to reflect the current resource state.

## Related content

- [Create a monitor](how-to-create-monitor.md)
- [Update or delete a monitor](how-to-update-delete-monitor.md)
- [Set up permissions for tenant monitoring](how-to-setup-permissions-tenant-monitoring.md)
- [Configuration management](configuration-management.md)

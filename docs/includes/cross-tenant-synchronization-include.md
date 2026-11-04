---
title: Include file
description: Include file
author: rolyon
ms.service: entra-id
ms.topic: include
ms.date: 11/02/2026
ms.author: rolyon
ms.custom: include file
ai-usage: ai-assisted
---

The cross-tenant synchronization settings are inbound-only organizational settings to allow the administrator of a source tenant to synchronize users and groups into a target tenant. These settings are checkboxes with the names **Allow user synchronization into this tenant** and **Allow group synchronization into this tenant** that are specified in the target tenant. These settings don't affect B2B invitations created through other processes such as [manual invitation](~/external-id/add-users-administrator.yml) or [Microsoft Entra entitlement management](~/id-governance/entitlement-management-external-users.md).

When role-enabled group sync is available in your environment, the target tenant also controls inbound role-assignable group synchronization through **Allow role-enabled group synchronization into this tenant**. Select this checkbox together with **Allow group synchronization into this tenant** to allow role-enabled group sync. This feature synchronizes role-assignability, not the source group's role assignments.

:::image type="content" source="~/media/external-identities/allow-role-enabled-groups-inbound.png" alt-text="Screenshot of the Cross-tenant sync tab showing the inbound user, group, and role-enabled group synchronization checkboxes." lightbox="~/media/external-identities/allow-role-enabled-groups-inbound.png":::

The screenshot identifies the settings. The group and role-enabled group checkboxes aren't selected in this example.

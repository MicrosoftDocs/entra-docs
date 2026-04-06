---
title: include file
description: include file
author: rolyon
ms.service: entra-id
ms.topic: include
ms.date: 01/23/2023
ms.author: rolyon
ms.custom: include file
---

The cross-tenant synchronization settings are an inbound only organizational settings to allow the administrator of a source tenant to synchronize users and groups into a target tenant. These settings are checkboxes with the names **Allow user synchronization into this tenant** and **Allow group synchronization into this tenant** that are specified in the target tenant. These settings don't impact B2B invitations created through other processes such as [manual invitation](~/external-id/add-users-administrator.yml) or [Microsoft Entra entitlement management](~/id-governance/entitlement-management-external-users.md).

:::image type="content" source="~/media/external-identities/access-settings-users-sync.png" alt-text="Screenshot that shows the Cross-tenant sync tab with the Allow user synchronization into this tenant and Allow group synchronization into this tenant checkboxes." lightbox="~/media/external-identities/access-settings-users-sync.png":::

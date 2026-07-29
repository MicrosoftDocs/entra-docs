---
title: include file
description: include file
author: amsliu
ms.service: entra-id
ms.topic: include
ms.date: 07/29/2026
ms.author: amsliu
ms.custom: include file
---

>[!Note]
> For groups used for elevating into Microsoft Entra roles, we recommend that you require an approval process for eligible member assignments. Assignments that can be activated without approval can leave you vulnerable to a security risk from less-privileged administrators, who might be able to reset a user's credentials and then activate the assignment on their behalf.
>
> Confirm that groups used for role elevation are created as [role-assignable](~/identity/role-based-access-control/groups-concept.md). You must be assigned at least the Privileged Authentication Administrator role to change the credentials of members and owners of a role-assignable group.

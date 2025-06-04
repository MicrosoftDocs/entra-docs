---
title: Include file
description: Include file
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: privileged-identity-management
ms.topic: include
ms.date: 03/20/2025
ms.author: barclayn
ms.custom: include file
---

Microsoft Entra ID doesn't allow you to remove the last (active) owner of a group. For example, consider a group that has active owner A and eligible owner B. If user B activates their ownership with PIM and then later user A is removed from the group or from the tenant, deactivation of user B's ownership won't succeed. 

PIM will try to deactivate user B's ownership for up to 30 days. If another active owner C is added to the group, the deactivation will succeed. If deactivation is unsuccessful after 30 days, PIM will stop trying to deactivate user B's ownership and user B will continue to be an active owner. 
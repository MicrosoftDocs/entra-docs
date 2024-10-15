---
title: 'Govern cloud users that are provisioned from on-premises to Microsoft Entra ID with Microsoft Identity Manager'
description: This article a tutorial on how to provision users and groups from on-premises to cloud using MIM.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: conceptual
ms.date: 02/28/2024
ms.subservice: hybrid-cloud-sync
ms.author: billmath
---

# Govern cloud users that are provisioned from on-premises to Microsoft Entra ID with Microsoft Identity Manager

**Scenario:** Manage cloud users that are provisioned from on-premises to Microsoft Entra ID with Microsoft Identity Manager.

:::image type="content" source="media/provision-microsoft-identity-manager-to-entra/provision-microsoft-identity-manager-to-entra.png" alt-text="Conceptual drawing showing MIM provisioning." lightbox="media/provision-microsoft-identity-manager-to-entra/provision-microsoft-identity-manager-to-entra.png":::

If you have integration scenarios, for users and groups, that aren't in scope for Microsoft Entra Connect cloud sync or Microsoft Entra Connect Sync, then you should consider using the [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016) and the [Microsoft Identity Manager connector for Microsoft Graph](/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph). This connector communicates with Microsoft Entra ID via the [Microsoft Graph API v1.0](/graph/overview) and beta. The end of [support](/microsoft-identity-manager/microsoft-identity-manager-2016#support-update-for-microsoft-entra-id-p1-or-p2-customers) for Microsoft Identity Manager 2016 is January 9, 2029.

## Next steps 
- [What is identity lifecycle management](~/id-governance/what-is-identity-lifecycle-management.md)
- [What is provisioning?](~/id-governance/what-is-provisioning.md)
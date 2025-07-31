---
title: 'Govern on-premises Active Directory(Kerberos) application access with groups from the cloud'
description: This article provides an overview of how to use cloud sync to govern on-premises application access using groups.
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: article
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi
---

# Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]

**Scenario:** Manage on-premises applications with Active Directory groups that are provisioned from and managed in the cloud. Microsoft Entra Cloud Sync allows you to fully govern application assignments in AD while taking advantage of Microsoft Entra ID Governance features to control and remediate any access related requests.

With the release of provisioning agent [1.1.1370.0](reference-version-history.md#1113700), cloud sync now has the ability to provision groups directly to your on-premises Active Directory environment. You can use identity governance features to govern access to AD-based applications, such as by including a [group in an entitlement management access package](../../../id-governance/entitlement-management-group-writeback.md).

 :::image type="content" source="media/govern-on-premises-groups/on-premises-group-writeback.png" alt-text="Conceptual drawing of Microsoft Entra Cloud Sync's Group Provision to AD." lightbox="media/govern-on-premises-groups/on-premises-group-writeback.png":::

## Watch the group writeback video

For a great overview of cloud sync group provisioning to Active directory and what it can do for you, check out the video below.

> [!VIDEO https://www.youtube.com/embed/C6XXlSVaIeo]

[!INCLUDE [governance-on-premises-active-directory-apps.md](~/includes/governance/governance-on-premises-active-directory-apps.md)]



## Next Steps
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Group provisioning to Active Directory using Microsoft Entra Cloud Sync](how-to-configure-entra-to-active-directory.md)
- [Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync migration](migrate-group-writeback.md)

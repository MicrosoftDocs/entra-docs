---
title: 'Group writeback with Microsoft Entra Cloud Sync'
description: This article describes the new feature in Cloud Sync to provision and writeback groups to on-premises AD.
author: billmath
manager: femila
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 04/09/2025
ms.subservice: hybrid
ms.author: billmath

---

# Group writeback with Microsoft Entra Cloud Sync

With the release of provisioning agent [1.1.1370.0](cloud-sync/reference-version-history.md#1113700), cloud sync now has the ability to perform group writeback. This feature means that cloud sync can provision groups directly to your on-premises Active Directory environment.  You can also now use identity governance features to govern access to AD-based applications, such as by including a [group in an entitlement management access package](../../id-governance/entitlement-management-group-writeback.md).

 :::image type="content" source="media/common-scenarios/group-writeback-1.png" alt-text="Diagram of group writeback with cloud sync." lightbox="media/common-scenarios/group-writeback-1.png":::

[!INCLUDE [deprecation](~/includes/gwb-v2-deprecation.md)]







[!INCLUDE [pre-requisites](includes/gpad-prereqs.md)]




## Supported scenarios for group writeback with Microsoft Entra Cloud Sync
The following sections describe the supported scenarios for group writeback with Microsoft Entra Cloud Sync.

- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](#migrate-microsoft-entra-connect-sync-group-writeback-v2-to-microsoft-entra-cloud-sync)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](#govern-on-premises-active-directory-based-apps-kerberos-using-microsoft-entra-id-governance)

###  Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync

**Scenario:**  Migrate group writeback using Microsoft Entra Connect Sync (formerly Azure AD Connect) to Microsoft Entra Cloud Sync. This scenario is **only** for customers who are currently using Microsoft Entra Connect group writeback v2. The process outlined in this document pertains only to cloud-created security groups that are written back with a universal scope. Mail-enabled groups and DLs written back using Microsoft Entra Connect group writeback V1 or V2 aren't supported.

For more information see [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](cloud-sync/migrate-group-writeback.md).

### Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance 

**Scenario:**  Manage on-premises applications with Active Directory groups that are provisioned from and managed in the cloud. Microsoft Entra Cloud Sync allows you to fully govern application assignments in AD while taking advantage of Microsoft Entra ID Governance features to control and remediate any access related requests. 

For more information see [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](cloud-sync/govern-on-premises-groups.md).


## Next steps
- [Provision groups to Active Directory using Microsoft Entra Cloud Sync](cloud-sync/how-to-configure-entra-to-active-directory.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](cloud-sync/govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](cloud-sync/migrate-group-writeback.md)
- [Scoping filter and attribute mapping - Microsoft Entra ID to Active Directory](cloud-sync/how-to-attribute-mapping-entra-to-active-directory.md)

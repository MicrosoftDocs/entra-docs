---
title: 'Tools used for synchronization'
description: Compare Microsoft identity synchronization tools for users, groups, contacts, and devices to choose an approach for hybrid identity with Active Directory.
ms.topic: concept-article
ms.tgt_pltfrm: na
ms.date: 10/06/2026
ms.custom: msecd-doc-authoring-1023
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to compare Microsoft identity synchronization tools so that I can choose an approach for my hybrid identity environment.
---

# Tools used for synchronization
This article compares Microsoft Entra Cloud Sync, Connect Sync, Microsoft Identity Manager (MIM), and the ECMA host connector. Use the comparison to choose a tool for synchronizing identities or provisioning users to on-premises applications.

## List of tools 

- **Cloud Sync and the provisioning agent** - Microsoft Entra Cloud Sync synchronizes users, groups, and contacts from Active Directory to Microsoft Entra ID. When device sync is enabled, it can also synchronize computer objects for Microsoft Entra hybrid join. Cloud Sync uses the lightweight provisioning agent and is configurable through the Microsoft Entra admin center. For more information, see [What is Microsoft Entra Cloud Sync?](cloud-sync/what-is-cloud-sync.md), [What is the provisioning agent?](cloud-sync/what-is-provisioning-agent.md), and [Configure device sync with Microsoft Entra Cloud Sync](cloud-sync/device-sync.md).

- **Connect Sync** - Microsoft Entra Connect is an on-premises application for synchronizing identities with Microsoft Entra ID. For more information, see [What is Microsoft Entra Connect?](connect/whatis-azure-ad-connect-v2.md).

- **Microsoft Identity Manager with the Graph connector** - Microsoft's on-premises identity and access management solution that provides advanced inter-directory provisioning to achieve hybrid identity environments for Active Directory, Microsoft Entra ID, and other directories. For more information, see [Microsoft Identity Manager](/microsoft-identity-manager/microsoft-identity-manager-2016). MIM is slowly being deprecated and should only be used in advanced scenarios. For more information, see [Deprecated Features and planning for the future](/microsoft-identity-manager/microsoft-identity-manager-2016-deprecated-features)

- **ECMA Host connector** - The ECMA host works with the provisioning agent to provision and synchronize users from the cloud into on-premises applications such as SQL and LDAP. For more information, see [Microsoft Entra on-premises application identity provisioning architecture](~/identity/app-provisioning/on-premises-application-provisioning-architecture.md) and [What is the provisioning agent?](cloud-sync/what-is-provisioning-agent.md)

## Selecting the right tool
These tools support different hybrid identity scenarios. Compare their capabilities in the [supported sync scenarios table](common-scenarios.md#supported-sync-scenarios), then use the [sync tool selection wizard](common-scenarios.md) to choose a tool.

## Next steps
- [Common scenarios](common-scenarios.md)
- [Choosing the right sync tool](common-scenarios.md)
- [Steps to start](get-started.md)
- [Prerequisites](prerequisites.md)

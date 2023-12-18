---
title: Microsoft Entra on-premises app provisioning to SCIM-enabled apps
description: This article describes how to use the Microsoft Entra provisioning service to provision users into an on-premises app that's SCIM enabled.
author: billmath
manager: amycolannino
ms.service: active-directory
ms.subservice: app-provisioning
ms.topic: conceptual
ms.workload: identity
ms.date: 04/04/2023
ms.author: billmath
ms.reviewer: arvinh
---

# Microsoft Entra on-premises application provisioning to SCIM-enabled apps

The Microsoft Entra provisioning service supports a [SCIM 2.0](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/provisioning-with-scim-getting-started/ba-p/880010) client that can be used to automatically provision users into cloud or on-premises applications. This article outlines how you can use the Microsoft Entra provisioning service to provision users into an on-premises application that's SCIM enabled. If you want to provision users into non-SCIM on-premises applications that use SQL as a data store, see the [Microsoft Entra ECMA Connector Host Generic SQL Connector tutorial](tutorial-ecma-sql-connector.md). If you want to provision users into cloud apps such as DropBox and Atlassian, review the app-specific [tutorials](~/identity/saas-apps/tutorial-list.md).

![Diagram that shows SCIM architecture.](./media/on-premises-scim-provisioning/scim-4.png)

## Prerequisites
- A Microsoft Entra tenant with Microsoft Entra ID P1 or Premium P2 (or EMS E3 or E5). [!INCLUDE [active-directory-p1-license.md](~/includes/entra-p1-license.md)]
- Administrator role for installing the agent. This task is a one-time effort and should be an Azure account that's either a Hybrid Identity Administrator or a global administrator. 
- Administrator role for configuring the application in the cloud (application administrator, cloud application administrator, global administrator, or a custom role with permissions).
- A computer with at least 3 GB of RAM, to host a provisioning agent. The computer should have Windows Server 2016 or a later version of Windows Server, with connectivity to the target application, and with outbound connectivity to login.microsoftonline.com, other Microsoft Online Services and Azure domains. An example is a Windows Server 2016 virtual machine hosted in Azure IaaS or behind a proxy.

<a name='download-install-and-configure-the-azure-ad-connect-provisioning-agent-package'></a>

[!INCLUDE [app-provisioning-provisioning-agent-install.md](~/includes/app-provisioning-provisioning-agent-install.md)]


 
## Provisioning to SCIM-enabled application
Once the agent is installed, no further configuration is necessary on-premises, and all provisioning configurations are then managed from the portal. Repeat the below steps for every on-premises application being provisioned via SCIM.

1. Configure any [attribute mappings](customize-application-attributes.md) or [scoping](define-conditional-rules-for-provisioning-user-accounts.md) rules required for your application.
1. Add users to scope by [assigning users and groups](~/identity/enterprise-apps/add-application-portal-assign-users.md) to the application.
1. Test provisioning a few users [on demand](provision-on-demand.md).
1. Add more users into scope by assigning them to your application.
1. Go to the **Provisioning** pane, and select **Start provisioning**.
1. Monitor using the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md).

The following video provides an overview of on-premises provisioning.

> [!VIDEO https://www.youtube.com/embed/QdfdpaFolys]

## Additional requirements
* Ensure your [SCIM](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/provisioning-with-scim-getting-started/ba-p/880010) implementation meets the [Microsoft Entra SCIM requirements](use-scim-to-provision-users-and-groups.md).
  
  Microsoft Entra ID offers open-source [reference code](https://github.com/AzureAD/SCIMReferenceCode/wiki) that developers can use to bootstrap their SCIM implementation. The code is as is.
* Support the /schemas endpoint to reduce configuration required in the Azure portal. 

## Next steps

- [App provisioning](user-provisioning.md)
- [Generic SQL connector](on-premises-sql-connector-configure.md)
- [Tutorial: ECMA Connector Host generic SQL connector](tutorial-ecma-sql-connector.md)
- [Known issues](known-issues.md)

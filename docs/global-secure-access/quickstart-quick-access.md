---
title: "Quickstart: Configure Quick Access to private resources"
description: Learn how to configure Quick Access to private resources in Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: quickstart
ms.date: 07/22/2024

#customer intent: As an administrator, I want learn how to configure Quick Access so that my users can access private resources in Global Secure Access.

---
  
# Quickstart: Configure Quick Access to private resources

Microsoft Entra Private Access provides a secure, zero-trust access solution for accessing internal resources without requiring a VPN. Configure Quick Access and enable the Private Access traffic forwarding profile to specify the sites and apps you want routed through Microsoft Entra Private Access. At this time, the Global Secure Access client must be installed on end-user devices to use Microsoft Entra Private Access, so that step is included in this section.
 
This quickstart shows you the steps needed to configure Quick Access to private resources. To learn more about Global Secure Access, see [What is Global Secure Access?](overview-what-is-global-secure-access.md)

## Prerequisites

Administrators who interact with **Global Secure Access** features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference). Some features might also require other roles.

To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to activate just-in-time privileged role assignments.

The product requires licensing. For details, see the licensing section of [What is Global Secure Access?](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense). To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

## Configure Quick Access to private resources

Set up Quick Access for broader access to your network using Microsoft Entra Private Access.

:::image type="content" source="media/quickstart-quick-access/private-access-diagram-quick-access.png" alt-text="Diagram of the Quick Access traffic flow for private resources." lightbox="media/quickstart-quick-access/private-access-diagram-quick-access.png":::

1. [Configure a Microsoft Entra private network connector and connector group](how-to-configure-connectors.md).
1. [Configure Quick Access to your private resources](how-to-configure-quick-access.md).
1. [Enable the Private Access traffic forwarding profile](how-to-manage-private-access-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).

After you complete these four steps, users with the Global Secure Access client installed on a Windows device can connect to private resources, through a Quick Access app and private network connector. 

## Next step
- [Quickstart: Configure per-app access to private resources](quickstart-per-app-access.md)

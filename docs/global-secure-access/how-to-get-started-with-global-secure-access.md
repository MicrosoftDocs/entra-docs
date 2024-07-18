---
title: Get started with Global Secure Access
description: Configure the main components of Microsoft Entra Internet Access and Microsoft Entra Private Access, which make up Global Secure Access, Microsoft's Security Service Edge solution.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 11/02/2023
ms.service: global-secure-access
---
# Get started with Global Secure Access

Global Secure Access, Microsoft's Security Service Edge, is the centralized location in the Microsoft Entra admin center where you can configure and manage the features. Many features and settings apply to both Microsoft Entra Private Access and Microsoft Entra Internet Access. Some features are specific to one or the other.

This guide helps you get started configuring both services for the first time.

## Prerequisites

Administrators who interact with **Global Secure Access** features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference). Some features might also require other roles.

To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to activate just-in-time privileged role assignments.

The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense). To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

There might be limitations with some features of the Global Secure Access, which are defined in the associated articles.

## Access the Microsoft Entra admin center

Global Secure Access is the area in the Microsoft Entra admin center where you configure and manage Microsoft Entra Internet Access and Microsoft Entra Private Access.

- Go to [**https://entra.microsoft.com**](https://entra.microsoft.com/).

If you encounter access issues, refer to this [FAQ regarding tenant restrictions](resource-faq.yml).

## Microsoft Entra Internet Access

Microsoft Entra Internet Access isolates the traffic for Microsoft applications and resources, such as Exchange Online and SharePoint Online. Users can access these resources by connecting to the Global Secure Access Client or through a remote network, such as in a branch office location.

### Install the client to acquire Microsoft traffic

![Diagram of the basic Microsoft Entra Internet Access traffic flow.](media/how-to-get-started-with-global-secure-access/internet-access-basic-option.png)

1. [Enable the Microsoft traffic forwarding profile](how-to-manage-microsoft-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).
1. [Enable universal tenant restrictions](how-to-universal-tenant-restrictions.md).
1. [Enable enhanced Global Secure Access signaling and Conditional Access](how-to-compliant-network.md).

After you complete these four steps, users with the Global Secure Access client installed on their Windows device can securely access Microsoft resources from anywhere. Conditional Access policy requires users to use the Global Secure Access client or a configured remote network, when they access Exchange Online and SharePoint Online.

### Create a remote network, apply Conditional Access, and review the logs

![Diagram of the Microsoft Entra Internet Access traffic flow with remote networks and Conditional Access.](media/how-to-get-started-with-global-secure-access/internet-access-remote-networks-option.png)

1. [Create a remote network](how-to-manage-remote-networks.md).
1. [Target the Microsoft traffic profile with Conditional Access policy](how-to-target-resource-microsoft-profile.md).
1. [Review the Global Secure Access logs](concept-global-secure-access-logs-monitoring.md).

After you complete these optional steps, users can connect to Microsoft services without the Global Secure Access client if they're connecting through the remote network you created *and* if they meet the conditions you added to the Conditional Access policy.

## Microsoft Entra Private Access

Microsoft Entra Private Access provides a secure, zero-trust access solution for accessing internal resources without requiring a VPN. Configure Quick Access and enable the Private access traffic forwarding profile to specify the sites and apps you want routed through Microsoft Entra Private Access. At this time, the Global Secure Access Client must be installed on end-user devices to use Microsoft Entra Private Access, so that step is included in this section.

### Configure Quick Access to your primary private resources

Set up Quick Access for broader access to your network using Microsoft Entra Private Access.

![Diagram of the Quick Access traffic flow for private resources.](media/how-to-get-started-with-global-secure-access/private-access-diagram-quick-access.png)

1. [Configure a Microsoft Entra private network connector and connector group](how-to-configure-connectors.md).
1. [Configure Quick Access to your private resources](how-to-configure-quick-access.md).
1. [Enable the Private Access traffic forwarding profile](how-to-manage-private-access-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).

After you complete these four steps, users with the Global Secure Access client installed on a Windows device can connect to your primary resources, through a Quick Access app and private network connector. 

### Configure Global Secure Access apps for per-app access to private resources

Create specific private apps for granular segmented access to private access resources using Microsoft Entra Private Access.

![Diagram of the Global Secure Access app traffic flow for private resources.](media/how-to-get-started-with-global-secure-access/private-access-diagram-global-secure-access.png)

1. [Configure a private network connector and connector group](how-to-configure-connectors.md).
1. [Create a private Global Secure Access application](how-to-configure-per-app-access.md).
1. [Enable the Private Access traffic forwarding profile](how-to-manage-private-access-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).

After you complete these steps, users with the Global Secure Access client installed on a Windows device can connect to your private resources through a Global Secure Access app and private network connector.

Optionally:

- [Secure Quick Access applications with Conditional Access policies](how-to-target-resource-private-access-apps.md).
- [Review the Global Secure Access logs](concept-global-secure-access-logs-monitoring.md).



## Next steps

To get started with Microsoft Entra Internet Access, start by [enabling the Microsoft traffic forwarding profile](how-to-manage-microsoft-profile.md).

To get started with Microsoft Entra Private Access, start by [configuring a private network connector group for the Quick Access app](how-to-configure-connectors.md).

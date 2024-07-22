---
title: "Quickstart: Install the Windows client to acquire Microsoft traffic"
description: Learn how to Install the Windows client to acquire Microsoft traffic in Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: quickstart
ms.date: 07/22/2024

#customer intent: As an administrator, I want learn how to install the client so that I can begin acquiring Microsoft traffic in Global Secure Access.

---
  
# Quickstart: Install the Windows client to acquire Microsoft traffic

Microsoft Entra Internet Access isolates the traffic for Microsoft applications and resources, such as Exchange Online and SharePoint Online. Users can access these resources by connecting to the Global Secure Access client or through a remote network, such as in a branch office location.
 
This quickstart shows you the steps needed to install the client and start acquiring Microsoft traffic. To learn more about Global Secure Access, see [What is Global Secure Access?](overview-what-is-global-secure-access.md)

## Prerequisites

Administrators who interact with **Global Secure Access** features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference). Some features might also require other roles.

To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to activate just-in-time privileged role assignments.

The product requires licensing. For details, see the licensing section of [What is Global Secure Access?](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense). To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

### Install the client to acquire Microsoft traffic

:::image type="content" source="media/quickstart-install-client/internet-access-basic-option.png" alt-text="Diagram of the basic Microsoft Entra Internet Access traffic flow." lightbox="media/quickstart-install-client/internet-access-basic-option.png":::

1. [Enable the Microsoft traffic forwarding profile](how-to-manage-microsoft-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).
1. [Enable universal tenant restrictions](how-to-universal-tenant-restrictions.md).
1. [Enable enhanced Global Secure Access signaling and Conditional Access](how-to-compliant-network.md).

After you complete these four steps, users with the Global Secure Access client installed on their Windows device can securely access Microsoft resources from anywhere. Conditional Access policy requires users to use the Global Secure Access client or a configured remote network, when they access Exchange Online and SharePoint Online.

## Next step
- [Related article title](link.md)

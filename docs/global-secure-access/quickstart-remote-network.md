---
title: "Quickstart: Create a remote network, apply Conditional Access, and review the logs"
description: Learn how to Create a remote network, apply Conditional Access, and review the logs in Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.service: global-secure-access
ms.topic: quickstart
ms.date: 07/22/2024

#customer intent: As an administrator, I want learn how to create a remote network so that I can begin acquiring remote network traffic in Global Secure Access.

---
  
# Quickstart: Create a remote network, apply Conditional Access, and review the logs

Microsoft Entra Internet Access isolates the traffic for Microsoft applications and resources, such as Exchange Online and SharePoint Online. Users can access these resources by connecting to the Global Secure Access client or through a remote network, such as in a branch office location.
 
This quickstart shows you the steps needed to create a remote network and start acquiring Microsoft traffic. To learn more about Global Secure Access, see [What is Global Secure Access?](overview-what-is-global-secure-access.md)

## Prerequisites

Administrators who interact with **Global Secure Access** features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference). Some features might also require other roles.

To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to activate just-in-time privileged role assignments.

The product requires licensing. For details, see the licensing section of [What is Global Secure Access?](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense). To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

### Create a remote network, apply Conditional Access, and review the logs

:::image type="content" source="media/quickstart-remote-network/internet-access-remote-networks-option.png" alt-text="Diagram of the Microsoft Entra Internet Access traffic flow with remote networks and Conditional Access." lightbox="media/quickstart-remote-network/internet-access-remote-networks-option.png":::

1. [Create a remote network](how-to-manage-remote-networks.md).
1. [Target the Microsoft traffic profile with Conditional Access policy](how-to-target-resource-microsoft-profile.md).
1. [Review the Global Secure Access logs](concept-global-secure-access-logs-monitoring.md).

After you complete these optional steps, users can connect to Microsoft services without the Global Secure Access client if they're connecting through the remote network you created *and* if they meet the conditions you added to the Conditional Access policy.

## Next step
- [Quickstart: Configure Quick Access to your primary private resources](quickstart-quick-access.md)

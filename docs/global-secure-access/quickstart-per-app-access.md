---
title: "Quickstart: Configure per-app access to private resources"
description: Learn how to configure per-app access to private resources in Global Secure Access.
author: kenwith
ms.author: kenwith
manager: femila
ms.service: global-secure-access
ms.topic: quickstart
ms.date: 02/21/2025
ai-usage: ai-assisted

#customer intent: As an administrator, I want learn how to configure per-app access so that my users can access private resources in Global Secure Access.

---
  
# Quickstart: Configure per-app access to private resources

This quickstart shows you the steps needed to configure per-app access to private resources. To learn more about Global Secure Access, see [What is Global Secure Access?](overview-what-is-global-secure-access.md)

## Prerequisites

Administrators who interact with **Global Secure Access** features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference). Some features might also require other roles.

To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](/azure/active-directory/privileged-identity-management/pim-configure) to activate just-in-time privileged role assignments.

The product requires licensing. For details, see the licensing section of [What is Global Secure Access?](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
## Configure per-app access to private resources

Create specific private apps for granular segmented access to private access resources using Microsoft Entra Private Access.

:::image type="content" source="media/quickstart-per-app-access/private-access-diagram-global-secure-access.png" alt-text="Diagram of the Global Secure Access app traffic flow for private resources." lightbox="media/quickstart-per-app-access/private-access-diagram-global-secure-access.png":::

1. [Configure a private network connector and connector group](how-to-configure-connectors.md).
1. [Create a private Global Secure Access application](how-to-configure-per-app-access.md).
1. [Enable the Private Access traffic forwarding profile](how-to-manage-private-access-profile.md).
1. [Install and configure the Global Secure Access Client on end-user devices](how-to-install-windows-client.md).

After you complete these steps, users with the Global Secure Access client installed on a Windows device can connect to your private resources through a Global Secure Access app and private network connector.

Optionally:

- [Secure Quick Access applications with Conditional Access policies](how-to-target-resource-private-access-apps.md).
- [Review the Global Secure Access logs](concept-global-secure-access-logs-monitoring.md).

## Next step
- [Understand Microsoft Entra Internet Access](concept-internet-access.md)
- [Understand Microsoft Entra Private Access](concept-private-access.md)

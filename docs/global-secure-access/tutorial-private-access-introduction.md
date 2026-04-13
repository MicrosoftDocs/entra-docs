---
title: "Tutorial: Get started with Microsoft Entra Private Access labs"
description: Learn about Microsoft Entra Private Access labs covering connector setup, traffic forwarding, Quick Access, per-app segmentation, and more.
ms.topic: tutorial
ms.date: 03/11/2026
ms.subservice: entra-private-access
ms.reviewer: jebley
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Tutorial: Get started with Microsoft Entra Private Access labs

This tutorial series offers practical, hands-on experience with Microsoft Entra Private Access, an identity-centric Zero Trust Network Access (ZTNA) solution. Microsoft Entra Private Access delivers granular access to on-premises resources without exposing the broader network, while strengthening access security through modern Microsoft Entra ID controls such as Conditional Access, Continuous Access Evaluation (CAE), Privileged Identity Management (PIM), and more.

In this tutorial, you learn how to:
> [!div class="checklist"]
> - Understand what Microsoft Entra Private Access is and how it works
> - Review Security Service Edge (SSE) concepts and capabilities
> - Navigate the learning progression for the lab series

## How to run the lab exercises

This series is designed to build foundational and advanced skills in Microsoft Entra Private Access. **The exercises assume you've gone in order.** Skipping steps might leave required prerequisites unconfigured. For example, the per-app access segmentation tutorial guides you through creating a specific Enterprise Application for an on-premises resource; however, if the enable Private Access tutorial is skipped, the required traffic forwarding profile might not be enabled, and traffic won't reach the Connector. To ensure successful outcomes, complete the tutorials in the prescribed order.

## Prerequisites

To complete this tutorial series, you need the following:

- Microsoft Entra ID tenant with P1 and either Microsoft Entra Private Access or Microsoft Entra Suite licenses.
- Either Global Admin role or all three of the following roles: Global Secure Access Admin, Security Admin, Application Admin.
- A Windows 11 device (must be Entra joined, hybrid joined, or Entra registered) with internet access.
- A Windows Server 2016 or later to host the Private Network Connector.
- An on-premises resource such as a server for RDP, an internal website, a file share, or similar. The tutorial steps assume it's an SMB file share.

## Learning progression

Each lab builds upon the previous one, following a logical progression:

| Exercise | What you learn |
|----------|----------------|
| [Connector setup](tutorial-private-access-connector-setup.md) | How to set up the Private Network Connector used to broker access to private resources. |
| [Enable Private Access](tutorial-private-access-enable-traffic-forwarding.md) | How to enable the Private Access traffic forwarding profile and assign users or groups. |
| [VPN replacement with Quick Access](tutorial-private-access-vpn-replacement.md) | How to publish broad private network access using Quick Access, including subnets, private DNS, and assignments. |
| [Per-app access segmentation](tutorial-private-access-app-segmentation.md) | How to transition from broad access to least-privilege per-app enterprise applications using discovery insights, and enforce Conditional Access policies on on-premises apps. |
| [Intelligent Local Access](tutorial-private-access-intelligent-local-access.md) | How to configure Intelligent Local Access (ILA) to optimize in-office/private network routing and validate traffic behavior. |

## Next steps

> [!div class="nextstepaction"]
> [Set up the Private Network Connector](tutorial-private-access-connector-setup.md)

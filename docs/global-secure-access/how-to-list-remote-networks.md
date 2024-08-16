---
title: How to list remote networks for Global Secure Access
description: Learn how to list remote networks for Global Secure Access.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 03/04/2024
ms.service: global-secure-access
---

# How to list remote networks for Global Secure Access

Reviewing your remote networks is an important part of managing your Global Secure Access deployment. As your organization grows, you add more remote networks. You use the Microsoft Entra admin center or the Microsoft Graph API.

## Prerequisites 

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## List all remote networks using the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Global Secure Access** > **Connect** > **Remote networks**. All remote networks are listed.
1. To view the details, select a remote network.

## List all remote networks using the Microsoft Graph API 

1. Sign in to [Graph Explorer](https://aka.ms/ge). 
1. Select `GET` as the HTTP method from the dropdown. 
1. Set the API version to beta. 
1. Enter the following query.
    ```
       GET https://graph.microsoft.com/beta/networkaccess/connectivity/branches
    ```
1. Select the **Run query** button to list the remote networks.  



## Next steps
- [Create remote networks](how-to-manage-remote-networks.md)

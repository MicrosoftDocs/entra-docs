---
title: How to list remote networks for Global Secure Access (preview)
description: Learn how to list remote networks for Global Secure Access (preview).
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 03/04/2024
ms.service: global-secure-access
---

# How to list remote networks for Global Secure Access (preview)

Reviewing your remote networks is an important part of managing your Global Secure Access (preview) deployment. As your organization grows, you add more remote networks. You use the Microsoft Entra admin center or the Microsoft Graph API.

## Prerequisites 

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

## List all remote networks using the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Global Secure Access (preview)** > **Devices** > **Remote network**. All remote networks are listed.
1. To view the details, select a remote network.

## List all remote networks using the Microsoft Graph API 

1. Sign in to the [Graph Explorer](https://aka.ms/ge). 
1. Select `GET` as the HTTP method from the dropdown. 
1. Set the API version to beta. 
1. Enter the following query.
    ```
       GET https://graph.microsoft.com/beta/networkaccess/connectivity/branches
    ```
1. Select the **Run query** button to list the remote networks.  

[!INCLUDE [Public preview important note](./includes/public-preview-important-note.md)]

## Next steps
- [Create remote networks](how-to-manage-remote-networks.md)

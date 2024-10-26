---
title: The Global Secure Access client for macOS
description: The Global Secure Access client secures network traffic at the end-user device. This article describes how to download and install the macOS client.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 10/25/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: macOS users, I want to download and install the Global Secure Access client.
---
# Global Secure Access client for macOS
The Global Secure Access client, an essential component of Global Secure Access, helps organizations manage and secure network traffic on end-user devices. The client's main role is to route traffic that needs to be secured by Global Secure Access to the cloud service. All other traffic goes directly to the network. The [Forwarding Profiles](concept-traffic-forwarding.md), configured in the portal, determine which traffic the Global Secure Access client routes to the cloud service.

This article describes how to download and install the Global Secure Access client for macOS.

## Prerequisites

- A Mac device with an Intel, M1, M2, or M3 processor, running macOS version 13 or newer.
- A device registered to Microsoft Entra tenant using Company Portal.
- A Microsoft Entra tenant onboarded to Global Secure Access.
- Deployment of the Microsoft Enterprise SSO plug-in is recommended for SSO experience based on the user who is signed in to the company portal.
- An internet connection.

## Download the client

The most current version of the Global Secure Access client is available to download from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Connect** > **Client download**.
1. Select **Download Client**.
:::image type="content" source="media/how-to-install-macos-client/client-download-screen.png" alt-text="Screenshot of the Client download screen with the Download Client button highlighted.":::
    
## Install the Global Secure Access client
### Automated installation
Organizations can install the Global Secure Access client silently with the `/quiet` switch, or use Mobile Device Management (MDM) solutions, such as [Microsoft Intune](/mem/intune/apps/apps-win32-app-management) to deploy the client to their devices.

### Manual installation


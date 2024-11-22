---
title: Deploy Application Discovery (Preview)
description: Use Application discovery to detect the applications accessed by users and create separate private applications.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/21/2024
ms.author: jayrusso
author: HULKsmashGithub
manager: amycolannino
ms.reviewer: lirazbarak


# Customer intent: As an administrator, I want to deploy Application discovery so I can detect the applications accessed by users and create separate private applications.
---
# Deploy Application discovery (Preview)
Application discovery, a part of Quick Access, is a tool administrators can use to gain visibility and insight about who uses which applications in their corporate network.  

With Quick Access, you can quickly onboard to Private Access by publishing wide IP ranges and wildcard FQDNs, in a way as you would with traditional VPN solutions. You can then transition from Quick Access to per-application publishing for better control and granularity over each application. For example, you can create a conditional access policy and set user assignments per application.  

This article walks through the process of using Application discovery to detect which applications users access (through Quick Access) and creating separate private applications.

## Prerequisites

- A Microsoft Entra tenant onboarded to [Microsoft Entra Private Access](concept-private-access.md).
- A Microsoft Entra tenant configured with [Quick Access](how-to-configure-quick-access.md).
- 

## The Application discovery main blade   
The Application discovery blade shows a list of all the application segments in Quick Access that users accessed via the Global Secure Access client in the last 30 days.  

Open the Entra portal and access the Application discovery blade under Global Secure Access, applications.  

 

 

By default, the application segments are sorted by descending order of the number of users, in order to make the application segments that are most heavily used more visible to the administrator.  

The administrator can adjust the time range, add filters and sort the application segments according to the different columns.  

Moreover, the administrator can use “filter by user” to see the list of the application segments access by a specific user.  

The search box allows to filter FQDN, IP and port.  
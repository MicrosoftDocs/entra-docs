---
title: Log latency for Microsoft Entra ID
description: Reference information for the factors that drive sign-in and audit log latency in Microsoft Entra ID
author: shlipsey3
manager: amycolannino
ms.service: active-directory
ms.topic: reference
ms.subservice: report-monitor
ms.date: 01/04/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg14
---

# Log latency in Microsoft Entra ID

Latency is the amount of time it takes for Microsoft Entra ID reporting data to appear in the Monitoring and health logs. This article describes the factors that can affect latency.

## Latency and first-time setup

When you upgrade from a free version of Microsoft Entra Premium P1 or P2, you should expect a delay of roughly 24 hours from when you upgrade your tenant before all premium reporting features show data. Many premium reporting features only begin retaining data after this 24-hour period following your upgrade.

When setting up a new storage account or security information and event management (SIEM) tool, you should also expect a delay of 24 hours before reporting data appears in those tools.

## Reporting latency factors

Many factors influence the latency of reporting data. The type of data, the amount of data, and the infrastructure that the reporting tools are built on can all influence latency. If there's a delay in the underlying infrastructure, Azure AD reports may experience a delay in reporting data.

One key factor in log latency is the path that the data travels from the source event to the logs in the Microsoft Entra admin center. Log data travels through the following systems before it appears in the logs.

1. Customer signs in to a service that uses Microsoft Entra ID as the identity and access service.
1. Log processors read the event metadata and publish it to the Azure storage queue.
1. Event metadata is processed and reviewed for success or failure.
1. Successful events are published to partner services, such as Azure Monitor and Microsoft Graph.
1. Customer views the data in the Microsoft Entra admin center, or their SIEM tool of choice.

There are many more steps in this process that aren't reflected here. Even with these summarized steps, it's easy to see how latency can be introduced into the system.
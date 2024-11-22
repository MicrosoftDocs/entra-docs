---
title: Improve the performance of Log Analytics and workbooks
description: Learn how to improve the performance of your Log Analytics workspaces and workbooks in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: monitoring-health
ms.topic: tutorial
ms.date: 11/22/2024
ms.author: sarahlipsey
author: shlipsey3
manager: amycolannino
ms.reviewer: sandeo

# Customer intent: As an IT admin, I want to exclude some unnecessary logs from the logs I integrate with Log Analytics so I can improve the performance of my analysis tools.

---
# Tutorial: Improving performance of sign-in logs and Log Analytics

In this tutorial, you learn how to:

> [!div class="checklist"]
> * Set up an Azure event hub
> * Stream sign-in logs to the event hub
> * Create a custom Log Analytics table
> * Create an Azure function to connect the event hub with the Log Analytics table
> * Remove Conditional Access policies from the logs

## Prerequisites

To complete the steps in this tutorial, you need the following roles and requirements:

- [Microsoft Entra monitoring and health licensing](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health)

- [Access to create a Log Analytics workspace](/azure/azure-monitor/logs/manage-access)

- The appropriate role for Azure Monitor:
  - Monitoring Reader
  - Log Analytics Reader
  - Monitoring Contributor
  - Log Analytics Contributor

- The appropriate role for Microsoft Entra ID:
  - Reports Reader
  - Security Reader
  - Global Reader
  - Security Administrator

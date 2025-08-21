---
title: Managed identity sign-in logs
description: Learn about the type of information captured in the managed identity sign-in logs in Microsoft Entra monitoring and health.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: troubleshooting-general
ms.subservice: monitoring-health
ms.date: 03/17/2025
ms.author: sarahlipsey
ms.reviewer: egreenberg14
ms.custom: sfi-image-nochange
# Customer intent: As an IT admin, I need to know what information is captured in the managed identity sign-in logs so that I can use the logs to monitor the health of my tenant and troubleshoot issues.
---
# What are managed identity sign-ins in Microsoft Entra?

Managed identities for Azure resources sign-ins are sign-ins that were performed by resources that have their secrets managed by Azure to simplify credential management. A VM with managed credentials uses Microsoft Entra ID to get an Access Token.

![Screenshot of the managed identity sign-in log.](media/concept-managed-identity-sign-ins/sign-in-logs-managed-identity.png)

You can't customize the fields shown in this report.

To make it easier to digest the data, these sign-in events are grouped together. Sign-ins from the same entity are aggregated into a single row. You can expand the row to see all the different sign-ins and their different time stamps. Sign-ins are aggregated in the managed identities report when all of the following data matches:

- Managed identity name or ID
- Status
- Resource name or ID

Select an item in the list view to display all sign-ins that are grouped under a node. Select a grouped item to see all details of the sign-in.

> [!NOTE]
> Entries in the sign-in logs are system generated and can't be changed or deleted.

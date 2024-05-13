---
title: 'Custom reports using Microsoft Entra and application data'
description: Tutorial that describes how to create customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: overview
ms.date: 01/05/2023
ms.author: billmath
---

# Tutorial: Customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID.

n this tutorial, you will learn how to create customized entitlement reports in Azure Data Explorer (ADX) using data from Microsoft Entra ID. This tutorial complements other reporting options such as [Archive & report with Azure Monitor and entitlement management](entitlement-management-logs-and-reporting.md) which focuses on exporting audit log data for longer retention and analysis. By comparison, exporting Entra ID data to Azure Data Explorer provides greater flexibility for creating custom reports by allowing data aggregation from multiple sources with massive scalability, and flexible schema and retention policies. 

This report illustrates how to show configuration, users and access rights exported from Microsoft Entra alongside data exported from other sources, such as applications with a SQL database.  You can then use the Kusto Query Language (KQL) to build custom reports based on your organization's requirements. Generating these types of reports within Azure Data Explorer may be especially helpful if you need to retain access data for longer periods, perform ad-hoc investigations, or need to run custom queries on user access data. 
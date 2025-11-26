---
title: Microsoft Entra Private Access and Microsoft Entra Internet Access data storage and privacy
description: Global Secure Access includes Microsoft Entra Private Access and Microsoft Entra Internet Access. This article outlines data storage and privacy information.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: reference
ms.date: 02/21/2025
ms.service: global-secure-access
ai-usage: ai-assisted
---

# Global Secure Access data storage and privacy

Frequently asked questions regarding privacy and data handling for Microsoft 365 enriched logs.

We prioritize the protection of your data and understand the importance of transparency, especially when it comes to data processing and privacy. This article outlines the stringent standards that give you a comprehensive understanding of how your data is handled and the measures put in place to ensure its security.

## What data does Global Secure Access process?

**Microsoft 365 Audit Logs Subset** - By integrating Global Secure Access with Microsoft 365 workloads, a subset of your Microsoft 365 audit logs are copied and sent to the Global Secure Access service for processing.

## Data retention and storage

**Azure Event Hubs disk storage** - Enriched logs are stored on the Azure Event Hubs disk.

**Retention Period** - The data is retained for a duration of 24 hours. Once the data is in the customer repository, it remains there, and Global Secure Access retains its copy for a 24-hour period.

## Data isolation and access

**Access Authentication** - Robust access authentication mechanisms are implemented to ensure only authorized individuals access the data.

## Data processing locations

**Geographical Processing** - All data processing strictly occurs within the US or Europe, based on the following criteria:

- **Europe** - Data from the European customers are processed in the Global Secure Access Europe datacenters. 
- **All Other Locations** - Data from any other customers are processed in the Global Secure Access U.S. datacenters.

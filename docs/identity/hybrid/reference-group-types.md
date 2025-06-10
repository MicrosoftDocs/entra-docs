---
title: Security Groups and Modern Group Types in Microsoft 365
description: Learn how to map on-premises security, distribution, and mail-enabled groups to modern Microsoft 365 group types for access control and collaboration.
author: Justinha
contributors:
ms.topic: conceptual
ms.date: 06/02/2025
ms.author: justinha
ms.reviewer: justinha
---

# How AD groups translate to cloud groups after SOA transfer

Security groups are fundamental for access control, policy management, and other critical functions. In most collaboration scenarios, Microsoft 365 groups are recommended due to their enhanced collaboration features, self-service options, and API capabilities. Distribution groups (DLs) and mail-enabled security groups (MESGs) remain viable options, particularly for Exchange administrators.

## Modern group type matching

When you transition to the cloud, map on-premises groups to modern group types in Microsoft Entra, Exchange Online, and Microsoft 365. The following table provides information about how to map groups ans manage them after SOA conversion.

| On-premises group type | Cloud group type | How they are managed after SOA conversion | Description |
|-----------------------|------------------|------------------------------------------|-------------|
| Security group | Microsoft Entra Security Group (not mail enabled) | Microsoft Entra admin center <br> Microsoft Graph APIs | Vital for access control and translate directly as Microsoft Entra security groups, offering management by Microsoft Graph and various admin centers, including the Microsoft Entra admin center. |
| Mail-enabled security group (Exchange on-premises) | Mail-enabled SG (read-only in Microsoft Entra ID and managed in Exchange) | Exchange Online or PowerShell | Can migrate directly, or be recreated as security-enabled Microsoft 365 Groups ([Create group](/graph/api/group-post-groups)). If email functionality is no longer needed, they may be recreated as Microsoft Entra security groups. Mail-enabled security groups are only editable by using Exchange or PowerShell. Security groups and Microsoft 365 groups are managed with Microsoft Graph and various admin centers, including the Microsoft Entra admin center. |
| Distribution List (Exchange on-premises) | Distribution List (read-only for Microsoft Entra and managed in Exchange) | Exchange Online or via PowerShell | Are for email-only communication. They can be migrated as Exchange Online Distribution Lists, and managed by using Exchange Online or Exchange PowerShell. They can then be converted to, or recreated, as Microsoft 365 groups. They enable shared files, calendars, Teams integration, and self-service management with Outlook, Teams, My Groups, or Microsoft Graph. |
| N/A (In the past with v1) | Microsoft 365 groups (cloud only) | Microsoft Entra admin center <br> Microsoft Graph APIs |  |

## Related content


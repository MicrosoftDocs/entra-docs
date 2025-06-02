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

Security Groups are fundamental for access control, policy management, and other critical functions. In most collaboration scenarios, Microsoft 365 Groups are recommended due to their enhanced collaboration features, self-service options, and API capabilities. Distribution Groups (DLs) and Mail-enabled Security Groups (MESGs) remain viable options, particularly for Exchange administrators.

Modern group type matching

When transitioning on-premises groups to the cloud, map each to modern group types in Microsoft Entra, Exchange Online, and Microsoft 365. The following table provides information on group mapping.

| On-premises group type | Cloud group type | How they are managed after SOA conversion | Description |
|-----------------------|------------------|------------------------------------------|-------------|
| Security Group | Entra Security Group (not mail enabled) | Microsoft Entra admin center <br> MS Graph APIs | Vital for access control and translate directly as Microsoft Entra Security Groups, offering management via MS Graph and various admin consoles including the Microsoft Entra admin center. |
| Mail Enabled SG (Exchange on-premises) | Mail enabled SG (Read only in Entra + managed in Exchange) | Exchange Online or via PowerShell | Can migrate directly or be recreated as security-enabled Microsoft 365 Groups (Create group - Microsoft Graph v1.0 Microsoft Learn). If email functionality is no longer needed, they may be recreated as Entra Security Groups. MESGs are only editable via Exchange or PowerShell. SGs and Microsoft 365 Groups are managed with Microsoft Graph, and various admin consoles including the Microsoft Entra admin center. |
| Distribution List (exchange on prem) | Distribution List (Read only for Entra + managed in Exchange) | Exchange Online or via PowerShell | Are for email-only communication. They can be migrated as Exchange Online DLs, manageable via Exchange Online or Exchange PowerShell. They can then be converted to or recreated as Microsoft 365 Groups, which enable shared files, calendars, Teams integration, and self-service management with Outlook, Teams, My Groups, or Microsoft Graph. |
| N/A (In the past with v1) | Microsoft 365 Groups (cloud only) | Microsoft Entra admin center <br> MS Graph APIs |  |

## Related content


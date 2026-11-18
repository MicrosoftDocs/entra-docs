---
title: Microsoft Entra Backup and Recovery Premium pricing (preview)
description: Learn how Microsoft Entra Backup and Recovery Premium pricing works and estimate monthly costs based on the number of protected objects.
author: tazkiaafra
ms.author: tazkiaafra
ms.date: 11/16/2026
ms.service: entra-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated

#customer intent: As an identity administrator, I want to estimate Microsoft Entra Backup and Recovery Premium costs so that I can plan my organization's backup budget.
---

# Microsoft Entra Backup and Recovery Premium pricing (preview)

Microsoft Entra Backup and Recovery Premium uses consumption-based pricing. The price is $0.025 USD per protected Microsoft Entra object per month.

Use the pricing formula and example in this article to estimate your monthly cost. The estimate helps with planning, but your actual charges depend on billed usage.

> [!NOTE]
> The Premium plan is in preview and must be turned on in the Microsoft 365 admin center. To get started, see [Set up Microsoft 365 Backup](/microsoft-365/backup/backup-setup?view=o365-worldwide).

## Pricing model

Estimate the monthly cost by multiplying the number of protected Microsoft Entra objects by the monthly price per object:

`Estimated monthly cost = number of protected objects × $0.025 USD`

The estimate uses the number of protected objects as its input.

## Pricing example

The following examples estimate the cost for a full month when the protected-object count remains constant.

| Protected objects | Calculation | Estimated monthly cost |
| --- | --- | ---: |
| **10,000** | 10,000 × $0.025 USD | $250 USD |
| **50,000** | 50,000 × $0.025 USD | $1,250 USD |
| **100,000** | 100,000 × $0.025 USD | $2,500 USD |
| **500,000** | 500,000 × $0.025 USD | $12,500 USD |
| **1,000,000** | 1,000,000 × $0.025 USD | $25,000 USD |

## Billing through Microsoft 365 Backup

Billing for Premium is processed through Microsoft 365 Backup. For commerce billing, protected-object usage is represented as GB-based billing units. These units don't indicate the amount of backup storage consumed. For details, see the [Microsoft 365 Backup pricing model](/microsoft-365/backup/backup-pricing?view=o365-worldwide).

## Related content

- [Compare Standard and Premium plans](backup-recovery-plans.md)
- [Microsoft Entra Backup and Recovery overview](overview.md)
- [Pricing model for Microsoft 365 Backup](/microsoft-365/backup/backup-pricing?view=o365-worldwide)

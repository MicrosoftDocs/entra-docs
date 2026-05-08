---
title: Estimate Cost Savings for Account Recovery in Microsoft Entra ID
description: Use the cost savings estimator to compare help desk recovery costs against self-service account recovery in Microsoft Entra ID and project potential savings.
author: tilarso
ms.author: tilarso
ms.service: entra-id
ms.topic: how-to
ms.date: 04/02/2026
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange, msecd-doc-authoring-1012

#customer intent: As an identity administrator, I want to estimate cost savings for account recovery so that I can build a business case for enabling self-service account recovery in my organization.

---

# Estimate cost savings for account recovery in Microsoft Entra ID

The cost savings estimator helps organizations understand the potential financial and productivity benefits of enabling account recovery in Microsoft Entra ID. This tool compares the cost and time impact of traditional help desk recovery versus self-service recovery, providing an estimate of:

- Monthly cost savings
- Time gained per month

> [!IMPORTANT]
> Savings shown are estimates based on industry averages and **aren't guaranteed amounts**. Actual savings might vary depending on your subscription, licensing, and internal cost structures.

## How the cost savings estimator works

The estimator calculates:

- Monthly cost savings: The difference between help desk and self-service recovery costs.

- Time gained per month: The reduction in productivity time that's lost when users recover accounts.

### Inputs 

You provide the values from the following table.

Field | Description
------|------------
Total users in your organization | Number of active users who may require account recovery. (Defaults to total number of enabled users in the tenant)
Percentage of monthly recoveries | Estimated percentage of users needing account recovery each month.
Average cost for Mid-tier help desk | Typical cost per recovery handled by help desk (industry average: $60).
Productivity time lost (minutes) | Average time a user is unable to work during recovery.<br>*Help desk scenario*: longer (for example, 60 minutes)<br>*Self-service scenario*: shorter (for example, 5 minutes)

### Outputs

The tool displays two comparison panels:

- Traditional Help Desk: shows total monthly cost and time lost based on your inputs.
- Self-Service Account Recovery (SSAR): shows reduced cost and time lost when using self-service recovery.

At the bottom, you’ll see:

- Monthly cost savings: estimated dollar savings.
- Time gained per month: productivity hours regained.

## Use the estimator

1. Enter your organization’s user count and recovery percentage.
1. Adjust cost and time values to reflect your environment.
1. Compare totals for help desk compared to self-service recovery.
1. Use the savings estimate to: 
   - Build a business case for self-service account recovery adoption.
   - Communicate ROI to stakeholders.
   - Plan operational improvements.

## Best practices

- Use realistic values based on your internal help desk costs and recovery times.
- Revisit estimates periodically as user counts and recovery patterns change.
- Combine data with licensing and subscription details for accurate ROI calculations.


## Example of cost savings estimate

For an organization with:

- 112 users
- 3% monthly recoveries
- Help desk cost: $60 per recovery, 60 minutes lost
- Self-service cost: $2 per recovery, 5 minutes lost

Estimated savings:

- $195 per month
- 3.1 hours regained per month

## Related content

- [Overview of Microsoft Entra account recovery](concept-account-recovery-overview.md) - Learn more about Microsoft Entra account recovery.
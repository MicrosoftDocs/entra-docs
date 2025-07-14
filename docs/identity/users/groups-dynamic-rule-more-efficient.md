---
title: Create Simpler and Faster Rules for Dynamic Membership Groups
description: Learn how to optimize your membership rules to automatically populate groups.

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 01/15/2025
ms.author: barclayn
ms.reviewer: jordandahl
ms.custom: it-pro
---


# Create simpler, more efficient rules for dynamic membership groups in Microsoft Entra ID

This article discusses the most common methods that you can use to simplify your rules for dynamic membership groups. Rules that are simpler and more efficient result in better processing times for dynamic groups.

When you're writing membership rules for dynamic membership groups, follow the tips in this article to ensure that you create these rules as efficiently as possible.

## Minimize use of the -match operator

Minimize your use of the `-match` operator in rules as much as possible. Instead, explore if it's possible to use the `-startswith` or `-eq` operator. Consider using other properties that allow you to write rules to select the users for a group without using the `-match` operator.

For example, if you want a rule for the group that contains all users whose city is Lagos, don't use a rule like these:

- `user.city -match "ago"`
- `user.city -match ".*?ago.*"`

It's better to use a rule like this example:

- `user.city -startswith "Lag"`

Or, best of all:

- `user.city -eq "Lagos"`

## Minimize use of the -contains operator

As with `-match`, minimize your use of the `-contains` operator in rules as much as possible. Instead, explore if it's possible to use the `-startswith` or `-eq` operator. Using `-contains` can increase processing times, especially for tenants that have many dynamic membership groups.

## Use fewer -or operators

Identify when your rule uses various values for the same property, linked together with `-or` operators. Instead, use the `-in` operator to group them into a single criterion. A single criterion makes the rule easier to evaluate.

For example, don't use a rule like this one:

```
(user.department -eq "Accounts" -and user.city -eq "Lagos") -or 
(user.department -eq "Accounts" -and user.city -eq "Ibadan") -or 
(user.department -eq "Accounts" -and user.city -eq "Kaduna") -or 
(user.department -eq "Accounts" -and user.city -eq "Abuja") -or 
(user.department -eq "Accounts" -and user.city -eq "Port Harcourt")
```

It's better to use a rule like this example:

- `user.department -eq "Accounts" -and user.city -in ["Lagos", "Ibadan", "Kaduna", "Abuja", "Port Harcourt"]`

Conversely, identify similar subcriteria with the same property not equal to various values that are linked with `-and` operators. Then use the `-notin` operator to group them into a single criterion to make the rule easier to understand and evaluate.

For example, don't use a rule like this one:

- `(user.city -ne "Lagos") -and (user.city -ne "Ibadan") -and (user.city -ne "Kaduna") -and (user.city -ne "Abuja") -and (user.city -ne "Port Harcourt")`

It's better to use a rule like this example:

- `user.city -notin ["Lagos", "Ibadan", "Kaduna", "Abuja", "Port Harcourt"]`

## Avoid redundant criteria

Ensure that you aren't using redundant criteria in your rule. For example, don't use a rule like this one:

- `user.city -eq "Lagos" or user.city -startswith "Lag"`

It's better to use a rule like this example:

- `user.city -startswith "Lag"`

## Related content

- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)

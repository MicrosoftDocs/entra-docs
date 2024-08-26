---
title: Create simpler and faster rules for dynamic membership groups
description: How to optimize your membership rules to automatically populate groups.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 08/25/2024
ms.author: barclayn
ms.reviewer: jordandahl
ms.custom: it-pro
---


# Create simpler, more efficient rules for dynamic membership groups in Microsoft Entra ID

The Microsoft Entra ID engineering team, part of Microsoft Entra, receives reports of incidents related to dynamic membership groups and the processing time for their membership rules. The information that is reported is presented in this article. This article also discusses the most common methods by which Microsoft helps customers to simplify their rules for dynamic membership groups. Simpler and more efficient rules result in better dynamic group processing times. 

When writing membership rules for dynamic membership groups, follow the steps in this article to ensure that you create these rules as efficiently as possible.

## Minimize use of MATCH

Minimize the usage of the `match` operator in rules as much as possible. Instead, explore if it's possible to use the `startswith` or `-eq` operators. Considering using other properties that allow you to write rules to select the users you want to be in the group without using the `-match` operator. For example, if you want a rule for the group for all users whose city is Lagos, then instead of using rules like:

- `user.city -match "ago"`
- `user.city -match ".*?ago.*"`

It's better to use rules like:

- `user.city -startswith "Lag"` 

Or, best of all:

- `user.city -eq "Lagos"`

## Minimize use of CONTAINS

Similar to the use of MATCH. Minimize the usage of the `contains` operator in rules as much as possible. Instead, explore if it's possible to use the `startswith` or `-eq` operators. Utilizing CONTAINS can increase processing times, especially for tenants with many dynamic membership groups.

## Use fewer OR operators

In your rule, identify when it uses various values for the same property linked together with `-or` operators. Instead, use the `-in` operator to group them into a single criterion to make the rule easier to evaluate. For example, instead of having a rule like this:

```
(user.department -eq "Accounts" -and user.city -eq "Lagos") -or 
(user.department -eq "Accounts" -and user.city -eq "Ibadan") -or 
(user.department -eq "Accounts" -and user.city -eq "Kaduna") -or 
(user.department -eq "Accounts" -and user.city -eq "Abuja") -or 
(user.department -eq "Accounts" -and user.city -eq "Port Harcourt")
```

It's better to have a rule like this:

- `user.department -eq "Accounts" -and user.city -in ["Lagos", "Ibadan", "Kaduna", "Abuja", "Port Harcourt"]`

Conversely, identify similar sub criteria with the same property not equal to various values, that are linked with `-and` operators. Then use the `-notin` operator to group them into a single criterion to make the rule easier to understand and evaluate. For example, instead of using a rule like this:

- `(user.city -ne "Lagos") -and (user.city -ne "Ibadan") -and (user.city -ne "Kaduna") -and (user.city -ne "Abuja") -and (user.city -ne "Port Harcourt")`

It's better to use a rule like this:

- `user.city -notin ["Lagos", "Ibadan", "Kaduna", "Abuja", "Port Harcourt"]`

## Avoid redundant criteria

Ensure that you aren't using redundant criteria in your rule. For example, instead of using a rule like this:

- `user.city -eq "Lagos" or user.city -startswith "Lag"`

It's better to use a rule like this:

- `user.city -startswith "Lag"`


## Next steps

- [Create a dynamic group](groups-dynamic-membership.md)

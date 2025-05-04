---
title: Understand and Manage Dynamic Group Processing in Microsoft Entra ID
description: Learn how dynamic group management works. 
author: barclayn
manager: femila
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 04/08/2025
ms.author: barclayn
ms.reviewer: mbhargava
---

# Understand and manage dynamic group processing in Microsoft Entra ID

Dynamic membership groups in Microsoft Entra ID are a powerful feature that enables administrators to automate the management of group memberships. Changes to memberships are typically processed within a few hours.

However, under certain conditions, customers can experience delays in membership updates. Processing can take more than 24 hours. Understanding the underlying causes can help admins optimize their configurations and avoid unnecessary processing bottlenecks.

## How dynamic group processing works

Dynamic group processing operates in a sequential manner. Changes for a single tenant are evaluated and applied in order, rather than all at once. Large volumes of changes, especially when they affect many users or devices, can lead to long processing queues. The long queues can extend the time required for updates to finish processing.

### Key factors that affect processing time

The three biggest factors that influence processing and can cause membership updates to take longer are:

- **Number of dynamic groups**: Tenants that have a large number of dynamic groups require more evaluations, increasing processing time.

- **Number of object changes**: A high volume of user or device changes can create a long processing queue and extend the processing time. Examples include changes to extension attributes, device additions or removals, and bulk user updates.

- **Rule configuration**: Certain rule configurations can affect processing time. For instance, the choice of inefficient operators like `Match`, `Contains`, or `memberOf` can increase processing time. Rule complexity is also a contributing factor.  

## Best practices for managing dynamic membership groups in your tenant

To help ensure efficient processing and minimize delays, consider the following best practices.

### Monitor the number of dynamic membership groups in your tenant

Regularly review the number of groups in your tenant. Delete inactive or outdated groups.

### Pause nonessential groups

You can pause nonessential groups to improve processing performance. You might consider pausing group processing in these circumstances:

- **Planned large-scale updates**: You anticipate making a large number of changes to group membership. For example, you plan to make changes to more than 500 groups or make more than 20,000 membership changes.
- **Unexpected delays**: You notice that group membership hasn't changed and you encounter unexpected delays.  

To temporarily halt processing, use the **Pause All Groups** script. Allow the service to recover before resuming.

Don't unpause the groups immediately. We recommend waiting a minimum of 24 hours to allow group processing to catch up. Then, check your audit logs to see if they're back to baseline. If necessary, unpause groups in phases rather than all at once.

### Optimize rule efficiency

- Avoid the use of the `Match` operator in rules as much as possible. Instead, use the `StartsWith`, `Equals`, or `EndsWith` operator.  

- Avoid the use of the `Contains` operator in rules as much as possible. It can lead to increased processing time.  

- Use fewer `-or` operators. Instead, use the `-in` operator to group rules into a single criterion. Grouping rules makes them easier to evaluate.  

- Avoid the use of the [`memberOf`](groups-dynamic-rule-member-of.md) operator if possible. It's currently in preview, and it comes with bugs and limitations. It can also introduce more complexity, particularly if a tenant has a large number of groups or frequent updates. The recommendation is to delete existing `memberOf` groups in your tenant.

For more help with optimizing dynamic group processing, review [Create simpler, more efficient rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-rule-more-efficient.md).

## Summary

Delays in dynamic group processing primarily happen due to high volumes of changes and large numbers of groups. By following best practices like optimizing rule efficiency, monitoring changes, and pausing nonessential groups when necessary, IT administrators can improve processing performance and avoid unnecessary delays.  

## Related content

- [Manage rules for dynamic membership groups in Microsoft Entra ID](groups-dynamic-membership.md)
- [Troubleshoot dynamic groups](/troubleshoot/entra/entra-id/dir-dmns-obj/troubleshoot-dynamic-groups)

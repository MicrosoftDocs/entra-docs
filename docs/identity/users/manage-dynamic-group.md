---
title: Understanding and Managing Dynamic Group Processing in Microsoft Entra ID
description: Learn how dynamic group management works. 
author: barclayn
manager: femila
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 04/01/2025
ms.author: barclayn
ms.reviewer: mbhargava
---

# Understanding and Managing Dynamic Group Processing  in Microsoft Entra ID

Dynamic membership groups in Microsoft Entra are a powerful tool that allows administrators to automate group membership management. Changes to membership typically process within a few hours. However, under certain conditions, customers can experience delays in membership updates. Processing can take more than 24 hours. Understanding the underlying causes can help admins optimize their configurations and avoid unnecessary processing bottlenecks. 

## How Dynamic Group Processing Works 

Dynamic group processing operates in a sequential manner, meaning changes for a single tenant are evaluated and applied in order rather than all at once. Large volumes of changes, especially those affecting many users or devices, can lead to long processing queues, extending the time required for updates to be complete processing.   

### Key Factors Affecting Processing Time

The three biggest factors influencing processing that can cause membership updates to take longer are: 

- **Number of dynamic groups**: Tenants with a large number of dynamic groups require more evaluations, increasing processing time. 

- **Number of object changes**: A high volume of user or device changes can create a long processing queue, extending the time taken to complete processing. Some examples include: changes to extension attributes, device additions or removals, and bulk user updates. 

- **Rule configuration**: Certain rule configurations can affect processing time. For instance, the choice of inefficient operators like Match, Contains, or MemberOf can increase processing time. Rule complexity is also a contributing factor.  

## Best Practices to manage dynamic membership groups in your tenant 

To ensure efficient processing and minimize delays, consider the following best practices: 

### **Monitor the number of dynamic membership groups in your tenant**:

Regularly review the number of groups in your tenant and delete inactive or outdated groups.

### **Pause non-essential groups**: 

If you anticipate making a large number of changes to group membership (for example – changes to more than 500 groups or making over 20,000 membership changes), pause nonessential groups to improve processing performance.

#### When to Pause Group Processing: 

- Planned large-scale updates: If you anticipate making a large number of changes to group membership (for example – changes to more than 500 groups or making over 20,000 membership changes). 

- Unexpected delays:  if you notice that group membership hasn't changed/ you encounter unexpected delays.  

#### How to Pause/resume:  

- Use the Pause All Groups script to temporarily halt processing and allow the service to recover before resuming. 

- Don't unpause the groups immediately. We recommend waiting a minimum of 24 hours to allow group processing to catch up and then look at your audit logs to see if they are back to baseline. If necessary, unpause groups in phases rather than all at once. 

### Optimizing Rule Efficiency 

- **Avoid the use of the Match operator** in rules as much as possible. Instead use the StartsWith, Equals, or EndsWith operators.  

- **Avoid Contains**: Similar to the use of Match, avoid the use of Contains operator in rules as much as possible as it can lead to increased processing time.  

- **Use fewer OR operators**: Instead, use the -in operator to group them into a single criterion to make the rules easier to evaluate.  

- **Minimize use of MemberOf at this time**: [```memberOf```](groups-dynamic-rule-member-of.md), which is currently in preview, can introduce more complexity, particularly if a tenant has a large number of groups or frequent updates. Avoid using this operator if possible as it comes with bugs and limitations. The recommendation is to delete existing MemberOf groups in your tenant: Learn More 

>[!NOTE]
> Review [Create simpler and more efficient rules](groups-dynamic-rule-more-efficient.md) to help you optimize dynamic group processing.



## Additional Troubleshooting Resources 

Delays in dynamic group processing primarily happen due to high volumes of changes and large numbers of groups. By following best practices—such as optimizing rule efficiency, monitoring changes, and pausing nonessential groups when needed—IT administrators can improve processing performance and avoid unnecessary delays.  

>[!NOTE]
> Review detailed information on pausing group processing in [Troubleshoot dynamic group processing](/troubleshoot/entra/entra-id/dir-dmns-obj/troubleshoot-dynamic-groups)

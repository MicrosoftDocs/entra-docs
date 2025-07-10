---
title: Self-service group management guidance for Group Source of Authority (SOA) 
description: Learn how to set up self-service group management for SOA converted security groups.
author: Justinha
ms.topic: how-to
ms.date: 06/17/2025
ms.author: justinha
manager: dougeby
ms.reviewer: mbhargav
---

# Self-service group management guidance for Group Source of Authority (SOA) 

This document outlines how self-service group management works in Microsoft Entra after Source of Authority (SOA) is flipped for different group types. It also highlights key limitations and recommended actions for each of these group types:

- [Security groups](#security-groups)
- [Mail-enabled security groups](#mail-enabled-security-groups)
- [Distribution groups](#distribution-groups)

## Security groups

### Self-service management experience

After the SOA is flipped to Microsoft Entra, security groups become fully manageable as Microsoft Entra security groups through self-service experiences:

- [My Groups](myaccount.microsoft.com/groups) - Group owners can manage membership, view group details, and perform other self-service tasks. Tenant admins must explicitly enable security groups for self-service management in My Groups in the Microsoft Entra ID tenant settings. For more information, see [Set up self-service group management in Microsoft Entra ID](/entra/identity/users/groups-self-service-management).
- Microsoft Entra Admin Center - Admins can manage group settings and ownership.
- Microsoft Graph - Automation and bulk management via API.


### Supported scenarios

- Assigning roles and permissions
- Applying Conditional Access policies
- Controlling access to apps and resources
- Managing group membership, ownership, and properties
- Scoping of Access Package assignment policies
- Triggering LCW workflow execution

### Governance integration

Security groups in Microsoft Entra can be integrated with governance features:

- Access packages (via Entitlement Management): Bundle and delegate access to resources, automate approval workflows, and manage access lifecycle.
- Lifecycle workflows: Automate user and group lifecycle events, such as provisioning, deprovisioning, and access review.

### How to enable self-service and correct group ownership and join policies

1. Populate group owners: Ensure group ownership is established in your on-premises group management tool before you flip SOA.
1. Flip SOA: Transition the group source of authority to Microsoft Entra.
1. Set self-service group management policies (if applicable): If your organization uses **Self-Service Group Management**, manually apply policies in **My Groups** after the group is transferred.

## Mail-enabled security groups

### Self-service management xperience
After SOA is flipped, mail-enabled security groups become cloud-managed mail-enabled security groups.

There are some limitations for cloud-managed mail-enabled security groups:
- These groups are read-only in Microsoft Entra.
- They can't be managed through My Groups or self-service interfaces.
- Management is only available to admins by using Exchange Online Admin Center or Exchange PowerShell.

As a workaround if self-service management is required, consider converting mail-enabled security groups to standard security groups in your on-premises environment and then flipping SOA. This workaround removes the mail-enabled capability of the group.

### Governance integration

Mail-enabled security groups are currently not compatible with Microsoft Entra governance features such as Access Packages, or Lifecycle Workflows.

## Distribution groups

### Self-service management experience
After SOA is flipped, on-premises distribution lists can be transitioned to cloud-managed distribution groups. Where possible, convert distribution groups to Microsoft 365 Groups for full self-service and governance integration. For more information, see [Create and manage distribution groups](https://support.microsoft.com/office/distribution-groups-e8ba58a8-fab2-4aaf-8aa1-2a304052d2de#bkmk_create).

### Limitations
- Cloud distribution groups can't be managed by using **My Groups**.
- Self-service management is only possible through Exchange’s end user self-service portal (link).
- Nested distribution groups  are not supported for direct conversion to Microsoft 365 Groups.

### Governance integration

Distribution groups can't be used with Microsoft Entra Governance features, such as Access Packages, or Lifecycle Workflows. However, if distribution groups are converted to M365 Groups, governance scenarios are unblocked. 

## Summary table

Group Type|Self-service in My Groups | Management experience|Governance Support|Recommended Action
----------|--------------------------|--------------------|------------------|------------------
Security Group|Yes|Entra Admin, Graph, My Groups|Yes|Populate owners, flip SOA, use self-service group management
Mail-Enabled Security Group|No (read-only) | Exchange Online, PowerShell<br>No self-service experience for end users|No|Convert to security group if needed
Distribution Group|No|Exchange Admin Center, Exchange Self-Service Portal|No|Convert to Microsoft 365 group if possible

## Key takeaways for admins

- Enable Security Groups for Self-Service: Set this in Microsoft Entra Admin Center before user rollout.
- Establish Group Ownership: Ownership must be set on-prem before flipping SOA to ensure proper self-service experience.
- Governance Scenarios: Only Microsoft Entra Security Groups and Microsoft 365 Groups support governance features. Distribution groups and mail-enabled security groups do not.
- Plan for Limitations: Review current group types and consider conversion to Microsoft 365 Groups for the best end-user and governance experience.

For more information about group management, see [Learn about group types, membership types, and access management](/entra/fundamentals/concept-learn-about-groups).

## Related content

- Group SOA overview
- How to configure Group SOA
---
title: Enterprise user management with Microsoft Security Copilot
description: Use Microsoft Security Copilot in the Microsoft Entra admin center to manage users, tenants, groups, using natural language queries.
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.reviewer: ptyagi
ms.date: 09/23/2025
ms.update-cycle: 180-days
ms.topic: how-to
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As an IT administrator, I want to learn how to use Microsoft Security Copilot for enterprise user management so I can efficiently manage tenants, users, groups, and licenses in my organization, which I can use for audits and reviews.
---

# Enterprise user management with Microsoft Security Copilot

Microsoft Security Copilot streamlines enterprise user management in Microsoft Entra by enabling IT administrators to quickly manage users, tenants, groups, and licenses using natural language queries. This capability helps streamline administrative tasks, helping users keep identities secure and up to date, reduce time spent navigating portals and improving response times for identity-related requests.

This article describes how an IT administrator can prepare for a quarterly identity governance review, and how to use Microsoft Security Copilot for the following core identity management use cases in the Microsoft Entra admin center.

- [Understand tenant configuration](#understand-tenant-configuration)
- [Manage domain information](#manage-domain-information)
- [Investigate and manage users](#investigate-and-manage-users)
- [Organize and manage groups](#organize-and-manage-groups)
- [Analyze license usage and optimization](#analyze-license-usage-and-optimization)

Use the prompts and examples in this article to compile your findings into actionable insights and reports for reviews and audits by your team or management.

## Prerequisites

- A tenant with Security Copilot enabled. Refer to [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot#option-2-provision-capacity-in-azure) for more information.
- The following roles and licenses are required for different governance and optimization use cases:

    | Use Case |Role(s)|License|Tenant|
    |---|---|---|---|
    | Tenant information | [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | Any Microsoft Entra ID license | Any tenant  |
    | User management |[User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) | Any Microsoft Entra ID license | Any tenant |
    | Group management |[Directory Writer](/entra/identity/role-based-access-control/permissions-reference#directory-writer), [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator), or [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator)| Free Microsoft Entra license | Any public cloud tenant with groups |
    | Domain management  | [Domain Name Administrator](/entra/identity/role-based-access-control/permissions-reference#domain-name-administrator) | Any Microsoft Entra ID license | Any tenant |
    | License usage  | [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID Governance license](/entra/id-governance/licensing-fundamentals)      | Any tenant |

## Launch Security Copilot in Microsoft Entra

[!INCLUDE [Launch Security Copilot in Microsoft Entra](./includes/access-entra-copilot.md)]

## Understand tenant configuration

Begin your assessment by gathering essential tenant information to understand your overall Microsoft Entra configuration. This foundational knowledge helps you establish context for further analysis.

### Tenant identity and basic information

Start by retrieving key tenant details such as display name, tenant ID, and creation date to establish the scope of your review. Use the following prompts to get the information you need:

- *What is my tenant's display name?*
- *What is my tenant ID?*
- *Can users in my tenant create new tenants?*

### Tenant licensing and contacts

You can gather information about your tenant's licensing and assigned contacts for technical and security compliance matters, which can be useful for audits and executive reporting. Use these prompts to retrieve relevant details:

- *What are all the active licenses assigned to my tenant?*
- *Who is the technical contact for my tenant?*
- *Who is the security compliance contact for my tenant?*

## Manage domain information

As part of your tenant review, you can also verify domain configurations and DNS records to ensure that your domains are properly set up and secure. This helps prevent issues related to domain verification and or setup.

### Domain details and verification

Examine your domain configurations and DNS verification status to ensure that your domains are correctly set up, secured, and compliant with your organizational policies. Use the following prompts to get the information you need:

- *List details of contoso.com.*
- *Show me DNS verification records of contoso.com.*
- *What is my initial domain name?*

## Investigate and manage users

Next, focus on understanding the user landscape in your Microsoft Entra setup. You can analyze user accounts, organizational structure, authentication methods, and identify any inconsistencies that may require attention.

### User information and details

Begin by examining user details and organizational relationships to understand how employees are structured within the company and identify any anomalies. Use the following prompts to gather the information you need:

- *Show recently deleted users.*
- *Tell me about myself.*
- *Are there guest users in the Human Resources department?*
- *Show transitive reports of Brandon Artois.*
- *Give the member count of each department.*
- *Who is Asha Brunelle's manager?*
- *Is Blake Martin's account cloud managed?*
- *Show users by mail nickname.*

### User authentication and permissions

You can then review user authentication methods and permissions to ensure security compliance and identify users who may need extra authentication requirements. Use these prompts get the information you need:

- *What are Abbi Atin's authentication methods?*
- *Look up Abadi Bod's permissions.*
- *How many users are reporting to Brandon Artois?*

### User filtering and organization

To identify potential compliance issues, you can filter users based on specific criteria such as licensing status, departments, and account configurations. Use the following prompts to get the information you need:

- *List users without assigned licenses.*
- *List users in Finance or Marketing department.*
- *Show users not in {Company Name}.*
- *Show users with account disabled.*
- *Are there any users with {Specific license}?*

## Organize and manage groups

Continue your assessment by examining group management across your organization. Groups are essential for organizing users and managing access to resources, so understanding their configuration is crucial to ensure proper governance. It also helps identify any potential security risks associated with group memberships.

### Group membership and composition

Start by analyzing group membership patterns and identify potential issues such as ownerless groups or unusual membership types that could pose security risks. Use the following prompts to get the information you need:

- *Count the total ownerless groups in my tenant.*
- *Count the total user memberships for a group.*
- *Provide separate counts for users, groups, devices, and service principals in a group.*
- *How many different object types does a group have in total?*
- *Show me all user members of a group.*
- *Which users are included in a group?*

### Group configuration and roles

Continue by reviewing group configurations, role assignments, and dynamic membership rules to understand how your groups are structured and managed. Use the following prompts to get the information you need:

- *What directory roles are assigned to a group?*
- *Does this group have any built-in roles?*
- *Show me the membership rules for a group.*
- *Is the dynamic membership rule currently processing for a group?*
- *Give me the details of a group.*

### Group organization and governance

To maintain proper organization and governance, you can categorize and analyze groups by type and identify any inconsistencies or opportunities for optimization. Use the following prompts to get the information you need:

- *Show the count of groups categorized by group type.*
- *List the number of groups under each of the group types.*
- *How many groups exist for each group type?*

## Analyze license usage and optimization

Finally, you can review license usage and optimization opportunities to ensure that your organization is making the most of its Microsoft Entra investment. This helps identify underutilized licenses and optimize costs.

### License analysis and utilization

Use the following prompts to analyze your license allocation, usage patterns, and feature utilization for cost optimization and better license management for upcoming budget planning:

- *How many Microsoft Entra P1/P2 licenses do I have?*
- *Count of P1/P2 Microsoft Entra licenses.*
- *Number of Microsoft Entra ID P1/P2 licenses.*
- *What is the usage of Microsoft Entra P1/P2 license?*
- *Show me P1/P2 feature utilization.*
- *Provide Microsoft Entra P1/P2 license usage details.*

## Related content

- Learn more about [user management in Microsoft Entra ID](/entra/fundamentals/how-to-manage-user-profile-info)
- Learn more about [group management in Microsoft Entra ID](/entra/fundamentals/how-to-manage-groups)
- Learn more about [device management in Microsoft Entra ID](/entra/identity/devices/)
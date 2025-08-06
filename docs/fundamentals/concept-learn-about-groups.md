---
title: Learn about groups, group membership, and access
description: Learn about Microsoft Entra groups, including how they work, what they can access, and how membership and access is assigned.
author: shlipsey3
manager: femila

ms.service: entra
ms.subservice: fundamentals
ms.topic: article
ms.date: 02/12/2025
ms.author: sarahlipsey
ms.reviewer: krbain
---

# Learn about group types, membership types, and access management 

Microsoft Entra ID provides several ways to manage access to resources, applications, and tasks. With Microsoft Entra groups, you can grant access and permissions to a group of users instead of to each individual user. Limiting access to Microsoft Entra resources to only those users who need access is one of the core security principles of [Zero Trust](/security/zero-trust/zero-trust-overview).

This article provides an overview of how groups and access rights can be used together to make managing your Microsoft Entra users easier, while also applying security best practices.

> [!NOTE]
> **Some groups can't be managed in the Azure portal or Microsoft Entra admin center.**
> 
> - Groups synced from on-premises Active Directory can only be managed on-premises.
> - Distribution lists and mail-enabled security groups can only be managed in the [Exchange admin center](https://admin.cloud.microsoft/exchange#/groups) or the [Microsoft 365 admin center](https://admin.microsoft.com/Adminportal/Home?#/groups). You must sign in and have the appropriate permissions for that admin center to manage those groups.


## Microsoft Entra groups overview

Effective use of groups can reduce manual tasks, such assigning roles and permissions to individual users. You can assign roles to a group and assign members to a group based on their job function or department. You can create a Conditional Access policy that applies to a group, and then assign the policy to the group. Because of the potential uses for groups, it's important to understand how they work and how they're managed.

### Group types

You can manage two types of groups in the Microsoft Entra admin center:

- **Security groups:** Used to manage access to shared resources.
    - Members of a security group can include users, devices, [service principals](../architecture/service-accounts-principal.md).
    - Groups can be members of other groups, sometimes known as nested groups. *See note.*
    - Users and service principals can be the owner of a security group.

- **Microsoft 365 groups:** Provide collaboration opportunities.
    - Members of a Microsoft 365 group can only include users.
    - Users and service principals can be the owner of a Microsoft 365 group.
    - People outside of your organization can be members of a group.
    - For more information, see [Learn about Microsoft 365 Groups](https://support.office.com/article/learn-about-office-365-groups-b565caa1-5c40-40ef-9915-60fdb2d97fa2).

> [!NOTE]
> When nesting an existing security group to another security group, only members in the parent group have access to shared resources and applications. For more info about managing nested groups, see [How to manage groups](how-to-manage-groups.yml#add-a-group-to-another-group).


### Membership types

- **Assigned groups:** Lets you add specific users as members of a group and have unique permissions.
- **Dynamic membership group for users:** Lets you use rules to automatically add and remove users as members. If a member's attributes change, the system looks at your rules for dynamic membership groups for the directory. The system checks to see whether the member meets the rule requirements (is added), or no longer meets the rules requirements (is removed).
- **Dynamic membership group for devices:** Lets you use rules to automatically add and remove devices as members. If a device's attributes change, the system looks at your rules for dynamic membership groups for the directory to see whether the device meets the rule requirements (is added) or no longer meets the rules requirements (is removed).

> [!IMPORTANT]
> You can create a dynamic group for either devices or users, but not for both. You can't create a device group based on the device owners' attributes. Device membership rules can only reference device attributions. For more information, see [Create a dynamic group](../identity/users/groups-create-rule.md).

## Access management
<a name='how-access-management-in-azure-ad-works'></a>

Microsoft Entra ID helps you give access to your organization's resources by providing access rights to a single user or a group. Using groups lets the resource owner or Microsoft Entra directory owner assign a set of access permissions to all members of the group. The resource or directory owner can also grant group management rights to someone such as a department manager or a help desk administrator, which allows that person to add and remove members. For more information about how to manage group owners, see the [Manage groups](how-to-manage-groups.yml) article.

The resources that Microsoft Entra groups can manage access to can be:

- Part of your Microsoft Entra organization, such as permissions to manage users, applications, billing, and other objects.
- External to your organization, such as non-Microsoft Software as a Service (SaaS) apps.
- Azure services
- SharePoint sites
- On-premises resources

Each application, resource, and service that requires access permissions needs to be managed separately because the permissions for one might not be the same as another. Grant access using the [principle of least privilege](~/identity-platform/secure-least-privileged-access.md) to help reduce the risk of attack or a security breach.

### Assignment types

After creating a group, you need to decide how to manage its access.

- **Direct assignment.** The resource owner directly assigns the user to the resource.

- **Group assignment.** The resource owner assigns a Microsoft Entra group to the resource, which automatically gives all of the group members access to the resource. Both the group owner and the resource owner manage group membership, letting either owner add or remove members from the group. For more information about managing group membership, see the [Managed groups](how-to-manage-groups.yml) article. 

- **Rule-based assignment.** The resource owner creates a group and uses a rule to define which users are assigned to a specific resource. The rule is based on attributes that are assigned to individual users. The resource owner manages the rule, determining which attributes and values are required to allow access the resource. For more information, see [Create a dynamic group](..//identity/users/groups-create-rule.md).

- **External authority assignment.** Access comes from an external source, such as an on-premises directory or a SaaS app. In this situation, the resource owner assigns a group to provide access to the resource and then the external source manages the group members.

## Best practices for managing groups in the cloud

The following are best practices for managing groups in the cloud:  

- **Enable self-service group management:** Allow users to search for and join groups or create and manage their own Microsoft 365 groups.
    - Empowers teams to organize themselves while reducing the administrative burden on IT.
    - Apply a **group naming policy** to block the use of restricted words and ensure consistency.
    - Prevent inactive groups from lingering by enabling group expiration policies, which automatically deletes unused groups after a specified period, unless renewed by a group owner.
    - Configure groups to automatically accept all users that join or require approval.
    - For more information, see [Set up self-service group management in Microsoft Entra ID](../identity/users/groups-self-service-management.md).
- **Leverage sensitivity labels:** Use sensitivity labels to classify and govern Microsoft 365 groups based on their security and compliance needs.
    - Provides fine-grained access controls and ensures that sensitive resources are protected.
    - For more information, see [Assign sensitivity labels to Microsoft 365 groups in Microsoft Entra ID](../identity/users/groups-assign-sensitivity-labels.md)
- **Automate membership with dynamic groups:** Implement dynamic membership rules to automatically add or remove users and devices from groups based on attributes like department, location, or job title.
    - Minimizes manual updates and reduces the risk of lingering access.
    - This feature applies to Microsoft 365 groups and Security Groups.  
- **Conduct Periodic Access Reviews:** Use Microsoft Entra Identity Governance capabilities to schedule regular access reviews.
    - Ensures that membership in assigned groups remains accurate and relevant over time.
    - For more information, see [Create or update a dynamic membership group in Microsoft Entra ID](../identity/users/groups-create-rule.md)
- **Manage membership with access packages:** Create access packages with Microsoft Entra Identity Governance to streamline the management of multiple group memberships. Access packages can: 
    - Include approval workflows for membership 
    - Define criteria for access expiration 
    - Provide a centralized way to grant, review, and revoke access across groups and applications 
    - For more information, see [Create an access package in entitlement management](../id-governance/entitlement-management-access-package-create.md)   
- **Assign multiple group owners:** Assign at least two owners to a group to ensure continuity and reduce dependencies on a single individual.
    - For more information, see [Manage Microsoft Entra groups and group membership](how-to-manage-groups.yml)
- **Use group-based licensing:** Group-based licensing simplifies user provisioning and ensures consistent license assignments.
    - Use dynamic membership groups to automatically manage licensing for users meeting specific criteria.
    - For more information, see [What is group-based licensing in Microsoft Entra ID?](concept-group-based-licensing.md)
- **Enforce Role Based Access Controls (RBAC):** Assign roles to control who can manage groups.
    - RBAC reduces the risk of privilege misuse and simplifies group management.
    - For more information, see [Overview of role-based access control in Microsoft Entra ID](../identity/role-based-access-control/custom-overview.md)

## Related content

- [Create and manage Microsoft Entra groups and group membership](how-to-manage-groups.yml)
- [Manage access to SaaS apps using groups](~/identity/users/groups-saasapps.md)
- [Manage rules for dynamic membership groups](~/identity/users/groups-create-rule.md)

---
title: Phase 1 Implement the Microsoft Entra Permissions Management framework to manage at scale
description: Learn about folder structure, security groups, delegated permissions, lifecycle management, and Permissions Creep Index thresholds
author: jricketts
manager: martinco
ms.service: entra
ms.topic: conceptual
ms.date: 10/23/2023
ms.author: jricketts
---

# Phase 1: Implement the framework to manage at scale

This section of the Microsoft Entra Permissions Management operations reference guide describes the checks and actions you should consider taking to effectively delegate permissions and manage at scale.

## Define a delegated administration model

**Recommended owner: Information Security Architecture**

### Define Microsoft Entra Permissions Management administrators

To begin operationalizing Microsoft Entra Permissions Management, establish two to five Permissions Management Administrators who delegate permissions in the product, configure key settings, and create and manage your organization’s configuration.

>[!IMPORTANT]
> Microsoft Entra Permissions Management relies on users with valid email addresses. We recommend that your Permissions Management Administrators have mailbox enabled accounts.

Assign designated administrators the Permissions Management Administrator role in Microsoft Entra ID to perform needed tasks. We recommend you use [Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md) to provide your admins with just-in-time (JIT) access to the role, rather than permanently assigning it.

### Define and maintain folder structure

In Permissions Management, a folder is a group of authorization systems. We recommend you create folders based on your organizational delegation strategy. For example, if your organization delegates based on teams, create folders for:

* Production Finance
* Production Infrastructure
* Pre-Production Research and Development

An effective folder structure makes it easier to delegate permissions at scale, and provides your authorization system owners with a positive product experience.

To help streamline your environment, see [create folders to organize your authorization systems](~/permissions-management/how-to-create-folders.md).

<a name='create-microsoft-entra-id-security-groups-to-delegate-permissions'></a>

### Create Microsoft Entra security groups to delegate permissions

Microsoft Entra Permissions Management has a group-based access system that uses Microsoft Entra security groups to grant permissions to different authorization systems. To delegate permissions, your IAM team creates Microsoft Entra security groups that map to authorization system owners, and Permissions Management responsibilities you define. Ensure users with shared ownership and responsibilities in the product are in the same security group.

We recommend you use [PIM for Groups](~/id-governance/privileged-identity-management/concept-pim-for-groups.md). This provides JIT access to Permissions Management to users and aligns with Zero Trust JIT and just-enough-access principles.

To create Microsoft Entra security groups, see [manage groups and group membership](../fundamentals/how-to-manage-groups.yml).

### Assign permissions in Microsoft Entra Permissions Management

After Microsoft Entra security groups are created, a Permissions Management Administrator grants security groups needed permissions.

At a minimum, ensure security groups are granted **Viewer** permissions for the authorization systems they are responsible for. Use **Controller** permissions for security groups with members that perform remediation actions. [Learn more about Microsoft Entra Permissions Management roles and permission levels](~/permissions-management/product-roles-permissions.md).

For more on managing users and groups in Permissions Management:

* [Add or remove a user in Microsoft Entra Permissions Management](~/permissions-management/how-to-add-remove-user-to-group.md)
* [Manage users and groups with the User Management Dashboard](~/permissions-management/ui-user-management.md)
* [Select group-based permissions settings](~/permissions-management/how-to-create-group-based-permissions.md)

## Determine authorization system lifecycle management

**Recommended owners: Information Security Architecture and Cloud Infrastructure**

As new authorization systems are created, and current authorization systems evolve, create and maintain a well-defined process for changes in Microsoft Entra Permissions Management. The following table outlines tasks and recommended owners.

|Task|Recommended owner|
|---|---|
|Define the discovery process for new authorization systems created in your environment|Information Security Architecture|
|Define triage and onboarding processes for new authorization systems to Permissions Management|Information Security Architecture|
|Define administration processes for new authorization systems: delegate permissions and update folder structure|Information Security Architecture|
|Develop a cross-charge structure. Determine a cost-management process.|Owner varies by organization|

## Define a Permissions Creep Index strategy

**Recommended owner: Information Security Architecture**

We recommend you define goals and use cases for how Permissions Creep Index (PCI) drives Information Security Architecture activity and reporting. This team can define, and help others meet, target PCI thresholds for your organization.

### Establish target PCI thresholds

PCI thresholds guide operational behavior and serve as policies to determine when action is required in your environment. Establish PCI thresholds for:

* Authorization systems
* Human identity users
  * Enterprise Directory (ED)
  * SAML
  * Local
  * Guest
* Non-human identities

>[!NOTE]
> Because non-human identity activity varies less than a human identity, apply stricter right-sizing to non-human identities: set a lower PCI threshold.

PCI thresholds vary based on the goals and use cases of your organization. We recommend you align with the built-in Permissions Management risk thresholds. See the following PCI ranges, by risk:

* **Low**: 0 to 33
* **Medium**: 34 to 67
* **High**: 68 to 100 

Using the previous list, review the following PCI threshold policy examples:

|Category|PCI threshold|Policy|
|---|---|---|
|Authorization systems|67: Classify the authorization system as high risk|If an authorization system has a PCI score higher than 67, review and right-size high PCI identities in the authorization system|
|Human identities: ED, SAML, and local|67: Classify the human identity as high risk|If a human identity has a PCI score higher than 67, right-size the identity’s permissions|
|Human identity: Guest user|33: Classify the guest user as high or medium risk|If a guest user has a PCI score higher than 33, right-size the identity’s permissions|
|Non-human identities|33: Classify the non-human identity as high or medium risk|If a non-human identity has a PCI score higher than 33, right-size the identity’s permissions |

## Next steps

* [Introduction](permissions-manage-ops-guide-intro.md)
* [Phase 2: Right-size permissions and automate the principle of least privilege](permissions-manage-ops-guide-two.md)
* [Phase 3: Configure Microsoft Entra Permissions Management monitoring and alerting](permissions-manage-ops-guide-three.md)
* [Microsoft Entra Permissions Management alerts guide](permissions-manage-ops-guide-alerts.md)

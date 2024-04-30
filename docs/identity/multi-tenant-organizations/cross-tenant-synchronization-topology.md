---
title: Topologies for cross-tenant synchronization
description: Learn about topologies for cross-tenant synchronization in Microsoft Entra ID.
author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: conceptual
ms.date: 11/03/2023
ms.author: rolyon
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# Topologies for cross-tenant collaboration

Organizations often find themselves managing multiple tenants due to mergers and acquisitions, regulatory requirements, or administrative boundaries. Regardless of your scenario, Microsoft Entra offers a flexible and ready-to-use solution for provisioning accounts across tenants and facilitating seamless collaboration. Microsoft Entra accommodates the following three models and can adapt to your evolving organizational needs.

> [!div class="checklist"]
> - Hub and spoke
> - Mesh
> - Just-in-time

## Hub and spoke
The hub and spoke topology presents two common patterns:

* **Option 1 (application hub):** In this option, you can integrate commonly used applications into a central hub tenant that users from across the organization can access. 

* **Option 2 (user hub):** Alternatively, option 2 centralizes all your users in a single tenant and provisions them into spoke tenants where resources are managed.


Let's examine a few real-world scenarios and see how they align with each of these models.
### Mergers and acquisitions (application hub)

During mergers and acquisitions, the ability to quickly enable collaboration is crucial, allowing businesses to function cohesively while complex IT decisions are being made. For instance, when a newly acquired company's employees need immediate access to applications such as the internal help desk ticketing system or benefits application, cross-tenant synchronization proves invaluable. This synchronization process allows users from the acquired company to be provisioned into the application hub from day one, granting them access to SaaS apps, on-premises applications, and other cloud resources. Within the target tenant, admins can set up access packages to grant time limited access to additional applications such as Salesforce and Amazon Web Services that contain business critical data. The following diagram shows recently acquired tenants on the left and their users being provisioned into the parent company's tenant, which grants users access to the necessary resources.

:::image type="content" source="./media/cross-tenant-synchronization-topology/hub-1.png" alt-text="Diagram that shows multiple source tenants synchronizing with a single target tenant.":::

## Separate collaboration and resource tenants (user hub)

As organizations scale their usage of Azure, they often create dedicated tenants for managing critical Azure resources. Meanwhile, they rely on a central hub tenant for user provisioning. This model empowers administrators in the hub tenant to establish central security and governance policies while granting development teams greater autonomy and agility to deploy required Azure resources. Cross-tenant synchronization supports this topology by enabling administrators to provision a subset of users into the spoke tenants and manage the lifecycle of those users.

:::image type="content" source="./media/cross-tenant-synchronization-topology/hub-2.png" alt-text="Diagram that shows a source tenant synchronizing with multiple target tenants.":::

## Mesh
While some companies centralize their users within a single tenant, others have a more decentralized structure with applications, HR systems, and Active Directory domains integrated into each tenant. Cross-tenant synchronization offers the flexibility to choose which users are provisioned into each tenant.

### Collaborate within a portfolio company (partial-mesh)
In this scenario, each tenant represents a different company within the same parent organization. Administrators in each tenant choose a subset of users to provision into the target tenant. This solution provides flexibility for each tenant to operate independently, while facilitating collaboration when users need access to critical resources. 

:::image type="content" source="./media/cross-tenant-synchronization-topology/mesh.png" alt-text="Diagram that shows a partial-mesh topology synchronizing with multiple tenants.":::

Cross-tenant synchronization is one way. An internal member user can be synchronized into multiple tenants as an external user. When the topology shows a synchronization going in both directions, it's a distinct set of users in each direction and each arrow is a separate configuration.

### Collaborate across business units (full-mesh)
In this scenario, the organization has designated different tenants for each business unit. The business units work closely together, in particular using Microsoft Teams. As a result, each tenant has chosen to provision all users across the four tenants in the organization. As new users join the company or leave, the provisioning service takes care of creating and deleting users. The organization has also configured a multitenant organization that includes all four tenants. Now when users need to collaborate in Teams, they're able to easily find users across the company and start chats and meetings with those users.    

:::image type="content" source="./media/cross-tenant-synchronization-topology/mesh-2.png" alt-text="Diagram that shows a ful-mesh topology synchronizing with multiple tenants.":::

## Just-in-time 
While the scenarios discussed so far cover collaboration within an organization, there are cases where cross-organization collaboration is vital. This could be in the context of joint ventures or organizations of independent legal entities. By employing connected organizations and entitlement management, you can define policies for accessing resources across connected organizations and enable users to request access to the resources they need.

### Joint ventures
Consider Contoso and Litware, separate organizations engaged in a multi-year joint venture. They need to collaborate closely. Administrators at Contoso have defined access packages containing the resources required by Litware users. When a new Litware employee needs access to Contoso's resources, they can request access to the access package. Upon approval, they are provisioned with the necessary resources. Access can be time-limited and subject to periodic review to ensure compliance with Contoso's governance requirements.

The following diagram shows how two organizations can just-in-time collaborate by using connected organizations and entitlement management.

:::image type="content" source="./media/cross-tenant-synchronization-topology/connected-organization.png" alt-text="Diagram that shows just-in-time collaboration by using connected organizations and entitlement management.":::

## Next steps

- [What is cross-tenant synchronization?](cross-tenant-synchronization-overview.md)
- [Configure cross-tenant synchronization](cross-tenant-synchronization-configure.md)

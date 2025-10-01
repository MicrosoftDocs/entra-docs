---
title: Understand Microsoft Entra private network connector groups
description: Learn how Microsoft Entra private network connector groups work and how they're used by Microsoft Entra Private Access and application proxy.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: concept-article
ms.date: 09/25/2025
ms.service: global-secure-access
ai-usage: ai-assisted
---

# Microsoft Entra private network connector groups

Use private network connector groups to assign connectors to applications. Connector groups give you more control and help you optimize deployments.

Each private network connector is in a connector group. Connectors in the same group act as a unit for high availability and load balancing. If you don't create groups, all connectors are in the default group. Create new groups and assign connectors in the Microsoft Entra admin center.

Use connector groups when applications run in different locations. Create groups by location so each application uses nearby connectors.

> [!TIP]
> If you have a large Application Proxy deployment, don't assign applications to the default connector group. New connectors don't receive live traffic until you move them to an active group. You can also idle connectors by moving them back to the default group so you can do maintenance without affecting users.

## Prerequisites

You need multiple connectors to use connector groups. The service automatically adds new connectors to the **Default** connector group. To install connectors, see [configure connectors](how-to-configure-connectors.md).


## Assign applications to your connector groups

Assign an application to a connector group when you publish it. Change the connector's group at any time.

## Use cases for connector groups

Use connector groups in these scenarios:

### Sites with multiple interconnected datacenters

Large organizations use multiple datacenters. Keep as much traffic in a datacenter as possible because cross-datacenter links are expensive and slow. Deploy connectors in each datacenter to serve only the apps in that datacenter. This approach reduces cross-datacenter traffic and is transparent to users.

### Applications installed on isolated networks

Apps run in networks that aren't part of the main corporate network. Use connector groups to install dedicated connectors on isolated networks and keep those apps contained there. This scenario is common for vendors that maintain a specific app.

### Applications installed on infrastructure as a service (IaaS)

For apps on infrastructure as a service (IaaS), use connector groups to secure access to all apps without adding corporate network dependencies or fragmenting the experience. Install connectors in each cloud datacenter and scope them to apps in that network. Install multiple connectors for high availability.

For example, an organization has several virtual machines connected to its own IaaS-hosted virtual network. To allow employees to use these applications, these private networks are connected to the corporate network using site-to-site Virtual Private Network (VPN). Site-to-site VPN gives on-premises employees a good experience. However, it isn't ideal for remote employees because it requires more on-premises infrastructure to route access, as shown in the diagram:

![Diagram that shows the Microsoft Entra IaaS network.](./media/concept-connector-groups/application-proxy-iaas-network.png)
  
With Microsoft Entra private network connector groups, enable a common service to secure access to all apps without adding corporate network dependencies:

![Diagram that shows multiple cloud vendors for Microsoft Entra IaaS.](./media/concept-connector-groups/application-proxy-multiple-cloud-vendors.png)

### Multi-forest: different connector groups for each forest

Single sign-on often uses Kerberos constrained delegation (KCD). Connector machines join a domain that can delegate users to the application. KCD supports cross-forest scenarios, but in distinct multi-forest environments with no trust, a single connector can't serve all forests. Deploy dedicated connectors per forest and scope them to apps for users in that forest. Each connector group represents a forest. The tenant and most of the experience are unified, and you assign users to their forest apps by using Microsoft Entra groups.

### Disaster recovery sites

There are two approaches to consider for disaster recovery (DR) sites:

* Your DR site runs in active-active mode and matches the main site networking and Active Directory (AD) settings. Create the connectors on the DR site in the same connector group as the main site. Microsoft Entra ID detects failovers.
* Your DR site is separate from the main site. Create a different connector group there. Use backup apps or manually divert existing apps to the DR connector group as needed.

### Serve multiple companies from a single tenant

You can implement a model in which a single service provider deploys and maintains Microsoft Entra related services for multiple companies. Connector groups help you separate connectors and apps into groups. One option for small companies is a single Microsoft Entra tenant while each company keeps its own domain name and networks. The same approach works for merger scenarios and situations where a single division serves several companies for regulatory or business reasons.

## Sample configurations

Consider these sample connector group configurations.

### Default configuration – no use for connector groups

If you don’t use connector groups, your configuration looks like this:

![Screenshot of a single Application Proxy connector setup with no connector groups, showing one connector handling all published applications.](./media/concept-connector-groups/application-proxy-sample-config-1.png)

The configuration is sufficient for small deployments and tests. It also works if your organization has a flat network topology.

### Default configuration with an isolated network

This configuration evolves the default. A specific app runs in an isolated network, such as an IaaS virtual network.

![Screenshot of Application Proxy where one app runs in an isolated IaaS virtual network without a connector group, extending the default setup.](./media/concept-connector-groups/application-proxy-sample-config-2.png)

### Recommended configuration – specific groups and a default idle group

For large, complex organizations, set the default connector group to hold idle or newly installed connectors. Don’t assign applications to it. Serve all applications through custom connector groups.

In this example, the company has two datacenters (A and B). Two connectors serve each site. Each site runs different applications.

![Screenshot of recommended setup with two datacenters (A and B), two connectors per site, a default idle connector group, and custom groups serving all applications.](./media/concept-connector-groups/application-proxy-sample-config-3.png)



## Next steps

- [Microsoft Entra private network connectors](concept-connectors.md)


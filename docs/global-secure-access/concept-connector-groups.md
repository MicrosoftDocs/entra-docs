---
title: Microsoft Entra Private Network Connector Groups
description: Learn how Microsoft Entra private network connector groups work, and how Microsoft Entra Private Access and application proxy use them.
ms.topic: concept-article
ms.date: 09/25/2025
ai-usage: ai-assisted
---

# Microsoft Entra private network connector groups

Use private network connector groups to assign connectors to applications. Connector groups give you more control and help you optimize deployments.

Each private network connector is in a connector group. Connectors in the same group act as a unit for high availability and load balancing. If you don't create groups, all connectors are in the default group. Create new groups and assign connectors in the Microsoft Entra admin center.

Use connector groups when applications run in different locations. Create groups by location so that each application uses nearby connectors.

> [!TIP]
> If you have a large deployment of Microsoft Entra application proxy, don't assign applications to the default connector group. New connectors don't receive live traffic until you move them to an active group. You can also idle connectors by moving them back to the default group so that you can do maintenance without affecting users.

## Prerequisites

You need multiple connectors to use connector groups. The service automatically adds new connectors to the default connector group. To install connectors, see [Configure private network connectors for Microsoft Entra Private Access and application proxy](how-to-configure-connectors.md).

## Assignment of applications to your connector groups

Assign an application to a connector group when you publish it. Change the connector group at any time.

## Use cases for connector groups

Use connector groups in the following scenarios.

### Sites with multiple interconnected datacenters

Large organizations use multiple datacenters. Keep as much traffic in a datacenter as possible, because cross-datacenter links are expensive and slow.

Deploy connectors in each datacenter to serve only the apps in that datacenter. This approach reduces cross-datacenter traffic and is transparent to users.

### Applications installed on isolated networks

Apps run in networks that aren't part of the main corporate network. Use connector groups to install dedicated connectors on isolated networks, and keep those apps contained there. This scenario is common for vendors that maintain a specific app.

### Applications installed on IaaS

For apps on infrastructure as a service (IaaS), use connector groups to help secure access to all apps without adding corporate network dependencies or fragmenting the experience. Install connectors in each cloud datacenter and scope them to apps in that network. Install multiple connectors for high availability.

For example, an organization has several virtual machines connected to its own IaaS-hosted virtual network. To allow employees to use these applications, these virtual machines are connected to the corporate network via site-to-site virtual private network (VPN). A site-to-site VPN gives on-premises employees a good experience. However, it isn't ideal for remote employees because it requires more on-premises infrastructure to route access, as shown in the following diagram.

![Diagram that shows the Microsoft Entra IaaS network.](./media/concept-connector-groups/application-proxy-iaas-network.png)
  
With Microsoft Entra private network connector groups, you can enable a common service to help secure access to all apps without adding corporate network dependencies.

![Diagram that shows multiple cloud vendors for Microsoft Entra IaaS.](./media/concept-connector-groups/application-proxy-multiple-cloud-vendors.png)

### Different connector groups for each forest in a multiple-forest environment

Single sign-on often uses Kerberos constrained delegation (KCD). Connector machines join a domain that can delegate users to the application. KCD supports cross-forest scenarios, but in distinct multiple-forest environments with no trust, a single connector can't serve all forests.

Deploy dedicated connectors per forest and scope them to apps for users in that forest. Each connector group represents a forest. The tenant and most of the experience are unified, and you assign users to their forest apps by using Microsoft Entra groups.

### Disaster recovery sites

There are two approaches to consider for disaster recovery (DR) sites:

- Your DR site runs in active/active mode and matches the main site networking and Active Directory settings. Create the connectors on the DR site in the same connector group as the main site. Microsoft Entra ID detects failovers.
- Your DR site is separate from the main site. Create a different connector group there. Use backup apps or manually divert existing apps to the DR connector group as needed.

### Serving multiple companies from a single tenant

You can implement a model in which a single service provider deploys and maintains Microsoft Entra-related services for multiple companies. Connector groups help you separate connectors and apps into groups.

One option for small companies is to use a single Microsoft Entra tenant, while each company keeps its own domain name and networks. The same approach works for merger scenarios and situations where a single division serves several companies for regulatory or business reasons.

## Sample configurations

Consider these sample configurations of connector groups.

### Default configuration: No use for connector groups

If you don't use connector groups, your configuration looks like the following example. The default proxy connector group handles all published applications.

![Screenshot of a setup with only the default connector group and two connectors handling all published applications.](./media/concept-connector-groups/application-proxy-sample-config-1.png)

The configuration is sufficient for small deployments and tests. It also works if your organization has a flat network topology.

### One connector group for an isolated network

This configuration extends the default. A specific app runs in an isolated network, such as an IaaS virtual network. The company created a connector group for this isolated network.

![Screenshot of application proxy where one app runs in an isolated IaaS virtual network with one connector group.](./media/concept-connector-groups/application-proxy-sample-config-2.png)

### Recommended configuration: Specific groups and a default idle group

For large, complex organizations, set the default connector group to hold idle or newly installed connectors. Don't assign applications to it. Serve all applications through custom connector groups.

In this example, the company has two datacenters (A and B). Two connectors serve each site. Each site runs different applications.

![Screenshot of a recommended setup with two datacenters, two connectors per site, a default idle connector group, and custom groups serving all applications.](./media/concept-connector-groups/application-proxy-sample-config-3.png)

## Related content

- [Microsoft Entra private network connectors](concept-connectors.md)

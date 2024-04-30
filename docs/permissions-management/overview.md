---
title: What's Microsoft Entra Permissions Management?
description: An introduction to Microsoft Entra Permissions Management.
author: jenniferf-skc
manager: amycolannino
ms.service: entra-permissions-management

ms.topic: overview
ms.date: 10/04/2023
ms.author: jfields
---

# What's Microsoft Entra Permissions Management

Microsoft Entra Permissions Management is a cloud infrastructure entitlement management (CIEM) solution that provides comprehensive visibility into permissions assigned to all identities. For example, over-privileged workload and user identities, actions, and resources across multicloud infrastructures in Microsoft Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

Permissions Management  detects, automatically right-sizes, and continuously monitors unused and excessive permissions.

Organizations have to consider permissions management as a central piece of their Zero Trust security to implement least privilege access across their entire infrastructure:

- Organizations are increasingly adopting multicloud strategy and are struggling with the lack of visibility and the increasing complexity of managing access permissions.
- With the growth of identities and cloud services, the number of high-risk cloud permissions is exploding, expanding the attack surface for organizations.
- IT security teams are under increased pressure to ensure access to their expanding cloud estate is secure and compliant.
- The inconsistency of cloud providers' native access management models makes it even more complex for Security and Identity to manage permissions and enforce least privilege access policies across their entire environment.

:::image type="content" source="media/overview/key-use-cases.png" alt-text="Diagram of Microsoft Entra Permissions Management use cases." lightbox="media/overview/key-use-cases.png":::

## Key use cases

Permissions Management allows customers to address three key use cases: *discover*, *remediate*, and *monitor*.

Permissions Management is designed in such a way that we recommended you 'step-through' each of the below phases in order to gain insights into permissions across the organization. This is because you generally can't take action on what has not been discovered, likewise you can't continually evaluate what has not been remediated.

:::image type="content" source="media/overview/discover-remediate-monitor.png" alt-text="Permissions Management use case diagram showing the discover, remediate, and monitor phases.":::

### Discover

Customers can assess permission risks by evaluating the gap between permissions granted and permissions used.

- Cross-cloud permissions discovery: Granular and normalized metrics for key cloud platforms: AWS, Azure, and GCP.
- Permission Creep Index (PCI): An aggregated metric that periodically evaluates the level of risk associated with the number of unused or excessive permissions across your identities and resources. It measures how much damage identities can cause based on the permissions they have.
- Permission usage analytics: Multi-dimensional view of permissions risk for all identities, actions, and resources.

### Remediate

Customers can right-size permissions based on usage, grant new permissions on-demand, and automate just-in-time access for cloud resources.

- Automated deletion of permissions unused for the past 90 days.
- Permissions on-demand: Grant identities permissions on-demand for a time-limited period or an as-needed basis.


### Monitor

Customers can detect anomalous activities with machine learning-powered (ML-powered) alerts and generate detailed forensic reports.

- ML-powered anomaly detections.
- Context-rich forensic reports around identities, actions, and resources to support rapid investigation and remediation.

Permissions Management deepens Zero Trust security strategies by augmenting the least privilege access principle, allowing customers to:

- Get comprehensive visibility: Discover which identity is doing what, where, and when.
- Automate least privilege access: Use access analytics to ensure identities have the right permissions, at the right time.
- Unify access policies across infrastructure as a service (IaaS) platforms: Implement consistent security policies across your cloud infrastructure.

Once your organization has explored and implemented the discover, remediation and monitor phases, you've established one of the core pillars of a modern zero-trust security strategy.

## Next steps

- Deepen your learning with [Introduction to Microsoft Entra Permissions Management](https://go.microsoft.com/fwlink/?linkid=2240016) learn module. 
- Sign up for a [45-day free trial](https://aka.ms/TryPermissionsManagement) of Permissions Management.
- For a list of frequently asked questions (FAQs) about Permissions Management, see [FAQs](faqs.md).

---
title: Road to the cloud - Introduction to moving identity and access management from AD to Microsoft Entra ID
description: Learn how to plan a migration of IAM from Active Directory to Microsoft Entra ID.
documentationCenter: ''
ms.topic: how-to
ms.date: 07/27/2023
ms.custom: references_regions
ms.subservice: architecture
---
# Road to the cloud: Introduction

Organizations are increasingly modernizing identity, access, and device management by reducing their dependence on on-premises Active Directory and adopting cloud-native capabilities in Microsoft Entra ID. Whether the goal is complete Active Directory retirement or a smaller, more secure on-premises footprint, this guidance helps you plan and execute that transformation. 

This content provides guidance to move:

* *From* Active Directory and other non-cloud-based services, either on-premises or infrastructure as a service (IaaS), that provide identity management (IDM), identity and access management (IAM), and device management.

* *To* Microsoft Entra ID and other Microsoft cloud-native solutions for IDM, IAM, and device management.

>[!NOTE]
> In this content, *Active Directory* refers to Windows Server Active Directory Domain Services.

Transformation must be aligned with and achieve business objectives, including increased productivity, reduced costs and complexity, and improved security posture. To better understand the costs versus value of moving to the cloud, see [Forrester TEI for Microsoft Entra ID](https://www.microsoft.com/security/business/forrester-tei-study) and [Cloud economics](https://azure.microsoft.com/overview/cloud-economics/).

## The AD minimization journey

Moving from Active Directory to Microsoft Entra ID progresses through five stages. Each stage describes where your environment is on the journey and is paired with a single strategic phase that describes the primary focus of work in that stage. Across every stage, three streams of progress (users and groups, applications, and devices) advance, and they can move independently of one another. 

1. **Cloud Attached (Identification):** Establish a baseline by discovering your current identity, application, and device landscape. Active Directory Domain Services remains authoritative while cloud identity is attached but not yet primary. The focus is on visibility and determining which workloads are ready to move. 

1. **Hybrid (Modernization):** Move beyond synchronizing identities and begin using cloud identity to strengthen security, resilience, and user experience while on-premises environments remain in place. Identify dependent apps and services, and enable capabilities such as conditional access and self-service password reset. 

1. **Cloud-First (Adoption):** Treat Microsoft Entra ID as the default authority for new investments and shift the identity control plane to the cloud. New users, groups, applications, and devices are provisioned as cloud-native by default. 

1. **On-premises AD minimized (Reduction):** Reduce Active Directory from a default dependency to an exception. Actively shrink the on-premises footprint by replacing legacy workloads with cloud alternatives and migrating identity lifecycle workflows to Microsoft Entra ID. 

1. **Cloud Only (Optimization):** Remove remaining on-premises identity dependencies and operate identity as a fully cloud-native service. All users, groups, and devices are managed in Microsoft Entra ID, enabling Active Directory to be decommissioned. Moving from Active Directory to Microsoft Entra ID progresses through five stages. Each stage describes where your environment is on the journey and is paired with a single strategic phase that describes the primary focus of work in that stage. Across every stage, three streams of progress (users and groups, applications, and devices) advance, and they can move independently of one another. 

## Next steps

* [Cloud transformation posture](road-to-the-cloud-posture.md)
* [Establish a Microsoft Entra footprint](road-to-the-cloud-establish.md)
* [Implement a cloud-first approach](road-to-the-cloud-implement.md)
* [Transition to the cloud](road-to-the-cloud-migrate.md)

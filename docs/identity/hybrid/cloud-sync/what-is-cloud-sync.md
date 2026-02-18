---
title: What is Microsoft Entra Cloud sync?
description: Describes Microsoft Entra Cloud sync.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: overview
ms.date: 02/17/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi

---

# What is Microsoft Entra Cloud sync?

> [!VIDEO https://www.youtube.com/embed/9T6lKEloq0Q]

Microsoft Entra Cloud Sync is a hybrid identity synchronization service that provides modern, cloud-managed synchronization of users, groups, and contacts between Active Directory and Microsoft Entra ID. It represents Microsoft's strategic direction for hybrid identity, offering a lightweight, agent-based approach that simplifies deployment and management while enabling advanced scenarios like disconnected forest synchronization.

Cloud Sync solves common challenges organizations face with hybrid identity infrastructure by eliminating single points of failure, reducing on-premises management overhead, and enabling complex multi-forest scenarios that support organizational growth and change.

## Core architecture and components

Cloud sync is built on a modern, cloud-first architecture with two key components:

**Microsoft Entra provisioning agent**: A lightweight, on-premises agent that acts as a secure bridge between Active Directory and Microsoft Entra ID. The agent uses the same proven technology as Microsoft Entra Application Proxy and Pass-Through Authentication, requiring only outbound connections and providing automatic updates from the cloud.

**Microsoft Entra provisioning service**: A cloud-based orchestration service that manages synchronization configuration, scheduling, and processing. This service uses the same infrastructure as other Microsoft Entra provisioning capabilities and operates on a scheduler-based model with synchronization occurring every two minutes.

 :::image type="content" source="media/what-is-cloud-sync/architecture-2.png" alt-text="Diagram of basic cloud sync." lightbox="media//what-is-cloud-sync/architecture-2.png":::

## How Cloud sync works

Cloud sync leverages the System for Cross-domain Identity Management (SCIM) standard to ensure reliable and standards-based identity management. The synchronization process follows this flow:

- **Agent communication**: The provisioning agent maintains a persistent outbound connection to Microsoft Entra services through Azure Service Bus, listening for synchronization requests.
- **Request processing**: When synchronization occurs, the agent receives SCIM requests from the cloud service and queries Active Directory for the requested information.
- **Data filtering and transformation**: The agent filters and transforms data based on configured scoping rules and attribute mappings before sending responses back to Microsoft Entra ID.
- **Cloud processing**: The provisioning service processes the responses and commits changes to Microsoft Entra ID, maintaining synchronization state and handling incremental updates through watermark tracking.

## Key capabilities

| Capability | Description |
|---|---|
| Cloud-managed configuration | All synchronization configuration is stored and managed in Microsoft Entra ID through the Microsoft Entra admin center. Administrators can modify settings, monitor status, and troubleshoot issues from any location without VPN access. |
| High availability through multi-agent support | Cloud sync supports multiple active provisioning agents deployed across different servers, providing automatic failover without configuration changes. Synchronization continues seamlessly when individual agents become unavailable. |
| Disconnected forest synchronization | Cloud sync natively handles multiple disconnected Active Directory forests without requiring complex configurations or multiple synchronization instances. This capability supports mergers and acquisitions, historical multi-forest environments, and scenarios where forests cannot be connected. |
| Simplified installation and management | The lightweight agent model requires minimal server resources and can be deployed on domain controllers or dedicated servers. Agents automatically receive security updates and patches from Microsoft. |
| Advanced provisioning scenarios | Cloud sync enables cloud-to-AD provisioning scenarios, including group provisioning to Active Directory for governing on-premises applications. This bidirectional capability supports modern identity architectures where Microsoft Entra ID serves as the authoritative identity source. |

<a name='how-is-azure-ad-connect-cloud-sync-different-from-azure-ad-connect-sync'></a>

## How is Microsoft Entra Cloud sync different from Microsoft Entra Connect sync?

With Microsoft Entra Cloud Sync, provisioning orchestration occurs entirely in Microsoft Online Services rather than on-premises infrastructure. Organizations deploy lightweight agents in their on-premises or Infrastructure-as-a-Service (IaaS) environments that act as secure bridges between Microsoft Entra ID and Active Directory. All provisioning configuration, monitoring, and management is handled through the cloud service, eliminating the complexity of on-premises sync server management.

This architectural difference enables scenarios that are complex or impossible with traditional approaches, such as synchronizing from multiple disconnected forests to a single Microsoft Entra tenant without forest consolidation.

For a detailed feature comparison table, see [Cloud Sync and Microsoft Entra Connect feature comparison](connect-to-cloud-sync-decision-guide.md#comparison-between-microsoft-entra-connect-and-cloud-sync).

<a name='azure-ad-connect-cloud-sync-video'></a>

## Microsoft Entra Cloud sync video

The following short video provides an excellent overview of Microsoft Entra Cloud Sync:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=2b0047aa-84ba-430d-8ce9-39cfdc55276d]

## When to consider Cloud sync

Cloud Sync is designed to modernize hybrid identity infrastructure and enable scenarios that traditional synchronization approaches cannot support effectively. Key scenarios include:

- Organizations undergoing mergers and acquisitions requiring rapid integration of disconnected forests
- Companies seeking to eliminate single points of failure and improve synchronization reliability 
- Environments requiring simplified management and reduced on-premises infrastructure
- Multi-forest organizations where forest consolidation is not feasible
- Organizations implementing cloud-first identity strategies with cloud-to-AD provisioning needs

For organizations evaluating migration from Microsoft Entra Connect or implementing new hybrid identity solutions, Cloud Sync offers significant architectural advantages. For detailed feature comparison, migration planning, and readiness assessment, see [Migrate from Microsoft Entra Connect to Cloud Sync: Decision Guide](connect-to-cloud-sync-decision-guide.md).

## Integration with Microsoft Entra ecosystem

Cloud Sync integrates seamlessly with the broader Microsoft Entra identity platform, supporting advanced scenarios like:

- **Microsoft Entra ID Governance**: Enabling lifecycle management and access governance for hybrid identities
- **Source of Authority (SOA) management**: Supporting cloud-first identity strategies where Microsoft Entra ID becomes the authoritative identity source
- **HR-driven provisioning**: Working alongside HR application integrations to create end-to-end identity provisioning workflows

## Next steps 

- [What is the provisioning agent?](what-is-provisioning-agent.md)
- [Install cloud sync](how-to-install.md)
- [Migrate from Microsoft Entra Connect to Cloud Sync: Decision Guide](connect-to-cloud-sync-decision-guide.md)

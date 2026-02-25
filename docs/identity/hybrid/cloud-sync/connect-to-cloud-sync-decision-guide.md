---
title: 'Migrate from Microsoft Entra Connect to Cloud Sync: Decision Guide'
description: 'Compare Microsoft Entra Connect and Cloud Sync technical capabilities to make informed migration decisions. Understand feature differences, limitations, and migration timing.'
ms.service: entra-id
ms.topic: concept-article
ms.date: 02/17/2025
ms.subservice: hybrid-cloud-sync
author: omondiatieno
ms.author: jomondi
manager: mwongerapk
ms.custom: customer-intent

#customer-intent: As an IT architect or administrator, I want to evaluate migrating from Microsoft Entra Connect to Cloud Sync so that I can make informed decisions about modernizing my hybrid identity infrastructure.
ai-usage: ai-assisted

---

# Migrate from Microsoft Entra Connect to Cloud Sync: Decision Guide

Microsoft Entra Cloud Sync represents Microsoft's strategic direction for hybrid identity synchronization, offering a modern, cloud-managed approach to synchronizing users, groups, and contacts between Active Directory and Microsoft Entra ID. As organizations evaluate their hybrid identity infrastructure, understanding the technical benefits and migration readiness is essential for making informed decisions.

This decision guide helps IT architects and decision makers evaluate migration from Microsoft Entra Connect to Cloud Sync by comparing technical capabilities, identifying architectural advantages, and providing migration readiness assessments. For basic overview information, see [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md), and for step-by-step migration procedures, see [Migrating from Microsoft Entra Connect to Microsoft Entra Cloud Sync](migrate-azure-ad-connect-to-cloud-sync.md).

New identity and synchronization features are being developed primarily on the Cloud Sync platform, making it the recommended path forward for most organizations.

## Technical benefits of migration

This section highlights the key technical benefits of migrating from Microsoft Entra Connect to Cloud Sync, providing insights into how Cloud Sync's architecture and capabilities can enhance your hybrid identity environment.

### Cloud-managed configuration architecture

Microsoft Entra Connect relies on on-premises server configuration that requires direct server access for management, updates, and troubleshooting. Cloud Sync moves configuration management to the cloud, storing all synchronization settings in Microsoft Entra ID as part of the service. This architecture eliminates the need for on-premises server management while providing centralized control through the Microsoft Entra admin center.

Administrators can modify synchronization configurations, monitor sync status, and troubleshoot issues from any location without requiring VPN access or on-premises connectivity. Configuration changes are automatically distributed to agents, reducing administrative overhead and potential configuration drift.

### Enhanced reliability through multiple active agents

Microsoft Entra Connect creates a single point of failure – if the Connect server becomes unavailable, synchronization stops until the server is restored. Cloud Sync supports multiple active provisioning agents deployed across different servers, providing automatic failover capabilities.

When one agent becomes unavailable, other agents continue processing synchronization requests without interruption. This distributed model eliminates planned downtime for maintenance and provides built-in resilience against hardware failures or network connectivity issues. Organizations can deploy agents strategically across different locations or network segments to optimize performance and reliability.

### Modern scalability and deployment model  

The lightweight provisioning agent model requires minimal server resources compared to Connect sync's comprehensive installation. Agents can be deployed on existing domain controllers or standalone servers with minimal resource impact. This deployment flexibility enables organizations to scale synchronization infrastructure based on geographic distribution or organizational requirements.

Agents automatically receive updates and security patches from Microsoft without requiring manual intervention, ensuring the synchronization infrastructure remains current and secure. The cloud-managed update process reduces maintenance windows and administrative effort.

### Advanced disconnected forest capabilities

Cloud Sync natively supports synchronization from multiple disconnected Active Directory forests. These scenarios are commonly required during mergers, acquisitions, or complex organizational structures. Unlike Connect sync, which requires complicated configurations or multiple instances for disconnected forests, Cloud Sync handles these scenarios through its multi-tenant architecture.

Each disconnected forest can have dedicated agents while maintaining unified management through the cloud service. This capability simplifies complex organizational scenarios and reduces the infrastructure complexity traditionally required for multi-forest synchronization.

### Strategic platform for new features

Microsoft's development focus for new synchronization and provisioning capabilities centers on Cloud Sync. Features like group provisioning to Active Directory, advanced source of authority management, and cloud-native identity scenarios are available exclusively in Cloud Sync. Organizations using Connect sync might miss access to new capabilities or require additional tools to achieve similar functionality.

## Comparison between Microsoft Entra Connect and Cloud Sync

The following table provides a detailed comparison of technical capabilities between Microsoft Entra Connect and Cloud Sync:

| Feature/Capability | Connect Sync | Cloud Sync | Technical Notes |
|:--- |:---:|:---:|:---|
| **Users, Groups, Contacts Sync** | ✓ | ✓ | Full parity for basic directory object synchronization |
| **Single Connected Forest** | ✓ | ✓ | Both support standard single-forest topologies |
| **Multiple Connected Forests** | ✓ | ✓ | Both support multiple connected forest scenarios |
| **Disconnected Forest Support** | ✗ | ✓ | Cloud Sync enables M&A scenarios without forest consolidation |
| **Device Synchronization** | ✓ | ✗ | Connect supports Hybrid Azure AD Join; not currently supported in Cloud Sync |
| **Multiple Active Sync Instances** | ✗ | ✓ | Cloud Sync agents provide automatic failover and load distribution |
| **Scale Limits per Domain** | Unlimited | 150K objects | Cloud Sync currently supports up to 150,000 objects per domain |
| **Large Group Support** | 250K members | 50K members | Connect supports larger groups; Cloud Sync limited to 50,000 members |
| **Password Hash Synchronization** | ✓ | ✓ | Full parity for password synchronization capabilities |
| **Password Writeback** | ✓ | ✓ | SSPR writeback supported in both platforms |
| **Pass-Through Authentication Config** | ✓ | ✗ | PTA configuration managed separately from sync in Cloud Sync |
| **ADFS Integration Setup** | ✓ | ✗ | Federation configuration requires separate tools in Cloud Sync |
| **Exchange Hybrid Attributes** | ✓ | ✓ | Full support for Exchange hybrid scenarios |
| **Directory Extensions (1-15)** | ✓ | ✓ | Standard extension attribute synchronization supported |
| **Custom AD Attributes** | ✓ | ✓ | Customer-defined attributes and directory extensions supported |
| **Basic Attribute Customization** | ✓ | ✓ | Attribute flow customization available through expression builder |
| **Advanced Sync Rules** | ✓ | ✗ | Complex sync rule engine available in Connect; Cloud Sync uses expression builder |
| **OU-based Filtering** | ✓ | ✓ | Both support organizational unit scoping |
| **Attribute-based Filtering** | ✓ | Limited | Connect provides full attribute filtering; Cloud Sync has basic capabilities |
| **Device Writeback** | ✓ | ✗ | Device writeback discontinued in favor of Cloud Kerberos Trust |
| **Group Writeback V1** | ✓ | ✓ | Legacy group writeback supported in both |
| **Group Provisioning to AD** | ✗ | ✓ | Cloud-to-AD group provisioning available only in Cloud Sync |
| **User Provisioning to AD** | ✗ | ✗ | Cloud-to-AD user provisioning not currently supported |
| **Cross-Domain References** | ✓ | ✓ | Support for user references across domains |
| **Cross-Forest References** | ✓ | ✗ | Connect supports forest-to-forest object relationships |
| **Merge Attributes from Multiple Domains** | ✓ | ✗ | Connect can merge attributes from different AD sources |
| **Reconciliation Capabilities** | ✓ | ✗ | Out-of-band sync correction not currently supported in Cloud Sync |
| **On-Demand Provisioning** | ✗ | ✓ | Cloud Sync provides immediate sync testing capabilities |
| **Cloud Configuration Management** | ✗ | ✓ | Cloud Sync managed entirely through Microsoft Entra admin center |
| **Seamless Single Sign-On** | ✓ | ✓ | Both platforms support seamless SSO |
| **US Government Cloud** | ✓ | ✓ | Both support sovereign cloud deployments |

## Migration readiness assessment

Based on your current requirements and the feature comparison in the table above, assess your migration readiness using these scenarios:

### Ready for immediate migration

Your organization can migrate immediately if you meet all these criteria:

- **Object Scale**: Fewer than 150,000 objects per Active Directory domain
- **Group Size**: Groups with fewer than 50,000 members  
- **Device Management**: Not using Hybrid Azure AD Join, or willing to transition to Cloud Kerberos Trust
- **Authentication**: Using Password Hash Sync or managing ADFS/PTA configurations separately
- **Filtering**: Using OU-based filtering rather than complex attribute-based rules
- **Forest Configuration**: Single forest or connected forests (no disconnected forest requirements)

Organizations matching this profile gain immediate benefits from Cloud Sync's architecture improvements, multiple agent support, and access to new cloud-native features.

### Plan for near-term migration

Consider planning migration based on feature availability if you have these requirements that might become supported:

- **Device Synchronization**: Currently rely on Hybrid Azure AD Join device synchronization
- **Advanced Filtering**: Use complex attribute-based filtering beyond current Cloud Sync capabilities
- **User Provisioning to AD**: Need cloud-to-AD user provisioning capabilities

Monitor Microsoft's feature announcements for feature availability and plan migration timing based on your critical dependencies.

### Evaluate for future migration

Organizations with these characteristics should evaluate migration timing based on business planning cycles:

- **Large Scale Deployments**: More than 150,000 objects per domain or groups exceeding 50,000 members
- **Complex Synchronization Rules**: Extensive custom synchronization rules requiring significant reconfiguration effort
- **Cross-Forest Dependencies**: Complex cross-forest object relationships that aren't supported in Cloud Sync
- **Reconciliation Requirements**: Critical dependency on out-of-band sync correction capabilities
- **Resource Planning**: Limited resources for migration project execution

For large-scale environments, assess whether segmenting the migration by domain or organizational unit provides a viable path forward while maintaining business continuity.

## Decision framework

Use this framework to make your migration decision:

- **Assess Current Dependencies**: Review your usage of Connect-specific features using the comprehensive feature table above
- **Evaluate Migration Readiness**: Determine which readiness scenario matches your environment
- **Plan Migration Timing**: Monitor feature announcements, consider business cycles, and assess resource availability
- **Validate Prerequisites**: Ensure your environment meets [Cloud Sync prerequisites](how-to-prerequisites.md)
- **Test Migration Process**: Use the [pilot migration tutorial](tutorial-pilot-aadc-aadccp.md) to validate the migration process

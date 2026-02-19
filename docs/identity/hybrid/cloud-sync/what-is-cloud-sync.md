---
title: 'What is Microsoft Entra Cloud Sync?'
description: Describes Microsoft Entra Cloud Sync.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: overview
ms.date: 09/29/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi

---

# What is Microsoft Entra Cloud Sync?

> [!VIDEO https://www.youtube.com/embed/9T6lKEloq0Q]

Microsoft Entra Cloud Sync is a new offering from Microsoft designed to meet and accomplish your hybrid identity goals for synchronization of users, groups, and contacts to Microsoft Entra ID.  It accomplishes this by using the Microsoft Entra cloud provisioning agent instead of the Microsoft Entra Connect application.  However, it can be used alongside Microsoft Entra Connect Sync and it provides the following benefits:

> [!IMPORTANT]
> **Authentication precedence**: Enabling Microsoft Entra Cloud Sync does not change or override your tenant's configured authentication method. If Pass-through Authentication (PTA) or Password Hash Synchronization (PHS) is already configured, it continues to control user sign-ins. Cloud Sync is a synchronization technology and does not manage authentication behavior.
    
- Support for synchronizing to a Microsoft Entra tenant from a multi-forest disconnected Active Directory forest environment: The common scenarios include merger and acquisition. In these cases, the acquired company's AD forests are isolated from the parent company's AD forests. Another scenario involves companies that historically had multiple AD forests.
- Simplified installation with light-weight provisioning agents: The agents act as a bridge from AD to Microsoft Entra ID, with all the sync configuration managed in the cloud. 
- Multiple provisioning agents can be used to simplify high availability deployments. They're critical for organizations relying upon password hash synchronization from AD to Microsoft Entra ID.
- Support for large groups with up to 50,000 members. It's recommended to use only the OU scoping filter when synchronizing large groups.


 :::image type="content" source="media/what-is-cloud-sync/architecture-2.png" alt-text="Diagram of basic cloud sync." lightbox="media//what-is-cloud-sync/architecture-2.png":::

<a name='how-is-azure-ad-connect-cloud-sync-different-from-azure-ad-connect-sync'></a>

## How is Microsoft Entra Cloud Sync different from Microsoft Entra Connect Sync?
With Microsoft Entra Cloud Sync, provisioning from AD to Microsoft Entra ID is orchestrated in Microsoft Online Services. An organization only needs to deploy, in their on-premises or IaaS-hosted environment, a light-weight agent that acts as a bridge between Microsoft Entra ID and AD. The provisioning configuration is stored in Microsoft Entra ID and managed as part of the service.

<a name='azure-ad-connect-cloud-sync-video'></a>

## Microsoft Entra Cloud Sync video
The following short video provides an excellent overview of Microsoft Entra Cloud Sync:

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=2b0047aa-84ba-430d-8ce9-39cfdc55276d]

## Choose the right sync client
To determine if cloud sync is right for your organization, review the supported sync scenarios. For more information, evaluate your options using the [supported sync scenarios comparison](../common-scenarios.md)


<a name='comparison-between-azure-ad-connect-and-cloud-sync'></a>

## Comparison between Microsoft Entra Connect and cloud sync

The following table provides a comparison between Microsoft Entra Connect and Microsoft Entra Cloud Sync:

| Feature | Connect sync| Cloud sync |
|:--- |:---:|:---:|
|Connect to single on-premises AD forest|● |● |
| Connect to multiple on-premises AD forests |● |● |
| Connect to multiple disconnected on-premises AD forests | |● |
| Lightweight agent installation model | |● |
| Multiple active agents for high availability | |● |
| Support for user objects |● |● |
| Support for group objects |● |● |
| Support for contact objects |● |● |
| Support for device objects |● | |
| Allow basic customization for attribute flows |● |● |
| Synchronize Exchange online attributes |● |● |
| Synchronize extension attributes 1-15 |● |● |
| Synchronize customer defined AD attributes (directory extensions) |●|●|
| Support for Password Hash Sync |●|●|
| Support for Pass-Through Authentication |●||
| Support for federation |●|●|
| Seamless Single Sign-on|● |●|
| Supports installation on a Domain Controller |● |● |
| Support for Windows Server 2022, Windows Server 2019, and Windows Server 2016|● |● |
| Filter on Domains/OUs/groups |● |● |
| Filter on objects' attribute values |● | |
| Allow minimal set of attributes to be synchronized (MinSync) |● |● |
| Allow removing attributes from flowing from AD to Microsoft Entra ID |● |● |
| Allow advanced customization for attribute flows |● | |
| Support for password writeback |● |● |
| Support for device writeback|● |Customers should use [Cloud Kerberos trust](/windows/security/identity-protection/hello-for-business/hello-hybrid-cloud-kerberos-trust?tabs=intune) for this moving forward|
| Support for group writeback| |●|
| Support for merging user attributes from multiple domains|● | |
| Microsoft Entra Domain Services support|● | |
| [Exchange hybrid writeback](exchange-hybrid.md) |● |● |
| Unlimited number of objects per AD domain |● | |
| Support for up to 150,000 objects per AD domain |● |● |
| Groups with up to 50,000 members |● |● |
| Large groups with up to 250,000 members |● |  |
| Cross domain references|● |● |
| Cross forest references|● | |
| On-demand provisioning| |● |
| Support for US Government|● |● |

> [!NOTE]
> **Understanding "Not Supported" for Pass-through Authentication**: In the feature comparison table above, where Cloud Sync does not support Pass-through Authentication, this means Cloud Sync cannot configure or manage PTA. **It does not mean that existing Pass-through Authentication is disabled or replaced when Cloud Sync is enabled.** If PTA is already configured in your tenant, it will continue to handle authentication for user sign-ins, independently of Cloud Sync's synchronization operations.

## Synchronization vs Authentication Responsibilities

It's important to understand the separation between synchronization technology and authentication methods. The following table clarifies what each component controls:

| Responsibility | Synchronization Technology (Microsoft Entra Cloud Sync / Microsoft Entra Connect Sync) | Authentication Method (Password Hash Synchronization / Pass-through Authentication / Federation) |
|:---|:---|:---|
| **What it controls** | • Object synchronization (users, groups, contacts)<br>• Attribute synchronization<br>• Writeback of certain attributes<br>• Directory extensions | • Password validation<br>• Sign-in behavior<br>• Where credentials are verified<br>• Enforcement of on-premises policies during sign-in |
| **What it does NOT control** | • User authentication and sign-in<br>• Password validation<br>• Authentication method configuration | • Object and attribute synchronization<br>• Which objects sync to Microsoft Entra ID<br>• Sync schedule and frequency |
| **Key point** | Synchronization moves data between directories | Authentication validates user credentials during sign-in |

**Important**: Changing your synchronization technology (for example, from Microsoft Entra Connect Sync to Cloud Sync) does not change how users sign in or where passwords are validated. Authentication behavior is determined by the authentication method configured for your tenant, not by the synchronization technology used.

> [!NOTE]
> For information about synchronizing to Microsoft Entra tenants operated by 21 Vianet, the version of Microsoft 365 specific to China, see [Microsoft 365 operated by 21Vianet](/office365/servicedescriptions/office-365-platform-service-description/microsoft-365-operated-by-21vianet) and [Topologies for Microsoft Entra Connect](~/identity/hybrid/connect/plan-connect-topologies.md).
> Cloud sync can be use for tenants in the Microsoft Commercial, US Government, and [21Vianet (China)](/office365/servicedescriptions/office-365-platform-service-description/microsoft-365-operated-by-21vianet) clouds. SSPR is not yet available to be used with Cloud Sync in the 21 Vianet (China) cloud. 

## Next steps 

- [What is provisioning?](../what-is-provisioning.md)
- [Install cloud sync](how-to-install.md)
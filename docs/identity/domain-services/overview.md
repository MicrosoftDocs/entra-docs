---
title: Overview of Microsoft Entra Domain Services | Microsoft Docs
description: In this overview, learn what Microsoft Entra Domain Services provides and how to use it in your organization to provide identity services to applications and services in the cloud.
author: justinha
manager: dougeby
ms.service: entra-id
ms.subservice: domain-services
ms.topic: overview
ms.date: 02/16/2026
ms.author: justinha
ms.custom: sfi-image-nochange
#Customer intent: As an IT administrator or decision maker, I want to understand what Domain Services is and how it can benefit my organization.
---

# What is Microsoft Entra Domain Services?

Microsoft Entra Domain Services provides managed domain services such as domain join, group policy, lightweight directory access protocol (LDAP), and Kerberos/NTLM authentication. You use these domain services without the need to deploy, manage, and patch domain controllers (DCs) in the cloud.

Use Entra Domain Services to support legacy applications that depend on Active Directory Domain Services (AD DS) protocols and can’t be easily modified to use modern authentication. By running these applications against a managed domain in Azure, you can lift and shift AD‑dependent workloads to the cloud without extending or operating their on‑premises AD DS infrastructure in Azure.

Entra Domain Services integrates with Microsoft Entra ID, which acts as the source of authority for users, groups, and credentials. This integration enables users to sign in to applications and services connected to the managed domain using their existing identities, while allowing you to centralize identity management in Microsoft Entra ID.

> [!div class="nextstepaction"]
> [To get started, create a Domain Services managed domain using the Microsoft Entra admin center][tutorial-create]

Take a look at our short video to learn more about Entra Domain Services.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=0a092182-e2de-4538-a6b4-adfcacf1cc54]

<a name='how-does-azure-ad-ds-work'></a>

## When to use Microsoft Entra Domain Services

Entra Domain Services is designed for organizations that are modernizing identity and access management with Entra ID but still have applications or workloads that depend on AD protocols.

You should consider using Entra Domain Services in the following scenarios:

- **Lift-and-shift legacy applications:** You have applications running on-premises that depend on LDAP, Kerberos, NTLM, Group Policy, or domain join. You want to move these workloads to the cloud but avoid rewriting them to support modern authentication like OIDC or OAuth.
- **Reduce on-premises footprint:** Your organization wants to move workloads to the cloud and retire on-premises hardware. Instead of maintaining a site-to-site VPN connection solely for authentication traffic back to on-premises AD DS, you can use a managed domain in Azure.
- **Implement an AD-minimized strategy:** You are adopting a cloud-first strategy where Microsoft Entra ID is the primary identity provider. Entra Domain Services supports the remaining legacy AD-dependent workloads, and avoids the need to extend old AD DS artefacts into Azure.
- **Isolate legacy workloads:** You want to keep AD‑dependent workloads in Azure while new applications use Microsoft Entra ID directly.
- **Cloud-only legacy support:** You are a cloud-native organization with no on-premises Active Directory, but you have specific third-party applications that still require LDAP or traditional domain-join. Entra Domain Services bridges this gap without forcing you to build a full AD DS infrastructure.

You use Entra Domain Services as a transitional capability alongside Entra ID, rather than as a replacement for cloud‑native identity services.

Learn more about these scenarios at [Common use-cases and scenarios for Microsoft Entra Domain Services](scenarios.md).


## Entra Domain Services in the cloud journey

Entra Domain Services helps you to achieve your goal of "AD minimization" — reducing reliance on legacy identity infrastructure in favor of modern, cloud-based identity such as Entra ID.

Entra Domain Services acts as a bridge in this journey:

- **Modern apps:** New, cloud-native apps should use Entra ID.
- **Legacy apps:** Older apps that cannot be easily modernized run in Azure using Entra Domain Services.

This approach avoids the complexity and security burden of manually deploying and managing AD DCs on Azure Virtual Machines (IaaS). By using Domain Services, you gain the compatibility you need for legacy apps while keeping your identity management centralized in Entra ID.

To learn more about Microsoft’s recommended approach, see [Cloud transformation posture](/entra/architecture/road-to-the-cloud-posture).

## How does Entra Domain Services work?

When you create an Entra Domain Services managed domain, you define a unique namespace, such as *aaddscontoso.com*. Two Windows Server domain controllers are deployed into your selected Azure region as part of a replica set.

These domain controllers are fully managed by Microsoft. You don’t need to configure, patch, or monitor them. The platform handles availability, backups, and encryption at rest.

A managed domain is configured to perform a one‑way synchronization from Microsoft Entra ID. Users, groups, and credentials from Entra ID are made available in the managed domain so that applications, services, and virtual machines in Azure can use familiar AD DS capabilities such as domain join, Group Policy, LDAP, and Kerberos/NTLM authentication.

In hybrid environments, identity information from on‑premises Active Directory Domain Services is synchronized to Microsoft Entra ID, and then made available to the managed domain.

Entra Domain Services works with both cloud‑only Microsoft Entra tenants and tenants synchronized with an on‑premises AD DS environment. The same set of managed domain capabilities is available in both scenarios.

You can also deploy multiple replica sets across Azure regions to improve availability and support disaster recovery scenarios for legacy applications. For more information, see [Replica sets concepts and features for managed domains][concepts-replica-sets].

## Entra Domain Services features and benefits

To provide identity services to applications and VMs in the cloud, Domain Services is fully compatible with a traditional AD DS environment for operations such as domain-join, secure LDAP (LDAPS), Group Policy, DNS management, and LDAP bind and read support. LDAP write support is available for objects created in the managed domain, but not resources synchronized from Microsoft Entra ID.

The following features of Domain Services simplify deployment and management operations:

* **Simplified deployment experience:** Domain Services is enabled for your Microsoft Entra tenant using a single wizard in the Microsoft Entra admin center.
* **Integration with Microsoft Entra ID:** User accounts, group memberships, and credentials are automatically available from your Microsoft Entra ID. New users, groups, or changes to attributes from your Microsoft Entra tenant or your on-premises AD DS environment are automatically synchronized to Domain Services.
    * Accounts in external directories linked to your Microsoft Entra ID aren't available in Domain Services. Credentials aren't available for those external directories, so can't be synchronized into a managed domain.
* **Use your corporate credentials/passwords:** Passwords for users in Domain Services are the same as in your Microsoft Entra tenant. Users can use their corporate credentials to domain-join machines, sign in interactively or over remote desktop, and authenticate against the managed domain.
* **Support for NTLM and Kerberos authentication:** With support for NTLM and Kerberos authentication, you can deploy applications that rely on Windows-integrated authentication.
* **Built‑in High availability:** Domain Services includes multiple domain controllers, which provide high availability for your managed domain. This high availability guarantees service uptime and resilience to failures.
    * In regions that support [Azure Availability Zones][availability-zones], these domain controllers are also distributed across zones for additional resiliency.
* **Disaster recovery:** Use [replica sets][concepts-replica-sets] to provide geographical disaster recovery.

A managed domain is a stand‑alone domain and isn’t an extension of an on‑premises domain. If required, you can [configure forest trusts][forest-trusts] with on‑premises AD DS environments to support hybrid access scenario.

To learn more about your identity options, [compare Domain Services with Microsoft Entra ID, AD DS on Azure VMs, and AD DS on-premises][compare].

## Next steps

To learn more about Domain Services compares with other identity solutions and how synchronization works, see the following articles:

* [Compare Domain Services with Microsoft Entra ID, Active Directory Domain Services on Azure VMs, and Active Directory Domain Services on-premises][compare]
* [Learn how Microsoft Entra Domain Services synchronizes with your Microsoft Entra directory][synchronization]
* To learn how to administrator a managed domain, see [management concepts for user accounts, passwords, and administration in Domain Services][administration-concepts].

To get started, [create a managed domain using the Microsoft Entra admin center][tutorial-create].

<!-- INTERNAL LINKS -->
[compare]: compare-identity-solutions.md
[synchronization]: synchronization.md
[tutorial-create]: tutorial-create-instance.md
[password-hash-sync]: /azure/active-directory/hybrid/connect/how-to-connect-password-hash-synchronization
[availability-zones]: /azure/reliability/availability-zones-overview
[forest-trusts]: ./concepts-forest-trust.md
[administration-concepts]: administration-concepts.md
[synchronization]: synchronization.md
[concepts-replica-sets]: concepts-replica-sets.md
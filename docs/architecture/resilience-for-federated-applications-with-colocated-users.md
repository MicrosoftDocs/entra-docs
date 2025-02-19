---
title: Increase the resilience of authentication and authorization for federated applications with colocated users
description: Resilience guidance for application deployments for federated applications with orchestration of a relying party security token service
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: markwahl-msft
ms.author: mwahl
manager: martinco
ms.date: 02/14/2025
---

# Increase the resilience of authentication and authorization for federated applications with colocated users

One scenario that many organizations [building for resilience](resilience-overview.md) in their identity and access management architecture need to accommodate is continuity of application access during temporary site disconnection. The organization may have one or more physical sites at which their applications are deployed, some of their users are colocated at those sites and need to be able to access the applications. For example, employees at a factory or at a store may need to be able to sign-in to in-house-developed business applications managing operations at that site. Historically, organizations could use Active Directory Domain Services, deploy [domain controllers at each site](/windows-server/identity/ad-ds/plan/planning-domain-controller-placement), so that users could authenticate to a local domain controller. Authenticating users through Microsoft Entra and connecting applications to Microsoft Entra ID via federation protocols such as SAML brings benefits, including multi-factor authentication and risk based conditional access. When applications are federated to Microsoft Entra, the users authenticate themselves to Microsoft Entra, and Microsoft Entra then provides tokens that indicates their authentication status to the applications. However, if the users and applications are unable to access Microsoft Entra cloud endpoints, which can occur if there is a break in network connectivity between the site and the Internet, then no more tokens can be issued to applications via that route until the break is repaired. Users already authenticated to the application may be able to continue to use the application until the application requires the user to re-authenticate, but will not be able to get a new access token from Microsoft Entra, and any user who did not previously connect to the application may find themselves unable to use the application as well.

One approach to solving this problem and ensuring tokens can be issued to federated applications even during temporary site disconnection is:

* maintain an Active Directory domain controller at each site
* ensure users at a site can authenticate to either the Active Directory or Microsoft Entra and that the same claims are available from both identity providers
* configure applications to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-without-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application and both Windows Server AD and Microsoft Entra ID as an identity provider.":::

For prepackaged or existing federated applications, it may not be feasible to configure the applications to have multiple trusted identity providers, or may require significant engineering effort to implement a process that changes many applications with different configuration models.

An alternative approach is to add a relying party security token service (STS), such as AD FS. In this topology,
* maintain an Active Directory domain controller at each site
* ensure users at a site can authenticate to either the Active Directory or Microsoft Entra
* configure applications to trust the local relying party security token service (STS)
* configure the relying party STS to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-with-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application, a relying party STS, and both Windows Server AD and Microsoft Entra ID as an identity provider.":::

This tutorial illustrates how to configure Microsoft Entra for a federated application, using a relying party STS. In normal operations, users will authenticate to Microsoft Entra, and Microsoft Entra will issue tokens for the application. And in a site disconnect situation, users can authenticate to Active Directory, and obtain tokens for that application with similar claims as that provided by Microsoft Entra. While the capabilities of multi-factor authentication, risk-based conditional access, and other Microsoft Entra features will not be available during the time of disconnection, users will continue to be able to be authenticated to access to those applications.

## Prerequisites

- An Active Directory domain
- A relying party STS, such as Active Directory Federation Services
- An application which implements a federation protocol such as SAML

## Ensure consistent user identities across Windows Server AD and Microsoft Entra ID

* Create users in AD and synchronize to Microsoft Entra

## Provide a user authentication option for Windows Server AD

* Set password in AD and implement password hash sync


## Deploy a relying party STS

* [Enable single sign-on for an enterprise application with a relying party security token service](~/identity/enterprise-apps/add-application-portal-setup-sso-rpsts.md)
* add users to app role
* configure AD

## Orchestrate changing the identity providers applicable to the application in the relying party STS configuration

* [Configure an identity provider list per relying party](/windows-server/identity/ad-fs/operations/home-realm-discovery-customization#configure-an-identity-provider-list-per-relying-party)

## Next steps

* [What is application management in Microsoft Entra ID?](~/identity/enterprise-apps/what-is-application-management.md)
* [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)

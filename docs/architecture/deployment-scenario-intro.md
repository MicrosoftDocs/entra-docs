---
title: Microsoft Entra deployment scenarios introduction
description: The Microsoft Entra deployment scenarios article series provides guidance regarding the Microsoft Entra Suite. 
ms.author: gasinh
author: gargi-sinha
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: concept-article
ms.date: 06/13/2024

#CustomerIntent: As a Microsoft Entra customer, I want learn how to configure the Microsoft Entra Suite products so that we can achieve best practices for them working together.
---
# Microsoft Entra deployment scenarios introduction

The Microsoft Entra deployment scenarios provide you with detailed guidance on how to combine and test these Microsoft Entra Suite products:

- [Microsoft Entra ID Protection](../id-protection/overview-identity-protection.md)
- [Microsoft Entra ID Governance](../id-governance/identity-governance-overview.md)
- [Microsoft Entra Verified ID (premium capabilities)](../verified-id/decentralized-identifier-overview.md)
- [Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md)
- [Microsoft Entra Private Access](../global-secure-access/concept-private-access.md)

In each guide, we describe scenarios that show the value of the Microsoft Entra Suite and how its capabilities work together.

## Workforce and guest onboarding, identity, and access lifecycle governance across all your apps

The [Workforce and guest onboarding, identity, and access lifecycle governance](deployment-scenario-workforce-guest.md) scenario describes these goals:

- Provide remote employees with secure and seamless access to necessary apps and resources.
- Collaborate with external users by providing them with access to relevant apps and resources.

The step-by-step solution focuses on Microsoft Entra Verified ID, Microsoft Entra ID Governance, Microsoft Entra ID Protection, and Conditional Access (CA):

- Microsoft Entra Verified ID issues and verifies digital identity proofs for remote employees and external users. Digital wallets store identity proofs to verify access to apps and resources. Face Check facial recognition verifies identity with credential-stored pictures.
- Microsoft Entra ID Governance creates and grants access packages with verifiable credentials. Users request access packages through a self-service portal with digital identity verification. Microsoft Entra accounts regulate access to access package apps and resources with single sign-on and multifactor authentication (MFA).
- Microsoft Entra ID Protection and Conditional Access (CA) monitor and protect accounts from risky sign-ins and user behavior. Access control enforcement factors in location, device, and risk level.

## Modernize remote access to on-premises apps with MFA per app

The [Modernize remote access to on-premises apps with MFA per app](deployment-scenario-remote-access.md) scenarios describe these goals:

- Upgrade existing VPN to a scalable cloud-based solution that helps to move towards Secure Access Service Edge (SASE).
- Resolve issues where business application access relies on corporate network connectivity.

The step-by-step solution focuses on Microsoft Entra Private Access, Microsoft Entra ID Protection, and Microsoft Entra ID Governance:

- Microsoft Entra Private Access provides secure access to private corporate resources. It builds on the Microsoft Entra application proxy to extend access to any private resource, independent of TCP/IP port and protocol. Remote users connect to private apps from any device and network without VPN. Per-app adaptive access based on Conditional Access (CA) policies provide granular security based on identity, endpoint, and risk signal.
- Microsoft Entra ID Protection cloud-based identity and access management (IAM) protects user identities and credentials from compromise.
- Microsoft Entra ID Governance enforces least privilege. Access packages include per-app network access alongside applications that require it, granting corporate network access to employees aligned with their job functions across their joiner/mover/leaver lifecycle.

## Secure internet access based on business needs

The [Secure internet access based on business needs](deployment-scenario-internet-access.md) scenario describes these goals:

- Augment existing strict default internet access policies with more internet access control.
- Allow users to request access to prohibited sites in [My Access](../id-governance/my-access-portal-overview.md). The approval process adds users to a group that grants them access. Examples include marketing department access to social networking sites and security department access to high-risk internet destinations while investigating incidents.

The step-by-step solution focuses on Microsoft Entra Internet Access, Microsoft Entra ID Governance, Conditional Access, and Global Secure Access:

- Create a security profile and web content filtering policies with a restrictive baseline policy that blocks specific web categories and web destinations for all users.
- Create security profiles and web content filtering policies for social networking sites and high-risk internet destinations.
- Use Microsoft Entra ID Governance to allow users to request access to access packages.
- Create and link Conditional Access policies with Global Secure Access security profile session control.

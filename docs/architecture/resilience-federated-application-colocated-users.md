---
title: Increase the resilience of authentication and authorization for federated applications with colocated users
description: Resilience guidance for application deployment for applications using a relying party security token service with orchestration for switching the identity provider
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: markwahl-msft
ms.author: mwahl
manager: martinco
ms.date: 02/14/2025
---

# Increase the resilience of authentication and authorization for federated applications with colocated users

with orchestration switching the identity provider

## Prerequisites

- A relying party STS, such as Active Directory Federation Services
- An application

## Ensure consistent user identities across Windows Server AD and Microsoft Entra ID

Create users in AD
Synchronization 

## Provide a user authentication option for Windows Server AD

Set password in AD
Password hash sync

federated identity provider

## Deploy a relying party STS

[Enable single sign-on for an enterprise application with a relying party security token service](~/identity/enterprise-apps/add-application-prtaol-setup-sso-rpsts.md)
add users to app role

AD

## Orchestrate changing the identity providers applicable to the application in the relying party STS configuration

[Configure an identity provider list per relying party](/windows-server/identity/ad-fs/operations/home-realm-discovery-customization#configure-an-identity-provider-list-per-relying-party)



## Next steps

* [What is application management in Microsoft Entra ID?](~/identity/enterprise-apps/what-is-application-management.md)
* [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)

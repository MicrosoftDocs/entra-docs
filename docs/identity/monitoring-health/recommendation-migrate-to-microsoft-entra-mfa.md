---
title: Recommendation to migrate to Microsoft Entra MFA
description: Learn about the Microsoft Entra recommendation to migrate to Microsoft Entra multifactor authentication from MFA server
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 04/09/2025
ms.author: sarahlipsey
ms.reviewer:  jupetter

# Customer intent: As an IT admin, I need to migrate from MFA Server to Microsoft Entra MFA to align with Microsoft Entra recommendations.

---
# Microsoft Entra recommendation: Migrate from MFA server to Microsoft Entra multifactor authentication (MFA)

[Microsoft Entra recommendations](overview-recommendations.md) provide you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to migrate from MFA server to Microsoft Entra MFA. This recommendation is called `mfaServerDeprecation` in the recommendations API in Microsoft Graph.

## Description

Azure Multi-Factor Authentication Server (MFA Server) was scheduled for retirement on September 30th, 2024. To help organizations migrate to Microsoft Entra MFA, this Microsoft Entra recommendation identifies tenants with MFA server activity. This recommendation identifies tenants with active users and MFA attempts for MFA Server in the last seven days. MFA Server client integrations, including a list of affected clients are also surfaced as a part of this recommendation.

## Value 

MFA Server is a component for deploying and managing MFA on-premises. In 2019, Microsoft stopped allowing new deployments of MFA Server and investing in feature enhancements. In September 2022, [Microsoft formally announced the deprecation of MFA Server](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/microsoft-entra-change-announcements-september-2022-train/ba-p/2967454).

Cloud-based, Microsoft Entra multifactor authentication offers better resiliency, availability, and data compliancy. Migrating to Microsoft Entra MFA helps you improve your security posture by giving you access to the latest phishing-resistant authentication methods and more fine-grained access controls. It also helps reduce cost and deployment complexity by no longer having to maintain an on-premises component. 

## Action plan

1. [Learn how to migrate MFA Server to Microsoft Entra MFA](../authentication/how-to-migrate-mfa-server-to-mfa-user-authentication.md).

1. Migrate MFA user information from on-premises to Microsoft Entra.
    - You can either migrate this information manually or use the MFA Server Migration Utility (recommended).
    - [How to use the MFA Server Migration Utility](../authentication/how-to-mfa-server-migration-utility.md).

1. Use [Staged Rollout](../authentication/how-to-mfa-server-migration-utility.md#enable-staged-rollout) to reroute users to authenticate against Microsoft Entra instead of MFA Server.  

1. Identify and migrate any MFA Server dependencies, such as applications using [RADIUS or LDAP authentication](../authentication/how-to-mfa-server-migration-utility.md#authentication-services). 

1. Update domain federation settings and decommission MFA Server. 

## Related content

- [Review the Microsoft Entra recommendations overview](overview-recommendations.md)
- [Learn how to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Explore the Microsoft Graph API properties for recommendations](/graph/api/resources/recommendation)

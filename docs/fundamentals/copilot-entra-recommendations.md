---
title: Microsoft Entra Recommendations with Microsoft Security Copilot
description: Use Microsoft Security Copilot and Microsoft Entra skills to quickly investigate how to evolve your tenant to a secure and healthy state.
keywords:
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 05/29/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
# Customer intent:
---

# Microsoft Entra Recommendations with Microsoft Security Copilot

> [!NOTE]
> 
> This article is a work in progress. It will be updated with more information, methods, and examples before GA.

Keeping track of all the settings and resources in your tenant can be overwhelming. The Microsoft Entra recommendations feature helps monitor the status of your tenant, so you don't have to. Entra Recommendations applies the capabilities of Microsoft Security Copilot  to help your security team investigate how to evolve your tenants to secure and healthy state while also helping you maximize the value of the features available in Microsoft Entra ID. 

By combining Recommendations signals with the power of generative AI, Security Copilot enables analysts to ask natural language questions—such as how to improve your secure score, recommendations details, or retrieving details of impacted resources —and receive clear insights in seconds. 

Required 

Roles: Global Administrator, Application Administrator, IT Governance Administrator, Privileged Role Administrator, Identity Governance Administrator, Conditional Access Administrator, Security Administrator, Hybrid Identity Administrator, Authentication Policy Administrator, Authentication Administrator 

Licensing: Entra ID License (Free, P1, P2), Microsoft Entra Workload ID 

Tenant: A cloud tenant with recommendations for maximizing your license on it.  

 

Supported Prompts (Examples) 

List all Entra recommendations 

Show my tenant's historical Secure Score data 

Show Entra recommendation "example” and its details 

Show the resources affected by an Entra recommendation 

Show resource "example” of Entra recommendation "example” 

List secure score recommendations 

List best practice recommendations 

List recommendations for conditional access policies 

Show Entra recommendations for a specific feature area 

List high-priority recommendations 

List recommendations with high priority 

List recommendations that are active 

List recommendations to improve app portfolio health 

List recommendations to reduce surface area risk 

List recommendations to improve security posture of my apps 

List recommendations for tenant configuration 

Show Entra recommendations by impact type 

Which enterprise applications have credentials about to expire? 

Show me service principals with credentials that are expiring soon 

Show me applications with credentials that are expiring soon 

Which of our apps are stale or unused in the tenant? 

List the unused apps. 
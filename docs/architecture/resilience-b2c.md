---
title: Build resilience in customer identity and access management with Azure AD B2C
description: Learn methods to build resilience in customer identity and access management (CIAM) using Azure AD B2C.
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 06/28/2024
---

# Build resilience in customer identity and access management with Azure AD B2C

[Azure AD B2C](/azure/active-directory-b2c/overview) is a customer identity and access management (CIAM) platform that is designed to help you launch your critical customer facing applications. We have built-in features for [resilience](https://azure.microsoft.com/blog/advancing-azure-active-directory-availability/) to help our service scale to your needs and improve resilience in the face of potential outage situations. In addition, when launching a mission critical application, it's important to consider various design and configuration elements in your application. Consider how the application is configured in Azure AD B2C to ensure you see resilient behavior in response to outage or failure scenarios. In this article, we discuss some of the best practices to help you increase resilience.

A resilient service continues to function despite disruptions. To improve resilience:

- Understand all the components
- Eliminate single points of failures
- Limit effects by isolating failing components
- Provide redundancy with fast failover mechanisms and recovery paths

As you develop your application, we recommend you consider how to [increase resilience of authentication and authorization in your applications](resilience-app-development-overview.md) with the identity components of your solution. This article attempts to address enhancements for resilience for Azure AD B2C applications. We group our recommendations by CIAM functions.

In the subsequent sections, we guide you to build resilience in the following areas:

- [End-user experience](resilient-end-user-experience.md): Enable a fallback plan for your authentication flow and mitigate the potential impact from a disruption of Azure AD B2C authentication service.
- [Interfaces with external processes](resilient-external-processes.md): Build resilience in your applications and interfaces by recovering from errors.  
- [Developer best practices](resilience-b2c-developer-best-practices.md): Avoid fragility because of common custom policy issues and improve error handling in the areas like interactions with claims verifiers, third-party applications, and REST APIs.
- [Monitoring and analytics](resilience-with-monitoring-alerting.md): Assess the health of your service by monitoring key indicators and detect failures and performance disruptions through alerting.
- [Build resilience in authentication infrastructure](resilience-in-infrastructure.md): Understand, contain, and mitigate the risk of disrupted authentication or authorization for resources.
- [Increase resilience of authentication and authorization in applications](resilience-app-development-overview.md): Use Microsoft identity platform to build apps your users and customers sign in to with Microsoft identities or social accounts. 

Watch the following video to [build resilient and scalable flows](https://www.youtube.com/embed/8f_Ozpw9yTs). Learn how to design and configure resilient and scalable services using Azure AD B2C.

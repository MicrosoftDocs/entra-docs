---
title: Build resilience in customer identity and access management using Azure AD B2C
description: Learn about methods to build resilience in customer identity and access management (CIAM) using Azure AD B2C.
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 06/27/2024
---

# Build resilience in customer identity and access management using Azure AD B2C

[Azure AD B2C](/azure/active-directory-b2c/overview) is a customer identity and access management (CIAM) platform that helps you launch customer facing applications. A resilient service is one that functions despite disruptions. There are features for [resilience](https://azure.microsoft.com/blog/advancing-azure-active-directory-availability/) that enable our service to scale to your needs and improve resilience in the face of potential outages. In addition, when launching applications, it's important to consider various design and configuration elements. Consider how the application is configured in Azure AD B2C to ensure resilient behavior in response to outages or failures. In this article, learn best practices to help you increase resilience.

Improve resilience in your service:

- Understand all the components
- Eliminate single points of failures
- Isolate failing components and limit their effect
- Enable redundancy with fast failover mechanisms and recovery paths

As you develop your application, consider how to [increase resilience of authentication and authorization in your applications](resilience-app-development-overview.md) with the identity components of your solution. 

By following instructions, find guidance on building resilience in:

- [End-user experience](resilient-end-user-experience.md): Enable a fallback plan for authentication flow. Mitigate the potential effects of a disruption of Azure AD B2C authentication service.
- [Interfaces with external processes](resilient-external-processes.md): Build resilience in your applications and interfaces. Recover effectively from errors.  
- [Developer best practices](resilience-b2c-developer-best-practices.md): Avoid fragility due to common custom policy issues and improve error handling in claims verifiers, third-party applications, and REST APIs.
- [Monitoring and analytics](resilience-with-monitoring-alerting.md): Assess service health by monitoring key indicators. Detect failures and performance disruptions with alerting.
- [Resilience in authentication infrastructure](resilience-in-infrastructure.md)
- [Increase resilience of authentication and authorization in applications](resilience-app-development-overview.md)

In the following video, see how to [build resilience and scalable flows with Azure AD B2C](https://www.youtube.com/embed/8f_Ozpw9yTs).

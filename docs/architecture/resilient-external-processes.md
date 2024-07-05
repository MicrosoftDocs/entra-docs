---
title: Resilient interfaces with external processes using Azure AD B2C
description: Learn about methods to build resilient interfaces with external processes.
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 06/28/2024
---

# Resilient interfaces with external processes using Azure AD B2C

In this article, find guidance on how to plan for and implement the RESTful APIs to make your application more resilient to API failures.

## Ensure correct API placement

Use identity experience framework (IEF) policies to call an external system using a [RESTful API technical profile](/azure/active-directory-b2c/restful-technical-profile). The IEF runtime environment doesn't control external systems, which is a potential failure point.

### Manage external systems using APIs

While calling an interface to access certain data, confirm the data drives the authentication decision. Assess whether the information is essential to the functionality of the application. For example, an e-commerce vs. a secondary functionality such as an administration. If the information isn't needed for authentication, consider moving the call to the application logic.

If the data for authentication is relatively static and small, and shouldn't be externalized, put it in the directory.

When possible, remove API calls from the preauthenticated path. If you can't, then enable protections for Denial of Service (DoS) and Distributed Denial of Service (DDoS) attacks for APIs. Attackers can load the sign-in page and try to flood your API with DoS attacks to disable your application. For example, use Completely Automated Public Turing Test To Tell Computers and Humans Apart (CAPTCHA) in your sign in and sign up flow.

Use [API connectors of sign-up user flows](/azure/active-directory-b2c/api-connectors-overview) to integrate with web APIs after federating with an identity provider, during sign-up, or before you create the user. Because user flows are tested, you don't have to perform user flow-level functional, performance, or scale testing. Test your applications for functionality, performance, and scale.

Azure AD B2C RESTful API [technical profiles](/azure/active-directory-b2c/restful-technical-profile) don't provide any caching behavior. Instead, RESTful API profile implements a retry logic and a timeout built into the policy.

For APIs that need to write data, use a task to have these actions executed by a background worker. Use services like [Azure queues](/azure/storage/queues/storage-queues-introduction). This practice makes the API return efficiently and increases the policy execution performance.  

## API errors

Because the APIs live outside the Azure AD B2C system, enable error handling in the technical profile. Ensure users are informed and the application can deal with failure gracefully.

### Handle API errors

Because APIs fail for various reasons, make your application resilient. [Return an HTTP 4XX error message](/azure/active-directory-b2c/restful-technical-profile#returning-validation-error-message) if the API is unable to complete the request. In the Azure AD B2C policy, try to handle the unavailability of the API and perhaps render a reduced experience.

[Handle transient errors gracefully](/azure/active-directory-b2c/restful-technical-profile#error-handling). Use the RESTful API profile to configure error messages for various [circuit breakers](/azure/architecture/patterns/circuit-breaker).

Monitor and use continuous integration and continuous delivery (CICD). Rotate the API access credentials such as passwords and certificates used by the [technical profile engine](/azure/active-directory-b2c/restful-technical-profile).

## API management best practices

While you deploy the REST APIs and configure the RESTful technical profile, use the following best practices to avoid common errors.

### API Management

API Management (APIM) publishes, manages, and analyzes APIs. APIM handles authentication for secure access to back-end services and microservices. Use an API gateway to scale out API deployments, caching, and load balancing.

Our recommendation is to get the right token, instead of calling multiple times for each API and [secure an Azure APIM API](/azure/active-directory-b2c/secure-api-management?tabs=app-reg-ga).

## Next steps

- [Resilience resources for Azure AD B2C developers](resilience-b2c.md)
  - [Resilient end-user experience](resilient-end-user-experience.md)
  - [Resilience through developer best practices](resilience-b2c-developer-best-practices.md)
  - [Resilience through monitoring and analytics](resilience-with-monitoring-alerting.md)
- [Build resilience in authentication infrastructure](resilience-in-infrastructure.md)
- [Increase resilience of authentication and authorization in applications](resilience-app-development-overview.md)

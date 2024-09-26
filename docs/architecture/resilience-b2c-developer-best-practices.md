---
title: Resilience through developer best practices using Azure AD B2C
description: Resilience through developer best practices in Customer Identity and Access Management using Azure AD B2C
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 07/02/2024
---

# Resilience through developer best practices

In this article, you can benefit from our experience working with large customers. You can consider these recommendations for the design and implementation of your services.

## Microsoft Authentication Library

[Microsoft Authentication Library](~/identity-platform/msal-overview.md) (MSAL) and the [Microsoft identity web authentication library for ASP.NET](~/identity-platform/reference-v2-libraries.md) simplify acquiring, managing, caching, and refreshing the tokens for applications. These libraries are optimized to support Microsoft Identity, including features that improve application resiliency.

Developers can adopt latest releases of MSAL and stay up to date. See [how to increase resilience of authentication and authorization](resilience-app-development-overview.md) in your applications. Where possible, avoid implementing your own authentication stack. Instead, use well-established libraries.

## Optimize directory reads and writes

The Azure AD B2C directory service supports billions of authentications a day, with a high rate of reads per second. Optimize your writes to minimize dependencies and increase resilience.

### How to optimize directory reads and writes

- **Avoid write functions to the directory on sign-in**: Avoid executing a write on sign-in without a precondition (if clause) in your custom policies. One use case that requires a write on a sign-in is [just-in-time migration of user passwords](https://github.com/azure-ad-b2c/user-migration/tree/master/seamless-account-migration). Don't require a write on every sign-in. [Preconditions](/azure/active-directory-b2c/userjourneys) in a user journey are:

  ```xml
  <Precondition Type="ClaimEquals" ExecuteActionsIf="true"> 
  <Value>requiresMigration</Value>
  ...
  <Precondition/>
  ```

- **Understand throttling**: The directory implements application and tenant level throttling rules. There are more rate limits for Read/GET, Write/POST, Update/PUT, and Delete/DELETE operations. Each operation has differing limits.

  - A write during sign-in falls under a POST for new users or PUT for current users.
  - A custom policy that creates or updates a user on every sign-in, can hit an application level PUT or POST rate limit. The same limits apply when updating directory objects via Microsoft Entra ID or Microsoft Graph. Similarly, examine the reads to keep the number of reads on every sign-in to the minimum.
  - Estimate peak load to predict the rate of directory writes and avoid throttling. Peak traffic estimates should include estimates for actions such as sign-up, sign-in, and multifactor authentication (MFA). Test the Azure AD B2C system and your application for peak traffic. Azure AD B2C can handle the load without throttling, when your downstream applications or services won't.
  - Understand and plan your migration timeline. When planning to migrate users to Azure AD B2C using Microsoft Graph, consider the application and tenant limits to calculate the time to complete user migration. If you split your user creation job or script using two applications, you can use the per-application limit. Ensure it remains below the per tenant threshold.
  - Understand the effects of your migration job on other applications. Consider the live traffic served by other relying applications to ensure no throttling at the tenant level and resource starvation for your live application. For more information, see the [Microsoft Graph throttling guidance](/graph/throttling).
  - Use a [load test sample](https://github.com/azure-ad-b2c/load-tests) to simulate sign-up and sign-in. 
  - Learn more about [Azure AD B2C service limits and restrictions](/azure/active-directory-b2c/service-limits?pivots=b2c-custom-policy).
  
## Token lifetimes

If the Azure AD B2C authentication service can't complete new sign-ups and sign-ins, provide mitigation for users who are signed in. With [configuration](/azure/active-directory-b2c/configure-tokens), users that are signed in can use the application without disruption until they sign out from the application, or the [session](/azure/active-directory-b2c/session-behavior) times out from inactivity.

Your business requirements and end-user experience dictate the frequency of token refresh for web and single-page applications (SPAs).

### Extend token lifetimes

- **Web applications**: For web applications where the authentication token is validated at sign-in, the application depends on the session cookie to continue to extend the session validity. Enable users to remain signed in by implementing rolling session times that renew based on user activity. If there's a long-term token issuance outage, these session times can be increased as a one-time configuration on the application. Keep the lifetime of the session to the maximum allowed.
- **SPAs**: A SPA might depend on access tokens to make calls to the APIs. For SPAs, we recommend using the authorization code flow with [Proof Key for Code Exchange (PKCE)](~/identity-platform/reference-third-party-cookies-spas.md) flow as an option to allow the user to continue to use the application. If your SPA is using implicit flow, consider migrating to authorization code flow with PKCE. Migrate your application from MSAL.js 1.x to MSAL.js 2.x to realize the resiliency of web applications. The implicit flow doesn't result in a refresh token. The SPA can use a hidden `iframe` to perform new token requests against the authorization endpoint if the browser has an active session with the Azure AD B2C. For SPAs, there are a few options to allow the user to continue use of the application. 
  - Extend the access token's validity duration.
  - Build your application to use an API gateway as the authentication proxy. In this configuration, the SPA loads without authentication and the API calls are made to the API gateway. The API gateway sends the user through a sign-in process using an [authorization code grant](https://oauth.net/2/grant-types/authorization-code/), based on a policy, and authenticates the user. The authentication session between the API gateway and the client is maintained using an authentication cookie. The API gateway services the APIs using the token obtained by the API gateway, or another direct authentication method such as certificates, client credentials, or API keys.
  - Switch to the recommended option. Migrate your SPA from implicit grant to [authorization code grant flow](/azure/active-directory-b2c/implicit-flow-single-page-application) with Proof Key for Code Exchange (PKCE) and Cross-Origin Resource Sharing (CORS) support. 
  - For mobile applications, extend the refresh and access token lifetimes.
- **Back-end or microservice applications**: Back-end (daemon) applications are non-interactive and aren't in a user context, therefore the prospect of token theft is diminished. Our recommendation is to strike a balance between security and lifetime and set a long token lifetime.

## Single sign-on

With [single sign-on](~/identity/enterprise-apps/what-is-single-sign-on.md) (SSO), users sign in once with an account and get access to applications: a web, mobile, or a single page application (SPA), regardless of platform or domain name. When the user signs in to an application, Azure AD B2C persists a [cookie-based session](/azure/active-directory-b2c/session-behavior).

Upon subsequent authentication requests, Azure AD B2C reads and validates the cookie-based session and issues an access token without prompting the user to sign in. If SSO is configured with a limited scope at a policy or an application, later access to other policies and applications require fresh authentication.

### Configure SSO

[Configure SSO](~/identity/hybrid/connect/how-to-connect-sso-quick-start.md) to be tenant-wide (default) to allow multiple applications and user flows in your tenant to share the same user session. Tenant-wide configuration provides the most resiliency for fresh authentication.  

## Safe deployment practices

The most common service disruptions are code and configuration changes. Adoption of Continuous Integration and Continuous Delivery (CICD) processes and tools enable deployment at a large scale and reduces human errors during testing and deployment. Adopt CICD for error reduction, efficiency, and consistency. [Azure Pipelines](/azure/devops/pipelines/apps/cd/azure/cicd-data-overview) is an example of CICD.

## Protection from bots

Protect your applications from known vulnerabilities such as Distributed Denial of Service (DDoS) attacks, SQL injections, cross-site scripting, remote code execution, and others documented in [OWASP Top-10](https://owasp.org/www-project-top-ten/). Deploy a Web Application Firewall (WAF) to defend against common exploits and vulnerabilities.

- Use Azure [WAF](/azure/web-application-firewall/overview), which provides centralized protection against attacks.
- Use WAF with Microsoft Entra [ID Protection and Conditional Access to provide multi-layer protection](/azure/active-directory-b2c/conditional-access-identity-protection-overview) when using Azure AD B2C.
- Build resistance to bot-driven [sign-ups by integrating with a CAPTCHA system](https://github.com/azure-ad-b2c/samples/tree/master/policies/captcha-integration).

## Secrets

Azure AD B2C uses secrets for applications, APIs, policies, and encryption. The secrets secure authentication, external interactions, and storage. The National Institute of Standards and Technology (NIST) refers to the time span of key authorization, used by legitimate entities, as a *cryptoperiod*. Choose the needed length of [cryptoperiods](https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-5/final). Set the expiration and rotate secrets before they expire.

### Implement secret rotation

- Use [managed identities](~/identity/managed-identities-azure-resources/overview.md) for supported resources to authenticate to any service that supports Microsoft Entra authentication. When you use managed identities, you can manage resources automatically, including rotation of credentials.
- Take an inventory of [keys and certificates configured](/azure/active-directory-b2c/policy-keys-overview) in Azure AD B2C. This list can include keys used in custom policies, [APIs](/azure/active-directory-b2c/secure-rest-api), signing ID token, and certificates for Security Assertion Markup Language (SAML).
- Using CICD, rotate secrets that expire within two months from the anticipated peak season. The recommended maximum cryptoperiod of private keys associated to a certificate is one year.
- Monitor and rotate the API access credentials, such as passwords and certificates.

## REST API testing

For resiliency, REST APIs testing needs to include verification of HTTP codes, response payload, headers, and performance. Don't use only happy path tests, and confirm the API handles problem scenarios gracefully.

### Test plan

We recommend your test plan includes [comprehensive API tests](/azure/active-directory-b2c/best-practices#testing). For surges due to a promotion, or holiday traffic, revise load testing with new estimates. Conduct API load testing and Content Delivery Network (CDN) in a developer environment, not in production.

## Next steps

- [Resilience resources for Azure AD B2C developers](resilience-b2c.md)
  - [Resilient end-user experience](resilient-end-user-experience.md)
  - [Resilient interfaces with external processes](resilient-external-processes.md)
  - [Resilience through monitoring and analytics](resilience-with-monitoring-alerting.md)
- [Build resilience in your authentication infrastructure](resilience-in-infrastructure.md)
- [Increase resilience of authentication and authorization in your applications](resilience-app-development-overview.md)

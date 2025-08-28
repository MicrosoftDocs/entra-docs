---
title: Configure Microsoft Entra for increased security
description: Learn how to improve your security posture with Microsoft Entra.

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 07/21/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: ramical
---
# Configure Microsoft Entra for increased security (Preview)

The security recommendations in this document are designed to help you improve your security posture in Microsoft Entra. These recommendations are influenced by accepted industry standards like those developed by NIST, the configuration baselines we use internally at Microsoft, and our experiences with customers. The recommendations are organized by the [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative?msockid=2bad2df65a416adb0e5838355b3e6b95#SFI-pillars) pillars:

- Protect identities and secrets
- Protect tenants and isolate production systems
- Protect networks
- Protect engineering systems
- Monitor and detect cyberthreats
- Accelerate response and remediation

> [!TIP]
> Some organizations might take these recommendations exactly as written, while others might choose to make modifications based on their own business needs. In our initial release of this guidance, we focus on traditional [workforce tenants](/entra/external-id/tenant-configurations#workforce-tenants). These workforce tenants are for your employees, internal business apps, and other organizational resources. 

We recommend that all of the following controls be implemented where licenses are available. This helps to provide a foundation for other resources built on top of this solution. More controls will be added to this document over time.

## Protect identities and secrets

### Applications don't have client secrets configured
[!INCLUDE [21772](../includes/secure-recommendations/21772.md)]

### Applications don't have certificates with expiration longer than 180 days
[!INCLUDE [21773](../includes/secure-recommendations/21773.md)]

### Application Certificates need to be rotated on a regular basis
[!INCLUDE [21992](../includes/secure-recommendations/21992.md)]

### Microsoft services applications don't have credentials configured
[!INCLUDE [21774](../includes/secure-recommendations/21774.md)]

### User consent settings are restricted
[!INCLUDE [21776](../includes/secure-recommendations/21776.md)]

### Admin consent workflow is enabled
[!INCLUDE [21809](../includes/secure-recommendations/21809.md)]

### Privileged accounts are cloud native identities
[!INCLUDE [21814](../includes/secure-recommendations/21814.md)]

### All privileged role assignments are activated just in time and not permanently active
[!INCLUDE [21815](../includes/secure-recommendations/21815.md)]

### Privileged accounts have phishing-resistant methods registered
[!INCLUDE [21782](../includes/secure-recommendations/21782.md)]

### Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods
[!INCLUDE [21783](../includes/secure-recommendations/21783.md)]

### Require password reset notifications for administrator roles
[!INCLUDE [21891](../includes/secure-recommendations/21891.md)]

### Block legacy authentication
[!INCLUDE [21796](../includes/secure-recommendations/21796.md)]

### Migrate from legacy MFA and SSPR policies
[!INCLUDE [21803](../includes/secure-recommendations/21803.md)]

### SMS and Voice Call authentication methods are disabled
[!INCLUDE [21804](../includes/secure-recommendations/21804.md)]

### Turn off Seamless SSO if there is no usage
[!INCLUDE [21985](../includes/secure-recommendations/21985.md)]

### Secure the MFA registration (My Security Info) page
[!INCLUDE [21806](../includes/secure-recommendations/21806.md)]

### Use cloud authentication
[!INCLUDE [21829](../includes/secure-recommendations/21829.md)]

### Users have strong authentication methods configured
[!INCLUDE [21801](../includes/secure-recommendations/21801.md)]

### User sign-in activity uses token protection
[!INCLUDE [21786](../includes/secure-recommendations/21786.md)]

### Restrict device code flow
[!INCLUDE [21808](../includes/secure-recommendations/21808.md)]

### Authentication transfer is blocked
[!INCLUDE [21828](../includes/secure-recommendations/21828.md)]

### Authenticator app shows sign-in context
[!INCLUDE [21802](../includes/secure-recommendations/21802.md)]

### Password expiration is disabled
[!INCLUDE [21811](../includes/secure-recommendations/21811.md)]

### Require multifactor authentication for device join and device registration using user action
[!INCLUDE [21872](../includes/secure-recommendations/21872.md)]

### Enable Microsoft Entra ID security defaults
[!INCLUDE [21871](../includes/secure-recommendations/21871.md)]

## Protect tenants and isolate production systems

### Permissions to create new tenants are limited to the Tenant Creator role
[!INCLUDE [21787](../includes/secure-recommendations/21787.md)]

### Allow/Deny lists of domains to restrict external collaboration are configured
[!INCLUDE [21874](../includes/secure-recommendations/21874.md)]

### Guests are not assigned high privileged directory roles
[!INCLUDE [22128](../includes/secure-recommendations/22128.md)]

### Guests can't invite other guests
[!INCLUDE [21791](../includes/secure-recommendations/21791.md)]

### Guests have restricted access to directory objects
[!INCLUDE [21792](../includes/secure-recommendations/21792.md)]

### App instance property lock is configured for all multitenant applications
[!INCLUDE [21777](../includes/secure-recommendations/21777.md)]

### Guests don't have long lived sign-in sessions
[!INCLUDE [21824](../includes/secure-recommendations/21824.md)]

### Guest access is protected by strong authentication methods
[!INCLUDE [21851](../includes/secure-recommendations/21851.md)]

### Guest self-service sign-up via user flow is disabled
[!INCLUDE [21823](../includes/secure-recommendations/21823.md)]

### Outbound cross-tenant access settings are configured
[!INCLUDE [21790](../includes/secure-recommendations/21790.md)]

### Guests don't own apps in the tenant
[!INCLUDE [21868](../includes/secure-recommendations/21868.md)]

### All guests have a sponsor
[!INCLUDE [21877](../includes/secure-recommendations/21877.md)]

### Inactive guest identities are disabled or removed from the tenant
[!INCLUDE [21858](../includes/secure-recommendations/21858.md)]

## Protect networks

### Named locations are configured
[!INCLUDE [21865](../includes/secure-recommendations/21865.md)]

### Tenant restrictions v2 policy is configured
[!INCLUDE [21793](../includes/secure-recommendations/21793.md)]

## Protect engineering systems

### Cloud-only emergency access accounts exist
[!INCLUDE [21835](../includes/secure-recommendations/21835.md)]

### Global Administrator role activation triggers an approval workflow
[!INCLUDE [21817](../includes/secure-recommendations/21817.md)]

### Global Administrators don't have standing access to Azure subscriptions
[!INCLUDE [21788](../includes/secure-recommendations/21788.md)]

### Creating new applications and service principals is restricted to privileged users
[!INCLUDE [21807](../includes/secure-recommendations/21807.md)]

### Inactive applications don't have highly privileged Microsoft Graph API permissions
[!INCLUDE [21770](../includes/secure-recommendations/21770.md)]

### Inactive applications don't have highly privileged built-in roles
[!INCLUDE [21771](../includes/secure-recommendations/21771.md)]

### App registrations use safe redirect URIs
[!INCLUDE [21885](../includes/secure-recommendations/21885.md)]

### Service principals use safe redirect URIs
[!INCLUDE [23183](../includes/secure-recommendations/23183.md)]

### App registrations must not have dangling or abandoned domain redirect URIs
[!INCLUDE [21888](../includes/secure-recommendations/21888.md)]

### Resource-specific consent to application is restricted
[!INCLUDE [21810](../includes/secure-recommendations/21810.md)]

### Workload Identities are not assigned privileged roles
[!INCLUDE [21836](../includes/secure-recommendations/21836.md)]

### Enterprise applications must require explicit assignment or scoped provisioning
[!INCLUDE [21869](../includes/secure-recommendations/21869.md)]

### Conditional Access policies for Privileged Access Workstations are configured
[!INCLUDE [21830](../includes/secure-recommendations/21830.md)]

## Monitor and detect cyberthreats

### Diagnostic settings are configured for all Microsoft Entra logs
[!INCLUDE [21860](../includes/secure-recommendations/21860.md)]

### Privileged role activations have monitoring and alerting configured
[!INCLUDE [21818](../includes/secure-recommendations/21818.md)]

### Privileged users sign in with phishing-resistant methods
[!INCLUDE [21781](../includes/secure-recommendations/21781.md)]

### All high-risk users are triaged
[!INCLUDE [21861](../includes/secure-recommendations/21861.md)]

### All high-risk sign-ins are triaged
[!INCLUDE [21863](../includes/secure-recommendations/21863.md)]

### All user sign-in activity uses strong authentication methods
[!INCLUDE [21800](../includes/secure-recommendations/21800.md)]

### High priority Microsoft Entra recommendations are addressed
[!INCLUDE [22124](../includes/secure-recommendations/22124.md)]

### ID Protection notifications enabled
[!INCLUDE [21798](../includes/secure-recommendations/21798.md)]

### No legacy authentication sign-in activity
[!INCLUDE [21795](../includes/secure-recommendations/21795.md)]

### All Microsoft Entra recommendations are addressed
[!INCLUDE [21866](../includes/secure-recommendations/21866.md)]

## Accelerate response and remediation

### Workload identities based on risk policies are configured
[!INCLUDE [21883](../includes/secure-recommendations/21883.md)]

### Restrict high risk sign-ins
[!INCLUDE [21799](../includes/secure-recommendations/21799.md)]

### Restrict access to high risk users
[!INCLUDE [21797](../includes/secure-recommendations/21797.md)]

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)

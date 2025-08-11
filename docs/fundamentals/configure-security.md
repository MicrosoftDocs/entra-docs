---
title: Configure Microsoft Entra for increased security
description: Learn how to improve your security posture with Microsoft Entra.

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 07/14/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: ramical
---
# Configure Microsoft Entra for increased security (Preview)

In Microsoft Entra, we group our security recommendations into several main areas. This structure allows organizations to logically break up projects into related consumable chunks.

> [!TIP]
> Some organizations might take these recommendations exactly as written, while others might choose to make modifications based on their own business needs. In our initial release of this guidance, we focus on traditional [workforce tenants](/entra/external-id/tenant-configurations#workforce-tenants). These workforce tenants are for your employees, internal business apps, and other organizational resources. 

We recommend that all of the following controls be implemented where licenses are available. This helps to provide a foundation for other resources built on top of this solution. More controls will be added to this document over time.

## Protect identities and secrets

- [Applications don't have client secrets configured](#zero-trust-protect-identities.md#applications-dont-have-client-secrets-configured)
- [Applications don't have certificates with expiration longer than 180 days](zero-trust-protect-identities.md#applications-dont-have-certificates-with-expiration-longer-than-180-days)
- [Application Certificates need to be rotated on a regular basis](zero-trust-protect-identities.md#application-certificates-need-to-be-rotated-on-a-regular-basis)
- [Microsoft services applications don't have credentials configured](zero-trust-protect-identities.md#microsoft-services-applications-dont-have-credentials-configured)
- [User consent settings are restricted](zero-trust-protect-identities.md#user-consent-settings-are-restricted)
- [Admin consent workflow is enabled](zero-trust-protect-identities.md#admin-consent-workflow-is-enabled)
- [Privileged accounts are cloud native identities](zero-trust-protect-identities.md#privileged-accounts-are-cloud-native-identities)
- [All privileged role assignments are activated just in time and not permanently active](zero-trust-protect-identities.md#all-privileged-role-assignments-are-activated-just-in-time-and-not-permanently-active)
- [Privileged accounts have phishing-resistant methods registered](zero-trust-protect-identities.md#privileged-accounts-have-phishing-resistant-methods-registered)
- [Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods](zero-trust-protect-identities.md#privileged-microsoft-entra-built-in-roles-are-targeted-with-conditional-access-policies-to-enforce-phishing-resistant-methods)
- [Require password reset notifications for administrator roles](zero-trust-protect-identities.md#require-password-reset-notifications-for-administrator-roles)
- [Block legacy authentication](zero-trust-protect-identities.md#block-legacy-authentication)
- [Migrate from legacy MFA and SSPR policies](zero-trust-protect-identities.md#migrate-from-legacy-mfa-and-sspr-policies)
- [SMS and Voice Call authentication methods are disabled](zero-trust-protect-identities.md#sms-and-voice-call-authentication-methods-are-disabled)
- [Secure the MFA registration (My Security Info) page](zero-trust-protect-identities.md#secure-the-mfa-registration-my-security-info-page)
- [Use cloud authentication](zero-trust-protect-identities.md#use-cloud-authentication)
- [Users have strong authentication methods configured](zero-trust-protect-identities.md#users-have-strong-authentication-methods-configured)
- [User sign-in activity uses token protection](zero-trust-protect-identities.md#user-sign-in-activity-uses-token-protection)
- [Authenticator app shows sign-in context](zero-trust-protect-identities.md#authenticator-app-shows-sign-in-context)
- [Password expiration is disabled](zero-trust-protect-identities.md#password-expiration-is-disabled)
- [Require multifactor authentication for device join and device registration using user action](zero-trust-protect-identities.md#require-multifactor-authentication-for-device-join-and-device-registration-using-user-action)
- [Enable Microsoft Entra ID security defaults](zero-trust-protect-identities.md#enable-microsoft-entra-id-security-defaults)



## Protect tenants and isolate production systems

- [Permissions to create new tenants are limited to the Tenant Creator role](zero-trust-protect-tenants.md#permissions-to-create-new-tenants-are-limited-to-the-tenant-creator-role)
- [Allow/Deny lists of domains to restrict external collaboration are configured](zero-trust-protect-tenants.md#allowdeny-lists-of-domains-to-restrict-external-collaboration-are-configured)
- [Guests are not assigned high privileged directory roles](zero-trust-protect-tenants.md#guests-are-not-assigned-high-privileged-directory-roles)
- [Guests can't invite other guests](zero-trust-protect-tenants.md#guests-cant-invite-other-guests)
- [Guests have restricted access to directory objects](zero-trust-protect-tenants.md#guests-have-restricted-access-to-directory-objects)
- [App instance property lock is configured for all multitenant applications](zero-trust-protect-tenants.md#app-instance-property-lock-is-configured-for-all-multitenant-applications)
- [Guests don't have long lived sign-in sessions](zero-trust-protect-tenants.md#guests-dont-have-long-lived-sign-in-sessions)
- [Guest access is protected by strong authentication methods](zero-trust-protect-tenants.md#guest-access-is-protected-by-strong-authentication-methods)
- [Guest self-service sign-up via user flow is disabled](zero-trust-protect-tenants.md#guest-self-service-sign-up-via-user-flow-is-disabled)
- [Outbound cross-tenant access settings are configured](zero-trust-protect-tenants.md#outbound-cross-tenant-access-settings-are-configured)
- [Guests don't own apps in the tenant](zero-trust-protect-tenants.md#guests-dont-own-apps-in-the-tenant)
- [All guests have a sponsor](zero-trust-protect-tenants.md#all-guests-have-a-sponsor)
- [Inactive guest identities are disabled or removed from the tenant](zero-trust-protect-tenants.md#inactive-guest-identities-are-disabled-or-removed-from-the-tenant)

## Protect networks

- [Named locations are configured](zero-trust-protect-networks.md#named-locations-are-configured)
- [Tenant restrictions v2 policy is configured](zero-trust-protect-networks.md#tenant-restrictions-v2-policy-is-configured)

## Protect engineering systems

- [Global Administrator role activation triggers an approval workflow](../includes/secure-recommendations/21817.md)
- [Global Administrators don't have standing access to Azure subscriptions](../includes/secure-recommendations/21788.md)
- [Creating new applications and service principals is restricted to privileged users](../includes/secure-recommendations/21807.md)
- [Inactive applications don't have highly privileged Microsoft Graph API permissions](../includes/secure-recommendations/21770.md)
- [Inactive applications don't have highly privileged built-in roles](../includes/secure-recommendations/21771.md)
- [App registrations use safe redirect URIs](../includes/secure-recommendations/21885.md)
- [Service principals use safe redirect URIs](../includes/secure-recommendations/23183.md)
- [App registrations must not have dangling or abandoned domain redirect URIs](../includes/secure-recommendations/21888.md)
- [Resource-specific consent to application is restricted](../includes/secure-recommendations/21810.md)
- [Workload Identities are not assigned privileged roles](../includes/secure-recommendations/21836.md)
- [Enterprise applications must require explicit assignment or scoped provisioning](../includes/secure-recommendations/21869.md)
- [Conditional Access policies for Privileged Access Workstations are configured](../includes/secure-recommendations/21830.md)

## Monitor and detect cyberthreats

## Monitor and detect cyberthreats

- [Diagnostic settings are configured for all Microsoft Entra logs](../includes/secure-recommendations/21860.md)
- [Privileged role activations have monitoring and alerting configured](../includes/secure-recommendations/21818.md)
- [Privileged users sign in with phishing-resistant methods](../includes/secure-recommendations/21781.md)
- [All high-risk users are triaged](../includes/secure-recommendations/21861.md)
- [All high-risk sign-ins are triaged](../includes/secure-recommendations/21863.md)
- [All user sign-in activity uses strong authentication methods](../includes/secure-recommendations/21800.md)
- [High priority Microsoft Entra recommendations are addressed](../includes/secure-recommendations/22124.md)
- [ID Protection notifications enabled](../includes/secure-recommendations/21798.md)
- [No legacy authentication sign-in activity](../includes/secure-recommendations/21795.md)
- [All Microsoft Entra recommendations are addressed](../includes/secure-recommendations/21866.md)

## Accelerate response and remediation

- [Workload identities based on risk policies are configured](../includes/secure-recommendations/21883.md)
- [Restrict high risk sign-ins](../includes/secure-recommendations/21799.md)
- [Restrict access to high risk users](../includes/secure-recommendations/21797.md)

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)

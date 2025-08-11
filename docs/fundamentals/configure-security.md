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

- [Applications don't have client secrets configured](zero-trust-protect-identities.md#applications-dont-have-client-secrets-configured)
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

- [Global Administrator role activation triggers an approval workflow](zero-trust-protect-engineering-systems.md#global-administrator-role-activation-triggers-an-approval-workflow)
- [Global Administrators don't have standing access to Azure subscriptions](zero-trust-protect-engineering-systems.md#global-administrators-dont-have-standing-access-to-azure-subscriptions)
- [Creating new applications and service principals is restricted to privileged users](zero-trust-protect-engineering-systems.md#creating-new-applications-and-service-principals-is-restricted-to-privileged-users)
- [Inactive applications don't have highly privileged Microsoft Graph API permissions](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-microsoft-graph-api-permissions)
- [Inactive applications don't have highly privileged built-in roles](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-built-in-roles)
- [App registrations use safe redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-use-safe-redirect-uris)
- [Service principals use safe redirect URIs](zero-trust-protect-engineering-systems.md#service-principals-use-safe-redirect-uris)
- [App registrations must not have dangling or abandoned domain redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-must-not-have-dangling-or-abandoned-domain-redirect-uris)
- [Resource-specific consent to application is restricted](zero-trust-protect-engineering-systems.md#resource-specific-consent-to-application-is-restricted)
- [Workload Identities are not assigned privileged roles](zero-trust-protect-engineering-systems.md#workload-identities-are-not-assigned-privileged-roles)
- [Enterprise applications must require explicit assignment or scoped provisioning](zero-trust-protect-engineering-systems.md#enterprise-applications-must-require-explicit-assignment-or-scoped-provisioning)
- [Conditional Access policies for Privileged Access Workstations are configured](zero-trust-protect-engineering-systems.md#conditional-access-policies-for-privileged-access-workstations-are-configured)

## Monitor and detect cyberthreats

- [Diagnostic settings are configured for all Microsoft Entra logs](zero-trust-monitor-detect.md#diagnostic-settings-are-configured-for-all-microsoft-entra-logs)
- [Privileged role activations have monitoring and alerting configured](zero-trust-monitor-detect.md#privileged-role-activations-have-monitoring-and-alerting-configured)
- [Privileged users sign in with phishing-resistant methods](zero-trust-monitor-detect.md#privileged-users-sign-in-with-phishing-resistant-methods)
- [All high-risk users are triaged](zero-trust-monitor-detect.md#all-high-risk-users-are-triaged)
- [All high-risk sign-ins are triaged](zero-trust-monitor-detect.md#all-high-risk-sign-ins-are-triaged)
- [All user sign-in activity uses strong authentication methods](zero-trust-monitor-detect.md#all-user-sign-in-activity-uses-strong-authentication-methods)
- [High priority Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#high-priority-microsoft-entra-recommendations-are-addressed)
- [ID Protection notifications enabled](zero-trust-monitor-detect.md#id-protection-notifications-enabled)
- [No legacy authentication sign-in activity](zero-trust-monitor-detect.md#no-legacy-authentication-sign-in-activity)
- [All Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#all-microsoft-entra-recommendations-are-addressed)

## Accelerate response and remediation

- [Workload identities based on risk policies are configured](zero-trust-response-remediation.md#workload-identities-based-on-risk-policies-are-configured)
- [Restrict high risk sign-ins](zero-trust-response-remediation.md#restrict-high-risk-sign-ins)
- [Restrict access to high risk users](zero-trust-response-remediation.md#restrict-access-to-high-risk-users)

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)

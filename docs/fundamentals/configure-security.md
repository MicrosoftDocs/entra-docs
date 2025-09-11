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

Reduce credential-related risk by implementing modern identity standards.

| Check | Minimum required license |
|---|---|
| [Applications don't have client secrets configured](zero-trust-protect-identities.md#applications-dont-have-client-secrets-configured) | Microsoft Entra ID P1 |
| [Applications don't have certificates with expiration longer than 180 days](zero-trust-protect-identities.md#applications-dont-have-certificates-with-expiration-longer-than-180-days) | Microsoft Entra ID P1 |
| [Application Certificates need to be rotated on a regular basis](zero-trust-protect-identities.md#application-certificates-need-to-be-rotated-on-a-regular-basis) | Microsoft Entra ID P1 |
| [Microsoft services applications don't have credentials configured](zero-trust-protect-identities.md#microsoft-services-applications-dont-have-credentials-configured) | Microsoft Entra ID P1 |
| [User consent settings are restricted](zero-trust-protect-identities.md#user-consent-settings-are-restricted) | Microsoft Entra ID P1 |
| [Admin consent workflow is enabled](zero-trust-protect-identities.md#admin-consent-workflow-is-enabled) | Microsoft Entra ID P1 |
| [Privileged accounts are cloud native identities](zero-trust-protect-identities.md#privileged-accounts-are-cloud-native-identities) | Microsoft Entra ID P2 |
| [All privileged role assignments are activated just in time and not permanently active](zero-trust-protect-identities.md#all-privileged-role-assignments-are-activated-just-in-time-and-not-permanently-active) | Microsoft Entra ID P2 |
| [Privileged accounts have phishing-resistant methods registered](zero-trust-protect-identities.md#privileged-accounts-have-phishing-resistant-methods-registered) | Microsoft Entra ID P1 |
| [Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods](zero-trust-protect-identities.md#privileged-microsoft-entra-built-in-roles-are-targeted-with-conditional-access-policies-to-enforce-phishing-resistant-methods) | Microsoft Entra ID P1 |
| [Require password reset notifications for administrator roles](zero-trust-protect-identities.md#require-password-reset-notifications-for-administrator-roles) | Microsoft Entra ID P1 |
| [Block legacy authentication](zero-trust-protect-identities.md#block-legacy-authentication) | Microsoft Entra ID P1 |
| [Migrate from legacy MFA and SSPR policies](zero-trust-protect-identities.md#migrate-from-legacy-mfa-and-sspr-policies) | Microsoft Entra ID P1 |
| [SMS and Voice Call authentication methods are disabled](zero-trust-protect-identities.md#sms-and-voice-call-authentication-methods-are-disabled) | Microsoft Entra ID P1 |
| [Secure the MFA registration (My Security Info) page](zero-trust-protect-identities.md#secure-the-mfa-registration-my-security-info-page) | Microsoft Entra ID P1 |
| [Use cloud authentication](zero-trust-protect-identities.md#use-cloud-authentication) | Microsoft Entra ID P1 |
| [Users have strong authentication methods configured](zero-trust-protect-identities.md#users-have-strong-authentication-methods-configured) | Microsoft Entra ID P1 |
| [User sign-in activity uses token protection](zero-trust-protect-identities.md#user-sign-in-activity-uses-token-protection) | Microsoft Entra ID P1 |
| [Authenticator app shows sign-in context](zero-trust-protect-identities.md#authenticator-app-shows-sign-in-context) | Microsoft Entra ID P1 |
| [Password expiration is disabled](zero-trust-protect-identities.md#password-expiration-is-disabled) | Microsoft Entra ID P1 |
| [Require multifactor authentication for device join and device registration using user action](zero-trust-protect-identities.md#require-multifactor-authentication-for-device-join-and-device-registration-using-user-action) | Microsoft Entra ID P1 |
| [Enable Microsoft Entra ID security defaults](zero-trust-protect-identities.md#enable-microsoft-entra-id-security-defaults) | None (included with Microsoft Entra ID) |

## Protect networks

Protect your network perimeter.

| Check | Minimum required license |
|---|---|
| [Named locations are configured](zero-trust-protect-networks.md#named-locations-are-configured) | Microsoft Entra ID P1 |
| [Tenant restrictions v2 policy is configured](zero-trust-protect-networks.md#tenant-restrictions-v2-policy-is-configured) | Microsoft Entra ID P1 |

## Protect engineering systems

Protect software assets and improve code security.

| Check | Minimum required license |
|---|---|
| [Global Administrator role activation triggers an approval workflow](zero-trust-protect-engineering-systems.md#global-administrator-role-activation-triggers-an-approval-workflow) | Microsoft Entra ID P2 |
| [Global Administrators don't have standing access to Azure subscriptions](zero-trust-protect-engineering-systems.md#global-administrators-dont-have-standing-access-to-azure-subscriptions) | Microsoft Entra ID P2 |
| [Creating new applications and service principals is restricted to privileged users](zero-trust-protect-engineering-systems.md#creating-new-applications-and-service-principals-is-restricted-to-privileged-users) | Microsoft Entra ID P1 |
| [Inactive applications don't have highly privileged Microsoft Graph API permissions](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-microsoft-graph-api-permissions) | Microsoft Entra ID P1 |
| [Inactive applications don't have highly privileged built-in roles](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-built-in-roles) | Microsoft Entra ID P1 |
| [App registrations use safe redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-use-safe-redirect-uris) | Microsoft Entra ID P1 |
| [Service principals use safe redirect URIs](zero-trust-protect-engineering-systems.md#service-principals-use-safe-redirect-uris) | Microsoft Entra ID P1 |
| [App registrations must not have dangling or abandoned domain redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-must-not-have-dangling-or-abandoned-domain-redirect-uris) | Microsoft Entra ID P1 |
| [Resource-specific consent to application is restricted](zero-trust-protect-engineering-systems.md#resource-specific-consent-to-application-is-restricted) | Microsoft Entra ID P1 |
| [Workload Identities are not assigned privileged roles](zero-trust-protect-engineering-systems.md#workload-identities-are-not-assigned-privileged-roles) | Microsoft Entra ID P1 |
| [Enterprise applications must require explicit assignment or scoped provisioning](zero-trust-protect-engineering-systems.md#enterprise-applications-must-require-explicit-assignment-or-scoped-provisioning) | Microsoft Entra ID P1 |
| [Conditional Access policies for Privileged Access Workstations are configured](zero-trust-protect-engineering-systems.md#conditional-access-policies-for-privileged-access-workstations-are-configured) | Microsoft Entra ID P1 |

## Monitor and detect cyberthreats

Collect and analyze security logs and triage alerts.

| Check | Minimum required license |
|--- | --- |
| [Diagnostic settings are configured for all Microsoft Entra logs](zero-trust-monitor-detect.md#diagnostic-settings-are-configured-for-all-microsoft-entra-logs) | Microsoft Entra ID P1     |
| [Privileged role activations have monitoring and alerting configured](zero-trust-monitor-detect.md#privileged-role-activations-have-monitoring-and-alerting-configured) | Microsoft Entra ID P2           |
| [Privileged users sign in with phishing-resistant methods](zero-trust-monitor-detect.md#privileged-users-sign-in-with-phishing-resistant-methods) | Microsoft Entra ID P1     |
| [All high-risk users are triaged](zero-trust-monitor-detect.md#all-high-risk-users-are-triaged)     | Microsoft Entra ID P2           |
| [All high-risk sign-ins are triaged](zero-trust-monitor-detect.md#all-high-risk-sign-ins-are-triaged) | Microsoft Entra ID P2           |
| [All user sign-in activity uses strong authentication methods](zero-trust-monitor-detect.md#all-user-sign-in-activity-uses-strong-authentication-methods) | Microsoft Entra ID P1     |
| [High priority Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#high-priority-microsoft-entra-recommendations-are-addressed) | Microsoft Entra ID P1     |
| [ID Protection notifications enabled](zero-trust-monitor-detect.md#id-protection-notifications-enabled) | Microsoft Entra ID P2           |
| [No legacy authentication sign-in activity](zero-trust-monitor-detect.md#no-legacy-authentication-sign-in-activity) | Microsoft Entra ID P1     |
| [All Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#all-microsoft-entra-recommendations-are-addressed) | Microsoft Entra ID P1     |

## Accelerate response and remediation

Improve security incident response and incident communications.

| Check | Minimum required license |
|---|---|
| [Workload identities based on risk policies are configured](zero-trust-response-remediation.md#workload-identities-based-on-risk-policies-are-configured) | Microsoft Entra Workload ID |
| [Restrict high risk sign-ins](zero-trust-response-remediation.md#restrict-high-risk-sign-ins) | Microsoft Entra ID P2 |
| [Restrict access to high risk users](zero-trust-response-remediation.md#restrict-access-to-high-risk-users) | Microsoft Entra ID P2 |

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)

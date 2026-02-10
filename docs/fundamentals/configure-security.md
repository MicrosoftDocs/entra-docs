---
title: Configure Microsoft Entra for increased security
description: Learn how to improve your security posture with Microsoft Entra.

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 02/09/2026

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: ramical
---
# Configure Microsoft Entra for increased security (Preview)

In Microsoft Entra, we group our security recommendations into multiple themes based on the Secure Future Initiative (SFI). This structure allows organizations to logically break up projects into related consumable chunks.

> [!TIP]
> Some organizations might take these recommendations exactly as written, while others might choose to make modifications based on their own business needs. In our initial release of this guidance, we focus on traditional [workforce tenants](/entra/external-id/tenant-configurations#workforce-tenants). These workforce tenants are for your employees, internal business apps, and other organizational resources. 

We recommend that all of the following controls be implemented where licenses are available. These patterns and practices help to provide a foundation for other resources built on top of this solution. More controls will be added to this document over time.

## Automated assessment

Manually checking this guidance against a tenant's configuration can be time-consuming and error-prone. The Zero Trust Assessment transforms this process with automation to test for these security configuration items and more. Learn more in [What is the Zero Trust Assessment?](/security/zero-trust/assessment/overview)

## Protect identities and secrets

Reduce credential-related risk by implementing modern identity standards.

| Check | Minimum required license |
|---|---|
| [Applications don't have client secrets configured](zero-trust-protect-identities.md#applications-dont-have-client-secrets-configured) | None (included with Microsoft Entra ID) |
| [Service principals don't have certificates or credentials associated with them](zero-trust-protect-identities.md#service-principals-dont-have-certificates-or-credentials-associated-with-them) | None (included with Microsoft Entra ID) |
| [Applications don't have certificates with expiration longer than 180 days](zero-trust-protect-identities.md#applications-dont-have-certificates-with-expiration-longer-than-180-days) | None (included with Microsoft Entra ID) |
| [Application certificates must be rotated on a regular basis](zero-trust-protect-identities.md#application-certificates-must-be-rotated-on-a-regular-basis) | None (included with Microsoft Entra ID) |
| [Enforce standards for app secrets and certificates](zero-trust-protect-identities.md#enforce-standards-for-app-secrets-and-certificates) | None (included with Microsoft Entra ID) |
| [Microsoft services applications don't have credentials configured](zero-trust-protect-identities.md#microsoft-services-applications-dont-have-credentials-configured) | None (included with Microsoft Entra ID) |
| [User consent settings are restricted](zero-trust-protect-identities.md#user-consent-settings-are-restricted) | None (included with Microsoft Entra ID) |
| [Admin consent workflow is enabled](zero-trust-protect-identities.md#admin-consent-workflow-is-enabled) | None (included with Microsoft Entra ID) |
| [High Global Administrator to privileged user ratio](zero-trust-protect-identities.md#high-global-administrator-to-privileged-user-ratio) | None (included with Microsoft Entra ID) |
| [Privileged accounts are cloud native identities](zero-trust-protect-identities.md#privileged-accounts-are-cloud-native-identities) | None (included with Microsoft Entra ID) |
| [All privileged role assignments are activated just in time and not permanently active](zero-trust-protect-identities.md#all-privileged-role-assignments-are-activated-just-in-time-and-not-permanently-active) | Microsoft Entra ID P2 |
| [All Microsoft Entra privileged role assignments are managed with PIM](zero-trust-protect-identities.md#all-microsoft-entra-privileged-role-assignments-are-managed-with-pim) | Microsoft Entra ID P2 |
| [Passkey authentication method enabled](zero-trust-protect-identities.md#passkey-authentication-method-enabled) | None (included with Microsoft Entra ID) |
| [Security key attestation is enforced](zero-trust-protect-identities.md#security-key-attestation-is-enforced) | None (included with Microsoft Entra ID) |
| [Privileged accounts have phishing-resistant methods registered](zero-trust-protect-identities.md#privileged-accounts-have-phishing-resistant-methods-registered) | Microsoft Entra ID P1 |
| [Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods](zero-trust-protect-identities.md#privileged-microsoft-entra-built-in-roles-are-targeted-with-conditional-access-policies-to-enforce-phishing-resistant-methods) | Microsoft Entra ID P1 |
| [Require password reset notifications for administrator roles](zero-trust-protect-identities.md#require-password-reset-notifications-for-administrator-roles) | Microsoft Entra ID P1 |
| [Block legacy authentication policy is configured](zero-trust-protect-identities.md#block-legacy-authentication-policy-is-configured) | Microsoft Entra ID P1 |
| [Temporary access pass is enabled](zero-trust-protect-identities.md#temporary-access-pass-is-enabled) | Microsoft Entra ID P1 |
| [Restrict Temporary Access Pass to Single Use](zero-trust-protect-identities.md#restrict-temporary-access-pass-to-single-use) | Microsoft Entra ID P1 |
| [Migrate from legacy MFA and SSPR policies](zero-trust-protect-identities.md#migrate-from-legacy-mfa-and-sspr-policies) | Microsoft Entra ID P1 |
| [Block administrators from using SSPR](zero-trust-protect-identities.md#block-administrators-from-using-sspr) | Microsoft Entra ID P1 |
| [Self-service password reset doesn't use security questions](zero-trust-protect-identities.md#self-service-password-reset-doesnt-use-security-questions) | Microsoft Entra ID P1 |
| [SMS and Voice Call authentication methods are disabled](zero-trust-protect-identities.md#sms-and-voice-call-authentication-methods-are-disabled) | Microsoft Entra ID P1 |
| [Secure the MFA registration (My Security Info) page](zero-trust-protect-identities.md#secure-the-mfa-registration-my-security-info-page) | Microsoft Entra ID P1 |
| [Use cloud authentication](zero-trust-protect-identities.md#use-cloud-authentication) | Microsoft Entra ID P1 |
| [All users are required to register for MFA](zero-trust-protect-identities.md#all-users-are-required-to-register-for-mfa) | Microsoft Entra ID P2 |
| [Users have strong authentication methods configured](zero-trust-protect-identities.md#users-have-strong-authentication-methods-configured) | Microsoft Entra ID P1 |
| [User sign-in activity uses token protection](zero-trust-protect-identities.md#user-sign-in-activity-uses-token-protection) | Microsoft Entra ID P1 |
| [All user sign-in activity uses phishing-resistant authentication methods](zero-trust-protect-identities.md#all-user-sign-in-activity-uses-phishing-resistant-authentication-methods) | Microsoft Entra ID P1 |
| [All sign-in activity comes from managed devices](zero-trust-protect-identities.md#all-sign-in-activity-comes-from-managed-devices) | Microsoft Entra ID P1 |
| [Security key authentication method enabled](zero-trust-protect-identities.md#security-key-authentication-method-enabled) | None (included with Microsoft Entra ID) |
| [Privileged roles aren't assigned to stale identities](zero-trust-protect-identities.md#privileged-roles-arent-assigned-to-stale-identities) | Microsoft Entra ID P2 |
| [Microsoft Authenticator app shows sign-in context](zero-trust-protect-identities.md#microsoft-authenticator-app-shows-sign-in-context) | Microsoft Entra ID P1 |
| [Microsoft Authenticator app report suspicious activity setting is enabled](zero-trust-protect-identities.md#microsoft-authenticator-app-report-suspicious-activity-setting-is-enabled) | Microsoft Entra ID P1 |
| [Password expiration is disabled](zero-trust-protect-identities.md#password-expiration-is-disabled) | Microsoft Entra ID P1 |
| [Smart lockout threshold set to 10 or less](zero-trust-protect-identities.md#smart-lockout-threshold-set-to-10-or-less) | Microsoft Entra ID P1 |
| [Smart lockout duration is set to a minimum of 60](zero-trust-protect-identities.md#smart-lockout-duration-is-set-to-a-minimum-of-60) | Microsoft Entra ID P1 |
| [Add organizational terms to the banned password list](zero-trust-protect-identities.md#add-organizational-terms-to-the-banned-password-list) | Microsoft Entra ID P1 |
| [Require multifactor authentication for device join and device registration using user action](zero-trust-protect-identities.md#require-multifactor-authentication-for-device-join-and-device-registration-using-user-action) | Microsoft Entra ID P1 |
| [Local Admin Password Solution is deployed](zero-trust-protect-identities.md#local-admin-password-solution-is-deployed) | Microsoft Entra ID P1 |
| [Entra Connect Sync is configured with Service Principal Credentials](zero-trust-protect-identities.md#entra-connect-sync-is-configured-with-service-principal-credentials) | None (included with Microsoft Entra ID) |
| [No usage of ADAL in the tenant](zero-trust-protect-identities.md#no-usage-of-adal-in-the-tenant) | None (included with Microsoft Entra ID) |
| [Block legacy Azure AD PowerShell module](zero-trust-protect-identities.md#block-legacy-azure-ad-powershell-module) | None (included with Microsoft Entra ID) |
| [Enable Microsoft Entra ID security defaults for free tenants](zero-trust-protect-identities.md#enable-microsoft-entra-id-security-defaults-for-free-tenants) | None (included with Microsoft Entra ID) |

## Protect tenants and isolate production systems

| Check | Minimum required license |
|---|---|
| [Permissions to create new tenants are limited to the Tenant Creator role](zero-trust-protect-tenants.md#permissions-to-create-new-tenants-are-limited-to-the-tenant-creator-role) | None (included with Microsoft Entra ID) |
| [Enable protected actions to secure Conditional Access policy creation and changes](zero-trust-protect-tenants.md#enable-protected-actions-to-secure-conditional-access-policy-creation-and-changes) | Microsoft Entra ID P1 |
| [Guest access is limited to approved tenants](zero-trust-protect-tenants.md#guest-access-is-limited-to-approved-tenants) | Microsoft Entra ID Free |
| [Guests are not assigned high privileged directory roles](zero-trust-protect-tenants.md#guests-are-not-assigned-high-privileged-directory-roles) | Microsoft Entra ID Free<br>Microsoft Entra ID P2 or Microsoft ID Governance for PIM |
| [Guests can't invite other guests](zero-trust-protect-tenants.md#guests-cant-invite-other-guests) | Microsoft Entra ID Free |
| [Guests have restricted access to directory objects](zero-trust-protect-tenants.md#guests-have-restricted-access-to-directory-objects) | Microsoft Entra ID Free |
| [App instance property lock is configured for all multitenant applications](zero-trust-protect-tenants.md#app-instance-property-lock-is-configured-for-all-multitenant-applications) | Microsoft Entra ID Free |
| [Guests don't have long lived sign-in sessions](zero-trust-protect-tenants.md#guests-dont-have-long-lived-sign-in-sessions) | Microsoft Entra ID P1 |
| [Guest access is protected by strong authentication methods](zero-trust-protect-tenants.md#guest-access-is-protected-by-strong-authentication-methods) | Microsoft Entra ID Free<br>Microsoft Entra ID P1 recommended for Conditional Access |
| [Guest self-service sign-up via user flow is disabled](zero-trust-protect-tenants.md#guest-self-service-sign-up-via-user-flow-is-disabled) | Microsoft Entra ID Free |
| [Outbound cross-tenant access settings are configured](zero-trust-protect-tenants.md#outbound-cross-tenant-access-settings-are-configured) | Microsoft Entra ID Free<br>Microsoft Entra ID P1 recommended for Conditional Access |
| [Guests don't own apps in the tenant](zero-trust-protect-tenants.md#guests-dont-own-apps-in-the-tenant) |  None (included with Microsoft Entra ID) |
| [All guests have a sponsor](zero-trust-protect-tenants.md#all-guests-have-a-sponsor) | Microsoft Entra ID Free |
| [Inactive guest identities are disabled or removed from the tenant](zero-trust-protect-tenants.md#inactive-guest-identities-are-disabled-or-removed-from-the-tenant) | Microsoft Entra ID Free |
| [All entitlement management policies have an expiration date](zero-trust-protect-tenants.md#all-entitlement-management-policies-have-an-expiration-date) | Microsoft Entra ID P2 or Microsoft ID Governance for entitlement managed and access reviews |
| [All entitlement management assignment policies that apply to external users require connected organizations](zero-trust-protect-tenants.md#all-entitlement-management-assignment-policies-that-apply-to-external-users-require-connected-organizations) | Microsoft Entra ID P2 or Microsoft ID Governance for entitlement managed and access reviews |
| [All entitlement management assignment policies that apply to external users require approval](zero-trust-protect-tenants.md#all-entitlement-management-assignment-policies-that-apply-to-external-users-require-approval) | Microsoft Entra ID P2 or Microsoft ID Governance for entitlement managed and access reviews |
| [All entitlement management packages that apply to guests have expirations or access reviews configured in their assignment policies](zero-trust-protect-tenants.md#all-entitlement-management-packages-that-apply-to-guests-have-expirations-or-access-reviews-configured-in-their-assignment-policies) | Microsoft Entra ID P2 or Microsoft ID Governance for entitlement managed and access reviews |
| [Manage the local administrators on Microsoft Entra joined devices](zero-trust-protect-tenants.md#manage-the-local-administrators-on-microsoft-entra-joined-devices) | None (included with Microsoft Entra ID) |
| [Restrict nonadministrator users from recovering the BitLocker keys for their owned devices](zero-trust-protect-tenants.md#restrict-nonadministrator-users-from-recovering-the-bitlocker-keys-for-their-owned-devices) | None (included with Microsoft Entra ID) |

## Protect networks

Protect your network perimeter.

| Check | Minimum required license |
|---|---|
| [Named locations are configured](zero-trust-protect-networks.md#named-locations-are-configured) | Microsoft Entra ID P1 |
| [Tenant restrictions v2 policy is configured](zero-trust-protect-networks.md#tenant-restrictions-v2-policy-is-configured) | Microsoft Entra ID P1 |
| [Internet Access forwarding profile is enabled](zero-trust-protect-networks.md#internet-access-forwarding-profile-is-enabled) | <!--Entra_Premium_Internet_Access--> Microsoft Entra Internet Access |
| [Global Secure Access web content filtering is enabled and configured](zero-trust-protect-networks.md#global-secure-access-web-content-filtering-is-enabled-and-configured) | <!--Entra_Premium_Internet_Access--> Microsoft Entra Internet Access |
| [Network validation is configured through Universal Continuous Access Evaluation](zero-trust-protect-networks.md#network-validation-is-configured-through-universal-continuous-access-evaluation) | Microsoft Entra ID P1 or Microsoft Entra Suite Add-on for Microsoft Entra ID P2 |
| [Global Secure Access client is deployed on all managed endpoints](zero-trust-protect-networks.md#global-secure-access-client-is-deployed-on-all-managed-endpoints) | Microsoft Entra ID P1 or Microsoft Entra Suite Add-on for Microsoft Entra ID P2 |
| [Global Secure Access licenses are available in the tenant and assigned to users](zero-trust-protect-networks.md#global-secure-access-licenses-are-available-in-the-tenant-and-assigned-to-users) | Microsoft Entra Suite Add-on for Microsoft Entra ID P2 |

## Protect engineering systems

Protect software assets and improve code security.

| Check | Minimum required license |
|---|---|
| [Emergency access accounts are configured appropriately](zero-trust-protect-engineering-systems.md#emergency-access-accounts-are-configured-appropriately) | Microsoft Entra ID P1 |
| [Global Administrator role activation triggers an approval workflow](zero-trust-protect-engineering-systems.md#global-administrator-role-activation-triggers-an-approval-workflow) | Microsoft Entra ID P2 |
| [Global Administrators don't have standing access to Azure subscriptions](zero-trust-protect-engineering-systems.md#global-administrators-dont-have-standing-access-to-azure-subscriptions) | None (included with Microsoft Entra ID) |
| [Creating new applications and service principals is restricted to privileged users](zero-trust-protect-engineering-systems.md#creating-new-applications-and-service-principals-is-restricted-to-privileged-users) | Microsoft Entra ID P1 |
| [Inactive applications don't have highly privileged Microsoft Graph API permissions](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-microsoft-graph-api-permissions) | Microsoft Entra ID P1 |
| [Inactive applications don't have highly privileged built-in roles](zero-trust-protect-engineering-systems.md#inactive-applications-dont-have-highly-privileged-built-in-roles) | Microsoft Entra ID P1 |
| [App registrations use safe redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-use-safe-redirect-uris) | Microsoft Entra ID P1 |
| [Service principals use safe redirect URIs](zero-trust-protect-engineering-systems.md#service-principals-use-safe-redirect-uris) | Microsoft Entra ID P1 |
| [App registrations must not have dangling or abandoned domain redirect URIs](zero-trust-protect-engineering-systems.md#app-registrations-must-not-have-dangling-or-abandoned-domain-redirect-uris) | Microsoft Entra ID P1 |
| [Resource-specific consent is restricted](zero-trust-protect-engineering-systems.md#resource-specific-consent-is-restricted) | Microsoft Entra ID P1 |
| [Workload Identities are not assigned privileged roles](zero-trust-protect-engineering-systems.md#workload-identities-are-not-assigned-privileged-roles) | Microsoft Entra ID P1 |
| [Enterprise applications must require explicit assignment or scoped provisioning](zero-trust-protect-engineering-systems.md#enterprise-applications-must-require-explicit-assignment-or-scoped-provisioning) | Microsoft Entra ID P1 |
| [Enterprise applications have owners](zero-trust-protect-engineering-systems.md#enterprise-applications-have-owners) | None (included with Microsoft Entra ID) |
| [Limit the maximum number of devices per user to 10](zero-trust-protect-engineering-systems.md#limit-the-maximum-number-of-devices-per-user-to-10) | None (included with Microsoft Entra ID) |
| [Conditional Access policies for Privileged Access Workstations are configured](zero-trust-protect-engineering-systems.md#conditional-access-policies-for-privileged-access-workstations-are-configured) | Microsoft Entra ID P1 |

## Monitor and detect cyberthreats

Collect and analyze security logs and triage alerts.

| Check | Minimum required license |
|--- | --- |
| [Diagnostic settings are configured for all Microsoft Entra logs](zero-trust-monitor-detect.md#diagnostic-settings-are-configured-for-all-microsoft-entra-logs) | Microsoft Entra ID P1 |
| [Privileged role activations have monitoring and alerting configured](zero-trust-monitor-detect.md#privileged-role-activations-have-monitoring-and-alerting-configured) | Microsoft Entra ID P2 |
| [Activation alert for Global Administrator role assignments](zero-trust-monitor-detect.md#activation-alert-for-global-administrator-role-assignments) | Microsoft Entra ID P2 |
| [Activation alert for all privileged role assignments](zero-trust-monitor-detect.md#activation-alert-for-all-privileged-role-assignments) | Microsoft Entra ID P2 |
| [Privileged users sign in with phishing-resistant methods](zero-trust-monitor-detect.md#privileged-users-sign-in-with-phishing-resistant-methods) | Microsoft Entra ID P1 |
| [All high-risk users are triaged](zero-trust-monitor-detect.md#all-high-risk-users-are-triaged) | Microsoft Entra ID P2 |
| [All high-risk sign-ins are triaged](zero-trust-monitor-detect.md#all-high-risk-sign-ins-are-triaged) | Microsoft Entra ID P2  |
| [All risky workload identities are triaged]
| [Tenant creation events are triaged](zero-trust-monitor-detect.md#tenant-creation-events-are-triaged) | Microsoft Entra ID P1 |
| [All user sign-in activity uses strong authentication methods](zero-trust-monitor-detect.md#all-user-sign-in-activity-uses-strong-authentication-methods) | Microsoft Entra ID P1 |
| [High priority Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#high-priority-microsoft-entra-recommendations-are-addressed) | Microsoft Entra ID P1 |
| [ID Protection notifications are enabled](zero-trust-monitor-detect.md#id-protection-notifications-are-enabled) | Microsoft Entra ID P2 |
| [No legacy authentication sign-in activity](zero-trust-monitor-detect.md#no-legacy-authentication-sign-in-activity) | Microsoft Entra ID P1 |
| [All Microsoft Entra recommendations are addressed](zero-trust-monitor-detect.md#all-microsoft-entra-recommendations-are-addressed) | Microsoft Entra ID P1 |

## Accelerate response and remediation

Improve security incident response and incident communications.

| Check | Minimum required license |
|---|---|
| [Workload Identities are configured with risk-based policies](zero-trust-response-remediation.md#workload-identities-are-configured-with-risk-based-policies) | Microsoft Entra Workload ID |
| [Restrict high risk sign-ins](zero-trust-response-remediation.md#restrict-high-risk-sign-ins) | Microsoft Entra ID P2 |
| [Restrict access to high risk users](zero-trust-response-remediation.md#restrict-access-to-high-risk-users) | Microsoft Entra ID P2 |

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)

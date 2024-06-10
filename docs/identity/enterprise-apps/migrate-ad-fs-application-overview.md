---
title: Overview of AD FS application migration
description: Learn about the capabilities of the AD FS application migration wizard and the migration status available on its dashboard. Learn the various validation tests that the  application migration generates and how to resolve the validation issues.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article

ms.date: 06/10/2024
ms.author: jomondi
ms.reviewer: smriti3
ms.custom: not-enterprise-apps

#customer intent: As an IT admin responsible for migrating applications from AD FS to Microsoft Entra ID, I want to use the AD FS application migration wizard to assess the compatibility of my applications, prioritize them for migration, run migration tests, and receive guidance on configuring new Microsoft Entra applications, so that I can efficiently migrate my applications to the new platform.
---

# Overview of AD FS application migration

In this article, you learn about the capabilities of the AD FS application migration wizard and the migration status available on its dashboard. You also learn the various validation tests that the application migration generates for each of the applications that you want to migrate from AD FS to Microsoft Entra ID.

The AD FS application migration wizard lets you quickly identify which of your applications are capable of being migrated to Microsoft Entra ID. It assesses all AD FS applications for compatibility with Microsoft Entra ID. It also checks for any issues, gives guidance on preparing individual applications for migration, and configuring new Microsoft Entra application using one-click experience.

With the AD FS application migration wizard, you can:

- **Discover AD FS applications and scope your migration** - The AD FS application migration wizard lists all AD FS applications in your organization that have had an active user sign-in in the last 30 days. The report indicates an apps readiness for migration to Microsoft Entra ID. The report doesn't display Microsoft related relying parties in AD FS such as Office 365. For example, relying parties with name `urn:federation:MicrosoftOnline`.

- **Prioritize applications for migration** - Get the number of unique users signed in to the application in the past 1, 7, or 30 days to help determine the criticality or risk of migrating the application.

- **Run migration tests and fix issues** - The reporting service automatically runs tests to determine if an application is ready to migrate. The results are displayed in the AD FS application migration dashboard as a migration status. If the AD FS configuration isn't compatible with a Microsoft Entra configuration, you get specific guidance on how to address the configuration in Microsoft Entra ID.

- **Use one-click application configuration experience to configure new Microsoft Entra application** -  This provides a guided experience to migrate on-premises relying party applications to cloud. The migration experience uses the relying party application's metadata that is directly imported from your on-premises environment. Also the experience provides a one-click configuration of SAML application on Microsoft Entra platform with some basic SAML settings, claims configurations, and groups assignments.

> [!NOTE]
> AD FS application migration only supports SAML-based applications. It doesn't support applications that use protocols such as OpenID Connect, WS-Fed and OAuth 2.0. If you want to migrate applications that use these protocols, see [Use the AD FS application activity report](migrate-adfs-application-activity.md) to identify the applications that you want to migrate. Once you've identified the apps you want to migrate, you can configure them manually in Microsoft Entra ID. For more information on how to get started on manual migration, see [Migrate and test your application](migrate-adfs-plan-migration-test.md).

## AD FS application migration status

The Microsoft Entra Connect and Microsoft Entra Connect Health agents for AD FS reads your on-premises relying party application configurations and sign-in audit logs. This data about each AD FS application is analyzed to determine if it can be migrated as-is, or if additional review is needed. Based on the result of this analysis, migration status for the given application is determined.

Applications are categorized into following migration statuses:

- **Ready to migrate** means the AD FS application configuration is fully supported in Microsoft Entra ID and can be migrated as-is.
- **Needs review** means some of the application's settings can be migrated to Microsoft Entra ID, but you need to review the settings that can't be migrated as-is.
- **Additional steps required** means Microsoft Entra ID doesn't support some of the application's settings, so the application can't be migrated in its current state.

## AD FS application migration validation tests

Application readiness is evaluated based on following predefined AD FS application configuration tests. The tests are run automatically and the results are displayed in the AD FS application migration dashboard as a **Migration status**. If the AD FS configuration isn't compatible with a Microsoft Entra configuration, you get specific guidance on how to address the configuration in Microsoft Entra ID.

## AD FS application migration insights status updates

When the application is updated, internal agents sync the updates within a few minutes. However, AD FS migration insights jobs are responsible for evaluating the updates and compute a new migration status. Those jobs are scheduled to run every 24 hours, which means that the data will be computed only once in a day, at around 00:00 Coordinated Universal Time (UTC).

|Result  |Pass/Warning/Fail  |Description  |
|---------|---------|---------|
|Test-ADFSRPAdditionalAuthenticationRules <br> At least one nonmigratable rule was detected for AdditionalAuthentication.       | Pass/Warning          | The relying party has rules to prompt for multifactor authentication. To move to Microsoft Entra ID, translate those rules into Conditional Access policies. If you're using an on-premises MFA, we recommend that you move to Microsoft Entra multifactor authentication. [Learn more about Conditional Access](~/identity/authentication/concept-mfa-howitworks.md).        |
|Test-ADFSRPAdditionalWSFedEndpoint <br> Relying party has AdditionalWSFedEndpoint set to true.       | Pass/Fail          | The relying party in AD FS allows multiple WS-Fed assertion endpoints. Currently, Microsoft Entra-only supports one. If you have a scenario where this result is blocking migration, [let us know](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).     |
|Test-ADFSRPAllowedAuthenticationClassReferences <br> Relying Party has set AllowedAuthenticationClassReferences.       | Pass/Fail          | This setting in AD FS lets you specify whether the application is configured to only allow certain authentication types. We recommend using Conditional Access to achieve this capability.  If you have a scenario where this result is blocking migration, [let us know](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).  [Learn more about Conditional Access](~/identity/authentication/concept-mfa-howitworks.md).         |
|Test-ADFSRPAlwaysRequireAuthentication <br> AlwaysRequireAuthenticationCheckResult      | Pass/Fail          | This setting in AD FS lets you specify whether the application is configured to ignore SSO cookies and **Always Prompt for Authentication**. In Microsoft Entra ID, you can manage the authentication session using Conditional Access policies to achieve similar behavior. [Learn more about configuring authentication session management with Conditional Access](~/identity/conditional-access/howto-conditional-access-session-lifetime.md).          |
|Test-ADFSRPAutoUpdateEnabled <br> Relying Party has AutoUpdateEnabled set to true       | Pass/Warning          | This setting in AD FS lets you specify whether AD FS is configured to automatically update the application based on changes within the federation metadata. Microsoft Entra ID doesn't support this today but shouldn't block the migration of the application to Microsoft Entra ID.           |
|Test-ADFSRPClaimsProviderName <br> Relying Party has multiple ClaimsProviders enabled       | Pass/Fail          | This setting in AD FS calls out the identity providers from which the relying party is accepting claims. In Microsoft Entra ID, you can enable external collaboration using Microsoft Entra B2B. [Learn more about Microsoft Entra B2B](~/external-id/what-is-b2b.md).          |
|Test-ADFSRPDelegationAuthorizationRules      | Pass/Fail          | The application has custom delegation authorization rules defined. This is a WS-Trust concept that  Microsoft Entra ID supports by using modern authentication protocols, such as OpenID Connect and OAuth 2.0. [Learn more about the Microsoft identity platform](~/identity-platform/v2-protocols-oidc.md).          |
|Test-ADFSRPImpersonationAuthorizationRules       | Pass/Warning          | The application has custom impersonation authorization rules defined. This is a WS-Trust concept that Microsoft Entra ID supports by using modern authentication protocols, such as OpenID Connect and OAuth 2.0. [Learn more about the Microsoft identity platform](~/identity-platform/v2-protocols-oidc.md).          |
|Test-ADFSRPIssuanceAuthorizationRules <br> At least one nonmigratable rule was detected for IssuanceAuthorization.       | Pass/Warning          | The application has custom issuance authorization rules defined in AD FS. Microsoft Entra ID supports this functionality with Microsoft Entra Conditional Access. [Learn more about Conditional Access](~/identity/conditional-access/overview.md). <br> You can also restrict access to an application by user or groups assigned to the application. [Learn more about assigning users and groups to access applications](./assign-user-or-group-access-portal.md).            |
|Test-ADFSRPIssuanceTransformRules <br> At least one nonmigratable rule was detected for IssuanceTransform.       | Pass/Warning          | The application has custom issuance transform rules defined in AD FS. Microsoft Entra ID supports customizing the claims issued in the token. To learn more, see [Customize claims issued in the SAML token for enterprise applications](~/identity-platform/saml-claims-customization.md).           |
|Test-ADFSRPMonitoringEnabled <br> Relying Party has MonitoringEnabled set to true.       | Pass/Warning          | This setting in AD FS lets you specify whether AD FS is configured to automatically update the application based on changes within the federation metadata. Microsoft Entra doesn’t support this today but shouldn't block the migration of the application to Microsoft Entra ID.           |
|Test-ADFSRPNotBeforeSkew <br> NotBeforeSkewCheckResult      | Pass/Warning          | AD FS allows a time skew based on the NotBefore and NotOnOrAfter times in the SAML token. Microsoft Entra ID automatically handles this by default.          |
|Test-ADFSRPRequestMFAFromClaimsProviders <br> Relying Party has RequestMFAFromClaimsProviders set to true.       | Pass/Warning          | This setting in AD FS determines the behavior for MFA when the user comes from a different claims provider. In Microsoft Entra ID, you can enable external collaboration using Microsoft Entra B2B. Then, you can apply Conditional Access policies to protect guest access. Learn more about [Microsoft Entra B2B](~/external-id/what-is-b2b.md) and [Conditional Access](~/identity/conditional-access/overview.md).          |
|Test-ADFSRPSignedSamlRequestsRequired <br> Relying Party has SignedSamlRequestsRequired set to true       | Pass/Fail          | The application is configured in AD FS to verify the signature in the SAML request. Microsoft Entra ID accepts a signed SAML request; however, it will not verify the signature. Microsoft Entra ID has different methods to protect against malicious calls. For example, Microsoft Entra ID uses the reply URLs configured in the application to validate the SAML request. Microsoft Entra ID will only send a token to reply URLs configured for the application. If you have a scenario where this result is blocking migration, [let us know](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789).          |
|Test-ADFSRPTokenLifetime <br> TokenLifetimeCheckResult        | Pass/Warning         | The application is configured for a custom token lifetime. The AD FS default is one hour. Microsoft Entra ID supports this functionality using Conditional Access. To learn more, see [Configure authentication session management with Conditional Access](~/identity/conditional-access/howto-conditional-access-session-lifetime.md).          |
|Relying Party is set to encrypt claims. This is supported by Microsoft Entra ID       | Pass          | With Microsoft Entra ID, you can encrypt the token sent to the application. To learn more, see [Configure Microsoft Entra SAML token encryption](./howto-saml-token-encryption.md).          |
|EncryptedNameIdRequiredCheckResult      | Pass/Fail          | The application is configured to encrypt the nameID claim in the SAML token. With Microsoft Entra ID, you can encrypt the entire token sent to the application. Encryption of specific claims isn't yet supported. To learn more, see [Configure Microsoft Entra SAML token encryption](./howto-saml-token-encryption.md).         |

## Next steps

- [Use AD FS application migration wizard to migrate apps from AD FS to Microsoft Entra ID](migrate-ad-fs-application-howto.md)

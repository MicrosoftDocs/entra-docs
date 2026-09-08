---
title: SAM Account Name
description: SAM Account Name support for Entra Domain Services
author:      BenMannMicrosoft2 # GitHub alias
ms.author:   benmann # Microsoft alias
ms.service: entra
ms.topic: concept-article
ms.date:     08/18/2026
ms.subservice: fundamentals
---

# Public preview of enhanced security account manager support

Enhanced support for synchronizing the security account manager account name (sAMAccountName) with Microsoft Entra Domain Services is now in public preview.

This feature allows sAMAccountName to be populated from the onPremisesSamAccountName attribute in Microsoft Entra ID. Existing managed domains can enable the new synchronization behavior. The feature needs to be enabled. 

When enabled, existing hybrid users are updated during synchronization; cloud-only users without an onPremisesSamAccountName value continue to use mailNickname-based generation.

## When is sAMAccountName sync needed?

The security account manager account name (sAMAccountName) attribute stores a user’s legacy logon name in Active Directory Domain Services and is now supported through enhanced synchronization in public preview for Microsoft Entra Domain Services. Applications that use legacy authentication commonly expect this value to be unique, no longer than 20 characters, and free of unsupported special characters. 

Enhanced sAMAccountName synchronization allows organizations with hybrid identities to populate sAMAccountName from onPremisesSamAccountName in Microsoft Entra ID. This helps preserve account-name consistency with on-premises Active Directory and improves compatibility with applications and scripts that depend on existing sAMAccountName values. 

### Prerequisites 

- A Microsoft Entra Domain Services managed domain. 
- An Enterprise or Premium SKU. The feature is not available with the Standard SKU. 
- Users synchronized from on-premises Active Directory must have onPremisesSamAccountName populated in Microsoft Entra ID. 
- To change the setting, the administrator must have both the Application Administrator and Groups Administrator roles. 

### How sAMAccountName synchronization works 

#### Existing managed domains 

Existing managed domains continue to use the current behavior until an administrator enables sAMAccountName synchronization from on-premises. 

- **Setting disabled**: Microsoft Entra Domain Services generates sAMAccountName from mailNickname or the user principal name prefix. Truncation and de-duplication are applied when needed to meet legacy constraints. 

- **Setting enabled**: Microsoft Entra Domain Services sources sAMAccountName from onPremisesSamAccountName in Microsoft Entra ID for hybrid users. Existing hybrid users are updated during synchronization. 

Cloud-only users without an onPremisesSamAccountName value continue to use mailNickname-based sAMAccountName generation. 

#### New managed domains 

For new managed domain deployments, enhanced synchronization is enabled by default. The sAMAccountName value for hybrid users is sourced from onPremisesSamAccountName in Microsoft Entra ID. For new domain deployments, samaccountName will need to be enabled, by default it is disabled.

### When to use enhanced synchronization 

Consider enabling enhanced synchronization when your organization: 

- Uses hybrid identities and requires the same sAMAccountName values across on-premises Active Directory and Microsoft Entra Domain Services. 
- Runs applications, scripts, or authentication workflows that depend on specific sAMAccountName values. 
- Is migrating domain-dependent workloads to Azure and wants to preserve existing identity formats. 
- Experiences authentication or application errors caused by generated, truncated, duplicated, or mismatched account names. 

### Benefits 

- **Improved application compatibility:** Applications can continue using established sAMAccountName values without identity-related code changes. 
- **Reduced identity drift:** Account names remain consistent across on-premises and managed-domain environments. 
- **Simplified migrations:** Existing identity formats can be preserved as workloads move to Azure. 
- **Fewer authentication issues:** Administrators can avoid mismatches caused by generating sAMAccountName from mailNickname or the user principal name prefix. 

### Before you enable the setting 

Enabling the setting changes the sAMAccountName source for existing hybrid users.

Before enabling it: 
- Confirm that onPremisesSamAccountName is populated correctly in Microsoft Entra ID.
- Review applications, scripts, scheduled tasks, and access-control configurations that use sAMAccountName.
- Identify integrations that might depend on the currently generated sAMAccountName value. 
- Plan to validate authentication and application access after synchronization completes. 

Enable sAMAccountName synchronization from on-premises 

1. Sign in to the Microsoft Entra admin center with an account assigned to both the Application Administrator and Groups Administrator roles. 
1. Search for and select Microsoft Entra Domain Services. 
1. Select your managed domain. 
1. In the left navigation, select Security settings. 
1. For sAMAccountName synchronization from on-premises, select Enable. 
1. Save the change. 

After the setting is enabled, Microsoft Entra Domain Services synchronizes sAMAccountName from onPremisesSamAccountName for existing hybrid users. Cloud-only users without that source attribute continue to use the existing generated behavior. 

### Validate the configuration 

1. Select representative hybrid users whose onPremisesSamAccountName values are known. 
1. Confirm that their sAMAccountName values in Microsoft Entra Domain Services match the source values in Microsoft Entra ID. 
1. Test authentication for applications and scripts that depend on sAMAccountName. 

If a user doesn’t receive the expected value, confirm that onPremisesSamAccountName is populated in Microsoft Entra ID and verify that the enhanced synchronization setting is enabled. Enhanced support for synchronizing the Security Account Manager account name (sAMAccountName) with Microsoft Entra Domain Services is now in Public Preview.

This feature allows sAMAccountName to be populated from the onPremisesSamAccountName attribute in Microsoft Entra ID. Existing managed domains can enable the new synchronization behavior, while it is enabled by default for new managed domains.

When enabled, existing hybrid users are updated during synchronization; cloud-only users without an onPremisesSamAccountName value continue to use mailNickname-based generation.

## Security accounts manager account name

The security accounts manager account name (sAMAccountName) attribute stores a user’s legacy logon name in Active Directory Domain Services and is now supported through enhanced synchronization in Public Preview for Microsoft Entra Domain Services. Applications that use legacy authentication commonly expect this value to be unique, no longer than 20 characters, and free of unsupported special characters. 

Enhanced sAMAccountName synchronization allows organizations with hybrid identities to populate sAMAccountName from onPremisesSamAccountName in Microsoft Entra ID. This helps preserve account-name consistency with on-premises Active Directory and improves compatibility with applications and scripts that depend on existing sAMAccountName values. 

### Prerequisites
- A Microsoft Entra Domain Services managed domain. 
- An Enterprise or Premium SKU. The feature isn’t available with the Standard SKU. 
- Users synchronized from on-premises Active Directory must have onPremisesSamAccountName populated in Microsoft Entra ID. 
- To change the setting, the administrator must have both the Application Administrator and Groups Administrator roles. 

### How sAMAccountName synchronization works

#### Existing managed domains

Existing managed domains continue to use the current behavior until an administrator enables sAMAccountName synchronization from on-premises. 
- **Setting disabled**: Microsoft Entra Domain Services generates sAMAccountName from mailNickname or the user principal name prefix. Truncation and de-duplication are applied when needed to meet legacy constraints. 
- **Setting enabled**: Microsoft Entra Domain Services sources sAMAccountName from onPremisesSamAccountName in Microsoft Entra ID for hybrid users. Existing hybrid users are updated during synchronization. 

Cloud-only users without an onPremisesSamAccountName value continue to use mailNickname-based sAMAccountName generation. 

#### New managed domains

For new managed domain deployments, enhanced synchronization is enabled by default. The sAMAccountName value for hybrid users is sourced from onPremisesSamAccountName in Microsoft Entra ID, and this behavior can’t be changed. 

### When to use enhanced synchronization

Consider enabling enhanced synchronization when your organization: 
- Uses hybrid identities and requires the same sAMAccountName values across on-premises Active Directory and Microsoft Entra Domain Services. 
- Runs applications, scripts, or authentication workflows that depend on specific sAMAccountName values. 
- Is migrating domain-dependent workloads to Azure and wants to preserve existing identity formats. 
- Experiences authentication or application errors caused by generated, truncated, duplicated, or mismatched account names. 

### Benefits
- **Improved application compatibility:** Applications can continue using established sAMAccountName values without identity-related code changes. 
- **Reduced identity drift:** Account names remain consistent across on-premises and managed-domain environments. 
- **Simplified migrations:** Existing identity formats can be preserved as workloads move to Azure. 
- **Fewer authentication issues:** Administrators can avoid mismatches caused by generating sAMAccountName from mailNickname or the user principal name prefix. 

### Before you enable the setting

Enabling the setting changes the sAMAccountName source for existing hybrid users.

Before enabling it: 
- Confirm that onPremisesSamAccountName is populated correctly in Microsoft Entra ID.
- Review applications, scripts, scheduled tasks, and access-control configurations that use sAMAccountName.
- Identify integrations that might depend on the currently generated sAMAccountName value. 
- Plan to validate authentication and application access after synchronization completes. 

Enable sAMAccountName synchronization from on-premises 
1. Sign in to the Microsoft Entra admin center with an account assigned to both the Application Administrator and Groups Administrator roles.
1. Search for and select Microsoft Entra Domain Services. 
1. Select your managed domain. 
1. In the left navigation, select Security settings. 
1. For sAMAccountName synchronization from on-premises, select Enable. 
1. Save the change. 

After the setting is enabled, Microsoft Entra Domain Services synchronizes sAMAccountName from onPremisesSamAccountName for existing hybrid users. Cloud-only users without that source attribute continue to use the existing generated behavior. 

### Validate the configuration
1. Select representative hybrid users whose onPremisesSamAccountName values are known. 
1. Confirm that their sAMAccountName values in Microsoft Entra Domain Services match the source values in Microsoft Entra ID. 
1. Test authentication for applications and scripts that depend on sAMAccountName. 
1. If a user doesn’t receive the expected value, confirm that onPremisesSamAccountName is populated in Microsoft Entra ID and verify that the enhanced synchronization setting is enabled. 


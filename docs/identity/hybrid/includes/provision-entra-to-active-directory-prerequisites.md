---
title: Include file
description: Include file
ms.topic: Include
ms.date: 08/07/2026
ms.custom: Include file, msecd-doc-authoring-1023
ai-usage: ai-assisted
---

## License requirements

Provisioning to Active Directory uses a configuration-based licensing model.

| Configuration | License required |
| --- | --- |
| **Existing configurations** (created before general availability) | No license change is required. These configurations continue to run under their existing Microsoft Entra ID P1 licensing. |
| First **2** new configurations per tenant | Microsoft Entra ID P1. |
| **More than 2** new configurations per tenant (3–20) | Microsoft Entra ID Governance. |

> [!NOTE]
> A maximum of **20** configurations (domains) can be configured per tenant. To find the right license for your requirements, see [Compare generally available features of Microsoft Entra ID](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## General requirements

> [!div class="checklist"]
> - Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
> - On-premises AD DS schema with the *msDS-ExternalDirectoryObjectId* attribute, which is available in Windows Server 2016 and later.
> - Provisioning agent with build version [1.1.2334.0](../cloud-sync/reference-version-history.md#1123340) or later.

> [!NOTE]
> The permissions to the service account are assigned during clean install only. If you're upgrading from the previous version, permissions need to be assigned manually by using PowerShell:
>
> ```powershell
> $credential = Get-Credential
> Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -EACredential $credential
> ```
>
> If the permissions are set manually, assign Read, Write, Create, and Delete all properties for all descendant Groups and User objects. These permissions aren't applied to AdminSDHolder objects by default. For more information, see [Microsoft Entra provisioning agent gMSA PowerShell cmdlets](../cloud-sync/how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain).

The provisioning agent and the sync client also have their own requirements:

- Install the provisioning agent on a domain-joined server. We recommend Windows Server 2025 or Windows Server 2022. You can use older Windows Server versions that are in extended support, but support for this configuration might require a [paid support program](/lifecycle/policies/fixed#extended-support).
- The provisioning agent must be able to communicate with one or more domain controllers on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
  - Global Catalog lookup is required to filter out invalid membership references.
- Microsoft Entra Connect Sync with build version [2.2.8.0](../connect/reference-connect-version-history.md#2280) or later.
  - Required to support on-premises user membership synchronized using Microsoft Entra Connect Sync.
  - Required to synchronize `AD DS:user:objectGUID` to `AAD DS:user:onPremisesObjectIdentifier`.

## More information

Consider the following points when you provision to AD DS:

- Group membership written to AD DS includes only members that have an AD DS account. Those members can be on-premises synchronized users, cloud-managed users that Cloud Sync provisions to AD DS because they're in scope of user provisioning, or other cloud-created security groups. A cloud-managed user that has no AD DS account is skipped.
- On-premises synchronized users must have the *onPremisesObjectIdentifier* attribute set on their account.
- The *onPremisesObjectIdentifier* must match a corresponding *objectGUID* in the target AD DS environment.
- An on-premises user *objectGUID* attribute can be synchronized to a cloud user *onPremisesObjectIdentifier* attribute by using either sync client.
- Only global Microsoft Entra ID tenants can provision from Microsoft Entra ID to AD DS. Tenants such as B2C aren't supported.
- The provisioning job runs on a recurring schedule.

> [!NOTE]
> The preview of Group Writeback v2 in Microsoft Entra Connect Sync is deprecated and no longer supported. If you use Group Writeback v2, move your sync client to Microsoft Entra Cloud Sync. If you provision Microsoft 365 groups to AD DS, you can keep using Group Writeback v1.

---
title: 'Best practices for securely deploying Microsoft Entra ID Governance '
description: This article provides best practices for securing deploying Microsoft Entra ID Governance. 
services: entra-id-governance
documentationcenter: ''
author: arvindh
manager: amycolannino
editor: ''
ms.service: active-directory
ms.topic: conceptual
ms.date: 07/28/2023
ms.author: billmath
---

# Best practices for securely deploying Microsoft Entra ID Governance 

This document provides best practices for securing deploying Microsoft Entra ID Governance. 

## Least privilege 

The principle of least privilege means giving users and workload identities the minimum level of access or permissions they need to perform their tasks. By limiting access to only required resources based on the specific roles or job functions of users, providing just-in-time access, and performing regular audits, you can reduce the risk of unauthorized actions and potential security breaches. 

Microsoft Entra ID Governance limits the access a user has based on the role that they have been assigned. Ensure that your users have the least privileged role to perform the task that they need. 

For more information, see [least privilege with Microsoft Entra ID Governance](scenarios/least-privileged.md) 

## Preventing lateral movement 

**Recommendation:** Don't use nested groups with PIM for groups. 

Groups can control access to various resources, including Microsoft Entra roles, Azure SQL, Azure Key Vault, Intune, other application roles, and third-party applications. Microsoft Entra ID allows you to grant users just-in-time membership and ownership of groups through Privileged Identity Management (PIM) for Groups. 

These groups can be “flat” or “nested groups” (a non-role assignable group is a member of a role assignable group). Roles such as the groups admin, exchange admin, and knowledge admin can manage the non-role assignable group, providing these admins a path to gain access to privileged roles. Ensure that role-assignable groups don't have non-role assignable groups as members.

For more information, see [Privileged Identity Management (PIM) for Groups](privileged-identity-management/concept-pim-for-groups.md#privileged-identity-management-and-group-nesting) 

**Recommendation:** Use Entitlement Management to provide access to sensitive resources, instead of hybrid groups. 

Organizations have historically relied on Active Directory groups to access applications. Synchronizing these groups to Microsoft Entra ID makes it easy to reuse these groups and provide access to resources connected with Microsoft Entra ID. However, this creates lateral movement risk as a compromised account / group on-premises can be used to gain access to resources connected in the cloud. 

When providing access to sensitive applications or roles, use [entitlement management](entitlement-management-scenarios.md) to drive assignment to the application instead of security groups synchronized from Active Directory Domain Services. For groups that need to be both in Microsoft Entra ID and Active Directory Domain Services, you can synchronize those groups from Microsoft Entra ID to Active Directory Domain Services using [cloud sync](~/identity/hybrid/group-writeback-cloud-sync.md). 

## Deny by default 

The principle of "Deny by Default" is a security strategy that restricts access to resources by default, unless explicit permissions are granted. This approach minimizes the risk of unauthorized access by ensuring that users and applications don't have access rights until they're specifically assigned. Implementing this principle helps create a more secure environment, as it limits potential entry points for malicious actors. 

### Entitlement Management 

[Connected organizations](entitlement-management-organization.md#what-is-a-connected-organization) are a feature of entitlement management that allows users to gain access to resources across tenants. Follow these best practices when configuring connected organizations.  

**Recommendations:**
 - Require an expiration date for access-to-access packages in a [connected organization](entitlement-management-organization.md#what-is-a-connected-organization). If, for example, users need access for the duration of a fixed contract, set the access package to expire at the end of the contract. 
 - Require approval prior to granting access to guests from connected organizations. 
 - Periodically [review guest access](entitlement-management-external-users.md) to ensure that users only have access to resources that they still need. 
 - Carefully consider which organizations you're including as connected orgs. Periodically review the list of connected organizations and remove any that you don't collaborate with anymore. 

### Provisioning 

**Recommendation:** Set the [provisioning scope](/entra/identity/app-provisioning/how-provisioning-works#scoping) to sync “assigned users and groups.” 

This scope ensures that only users explicitly assigned to your sync configuration will get provisioned. The alternative setting of allowing all users and groups should only be used for applications where access is required broadly across the organization. 

### PIM for roles 

**Recommendation:** Require approval of PIM requests for Global Admin. 

With Privileged Identity Management (PIM) in Microsoft Entra ID you can configure roles to require approval for activation, and choose one or multiple users or groups as delegated approvers.  

For more information, see [Approve or deny requests for Microsoft Entra roles in Privileged Identity Management](privileged-identity-management/pim-approval-workflow.md)

## Defense in depth 
The following sections provide additional guidance on multiple security measures you can take to provide a [defense in depth strategy](/shows/azure-videos/defense-in-depth-security-in-azure) for your governance deployments.

### Applications

**Recommendation:** Securely manage credentials for connectivity to applications 

Encourage application vendors to support [OAuth](/entra/identity-platform/v2-oauth2-client-creds-grant-flow) on their SCIM endpoints, rather than relying on long-lived tokens. Securely store credentials in [Azure Key Vault](https://azure.microsoft.com/products/key-vault), and regularly rotate your credentials. 

### Provisioning

**Recommendation:** Use a certificate from a [trusted certificate authority](/windows-server/identity/ad-cs/certification-authority-role) when configuring on-premises application provisioning.  

When configuring on-premises application provisioning with the ECMA host, you have the option to use a self-signed certificate or a trusted certificate. While the self-signed cert is helpful for getting started quickly and testing the capability, it isn't recommended for production use, because the certificates can't be revoked and expire in 2 years by default. 


**Recommendation:** Harden your Microsoft Entra Provisioning Agent server 

We recommend that you [harden your Microsoft Entra provisioning agent](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#harden-your-microsoft-entra-provisioning-agent-server) server to decrease the security attack surface for this critical component of your IT environment. The best practices described in [Prerequisites for Microsoft Entra Cloud Sync in Microsoft Entra ID](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#harden-your-microsoft-entra-provisioning-agent-server) include: 

 - We recommend hardening the Microsoft Entra provisioning agent server as a Control Plane (formerly Tier 0) asset by following the guidance provided in [Secure Privileged Access](/security/privileged-access-workstations/overview) and [Active Directory administrative tier model](/security/privileged-access-workstations/privileged-access-access-model).
 - Restrict administrative access to the Microsoft Entra provisioning agent server to only domain administrators or other tightly controlled security groups.
 - Create a [dedicated account for all personnel with privileged access](/windows-server/identity/securing-privileged-access/securing-privileged-access). Administrators shouldn't be browsing the web, checking their email, and doing day-to-day productivity tasks with highly privileged accounts.
 - Follow the guidance provided in [Securing privileged access](/security/privileged-access-workstations/overview). 
 - Enable multifactor authentication (MFA) for all users that have privileged access in Microsoft Entra ID or in AD. One security issue with using Microsoft Entra provisioning agent is that if an attacker can get control over the Microsoft Entra provisioning agent server they can manipulate users in Microsoft Entra ID. To prevent an attacker from using these capabilities to take over Microsoft Entra accounts, MFA offers protections so that even if an attacker manages to, such as reset a user's password using Microsoft Entra provisioning agent they still can't bypass the second factor.

 For more information and additional best practices, see [Prerequisites for Microsoft Entra Cloud Sync in Microsoft Entra ID](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#harden-your-microsoft-entra-provisioning-agent-server)

### Entitlement management and lifecycle workflows

**Recommendation:** Follow security best practices for using custom extensions with entitlement management + lifecycle workflows. The best practices described in [this article](custom-extension-security.md) include: 

 - Securing administrative access to the subscription 
 - Disabling shared access signature (SAS) 
 - Using managed identities for authentication 
 - Authorizing with least privileged permissions 
 - Ensuring Proof-of-Possession (PoP) usage 

**Recommendation:** All entitlement management policies should have an [expiration date](entitlement-management-access-package-lifecycle-policy.md) and / or periodic [access review](entitlement-management-access-reviews-create.md) to right size access. These requirements ensure that only users that should have access continue to have access to the application. 

## Backup and recovery 

Backup your configuration so you can recover to a known good state in case of a compromise.  Use the following list to create a comprehensive backup strategy that covers the various areas of governance.

 - [Microsoft Graph APIs](/graph/overview) can be used to export the current state of many Microsoft Entra configurations. 
 - [Microsoft Entra Exporter](https://github.com/microsoft/entraexporter) is a tool you can use to export your configuration settings. 
 - [Microsoft 365 Desired State Configuration](https://github.com/microsoft/Microsoft365DSC/wiki/What-is-Microsoft365DSC) is a module of the PowerShell Desired State Configuration framework. You can use it to export configurations for reference and application of the prior state of many settings. 
 - [Provisioning: Export Application Provisioning configuration and roll back to a known good state for disaster recovery in Microsoft Entra ID](~/identity/app-provisioning/export-import-provisioning-configuration.md) 

## Monitoring 

Monitoring helps detect potential threats and vulnerabilities early. By watching for unusual activities and configuration changes, you can prevent security breaches and maintain data integrity. 

 - Alert when users activate privileged roles. [Security alerts for Microsoft Entra roles in PIM - Microsoft Entra ID Governance](privileged-identity-management/pim-how-to-configure-security-alerts.md)
 - Proactively monitor your environment for configuration changes and suspicious activity by integrating Microsoft Entra ID Audit Logs with Azure Monitor. [Identity Governance custom alerts - Microsoft Entra ID Governance](governance-custom-alerts.md)

 ## Next steps

- [What is identity governance?](identity-governance-overview.md)
- [Understanding least privileged](scenarios/least-privileged.md)
- [Govern the employee and guest lifecycle](scenarios/govern-the-employee-lifecycle.md)
- [Govern access for applications in your environment](identity-governance-applications-prepare.md)
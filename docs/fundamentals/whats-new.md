---
title: Microsoft Entra releases and announcements
description: Learn what is new with Microsoft Entra, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
author: owinfreyATL
manager: dougeby
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.topic: reference
ms.date: 03/12/2026
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

> Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

## March 2026

### Public Preview - Microsoft Entra Backup and Recovery is now available

**Type:** Public Preview  
**Service category:** Entra Backup and Recovery  
**Product capability:** Entra Backup and Recovery  

Microsoft Entra Backup and Recovery is a built-in solution to help restore your tenant after accidental changes or malicious updates. Always on by default, it automatically backs up critical directory objects — including users, groups, applications, service principals, managed identities, conditional Access policies, named locations, agent IDs, and authentication and authorization policy, so admins can quickly restore them to a previously known good state.

At public preview Entra Backup and Recovery automatically takes daily backup of a tenant’s supported directory objects. If a tenant has Microsoft Entra ID P1 or P2 licenses, one backup is taken each day and retained for five days. Admins can view available snapshots, generate difference reports to understand what has changed, and run recovery jobs to restore objects to a prior state.

This gives your organization a reliable, built in safety net helping you recover with confidence, minimize downtime, and protect your tenant from accidental changes, misconfigurations, or security compromises. For more information, see: [Microsoft Entra Backup and Recovery overview (Preview)](../backup/overview.md).

---

### Public Preview - Entra Hybrid Join using Entra Kerberos

**Type:** Public Preview  
**Service category:** Device Registration and Management  
**Product capability:** Device Lifecycle Management  

This new capability enables a Windows device to become **Hybrid Entra joined immediately at provisioning time**, without waiting for **Entra Connect sync** or requiring **AD FS**. By leveraging Entra Kerberos, customers can modernize their hybrid identity architecture while reducing infrastructure complexity and dependency on legacy federation components. For more information, see: [Microsoft Entra hybrid join using Microsoft Entra Kerberos (preview)](../identity/devices/how-to-hybrid-join-using-microsoft-entra-kerberos.md).

---

### General Availability - Synced passkeys in Microsoft Entra ID

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra ID now supports synced passkeys as a generally available authentication method. Synced passkeys are FIDO2-based credentials that can be stored in built-in or third-party passkey providers and made available across a user’s devices. Administrators can manage the use of synced passkeys alongside device-bound passkeys through passkey profiles in the authentication methods policy. Existing passkey configurations can be managed using the same Entra ID authentication policies and reporting surfaces. For more information, see: [How to enable passkeys (FIDO2) in Microsoft Entra ID](../identity/authentication/how-to-authentication-passkeys-fido2.md).

---

### General Availability - SCIM 2.0 APIs for Microsoft Entra ID

**Type:** General Availability  
**Service category:** Provisioning  
**Product capability:** Identity Lifecycle Management  

SCIM 2.0 APIs give customers, developers, and partners a standards-based option for managing users and groups in Microsoft Entra using the System for Cross-domain Identity Management (SCIM) 2.0 specification. For more information, see: [Tutorial: Develop and plan provisioning for a SCIM endpoint in Microsoft Entra ID](../identity/app-provisioning/use-scim-to-provision-users-and-groups.md).

---

### Public Preview - Cross-tenant security group synchronization

**Type:** Public Preview  
**Service category:** Provisioning  
**Product capability:** Collaboration  

We’re introducing cross-tenant group synchronization, a new capability that allows organizations to synchronize security groups across Microsoft Entra tenants. This feature enables centralized management of group membership in a source tenant while making those groups available in one or more target tenants, simplifying cross-tenant collaboration and reducing administrative overhead associated with managing duplicate groups.

With cross-tenant group synchronization, organizations can extend their existing cross-tenant synchronization configurations to include groups, supporting scenarios such as shared application access, resource authorization, and consistent group-based access control across tenants. Admins can opt in to this functionality and configure attribute mappings and cross-tenant access policies to enable group synchronization into target tenants. Use of cross-tenant group synchronization requires Microsoft Entra ID Governance licenses. Existing licensing requirements for cross-tenant user synchronization features remains unchanged. For more information, see: [What is cross-tenant synchronization?](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md).

---

### Public Preview - Microsoft Entra passkeys on Windows

**Type:** Public Preview  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra passkeys on Windows are now available in public preview. This feature allows users to register device‑bound passkeys directly in the local Windows Hello container and use them to sign in to Microsoft Entra ID with Windows Hello biometrics or PIN.

Entra passkeys on Windows behave as standard FIDO2 credentials and can be used for Entra authentication flows without requiring the device to be Microsoft Entra joined or registered. During public preview, the feature is opt‑in and requires explicit configuration through passkey profiles to allow Windows Hello as a passkey provider. For more information, see: [How to enable passkeys (FIDO2) in Microsoft Entra ID](../identity/authentication/how-to-authentication-passkeys-fido2.md)

---

### General Availability - Passkey profiles in Microsoft Entra ID

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Passkey profiles in Microsoft Entra ID are now generally available. Passkey profiles provide a structured way to manage passkey (FIDO2) authentication by allowing administrators to define multiple profiles with different requirements and target them to specific user groups.

Each profile can specify allowed passkey types, attestation requirements, and authenticator restrictions, enabling differentiated policies for scenarios such as administrators versus standard users. For tenants that previously configured passkeys, existing settings are migrated into a default passkey profile. For more information, see: [How to enable passkeys (FIDO2) in Microsoft Entra ID](../identity/authentication/how-to-authentication-passkeys-fido2.md).

---

### Public preview - Tenant governance relationships

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

This feature allows admins to request and accept tenant governance relationships, which grant admins of the governing tenant access and administrative control over the governed tenant. For more information, see: [Microsoft Entra tenant governance documentation (preview)](https://learn.microsoft.com/entra/id-governance/tenant-governance/).

---

### Public Preview - Related Tenants

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

This feature allows admins to discover related tenants connected to their own by B2B activity or shared billing information. Admins can use this information to request and establish tenant governance relationships, or to quarantine potential risks. For more information, see: [Microsoft Entra tenant governance documentation (preview)](https://learn.microsoft.com/entra/id-governance/tenant-governance/).

---

### Public preview - Tenant configuration management administration portal experience

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

Now you can use the Entra admin center to administer tenant configuration management capabilities of Entra tenant governance. You can use this experience to:  

- Create and update monitors that enable you to define the desired state of resources in your tenant across a range of Microsoft services, and monitor the actual state of those resources relative to the desired state on an ongoing basis
- See reports of monitor results, and details of any configuration drifts identified by the configuration management service when it runs a monitor that you defined.
- Manage permission for the configuration management service to monitor resources in your tenant, by assigning app permissions or Entra roles. 

For more information, see [Tenant configuration management docs](../id-governance/tenant-governance/configuration-management.md)

---

### General Availability - Microsoft Single Sign-On for Linux support for authenticating with Phish-Resistant MFA credentials

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** SSO  

The major improvements that this release provides includes:

- Enables authentication using CBA/YubiKey with certificate (PRMFA)
- Removes dependency on Java runtime as part of the Intune install
- Improved performance and reliability when authenticating to EntraId
- Provides device trust using Entra Join instead of Entra Registration
- Increased stability and performance for authentication requests

For more information, see: [What is Microsoft single sign-on for Linux?](../identity/devices/sso-linux.md).

---

### Public preview - Secure add-on tenant creation

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

Permissioned users can now create add-on tenants that are owned and governed by their home tenant. Governance is established through tenant governing relationships, granting admins access and control via GDAP. For more information, see: [Microsoft Entra tenant governance documentation (preview)](https://learn.microsoft.com/entra/id-governance/tenant-governance/).

---

### Public Preview - Passkey Adoption Campaigns with the Conditional Access Optimization Agent

**Type:** Public Preview  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

**The Conditional Access Optimization Agent now supports passkey adoption campaigns in public preview, helping organizations roll out phishing‑resistant authentication in a structured and automated way.**

With this capability, the agent can assess user and device readiness, generate a recommended deployment plan, guide users through required steps, and automatically enforce Conditional Access policies once users are ready. Campaigns progress continuously as prerequisites are met, reducing manual effort for large‑scale passkey rollouts.

Passkey adoption campaigns are managed directly from the Microsoft Entra admin center and are currently targeted at privileged administrator roles. The agent creates Conditional Access policies in report‑only mode first, allowing administrators to monitor impact before enforcement. For more information, see: [Deploy passkey adoption campaigns with the Conditional Access Optimization Agent (Preview)](../security-copilot/conditional-access-agent-optimization-passkeys.md)

---

### Public Preview - Phased Rollout with the Conditional Access Agent

**Type:** Public Preview  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

You can now use the **Conditional Access Optimization Agent** to safely roll out _any_ report‑only Conditional Access policy in phases. When you initiate the process, the agent analyzes sign‑in data to recommend a low‑risk, staged deployment plan, starting with smaller user groups and gradually expanding, so you can turn policies on with confidence and minimize user impact. For more information, see: [Conditional Access Optimization Agent phased rollout](../security-copilot/conditional-access-agent-optimization-phased-rollout.md).

---

### General Availability - New M365 group creation experience in My Groups

**Type:** General Availability  
**Service category:** Group Management  
**Product capability:** End User Experiences  

We’re improving the Microsoft 365 group creation experience in **[My Groups](https://myaccount.microsoft.com/groups)** to give group owners more control and clarity from the start. The updated experience lets you configure key group, email, and security settings during creation—so your group works the way you expect without extra admin help later.

With this update, you can:

- Set group usage guidelines, email alias, and sensitivity labels
- Configure Exchange settings such as sending welcome emails, subscribing members to conversations, and showing the group mailbox and calendar in Outlook
-  Control who can send email to the group, hide the group from the global address list, and allow or block external senders
- Enable security group functionality when needed

This streamlined, self‑service experience helps ensure your group is created with the right defaults and policies from day one. We are rolling out to all tenants by end of March.

---

### General Availability - Microsoft Entra Connect Health now enforces TLS 1.2

**Type:** General Availability  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

We’ve completed a full migration to TLS 1.2 for Entra Connect Health and removed legacy TLS 1.1 references as part of security hardening. Ensure your Health agents are up to date and your servers are configured to use TLS 1.2 for outbound connections.

**Why this matters**  
TLS 1.1 is deprecated due to security vulnerabilities. This change helps protect agent-to-service communication and aligns with modern compliance expectations. 

**What you need to do**  
Ensure your Entra Connect Health agents are up to date and that your servers are configured to use TLS 1.2 for outbound connections. 

*   Enable [TLS 1.2](https://learn.microsoft.com/troubleshoot/entra/entra-id/ad-dmn-services/enable-support-tls-environment) support in your environment

---

### General Availability - Just‑in‑Time Password Migration in Microsoft Entra External ID

**Type:** General Availability  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

**Just‑in‑Time Password Migration is now generally available in Microsoft Entra External ID.** 

Customers can migrate user passwords securely at first sign‑in, allowing users to continue using their existing credentials without forced password resets. This enables a smoother transition from Azure AD B2C or other identity providers while reducing migration risk and operational overhead.

---

### General Availability - Enabling Email and SMS OTP MFA in Entra External ID Native Authentication

**Type:** General Availability  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** Developer Experience  

Build secure sign‑in and sign‑up experiences for applications in Entra External ID using Native Authentication, with Email and SMS OTP MFA available through developer‑friendly [SDKs and APIs.](../identity-platform/concept-native-authentication.md).

---

### General Availability - Tenant configuration management APIs

**Type:** General Availability  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

Tenant Configuration Management APIs allow organizations to take snapshots of their tenants' current configuration settings in a JSON format and to enforce configuration settings by offering continuous monitoring of drifts.

For more information see [Overview of the Tenant Configuration Management APIs](/graph/unified-tenant-configuration-management-concept-overview).

---

### General Availability – Improved readability for Authentication Methods Policy Update audit logs

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Starting in April 2026, the Authentication Methods Policy Update audit log entry has been updated to improve readability and clarity. Previously, audit logs included the full authentication methods policy payload in both the old and new values, even when only a small number of settings were changed. With this update, audit log entries now surface only the specific properties that were modified, along with their corresponding old and new values.

Policy-wide updates—such as Registration Campaigns and System‑preferred MFA—may continue to include the full policy payload. The activity name and triggering events remain unchanged. This update affects formatting only and does not change policy behavior. For more information, see: [Core Directory](../identity/monitoring-health/reference-audit-activities.md#core-directory)

---


## February 2026

### General Availability - Expanded attribute support in Lifecycle Workflows attribute changes trigger

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

The Attribute Changes trigger in Lifecycle Workflows now supports additional attribute types, enabling broader detection of organizational changes. Previously, this trigger was limited to a set of core attributes. With this update, you can configure workflows to respond when any of the following attributes change:

- Custom security attributes
- Directory extension attributes
- EmployeeOrgData attributes
- On-premises attributes 1–15

This enhancement gives administrators greater flexibility to automate lifecycle processes for mover events based on custom or extended attributes, improving governance for complex organizational structures and hybrid environments. For more information, see: [Use Custom attribute triggers in lifecycle workflows](../id-governance/workflow-custom-triggers.md).

---

### General Availability - Delegated Workflow Management in Lifecycle Workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Lifecycle workflows can now be managed with Administrative Units (AUs), enabling organizations to segment workflows and delegate administration to specific admins. This enhancement ensures that only authorized admins can view, configure, and execute workflows relevant to their scope. Customers are able to associate workflows with AUs, assign scoped permissions to delegated admins, and ensure that workflows only impact users within their defined scope. For more information, see: [Delegated workflow management](..//id-governance/manage-delegate-workflow.md).

---

### General Availability - Device authorization grant flow in Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

Similar to Microsoft Entra ID (workforce tenants), Microsoft Entra External ID (external tenants) now supports device authorization grant flow, which allows users to sign in to input-constrained devices such as a smart TV, IoT device, or a printer. For more information, see [OAuth 2.0 device authorization grant](../identity-platform/v2-oauth2-device-code.md).

---

### General Availability - Sign-in with username/alias

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

In Microsoft Entra External ID (EEID), users who authenticate with a local email and password now can also sign in using a username (alias) as an alternate sign-in identifier. This alias can represent a customer or member ID, insurance number, frequent flyer number, or a self-chosen username. The alias can be collected from user or assigned during self-service sign-up, or assigned during user creation or user update via the Microsoft Graph API or Microsoft Entra admin center. For details, see [Sign in with alias](../external-id/customers/how-to-sign-in-alias.md).

---

### Upcoming change – Microsoft Entra Connect security update to block hard match for users with Microsoft Entra roles

**Type:** Plan for change  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

**What is Hard-matching in Microsoft Entra Connect Sync and Cloud Sync?**

When Microsoft Entra Connect or Cloud Sync adds new objects from Active Directory, the Microsoft Entra ID service tries to match the incoming object with an Entra object by looking up the incoming object’s sourceAnchor value against the OnPremisesImmutableId attribute of existing cloud managed objects in Microsoft Entra ID. If there's a match, Microsoft Entra Connect or Cloud Sync takes over the source or authority (SoA) of that object and updates it with the properties of the incoming Active Directory object in what is known as "hard-match." 

To strengthen the security posture of your Microsoft Entra ID environment, we are introducing a change that will restrict certain types of hard-match operations by default.   
  

**What’s changing**

Beginning **June 1, 2026**, Microsoft Entra ID will block any attempt by Entra Connect Sync or Cloud Sync from hard-matching a new user object from Active Directory to an existing cloud-managed Entra ID user object that hold [Microsoft Entra roles](../identity/role-based-access-control/permissions-reference.md).

**This means**:

- If a cloud managed user already has [onPremisesImmutableId (sourceAnchor)](..//identity/hybrid/connect/plan-connect-design-concepts.md#sourceanchor) set and is assigned a Microsoft Entra role, Microsoft Entra Connect Sync or Cloud Sync will no longer be able to take over the Source of Authority of that user by hard-matching with an incoming user object from Active Directory.
- This safeguard prevents attackers from taking over privileged cloud managed users in Entra by manipulating attributes of user objects in Active Directory.
    

**What’s not changing**

- Hard match operations for cloud users without Microsoft Entra roles are not affected.   
- [Soft match](../identity/hybrid/connect/how-to-connect-install-existing-tenant.md?source=recommendations#hard-match-vs-soft-match) behavior isn't affected.
- Ongoing sync from Active Directory to Entra ID for previously hard-matched objects will not be affected.   
    

**Customer action required**

If you encounter a hard match error after June 1, 2026, see our [documentation](../identity/hybrid/connect/tshoot-connect-sync-errors.md#existing-admin-role-conflict) for mitigation steps.

---

### General Availability - External MFA is Generally Available

**Type:** New feature  
**Service category:** MFA  
**Product capability:** User Authentication  

We're excited to announce that external authentication methods in Microsoft Entra ID is now generally available under a new name: External Multifactor Authentication (External MFA). This capability enables organizations to meet multifactor authentication requirements while continuing to use their preferred MFA provider. Microsoft Entra ID remains the identity control plane, performing full policy evaluation and access decisions on every sign in, including real time Conditional Access enforcement and sign in risk assessment. For more information, see [How to enable external MFA](../identity/authentication/how-to-authentication-external-method-manage.md).

---

### General Availability - Custom banned password lists supported in Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

In addition to the [global banned password lists](../identity/authentication/concept-password-ban-bad.md#global-banned-password-list) already supported, EEID admins can now add specific strings to block during password creation and reset. For more information, see [Password Protection - Custom banned password lists](../identity/authentication/concept-password-ban-bad.md#custom-banned-password-list).

---

### Upcoming Changes - Jailbreak Detection in Authenticator App

**Type:** New feature  
**Service category:** Microsoft Authenticator App  
**Product capability:** Identity Security & Protection  

Starting February 2026, Microsoft Authenticator will introduce jailbreak/root detection for Microsoft Entra credentials in the Android app. The rollout progresses from warning mode → blocking mode → wipe mode. Users must move to compliant devices to continue using Microsoft Entra accounts in Authenticator.

---

### Public Preview - BYOD support for Windows client using Microsoft Entra registration

**Type:** New feature  
**Service category:** BYOD support  
**Product capability:** Network Access  

Bring Your Own Device (BYOD) support for Windows using Microsoft Entra‑registered devices is now available in public preview. Users and partners can access corporate resources from their own devices. Admins can assign the Private Application traffic profile to internal accounts, including internal guest users. For more information, see: [Bring Your Own Device (Preview)](../global-secure-access/concept-bring-your-own-device.md).

---

### General Availability - Custom Block pages

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

When you configure policies blocking your users from accessing a risky, NSFW, or unsanctioned sites or apps in GSA, they receive a clear HTML error message with Microsoft Entra Internet Access branding. We’ve heard from many admins that they’d like to start customizing that experience with text aligned to a company style guide, callouts to company Terms of Use documentation, hyperlinks to IT workflows, and more. 

Global Secure Access now offers customized block pages for Internet Access. In the Microsoft Graph API, Admins can now:

- Configure the  tenant-wide body text of the GSA block page.
- Add hyperlinks via limited markdown to reference Terms of Use,  ServiceNow/IT ticketing services, or even MyAccess for ID Governance workflow integration. 

For more information, see: [How to Customize Global Secure Access Block Page](../global-secure-access/how-to-customize-block-page.md).

---

### General Availability - Microsoft Entra Connect Sync now supports Windows Server 2025

**Type:** New feature  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

Microsoft Entra Connect Sync now officially supports [Windows Server 2025](https://www.microsoft.com/evalcenter/download-windows-server-2025). This means you can confidently install and run Microsoft Entra Connect Sync on servers running Windows Server 2025, enabling your hybrid identity environment to take full advantage of the latest Windows Server enhancements.

**What this means for you:** With this update, organizations can upgrade their identity synchronization servers to Windows Server 2025 without hesitation. Windows Server 2025 brings advanced features that improve security, performance, and flexibility, and our engineering team has thoroughly validated Microsoft Entra Connect Sync on this platform. Many customers have been eager to adopt Windows Server 2025 to leverage its enhanced security, better performance, and improved management capabilities. Now, with official support in place, you can benefit from these improvements while maintaining a reliable, fully supported hybrid identity solution.

The Microsoft Entra Connect Sync .msi installation file is exclusively available on Microsoft Entra admin center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details on available versions.

**Consider moving to Cloud Sync:** Microsoft Entra Cloud Sync is a sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we're introducing new features that improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Use the [supported sync scenarios comparison](../identity/hybrid/common-scenarios.md) to see if Cloud Sync is the right sync client for you.

---

### Public Preview - New end user homepage in My Account

**Type:** New feature  
**Service category:** My Profile/Account  
**Product capability:** End User Experiences  

The homepage at https://myaccount.microsoft.com has been updated to provide a more task-focused experience. Users will see pending actions like renewing expiring groups, approving access package requests, and setting up MFA directly on the homepage. Quick links to apps, groups, access packages, and sign-in details will be easier to find and use. This change is designed to streamline account management and help users stay on top of access and security tasks.

---

### General Availability - Microsoft Entra Provisioning Service available in Microsoft Azure operated by 21Vianet

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Outbound to SaaS Applications  

The Microsoft Entra provisioning service can be used in the 21Vianet / China cloud for the following scenarios: API-driven provisioning, Cloud Sync, Cross-tenant sync between China tenants, SCIM provisioning for the non-gallery / custom application, and on-premises app provisioning (ECMA). Specific gallery connectors such as Workday, SuccessFactors, and AWS aren't onboarded to the environment. For more information, see: [Gallery application doesn't support provisioning in US Government or 21Vianet (China) clouds](../identity/app-provisioning/known-issues.md#gallery-application-doesnt-support-provisioning-in-us-government-or-21vianet-china-clouds).

---

### General Availability - Revoke previously approved access package assignments in My Access

**Type:** New feature  
**Service category:** Entitlement Management  
**Product capability:** Identity Governance  

By end of March Microsoft Entra ID Governance approvers can now revoke access to an access package after an approval has already been granted. This gives approvers greater control to respond to changes, mistakes, or updated business needs. With this update, an approver can undo a prior approval decision, immediately removing the requestor’s access to the access package. Only the approver who originally approved the request can revoke it, even if multiple approvers belong to the same approver group. For more information, see: [Revoke a request](../id-governance/entitlement-management-request-approve.md#revoke-a-request-preview).

---

## January 2026

### General Availability - Ability to convert Source of Authority of synced on-premises AD users to cloud users is now available 

**Type:** New feature  
**Service category:** User Management  
**Product capability:** Microsoft Entra Cloud Sync

We’re pleased to announce the general availability of object-level Source of Authority (SOA) switching for Microsoft Entra ID. With this feature, administrators can transition individual users from being synced with Active Directory (AD) to becoming cloud-managed accounts within Microsoft Entra ID. These users are no longer tied to AD sync and behave like native cloud users, giving you greater flexibility and control. This capability enables organizations to gradually reduce dependence on AD and simplify migration to the cloud, all while minimizing disruption for users and daily operations. Both Microsoft Entra Connect Sync and Cloud Sync fully support this SOA switch, ensuring a smooth transition process.

For more information, see: [Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud](../identity/hybrid/user-source-of-authority-overview.md).

---

### General Availability - Microsoft Entra ID Governance guest billing meter enforcement

**Type:** New feature  
**Service category:** Entitlement Management, Lifecycle Workflows  
**Product capability:** Entitlement Management, Lifecycle Workflows

Enforcement for the Microsoft Entra ID Governance guest billing meter is now in effect for Entitlement Management and Lifecycle Workflows (Access Reviews will be enforced later in CY26 Q1). To keep using Entra ID Governance premium features for guest users in workforce tenants, you must link a valid Azure subscription to activate the Microsoft Entra ID Governance for guests add-on. If a subscription isn’t linked, creation or updates of new guest-scoped governance configurations will be restricted (for example, certain access package policies, access reviews, and lifecycle workflows), and guest-specific governance actions may fail until billing is configured.

For more information, see: [Microsoft Entra ID Governance licensing for guest users](../id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md).

---

### General Availability - Client Credentials in Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management     
**Product capability:** B2B/B2C    

We are pleased to announce the general availability of client credentials in Entra External ID.  The OAuth 2.0 client credentials grant flow permits a web service (confidential client) to use its own credentials, instead of impersonating a user, to authenticate when calling another web service. Permissions are granted directly to the application itself by an administrator.

Billing: When you configure machine-to-machine (M2M) authentication for Microsoft Entra External ID, you must use the [M2M Premium add‑on](https://www.microsoft.com/security/pricing/microsoft-entra-external-id/). Review your organization’s premium add‑on usage policy to understand cost implications and ensure the implementation complies with internal governance and licensing guidelines. For more information, see: [Microsoft identity platform and the OAuth 2.0 client credentials flow](../identity-platform/v2-oauth2-client-creds-grant-flow.md).

---

### General Availability - App-based branding via Branding themes in Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

In Entra External ID (EEID), customers can create a single, tenant-wide, customized branding experience that applies to all apps. We're introducing a concept of Branding "themes" to allow customers to create different branding experiences for specific applications. A new Live Preview feature also helps quickly visualize the changes before saving. For more information, see: [Customize the sign‑in experience for your application with branding themes in external tenants - Microsoft Entra External ID](../external-id/customers/how-to-customize-branding-themes-apps.md).

---

### General Availability - Service Principal creation audit logs for alerting & monitoring

**Type:** New feature  
**Service category:** Audit  
**Product capability:** Monitoring & Reporting  

New audit log properties now make it easy for admins to understand why a service principal was created and who or what triggered it. The logs now surface the provisioning mechanism, the specific SKUs or service plans that enabled just‑in‑time creation, and the home tenant of the app registration. This helps admins quickly distinguish Microsoft‑driven provisioning from tenant‑driven activity, streamlining alerting and investigations into newly created service principals. For more information, see: 

- [Understand why a service principal was created in your tenant](../identity/monitoring-health/understand-service-principal-creation-with-new-audit-log-properties.md)
- [How to download and analyze the Microsoft Entra provisioning logs](../identity/monitoring-health/howto-analyze-provisioning-logs.md)

---

### General Availability - Session Control Conditional Access Policies in Entra External ID

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** B2B/B2C  

EEID admins can configure persistent browser session and sign‑in frequency in Conditional Access. For more information, see [Conditional Access: Manage Session Controls Effectively](../identity/conditional-access/concept-conditional-access-session.md).

---

### General Availability - Entra Private Access for Domain Controllers

**Type:** New feature  
**Service category:** Private Access  
**Product capability:** Network Access  

Bring MFA to on‑premises applications when accessed from on‑premises, i.e., local‑to‑local access, while safeguarding domain controllers against identity threats. Enable secure access to private apps that use domain controllers for Kerberos authentication. For more information, see: [Configure Microsoft Entra Private Access for Active Directory domain controllers](../global-secure-access/how-to-configure-domain-controllers.md).

---

### General Availability - Improved enforcement for *All resources* policies with resource exclusions

**Type:** Changed feature  
**Service category:** Conditional Access  
**Product capability:** Access Control  

Microsoft Entra Conditional Access is strengthening how policies that target All resources with resource exclusions are enforced in a narrow set of authentication flows. After this change, in user sign‑ins where a client application requests only [OIDC](../identity-platform/scopes-oidc.md#openid-connect-scopes) or [specific directory scopes](../identity/conditional-access/concept-conditional-access-cloud-apps.md#legacy-conditional-access-behavior-when-an-all-resources-policy-has-a-resource-exclusion), Conditional Access policies that target All resources with one or more resource exclusions, or policies that explicitly target Azure AD Graph, will be enforced. This ensures that policies are consistently applied regardless of the scope set requested by the client application. For more information, see: [New Conditional Access behavior when an ALL resources policy has a resource exclusion](../identity/conditional-access/concept-conditional-access-cloud-apps.md#new-conditional-access-behavior-when-an-all-resources-policy-has-a-resource-exclusion).

---

## December 2025

### General Availability - Modernizing Microsoft Entra ID auth flows with WebView2 in Windows 11

**Type:** New feature  
**Service category:** Authentications (Logins)  
**Product capability:** SSO  

Windows has many user experiences that uses webview’s to gather web information to present web information to users that looks like native content. One of the common scenarios for this is for authentication flows, where a user is prompted for their username and provides credentials. 

Microsoft Entra ID app sign-in through Web Account Manager (WAM) now has the option to be powered by WebView2, the Chromium-based web control, starting with [KB5072033 (OS Builds 26200.7462 and 26100.7462) or later](https://support.microsoft.com/topic/december-9-2025-kb5072033-os-builds-26200-7462-and-26100-7462-0c1a4334-19ba-406d-bb1e-88fcffc87b79). This release marks a significant step forward in delivering a secure, modern, and consistent sign-in experience across apps and services.  

WebView2 will become the default framework for WAM authentication in an expected future Windows release, with the EdgeHTML WebView being deprecated. Therefore, we encourage users to deploy now and participate in the opt-in process, enable this experience in their environments, and make any necessary adjustments — such as updating proxy rules or modifying code in services involved in the sign in process. Contact Customer Support Services if you'd like to provide feedback.

Moving to WebView2 is more than a technical upgrade, it’s a strategic investment in secure, user-friendly identity experiences. We’re committed to evolving Microsoft Entra ID to meet the needs of modern organizations and developers.  
  
For more information, see:  

[Now generally available: Modernizing Microsoft Entra ID auth flows with WebView2 in Windows 11 - Windows IT Pro Blog](https://techcommunity.microsoft.com/blog/windows-itpro-blog/now-generally-available-modernizing-microsoft-entra-id-auth-flows-with-webview2-/4476166)

---

### General Availability - Microsoft Entra Connect security hardening to prevent user account takeover

**Type:** Fixed  
**Service category:** Entra Connect  
**Product capability:** Access Control  

When Microsoft Entra Connect adds new objects from Active Directory, the Microsoft Entra ID service tries to match the incoming object with an Entra object by looking up the incoming object’s [sourceAnchor value against the OnPremisesImmutableId attribute](../identity/hybrid/connect/how-to-connect-install-existing-tenant.md#hard-match-vs-soft-match) of existing cloud managed objects in Microsoft Entra ID. If there's a match, Microsoft Entra Connect Sync takes over the source or authority (SoA) of that object and updates it with the properties of the incoming Active Directory object in what is known as "hard-match."

As part of ongoing security hardening, Microsoft is going to introduce enforcement changes in Microsoft Entra Connect to mitigate the risk of account takeover via hard match abuse. Enforcement of this change will begin on **July 1, 2026**. 


**What’s Changing:**

- Microsoft Entra will block attempts by Entra Connect to modify the OnPremisesObjectIdentifier attribute after it has already been mapped to a synced user object. This prevents re‑mapping an existing Entra ID user to a different on‑premises identity.
- [Audit logs](../identity/monitoring-health/reference-audit-activities.md#core-directory) have been enhanced to capture changes to OnPremisesObjectIdentifier and DirSyncEnabled, enabling better visibility into synchronization behavior.
- To support [legitimate](../identity/hybrid/connect/how-to-connect-migrate-groups.md) scenarios where an existing synced Entra object must be remapped to another on-premises object, Microsoft has introduced a Microsoft Graph API that allows controlled recovery actions, without re‑enabling hard‑match abuse or unauthorized re‑mapping.
- Resetting a user’s OnPremisesObjectIdentifier field will not impact subsequent sync jobs. This means that both the cloud sync and connect sync clients can continue syncing the user object that was reset without issue. Each time a user object is synced after that field has been set to null, it gets assigned a new GUID.


**What's Not Changing:**

- This enforcement applies only to scenarios where OnPremisesObjectIdentifier is being modified for synced object since it was remapped to different on-premises object (through hard-match). Hard match and take over of cloud objects using [onPremisesImmutableId](../identity/hybrid/connect/plan-connect-design-concepts.md#sourceanchor) remains supported and unchanged.




**Customer Action Required:** 

- Review and implement updated hardening guidance, including recommended flags to disable hard match takeover where appropriate.
- Identify potentially impacted users by reviewing audit logs for recent changes to OnPremisesObjectIdentifier. Refer to the Microsoft Entra Connect Sync [error code](../identity/hybrid/connect/tshoot-connect-sync-errors.md#existing-admin-role-conflict) for impacted users
- Test the new Graph API-based recovery flow to ensure readiness before enforcement begins on **July 1, 2026**.
    


**Microsoft Graph API for Recovery**

Starting **July 1st, 2026**, the sync operations that attempt to remap existing synced objects in Entra to a different on-premises object will fail with the following error:

“*Hard match operation blocked due to security hardening. Review OnPremisesObjectIdentifier mapping.*”

Customers can recover by first clearing the OnPremisesObjectIdentifier property on the Entra object and then re-attempting the hard-match and takeover operation.

To clear the OnPremisesObjectIdentifier for a user, use the following Microsoft Graph API call:

`PATCH https://graph.microsoft.com/beta/users/{userId}`

Body:

```
{
onPremisesObjectIdentifier: null
}
```

Required permissions:
- Delegated or application permission: “**User-OnPremisesSyncBehavior.ReadWrite.All**”
- The caller must also have one of the following roles: **Global Administrator** or **Hybrid Identity Administrator**
- Any user, including global or hybrid admins, cannot reset the field via MS graph if the app isn’t granted **User-OnPremisesSyncBehavior.ReadWrite.All**

> [!NOTE]
> The API only allows clearing OnPremisesObjectIdentifier (setting it to null). Attempts to set it to any other value are blocked.


**Additional Guidance:**

- If enforcement blocks an operation, the following error message will be returned: “*Hard match operation blocked due to security hardening. Review OnPremisesObjectIdentifier mapping.*”
- Use audit logs to identify affected objects. Look for “*Update user*” events where OnPremisesObjectIdentifier was modified. These users may require remediation before enforcement begins.

The Microsoft Entra Connect Sync .msi installation file is exclusively available on Microsoft Entra admin center under[Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).  Check our [version history page](/entra/identity/hybrid/connect/reference-connect-version-history) for more details on available versions.

---

### Public Preview - Just-in-time password migration to Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

The Just-in-Time (JIT) Password Migration feature is designed to provide a seamless and secure experience for customers transitioning to Microsoft Entra External ID. This capability enables external identity providers to migrate user credentials during sign-in, eliminating the need for bulk password resets and minimizing disruption for end users. When a user meets the migration conditions at sign-in, their credentials are securely transferred as part of the process, ensuring continuity and reducing friction.

By integrating migration into the authentication flow, organizations can simplify administrative tasks while maintaining security standards. This approach not only enhances user experience but also accelerates adoption of Microsoft Entra External ID without compromising operational efficiency.

---

### Public preview - Protect enterprise generative AI applications with Prompt Shield

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

Block prompt injection attacks to enterprise GenAI apps in real-time with universal policy controls, extending Azure AI Prompt Shield to all network traffic. For more information, see: [Protect Enterprise Generative AI apps with Prompt Shield (preview)](../global-secure-access/how-to-ai-prompt-shield.md).

---

### Public Preview - B2B guest access support in Global Secure Access

**Type:** New feature  
**Service category:** B2B  
**Product capability:** Network Access  

You can now enable the B2B guest access feature for your guest users with the Global Secure Access client, signed in to their home organization's Microsoft Entra ID account. The Global Secure Access client automatically discovers partner tenants where the user is a guest and offers the option to switch into the customer's tenant context. The client routes only private traffic through the customer's Global Secure Access service. For more information, see: [Learn about Global Secure Access External User Access (Preview)](../global-secure-access/concept-external-user-access.md).

---

### Public Preview - Data exploration using Microsoft Security Copilot in Entra

**Type:** New feature  
**Service category:** N/A  
**Product capability:** Identity Security & Protection  

Microsoft Security Copilot in Microsoft Entra now supports data exploration when prompts return datasets with more than 10 items. This feature is in preview and available for select Microsoft Entra scenarios. From the Copilot chat response, select **Open list** to access a comprehensive data grid. This allows you to explore large datasets with complete and accurate results, enabling more efficient decision-making. Each data grid displays the underlying Microsoft Graph URL, helping you verify query accuracy and build confidence in the results. For more information, see: [Microsoft Security Copilot scenarios in Microsoft Entra overview](../security-copilot/entra-security-scenarios.md).

---

## November 2025

### Public Preview - Microsoft Entra ID Account Recovery

**Type:** New feature  
**Service category:** Verified ID  
**Product capability:** Identity Security & Protection  

Microsoft Entra ID Account Recovery is an advanced authentication recovery mechanism that enables users to regain access to their organizational accounts when they've lost access to all registered authentication methods. Unlike traditional password reset capabilities, account recovery focuses on identity verification and trust re‑establishment prior to replacement of authentication methods rather than simple credential recovery. For more information, see: [Overview of Microsoft Entra ID Account Recovery](../identity/authentication/concept-account-recovery-overview.md).

---

### Public preview - Self-remediation for passwordless users

**Type:** New feature  
**Service category:** Identity Protection  
**Product capability:** Identity Security & Protection  

**Self-remediation for passwordless users:** Risk-based access policies in Microsoft Entra Conditional Access now support self-remediation of risks across all authentication methods, including passwordless ones. This new control revokes compromised sessions in real-time, enables frictionless self-service, and reduces help-desk load. For more information, see: [Require risk remediation with Microsoft-managed remediation (preview)](../id-protection/concept-identity-protection-policies.md#require-risk-remediation-control-preview).

---

### General Availability - External ID regional expansion to Australia and Japan

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

We’re expanding Microsoft Entra External ID to **Australia** and **Japan** with **Go‑Local add‑on** that keeps External ID data **stored and processed in location**. This premium add‑on is selectable when you create a new External ID tenant and is designed for organizations with strict **data residency** requirements. A small set of centralized platform services remains global (e.g., some MFA/RBAC functions), with no change to security or compliance posture. **Get started:** Create a new tenant in **Australia** or **Japan** and opt in to the add‑on or contact your Microsoft representative to discuss options for your existing environment. For more information, see: [Microsoft Entra ID and data residency](data-residency.md)

---

### General Availability - New SCIM 2.0 SAP CIS connector available, with support for group provisioning

**Type:** New feature  
**Service category:** Enterprise Apps  
**Product capability:** Outbound to SaaS Applications  

An updated SCIM 2.0 SAP Cloud Identity Services (CIS) connector was released to the Microsoft Entra app gallery on September 30, 2025. It replaces our previous SAP CIS provisioning integration and now provides support for provisioning and deprovisioning groups to SAP CIS, custom extension attributes, and the OAuth 2.0 Client Credentials grant. For more information, see: [Configure SAP Cloud Identity Services for automatic user provisioning with Microsoft Entra ID](../identity/saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md).

---

### Public Preview - Externally determine the approval requirements for an access package using custom extensions

**Type:** New feature  
**Service category:** Entitlement Management  
**Product capability:** Entitlement Management  

In Entitlement Management, approvers for access package assignment requests can either be directly assigned, or determined dynamically. Entitlement management natively supports dynamically determining approvers such as the requestors manager, their second-level manager, or a sponsor from a connected organization. With the introduction of this feature you can now use custom extensions for callouts to Azure Logic Apps and dynamically determine approval requirements for each access package assignment request based on your organizations specific business logic. The access package assignment request process will pause until your business logic hosted in Azure Logic Apps returns an approval stage which will then be leveraged in the subsequent approval process via the My Access portal. For more information, see: [Externally determine the approval requirements for an access package using custom extensions](../id-governance/entitlement-management-dynamic-approval.md).

---

### General Availability - Support for eligible group memberships and ownerships in Entitlement Management access packages

**Type:** New feature  
**Service category:** Entitlement Management  
**Product capability:** Entitlement Management  

This integration between Entitlement Management and Privileged Identity Management (PIM) for Groups adds support for assigning eligible group memberships and ownerships via access packages. You are now able to govern these just-in-time access assignments at scale by offering a self-service access request & extension process and integrate them into your organization's role model. For more information, see: [Assign eligible group membership and ownership in access packages via Privileged Identity Management for Groups](../id-governance/entitlement-management-access-package-eligible.md).

---

### General Availability - Reprocess failed users and workflows in Lifecycle Workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Lifecycle Workflows now supports reprocessing of your workflows to help organizations streamline the reprocessing of workflows when errors or failures are discovered. This feature includes the ability to reprocess previous runs of workflows including failed runs or just runs that you may want to process again. Customers can choose from the following options to fit their needs:  

- Select specific workflow run to be reprocessed  
- Select which users from the workflow run to be reprocessed e.g. failed users or all users from the run  

For more information, see [Reprocess workflows](../id-governance/reprocess-workflow.md).

---

### General Availability - Groups Purview sensitivity label support in Lifecycle Workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Customers can now view Purview sensitivity labels assigned to groups and Teams in Lifecycle Workflows. When configuring workflow tasks for managing group or Teams assignments, admins will now see actively assigned sensitivity labels to support informed group selection decisions. This helps customer achieve stronger organizational compliance. For more information see [Sensitivity Labels in Lifecycle Workflows](../id-governance/workflow-sensitivity-labels.md).

---

### General Availability - Trigger workflows for inactive employees and guests in Lifecycle Workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Lifecycle Workflows now enables customers to configure custom workflows to proactively manage dormant user accounts by automating identity lifecycle actions based on sign‑in inactivity. By detecting inactivity, the workflow automatically executes predefined tasks—such as sending notifications, disabling accounts, or initiating offboarding—when users exceed the inactivity threshold. Admins can configure the inactivity threshold and scope, ensuring dormant accounts are handled efficiently and consistently — reducing security exposure, reducing license waste, and enforcing governance policies at scale. For more information, see: [Manage inactive users using Lifecycle Workflows](../id-governance/lifecycle-workflow-inactive-users.md).

---

### Public Preview - Passkey profiles in Microsoft Entra ID

**Type:** Changed feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra ID now supports group‑based passkey (FIDO2) configurations, enabling separate rollouts of different types of passkeys to different sets of users. For more information, see [How to Enable Passkey (FIDO2) Profiles in Microsoft Entra ID (Preview)](../identity/authentication/how-to-authentication-passkey-profiles.md).

---

### Public Preview - Soft Deletion for Cloud Security Groups

**Type:** New feature  
**Service category:** Group Management  
**Product capability:** Identity Security & Protection  

Soft deletion for cloud security groups introduces a safety mechanism that allows administrators to recover deleted groups within a **30‑day retention period**. When a cloud security group is deleted, it is not immediately removed from the directory; instead, it enters a soft‑deleted state, preserving its membership and configuration. This feature helps prevent accidental data loss and supports business continuity by enabling quick restoration of groups without requiring manual recreation. Administrators can restore soft‑deleted groups through the Microsoft Entra admin center or Microsoft Graph API during the retention window.

---

### Public Preview - End user experience for managing agent identities

**Type:** New feature  
**Service category:** Other  
**Product capability:** End User Experiences  

The Manage agents end user experiences lets you view, and control, agent identities you own or sponsor. With the manage agents feature, you can easily see which agents you’re responsible for, review their details, and take action to enable, disable, or request access for them. Learn more: [Manage Agents in end user experience (Preview)](../agent-id/identity-platform/manage-agent.md).

---

### Public Preview - Conditional Access for Agents

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

Conditional Access for Agent ID is a new capability in Microsoft Entra ID that brings Conditional Access evaluation and enforcement to AI agents. This capability extends the same Zero Trust controls that already protect human users and apps to your agents. Conditional Access treats agents as first‑class identities and evaluates their access requests the same way it evaluates requests for human users or workload identities, but with agent‑specific logic.

---

### Public Preview - Agent identity sponsor lifecycle support in Lifecycle Workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Managing agent identity sponsors is key for lifecycle governance and access control of agent identities. Sponsors oversee agent identities' lifecycles and access. Lifecycle Workflows now automates and streamlines sponsor lifecycle management by notifying managers and co‑sponsors when a sponsor changes roles or leaves the organization. Keeping sponsor information accurate and current ensures effective governance and compliance. For more information, see: [Agent identity sponsor tasks in Lifecycle Workflows (Preview)](../id-governance/agent-sponsor-tasks.md).

---

### Public Preview - Microsoft Entra agent registry

**Type:** New feature  
**Service category:** Other  
**Product capability:** Platform  

Microsoft Entra agent registry is a centralized metadata store of all deployed agents in an organization. As AI agents increasingly handle data retrieval, orchestration, and autonomous decision‑making, enterprises face rising security, compliance, and governance risks without clear visibility or control. Microsoft Entra agent registry, part of Microsoft Entra Agent ID, solves this by providing an extensible repository that delivers a unified view of every agent across Microsoft and non‑Microsoft ecosystems — enabling consistent discovery, governance, and secure collaboration at scale. For more information, see: [What is the Microsoft Entra Agent Registry?](../agent-id/identity-platform/what-is-agent-registry.md).

---

### Public Preview - User centric access reviews including disconnected applications

**Type:** New feature  
**Service category:** Access Reviews  
**Product capability:** Identity Governance  

This capability enables organizations to manage access reviews for applications that are not yet integrated with Microsoft Entra ID. For more information, see: [Include custom data provided resource in the catalog for catalog user Access Reviews (Preview)](../id-governance/custom-data-resource-access-reviews.md).

---

### Public Preview - User centric access reviews

**Type:** New feature  
**Service category:** Access Reviews  
**Product capability:** Identity Governance  

User centric access reviews (UAR) provide a user‑centric review model that lets reviewers view a user’s access across multiple resources in a catalog in one unified view, streamlining the process of ensuring the right access at the right time. Resources include Entra groups, and both connected and disconnected (BYOD) applications, providing customers with a consolidated, holistic review experience.  For more information, see: [Catalog Access Reviews (Preview)](../id-governance/catalog-access-reviews.md).

---

### Public Preview - New experience for Entra account registration page on Windows

**Type:** New feature  
**Service category:** Device Registration and Management  
**Product capability:** User Authentication  

We are introducing a new modernized user experience for the Entra account registration flow on Windows. The new user experience is updated to be consistent with Microsoft design patterns and splits the experience into two separate pages for registration and enrollment.

We are also introducing a new admin property in public preview to control the MDM enrollment option in the account registration flow. This is targeted at customers who want to enable Windows MAM for their work or school accounts. The new setting controls the user experience screen for end users to MDM enroll in this flow. For more information, see: [Set up automatic enrollment for Windows devices](/intune/intune-service/enrollment/windows-enroll).

---

### Public preview - Microsoft Entra ID with Entra Kerberos has added support for cloud‑only identities

**Type:** New feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra ID with Entra Kerberos has added support for cloud-only identities which allows Entra-joined session hosts to authenticate and access cloud resources like Azure file shares and Azure virtual desktop without relying on traditional Active Directory infrastructure. This capability is essential for organizations adopting a cloud-only strategy, as it removes the need for domain controllers while preserving enterprise-grade security, access control, and encryption. For more information, see: [Cloud only identity (Preview)](../identity/authentication/kerberos.md#cloud-only-identity-preview).

---

### Public preview - Microsoft Entra ID Protection for Agents

**Type:** New feature  
**Service category:** Identity Protection  
**Product capability:** Identity Security & Protection  

As organizations adopt, build, and deploy autonomous AI agents, the need to monitor and protect those agents becomes critical. Microsoft Entra ID Protection helps protect your organization by automatically detecting and responding to identity‑based risks on agents that use the [Microsoft Entra Agent ID](../agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md) platform.

---

### Public Preview - Synced passkeys in Microsoft Entra ID

**Type:** New feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra ID now supports synced passkeys stored in native and third‑party passkey providers. With this change, the passkey (FIDO2) authentication methods policy has been expanded to support group‑based configurations enabling separate rollouts of different types of passkeys. For more information on how to use this feature, see [How to Enable Synced Passkeys (FIDO2) in Microsoft Entra ID (Preview)](../identity/authentication/how-to-authentication-synced-passkeys.md)

---

### Public Preview - Unified Entra App Gallery

**Type:** New feature  
**Service category:** Enterprise Apps  
**Product capability:** Access Control  

Microsoft is enhancing Global Secure Access (GSA) with Integrated App Risk Insights, now in Preview. 

This new capability unifies Global Secure Access and the Microsoft Entra App Gallery—which now includes applications and risk scores from Microsoft Defender for Cloud Apps—into one unified, risk-aware experience. It allows organizations to discover, assess, and protect all their applications directly within the Microsoft Entra Admin Center. 

With this integration, organizations can evaluate app risk in real time and enforce access policies based on that risk. Admins can view each app’s risk score, compliance data, and configuration (SSO and provisioning) in the Entra App Gallery, while GSA applies Conditional Access and session controls based on the app’s risk level. 

What Customers Can Do: 

- Discover applications across their environment through Global Secure Access telemetry, including unmanaged or shadow IT. 
- Assess risk and compliance data in the Microsoft Entra app gallery. 
- Enforce Conditional Access and session policies in GSA, using real-time risk signals. 
    
This integration unifies app discovery, risk intelligence, and policy enforcement across the Microsoft Entra ecosystem — reducing blind spots, simplifying governance, and strengthening protection for every cloud app in use. 

The experience is now available in Preview within the Microsoft Entra Admin Center. To access this capability, you will need one of the following licenses:   

- Microsoft Entra Suite License 
- Microsoft Entra Internet Access License 
    

To learn more, see: 
- [Microsoft Entra documentation](/entra/) 

- [Microsoft Entra Global Secure Access](/entra/global-secure-access/) 

- [Microsoft Defender for Cloud Apps overview](/defender-cloud-apps/)

---

### Public Preview - GSA Cloud Firewall for Remote Networks for Internet Traffic

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

Cloud Firewall (CFW), also known as Next Gen Firewall as a Service (FWaaS), can protect GSA customers from unauthorized egress access (like connections to the Internet networks) by monitoring and applying policies on the network traffic, providing centralized management, visibility, and consistent policies for branches. For more information, see: [Configure Global Secure Access cloud firewall (preview)](../global-secure-access/how-to-configure-cloud-firewall.md).

---

### Public Preview - Secure Web and AI Gateway for Microsoft Copilot Studio Agents

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

As organizations adopt autonomous and interactive AI agents to perform tasks previously handled by humans, administrators need visibility and control over agent network activity. Global Secure Access for agents provides network security controls for Microsoft Copilot Studio agents, enabling you to apply the same security policies to agents that you use for users.

With Global Secure Access for agents, you can regulate how agents use knowledge, tools, and actions to access external resources. You can apply network security policies including web content filtering, threat intelligence filtering, and network file filtering to agent traffic. For more information, see: [Learn about Secure Web And AI Gateway for Microsoft Copilot Studio agents (preview)](../global-secure-access/concept-secure-web-ai-gateway-agents.md).

---

### Public preview - Internet traffic support over GSA remote network connectivity

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

Remote Network Connectivity enables secure, _clientless_ access to Microsoft 365 and internet resources from branch offices via IPsec tunnels. While Microsoft 365 traffic support is generally available, full internet access has now gone to public preview. Supporting full internet traffic was the top requests from remote network connectivity customers, including our own MSIT. For more information, see: [How to create a remote network with Global Secure Access](../global-secure-access/how-to-create-remote-networks.md).

---

### General Availability - GSA + Netskope ATP & DLP integration

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

In today's evolving threat landscape, organizations face challenges protecting sensitive data and systems from cyber attacks. Global Secure Access combines Entra Internet Access protections with Netskope's Advanced Threat Protection (ATP) and Data Loss Prevention (DLP) capabilities to deliver real-time protection against malware, zero-day vulnerabilities, and data leaks, and simplifies management through a unified platform. Microsoft’s SSE solution adopts an open platform approach, enabling integration with third-party companies, with Netskope being the first. For more information, see: [Global Secure Access integration with Netskope's Advanced Threat Protection and Data Loss Prevention](../global-secure-access/concept-netskope-integration.md).

---

### Public Preview - Entitlement Management Introduces Additional Approval Flows for Risky Users’ Access Package Requests Based on IRM and IDP Risk Signals

**Type:** Changed feature  
**Service category:** Entitlement Management  
**Product capability:** Entitlement Management  

Entitlement Management now supports risk-based approval escalation. When a user requesting an access package is flagged by Insider Risk Management or Identity Protection as requiring additional scrutiny, the request is automatically routed to designated security approvers for an extra approval step before access is granted. For more information see:

IDP- [Configure ID Protection-based approvals for access package requests in Entitlement Management (Preview)](../id-governance/entitlement-management-configure-id-protection-approvals.md)

IRM- [Configure Insider risk management-based approvals for access package requests in Entitlement Management (Preview)](../id-governance/entitlement-management-configure-insider-risk-management-approvals.md)

---

### General Availability - Microsoft Entra Internet Access TLS Inspection

**Type:** Changed feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

Transport Layer Security (TLS) Inspection for Microsoft Entra Internet Access is now generally available, delivering deep visibility into encrypted traffic and advanced security controls.

TLS Inspection provides the foundation for user-friendly block messages, full URL filtering, file policy enforcement, and prompt inspection with AI Gateway.

Organizations can define flexible TLS inspection policies to specify which traffic to inspect, and which users or devices policies apply to. Custom rules offer granular control to intercept or bypass traffic based on destination FQDNs or web categories, while traffic logs provide detailed insights into matched policies and rules. Learn more from [What is Transport Layer Security Inspection?](../global-secure-access/concept-transport-layer-security.md).

---

### Public Preview - URL Filtering

**Type:** New feature  
**Service category:** Internet Access  
**Product capability:** Network Access  

This public preview allows you to configure URL filtering rules to granularly deny or allow access to full URLs (including hostname and full path). These rules are part of the existing web content filtering policy schema that allows security policies to become context-aware by linking a policy to a security profile to a conditional access policy. For more information, see: [How to configure Global Secure Access web content filtering](../global-secure-access/how-to-configure-web-content-filtering.md).

---

## October 2025

### Plan for Change - Update to Revoke Multifactor Authentication Sessions 

**Type:** Plan for change   
**Service category:** MFA    
**Product capability:** Identity Security & Protection    

Starting February 2026, we are replacing the current “*Revoke multifactor authentication sessions*” button with the “*Revoke sessions*” button in the Microsoft Entra admin center.

The legacy “*Revoke MFA session*s” action only applies to per-user MFA enforcement, which has led to confusion. To simplify and ensure consistent behavior, the new “*Revoke sessions*” button will invalidate all user sessions, including MFA, regardless of whether MFA is enforced via Conditional Access or per-user policies.

**Action required**

Admins should update workflows and guidance to use “*Revoke sessions*” instead of “*Revoke MFA sessions*”. The “*Revoke MFA sessions*” option will be removed from the portal after this change.

---

### Public Preview - Delegated Workflow Management in Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Lifecycle workflows can now be managed with Administrative Units (AUs), enabling organizations to segment workflows and delegate administration to specific admins. This enhancement ensures that only authorized admins can view, configure, and execute workflows relevant to their scope. Customers are able to associate workflows with AUs, assign scoped permissions to delegated admins, and ensure that workflows only impact users within their defined scope. For more information, see: [Delegated workflow management (preview)](../id-governance/manage-delegate-workflow.md).

---

### Public Preview - App-based branding via Branding themes in Microsoft Entra External ID
 
**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    
 
In Microsoft Entra External ID (EEID), customers can create a single, tenant-wide, customized branding experience that applies to all apps. We're introducing a concept of Branding "*themes*" to allow customers to create different branding experiences for specific applications. For more information, see [Customize branding themes for apps](/entra/external-id/customers/how-to-customize-branding-themes-apps).

---

### Public preview - Expanded attribute support in Lifecycle Workflows attribute changes trigger

**Type:** Changed feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

The Attribute Changes trigger in Lifecycle Workflows now supports additional attribute types, enabling broader detection of organizational changes. Previously, this trigger was limited to a set of core attributes. With this update, you can configure workflows to respond when any of the following attributes change:

- Custom security attributes
- Directory extension attributes
- EmployeeOrgData attributes
- On-premises attributes 1–15

This enhancement gives administrators greater flexibility to automate lifecycle processes for mover events based on custom or extended attributes, improving governance for complex organizational structures and hybrid environments. For more information, see: [Use Custom attribute triggers in lifecycle workflows (Preview)](../id-governance/workflow-custom-triggers.md).

---

### Public Preview - Sign-in with username/alias

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C   

In Microsoft Entra External ID (EEID), users with a local email+password credential can sign in with email address as identifier.  We are adding the ability for these users to sign in with an alternative identifier such as customer/member ID, for example insurance number, frequent flier number assigned via Graph API or Microsoft Entra admin center. For more information, see [Sign in with an alias or username (preview)](/entra/external-id/customers/how-to-sign-in-alias).

---

### Deprecation - Iteration 2 beta APIs for Microsoft Entra PIM will be retired. Migrate to Iteration 3 APIs. 

**Type:** Deprecated   
**Service category:** Privileged Identity Management    
**Product capability:** Identity Governance   

**Introduction**

Starting Oct 28, 2026, all applications and scripts making calls to Microsoft Entra Privileged Identity Management (PIM) [Iteration 2](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta&preserve-view=true) (beta) APIs for Azure resources, Microsoft Entra roles and Groups will fail.

**How this will affect your organization**

After Oct 28, 2026, any applications or scripts calling Microsoft Entra PIM Iteration 2 (beta) API endpoints will fail. These calls will no longer return data, which might disrupt workflows or integrations relying on these endpoints. These APIs were released in beta and are being retired, Iteration 3 are generally available (GA) APIs which offer improved reliability and broader scenario support.

**What you need to do to prepare**

We strongly recommend migrating to the **Iteration 3 (GA) APIs**, which are generally available. 

- Begin migration planning and testing as soon as possible.
- Halt any new development using Iteration 2 APIs.
- Review documentation for Iteration 3 APIs to ensure compatibility.

Learn more: 

- [API concepts in Privileged Identity management - Microsoft Entra ID Governance | Microsoft Learn](../id-governance/privileged-identity-management/pim-apis.md)
- [Privileged Identity Management iteration 2 APIs](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta&preserve-view=true)
- [Migrate from PIM iteration 2 APIs to PIM iteration 3 APIs](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta&preserve-view=true#migrate-from-pim-iteration-2-apis-to-pim-iteration-3-apis)

---

### Public Preview - Soft Delete & Restore for Conditional Access Policies and Named Locations

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

We’re thrilled to announce the **Public Preview of soft delete and restore for Conditional Access (CA) policies and Named Locations** in Microsoft Entra. This new capability extends our proven soft delete model to critical security configurations across **Microsoft Graph APIs (in beta) and the Microsoft Entra Admin Center**, helping admins recover from accidental or malicious deletions quickly and strengthen overall security posture.

With this feature, admins can:

- Restore deleted items to their exact prior state within 30 days  
- Review deleted items before restoring   
- Permanently delete when needed

Soft delete has already been proven at scale across Microsoft Entra (7M+ objects restored in the last 30 days). Bringing it to CA policies and Named Locations ensure quick disaster recovery, minimizes downtime, and maintains security integrity.

---

### General Availability - Suggested Access Packages can be shown to users in My Access

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

In My Access, Microsoft Entra ID Governance users can see a curated list of suggested access packages in My Access. This capability allows users to quickly view the most relevant access packages for them based off their peers' access packages and previous assignments without scrolling through all their available access packages.

The suggested access packages list is created by finding people related to the user (manager, direct reports, organization, team members) and recommending access packages based on what the users’ peers have. The user is also suggested access packages that were previously assigned to them.

We recommend admins turn on the peer-based insights for suggested access packages via this setting. For more information, see: [Suggested access packages in My Access](../id-governance/entitlement-management-suggested-access-packages.md)

---

### General Availability - Conversion of external users to internal members

**Type:** New feature    
**Service category:** User Management    
**Product capability:** User Management    

External user conversion enables customers to convert external users to internal members without needing to delete and create new user objects. Maintaining the same underlying object ensures the user’s account and access to resources isn’t disrupted and that their history of activities remains intact as their relationship with the host organization changes. 

The external to internal user conversion feature includes the ability to convert on-premises synchronized users as well.

---

### General Availability - Granular, Least-Privileged Permissions for UserAuthenticationMethod APIs

**Type:** New feature    
**Service category:** MS Graph    
**Product capability:** Developer Experience    

**Summary**

We're introducing new, granular permissions for the UserAuthenticationMethod APIs in Microsoft Entra ID. This update enables organizations to apply the principle of least privilege when managing authentication methods, supporting both security and operational efficiency.

**What’s New?**

- **New per-method permissions:** Fine-grained permissions for each authentication method (for example, Password, Microsoft Authenticator, Phone, Email, Temporary Access Pass, Passkey, Windows Hello for Business, QR+PIN, and others).
- **Read-only policy permission:** A new permission allows read-only access to authentication method policies, improving role separation and auditability.

For more information, see [Microsoft Graph permissions reference - Microsoft Graph | Microsoft Learn](/graph/permissions-reference)

---

### Public Preview - Cloud Managed Remote Mailboxes

**Type:** New feature    
**Service category:** User Management    
**Product capability:** Microsoft Entra Cloud Sync    

The Source of Authority (SOA) at the object level allows administrators to convert specific users synced from Active Directory (AD) to Microsoft Entra ID into cloud-editable objects, which are no longer synced from AD and act as if originally created in the cloud. This feature supports a gradual migration process, decreasing dependencies on AD while aiming to minimize user and operational impact. Both Microsoft Entra Connect Sync and Cloud Sync recognize the SOA switch for these objects. The option to switch the SOA of synced users from AD to Microsoft Entra ID is currently available in Public Preview. For more information, see: [Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud (Preview)](../identity/hybrid/user-source-of-authority-overview.md).

---

### Public Preview - Prefetch Workday termination data to customize account disable logic

**Type:** Fixed    
**Service category:** Provisioning    
**Product capability:** Inbound to Microsoft Entra ID    

This Workday connector update resolves termination processing delays observed for workers in APAC and ANZ regions. Admins can now enable termination lookahead setting to prefetch data and tailor deprovisioning logic for accounts in Microsoft Entra ID and on-premises Active Directory. For more information, see: [Configure Workday termination lookahead (Preview)](../identity/app-provisioning/configure-workday-termination-lookahead.md).

---

### General Availability - Ability to convert Source of Authority of synced on-premises AD groups to cloud groups is now available 

**Type:** New feature    
**Service category:** Group Management    
**Product capability:** Microsoft Entra Cloud Sync    

The Group SOA feature lets organizations move application access governance from on-premises to the cloud by transferring Active Directory group authority to Microsoft Entra ID using Connect Sync or Cloud Sync. With phased migration, admins can reduce AD dependencies gradually and minimize disruption. Microsoft Entra ID Governance manages access for both cloud and on-premises apps linked to security groups, and customers of either sync client can now use this feature. For more information, see: [Group source of authority](https://aka.ms/groupsoadocs).

---

### Plan for Change - Jailbreak Detection in Authenticator App

**Type:** Plan for change    
**Service category:** Microsoft Authenticator App    
**Product capability:** Identity Security & Protection    

**Starting February 2026**, we'll introduce **Jailbreak/Root detection for Microsoft Entra credentials in the Authenticator app**. This update strengthens security by preventing Microsoft Entra credentials from functioning on jail-broken or rooted devices. All existing credentials on such devices will be wiped to protect your organization.

This capability is secure by default and requires no admin configuration or control. The change applies to both iOS and Android.This change won't apply to personal or third party accounts.

**Action required:** Notify end users about this upcoming change. Authenticator will become unusable for Microsoft Entra accounts on jail-broken or rooted devices.

For more information, see: [About Microsoft Authenticator](https://support.microsoft.com/account-billing/about-microsoft-authenticator-9783c865-0308-42fb-a519-8cf666fe0acc).

---

### Public Preview - Global Secure Access B2B support with AVD and W365

**Type:** New feature    
**Service category:** B2B    
**Product capability:** Network Access    

Guest access support for Global Secure Access (GSA) using W365 and AVD is now in public preview. This B2B support addresses secure access using GSA to external identities such as Guests, Partners, Contractors using Windows Cloud - Azure Virtual Desktop (AVD), and Windows 365 (W365). This feature empowers 3rd party users from a foreign tenant to securely access resources within a company’s tenant also known as the resource tenant. As a resource tenant administrator, you can enable Private Access, Internet Access, and Microsoft 365 traffic to these 3rd party users.

For more information, see: [Learn about Global Secure Access B2B Guest Access (Preview) - Global Secure Access | Microsoft Learn](../global-secure-access/concept-external-user-access.md).

---

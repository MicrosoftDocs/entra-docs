---
title: Microsoft Entra releases and announcements
description: Learn what is new with Microsoft Entra, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
manager: dougeby
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.topic: reference
ms.date: 06/26/2026
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
ai-usage: ai-assisted
#Customer Intent: As an IT admin, I want to review the latest Microsoft Entra releases and announcements so that I can stay current with product updates.
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

> Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

## June 2026

### General Availability - External users can be directly assigned to Access Packages

**Type:** New feature  
**Service category:** Entitlement Management  
**Product capability:** Identity Governance

This feature allows Entitlement Management admins to directly assign external users who are not in the directory to an access package using the user's email. Users are invited into the tenant as Guest users and are governed (as long as Entra ID Governance is configured).

---

### General availability - Microsoft Entra Kerberos key rotation improved reliability for incoming trust referral flows

**Type:** Changed feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication

General availability of Microsoft Entra Kerberos key rotation improved reliability particularly for environments using incoming trust referral flows. Previously, authentication failures could occur during Kerberos key rotation if referral tickets were encrypted with a secondary key. The update enhances validation logic to attempt decryption with both primary and secondary Kerberos keys, improving resiliency during key rollover operations and reducing authentication disruption during rotation events. For more information, see: [Rotate the Kerberos server key for Microsoft Entra Kerberos](../identity/authentication/kerberos-server-key-rotation.md).

---

### General Availability - BYOD support for Windows client using Entra registration

**Type:** New feature  
**Service category:** BYOD  
**Product capability:** Network Access

We are excited to announce Bring Your Own Device (BYOD) support for Windows client using Entra-registered devices is now generally available. You can now enable **users and partners** to access corporate resources from their own devices. Administrators can assign the **Private Application** traffic profile to users with internal accounts, including **internal guest users**. This removes the previous requirement for Windows devices to be domain-joined. For more information, see: [Bring Your Own Device](../global-secure-access/concept-bring-your-own-device.md).

---

### Generally available - Jailbreak/Root Detection in Authenticator App

**Type:** New feature  
**Service category:** Microsoft Authenticator App  
**Product capability:** Identity Security & Protection

Microsoft Authenticator introduced jailbreak/root detection for Microsoft work or school accounts in the Authenticator app. Users with rooted/jailbroken devices will be blocked from adding/using work or school accounts in Authenticator app. Users must move to compliant devices to continue using work or school accounts in Authenticator. This capability is secure by default and does not require any admin configuration or control.

---

### Public Preview - Extended Conditional Access protections for Agent's user accounts

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection

Conditional Access now provides broader controls to secure AI agents that have a user account. Administrators can:

- **Target agent's user accounts with greater precision** by including or excluding individual agents or dynamically grouping agents using **Custom Security Attributes**.
- **Protect against risky agent activity** by applying Conditional Access policies based on **Agent Risk**.
- **Require compliant devices** for agents running on managed endpoints, including **Windows 365 for Agents**, ensuring agents can only operate from devices that meet your organization's compliance requirements.
- **Apply device platforms, filter for devices and compliant network conditions** to agents running on endpoints, enabling policies based on device state and trusted network locations.

These capabilities extend Zero Trust protections to agent's user accounts while leveraging the familiar Conditional Access policy experience. For more information see: [Target agent identities in Conditional Access policies](../identity/conditional-access/howto-target-agent-identities.md).

---

### General Availability - Domainless SAML IdP federation for workforce tenants

**Type:** New feature  
**Service category:** B2B  
**Product capability:** B2B/B2C

Domainless SAML federation with a SAML Identity Provider allows external users to authenticate into your apps or workforce resources using their IdP-managed credentials, regardless of their email domain. Domainless federation removes the need for domain matching between the user's email and preconfigured IdP domains during sign-in or invitation redemption. Learn more at [Add a SAML/WS-Fed identity provider - Microsoft Entra External ID](/entra/external-id/direct-federation#domainless-saml-idp-federation-preview).

---

### General Availability - SCIM 2.0 APIs for Microsoft Entra ID in US Gov cloud

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Identity Lifecycle Management

SCIM 2.0 APIs are now generally available in the US Gov cloud, giving customers, developers, and partners a standards-based option for managing users and groups in Microsoft Entra using the System for Cross-domain Identity Management (SCIM) 2.0 specification. For more information, see: [Enable the SCIM Provisioning API in Microsoft Entra ID](../identity/app-provisioning/enable-scim-api.md).

---

### General Availability - Microsoft Entra Backup and Recovery is now available

**Type:** New feature  
**Service category:** Entra Backup and Recovery  
**Product capability:** Entra Backup and Recovery

Microsoft Entra Backup and Recovery is a built-in solution to help restore your tenant after accidental changes or malicious updates. Always on by default, it automatically backs up critical directory objects — including users, groups, applications, service principals, managed identities, Conditional Access policies, named locations, agent IDs, and authentication and authorization policy, so admins can quickly restore them to a previously known good state.

At preview, Entra Backup and Recovery automatically takes daily backup of a tenant's supported directory objects. If a tenant has Microsoft Entra ID P1 or P2 licenses, one backup is taken each day and retained for 7 days. Admins can view available snapshots, generate difference reports to understand what has changed, and run recovery jobs to restore objects to a prior state.

This gives your organization a reliable, built-in safety net helping you recover with confidence, minimize downtime, and protect your tenant from accidental changes, misconfigurations, or security compromises. For more information, see: [Microsoft Entra Backup and Recovery overview (Preview)](../backup/overview.md).

---

### Upcoming change - Improved restore experience for device-bound Authenticator app passkeys on iOS

**Type:** Plan for change  
**Service category:** Microsoft Authenticator App  
**Product capability:** Identity Security & Protection

No action is required.

What is changing? Starting August 2026, users will see an improved restore experience for device-bound Authenticator app passkeys for iOS users. No admin or user action is required.

With this update:

- Users who already have iCloud and iCloud Keychain backup enabled for the Authenticator app—and have device-bound Authenticator passkeys on their old device—will automatically benefit from this improved experience.
- Users restoring their Authenticator app on a new iOS device will experience an updated restore flow.

This change streamlines the restore experience by directing users to the right recovery path based on access to their old device and helping them understand cross-device passkey authentication, resulting in a smoother transition to a new phone.

This update applies to iOS devices only. Android support will follow.

[Learn more](https://support.microsoft.com/account-billing/back-up-account-credentials-in-microsoft-authenticator-bb939936-7a8d-4e88-bc43-49bc1a700a40) about the changes to backup and restore in Authenticator app.

---

### Public Preview - New built-in Entra role for SOC identity response in Microsoft Defender

**Type:** New feature  
**Service category:** RBAC  
**Product capability:** Identity Security & Protection

Starting June 8 we're introducing a new built-in role in Microsoft Entra—**SOC Identity Responder**—to further improve how security teams execute identity containment actions initiated from Microsoft Defender using a least-privilege access model.

Previously, performing these actions required SOC analysts to hold multiple high-privilege Entra roles or depend on identity administrators, creating delays during active investigations.

With this update, **SOC analysts can be assigned a dedicated role purpose-built for identity response actions**, allowing them to perform key actions—such as disabling users, revoking sessions, and forcing password resets—without being granted broad directory administrative privileges.

Access to this role supports flexible assignment models, including **role-assignable groups** for managing permissions through group membership and delegated ownership. Optional integration with **Privileged Identity Management (PIM)** enables just-in-time activation and enhanced governance controls.

These actions continue to be enforced and audited by Microsoft Entra, ensuring consistency with existing RBAC and compliance controls.

---

### Public Preview - Prevent unauthorized changes to AD groups with AD group enforcement

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Entra Cloud Sync

For customers leveraging group provisioning to AD, this capability ensures that changes to AD groups remain consistent with those managed in Microsoft Entra. With this preview, you can designate specific AD groups so that modifications to those groups can only be made through the Entra provisioning service. Changes made outside of Entra are blocked, helping prevent drift before it occurs and maintaining alignment between Entra ID and AD groups.

Learn more: [AD group enforcement documentation](https://aka.ms/ADEnforcementDocumentation).

---

## May 2026

### Public Preview - Enable soft-delete for Microsoft Entra Device objects

**Type:** New feature  
**Service category:** Device Access Management  
**Product capability:** Entra Backup and Recovery

Device Soft Delete, now available in preview, enables administrators to safely remove device objects by moving them to a recoverable state instead of permanently deleting them. This feature allows organizations to restore devices within a defined retention period while preserving critical data such as device identity and associated security artifacts. The feature supports Microsoft Entra joined, registered, and hybrid joined devices and helps reduce risk from accidental deletions while improving device lifecycle management.

---

### General Availability - NetBiosName resolution test now informational

**Type:** Changed feature  
**Service category:** Entra Connect  
**Product capability:** Entra Connect    

The “NetBIOS Name Sysvol Connectivity resolution” test in the AD DS health monitoring agent has been _reclassified_ from an alerting test to an informational test. Going forward, if this test fails, it will no longer generate an alert or require remediation action on your part. Instead, the test runs in the background and logs results for your information only.  

**What Changed**


**The NetBIOS Name Sysvol Connectivity test is now _informational-only_**. Previously, when this test failed (e.g. if a domain controller couldn’t resolve the **NetBIOS name** to access its **SYSVOL share**), an **alert was triggered** in Connect Health, prompting you for action. Now, **failures in this test will not raise an alert** in Microsoft Entra Connect Health.

**Why We Made This Change**


**NetBIOS is a legacy networking protocol that is not critical in modern Active Directory environments.** Many organizations no longer rely on NetBIOS name resolution in day-to-day operations. **Reclassifying this test as informational reduces noise in your alert feed and allows you to focus on issues that are genuinely critical to your identity infrastructure.** In short, we want to ensure that Connect Health alerts highlight _meaningful issues_ and help you prioritize real problems, rather than flagging non-essential conditions.

---

### Upcoming change - Enhanced admin authorization for Microsoft Entra Connect Sync configuration changes

**Type:** Changed feature  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

We're enhancing the security posture of Microsoft Entra Connect Sync by introducing interactive admin authorization for configuration changes. With this update, an authorized administrator will need to sign in and explicitly approve changes to sync settings, ensuring that configuration updates are intentional and made by the right person.

**What’s changing**

*   **Interactive admin authorization for sync configuration changes:** Going forward, changes to sync configuration settings – such as enabling or disabling features – will require interactive authentication from an authorized cloud administrator. Whether you're using the Entra Connect wizard or PowerShell, a verified admin sign-in will be required to complete the action. This strengthens the authorization model for all sync-related configuration changes.
*   **Greater consistency in admin-driven configuration:** We are aligning sync behavior so that configuration decisions made by cloud administrators are consistently respected. The cloud will serve as the source of truth for sync feature state, giving administrators greater confidence that their intended configuration is maintained.
*   **Updated management paths:** All management interfaces for Entra Connect will incorporate delegated admin authentication where needed. Specifically:

*   **Entra Connect wizard flows:** The installation and configuration wizard will use delegated admin tokens for sync configuration changes, providing a more secure authorization flow.
*   **PowerShell cmdlets:** PowerShell-based management of sync settings will now prompt for an interactive admin sign-in to complete configuration changes. Ensure you run these commands in a session where you can provide admin credentials.
*   **Uninstall behavior:** If you uninstall Entra Connect Sync and choose to make cloud-side changes such as converting the tenant to cloud-only synchronization, the uninstall process will require admin authentication before modifying settings in the cloud tenant.

**What’s not changing**

*   Sync functionality and the end-user experience remain unchanged. Everything continues to work as expected when features are enabled or disabled.
*   There is no change to how administrators choose to enable or disable sync features; only that these actions now require interactive authentication.

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on Microsoft Entra admin center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details on available versions.

---

### Public Preview - Workload identity-based authentication for SAP SuccessFactors provisioning integrations 

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Inbound to Entra ID    

Microsoft Entra is introducing workload identity–based authentication for SAP SuccessFactors provisioning. This new capability allows the Microsoft Entra provisioning service to authenticate to SAP SuccessFactors using Entra workload identity and short‑lived tokens instead of static credentials (username and password). 

This change helps customers transition to a more secure authentication model in preparation for SAP’s plan to [deprecate basic authentication for SuccessFactors APIs by November 2026](https://help.sap.com/docs/successfactors-release-information/8e0d540f96474717bbf18df51e54e522/fcc05a902b4140e585d968c2fe4a96bc.html). 

What’s changing 

*   Customers can switch existing provisioning configurations from basic authentication to workload identity–based authentication directly through updated connectivity settings in the provisioning experience, without needing to recreate or restart their configuration. 
*   This method removes the need to store long-lived credentials and uses a standards-based authentication method between Entra and SAP SuccessFactors through SAP Cloud Identity Services.  
This capability applies to the following provisioning scenarios:  
*   [SAP SuccessFactors to Active Directory user provisioning](../identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) 
*   [SAP SuccessFactors to Microsoft Entra ID user provisioning](../identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) 
*   [SAP SuccessFactors writeback (Entra to SuccessFactors)](../identity/saas-apps/sap-successfactors-writeback-tutorial.md)
    

What this means for you 

*   If you are currently using basic authentication for any of the above SAP SuccessFactors provisioning integrations, you must upgrade to workload identity-based authentication before November 2026 to ensure uninterrupted operation of the integrations. 
*   No immediate action is required, but we recommend planning your migration early to avoid last-minute disruption. 
The new method improves security by:  
*   Eliminating stored passwords 
*   Using short-lived, verifiable tokens 
*   Aligning with SAP’s supported authentication model 
    

Recommended action 

*   Evaluate the new authentication option once available in your tenant 
*   Plan and test migration of existing provisioning jobs to workload identity-based authentication 
*   Update any internal documentation or operational processes that reference basic authentication 
    
Additional information 

For detailed configuration guidance and step-by-step instructions visit https://aka.ms/EntraSAPSFConnectivityGuide.

---

### Public Preview - Sensitivity labels for Microsoft Entra security groups

**Type:** New feature  
**Service category:** Group Management    
**Product capability:** Platform    

Microsoft Entra ID now supports applying Microsoft Purview sensitivity labels to Entra cloud security groups in public preview.

Administrators can use labels to govern security group settings such as guest access using the same labels and policies that apply to Microsoft 365 groups today. 

Labels can be managed in Microsoft Purview and applied through the Microsoft Entra Admin Center, Azure portal, and Microsoft Graph. For more information, see: [Assign sensitivity labels to Microsoft Entra security groups (preview)](/entra/identity/users/groups-sensitivity-labels).

---

### General Availability - Account Discovery

**Type:** General Availability  
**Service category:** Provisioning  
**Product capability:** 3rd Party Integration

Account discovery for connected applications is now generally available in Microsoft Entra ID Governance. This capability provides administrators with visibility into all accounts that exist within connected applications, including orphan accounts.

By generating discovery reports directly from the provisioning experience, organizations can identify accounts in connected applications that aren't assigned to the enterprise application in Microsoft Entra and simplify onboarding the application.

This capability requires a Microsoft Entra ID Governance or Microsoft Entra Suite license. Learn more: [https://aka.ms/accountDiscoveryDocumentation](https://aka.ms/accountDiscoveryDocumentation).

---

### General Availability - Cross tenant group synchronization

**Type:** General Availability  
**Service category:** Provisioning  
**Product capability:** Identity Lifecycle Management    

Cross tenant group synchronization allows organizations to synchronize security groups across Microsoft Entra tenants. This feature enables centralized management of group membership in a source tenant while making those groups available in one or more target tenants, simplifying cross-tenant collaboration and reducing administrative overhead associated with managing duplicate groups.

With cross tenant group synchronization, organizations can extend their existing cross tenant synchronization configurations to include groups, supporting scenarios such as shared application access, resource authorization, and consistent group-based access control across tenants. Admins can opt in to this functionality and configure attribute mappings and cross tenant access policies to enable group synchronization into target tenants. Use of cross-tenant group synchronization requires Microsoft Entra ID Governance licenses. Existing licensing requirements for cross tenant user synchronization features remains unchanged. [https://learn.microsoft.com/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md).

---

### General Availability - Modernized My Account pages

**Type:** Changed feature  
**Service category:** Modernized My Account pages  
**Product capability:** End User Experiences    

We're excited to announce the upcoming general availability of three redesigned pages in the My Account portal (myaccount.microsoft.com), bringing a modernized experience to help end users manage their account with greater ease and clarity.

The redesigned Devices page features a modernized layout that makes it easier for users to view and manage their registered devices. BitLocker recovery keys are now more prominently surfaced, reducing the need to contact IT helpdesk for key retrieval.

The new Personal Info page gives users a centralized view of their profile information alongside language and region settings - making it simple to review and update personal details in one place.

The redesigned Organizations page delivers a modernized experience and resolves a longstanding issue where users were unable to successfully leave an organization.

Availability: These pages will be generally available to all Microsoft Entra ID customers by end of June 2026. No admin action is required - users will see the updated experience automatically.

---

### General Availability - Support for passkeys in Microsoft Entra ID registration campaign

**Type:** General Availability  
**Service category:** MFA  
**Product capability:** Identity Security & Protection

Microsoft Registration Campaigns now supports Passkeys (FIDO2) as an authentication method. Administrators can configure registration campaigns to nudge users to register passkeys during sign-in, helping organizations drive passkey adoption at scale. This first rollout experience is optimized for users who are in a passkey profile that doesn't have any restrictions.

---

### Public Preview - Automate setting or clearing user attributes values in Lifecycle workflows

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance

We're excited to introduce the User Attribute Updates task in Lifecycle Workflows, extending existing attribute change trigger capabilities with a built-in, customer-ready way to automate attribute updates (set or clear values) directly within a workflow. With a secure, consistent, and auditable experience, organizations can reduce manual effort, improve governance, and scale identity automation with greater confidence.

---

### General Availability - System-preferred authentication expanded to first-factor in Microsoft Entra ID

**Type:** General Availability  
**Service category:** MFA  
**Product capability:** Identity Security & Protection

We're extending system-preferred authentication to apply to the **first factor** in Microsoft-managed configurations (in addition to second factor). With this change, the system evaluates the credentials registered for a user and selects the highest-ranked authentication method for each step of the sign-in flow.

As a result, users with strong, phishing-resistant credentials (such as passkeys) might be signed in **without needing to use a password**, improving both security and user experience.

This behavior applies only to the Microsoft-managed state, where system-preferred authentication now covers both first- and second-factor authentication. The rollout is currently in progress and will be fully deployed to all Microsoft-managed tenants by the end of June.

---

### General Availability - High Scale Compatibility (HSC) mode for Microsoft Entra External ID

**Type:** General Availability  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C

High Scale Compatibility (HSC) mode enables organizations to **migrate to Microsoft Entra External ID while preserving their existing user directory**. It's designed for large, established customer identity platforms transitioning from Azure AD B2C.

With HSC mode, customers can **rebuild applications on External ID** while maintaining continuity for existing users, supporting a **seamless, phased migration at scale**. Some advanced customization capabilities are limited in this mode and will continue to evolve. For more information, see: [Enable External ID High Scale Compatibility (HSC) mode](../external-id/customers/enable-external-id-high-scale-compatibility-mode.md).

---

### Expanded policy storage for passkeys (FIDO2) in Microsoft Entra ID

**Type:** Changed feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication

We increased the passkey (FIDO2) policy size limit in the authentication methods policy to a dedicated 20-KB allocation.

Previously, all authentication methods shared a single 20-KB policy size limit. With this update, a dedicated 20-KB limit is now allocated specifically to the passkey (FIDO2) policy, while the remaining authentication methods continue to use their existing limit.

This change helps address scenarios where tenants approach the overall policy size limit, which can block configuration of passkey profiles. By separating passkey policy storage, organizations can more easily adopt passkeys and configure advanced targeting scenarios.

In addition, the maximum number of passkey profiles per tenant has been increased from 3 to 10.

---

### Public Preview - Azure Role assignments can now be governed via Entitlement Management

**Type:** New feature  
**Service category:** Entitlement Management  
**Product capability:** Identity Governance  

You can now govern eligible and active assignments to Azure roles at the Management Group, Subscription, and Resource Group levels directly through access packages. This brings role assignment into the same request, approval, and lifecycle governance model as apps, groups, and more - making it easier to manage access to Azure resources at scale while aligning to least privilege and just-in-time access.

---

### General Availability - Manage Agent ID sponsorship lifecycle with Lifecycle Workflows

**Type:** General Availability  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance

One of the most important parts of governing agent identities is making sure that a delegated human user is always assigned to make sure the agent identity's access to resources are current. If the sponsor is leaving the organization, sponsorship of the agent identities is automatically transferred to their manager. With sponsorship transferred, there's always a human user accountable for managing the access and lifecycle of the agent identities. Microsoft Entra ID Governance features can help streamline this process within your organization. Lifecycle workflows include multiple tasks around notifying cosponsors, and managers of sponsors, of impending sponsorship changes. For a guide on setting up a workflow for agent identities sponsors, see: [Agent identity sponsor tasks in Lifecycle Workflows](../id-governance/agent-sponsor-tasks.md).

---


## April 2026

### General Availability - Microsoft Entra Agent ID platform

**Type:** General Availability  
**Service category:** Other  
**Product capability:** Identity Security & Protection  

The Microsoft Entra Agent ID platform is now generally available. The Agent ID platform provides an identity and authorization framework built specifically for AI agents operating in enterprise environments. It enables developers to create and manage agent identities with enterprise-grade authentication, authorization, and governance, using standard protocols such as OAuth 2.0, MCP, and A2A.

For more information, see: [What is Microsoft Entra Agent ID?](../agent-id/what-is-microsoft-entra-agent-id.md).

---

### Public Preview - Account Discovery

**Type:** Public Preview  
**Service category:** Provisioning  
**Product capability:** 3rd Party Integration  

Microsoft Entra ID Governance now supports account discovery for connected applications in public preview. This capability provides administrators with visibility into all accounts that exist within connected applications, including orphan accounts. 

By generating discovery reports directly from the provisioning experience, organizations can identify accounts in connected applications that aren't assigned to the enterprise application in Microsoft Entra and simplify onboarding the application. 

This capability requires a Microsoft Entra ID Governance or Microsoft Entra Suite license. Learn more: [https://aka.ms/accountDiscoveryDocumentation](https://aka.ms/accountDiscoveryDocumentation)

---

### Public Preview - Microsoft Entra ID federation with External ID (EEID)

**Type:** Public Preview  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** 3rd Party Integration  

Microsoft Entra ID federation with External ID (EEID) enables organizations to let users sign in to customer‑facing applications using their existing workforce Entra ID identities. By leveraging standards‑based federation, users authenticate with their home tenant while applications hosted in an External ID tenant rely on trusted identity assertions from Entra ID. This approach reduces the need for duplicate accounts, streamlines sign‑in experiences, and allows organizations to extend consistent security controls across workforce and customer scenarios. For more information, see: [Add a Microsoft Entra ID tenant as an OpenID Connect identity provider (Preview)](../external-id/customers/how-to-entra-id-federation-customers.md).

---

### Public Preview - App-based branding via Branding themes in Microsoft Entra tenants

**Type:** Public Preview  
**Service category:** User Experience and Management  
**Product capability:** User Authentication  

In Microsoft Entra tenants, customers can create a single, tenant-wide, customized branding experience that applies to all apps. We are introducing a concept of Branding "themes" to allow customers to create different branding experiences for specific applications.

---

### Upcoming Change - Migrate from Microsoft Entra Connect Sync to Microsoft Entra Cloud Sync

**Type:** Plan for change  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

As organizations look to strengthen identity security and advance their Zero Trust strategies, many are looking for simpler, more reliable ways to manage hybrid identity. To support these needs, we’re beginning the transition from [Microsoft Entra Connect Sync](../identity/hybrid/connect/whatis-azure-ad-connect-v2.md) to the cloud‑native [Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/what-is-cloud-sync.md) - helping reduce on‑premises complexity while improving security, reliability, and day‑to‑day manageability.  

This shift is a key step toward a cloud-managed identity future that will provide a more secure, resilient, and easier-to-operate synchronization experience. As part of ongoing modernization efforts, Microsoft’s strategy remains to deliver stronger security, improved reliability, and simpler identity operations.  

#### What's next

Beginning in July 2026, we will begin notifying customers through the M365 Message Center, Entra Connect Health, and targeted emails about their individual transition timelines. The transition will be rolled out in phases, and we will reach out directly to each organization when their assigned transition window begins. This phased approach ensures that we can provide tailored guidance and support to all our customers. 

*   **Initial phases:** In the first waves, we will focus on tenants for whom Entra Cloud Sync already meets all their identity synchronization needs. If your organization relies on advanced features or has a large directory, you will **_not_** be among the initial targeted groups. We will prioritize early transitions for customers with straightforward configurations that are fully supported by Entra Cloud Sync’s current capabilities. 

*   **Subsequent phases:** As Entra Cloud Sync’s capabilities expand, we will progressively notify the later groups and ensure they can transition successfully once equivalent support is available in Entra Cloud Sync 

We are committed to supporting you by providing tooling and documentation for the transition to Entra Cloud Sync. 

#### What's changing

Once your organization is notified of its assigned transition window, you will receive detailed guidance and resources to help you begin the move to Entra Cloud Sync. During this period: 

*   You will have review your current configuration, assess readiness, and familiarize yourself with Cloud Sync’s capabilities. 

*   You will gain access to the transition tool and step-by-step documentation to support a smooth transition. 

*   You will move and test your synchronization environment in Entra Cloud Sync before any permanent changes are made.  

Once your transition to Entra Cloud Sync is successfully completed: 

*   Entra Cloud Sync will be the primary mechanism for identity synchronization capabilities between Active Directory and Entra ID, replacing the identity sync functionality in Entra Connect tool. 

#### What's not changing

Once you migrate to Cloud Sync, your hybrid authentication features that enable on‑premises credentials to be used for accessing cloud resources will continue to be available after migration on the Connect Sync config wizard.

**Start preparing today**

We recommend that you take steps to begin your migration. You can begin familiarizing yourself with [Entra Cloud Sync](../identity/hybrid/cloud-sync/what-is-cloud-sync.md) and review our dedicated resources to ensure a smooth transition: 

*   [Cloud Sync deep dive – how it works](../identity/hybrid/cloud-sync/concept-how-it-works.md) 
*   [Step-by-step migration guidance](../identity/hybrid/cloud-sync/migrate-azure-ad-connect-to-cloud-sync.md) 
*   Migration scenarios: 

*   [Migrate to Microsoft Entra Cloud Sync for a synced Active Directory forest](../identity/hybrid/cloud-sync/tutorial-pilot-aadc-aadccp.md) 
*   [Migrate Microsoft Entra Connect Sync Group Writeback v2 to Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/migrate-group-writeback.md) 
*   [Microsoft Entra Cloud Sync vs. Microsoft Entra Connect Sync feature comparison](../identity/hybrid/cloud-sync/connect-to-cloud-sync-decision-guide.md#comparison-between-microsoft-entra-connect-and-cloud-sync) 

Microsoft Entra supports Source of Authority (SOA) capabilities that allow you to shift user and group management to the cloud while continuing to operate existing Connect Sync deployments. These capabilities can help simplify environments, reduce long‑term dependency on on‑prem infrastructure, and improve readiness for future transitions. If this aligns with your identity strategy, the following resources may be helpful: 

*   IT Architect Guidance for SOA planning: [https://aka.ms/SOAITArchitectsGuidance](https://aka.ms/SOAITArchitectsGuidance) 
*   [User SOA](https://aka.ms/UserSOAdocs): Manage users directly in Entra ID while maintaining hybrid coexistence 
*   [Group SOA](https://aka.ms/GroupSOAdocs): Cloud‑managed groups with on‑premises impact where required 

This is not a prerequisite to move to Cloud Sync, but provides an opportunity to prepare at your own pace. 

Stay tuned to this page for further updates.

---

### Plan for change - Update SCIM provisioning applications to use modern authentication

**Type:** Plan for change  
**Service category:** Provisioning  
**Product capability:** Outbound to SaaS Applications  

#### What is changing


*   SCIM provisioning applications that use the OAuth 2.0 Authorization Code grant will be updated to support modern authentication methods, such as OAuth 2.0 Client Credentials and workload identity federation.
*   Existing provisioning jobs will not switch automatically. Customers will need to update job configuration after the new method is available.
*   A small number of applications that cannot support a modern method may be retired from the Microsoft Entra app gallery.

#### When this is changing


This change will roll out over the coming months, and timing will vary by application. We will share impacted applications, customer deadlines, and supporting documentation through monthly What’s new articles and the Microsoft 365 Message Center.

#### Why this is changing


This update strengthens the security of Microsoft Entra provisioning integrations by moving away from older authentication patterns. Modern methods are better suited for service-to-service scenarios and can reduce credential management overhead, including the need to rotate shared secrets.

#### Action required from customers


*   Identify existing provisioning jobs that use the OAuth 2.0 Authorization Code grant.
*   Watch for announcements about affected applications and availability of updated authentication methods.
*   Update and test provisioning job configuration when your application supports a modern authentication method.
*   If an application is retired, plan to migrate to a supported alternative.

#### Stay informed


Please monitor monthly What’s new articles and the Microsoft 365 Message Center for future announcements, migration guidance, deadlines, and documentation.

---

### Public Preview - $count filtering in sign-ins API

**Type:** Public Preview  
**Service category:** MS Graph  
**Product capability:** Monitoring & Reporting  

The ability to use $count in sign-ins API requests is now here, allowing customers to perform count computations directly in API requests. For more information, see: [Customize Microsoft Graph responses with query parameters](/graph/query-parameters).

---

### Plan for change - Switch from basic auth to workload identity based auth for SAP SuccessFactors provisioning integrations

**Type:** Plan for change  
**Service category:** Provisioning  
**Product capability:** Inbound to Entra ID  

Microsoft Entra is introducing workload identity–based authentication for SAP SuccessFactors provisioning. This new capability allows the Microsoft Entra provisioning service to authenticate to SAP SuccessFactors using Entra workload identity and short‑lived tokens instead of static credentials (username and password). 

This change helps customers transition to a more secure authentication model in preparation for SAP’s plan to [deprecate basic authentication for SuccessFactors APIs by November 2026](https://help.sap.com/docs/successfactors-release-information/8e0d540f96474717bbf18df51e54e522/fcc05a902b4140e585d968c2fe4a96bc.html). 

#### What's changing

*   A new authentication option will be available starting May 2026 in the SAP SuccessFactors provisioning apps to use Entra workload identity-based authentication instead of basic authentication. 
    
*   Customers can switch existing provisioning configurations from basic authentication to workload identity–based authentication directly through updated connectivity settings in the provisioning experience, without needing to recreate or restart their configuration. 
    
*   This method removes the need to store long-lived credentials and uses a standards-based authentication method between Entra and SAP SuccessFactors through SAP Cloud Identity Services. 
    
*   This capability applies to the following provisioning scenarios:  
    

*   [SAP SuccessFactors to Active Directory user provisioning](../identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md) 
    
*   [SAP SuccessFactors to Microsoft Entra ID user provisioning](../identity/saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md) 
    
*   [SAP SuccessFactors writeback (Entra to SuccessFactors)](../identity/saas-apps/sap-successfactors-writeback-tutorial.md) 
    

#### What this means for you

*   If you are currently using basic authentication for any of the above SAP SuccessFactors provisioning integrations, you must upgrade to workload identity-based authentication before November 2026 to ensure uninterrupted operation of the integrations. 
    
*   No immediate action is required, but we recommend planning your migration early to avoid last-minute disruption. 
    
 The new method improves security by:  
    

*   Eliminating stored passwords 
    
*   Using short-lived, verifiable tokens 
    
*   Aligning with SAP’s supported authentication model 
    

#### Recommended action

*   Evaluate the new authentication option once available in your tenant 
    
*   Plan and test migration of existing provisioning jobs to workload identity-based authentication 
    
*   Update any internal documentation or operational processes that reference basic authentication 
    

#### Additional information

Detailed configuration guidance and step-by-step instructions will be published in Microsoft Learn documentation.

---

### General Availability - Prefetch Workday termination data to customize account disable logic

**Type:** General Availability  
**Service category:** Provisioning  
**Product capability:** Inbound to Entra ID  

This Workday connector update resolves termination processing delays observed for workers in APAC and ANZ regions. Admins can now enable termination lookahead setting to prefetch data and tailor deprovisioning logic for accounts in Microsoft Entra ID and on-premises Active Directory. For more details, refer to: [https://aka.ms/WorkdayTerminationLookaheadDoc](https://aka.ms/WorkdayTerminationLookaheadDoc)

---

### General Availability - Microsoft Entra Certificate-based authentication (CBA) support on iOS and CBA as second factor

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Microsoft Entra Certificate-Based Authentication (CBA) is now generally available on iOS. Native iOS sign-ins now avoid unnecessary password and MFA prompts, enabling CBA as a supported second factor and allowing it to be prioritized as a system‑preferred MFA method. Users can choose another allowed MFA method if needed, based on tenant policy. More information at [Microsoft Entra certificate-based authentication on Apple devices](../identity/authentication/concept-certificate-based-authentication-mobile-ios.md)

---

### General Availability - Microsoft Identity Manager (MIM) 2016 Service Pack 3 (SP3)

**Type:** General Availability  
**Service category:** Microsoft Identity Manager  
**Product capability:** Identity Governance  

Microsoft Identity Manager (MIM) 2016 Service Pack 3 (SP3) is now available. SP3 focuses on stability and supportability, modernizes compatibility with current platform components (SQL Server, SharePoint, and Exchange), and adds an additional deployment option for the Synchronization Service by enabling Azure SQL Database with managed identity authentication—helping reduce operational risk for hybrid identity environments. 

Issues fixed and improvements added in this update  include 

#### MIM Synchronization Service

*   SQL Server 2022 Support:  Full support for installation with and connection to SQL Server 2022.  
    
*   Azure SQL Support: MIM Sync can now use Azure SQL Database, with authentication supported via both System Assigned and User Assigned Managed Identities. 
    

#### MIM Service and Portal

*   SQL Server 2022 and Exchange Server Subscription Edition (SE) Support: Updated integration and database compatibility with the latest SQL and Exchange releases.  
    
*   SharePoint Subscription Edition (SE) Support: The MIM Portal can now be deployed on SharePoint SE.  
    
*   System Center Service Manager Data Warehouse (DW) 2022 Support: Enables reporting and audit integration with the latest SCSM DW.    
    
*   Active Directory Federation Services (AD FS) Single Sign-On (SSO):  Introduces support for claims-based authentication, allowing end-users to sign in via AD FS instead of Windows Integrated Authentication 
    

#### Download and upgrade information

*   Based on your licensing, you can download the installer packages here: [Microsoft Identity Manager licensing and downloads | Microsoft Learn](/microsoft-identity-manager/microsoft-identity-manager-licensing#obtaining-windows-installer-packages) 
    
*   SP3 introduces a new upgrade process. Please follow the documented steps carefully: [Upgrade Microsoft Identity Manager 2016 from SP2 to SP3 | Microsoft Learn](/microsoft-identity-manager/microsoft-identity-manager-2016-upgrade-from-service-pack-2-to-service-pack-3)

---

### General Availability - As an AP requestor, I can see in My Access who my approver(s) are if the access package owner allows me to

**Type:** General Availability  
**Service category:** Entitlement Management  
**Product capability:** Entitlement Management  

In May, requestors will be able to see the name and email address of approvers for their pending access package requests directly in the My Access portal will be in General Availability. This feature improves transparency and helps streamline communication between requestors and approvers. At the tenant level, approver visibility is enabled by default for all members (non-guests) and can be controlled through the Entitlement Management settings in the Microsoft Entra Admin Center. At the access package level, admins and access package owners can configure the approver visibility and choose to override the tenant level setting under the advanced request settings in the access package policy. For more information, see: [View approver information for pending requests](../id-governance/entitlement-management-request-access.md#view-approver-information-for-pending-requests).

---

### General Availability - Entra CBA as third option in system-preferred MFA methods

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

General Availability - Due to known issues on iOS platform, the Entra certificate-based authentication (CBA) method was not allowed as a second factor on iOS and CBA was moved to the last place in the system-preferred MFA list as documented at [FAQ](../identity/authentication/concept-system-preferred-multifactor-authentication.md#faq). 

We've enhanced the user experience during sign-in with certificate in native iOS apps by removing unnecessary passwords and MFA prompts with all the known issues addressed. The feature enhancement enables us to support CBA as a second factor on iOS, and to move CBA to the third place in system preferred MFA methods.

---

### General Availability - GSA iOS client support

**Type:** General Availability  
**Service category:** iOS client  
**Product capability:** Network Access  

We are excited to announce the general availability of the iOS Global Secure Access (GSA) client. The Global Secure Access client on iOS and iPadOS requires no new agent installation. It leverages the existing Microsoft Defender for Endpoint (MDE) to route traffic through Microsoft SSE for Microsoft 365, internet access, and private access.

---

### General Availability - Entra CBA Certificate Authority (CA) scoping

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Entra CBA Certificate Authority (CA) scoping in Microsoft Entra allows tenant administrators to restrict the use of specific certificate authorities (CAs) to defined user groups. This feature enhances the security and manageability of certificate-based authentication (CBA) by ensuring that only authorized users can authenticate using certificates issued by specific CAs. More information at [Certificate Authority (CA) scoping](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#certificate-authority-ca-scoping)

---

### General Availability - Network Content Filtering based on File Types

**Type:** General Availability  
**Service category:** Internet Access  
**Product capability:** Network Access  

Global Secure Access supports network-based content filtering based on file types. This allows you to monitor and control file transfers across the network to GenAI and SaaS apps to prevent unauthorized exfiltration of content. For more information, see: [Create a content policy to filter network file content](../global-secure-access/how-to-network-content-filtering.md).

---

### General Availability - GSA Cloud Firewall for Remote Networks

**Type:** General Availability  
**Service category:** Internet Access  
**Product capability:** Network Access  

Customer can use GSA cloud firewall to apply admin configurable, 5-tuple (source IP, destination IP, protocol, source port, destination port) based filtering for all internet traffic acquired from branch offices through GSA remote networks capability. For more information, see: [Configure Global Secure Access cloud firewall](../global-secure-access/how-to-configure-cloud-firewall.md).

---

### General Availability – Enabling Social Identity Providers in Entra External ID Native Authentication via browser‑delegated (web‑view) flows using SDKs for applications

**Type:** General Availability  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** Developer Experience  

Build secure sign‑in and sign‑up experiences for applications in Entra External ID using Native Authentication, with Social Identity Provider support such as Google, Facebook, and Apple available through browser‑delegated (web‑view) authentication using developer‑friendly SDKs. For more information, see: [Native authentication in Microsoft Entra External ID](../identity-platform/concept-native-authentication.md).

---

### General Availability - Enforce Conditional Access policies like MFA on every PIM activation

**Type:** General Availability  
**Service category:** Privileged Identity Management  
**Product capability:** Privileged Identity Management  

Generally available feature for configuring reauthentication with Conditional Access for Microsoft Entra Privileged Identity Management role activation. For more information see: [On activation, require Microsoft Entra Conditional Access authentication context](../id-governance/privileged-identity-management/groups-role-settings.md#on-activation-require-microsoft-entra-conditional-access-authentication-context)


---

### General Availability - License Usage

**Type:** General Availability  
**Service category:** Reporting  
**Product capability:** Monitoring & Reporting  

The **License Usage** page in the Microsoft Entra admin center helps customers optimize their Entra licenses by providing visibility into feature usage across their tenant. It shows how many Entra ID P1, P2, and Suite licenses you own, along with usage of key features such as Conditional Access and risk‑based Conditional Access mapped to each license type. You can also review usage trends over the past six months. This view gives you a clearer understanding of your license footprint, the value you’re deriving from Entra, and potential over‑usage risks within your tenant. For more information, see: [Microsoft Entra license usage insights](../fundamentals/concept-license-usage-insights.md).

---

### General Availability - Issuer Hints for Microsoft Entra CBA

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

Issuer Hints is generally available now and helps improve the sign‑in experience for Entra Certificate‑Based Authentication (CBA) by ensuring users are prompted to select only certificates that are trusted and valid for their organization. This reduces confusion, minimizes sign‑in errors, and streamlines certificate selection especially on devices with multiple certificates installed. Issuers hints are designed to enhance both security and usability without changing how certificates are issued or managed. For more information, see: [Issuer hints](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#issuer-hints).

---

### General Availability - Configurable Token Lifetime Policies

**Type:** General Availability  
**Service category:** Authentications (Logins)  
**Product capability:** Platform  

Configurable token lifetime policies are now generally available in Microsoft Entra ID. This feature allows administrators to customize the lifetimes of access tokens, ID tokens, and SAML tokens issued by the Microsoft identity platform by creating and assigning token lifetime policies to applications and service principals.  

With configurable token lifetime policies, organizations can adjust token durations to meet their security and usability requirements -- for example, shortening access token lifetimes for sensitive applications or extending them for long-running automation scenarios. For more information, see: [Configurable token lifetimes in the Microsoft identity platform](../identity-platform/configurable-token-lifetimes.md).

---

## March 2026

### Plan for change – Agent Registry consolidation into Microsoft Agent 365

**Type:** Plan for change  
**Service category:** Other  
**Product capability:** Directory    

We’re consolidating agent management experiences to make it easier to observe, govern, and secure all agents in your tenant. Agent 365 will be the single source of truth, offering a unified catalog, consistent visibility, and simplified management.

**What’s changing**

*   The Agent registry and Agent collections blades in the [Entra admin center](https://entra.microsoft.com/) will be retired on May 1, 2026.  
*   No action is required by administrators. Agent functionality and management remain unaffected. You can still access the agent inventory in the [All agents view within the Microsoft 365 admin center (MAC)](https://admin.microsoft.com/Adminportal/Home#/homepage).  

**With this change:**

*   Agent 365 becomes the unified registry and control plane for agents.  
*   Microsoft Entra continues to provide the identity foundation through Agent ID.  
*   The existing [registry Graph API](/graph/api/resources/agentregistry) will be deprecated and replaced by a new API powered by Agent 365. Agents registered via the current API will need to be re-registered. We’ll follow up soon with details on the deprecation date and the availability of the new registry Graph API.  
*   All agent access and governance capabilities remain fully available through Agent ID and Agent 365.  

For more information, see: [Agent Registry convergence with Microsoft Agent 365](../agent-id/agent-registry-convergence.md).

---

### Public Preview - Microsoft Entra Backup and Recovery is now available

**Type:** Public Preview  
**Service category:** Entra Backup and Recovery  
**Product capability:** Entra Backup and Recovery  

Microsoft Entra Backup and Recovery is a built-in solution to help restore your tenant after accidental changes or malicious updates. Always on by default, it automatically backs up critical directory objects — including users, groups, applications, service principals, managed identities, conditional Access policies, named locations, agent IDs, and authentication and authorization policy, so admins can quickly restore them to a previously known good state.

At preview, Entra Backup and Recovery automatically takes daily backup of a tenant’s supported directory objects. If a tenant has Microsoft Entra ID P1 or P2 licenses, one backup is taken each day and retained for five days. Admins can view available snapshots, generate difference reports to understand what has changed, and run recovery jobs to restore objects to a prior state.

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

SCIM 2.0 APIs give customers, developers, and partners a standards-based option for managing users and groups in Microsoft Entra using the System for Cross-domain Identity Management (SCIM) 2.0 specification. For more information, see: [Enable Microsoft Entra SCIM 2.0 APIs](https://aka.ms/EnableEntraSCIMAPI).

---

### Public Preview - Cross-tenant security group synchronization

**Type:** Public Preview  
**Service category:** Provisioning  
**Product capability:** Collaboration  

We’re introducing cross-tenant group synchronization, a new capability that allows organizations to synchronize security groups across Microsoft Entra tenants. This feature enables centralized management of group membership in a source tenant while making those groups available in one or more target tenants, simplifying cross-tenant collaboration and reducing administrative overhead associated with managing duplicate groups.

With cross-tenant group synchronization, organizations can extend their existing cross-tenant synchronization configurations to include groups, supporting scenarios such as shared application access, resource authorization, and consistent group-based access control across tenants. Admins can opt in to this functionality and configure attribute mappings and cross-tenant access policies to enable group synchronization into target tenants. Use of cross-tenant group synchronization requires Microsoft Entra ID Governance licenses. Existing licensing requirements for cross-tenant user synchronization features remains unchanged. For more information, see: [What is cross-tenant synchronization?](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md).

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

This feature allows admins to request and accept tenant governance relationships, which grant admins of the governing tenant access and administrative control over the governed tenant. For more information, see: [Microsoft Entra tenant governance documentation (preview)](~/id-governance/tenant-governance/overview.md).

---

### Public Preview - Related Tenants

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

This feature allows admins to discover related tenants connected to their own by B2B activity or shared billing information. Admins can use this information to request and establish tenant governance relationships, or to quarantine potential risks. For more information, see: [Microsoft Entra tenant governance documentation (preview)](~/id-governance/tenant-governance/overview.md).

---

### Public preview - Tenant configuration management administration portal experience

**Type:** Public Preview  
**Service category:** Tenant Governance  
**Product capability:** Tenant Governance  

Now you can use the Entra admin center to administer tenant configuration management capabilities of Entra tenant governance. You can use this experience to:  

- Create and update monitors that enable you to define the desired state of resources in your tenant across a range of Microsoft services, and monitor the actual state of those resources relative to the desired state on an ongoing basis
- See reports of monitor results, and details of any configuration drifts identified by the configuration management service when it runs a monitor that you defined.
- Manage permission for the configuration management service to monitor resources in your tenant, by assigning app permissions or Entra roles. 

For more information, see [Tenant configuration management docs](../id-governance/tenant-governance/configuration-management.md)

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

Permissioned users can now create add-on tenants that are owned and governed by their home tenant. Governance is established through tenant governing relationships, granting admins access and control via GDAP. For more information, see: [Microsoft Entra tenant governance documentation (preview)](~/id-governance/tenant-governance/overview.md).

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

*   Enable [TLS 1.2](/troubleshoot/entra/entra-id/ad-dmn-services/enable-support-tls-environment) support in your environment

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

Starting in April 2026, the Authentication Methods Policy Update and Authentication Methods Policy Reset audit log activities has been updated to improve readability and clarity. Previously, audit logs included the full authentication methods policy payload in both the old and new values, even when only a small number of settings were changed. With this update, audit log entries now surface only the specific properties that were modified, along with their corresponding old and new values.

Policy-wide updates—such as Registration Campaigns and System‑preferred authentication—may continue to include the full policy payload. The activity name and triggering events remain unchanged. This update affects formatting only and does not change policy behavior. For more information, see: [Core Directory](../identity/monitoring-health/reference-audit-activities.md#core-directory).

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

Similar to Microsoft Entra ID (workforce tenants), Microsoft Entra External ID (external tenants) now supports device authorization grant flow, which allows users to sign in to input-constrained devices such as a smart TV, IoT device, or a printer. For more information, see [OAuth 2.0 device authorization grant](../identity-platform/v2-oauth2-device-code.md).

---

### General Availability - Sign-in with username/alias

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

In Microsoft Entra External ID (EEID), users who authenticate with a local email and password now can also sign in using a username (alias) as an alternate sign-in identifier. This alias can represent a customer or member ID, insurance number, frequent flyer number, or a self-chosen username. The alias can be collected from user or assigned during self-service sign-up, or assigned during user creation or user update via the Microsoft Graph API or Microsoft Entra admin center. For details, see [Sign in with alias](../external-id/customers/how-to-sign-in-alias.md).

---

### Upcoming change – Microsoft Entra Connect security update to block hard match for users with Microsoft Entra roles

**Type:** Plan for change  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

**What is Hard-matching in Microsoft Entra Connect Sync and Cloud Sync?**

When Microsoft Entra Connect or Cloud Sync adds new objects from Active Directory, the Microsoft Entra ID service tries to match the incoming object with an Entra object by looking up the incoming object’s sourceAnchor value against the OnPremisesImmutableId attribute of existing cloud managed objects in Microsoft Entra ID. If there's a match, Microsoft Entra Connect or Cloud Sync takes over the source or authority (SoA) of that object and updates it with the properties of the incoming Active Directory object in what is known as "hard-match." 

To strengthen the security posture of your Microsoft Entra ID environment, we are introducing a change that will restrict certain types of hard-match operations by default.   
  

**What’s changing**

Beginning **June 1, 2026**, Microsoft Entra ID will block any attempt by Entra Connect Sync or Cloud Sync from hard-matching a new user object from Active Directory to an existing cloud-managed Entra ID user object that holds [Microsoft Entra roles](../identity/role-based-access-control/permissions-reference.md).

**This means**:

- If a cloud managed user already has [onPremisesImmutableId (sourceAnchor)](..//identity/hybrid/connect/plan-connect-design-concepts.md#sourceanchor) set and is assigned a Microsoft Entra role, Microsoft Entra Connect Sync or Cloud Sync will no longer be able to take over the Source of Authority of that user by hard-matching with an incoming user object from Active Directory.
- This safeguard prevents attackers from taking over privileged cloud managed users in Entra by manipulating attributes of user objects in Active Directory.
    

**What’s not changing**

- Hard match operations for cloud users without Microsoft Entra roles are not affected.   
- [Soft match](../identity/hybrid/connect/how-to-connect-install-existing-tenant.md?source=recommendations#hard-match-vs-soft-match) behavior isn't affected.
- Ongoing sync from Active Directory to Entra ID for previously hard-matched objects will not be affected.   
    

**Customer action required**

If you encounter a hard match error after June 1, 2026, see our [documentation](../identity/hybrid/connect/tshoot-connect-sync-errors.md#existing-admin-role-conflict) for mitigation steps.

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

In addition to the [global banned password lists](../identity/authentication/concept-password-ban-bad.md#global-banned-password-list) already supported, EEID admins can now add specific strings to block during password creation and reset. For more information, see [Password Protection - Custom banned password lists](../identity/authentication/concept-password-ban-bad.md#custom-banned-password-list).

---

### Upcoming Changes – Jailbreak/root Detection in Authenticator App

**Type:** New feature  
**Service category:** Microsoft Authenticator App  
**Product capability:** Identity Security & Protection  

Starting February 2026, Microsoft Authenticator will introduce jailbreak/root detection for Microsoft Entra credentials in the Authenticator app. The rollout progresses from warning mode → blocking mode. Users must move to compliant devices to continue using Microsoft Entra accounts in Authenticator.

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

When you configure policies blocking your users from accessing a risky, NSFW, or unsanctioned sites or apps in GSA, they receive a clear HTML error message with Microsoft Entra Internet Access branding. We’ve heard from many admins that they’d like to start customizing that experience with text aligned to a company style guide, callouts to company Terms of Use documentation, hyperlinks to IT workflows, and more. 

Global Secure Access now offers customized block pages for Internet Access. In the Microsoft Graph API, Admins can now:

- Configure the  tenant-wide body text of the GSA block page.
- Add hyperlinks via limited markdown to reference Terms of Use,  ServiceNow/IT ticketing services, or even MyAccess for ID Governance workflow integration. 

For more information, see: [How to Customize Global Secure Access Block Page](../global-secure-access/how-to-customize-block-page.md).

---

### General Availability - Microsoft Entra Connect Sync now supports Windows Server 2025

**Type:** New feature  
**Service category:** Entra Connect  
**Product capability:** Entra Connect  

Microsoft Entra Connect Sync now officially supports [Windows Server 2025](https://www.microsoft.com/evalcenter/download-windows-server-2025). This means you can confidently install and run Microsoft Entra Connect Sync on servers running Windows Server 2025, enabling your hybrid identity environment to take full advantage of the latest Windows Server enhancements.

**What this means for you:** With this update, organizations can upgrade their identity synchronization servers to Windows Server 2025 without hesitation. Windows Server 2025 brings advanced features that improve security, performance, and flexibility, and our engineering team has thoroughly validated Microsoft Entra Connect Sync on this platform. Many customers have been eager to adopt Windows Server 2025 to leverage its enhanced security, better performance, and improved management capabilities. Now, with official support in place, you can benefit from these improvements while maintaining a reliable, fully supported hybrid identity solution.

The Microsoft Entra Connect Sync .msi installation file is exclusively available on Microsoft Entra admin center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details on available versions.

**Consider moving to Cloud Sync:** Microsoft Entra Cloud Sync is a sync client that works from the cloud and allows customers to set up and manage their sync preferences online. We recommend that you use Cloud Sync because we're introducing new features that improve the sync experiences through Cloud Sync. You can avoid future migrations by choosing Cloud Sync if that's the right option for you. Use the [supported sync scenarios comparison](../identity/hybrid/common-scenarios.md) to see if Cloud Sync is the right sync client for you.

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

By end of March Microsoft Entra ID Governance approvers can now revoke access to an access package after an approval has already been granted. This gives approvers greater control to respond to changes, mistakes, or updated business needs. With this update, an approver can undo a prior approval decision, immediately removing the requestor’s access to the access package. Only the approver who originally approved the request can revoke it, even if multiple approvers belong to the same approver group. For more information, see: [Revoke a request](../id-governance/entitlement-management-request-approve.md#revoke-a-request).

---

## January 2026

### General Availability - Ability to convert Source of Authority of synced on-premises AD users to cloud users is now available 

**Type:** New feature  
**Service category:** User Management  
**Product capability:** Microsoft Entra Cloud Sync

We’re pleased to announce the general availability of object-level Source of Authority (SOA) switching for Microsoft Entra ID. With this feature, administrators can transition individual users from being synced with Active Directory (AD) to becoming cloud-managed accounts within Microsoft Entra ID. These users are no longer tied to AD sync and behave like native cloud users, giving you greater flexibility and control. This capability enables organizations to gradually reduce dependence on AD and simplify migration to the cloud, all while minimizing disruption for users and daily operations. Both Microsoft Entra Connect Sync and Cloud Sync fully support this SOA switch, ensuring a smooth transition process.

For more information, see: [Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud](../identity/hybrid/user-source-of-authority-overview.md).

---

### General Availability - Microsoft Entra ID Governance guest billing meter enforcement

**Type:** New feature  
**Service category:** Entitlement Management, Lifecycle Workflows  
**Product capability:** Entitlement Management, Lifecycle Workflows

Enforcement for the Microsoft Entra ID Governance guest billing meter is now in effect for Entitlement Management and Lifecycle Workflows (Access Reviews will be enforced later in CY26 Q1). To keep using Entra ID Governance premium features for guest users in workforce tenants, you must link a valid Azure subscription to activate the Microsoft Entra ID Governance for guests add-on. If a subscription isn’t linked, creation or updates of new guest-scoped governance configurations will be restricted (for example, certain access package policies, access reviews, and lifecycle workflows), and guest-specific governance actions may fail until billing is configured.

For more information, see: [Microsoft Entra ID Governance licensing for guest users](../id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md).

---

### General Availability - Client Credentials in Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management     
**Product capability:** B2B/B2C    

We are pleased to announce the general availability of client credentials in Entra External ID.  The OAuth 2.0 client credentials grant flow permits a web service (confidential client) to use its own credentials, instead of impersonating a user, to authenticate when calling another web service. Permissions are granted directly to the application itself by an administrator.

Billing: When you configure machine-to-machine (M2M) authentication for Microsoft Entra External ID, you must use the [M2M Premium add‑on](https://www.microsoft.com/security/pricing/microsoft-entra-external-id/). Review your organization’s premium add‑on usage policy to understand cost implications and ensure the implementation complies with internal governance and licensing guidelines. For more information, see: [Microsoft identity platform and the OAuth 2.0 client credentials flow](../identity-platform/v2-oauth2-client-creds-grant-flow.md).

---

### General Availability - App-based branding via Branding themes in Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

In Entra External ID (EEID), customers can create a single, tenant-wide, customized branding experience that applies to all apps. We're introducing a concept of Branding "themes" to allow customers to create different branding experiences for specific applications. A new Live Preview feature also helps quickly visualize the changes before saving. For more information, see: [Customize the sign‑in experience for your application with branding themes](how-to-customize-branding-themes-apps.md).

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

---
title: Microsoft Entra releases and announcements
description: Learn what is new with Microsoft Entra, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
author: owinfreyATL
manager: dougeby
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 10/30/2025
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

> Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.


## January 2026

### General Availability - Ability to convert Source of Authority of synced on-prem AD users to cloud users is now available 

**Type:** New feature  
**Service category:** User Management  
**Product capability:** Microsoft Entra Cloud Sync

We’re pleased to announce the general availability of object-level Source of Authority (SOA) switching for Microsoft Entra ID. With this feature, administrators can transition individual users from being synced with Active Directory (AD) to becoming cloud-managed accounts within Microsoft Entra ID. These users are no longer tied to AD sync and behave like native cloud users, giving you greater flexibility and control. This capability enables organizations to gradually reduce dependence on AD and simplify migration to the cloud, all while minimizing disruption for users and daily operations. Both Microsoft Entra Connect Sync and Cloud Sync fully support this SOA switch, ensuring a smooth transition process.

For more information, see: [Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud](../identity/hybrid/user-source-of-authority-overview.md).

---

### General Availability - Entra ID Governance guest billing meter enforcement

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

As part of ongoing security hardening, Microsoft has implemented new safeguards to block account takeover attempts via hard match abuse in Microsoft Entra Connect (known as SyncJacking). Enforcement of this change begins in March 2026. 

What’s Changing: 

- Enforcement logic now checks OnPremisesObjectIdentifier to detect and block remapping attempts. 
    
- Audit logs have been enhanced to capture changes to OnPremisesObjectIdentifier and DirSyncEnabled. 
    
- Admin capability added to clear OnPremisesObjectIdentifier for legitimate recovery scenarios. 

Customer Action Required: 

- Upgrade to the latest Microsoft Entra Connect version. 
    
- Review updated hardening guidance and enable recommended flags:  
    
- Disable [hard match takeover](https://learn.microsoft.com/powershell/module/microsoft.entra.directorymanagement/set-entradirsyncfeature?view=entra-powershell) 
    

Additional Guidance: 

- If enforcement blocks an operation, you'll see the following error message: “Hard match operation blocked due to security hardening. Review OnPremisesObjectIdentifier mapping.” 
    
- Use audit logs to identify which objects are currently impacted. Specifically, look for audit events where OnPremisesObjectIdentifier or DirSyncEnabledwas modified. 
    
- For legitimate recovery, you can clear and reset OnPremisesObjectIdentifier using the following Microsoft Graph API: 
    

Request: `PATCH https://graph.microsoft.com/beta/users/<UserId>`

Body:


```
{
onPremisesObjectIdentifier: null
}
```

This change will take effect on Microsoft Entra service side so it's independent of your sync client. 

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on Microsoft Entra admin center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).  Check our [version history page](/entra/identity/hybrid/connect/reference-connect-version-history) for more details on available versions.

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

You can now enable the B2B guest access feature for your guest users with the Global Secure Access client, signed in to their home organization's Microsoft Entra ID account. The Global Secure Access client automatically discovers partner tenants where the user is a guest and offers the option to switch into the customer's tenant context. The client routes only private traffic through the customer's Global Secure Access service. For more information, see: [Learn about Global Secure Access B2B Guest Access (Preview)](../global-secure-access/concept-b2b-guest-access.md).

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

**Self-remediation for passwordless users:** Risk-based access policies in Microsoft Entra Conditional Access now support self-remediation of risks across all authentication methods, including passwordless ones. This new control revokes compromised sessions in real-time, enables frictionless self-service, and reduces help-desk load. For more information, see: [Require risk remediation with Microsoft-managed remediation (preview)](../id-protection/concept-identity-protection-policies.md#require-risk-remediation-with-microsoft-managed-remediation-preview).

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

Microsoft Entra agent registry is a centralized metadata store of all deployed agents in an organization. As AI agents increasingly handle data retrieval, orchestration, and autonomous decision‑making, enterprises face rising security, compliance, and governance risks without clear visibility or control. Microsoft Entra agent registry, part of Microsoft Entra agent id, solves this by providing an extensible repository that delivers a unified view of every agent across Microsoft and non‑Microsoft ecosystems — enabling consistent discovery, governance, and secure collaboration at scale. For more information, see: [What is the Microsoft Entra Agent Registry?](../agent-id/identity-platform/what-is-agent-registry.md).

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
- [Microsoft Entra documentation](https://learn.microsoft.com/entra/) 

- [Microsoft Entra Global Secure Access](https://learn.microsoft.com/entra/global-secure-access/) 

- [Microsoft Defender for Cloud Apps overview](https://learn.microsoft.com/defender-cloud-apps/)

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

Starting February 2026, we are replacing the current “*Revoke multifactor authentication sessions*” button with the “*Revoke sessions*” button in the MicrosoftEntra portal.

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
 
In Microsoft Entra External ID (EEID), customers can create a single, tenant-wide, customized branding experience that applies to all apps. We're introducing a concept of Branding "*themes*" to allow customers to create different branding experiences for specific applications. For more information, see [https://learn.microsoft.com/en-us/entra/external-id/customers/how-to-customize-branding-themes-apps](/entra/external-id/customers/how-to-customize-branding-themes-apps)

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

In Microsoft Entra External ID (EEID), users with a local email+password credential can sign in with email address as identifier.  We are adding the ability for these users to sign in with an alternative identifier such as customer/member id, for example insurance number, frequent flier number assigned via Graph API or Microsoft Entra admin center. For more information, see [Sign in with an alias or username (preview)](/entra/external-id/customers/how-to-sign-in-alias).

---

### Deprecation - Iteration 2 beta APIs for Microsoft Entra PIM will be retired. Migrate to Iteration 3 APIs. 

**Type:** Deprecated   
**Service category:** Privileged Identity Management    
**Product capability:** Identity Governance   

**Introduction**

Starting Oct 28, 2026, all applications and scripts making calls to Microsoft Entra Privileged Identity Management (PIM) [Iteration 2](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta) (beta) APIs for Azure resources, Microsoft Entra roles and Groups will fail.

**How this will affect your organization**

After Oct 28, 2026, any applications or scripts calling Microsoft Entra PIM Iteration 2 (beta) API endpoints will fail. These calls will no longer return data, which might disrupt workflows or integrations relying on these endpoints. These APIs were released in beta and are being retired, Iteration 3 are generally available (GA) APIs which offer improved reliability and broader scenario support.

**What you need to do to prepare**

We strongly recommend migrating to the **Iteration 3 (GA) APIs**, which are generally available. 

- Begin migration planning and testing as soon as possible.
- Halt any new development using Iteration 2 APIs.
- Review documentation for Iteration 3 APIs to ensure compatibility.

Learn more: 

- [API concepts in Privileged Identity management - Microsoft Entra ID Governance | Microsoft Learn](../id-governance/privileged-identity-management/pim-apis.md)
- [Privileged Identity Management iteration 2 APIs](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta)
- [Migrate from PIM iteration 2 APIs to PIM iteration 3 APIs](/graph/api/resources/privilegedidentitymanagement-root?view=graph-rest-beta#migrate-from-pim-iteration-2-apis-to-pim-iteration-3-apis)

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

For more information, see: [Learn about Global Secure Access B2B Guest Access (Preview) - Global Secure Access | Microsoft Learn](../global-secure-access/concept-b2b-guest-access.md).

---

### Public Preview - Global Secure Access Internet profile support for iOS client

**Type:** New feature    
**Service category:** Internet Access    
**Product capability:** Network Access    

Kerberos SSO experience for users on mobile devices with Global Secure Access is now supported. On iOS, create and deploy profile for Single sign-on app extension, see: [Single sign-on app extension](/intune/intune-service/configuration/ios-device-features-settings#single-sign-on-app-extension). On Android. You need to install and configure a 3rd party SSO client.

---

## September 2025

### Public Preview - Convert Source of Authority of synced Active Directory users to the cloud

**Type:** New feature  
**Service category:** User Management  
**Product capability:** Microsoft Entra Connect and Microsoft Entra Cloud Sync

The Source of Authority (SOA) at the object level allows administrators to convert specific users synced from Active Directory (AD) to Microsoft Entra ID into cloud-editable objects, which are no longer synced from AD and act as if originally created in the cloud. This feature supports a gradual migration process, decreasing dependencies on AD while aiming to minimize user and operational impact. Both Microsoft Entra Connect Sync and Cloud Sync recognize the SOA switch for these objects. The option to switch the SOA of synced users from AD to Microsoft Entra ID is currently available in Public Preview. For more information, see: [Embrace cloud-first posture: Transfer user Source of Authority (SOA) to the cloud (Preview)](../identity/hybrid/user-source-of-authority-overview.md).

---

### Public Preview - Use SMS as a verification method in password reset flows in Microsoft Entra External ID 

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management        
**Product capability:** B2B/B2C    

We’re excited to announce the **public preview of SMS for self-service password reset (SSPR) in Microsoft Entra External ID**. This change is actively rolling out to all tenants in production by end of October. 

**What’s New**

- **SMS Authentication for Password Reset:** End users can now verify their identity via SMS when using the *“forgot password”* or self-service password reset flow. Previously, only email one-time passcodes were supported.

- **Enhanced Security:** If users have two or more registered methods for password reset, they'll now be required to verify their identity with at least two methods, adding an extra layer of protection.

- **Fraud Protection:** With built-in integration to the Phone Reputation platform, telephony activity is processed in real time to identify risks. Each request is returned with an Allow, Block, or Challenge decision to help protect against telephony fraud.

- **Billing:** SMS for password reset is a part of add-on feature with tiered pricing based on location/region. Charges per SMS include the fraud protection services. For more information, see:  [SMS pricing tiers by country/region](../external-id/customers/concept-multifactor-authentication-customers.md#sms-pricing-tiers-by-countryregion).

---

### Public Preview - Microsoft Security Copilot Access Review Agent in Microsoft Entra

**Type:** New feature    
**Service category:** Access Reviews        
**Product capability:** Identity Governance    

Say goodbye to time-consuming research and the uncertainty of rushed decisions. With the public preview of the [Microsoft Security Copilot Access Review Agent in Microsoft Entra](https://aka.ms/ARAgent), we’re bringing the power of AI directly into the heart of access governance.

The agent works for your reviewers by automatically gathering insights and generating recommendations to help them make fast, accurate access decisions. Reviewers are guided through a natural, conversational flow right inside Microsoft Teams, so they can make the final call with confidence and clarity.

---

### General Availability - Cross-tenant synchronization (cross-cloud)

**Type:** New feature    
**Service category:** Provisioning        
**Product capability:** Collaboration    

Automate creating, updating, and deleting users across tenants across Microsoft clouds. The following combinations are supported:

*   Commercial -> US Gov
*   US Gov -> Commercial
*   Commercial -> China

For more information, see: [Configure cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md)

---

### General Availability - Dedicated new 1st party resource application to enable AD to Microsoft Entra ID sync using Microsoft Entra Connect Sync or Cloud Sync

**Type:** Plan for change    
**Service category:** Microsoft Entra Connect    
**Product capability:** Microsoft Entra Connect    

As part of ongoing security hardening, Microsoft has deployed a dedicated first-party application to enable the synchronization between Active Directory and Microsoft Entra ID. This new application will manifest as a first party service principal called the "Microsoft Entra AD Synchronization Service" (Application ID: 6bf85cfa-ac8a-4be5-b5de-425a0d0dc016) and will be visible in the Enterprise Applications experience within the Microsoft Entra admin center. This application is critical for the continued operation of on-premises to Microsoft Entra ID synchronization functionality through Microsoft Entra Connect.

Microsoft Entra Connect now uses this first party application to synchronize between Active Directory and Microsoft Entra ID. Customers are required to upgrade to version **2.5.79.0** or later by **September 2026**. 

We auto-upgrade customers where supported. For customers who wish to be auto-upgraded, [ensure that you have auto-upgrade configured](../identity/hybrid/connect/how-to-connect-install-automatic-upgrade.md).  

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on Microsoft Entra admin center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details on available versions.

---

### Public Preview - App management policies portal experience

**Type:** New feature    
**Service category:** Enterprise Apps    
**Product capability:** Directory    

App management policies allow administrators to improve the security of their organization by setting rules on how applications in their organization can be configured. They can use them to block insecure configurations like password credentials. These policies have been available through the Microsoft Graph API, but can now also be configured using the Microsoft Entra admin center, under the Enterprise applications experience.

Learn more about [how to configure app management policies](https://aka.ms/app-mgmt-policy-ux-docs).

---

### Public Preview - Delegate approvals in My Access

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

Users can now delegate their access package approvals in My Access. Approvers can assign another individual to respond to access package approval requests on their behalf. The original approvers can still respond to their approvals during the delegation period.  

> [!NOTE]
> This feature currently applies only to access package approvals and will be expanded to support access reviews in November 2025.  
  
For more information, see: [Delegate approvals in My Access](../id-governance/delegate-approvals-my-access.md).

---

### Public Preview - Reprocess failed users and workflows in Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Lifecycle Workflows now supports reprocessing of your workflows to help organizations streamline the reprocessing of workflows when errors or failures are discovered. This feature includes the ability to reprocess previous runs of workflows including failed runs or just runs that you might want to process again. Customers can choose from the following options to fit their needs:

- Select specific workflow run to be reprocessed
- Select which users from the workflow run to be reprocessed. For example either failed users, or all users from the run

For more information, see: [Reprocess workflows](../id-governance/reprocess-workflow.md)

---

### Public Preview - Trigger workflows for inactive employees and guests in Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Lifecycle Workflows now enables customers to configure custom workflows to proactively manage dormant user accounts by automating identity lifecycle actions based on sign-in inactivity. After detecting inactivity, the workflow automatically executes predefined tasks—such as sending inactivity notifications, disabling accounts, or initiating offboarding—for users that exceed the inactivity threshold. Admins can configure the inactivity threshold and scope, ensuring dormant accounts are handled efficiently and consistently - reducing security exposure, reducing license waste, and enforcing governance policies at scale.

For more information, see: [Manage inactive users using Lifecycle Workflows (Preview)](../id-governance/lifecycle-workflow-inactive-users.md).

---

### Retirement - Microsoft Authentication Library to MSAL Recommendations API

**Type:** Deprecated    
**Service category:** Other    
**Product capability:** Developer Experience    

We’re retiring the **ADAL to MSAL Recommendations API** on **December 15, 2025**.

To continue monitoring authentication library usage, customers can query sign-in logs manually via **Microsoft Graph API**. The relevant data is available in the `authenticationProcessingDetails` field under the key `"Azure AD App Authentication Library"`.

For guidance, see:

*   [Analyze a sign-in with Microsoft Graph API](/azure/azure-monitor/reference/tables/aadnoninteractiveusersigninlogs)

No action is required to disable the API.

---

### Deprecation - Automatically capture sign-in fields for an app in Microsoft Entra admin center. 

**Type:** Deprecated    
**Service category:** My Apps    
**Product capability:** Platform    

The “*Automatically capture sign-in fields for an app*” option in the Microsoft Entra admin center is retired. Existing apps already configured with this feature continues to work, but it will no longer be available for new configurations. Going forward, admins should use the “*Capture sign-in fields for an app*”. This requires the MyApps Secure Sign-In Extension, available for Microsoft Edge and Chrome. 

For more information, see: [Capture sign-in fields for an app](../identity/enterprise-apps/troubleshoot-password-based-sso.md#capture-sign-in-fields-for-an-app) 

To learn about our passwordless strategy, see:[Passwordless is here and at scale](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/passwordless-is-here-and-at-scale/2810639).

---

### Public Preview - Global Secure Access Internet profile support for iOS client

**Type:** New feature    
**Service category:** Internet Access    
**Product capability:** Network Access    

We're excited to announce the Internet Access support with iOS app. This feature protects access to internet and SaaS apps with an identity-based Secure Web Gateway (SWG), blocking threats, unsafe content, and malicious traffic from the iPhones and iPads.

Global Secure Access client on mobile platforms requires no new agent installation/deployment for secure access to their resources, and uses existing MDE (Microsoft Defender for Endpoint) to route traffic through Microsoft SSE for both Microsoft 365, internet access and private access.

For more information, see: [Global Secure Access client for iOS (Preview)](../global-secure-access/how-to-install-ios-client.md).

---

### Public Preview - Basic HTML support in Lifecycle Workflow custom email notifications

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Now customers can further customize their Lifecycle workflows email notifications to personalize, or emphasize, specific information using basic HTML elements. Email notifications can now be customized to include sending links using HTML hyperlinks and basic text formatting like bold, italics, and underline. For more information, see: [Customize emails sent from workflow tasks](../id-governance/customize-workflow-email.md).

---

### Public Preview - Microsoft Entra Internet Access Custom Block Pages

**Type:** New feature    
**Service category:** Microsoft Entra Internet Access 
**Product capability:** Network Access

When administrators configure policies that block users from accessing risky, NSFW, or unsanctioned sites or apps in Global Secure Access (GSA), users receive a clear HTML error message branded with Microsoft Entra Internet Access. Many administrators have expressed interest in customizing this experience to align with company style guides, include references to Terms of Use, add hyperlinks to IT workflows, and more.
Global Secure Access now supports customized block pages for Internet Access. Through the Microsoft Graph API, administrators can:

- Configure the tenant-wide body text of the GSA block page.
- Add hyperlinks using limited markdown to reference resources such as Terms of Use, ServiceNow/IT ticketing systems, or MyAccess for identity governance workflow integration.

For more information, see: [How to customize Global Secure Access block page (preview)](../global-secure-access/how-to-customize-block-page.md).

---

## August 2025

### General Availability - Microsoft Entra ID Protection: Improved detection quality

**Type:** New feature      
**Service category:** Identity Protection     
**Product capability:** Identity Security & Protection  

Improvements have been made to Microsoft Entra ID Protection detections to increase detection quality by improving precision and reducing detection noise. This quarter’s improvements apply to the following detections:

- [Anomalous token](../id-protection/concept-identity-protection-risks.md#anomalous-token-sign-in)
- [Anonymous IP address](../id-protection/concept-identity-protection-risks.md#anonymous-ip-address)
- [Impossible travel](../id-protection/concept-identity-protection-risks.md#impossible-travel)
- [Password spray](../id-protection/concept-identity-protection-risks.md#password-spray)
- [Unfamiliar sign-in properties](../id-protection/concept-identity-protection-risks.md#unfamiliar-sign-in-properties)

Furthermore, changes have been made to better adjust the risk detections to passwordless scenarios.

---

### Public preview - Lifecycle Workflows task now supports setting Access Package assignments expiration

**Type:** New feature      
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance  

Customers can now configure the remove all access packages task in Lifecycle Workflows to automatically expire access packages assignments after a specified number of days when employees leave the organization. For more information, see: [Remove all access package assignments for user](../id-governance/lifecycle-workflow-tasks.md#remove-all-access-package-assignments-for-user).

---

### Plan for change - New end user homepage in My Account

**Type:** New feature      
**Service category:** My Profile/Account     
**Product capability:** End User Experiences  

By the end of September 2025, the homepage at https://myaccount.microsoft.com will be updated to provide a more task-focused experience. Users will see pending actions like renewing expiring groups, approving access package requests, and setting up MFA directly on the homepage. Quick links to apps, groups, access packages, and sign-in details will be easier to find and use. This change is designed to streamline account management and help users stay on top of access and security tasks.

---

### Plan for change  - Requestors can view who their access package approvers are in My Access

**Type:** New feature  
**Service category:** Entitlement Management     
**Product capability:** Entitlement Management  

By the end of September 2025, requestors will be able to see the name and email address of approvers for their pending access package requests directly in the My Access portal. This feature improves transparency and helps streamline communication between requestors and approvers. At the tenant level, approver visibility is enabled by default for all members (non-guests) and can be controlled through the Entitlement Management settings in the Microsoft Entra Admin Center. At the access package level, admins and access package owners can configure the approver visibility and choose to override the tenant level setting under the advanced request settings in the access package policy.

---

### Public Preview - Externally determine the approval requirements for an access package using custom extensions

**Type:** New feature  
**Service category:** Entitlement Management     
**Product capability:** Entitlement Management  

In Entitlement Management, approvers for access package assignment requests can either be directly assigned, or determined dynamically. Entitlement management natively supports dynamically determining approvers such as the requestors manager, their second-level manager, or a sponsor from a connected organization. With the introduction of this feature you can now use custom extensions for callouts to Azure Logic Apps and dynamically determine approval requirements for each access package assignment request based on your organizations specific business logic. The access package assignment request process will pause until your business logic hosted in Azure Logic Apps returns an approval stage which will then be leveraged in the subsequent approval process via the My Access portal. 

For more information, see: [Externally determine the approval requirements for an access package using custom extensions (Preview)](../id-governance/entitlement-management-dynamic-approval.md).

---

### Public Preview - Support for eligible group memberships and ownerships in Entitlement Management access packages

**Type:** New feature  
**Service category:** Entitlement Management     
**Product capability:** Entitlement Management  

This integration between Entitlement Management and Privileged Identity Management (PIM) for Groups adds support for assigning eligible group memberships and ownerships via access packages. You will now be able to govern these just-in-time protected access assignments at scale by offering a self-service access request & extension process and can integrate them into your organization's role model. For more information, see: [Assign eligible group membership and ownership in access packages via Privileged Identity Management for Groups (Preview)](../id-governance/entitlement-management-access-package-eligible.md)

---

### General Availability - Platform SSO for macOS with Microsoft Entra ID

**Type:** New feature  
**Service category:** Authentications (Logins)  
**Product capability:** SSO  

Today we’re announcing that Platform SSO for macOS is Generally Available with Microsoft Entra ID. Platform SSO is an enhancement to the Microsoft Enterprise SSO plug-in for Apple Devices that makes usage and management of Mac devices more seamless and secure than ever. At the start of public preview, Platform SSO will work with Microsoft Intune. Other Mobile Device Management (MDM) providers will be coming soon. Please contact your MDM provider for more information on support and availability. For more information, see:

- [macOS Platform Single Sign-on overview](../identity/devices/macos-psso.md)
- [Platform SSO configuration guide for macOS devices using Microsoft Intune](/intune/intune-service/configuration/platform-sso-macos)
- [Configuring macOS Platform SSO (PSSO) to meet NIST SP 800-63 and EO 14028 Requirements](../identity/devices/macos-psso-deployment-eocustomers.md)
- [Understanding Primary Refresh Token (PRT)](../identity/devices/concept-primary-refresh-token.md)

---

### General Availability - Enabling native authentication JavaScript SDK for sign-in, sign-up and sign-out experiences in Microsoft Entra External ID.

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** Developer Experience  

Build sign-in, sign-up, and sign-out experiences for single page applications in Microsoft Entra External ID with the new native authentication [JavaScript SDK](../identity-platform/quickstart-native-authentication-single-page-app-sdk-sign-in.md).

---

### General Availability - QR + PIN Simple Auth method for FLW

**Type:** New feature  
**Service category:** Authentications (Logins)  
**Product capability:** User Authentication  

QR code authentication in Microsoft Entra ID is now generally available, offering frontline workers a quick and secure way to sign in using a QR code and personal PIN. This authentication method can be provisioned through Microsoft Entra ID, My Staff, or Microsoft Graph APIs. Users can sign in on a mobile device (Android, iOS, iPadOS) by visiting https://login.microsoftonline.com, selecting Sign-in options > Sign in to an organization > Sign in with QR code, a web-based sign-in option available for all apps. Additionally, some applications, including Microsoft Teams, MHS, Bluefletch, and Jamf, support a dedicated “*Sign in with a QR code*” button on their login page for a seamless experience. For more information, see: 

- [Authentication methods in Microsoft Entra ID - QR code authentication method](../identity/authentication/concept-authentication-qr-code.md)
- [How to enable the QR code authentication method in Microsoft Entra ID](../identity/authentication/how-to-authentication-qr-code.md)

---

### Public Preview - New Bulk Operations Feature

**Type:** New feature  
**Service category:** Directory Management  
**Product capability:** End User Experiences  

The new Bulk Operations in Microsoft Entra ID offer an enhanced experience for managing **Groups**, **Devices**, and **User Export**, enabling bulk actions such as create, update, and delete. This streamlined service improves performance, reduces timeouts, and removes scaling limitations especially for large tenants.  


**Note:** Currently, the new Bulk Operations service supports **Groups**, **Devices**, and **User Export** only. Support for additional entities, such as **Enterprise Applications**, is coming soon. For more information, see: [Bulk operations in Microsoft Entra ID (Preview)](../fundamentals/bulk-operations.md).

---



##  July 2025

### General Availability - Microsoft Entra External ID: Custom 3rd party email OTP provider

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management   
**Product capability:** 3rd Party Integration 

Use a 3rd Party Email OTP Provider to customize the Email OTP notifications for sign-in and sign-up flows for Microsoft Entra External ID. A new "Custom Email OTP Provider" Custom Authentication Extension allows you to use Azure Communication Service (ACS) or a 3rd party provider, such as SendGrid, to maintain branding consistency through your end user authentication experiences. For more information, see: [Configure a custom email provider for one time passcode send events](../identity-platform/custom-extension-email-otp-get-started.md).

---


### General Availability - Application Based Authentication on Microsoft Entra Connect Sync

**Type:** New feature  
**Service category:** Microsoft Entra Connect   
**Product capability:** Microsoft Entra Connect 

The Application-Based Authentication (ABA) feature is now the default authentication method for Microsoft Entra Connect. It enables Microsoft Entra Connect to securely authenticate with Microsoft Entra ID without relying on a locally stored password. This feature uses a Microsoft Entra ID application identity and Oauth 2.0 client credential flow to authenticate with Microsoft Entra ID.  Microsoft Entra Connect automatically creates a single-tenant third-party application in the customer’s Entra ID tenant, registers a certificate as the application’s credential, and grants the required permissions for directory synchronization. 

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on Microsoft Entra Admin Center under [Microsoft Entra Connect](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details of the change.

---

### General Availability – Security Copilot in Microsoft Entra 

**Type:** New feature  
**Service category:** Copilot   
**Product capability:** Identity Security & Protection 

You can now interact with Copilot in Microsoft Entra to investigate threats, manage the identity lifecycle of employees and guests, and take action quickly across users, apps, and access. All of this works through natural language, without writing custom queries or scripts. For more information, see: [Copilot in Microsoft Entra](../security-copilot/security-copilot-in-entra.md).

---

### General Availability - Conditional Access Optimization Agent in Microsoft Entra

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

Conditional Access Optimization Agent in Microsoft Entra monitors for new users or apps not covered by existing policies, identifies necessary updates to close security gaps, and recommends quick fixes for identity teams to apply with a single selection. For more information, see: [Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot](../security-copilot/conditional-access-agent-optimization.md).

---

### General Availability - Conditional Access Agent Supports Disabling Agent Creation of Report-Only Policies

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

The Conditional Access Optimization Agent now supports a new setting that allows admins to configure if the agent can or cannot create report-only mode policies autonomously. If turned off, the agent will only create policies upon admin approval. For more information, see: [Microsoft Entra Conditional Access Optimization Agent with Microsoft Security Copilot](../security-copilot/conditional-access-agent-optimization.md).

---

### General Availability - New Lifecycle Workflows task to revoke refresh tokens

**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  

Customers can now configure a Lifecycle Workflows task to automatically revoke access tokens when employees move within, or leave, the organization. For more information, see: [Revoke all refresh tokens for user](../id-governance/lifecycle-workflow-tasks.md#revoke-all-refresh-tokens-for-user).

---

### General Availability - Audit administrator events in Microsoft Entra Connect Sync

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Microsoft Entra Connect  

The Admin Audit Logging feature enables organizations to monitor changes made to Microsoft Entra Connect Sync configurations by Global Administrators or Hybrid Administrators. It captures actions performed through the Microsoft Entra Connect Sync Wizard, PowerShell, or Synchronization Rules Editor—including changes to synchronization rules, authentication settings (such as enabling or disabling features), and Federation settings. These events are logged in a dedicated Microsoft Entra Connect Sync audit log channel within the Windows Event Viewer, providing greater visibility into identity infrastructure changes. This feature supports troubleshooting, operational accountability, and regulatory compliance.   

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on the Microsoft Entra Admin Center within the [Microsoft Entra Connect pane](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). 

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details of the change. 

---

### General Availability - Bicep templates for Microsoft Graph resources

**Type:** New feature  
**Service category:** MS Graph  
**Product capability:** Developer Experience  

Bicep templates for Microsoft Graph resources allows you to author, deploy and manage a limited set of Microsoft Graph resources (mostly Microsoft Entra ID resources) using Bicep template files, alongside Azure resources.  
- Azure customers can use familiar tools to deploy Azure resources and the Microsoft Entra resources they depend on, such as applications and service principals, using Infrastructure-as-Code (IaC) and DevOps practices.  
- It also opens the door for existing Microsoft Entra customers to use Bicep templates and IaC practices to deploy and manage their tenant's Microsoft Entra resources.  

For more information, see: [Bicep templates for Microsoft Graph](/graph/templates/bicep/overview-bicep-templates-for-graph).

---

### General Availability - Conditional Access What If API

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Access Control  

The Conditional access What If API can be used to programmatically test the impact of policies on user and workload identity sign-ins.

---

### General Availability - Enterprise App SSO via pre-integrated gallery app or customer SAML apps

**Type:** Changed feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** SSO  

Enterprise apps SSO & User Provisioning SAML-based Single Sign-On (SSO) and gallery apps with user provisioning flows are now Generally Available (GA). These features help streamline secure access and automate user lifecycle management across your enterprise applications. For more information, see:

- [Add an enterprise application](../external-id/customers/how-to-add-enterprise-application.md)
- [Register a SAML app in your external tenant](../external-id/customers/how-to-register-saml-app.md)
- [Supported features on external tenant](../external-id/customers/concept-supported-features-customers.md#enterprise-applications)

---

### Public Preview - Convert Source of Authority of synced Active Directory groups to the cloud

**Type:** New feature  
**Service category:** Group Management  
**Product capability:** Microsoft Entra Connect and Microsoft Entra Cloud Sync

The Source of Authority (SOA) at the object level allows administrators to convert specific groups synced from Active Directory (AD) to Microsoft Entra ID into cloud-editable objects, which are no longer synced from AD and act as if originally created in the cloud. This feature supports a gradual migration process, decreasing dependencies on AD while aiming to minimize user and operational impact. Both Entra Connect Sync and Cloud Sync recognize the SOA switch for these objects. Additionally, administrators can govern Kerberos-based applications associated with AD security groups from the cloud using Microsoft Entra Governance by including these SOA-converted security groups for Group Provision to AD. The option to switch the SOA of synced groups from AD to Microsoft Entra ID is currently available in Public Preview. For more information, see: [Embrace cloud-first posture: Convert Group Source of Authority to the cloud (Preview)](../identity/hybrid/concept-source-of-authority-overview.md).

---

### General Availability - Restricted Management Administrative Units

**Type:** New feature  
**Service category:** RBAC  
**Product capability:** AuthZ/Access Delegation  

Restricted management administrative units enable you to easily restrict access to users, groups, or devices to the specific users or applications you specify. Tenant-level administrators (including Global Administrators) can't modify members of restricted management administrative units unless they're explicitly assigned a role scoped to the administrative unit. This makes it easy to lock down a set of sensitive groups or user accounts in your tenant without having to remove tenant-level role assignments. For more information, see: [Restricted management administrative units in Microsoft Entra ID](../identity/role-based-access-control/admin-units-restricted-management.md).

---


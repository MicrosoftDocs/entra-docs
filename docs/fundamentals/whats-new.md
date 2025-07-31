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
ms.date: 07/25/2025
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

>Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

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

You can now interact with Copilot in Microsoft Entra to investigate threats, manage the identity lifecycle of employees and guests, and take action quickly across users, apps, and access. All of this works through natural language, without writing custom queries or scripts. For more information, see: [Copilot in Microsoft Entra](copilot-security-entra.md).

---

### General Availability - Conditional Access Optimization Agent in Microsoft Entra

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

Conditional Access Optimization Agent in Microsoft Entra monitors for new users or apps not covered by existing policies, identifies necessary updates to close security gaps, and recommends quick fixes for identity teams to apply with a single selection. For more information, see: [Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot](../identity/conditional-access/agent-optimization.md).

---

### General Availability - Conditional Access Agent Supports Disabling Agent Creation of Report-Only Policies

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

The Conditional Access Optimization Agent now supports a new setting that allows admins to configure if the agent can or cannot create report-only mode policies autonomously. If turned off, the agent will only create policies upon admin approval. For more information, see: [Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot](../identity/conditional-access/agent-optimization.md#agent-capabilities).

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

The Source of Authority (SOA) at the object level allows administrators to convert specific groups synced from Active Directory (AD) to Microsoft Entra ID into cloud-editable objects, which are no longer synced from AD and act as if originally created in the cloud. This feature supports a gradual migration process, decreasing dependencies on AD while aiming to minimize user and operational impact. Both Entra Connect Sync and Cloud Sync recognize the SOA switch for these objects. Additionally, administrators can govern Kerberos-based applications associated with AD security groups from the cloud using Microsoft Entra Governance by including these SOA-converted security groups for Group Provision to AD. The option to switch the SOA of synced groups from AD to Microsoft Entra ID is currently available in Public Preview. For more information, see: https://aka.ms/groupsoadocs

---

### General Availability - Restricted Management Administrative Units

**Type:** New feature  
**Service category:** RBAC  
**Product capability:** AuthZ/Access Delegation  

Restricted management administrative units enable you to easily restrict access to users, groups, or devices to the specific users or applications you specify. Tenant-level administrators (including Global Administrators) can't modify members of restricted management administrative units unless they're explicitly assigned a role scoped to the administrative unit. This makes it easy to lock down a set of sensitive groups or user accounts in your tenant without having to remove tenant-level role assignments. For more information, see: [Restricted management administrative units in Microsoft Entra ID](../identity/role-based-access-control/admin-units-restricted-management.md).

---


## June 2025
 
### General Availability – Update to Microsoft Entra Work or School Default Background Image 
 
**Type:** Changed feature  
**Service category:** Authentications (Login)  
**Product capability:** User Authentication  
 
Starting September 29, 2025, we'll be making a change to the default background image of our Microsoft Entra work or school authentication screens. This new background was designed to help users focus on signing into their accounts, enhancing productivity, and minimizing distractions. With this, we aim to ensure visual consistency and a clean, simplified user experience throughout Microsoft’s authentication flows – aligning with Microsoft’s modernized [Fluent](https://microsoft.design/articles/four-principles-for-the-future-of-design/) design language. When our experiences look and feel consistent, it gives our users a familiar experience that they know and trust. 

**What’s changing?**                                                   		           

This update is solely a visual user interface refresh with no changes to functionality. This change will only affect screens where [Company Branding](how-to-customize-branding.md) doesn't apply or where users see the [default background image](https://aka.ms/entradefaultbackground). We recommend updating any documentation that contains screenshots and notifying your help desk. If you have configured a custom background image in Company Branding for your tenant, there will be no change for your users. 

**Additional Details:** 

1. **Tenants without a custom background configured:**  
    a. Tenants without a custom background will see the change on every authentication screen.<br> 
    b. To change this background and use a custom background, configure [Company Branding](how-to-customize-branding.md).

1. **Tenants with a custom background configured:**  
    a. Tenants with a custom background configured will only see the change wherever the URL doesn't have a specified tenant ID parameter (For example, login.microsoftonline.com directly **without** a domain hint or custom URL).<br> 
    b. For all other screens, tenants with a custom background configured **will see no change** to their experience on all clients. 

1. **Entra External ID Tenants will not see any change to their experience on all clients** 

**What do you need to do?**

No action is required. The update will be applied automatically starting September 29, 2025. 
 
---


### General Availability - API-driven provisioning in US Gov cloud
 
**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Identity Governance  
 
API-driven provisioning is now generally available in US Gov cloud. With this capability, customers in US Gov cloud can now ingest identity data from any authoritative source into Microsoft Entra ID and on-premises Active Directory. For more information, see: [Quickstart API-driven inbound provisioning with Graph Explorer](../identity/app-provisioning/inbound-provisioning-api-graph-explorer.md).
 
---

### Deprecated - Conditional Access Overview Monitoring Tab to Retire
 
**Type:** Deprecated  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  
 
We're retiring the Conditional Access Overview Monitoring Tab in the Microsoft Entra Admin Center starting July 18 and completing by August 1. After this date, admins will no longer have access to this tab. We encourage customers to transition to Conditional Access Per-Policy Reporting and the Insights and Reporting Dashboard, both of which are more reliable, offer greater accuracy, and have received significantly better feedback from customers. Learn more about [Per-Policy Reporting](../identity/conditional-access/concept-conditional-access-report-only.md#policy-impact) and [Insights and Reporting](../identity/conditional-access/howto-conditional-access-insights-reporting.md).
 
---
 
### General Availability - Manage Lifecycle Workflows with Microsoft Security CoPilot in Microsoft Entra
 
**Type:** New feature  
**Service category:** Lifecycle Workflows  
**Product capability:** Identity Governance  
 
Now customers can manage and customize Lifecycle Workflows using natural language with Microsoft Security CoPilot in Microsoft Entra. Our Lifecycle Workflows (LCW) Copilot solution provides step-by-step guidance to perform key workflow configuration and execution tasks using natural language. It allows customers to quickly get rich insights to help monitor and troubleshoot workflows for compliance. For more information, see: [Manage employee lifecycle using Microsoft Security Copilot](../fundamentals/copilot-entra-lifecycle-workflow.md).
 
---
 
### General Availability - Provision custom security attributes from HR sources
 
**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Identity Governance  
 
With this feature, customers can automatically provision "*custom security attributes*" in Microsoft Entra ID from authoritative HR sources. Supported authoritative sources: Workday, SAP SuccessFactors and any HR system integrated using API-driven provisioning. For more information, refer to: [Provision custom security attributes from HR sources](../identity/app-provisioning/provision-custom-security-attributes.md).
 
---
 
### General Availability - Conditional Access audience reporting
 
**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Access Control  
 
Conditional Access audience reporting in the sign-in logs lets admins view all the resources evaluated by Conditional Access as part of a sign-in event. For more information, see: [Audience reporting](../identity/conditional-access/troubleshoot-conditional-access.md#audience-reporting).
 
---
 
### Public Preview - Cross-tenant synchronization (cross-cloud)
 
**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Identity Governance  
 
Automate creating, updating, and deleting users across tenants across Microsoft clouds. The following combinations are supported:
 
- Commercial -> US Gov  
- US Gov -> Commercial  
- Commercial -> China  
 
For more information, see: [Configure cross-tenant synchronization](../identity/multi-tenant-organizations/cross-tenant-synchronization-configure.md)
 
---
 
### General Availability - Conditional Access support for all Microsoft apps
 
**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  
 
Administrators can assign a Conditional Access policy to all cloud apps from Microsoft as long as the service principal appears in their tenant. For more information, see: [Microsoft cloud applications](../identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-cloud-applications).
 
---
 
### General Availability - Two-Way Forest Trusts for Microsoft Entra Domain Services
 
**Type:** New feature  
**Service category:** Microsoft Entra Domain Services  
**Product capability:** Microsoft Entra Domain Services  
 
Two-Way Forest Trusts for Microsoft Entra Domain Services are now generally available. This capability allows organizations to establish trust relationships between Microsoft Entra Domain Services domains and on-premises Active Directory (AD) domains. Forest trusts can now be configured in three directions: one-way outbound (as before), one-way inbound, and bi-directional, depending on organizational needs. Forest trusts can be used to enable resource access across trusted domains in hybrid environments. This capability offers more control and flexibility over how to manage your hybrid identity environment with Microsoft Entra Domain Services. Trusts require an Enterprise or Premium SKU license. For more information, see: [How trust relationships work for forests in Active Directory](../identity/domain-services/concepts-forest-trust.md).
 
---

### General Availability - Certificate Authority (CA) Trust Store
 
**Type:** New feature  
**Service category:** Authentications (Login)   
**Product capability:** User Authentication  
 
The new PKI-based CA Trust Store replaces the legacy flat-list model with a more robust structure and no limitations on the size or the number of CAs. It supports bulk PKI uploads, CRL updates, issuer hints, and prioritization of the new store over the legacy one. Sign-in logs now indicate which store was used, helping admins phase out legacy configurations. For more information, see: [How to configure Microsoft Entra certificate-based authentication](../identity/authentication/how-to-certificate-based-authentication.md).
 
---

### General Availability - Certificate Revocation List (CRL) Fail Safe
 
**Type:** New feature  
**Service category:** Authentications (Login)   
**Product capability:** User Authentication  
 
CRL Fail Safe ensures that CBA auth fails if the end user certificate issuing CA does not have a Certificate Revocation List (CRL) configured. This closes a critical security gap where certificates could previously be accepted without revocation validation. Admins can enable this at the tenant level and configure exceptions for specific CAs as needed. For more information, see: [Understanding CRL validation](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-crl-validation).
 
---

### Public Preview - Certificate Authority (CA) Scoping
 
**Type:** New feature  
**Service category:** Authentications (Login)   
**Product capability:** User Authentication 
 
CA Scoping allows admins to bind specific CAs to defined user groups. This ensures that users can only authenticate using certificates from trusted sources scoped to them. This enhances compliance, and reduces exposure to mis-issued or rogue certificates. For more information, see: [Certificate Authority (CA) Scoping (Preview)](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#certificate-authority-ca-scoping-preview).
 
---

## May 2025

### General Availability - Microsoft Entra External ID:  User authentication with SAML/WS-Fed Identity Providers

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** B2B/B2C  

Set up a SAML or WS-Fed identity provider to enable users to sign up and sign in to, your applications using their own account with the identity provider. Users will be redirected to the identity provider, and then redirected back to Microsoft Entra after successful sign in. For more information, see: [SAML/WS-Fed identity providers](../external-id/direct-federation-overview.md).

---

### General Availability - Pre/Post Attribute Collection Custom Extensions in Microsoft Entra External ID

**Type:** New feature  
**Service category:** B2C - Consumer Identity Management  
**Product capability:** Extensibility   

Use Pre/Post Attribute Collection Custom Extensions to customize your self-service sign-up flow. This includes blocking sign-up, or prefilling, validating, and modifying attribute values. For more information, see: [Create a custom authentication extension for attribute collection start and submit events](../identity-platform/custom-extension-attribute-collection.md).

---

### Public Preview - Roll out of Application Based Authentication on Microsoft Entra Connect Sync

**Type:** New feature  
**Service category:** Microsoft Entra Connect  
**Product capability:** Microsoft Entra Connect  

Microsoft Entra Connect creates and uses a [Microsoft Entra Connector account](../identity/hybrid/connect/reference-connect-accounts-permissions.md) to authenticate and sync identities from Active Directory to Microsoft Entra ID. The account uses a locally stored password to authenticate with Microsoft Entra ID. To enhance the security of the Microsoft Entra Connect sync process with the application, we've rolled out support for "*Application based Authentication" (ABA)*, which uses a Microsoft Entra ID application identity and Oauth 2.0 client credential flow to authenticate with Microsoft Entra ID. To enable this, Microsoft Entra Connect creates a single tenant 3rd party application in the customer's Microsoft Entra ID tenant, registers a certificate as the credential for the application, and authorizes the application to perform on-premises directory synchronization. 

The Microsoft Entra Connect Sync .msi installation file for this change is exclusively available on Microsoft Entra Admin Center within the [Microsoft Entra Connect pane](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted).  

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) for more details of the change.

---

### General Availability – Analyze Conditional Access Policy impact

**Type:** New feature  
**Service category:** Conditional Access  
**Product capability:** Identity Security & Protection  

The policy impact view for individual Conditional Access policies enables admins to understand how each policy has affected recent sign-ins. The feature provides a clear, built-in graph in the Microsoft Entra admin center, making it easy to visualize and assess the impact without needing additional tools and resources, such as Log Analytics. For more information, see: [Policy impact](../identity/conditional-access/concept-conditional-access-report-only.md#policy-impact-preview).

---

### Public Preview – Deployment logs support for Global Secure Access

**Type:** New feature  
**Service category:** Reporting  
**Product capability:** Monitoring & Reporting  

Deployment logs feature provide visibility into the status and progress of configuration changes made in Global Secure Access. Deployment logs publish updates to admins and monitor the process for any errors. Unlike other logging features, deployment logs focus specifically on tracking configuration updates. These logs help administrators track and troubleshoot deployment updates, such as forwarding profile redistributions and remote network updates, across the global network. For more information, see: [How to use the Global Secure Access deployment logs (preview)](../global-secure-access/how-to-view-deployment-logs.md).

---


## April 2025

### Public Preview -  Conditional Access Optimization Agent in Microsoft Entra 

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

[Conditional Access Optimization Agent in Microsoft Entra](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/new-innovations-in-microsoft-entra-to-strengthen-ai-security-and-identity-protec/3827393) monitors for new users or apps not covered by existing policies, identifies necessary updates to close security gaps, and recommends quick fixes for identity teams to apply with a single selection. For more information, see: [Microsoft Entra Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md).

---

### Public Preview - Microsoft Entra ID Governance: Suggested access packages in My Access

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

In December 2024, we introduced a new feature in My Access: a curated list of suggested access packages. Users view the most relevant access packages, based on their peers' access packages and previous assignments, without scrolling through a long list. By May 2025, suggestions will be enabled by default and we'll introduce a new card in the Microsoft Entra Admin Center Entitlement Management control configurations for admins to see My Access settings. We recommend admins turn on the peer-based insights for suggested access packages via this setting. For more information, see: [Suggested access packages in My Access (Preview)](../id-governance/entitlement-management-suggested-access-packages.md).

---

### Public Preview - Conditional Access What If evaluation API

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Access Control    

Conditional Access What If evaluation API – Leverage the What If tool using the Microsoft Graph API to programmatically evaluate the applicability of Conditional Access policies in your tenant on user and service principal sign-ins. For more information, see: [conditionalAccessRoot: evaluate](/graph/api/conditionalaccessroot-evaluate).

---

### Public Preview - Manage refresh tokens for mover and leaver scenarios with Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Now customers can configure a Lifecycle workflows task to automatically revoke access tokens when employees move within, or leave, the organization. For more information, see: [Revoke all refresh tokens for user](../id-governance/lifecycle-workflow-tasks.md#revoke-all-refresh-tokens-for-user).

---

### General Availability - Use managed identities as credentials in Microsoft Entra apps

**Type:** New feature    
**Service category:** Managed identities for Azure resources    
**Product capability:** Identity Security & Protection   

You can now use managed identities as federated credentials for Microsoft Entra apps, enabling secure, secret-less authentication in both single- and multi-tenant scenarios. This eliminates the need to store and manage client secrets or certificates when using Microsoft Entra app to access Azure resources across tenants. This capability aligns with Microsoft’s [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative) pillar of protecting identities and secrets across systems. Learn how to configure this capability in the [official documentation](../workload-id/workload-identity-federation-config-app-trust-managed-identity.md).

---

### Plan for change - Roll out of Application Based Authentication on Microsoft Entra Connect Sync

**Type:** Plan for change   
**Service category:** Microsoft Entra Connect    
**Product capability:** Microsoft Entra Connect    

**What is changing**

Microsoft Entra Connect creates and uses a [Microsoft Entra Connector account](../identity/hybrid/connect/reference-connect-accounts-permissions.md) to authenticate and sync identities from Active Directory to Microsoft Entra ID. The account uses a locally stored password to authenticate with Microsoft Entra ID. To enhance the security of the Microsoft Entra Connect application sync process, we will, in the coming week roll out support for "Application based Authentication" (ABA), which uses a Microsoft Entra ID application based identity and Oauth 2.0 client credential flow to authenticate with Microsoft Entra ID. To enable this, Microsoft Entra Connect will create a single tenant 3rd party application in customer's Microsoft Entra ID tenant, register a certificate as the credential for the application, and authorize the application to perform on-premises directory synchronization

The Microsoft Entra Connect Sync .msi installation file for this change will be exclusively available in the Microsoft Entra admin center within the [Microsoft Entra Connect pane](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). 

Check our [version history page](../identity/hybrid/connect/reference-connect-version-history.md) in the next week for more details of the change.

---


## March 2025

### Microsoft Entra Permissions Management end of sale and retirement
 
**Type:** Plan for change    
**Service category:** Other    
**Product capability:** Permissions Management    
 
Effective April 1, 2025, Microsoft Entra Permissions Management (MEPM) will no longer be available for sale to new Enterprise Agreement or direct customers. Additionally, starting May 1, it will not be available for sale to new CSP customers. Effective October 1, 2025, we will retire Microsoft Entra Permissions Management and discontinue support of this product. 

Existing customers will retain access to this product until September 30, 2025, with ongoing support for current functionalities. We have partnered with Delinea to provide an alternative solution, [Privilege Control for Cloud Entitlements (PCCE)](https://delinea.com/products/privilege-control-for-cloud-entitlements), that offers similar capabilities to those provided by Microsoft Entra Permissions Management. The decision to phase out Microsoft Entra Permissions Management was done after deep consideration of our innovation portfolio and how we can focus on delivering the best innovations aligned to our differentiating areas and partner with the ecosystem on adjacencies. We remain committed to delivering top-tier solutions across the Microsoft Entra portfolio. For more information, see: [Important change announcement: Microsoft Entra Permissions Management end of sale and retirement](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/important-change-announcement-microsoft-entra-permissions-management-end-of-sale/4399382).
 
---

### Public Preview - Track and investigate identity activities with linkable identifiers in Microsoft Entra

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Microsoft will standardize the linkable token identifiers, and expose them in both Microsoft Entra and workflow audit logs. This allows customers to join the logs to track, and investigate, any malicious activity. Currently linkable identifiers are available in Microsoft Entra sign in logs, Exchange Online audit logs, and MSGraph Activity logs.

For more information, see: [Track and investigate identity activities with linkable identifiers in Microsoft Entra (preview)](../identity/authentication/how-to-authentication-track-linkable-identifiers.md).

---

### General Availability- Conditional Access reauthentication policy 

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Require reauthentication every time can be used for scenarios where you want to require a fresh authentication, every time a user performs specific actions like accessing sensitive applications, securing resources behind VPN, or Securing privileged role elevation in PIM​. For more information, see: [Require reauthentication every time](../identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time).

---

### General Availability- Custom Attributes support for Microsoft Entra Domain Services

**Type:** New feature    
**Service category:** Microsoft Entra Domain Services    
**Product capability:** Microsoft Entra Domain Services    

Custom Attributes for Microsoft Entra Domain Services is now Generally Available. This capability allows customers to use Custom Attributes in their managed domains. Legacy applications often rely on custom attributes created in the past to store information, categorize objects, or enforce fine-grained access control over resources. For example, these applications might use custom attributes to store an employee ID in their directory and rely on these attributes in their application LDAP calls. Modifying legacy applications can be costly and risky, and customers might lack the necessary skills or knowledge to make these changes. Microsoft Entra Domain Services now supports custom attributes, enabling customers to migrate their legacy applications to the Azure cloud without modification. It also provides support to synchronize custom attributes from Microsoft Entra ID, allowing customers to benefit from Microsoft Entra ID services in the cloud. For more information, see: [Custom attributes for Microsoft Entra Domain Services](../identity/domain-services/concepts-custom-attributes.md).

---

### Public Preview - Conditional Access Per-Policy Reporting

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Conditional Access Per-Policy Reporting enables admins to easily evaluate the impact of enabled and report-only Conditional Access policies on their organization, without using Log Analytics. This feature surfaces a graph for each policy in the Microsoft Entra Admin Center, visualizing the policy’s impact on the tenant’s past sign-ins. For more information, see: [Policy impact (Preview)](../identity/conditional-access/concept-conditional-access-report-only.md#policy-impact-preview).

---

### Public Preview - Limit creation or promotion of multitenant apps

**Type:** New feature    
**Service category:** Directory Management    
**Product capability:** Developer Experience    

A new feature has been added to the [App Management Policy Framework](/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) that allows restriction on creation or promotion of multitenant applications, providing administrators with greater control over their app environments.

Administrators can now configure tenant default or custom app policy using the new '[audiences](/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta#what-restrictions-can-be-managed-in-microsoft-graph)' restriction to block new app creation if the signInAudience value provided in the app isn't permitted by the policy. In addition, existing apps can be restricted from changing their signInAudience if the target value isn't permitted by the policy. These policy changes are applied during app creation or update operations, offering control over application deployment and usage. For more information, see: [audiencesConfiguration resource type](/graph/api/resources/audiencesconfiguration).

---


### General Availability - Download Microsoft Entra Connect Sync on the Microsoft Entra admin center

**Type:** Plan for change    
**Service category:** Microsoft Entra Connect    
**Product capability:** Identity Governance    

The Microsoft Entra Connect Sync .msi installation files are also available on Microsoft Entra admin center within the [Microsoft Entra Connect pane](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/~/GetStarted). As part of this change, we'll stop uploading new installation files on the [Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=47594).

---

### General Availability - New Microsoft-managed Conditional Access policies designed to limit device code flow and legacy authentication flows

**Type:** Changed feature    
**Service category:** Conditional Access    
**Product capability:** Access Control    

As part of our ongoing commitment to enhance security and protect our customers from evolving cyber threats, we're rolling out two new Microsoft-managed Conditional Access policies designed to limit device code flow and legacy authentication flows. These policies are aligned to the secure by default principle of our broader [Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative), which aims to provide robust security measures to safeguard your organization by default.

---

### Deprecated - Upgrade your Microsoft Entra Connect Sync version to avoid impact on the Sync Wizard

**Type:** Deprecated    
**Service category:** Microsoft Entra Connect    
**Product capability:** Microsoft Entra Connect    

As announced in the Microsoft Entra What's New [Blog](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/whats-new-in-microsoft-entra---september-2024/4253153) and in Microsoft 365 Center communications, customers should upgrade their connect sync versions to at least [2.4.18.0](../identity/hybrid/connect/reference-connect-version-history.md#24180) for commercial clouds and [2.4.21.0](../identity/hybrid/connect/reference-connect-version-history.md#24210) for non-commercial clouds before April 7, 2025. A breaking change on the Connect Sync Wizard will affect all requests that require authentication such as schema refresh, configuration of staging mode, and user sign in changes. For more information, see: [Minimum versions](../identity/hybrid/connect/harden-update-ad-fs-pingfederate.md#minimum-versions).

---

## February 2025

### General Availability - Authentication methods migration wizard

**Type:** New feature    
**Service category:** MFA    
**Product capability:** User Authentication    

The authentication methods migration guide in the Microsoft Entra Admin Center lets you automatically migrate method management from the [legacy MFA and SSPR policies](../identity/authentication/concept-authentication-methods-manage.md#legacy-mfa-and-sspr-policies) to the [converged authentication methods policy](../identity/authentication/concept-authentication-methods-manage.md). In 2023, it was announced that the ability to manage authentication methods in the legacy MFA and SSPR policies would be retired in September 2025. Until now, organizations had to manually migrate methods themselves by using [the migration toggle](../identity/authentication/how-to-authentication-methods-manage.md#start-the-migration) in the converged policy. Now, you can migrate in just a few selections by using the migration guide. The guide evaluates what your organization currently has enabled in both legacy policies, and generates a recommended converged policy configuration for you to review and edit as needed. From there, confirm the configuration, and we set it up for you and mark your migration as complete. For more information, see: [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](../identity/authentication/how-to-authentication-methods-manage.md).

---

### Public Preview – QR code authentication, a simple and fast authentication method for Frontline Workers

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

We're thrilled to announce public preview of QR code authentication in Microsoft Entra ID, providing an efficient and simple authentication method for frontline workers.

You see a new authentication method ‘QR code’ in Microsoft Entra ID Authentication method Policies. You can enable and add QR code for your frontline workers via Microsoft Entra ID, My Staff, or MS Graph APIs. All users in your tenant see a new link ‘Sign in with QR code’ on navigating to https://login.microsoftonline.com > ‘Sign-in options’ > ‘Sign in to an organization’ page. This new link is visible only on mobile devices (Android/iOS/iPadOS). Users can use this auth method only if you add and provide a QR code to them. QR code auth is also available in BlueFletch and Jamf. MHS QR code auth support is generally available by early March.

The feature has a ‘preview’ tag until it's generally available. For more information, see: [Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)](../identity/authentication/concept-authentication-qr-code.md).

---


### Public Preview - Enhanced user management in Admin Center UX

**Type:** New feature    
**Service category:** User Management    
**Product capability:** User Management    

Admins are now able to multi-select and edit users at once through the Microsoft Entra Admin Center. With this new capability, admins can bulk edit user properties, add users to groups, edit account status, and more. This UX enhancement will significantly improve efficiency for user management tasks in the Microsoft Entra admin center. For more information, see: [Add or update a user's profile information and settings in the Microsoft Entra admin center](how-to-manage-user-profile-info.yml).

---

### Public Preview - Custom SAML/WS-Fed External Identity Provider Support in Microsoft Entra External ID

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

By setting up federation with a custom-configured identity provider that supports the SAML 2.0 or WS-Fed protocol, you enable your users to sign up and sign in to your applications using their existing accounts from the federated external provider.

This feature also includes domain-based federation, so a user who enters an email address on the sign-in page that matches a predefined domain in any of the external identity providers will be redirected to authenticate with that identity provider.

For more information, see: [Custom SAML/WS-Fed identity providers](../external-id/customers/concept-authentication-methods-customers.md#custom-samlws-fed-identity-providers).

---


### Public Preview - External Auth Methods support for system preferred MFA

**Type:** New feature    
**Service category:** MFA    
**Product capability:** 3rd Party Integration    

Support for external auth methods as a supported method begins rolling out at the beginning of March 2025. When this is live in a tenant where system preferred is enabled and users are in scope of an external auth methods policy, those users will be prompted for their external authentication method if their most secure registered method is Microsoft Authenticator notification. External Authentication Method will appear as third in the list of most secure methods. If the user has a Temporary Access Pass (TAP) or Passkey (FIDO2) device registered, they'll be prompted for those. In addition, users in the scope of an external auth methods policy will have the ability to delete all registered second factor methods from their account, even if the method being deleted is specified as the default sign in method or is system preferred. For more information, see: [System-preferred multifactor authentication - Authentication methods policy](../identity/authentication/concept-system-preferred-multifactor-authentication.md).

---

### General Availability - Granular Microsoft Graph permissions for Lifecycle workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Now new, lesser privileged permissions can be used for managing specific read and write actions in Lifecycle workflows scenarios. The following granular permissions were introduced in Microsoft Graph:

- LifecycleWorkflows-Workflow.ReadBasic.All
- LifecycleWorkflows-Workflow.Read.All
- LifecycleWorkflows-Workflow.ReadWrite.All
- LifecycleWorkflows-Workflow.Activate
- LifecycleWorkflows-Reports.Read.All
- LifecycleWorkflows-CustomExt.Read.All
- LifecycleWorkflows-CustomExt.ReadWrite.All

For more information, see: [Microsoft Graph permissions reference](/graph/permissions-reference).


---


## January 2025


### Public Preview - Manage Lifecycle Workflows with Microsoft Security CoPilot in Microsoft Entra

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Customers can now manage, and customize, Lifecycle Workflows using natural language with Microsoft Security CoPilot. Our Lifecycle Workflows (LCW) Copilot solution provides step-by-step guidance to perform key workflow configuration and execution tasks using natural language. It allows customers to quickly get rich insights to help monitor, and troubleshoot, workflows for compliance. For more information, see: [Manage employee lifecycle using Microsoft Security Copilot (Preview)](../fundamentals/copilot-entra-lifecycle-workflow.md).

---

### General Availability - Microsoft Entra PowerShell

**Type:** New feature    
**Service category:** MS Graph    
**Product capability:** Developer Experience    

Manage and automate Microsoft Entra resources programmatically with the scenario-focused Microsoft Entra PowerShell module. For more information, see: [Microsoft Entra PowerShell module now generally available](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/microsoft-entra-powershell-module-now-generally-available/4365718).

---


### General Availability - Improving visibility into downstream tenant sign-ins

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

Microsoft Security wants to ensure that all customers are aware of how to notice when a partner is accessing a downstream tenant's resources. Interactive sign-in logs currently provide a list of sign in events, but there's no clear indication of which logins are from partners accessing downstream tenant resources. For example, when reviewing the logs, you might see a series of events, but without any additional context, it’s difficult to tell whether these logins are from a partner accessing another tenant’s data.

Here's a list of steps that one can take to clarify which logins are associated with partner tenants:

1. Take note of the  "ServiceProvider" value in the CrossTenantAccessType column:
    - This filter can be applied to refine the log data. When activated, it immediately isolates events related to partner logins.
2. Utilize the "Home Tenant ID" and "Resource Tenant ID" Columns:
    - These two columns identify logins coming from the partner’s tenant to a downstream tenant.


After seeing a partner logging into a downstream tenant’s resources, an important follow-up activity to perform is to validate the activities that might have occurred in the downstream environment. Some examples of logs to look at are Microsoft Entra Audit logs for Microsoft Entra ID events, Microsoft 365 Unified Audit Log (UAL) for Microsoft 365 and Microsoft Entra ID events, and/or the Azure Monitor activity log for Azure events. By following these steps, you're able to clearly identify when a partner is logging into a downstream tenant’s resources and subsequent activity in the environment, enhancing your ability to manage and monitor cross-tenant access efficiently.

To increase visibility into the aforementioned columns, Microsoft Entra will begin enabling these columns to display by default when loading the sign-in logs UX starting on March 7, 2025.

---

### Public Preview - Auditing administrator events in Microsoft Entra Connect

**Type:** New feature    
**Service category:** Microsoft Entra Connect    
**Product capability:** Microsoft Entra Connect    

We have released a new version of Microsoft Entra Connect, version 2.4.129.0, that supports the logging of the changes an administrator makes on the Connect Sync Wizard and PowerShell. For more information, see: [Auditing administrator events in Microsoft Entra Connect Sync (Public Preview)](../identity/hybrid/connect/admin-audit-logging.md).

Where supported, we'll also autoupgrade customers to this version of Microsoft Entra Connect in February 2025. For customers who wish to be autoupgraded, [ensure that you have auto-upgrade configured](../identity/hybrid/connect/how-to-connect-install-automatic-upgrade.md).

For upgrade-related guidance, see [Microsoft Entra Connect: Upgrade from a previous version to the latest](../identity/hybrid/connect/how-to-upgrade-previous-version.md).

---

### Public Preview - Flexible Federated Identity Credentials

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** Developer Experience    

Flexible Federated Identity Credentials extend the existing Federated Identity Credential model by providing the ability to use wildcard matching against certain claims. Currently available for GitHub, GitLab, and Terraform Cloud scenarios, this functionality can be used to lower the total number of FICs required to managed similar scenarios. For more information, see: [Flexible federated identity credentials (preview)](../workload-id/workload-identities-flexible-federated-identity-credentials.md).

---

### General Availability - Real-time Password Spray Detection in Microsoft Entra ID Protection

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Traditionally, password spray attacks are detected post breach or as part of hunting activity. Now, we’ve enhanced Microsoft Entra ID Protection to detect password spray attacks in real-time before the attacker ever obtains a token. This reduces remediation from hours to seconds by interrupting attacks during the sign-in flow.

Risk-based Conditional Access can automatically respond to this new signal by raising session risk, immediately challenging the sign-in attempt, and stopping password spray attempts in their tracks. This cutting-edge detection, now Generally Available, works alongside existing detections for advanced attacks such as Adversary-in-the-Middle (AitM) phishing and token theft, to ensure comprehensive coverage against modern attacks. For more information, see: [What is Microsoft Entra ID Protection?](../id-protection/overview-identity-protection.md)

---

### General Availability - Protected actions for hard deletions

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Security & Protection    

Customers can now configure Conditional Access policies to protect against early hard deletions. Protected action for hard deletion protects hard deletion of users, Microsoft 365 groups, and applications. For more information, see: [What are protected actions in Microsoft Entra ID?](../identity/role-based-access-control/protected-actions-overview.md).

---

### Public Preview - Elevate Access events are now exportable via Microsoft Entra Audit Logs

**Type:** New feature    
**Service category:** RBAC    
**Product capability:** Monitoring & Reporting    

This feature enables administrators to export and stream Elevate Access events to both first-party and third-party SIEM solutions via Microsoft Entra Audit logs. It enhances detection and improves logging capabilities, allowing visibility into who in their tenant has utilized Elevate Access. For more information on how to use the feature, see: [View elevate access log entries](/azure/role-based-access-control/elevate-access-global-admin?tabs=azure-portal%2Centra-audit-logs#view-elevate-access-log-entries).

---


### Deprecated - Action Required by February 1, 2025: Azure AD Graph retirement

**Type:** Deprecated    
**Service category:** Azure AD Graph    
**Product capability:** Developer Experience    

The Azure AD Graph API service was [deprecated] in 2020. [Retirement of the Azure AD Graph API service](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/june-2024-update-on-azure-ad-graph-api-retirement/ba-p/4094534) began in September 2024, and the next phase of this retirement starts February 1, 2025. This phase will impact new and existing applications unless action is taken. The latest updates on Azure AD Graph retirement can be found here: [Take action by February 1: Azure AD Graph is retiring](https://aka.ms/AzureADGraphRetirement).

Starting from February 1, both new and existing applications will be prevented from calling Azure AD Graph APIs, unless they're configured for an extension. You might not see impact right away, as we’re rolling out this change in stages across tenants. We anticipate full deployment of this change around the end of February, and by the end of March for national cloud deployments.

If you haven't already, it's now urgent to review the applications on your tenant to see which ones depend on Azure AD Graph API access, and mitigate or migrate these before the February 1 cutoff date. For applications that haven't migrated to Microsoft Graph APIs, [an extension](/graph/applications-authenticationbehaviors?tabs=http#allow-extended-azure-ad-graph-access-until-june-30-2025) can be set to allow the application access to Azure AD Graph through June 30, 2025.

Microsoft Entra Recommendations are the best tool to identify applications that are using Azure AD Graph APIs in your tenant and require action. Reference this blog post: Action required: [Azure AD Graph API retirement](https://techcommunity.microsoft.com/blog/identity/action-required-azure-ad-graph-api-retirement/4090533) for step by step guidance.

---

### General Availability - Microsoft Entra Connect Version 2.4.129.0

**Type:** Changed feature    
**Service category:** Microsoft Entra Connect    
**Product capability:** Microsoft Entra Connect    

On January 15, 2025, we released Microsoft Entra Connect Sync Version 2.4.129.0 which supports auditing administrator events. More details are available in the [release notes](../identity/hybrid/connect/reference-connect-version-history.md#241290). We'll automatically upgrade eligible customers to this latest version of Microsoft Entra Connect in February 2025. For customers who wish to be autoupgraded, [ensure that you have auto-upgrade configured](../identity/hybrid/connect/how-to-connect-install-automatic-upgrade.md).  

---


### Deprecated - Take action to avoid impact when legacy MSOnline and AzureAD PowerShell modules retire

**Type:** Deprecated    
**Service category:** Legacy MSOnline and AzureAD PowerShell modules    
**Product capability:** Developer Experience    

As announced in Microsoft Entra [change announcements](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/ChangeManagementHubList.ReactView) and in the Microsoft Entra [Blog](https://techcommunity.microsoft.com/blog/identity/important-update-deprecation-of-azure-ad-powershell-and-msonline-powershell-modu/4094536), the MSOnline, and Microsoft Azure AD PowerShell modules (for Microsoft Entra ID) retired on March 30, 2024.

The retirement for MSOnline PowerShell module starts in early April 2025, and ends in late May 2025. If you're using MSOnline PowerShell, you must take action by March 30, 2025 to avoid impact after the retirement by migrating any use of MSOnline to [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation) or [Microsoft Entra PowerShell](/powershell/entra-powershell/installation).

Key points

- MSOnline PowerShell will retire, and stop working, between early April 2025 and late May 2025
- AzureAD PowerShell will no longer be supported after March 30, 2025, but its retirement will happen in early July 2025. This postponement is to allow you time to finish the MSOnline PowerShell migration
- To ensure customer readiness for MSOnline PowerShell retirement, a series of temporary outage tests will occur for all tenants between January 2025 and March 2025.

For more information, see: [Action required: MSOnline and AzureAD PowerShell retirement - 2025 info and resources](https://techcommunity.microsoft.com/blog/identity/action-required-msonline-and-azuread-powershell-retirement---2025-info-and-resou/4364991).

---

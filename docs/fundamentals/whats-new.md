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
ms.date: 08/25/2025
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

>Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

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

We'll auto-upgrade customers where supported. For customers who wish to be auto-upgraded, [ensure that you have auto-upgrade configured](../identity/hybrid/connect/how-to-connect-install-automatic-upgrade.md).  

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

*   [Recommendation: Migrate from Microsoft Authentication Library to MSAL](../identity/monitoring-health/recommendation-migrate-from-adal-to-msal.md)
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

The Conditional Access Optimization Agent now supports a new setting that allows admins to configure if the agent can or cannot create report-only mode policies autonomously. If turned off, the agent will only create policies upon admin approval. For more information, see: [Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot](../security-copilot/conditional-access-agent-optimization.md#agent-capabilities).

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
 
Now customers can manage and customize Lifecycle Workflows using natural language with Microsoft Security CoPilot in Microsoft Entra. Our Lifecycle Workflows (LCW) Copilot solution provides step-by-step guidance to perform key workflow configuration and execution tasks using natural language. It allows customers to quickly get rich insights to help monitor and troubleshoot workflows for compliance. For more information, see: [Manage employee lifecycle using Microsoft Security Copilot](../security-copilot/entra-lifecycle-workflows.md).
 
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

CRL Fail Safe ensures that CBA auth fails if the end user certificate issuing CA does not have a Certificate Revocation List (CRL) configured. This closes a critical security gap where certificates could previously be accepted without revocation validation. Admins can enable this at the tenant level and configure exceptions for specific CAs as needed. For more information, see: [Understanding CRL validation](../identity/authentication/concept-certificate-based-authentication-certificate-revocation-list.md#enforce-crl-validation-for-cas).
 
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

[Conditional Access Optimization Agent in Microsoft Entra](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/new-innovations-in-microsoft-entra-to-strengthen-ai-security-and-identity-protec/3827393) monitors for new users or apps not covered by existing policies, identifies necessary updates to close security gaps, and recommends quick fixes for identity teams to apply with a single selection. For more information, see: [Microsoft Entra Conditional Access optimization agent](../security-copilot/conditional-access-agent-optimization.md).

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

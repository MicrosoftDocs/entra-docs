---
title: Microsoft Entra releases and announcements
description: Learn what is new with Microsoft Entra, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
author: owinfreyATL
manager: femila
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 02/06/2025
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see: [Archive for What's new in Microsoft Entra](whats-new-archive.md).

>Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

## March 2025

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


### Public Preview - Enhanced user management in Admin Center UX

**Type:** New feature    
**Service category:** User Management    
**Product capability:** User Management    

Admins are now able to multi-select and edit users at once through the Microsoft Entra Admin Center. With this new capability, admins can bulk edit user properties, add users to groups, edit account status, and more. This UX enhancement will significantly improve efficiency for user management tasks in the Microsoft Entra admin center. For more information, see: [Add or update a user's profile information and settings in the Microsoft Entra admin center](how-to-manage-user-profile-info.yml).

---

### Public Preview – QR code authentication, a simple and fast authentication method for Frontline Workers

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

We're thrilled to announce public preview of QR code authentication in Microsoft Entra ID, providing an efficient and simple authentication method for frontline workers.

You see a new authentication method ‘QR code’ in Microsoft Entra ID Authentication method Policies. You can enable and add QR code for your frontline workers via Microsoft Entra ID, My Staff, or MS Graph APIs. All users in your tenant see a new link ‘Sign in with QR code’ on navigating to https://login.microsoftonline.com > ‘Sign-in options’ > ‘Sign in to an organization’ page. This new link is visible only on mobile devices (Android/iOS/iPadOS). Users can use this auth method only if you add and provide a QR code to them. QR code auth is also available in BlueFletch and Jamf. MHS QR code auth support is generally available by early March.

The feature has a ‘preview’ tag until it's generally available. For more information, see: [Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)](../identity/authentication/concept-authentication-qr-code.md).

---

### Public Preview - Custom SAML/WS-Fed External Identity Provider Support in Microsoft Entra External ID

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

By setting up federation with a custom-configured identity provider that supports the SAML 2.0 or WS-Fed protocol, you enable your users to sign up and sign in to your applications using their existing accounts from the federated external provider.

This feature also includes domain-based federation, so a user who enters an email address on the sign-in page that matches a predefined domain in any of the external identity providers will be redirected to authenticate with that identity provider.

For more information, see: [Custom SAML/WS-Fed identity providers (preview)](../external-id/customers/concept-authentication-methods-customers.md#custom-samlws-fed-identity-providers-preview).

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

## December 2024

### General Availability - What's new in Microsoft Entra

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

What's new in Microsoft Entra offers a comprehensive view of Microsoft Entra product updates including product roadmap (like Public Previews and recent GAs), and change announcements (like deprecations, breaking changes, feature changes and Microsoft-managed policies). It's a one stop shop for Microsoft Entra admins to discover the product updates.

---

### Public Preview - Microsoft Entra ID Governance: Approvers can revoke access in MyAccess

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

For Microsoft Entra ID Governance users, approvers of access package requests can now revoke their decision in MyAccess. Only the person who took the approve action is able to revoke access. To opt into this feature, admins can go to the [Identity Governance settings page](https://entra.microsoft.com/#view/Microsoft_AAD_ERM/DashboardBlade/~/elmSetting), and enable the feature. For more information, see: [What is the My Access portal?](..//id-governance/my-access-portal-overview.md#approve-or-deny-a-request).

---

### General Availability - Expansion of SSPR Policy Audit Logging 

**Type:** New feature    
**Service category:** Self Service Password Reset    
**Product capability:** Monitoring & Reporting    

Starting Mid-January, we are improving the audit logs for changes made to the SSPR Policy.

With this improvement, any change to the SSPR policy configuration, including enablement or disablement, will result in an audit log entry that includes details about the change made. Additionally, both the previous values and current values from the change will be recorded within the audit log. This additional information can be found by selecting an audit log entry and selecting the Modified Properties tab within the entry.

These changes are rolled out in phases:

- Phase 1 includes logging for the Authentication Methods, Registration, Notifications, and Customization configuration settings.

- Phase 2 includes logging for the On-premises integration configuration settings.

This change occurs automatically, so admins take no action. For more information and details regarding this change, see: [Microsoft Entra audit log categories and activities](..//identity/monitoring-health/reference-audit-activities.md).

---

### General Availability - Update Profile Photo in MyAccount

**Type:** New feature    
**Service category:** My Profile/Account    
**Product capability:** End User Experiences    

Users can now update their profile photo directly from their MyAccount portal. This change exposes a new edit button on the profile photo section of the user’s account.

In some environments, it’s necessary to prevent users from making this change. Global Administrators can manage this using a tenant-wide policy with Microsoft Graph API, following the guidance in the [Manage user profile photo settings in Microsoft 365](/graph/profilephoto-configure-settings) document.

---

### General Availability - Temporary Access Pass (TAP) support for internal guest users

**Type:** New feature    
**Service category:** MFA    
**Product capability:** Identity Security & Protection    

Microsoft Entra ID now supports issuing Temporary Access Passes (TAP) to internal guest users. TAPs can be issued to internal guests just like normal members, through the Microsoft Entra ID Admin Center, or natively through Microsoft Graph. With this enhancement, internal guests can now seamlessly onboard, and recover, their accounts with time-bound temporary credentials. For more information, see: [Configure Temporary Access Pass to register passwordless authentication methods](../identity/authentication/howto-authentication-temporary-access-pass.md).

---

### Public Preview - Microsoft Entra ID Governance: access package request suggestions

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

**Opt-In** As communicated [earlier](https://techcommunity.microsoft.com/blog/identity/whats-new-in-microsoft-entra---september-2024/4253153), we're excited to introduce a new feature in [My Access](https://myaccess.microsoft.com): a curated list of suggested access packages. This capability allows users to quickly view the most relevant access packages (based off their peers' access packages and previous requests) without scrolling through a long list. In December you can [enable the preview in the Opt-in Preview Features for Identity Governance](https://entra.microsoft.com/?feature.msaljs=true#view/Microsoft_AAD_ERM/DashboardBlade/~/elmSetting). From January, this setting is enabled by default.

---

### Public Preview - Security Copilot embedded in Microsoft Entra

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Security & Protection    

We’ve announced the public preview of Microsoft Security Copilot embedded in the Microsoft Entra admin Center. This integration brings all identity skills previously made generally available for the Security Copilot standalone experience in April 2024, along with new identity capabilities for admins and security analysts to use directly within the Microsoft Entra admin center. We've also added brand new skills to help improve identity-related risk investigation. In December, we broaden the scope even further to include a set of skills specifically for App Risk Management in both standalone and embedded experiences of Security Copilot and Microsoft Entra. These capabilities allow identity admins and security analysts to better identify, understand, and remediate the risks impacting applications and workload identities registered in Microsoft Entra.

With Security Copilot now embedded in Microsoft Entra, identity admins get AI-driven, natural-language summaries of identity context and insights tailored for handling security incidents, equipping them to better protect against identity compromise. The embedded experience also accelerates troubleshooting tasks like resolving identity-related risks and sign-in issues, without ever leaving the admin center.  

---

### Public Preview - Security Copilot in Microsoft Entra: App Risk skills

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Security & Protection        

Identity admins and security analysts managing Microsoft Entra ID registered apps can identify and understand risks through natural language prompts. Security Copilot has links to the Microsoft Entra Admin Center for admins to take needed remediation actions. For more information, see: [Assess application risks using Microsoft Security Copilot in Microsoft Entra](../fundamentals/copilot-security-entra-investigate-risky-apps.md).

---

### Public Preview - Provision custom security attributes from HR sources

**Type:** New feature    
**Service category:** Provisioning    
**Product capability:** Inbound to Entra ID    

With this feature, customers can automatically provision "*custom security attributes*" in Microsoft Entra ID from authoritative HR sources. Supported authoritative sources include: Workday, SAP SuccessFactors, and any HR system integrated using API-driven provisioning.

---

### Public Preview - Sign in with Apple

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** Extensibility    

This new feature adds Apple to our list of preconfigured social identity providers. As the first social identity provider implemented on the eSTS platform, it introduces a "*Sign in with Apple*" button to the sign-in options, allowing users to access applications with their Apple accounts. For more information, see: [Add Apple as an identity provider (preview)](../external-id/customers/how-to-apple-federation-customers.md).

---

### General Availability - Microsoft Entra External ID Custom URL Domains

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** Identity Lifecycle Management    

This feature allows users to customize their Microsoft default sign in authentication endpoint with their own brand names. Custom URL Domains help users to change Ext ID endpoint < tenant-name >.ciamlogin.com to login.contoso.com.

---

### General Availability - Privileged Identity Management integration in Azure Role Based Access Control

**Type:** New feature    
**Service category:** RBAC    
**Product capability:** Access Control    

Privileged Identity Management (PIM) capabilities are now integrated into the Azure Role Based Access Control (Azure RBAC) UI. Before this integration, RBAC admins could only manage standing access (active permanent role assignments) from the Azure RBAC UI. With this integration, just-in-time access and timebound access, which are functionalities supported by PIM, are now brought into the Azure RBAC UI for customers with either a P2, or Identity Governance, license.

RBAC admins can create assignments of type eligible and timebound duration from the Azure RBAC add role assignment flow, see the list of different states of role assignment in a single view, as well as convert the type and duration of their role assignments from the Azure RBAC UI. In addition, end users now see all their role assignments of different state straight from the Azure RBAC UI landing page, from where they can also activate their eligible role assignments. For more information, see: [List role assignments at a scope](/azure/role-based-access-control/role-assignments-list-portal#list-role-assignments-at-a-scope).

---

### General Availability - Dedicated new 1st party resource application to enable Active Directory to Microsoft Entra ID sync using Microsoft Entra Connect Sync or Cloud Sync

**Type:** Changed feature    
**Service category:** Provisioning    
**Product capability:** Directory    

As part of ongoing security hardening, Microsoft deployed Microsoft Entra AD Synchronization Service, a dedicated first-party application to enable the synchronization between Active Directory and Microsoft Entra ID. This new application, with Application Id `6bf85cfa-ac8a-4be5-b5de-425a0d0dc016`, was provisioned in customer tenants that use Microsoft Entra Connect Sync or the Microsoft Entra Cloud Sync service. 

---


## November 2024

### Public Preview - Universal Continuous Access Evaluation

**Type:** New feature       
**Service category:** Provisioning        
**Product capability:** Network Access        

Continuous Access Evaluation (CAE) revokes, and revalidates, network access in near real-time whenever Microsoft Entra ID detects changes to the identity. For more information, see: [Universal Continuous Access Evaluation (Preview)](../global-secure-access/concept-universal-continuous-access-evaluation.md).

---

### Public Preview - Microsoft Entra new store for certificate-based authentication

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Microsoft Entra ID has a new scalable **PKI (Public Key Infrastructure) based CA** (Certificate Authorities) store with higher limits for the number of CAs and the size of each CA file. PKI based CA store allows CAs within each different PKI to be in its own container object allowing administrators to move away from one flat list of CAs to more efficient PKI container based CAs. PKI-based CA store now supports up to 250CAs, 8KB size for each CA and also supports issuers hints attribute for each CA. Administrators can also upload the entire PKI and all the CAs using the "Upload CBA PKI" feature or create a PKI container and upload CAs individually. For more information, see: [Step 1: Configure the certificate authorities with PKI-based trust store (Preview)](../identity/authentication/how-to-certificate-based-authentication.md#step-1-configure-the-certificate-authorities-with-pki-based-trust-store-preview).

---

### Public Preview - Updating profile photo in MyAccount

**Type:** New feature    
**Service category:** My Profile/Account    
**Product capability:** End User Experiences    

On November 13, 2024, users received the ability to update their profile photo directly from their [MyAccount](https://myaccount.microsoft.com/) portal. This change exposes a new edit button on the profile photo section of the user’s account.

In some environments, it’s necessary to prevent users from making this change. Global Administrators can manage this using a tenant-wide policy with Microsoft Graph API, following the guidance in the [Manage user profile photo settings in Microsoft 365](/graph/profilephoto-configure-settings) document.

---

### General Availability - Microsoft Entra Health Monitoring, Health Metrics Feature

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

Microsoft Entra health monitoring, available from the Health pane, includes a set of low-latency pre-computed health metrics that can be used to monitor the health of critical user scenarios in your tenant. The first set of health scenarios includes MFA, CA-compliant devices, CA-managed devices, and SAML authentications. This set of monitor scenarios will grow over time. These health metrics are now released as general availability data streams, in conjunction with the public preview of an intelligent alerting capability. For more information, see: [What is Microsoft Entra Health?](../identity/monitoring-health/concept-microsoft-entra-health.md).

---

### General Availability - Microsoft Entra Connect Sync Version 2.4.27.0

**Type:** Changed feature       
**Service category:** Provisioning        
**Product capability:** Identity Governance        

On November 14, 2025, we released Microsoft Entra Connect Sync Version 2.4.27.0 that uses the OLE DB version 18.7.4 that further hardens our service.  Upgrade to this latest version of connect sync to improve your security. More details are available in the [release notes](../identity/hybrid/connect/reference-connect-version-history.md#24270). 

---

### Changed feature - expansion of WhatsApp as an MFA one-time passcode delivery channel for Entra ID

**Type:** Changed feature    
**Service category:** MFA    
**Product capability:** User Authentication    

In late 2023, Entra started leveraging WhatsApp as an alternate channel to deliver multifactor authentication (MFA) one-time passcodes to users in India and Indonesia. We saw improved deliverability, completion rates, and satisfaction when leveraging the channel in both countries. The channel was temporarily disabled in India in early 2024. Starting early December 2024, we will be re-enabling the channel in India, and expanding its use to additional countries.

Starting December 2024, users in India, and other countries can start receiving MFA text messages via WhatsApp. Only users that are enabled to receive MFA text messages as an authentication method, and already have WhatsApp on their phone, will get this experience. If a user with WhatsApp on their device is unreachable or doesn’t have internet connectivity, we will quickly fall back to the regular SMS channel. In addition, users receiving OTPs via WhatsApp for the first time will be notified of the change in behavior via SMS text message. 

If you don’t want your users to receive MFA text messages through WhatsApp, you can disable text messages as an authentication method in your organization or scope it down to only be enabled for a subset of users. Please note that we highly encourage organizations move to using more modern, secure methods like Microsoft Authenticator and passkeys in favor of telecom and messaging app methods. For more information, see: [Text message verification](../identity/authentication/concept-authentication-phone-options.md#text-message-verification).

---

### Retirement - MFA Fraud Alert will be retired on March 1st 2025

**Type:** Deprecated    
**Service category:** MFA    
**Product capability:** Identity Security & Protection    

Microsoft Entra multifactor authentication (MFA) fraud alert allows end users to report MFA voice calls, and Microsoft Authenticator push requests, they didn't initiate as fraudulent. Beginning March 1, 2025, MFA Fraud Alert will be retired in favor of the replacement feature [Report Suspicious Activity](../identity/authentication/howto-mfa-mfasettings.md#report-suspicious-activity) which allows end users to report fraudulent requests, and is also integrated with [Identity Protection](../id-protection/overview-identity-protection.md) for more comprehensive coverage and remediation. To ensure users can continue reporting fraudulent MFA requests, organizations should migrate to using Report Suspicious Activity, and review how reported activity is remediated based on their Microsoft Entra licensing. For more information, see: [Configure Microsoft Entra multifactor authentication settings](../identity/authentication/howto-mfa-mfasettings.md).

---

### Public Preview - Microsoft Entra Health Monitoring, Alerts Feature

**Type:** Changed feature    
**Service category:** Other    
**Product capability:** Monitoring & Reporting    

Intelligent alerts in Microsoft Entra health monitoring notify tenant admins, and security engineers, whenever a monitored scenario breaks from its typical pattern. Microsoft Entra's alerting capability watches the low-latency health signals of each scenario, and fires a notification in the event of an anomaly. The set of alert-ready health signals and scenarios will grow over time. This alerts feature is now available in Microsoft Entra Health as an API-only public preview release (UX release is scheduled for February 2025). For more information, see: [How to use Microsoft Entra Health monitoring alerts (preview)](../identity/monitoring-health/howto-use-health-scenario-alerts.md).

---

### General Availability - Log analytics sign-in logs schema is in parity with MSGraph schema

**Type:** Plan for change    
**Service category:** Authentications (Logins)    
**Product capability:** Monitoring & Reporting    

To maintain consistency in our core logging principles, we've addressed a legacy parity issue where the Azure Log Analytics sign-in logs schema did not align with the MSGraph sign-in logs schema. The updates include fields such as ClientCredentialType, CreatedDateTime, ManagedServiceIdentity, NetworkLocationDetails, tokenProtectionStatus, SessionID, among others. These changes will take effect in the first week of December 2024.

We believe this enhancement will provide a more consistent logging experience. As always, you can perform pre-ingestion transformations to remove any unwanted data from your Azure Log Analytics storage workspaces. For guidance on how to perform these transformations, see: [Data collection transformations in Azure Monitor](/azure/azure-monitor/essentials/data-collection-transformations).

---

### Deprecated - MIM hybrid reporting agent

**Type:** Deprecated    
**Service category:** Microsoft Identity Manager    
**Product capability:** Monitoring & Reporting    

The hybrid reporting agent, used to send a MIM Service event log to Microsoft Entra to surface in password reset and self-service group management reports, is deprecated. The recommended replacement is to use Azure Arc to send the event logs to Azure Monitor. For more information, see: [Microsoft Identity Manager 2016 reporting with Azure Monitor](/microsoft-identity-manager/mim-azure-monitor-reporting).

---

## October 2024

### Public Preview - Passkey authentication in brokered Microsoft apps on Android

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Microsoft Entra ID users can now use a passkey to sign into Microsoft apps on Android devices where an authentication broker like Microsoft Authenticator, or Microsoft Intune Company Portal, is installed. For more information, see: [Support for FIDO2 authentication with Microsoft Entra ID](../identity/authentication/concept-fido2-compatibility.md).

---

### Public Preview Refresh - Passkeys in Microsoft Authenticator

**Type:** New feature    
**Service category:** Microsoft Authenticator App    
**Product capability:** User Authentication    

Public preview of passkeys in the Microsoft Authenticator will now support additional features. Admins can now require attestation during registration of a passkey, and Android native apps now supports signing in with passkeys in the Authenticator. Additionally, users are now prompted to sign in to the Authenticator app to register a passkey when initiating the flow from MySignIns. The Authenticator app passkey registration wizard walks the user through meeting all the prerequisites within the context of the app before attempting registration. Download the latest version of the Authenticator app and give us feedback as you pilot these changes in your organization. For more information, see: [Enable passkeys in Microsoft Authenticator (preview)](../identity/authentication/how-to-enable-authenticator-passkey.md).

---

### Public Preview - Authentication methods migration wizard

**Type:** New feature    
**Service category:** MFA    
**Product capability:** User Authentication    

The authentication methods migration guide (preview) in the Microsoft Entra admin center lets you automatically migrate method management from the [legacy MFA and SSPR policies](../identity/authentication/concept-authentication-methods-manage.md#legacy-mfa-and-sspr-policies) to the [converged authentication methods policy](../identity/authentication/concept-authentication-methods-manage.md). In 2023, it was announced that the ability to manage authentication methods in the legacy MFA and SSPR policies would be retired in September 2025. Until now, organizations had to manually migrate methods themselves by leveraging [the migration toggle](../identity/authentication/how-to-authentication-methods-manage.md#start-the-migration) in the converged policy. Now, you can migrate in just a few selections by using the migration guide. The guide evaluates what your organization currently has enabled in both legacy policies, and generates a recommended converged policy configuration for you to review and edit as needed. From there, simply confirm the configuration and we set it up for you and mark your migration as complete. For more information, see: [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](../identity/authentication/how-to-authentication-methods-manage.md).

---

### General availability- SMS as an MFA method in Microsoft Entra External ID

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

Announcing general availability of SMS as an MFA method in Microsoft Entra External ID with built-in telecom fraud protection through integrations with the Phone Reputation Platform.

**What's new?**

- SMS sign-in experience that maintains the look and feel of the application users are accessing.
- SMS is an add-on feature. We'll apply an additional charge per SMS sent to the user which will include the built-in fraud protection services.
- Built-in fraud protection against telephony fraud through our integration with the Phone Reputation platform. This platform processes telephony activity in real-time and returns an "Allow", "Block" or "Challenge" based on risk and a series of heuristics.


For more information, see: [Multifactor authentication in external tenants](../external-id/customers/concept-multifactor-authentication-customers.md).

---

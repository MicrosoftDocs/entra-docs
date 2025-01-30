---
title: Microsoft Entra releases and announcements
description: Learn what is new with Microsoft Entra, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
author: owinfreyATL
manager: amycolannino
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 12/02/2024
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
---

# Microsoft Entra releases and announcements

This article provides information about the latest releases and change announcements across the Microsoft Entra family of products over the last six months (updated monthly). If you're looking for information that's older than six months, see [Archive for What's new in Microsoft Entra](whats-new-archive.md). 

For a more dynamic experience, you can now find this information in the Microsoft Entra admin center. To learn more, see [What's new (preview)](./whats-new-overview.md).

>Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

> [!NOTE] 
> If you're currently using Azure Active Directory today or are have previously deployed Azure Active Directory in your organizations, you can continue to use the service without interruption. All existing deployments, configurations, and integrations continue to function as they do today without any action from you.

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

Traditionally, security admins comb through logs to identify password spray attack patterns. Now, we’ve enhanced Microsoft Entra ID Protection to detect password spray attacks in real-time. It reduces remediation from hours to seconds by interrupting attacks during the sign-in flow.

Risk-based Conditional Access can automatically respond to this new signal by raising session risk, immediately challenging the next risky sign-in attempt, and stopping password spray attempts in their tracks. This cutting-edge detection, coming soon to public preview, works alongside existing detections for advanced attacks such as Adversary-in-the-Middle (AitM) phishing and token theft, to ensure comprehensive coverage against modern attacks. For more information, see: [What is Microsoft Entra ID Protection?](../id-protection/overview-identity-protection.md)

---

### General Availability - Protected actions for hard deletions

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Security & Protection    

Customers can now configure Conditional Access policies to protect against early hard deletions. Protected action for hard deletion protects hard deletion of users, Microsoft 365 groups, and applications. For more information, see: [What are protected actions in Microsoft Entra ID?](../identity/role-based-access-control/protected-actions-overview.md)

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

### Public Preview - Elevate Access events are now exportable via Microsoft Entra Audit Logs

**Type:** New feature    
**Service category:** RBAC    
**Product capability:** Monitoring & Reporting    

This feature enables administrators to export and stream Elevate Access events to both first-party and third-party SIEM solutions via Microsoft Entra Audit logs. It enhances detection and improves logging capabilities, allowing visibility into who in their tenant has utilized Elevate Access. For more information on how to use the feature, see: [View elevate access log entries](/azure/role-based-access-control/elevate-access-global-admin?tabs=azure-portal%2Centra-audit-logs#view-elevate-access-log-entries).

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

### General Availability - Dedicated new 1st party resource application to enable Active Directory to Microsoft Entra ID sync using Microsoft Entra Connect Sync or Cloud Sync

**Type:** Changed feature    
**Service category:** Provisioning    
**Product capability:** Directory    

As part of ongoing security hardening, Microsoft deployed Microsoft Entra AD Synchronization Service, a dedicated first-party application to enable the synchronization between Active Directory and Microsoft Entra ID. This new application, with Application Id 6bf85cfa-ac8a-4be5-b5de-425a0d0dc016, was provisioned in customer tenants that use Microsoft Entra Connect Sync or the Microsoft Entra Cloud Sync service. 

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

This change occurs automatically, so admins take no action. For more information and details regarding this change, see: [Microsoft Entra audit log categories and activities](..//identity/monitoring-health/reference-audit-activities.md)

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


## November 2024

### Public Preview - Universal Continuous Access Evaluation

**Type:** New feature       
**Service category:** Provisioning        
**Product capability:** Network Access        

Continuous Access Evaluation (CAE) revokes, and revalidates, network access in near real-time whenever Microsoft Entra ID detects changes to the identity. For more information, see: [Universal Continuous Access Evaluation (Preview)](../global-secure-access/concept-universal-continuous-access-evaluation.md).

---

### General Availability - Microsoft Entra Connect Sync Version 2.4.27.0

**Type:** Changed feature       
**Service category:** Provisioning        
**Product capability:** Identity Governance        

On November 14, 2025, we released Microsoft Entra Connect Sync Version 2.4.27.0 that uses the OLE DB version 18.7.4 that further hardens our service.  Upgrade to this latest version of connect sync to improve your security. More details are available in the [release notes](../identity/hybrid/connect/reference-connect-version-history.md#24270). 

---

### Public Preview - Microsoft Entra new store for certificate-based authentication

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Microsoft Entra ID has a new scalable **PKI (Public Key Infrastructure) based CA** (Certificate Authorities) store with higher limits for the number of CAs and the size of each CA file. PKI based CA store allows CAs within each different PKI to be in its own container object allowing administrators to move away from one flat list of CAs to more efficient PKI container based CAs. PKI-based CA store now supports up to 250CAs, 8KB size for each CA and also supports issuers hints attribute for each CA. Administrators can also upload the entire PKI and all the CAs using the "Upload CBA PKI" feature or create a PKI container and upload CAs individually. For more information, see: [Step 1: Configure the certificate authorities with PKI-based trust store (Preview)](../identity/authentication/how-to-certificate-based-authentication.md#step-1-configure-the-certificate-authorities-with-pki-based-trust-store-preview).

---

### Changed feature - expansion of WhatsApp as an MFA one-time passcode delivery channel for Entra ID

**Type:** Changed feature    
**Service category:** MFA    
**Product capability:** User Authentication    

In late 2023, Entra started leveraging WhatsApp as an alternate channel to deliver multifactor authentication (MFA) one-time passcodes to users in India and Indonesia. We saw improved deliverability, completion rates, and satisfaction when leveraging the channel in both countries. The channel was temporarily disabled in India in early 2024. Starting early December 2024, we will be re-enabling the channel in India, and expanding its use to additional countries.

Starting December 2024, users in India, and other countries can start receiving MFA text messages via WhatsApp. Only users that are enabled to receive MFA text messages as an authentication method, and already have WhatsApp on their phone, will get this experience. If a user with WhatsApp on their device is unreachable or doesn’t have internet connectivity, we will quickly fall back to the regular SMS channel. In addition, users receiving OTPs via WhatsApp for the first time will be notified of the change in behavior via SMS text message. 

If you don’t want your users to receive MFA text messages through WhatsApp, you can disable text messages as an authentication method in your organization or scope it down to only be enabled for a subset of users. Please note that we highly encourage organizations move to using more modern, secure methods like Microsoft Authenticator and passkeys in favor of telecom and messaging app methods. For more information, see: [Text message verification](../identity/authentication/concept-authentication-phone-options.md#text-message-verification).

---

### Public Preview - Updating profile photo in MyAccount

**Type:** New feature    
**Service category:** My Profile/Account    
**Product capability:** End User Experiences    

On November 13, 2024, users received the ability to update their profile photo directly from their [MyAccount](https://myaccount.microsoft.com/) portal. This change exposes a new edit button on the profile photo section of the user’s account.

In some environments, it’s necessary to prevent users from making this change. Global Administrators can manage this using a tenant-wide policy with Microsoft Graph API, following the guidance in the [Manage user profile photo settings in Microsoft 365](/graph/profilephoto-configure-settings) document.

---

### Retirement - MFA Fraud Alert will be retired on March 1st 2025

**Type:** Deprecated    
**Service category:** MFA    
**Product capability:** Identity Security & Protection    

Microsoft Entra multifactor authentication (MFA) [fraud alert](../identity/authentication/howto-mfa-mfasettings.md#fraud-alert) allows end users to report MFA voice calls, and Microsoft Authenticator push requests, they didn't initiate as fraudulent. Beginning March 1, 2025, MFA Fraud Alert will be retired in favor of the replacement feature [Report Suspicious Activity](../identity/authentication/howto-mfa-mfasettings.md#report-suspicious-activity) which allows end users to report fraudulent requests, and is also integrated with [Identity Protection](../id-protection/overview-identity-protection.md) for more comprehensive coverage and remediation. To ensure users can continue reporting fraudulent MFA requests, organizations should migrate to using Report Suspicious Activity, and review how reported activity is remediated based on their Microsoft Entra licensing. For more information, see: [Configure Microsoft Entra multifactor authentication settings](../identity/authentication/howto-mfa-mfasettings.md).

---

### Public Preview - Microsoft Entra Health Monitoring, Alerts Feature

**Type:** Changed feature    
**Service category:** Other    
**Product capability:** Monitoring & Reporting    

Intelligent alerts in Microsoft Entra health monitoring notify tenant admins, and security engineers, whenever a monitored scenario breaks from its typical pattern. Microsoft Entra's alerting capability watches the low-latency health signals of each scenario, and fires a notification in the event of an anomaly. The set of alert-ready health signals and scenarios will grow over time. This alerts feature is now available in Microsoft Entra Health as an API-only public preview release (UX release is scheduled for February 2025). For more information, see: [How to use Microsoft Entra Health monitoring alerts (preview)](../identity/monitoring-health/howto-use-health-scenario-alerts.md).

---

### General Availability - Microsoft Entra Health Monitoring, Health Metrics Feature

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

Microsoft Entra health monitoring, available from the Health pane, includes a set of low-latency pre-computed health metrics that can be used to monitor the health of critical user scenarios in your tenant. The first set of health scenarios includes MFA, CA-compliant devices, CA-managed devices, and SAML authentications. This set of monitor scenarios will grow over time. These health metrics are now released as general availability data streams, in conjunction with the public preview of an intelligent alerting capability. For more information, see: [What is Microsoft Entra Health?](../identity/monitoring-health/concept-microsoft-entra-health.md).

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

## September 2024

### Public preview - New Conditional Access Template Requiring Device Compliance 

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

A new Conditional Access template requiring device compliance is now available in Public Preview. This template restricts access to company resources exclusively to devices enrolled in mobile device management (MDM) and compliant with company policy. Requiring device compliance improves data security, reducing risk of data breaches, malware infections, and unauthorized access. This is a recommended best practice for users and devices targeted by compliance policy through MDM. For more information, see: [Common policy: Create a Conditional Access policy requiring device compliance.](../identity/conditional-access/policy-all-users-device-compliance.md)

---

### Public preview - Tenant admin can fail certificate based auth when the end user certificate issuer isn't configured with a certificate revocation list

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

With Certificate based authentication, a CA can be uploaded without a CRL endpoint, and certificate-based authentication won't fail if an issuing CA doesn't have a CRL specified.

To strengthen security and avoid misconfigurations, an Authentication Policy Administrator can require CBA authentication to fail if no CRL is configured for a CA that issues an end user certificate. For more information, see: [Understanding CRL validation (Preview)](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-crl-validation-preview).

---

### General Availability: Microsoft Authenticator on Android is FIPS 140 compliant for Microsoft Entra authentication

**Type:** New feature    
**Service category:** Microsoft Authenticator App    
**Product capability:** User Authentication    

Beginning with version 6.2408.5807, Microsoft Authenticator for Android is compliant with Federal Information Processing Standard (FIPS 140-3) for all Microsoft Entra authentications, including phishing-resistant device-bound passkeys, push multifactor authentication (MFA), passwordless phone sign-in (PSI), and time-based one-time passcodes (TOTP). No changes in configuration are required in Microsoft Authenticator or Microsoft Entra ID Admin Portal to enable this capability. Microsoft Authenticator on iOS is already FIPS 140 compliant, as announced last year. For more information, see: [Authentication methods in Microsoft Entra ID - Microsoft Authenticator app](../identity/authentication/concept-authentication-authenticator-app.md).

---

### General Availability - Microsoft Entra External ID extension for Visual Studio Code

**Type:** Changed feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

[Microsoft Entra External ID Extension for VS Code](https://aka.ms/ciamvscode/newsletter/marketplace) provides a streamlined, guided experience to help you kickstart identity integration for customer-facing apps. With this extension, you can create external tenants, set up a customized and branded sign-in experience for external users, and quickly bootstrap your projects with preconfigured External ID samples—all within Visual Studio Code. Additionally, you can view and manage your external tenants, applications, user flows, and branding settings directly within the extension.

For more information, see: [Quickstart: Get started with the Microsoft Entra External ID extension for Visual Studio Code](../external-id/customers/visual-studio-code-extension.md).

---

### Public Preview - Custom Claims API for Claims Configuration of Enterprise Apps

**Type:** New feature    
**Service category:** Enterprise Apps    
**Product capability:** SSO    

Custom Claims API allows admins to manage and update additional claims for their Enterprise Applications seamlessly through MS Graph. The Custom Claims API offers a simplified and user friendly API experience for claims management for our customers. With the introduction of Custom Claims API, we achieved UX and API interoperability. Admins can now use Microsoft Entra admin center and MS Graph API interchangeably to manage claims configurations for their Enterprise Applications. It facilitates admins to execute their automations using the API while allowing the flexibility to update claims on the Microsoft Entra admin center as required on the same policy object. For more information, see: [Customize claims using Microsoft Graph Custom Claims Policy (preview)](../identity-platform/claims-customization-custom-claims-policy.md).

---

### General Availability - Cross-tenant manager synchronization

**Type:** New feature    
**Service category:** Provisioning    
**Product capability:** Identity Governance    

Support for synchronizing the manager attribute using cross-tenant synchronization is now generally available. For more information, see: [Attributes](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md#attributes).

---

### Public Preview - Request on behalf of

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

Entitlement Management enables admins to create access packages to manage their organization’s resources. Admins can either directly assign users to an access package, or configure an access package policy that allows users and group members to request access. This option to create self-service processes is useful, especially as organizations scale and hire more employees. However, new employees joining an organization might not always know what they need access to, or how they can request access. In this case, a new employee would likely rely on their manager to guide them through the access request process.

Instead of having new employees navigate the request process, managers can request access packages for their employees, making onboarding faster and more seamless. To enable this functionality for managers, admins can select an option when setting up an access package policy that allows managers to request access on their employees' behalf.

Expanding self-service request flows to allow requests on behalf of employees ensures that users have timely access to necessary resources, and increases productivity. For more information, see: [Request access package on-behalf-of other users (Preview)](../id-governance/entitlement-management-request-behalf.md).

---


## August 2024

### Change announcement - Upcoming MFA Enforcement on Microsoft Entra admin center

**Type:** Plan for change     
**Service category:** MFA   
**Product capability:** Identity Security & Protection    

As part of our commitment to providing our customers with the highest level of security, we previously [announced](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/update-on-mfa-requirements-for-azure-sign-in/ba-p/4177584) that Microsoft requires multifactor authentication (MFA) for users signing into Azure.

We'd like to share an update that the scope of MFA enforcement includes [Microsoft Entra admin center](https://entra.microsoft.com/) in addition to the Azure portal and Intune admin center. This change is rolled out in phases, allowing organizations time to plan their implementation:

**Phase 1**: Beginning in the second half of the calendar year 2024, MFA is required to sign in to the Microsoft Entra admin center, Azure portal, and Intune admin center. This enforcement is gradually rolled out to all tenants worldwide. This phase didn't affect other Azure clients such as the Azure Command Line Interface, Azure PowerShell, Azure mobile app, and Infrastructure as Code (IaC) tools.

**Phase 2**: Beginning in early 2025, gradual enforcement of MFA at sign-in for the Azure CLI, Azure PowerShell, Azure mobile app, and Infrastructure as Code (IaC) tools commences.

Microsoft sends a 60-day advance notice to all Microsoft Entra Global Administrators by email, and through Azure Service Health Notifications, to notify them of the start date of enforcement and required actions. Extra notifications are sent through the Azure portal, Microsoft Entra admin center, and the Microsoft 365 message center.

We understand that some customers might need extra time to prepare for this MFA requirement. Therefore, Microsoft allows extended time for customers with complex environments or technical barriers. The notification from us also includes details about how customers can postpone specific changes. These changes include the start date of enforcement for their tenants, the duration of the postponement, and a link to apply changes. Visit [here](../identity/authentication/concept-mandatory-multifactor-authentication.md) to learn more.

---

### General Availability - restricted permissions on Directory Synchronization Accounts (DSA) role in Microsoft Entra Connect Sync and Microsoft Entra Cloud Sync

**Type:** Changed feature     
**Service category:** Provisioning   
**Product capability:** Microsoft Entra Connects    

As part of ongoing security hardening, Microsoft removes unused permissions from the privileged *Directory Synchronization Accounts* role. This role is exclusively used by Microsoft Entra Connect Sync, and Microsoft Entra Cloud Sync, to synchronize Active Directory objects with Microsoft Entra ID. There's no action required by customers to benefit from this hardening, and the revised role permissions are documented here: [Directory Synchronization Accounts](../identity/role-based-access-control/permissions-reference.md#directory-synchronization-accounts).

---

### Plan for change - My Security-Info Add sign-in method picker UX update

**Type:** Plan for change     
**Service category:** MFA   
**Product capability:** End User Experiences    

Starting Mid-October 2024, the *Add sign-in* method dialog on the My Security-Info page will be updated with a modern look and feel. With this change, new descriptors will be added under each method which provides detail to users on how the sign-in method is used (ex. *Microsoft Authenticator – Approve sign-in requests* or *use one-time codes*).  

Early next year the *Add sign-in* method, dialog will be enhanced to show an initially recommended sign-in method instead of initially showing the full list of sign-in methods available to register. The recommended sign-in method will default to the strongest method available to the user based on the organization’s authentication method policy. Users can select *Show more options* and choose from all available sign-in methods allowed by their policy.

This change will occur automatically, so admins take no action.

---

### Public Preview - Provisioning UX Updates

**Type:** Plan for change    
**Service category:** Provisioning    
**Product capability:** Outbound to SaaS Applications    

We'll start releasing user experience updates for application provisioning, HR provisioning, and cross-tenant synchronization next month. These updates include a new overview page, user experience to configure connectivity to your application, and new create provisioning experience. The new experiences include all functionality available to customers today, and no customer action is required.

---

### Change Announcement - Deferred Changes to My Groups Admin Controls

**Type:** Plan for change    
**Service category:** Group Management    
**Product capability:** AuthZ/Access Delegation        

In [October 2023](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/what-s-new-in-microsoft-entra/ba-p/3796395), we shared that, starting June 2024, the existing Self Service Group Management setting in the Microsoft Entra Admin Center that states *restrict user ability to access groups features in My Groups* retires. These changes are under review, and might take place as originally planned. A new deprecation date will be announced in the future.

---

### Public Preview - Microsoft Entra ID FIDO2 provisioning APIs

**Type:** New feature    
**Service category:** MFA    
**Product capability:** Identity Security & Protection            

Microsoft Entra ID now supports FIDO2 provisioning via API, allowing organizations to pre-provision security keys (passkeys) for users. These new APIs can simplify user onboarding, and provide seamless phishing-resistant authentication on day one for employees. 
For more information on how to use this feature, see: [Provision FIDO2 security keys using Microsoft Graph API](../identity/authentication/how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).

---

### General Availability - Enable, Disable, and Delete synchronized users accounts with Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management            

Lifecycle Workflows is now able to enable, disable, and delete user accounts that are synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra. This capability allows you to complete the employee offboarding process by deleting the user account after a retention period.

To learn more, see: [Manage users synchronized from Active Directory Domain Services with workflows](../id-governance/manage-workflow-on-premises.md).

---

### General Availability - Configure Lifecycle Workflow Scope Using Custom Security Attributes

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management            

Customers can now use their confidential HR data stored in custom security attributes. They can do this addition to other attributes to define the scope of their workflows in Lifecycle Workflows for automating joiner, mover, and leaver scenarios.

To learn more, see: [Use custom security attributes to scope a workflow](..//id-governance/manage-workflow-custom-security-attribute.md).

---

### General Availability - Workflow History Insights in Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management              

With this feature, customers can now monitor workflow health, and get insights for all their workflows in Lifecycle Workflows including viewing workflow processing data across workflows, tasks, and workflow categories.

To learn more, see: [Lifecycle workflow Insights](../id-governance/lifecycle-workflow-insights.md).


---

### General Availability - Configure custom workflows to run mover tasks when a user's job profile changes

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management           

Lifecycle Workflows now supports the ability to trigger workflows based on job change events like changes to an employee's department, job role, or location, and see them executed on the workflow schedule. With this feature, customers can use new workflow triggers to create custom workflows for their executing tasks associated with employees moving within the organization including triggering:

- Workflows when a specified attribute changes
- Workflows when a user is added or removed from a group's membership
- Tasks to notify a user's manager about a move
- Tasks to assign licenses or remove selected licenses from a user

To learn more, see [Automated employee mover tasks when they change jobs using the Microsoft Entra admin center tutorial](../id-governance/tutorial-mover-custom-workflow-portal.md).

---

### General Availability -  Device based conditional access to M365/Azure resources on Red Hat Enterprise Linux

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** SSO              

Since October 2022, users on Ubuntu Desktop 20.04 LTS & Ubuntu 22.04 LTS with Microsoft Edge browser could register their devices with Microsoft Entra ID, enroll into Microsoft Intune management, and securely access corporate resources using device-based Conditional Access policies.

This release extends support to Red Hat Enterprise Linux 8.x and 9.x (LTS) which makes these capabilities possible:

- Microsoft Entra ID registration & enrollment of RedHat LTS (8/9) desktops.
- Conditional Access policies protecting web applications via Microsoft Edge.
-Provides SSO for native & web applications (ex: Azure CLI, Microsoft Edge browser, Teams progressive web app (PWA), etc.) to access M365/Azure protected resources.
- Standard Intune compliance policies.
- Support for Bash scripts with custom compliance policies.
- Package Manager now supports RHEL *RPM* packages in addition to Debian *DEB* packages.

To learn more, see: [Microsoft Entra registered devices](..//identity/devices/concept-device-registration.md).

---


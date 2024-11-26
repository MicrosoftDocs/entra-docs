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
ms.topic: whats-new
ms.date: 09/19/2024
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

## November 2024

### Public Preview - Microsoft Entra new store for certificate-based authentication

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Microsoft Entra ID has a new scalable **PKI (Public Key Infrastructure) based CA** (Certificate Authorities) store with higher limits for the number of CAs and the size of each CA file. PKI based CA store allows CAs within each different PKI to be in its own container object allowing administrators to move away from one flat list of CAs to more efficient PKI container based CAs. PKI-based CA store now supports up to 250CAs, 8KB size for each CA and also supports issuers hints attribute for each CA. Administrators can also upload the entire PKI and all the CAs using the "Upload CBA PKI" feature or create a PKI container and upload CAs individually. For more information, see: [Step 1: Configure the certificate authorities with PKI-based trust store (Preview)](../identity/authentication/how-to-certificate-based-authentication.md#step-1-configure-the-certification-authorities).

---

### Changed feature - expansion of WhatsApp as an MFA one-time passcode delivery channel for Entra ID

**Type:** Changed feature    
**Service category:** MFA    
**Product capability:** User Authentication    

In late 2023, Entra started leveraging WhatsApp as an alternate channel to deliver multifactor authentication (MFA) one-time passcodes to users in India and Indonesia. We saw improved deliverability, completion rates, and satisfaction when leveraging the channel in both countries. The channel was temporarily disabled in India in early 2024. Starting early December 2024, we will be re-enabling the channel in India, and expanding its use to additional countries.

Starting December 2024, users in India, and other countries can start receiving MFA text messages via WhatsApp. Only users that are enabled to receive MFA text messages as an authentication method, and already have WhatsApp on their phone, will get this experience. If a user with WhatsApp on their device is unreachable or doesn’t have internet connectivity, we will quickly fall back to the regular SMS channel. In addition, users receiving OTPs via WhatsApp for the first time will be notified of the change in behavior via SMS text message. 

If you don’t want your users to receive MFA text messages through WhatsApp, you can disable text messages as an authentication method in your organization or scope it down to only be enabled for a subset of users. Please note that we highly encourage organizations move to using more modern, secure methods like Microsoft Authenticator and passkeys in favor of telecom and messaging app methods. For more information, see: [Text message verification](../identity/authentication/concept-authentication-phone-options.md#text-message-verification).

---

### Public Preview - bring your own 3rd party email OTP provider for Microsoft Entra External ID

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** 3rd Party Integration    

Bring your own favorite email provider for email OTPs of sign-in and sign-up flows to Microsoft Entra External ID. You can use Azure Communication Service (ACS), or true 3rd party of choice making your authentication experiences consistently branded.


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

### Public Preview - Universal CAE

**Type:** New feature    
**Service category:** Other    
**Product capability:** Network Access    

Universal CAE revokes, and revalidates, network access in near real-time whenever Microsoft Entra ID detects changes to the identity. For more information, see: [Universal Continuous Access Evaluation (Preview)](../global-secure-access/concept-universal-continuous-access-evaluation.md).

---

### Change Announcement - Updates to “Target resources” in Microsoft Entra Conditional Access

**Type:** Changed feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

The Microsoft Entra Conditional Access '*Target resources*' assignment has a consolidated view for the "*Cloud apps*", and "*Global Secure Access*" options under a new name "*Resources*".

Customers can now target "All internet resources with Global Secure Access", "All resources (formerly 'all cloud apps'), or select specific resources (formerly "select apps"). For more information, see: [Conditional Access: Target resources](../identity/conditional-access/concept-conditional-access-cloud-apps.md).

---

### General Availability - Dedicated new 1p resource application to enable AD to Microsoft Entra ID sync using Microsoft Entra Connect Sync or Cloud Sync

**Type:** Changed feature    
**Service category:** Provisioning    
**Product capability:** Directory    

As part of ongoing security hardening, Microsoft will deploy a dedicated 1st party application to enable the synchronization between Active Directory and Microsoft Entra ID. This new application, called the "Microsoft Entra AD Synchronization Service" (Application Id: 6bf85cfa-ac8a-4be5-b5de-425a0d0dc016) will be provisioned in customer tenants using Microsoft Entra Connect Sync, or Microsoft Entra Cloud Sync service.

In the upcoming release(s), you will receive communications around deprecation of the current 1st party app that’s used for syncing between Active Directory and Microsoft Entra ID that would require you to update to the latest version of either Microsoft Entra Connect Sync, or Microsoft Entra Cloud Sync.

---

### General Availability - Dynamic Administrative Units

**Type:** New feature    
**Service category:** RBAC    
**Product capability:** AuthZ/Access Delegation    

Dynamic membership for users and devices in Administrative Units is now Generally Available.  Instead of manually assigning users and devices to administrative units, tenant admins can set up a query for the administrative unit.  The membership will be automatically maintained by Microsoft Entra ID. For more information, see: [Manage users or devices for an administrative unit with rules for dynamic membership groups](../identity/role-based-access-control/admin-units-members-dynamic.md).

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

Microsoft Entra health monitoring, available from the Health pane, includes a set of low-latency pre-computed health metrics that can be used to monitor the health of critical user scenarios in your tenant. The first set of health scenarios includes MFA, CA-compliant devices, CA-managed devices, and SAML authentications. This set of monitor scenarios will grow over time. These health metrics are now released as general availability data streams, in conjunction with the public preview of an intelligent alerting capability.

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
For more information on how to use this feature, see: [Provision FIDO2 security keys using Microsoft Graph API (preview)](../identity/authentication/how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).

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


## July 2024

### General Availability - Insider Risk condition in Conditional Access is GA

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

**Insider Risk condition in Conditional Access is now GA**

Insider Risk condition, in Conditional Access, is a new feature that uses signals from Microsoft Purview's Adaptive Protection capability to enhance the detection and automatic mitigation of Insider threats. This integration allows organizations to more effectively manage, and respond, to potential insider risks by using advanced analytics and real-time data.

For example, if Purview detects unusual activity from a user, Conditional Access can enforce extra security measures such as requiring multifactor authentication (MFA) or blocking access. This feature is a premium and requires a P2 license. For more information, see: [Common Conditional Access policy: Block access for users with insider risk](../identity/conditional-access/policy-risk-based-insider-block.md).

---

### General Availability - New SAML applications can't receive tokens through OAuth2/OIDC protocols

**Type:** Plan for change    
**Service category:** Enterprise Apps    
**Product capability:** Developer Experience    

Starting late September 2024, applications indicated as *SAML* applications (via the `preferredSingleSignOnMode` property of the service principal) can't be issued JWT tokens. This change means they can't be the resource application in OIDC, OAuth2.0, or other protocols using JWTs. This change only affects SAML applications attempting to take a new dependency on JWT-based protocols; existing SAML applications already using these flows aren't affected. This update improves the security of apps.  

For more information, see: [SAML authentication with Microsoft Entra ID](/entra/architecture/auth-saml).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - July 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** Third Party Integration          

In February 2024, we added the following 10 new applications in our App gallery with Federation support:

[Full story SAML](../identity/saas-apps/fullstory-saml-tutorial.md), [LSEG Workspace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/aad.lsegworkspace?tab=Overview)

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

### General Availability - Active Directory Federation Services (AD FS) Application Migration Wizard

**Type:** New feature    
**Service category:** AD FS Application Migration    
**Product capability:** Platform    

The Active Directory Federation Services (AD FS) application migration wizard allows the user to quickly identify which AD FS relying party applications are compatible with being migrated to Microsoft Entra ID. This tool shows the migration readiness of each application and highlights issues with suggested actions to remediate. This tool also guides users through preparing an individual application for migration and configuring their new Microsoft Entra application. For more information on how to use this feature, see: [Use AD FS application migration to move AD FS apps to Microsoft Entra ID](../identity/enterprise-apps/migrate-ad-fs-application-howto.md).

---

### General Availability -  Attacker in the Middle detection alert in Identity Protection

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

The Attacker in the Middle detection is now Generally Available for users in Identity Protection. 

This high precision detection is triggered on a user account compromised by an adversary that intercepted a user's credentials, including tokens issued. The risk is identified through Microsoft 365 Defender and raises the user with High risk to trigger the configured Conditional Access policy.

For more information on this feature, see: [What are risk detections?](..//id-protection/concept-identity-protection-risks.md)

---

### General Availability - Easy authentication with Azure App Service and Microsoft Entra External ID

**Type:** Changed feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

An improved experience when using Microsoft Entra External ID as an identity provider for Azure App Service’s built-in authentication, simplifying the process of configuring authentication and authorization for external-facing apps. You can complete initial configuration directly from the App Service authentication setup without switching into the external tenant. For more information, see: [Quickstart: Add app authentication to your web app running on Azure App Service](/azure/app-service/scenario-secure-app-authentication-app-service?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=external-configuration).

---


## June 2024

### Plan for change - Passkey in Microsoft Authenticator (preview) registration experience is changing

**Type:** Plan for change    
**Service category:** MFA    
**Product capability:** End User Experiences        

Starting late July 2024, through end of August 2024, we're rolling out changes to the registration experience for passkey in Microsoft Authenticator (preview) on the My Security-Info page. This registration experience change will go from an WebAuthn approach, to guide users to register by signing into the Microsoft Authenticator app. This change will occur automatically, and admins won’t need to take any action. Here's more details:

- By default, we'll guide users to sign into the Authenticator app to setup passkeys. 
- If users are unable to sign in, they'll be able to fallback to an improved WebAuthn experience through a "*Having trouble?*" link on the page. 

---

### General Availability - Security Improvements to Microsoft Entra Connect Sync and Connect Health

**Type:** Changed feature    
**Service category:** Provisioning    
**Product capability:** Microsoft Entra Connect    

**Action Recommended: Security Improvements to Microsoft Entra Connect Sync and Connect Health**

Since September 2023, we have been autoupgrading Microsoft Entra Connect Sync and Microsoft Entra Connect Health customers to an updated build as part of a precautionary security-related service change. For customers who previously opted out of autoupgrade, or for whom autoupgrade failed, **we strongly recommend** that you upgrade to the latest versions by **September 23, 2024**.

When you upgrade to the latest versions, you ensure that when the service change takes effect, you avoid service disruptions for:

- Microsoft Entra Connect Sync
- Microsoft Entra Connect Health agent for Sync
- Microsoft Entra Connect Health agent for ADDS
- Microsoft Entra Connect Health agent for ADFS

See documentation here: [Security improvements to the autoupgrade process](/entra/identity/hybrid/connect/security-updates-pks) for upgrade-related guidance, versioning information, and further details on the expected impacts of the service change.

---

### Public Preview - MS Graph API support for per-user multifactor authentication

**Type:** New feature    
**Service category:** MFA    
**Product capability:** Identity Security & Protection    

MS Graph API support for per-user multifactor authentication

Starting June 2024, we're releasing the capability to manage user status (Enforced, Enabled, Disabled) for per-user multifactor authentication through MS Graph API. This update replaces the legacy MSOnline PowerShell module that is being retired. The recommended approach to protect users with Microsoft Entra multifactor authentication is Conditional Access (for licensed organizations) and security defaults (for unlicensed organizations). For more information, see: [Enable per-user Microsoft Entra multifactor authentication to secure sign-in events](..//identity/authentication/howto-mfa-userstates.md).

---

### Public Preview - Easy authentication with Azure App Service and Microsoft Entra External ID

**Type:** Changed feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

We improved the experience when using Microsoft Entra External ID as an identity provider for Azure App Service’s built-in authentication, simplifying the process of configuring authentication and authorization for external-facing apps. You can complete initial configuration directly from the App Service authentication setup without switching into the external tenant. For more information, see: [Quickstart: Add app authentication to your web app running on Azure App Service](/azure/app-service/scenario-secure-app-authentication-app-service?toc=%2fentra%2fexternal-id%2ftoc.json&bc=%2fentra%2fexternal-id%2fbreadcrumb%2ftoc.json&tabs=external-configuration)

---

### General Availability - Refactored account details screen in Microsoft Authenticator

**Type:** Plan for change    
**Service category:** Microsoft Authenticator App    
**Product capability:** User Authentication    

In July, enhancements for the Microsoft Authenticator app UX roll-out. The account details page of a user account is reorganized to help users better understand, and interact with, the information and buttons on the screen. Key actions that a user can do today are available in the refactored page, but they're organized in three sections or categories that help better communicate to users:

- Credentials configured in the app
- More sign in methods they can configure
- Account management options in the app

---

### General Availability - SLA Attainment Report at the Tenant Level

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

In addition to providing global SLA performance, Microsoft Entra ID reports tenant-level SLA performance for organizations with at least 5,000 monthly active users. This feature entered general availability in May 2024. The Service Level Agreement (SLA) sets a minimum bar of 99.99% for the availability of Microsoft Entra ID user authentication, reported on a monthly basis in the Microsoft Entra admin center. For more information, see: [What is Microsoft Entra Health?](../identity/monitoring-health/concept-microsoft-entra-health.md)

---

### Preview – QR code sign-in, a new authentication method for Frontline Workers 

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

We're introducing a new simple way for Frontline Workers to authenticate in Microsoft Entra ID with a QR code and PIN. This capability eliminates the need for users to enter and reenter long UPNs and alphanumeric passwords. 

Beginning in August 2024, all users in your tenant now see a new link *Sign in with QR code* when navigating to https://login.microsoftonline.com > *Sign-in options* > *Sign in to an organization*. This new link, *Sign in with QR code*, is visible only on mobile devices (Android/iOS/iPadOS). If you aren't participating in the preview, users from your tenant can't sign in through this method while we're still in review. They receive an error message if they try to sign-in. 

The feature has a *preview* tag until it's generally available. Your organization needs to be enabled to test this feature. Broad testing is available in public preview, to be announced later.   

While the feature is in preview, no technical support is provided. Learn more about support during previews here: [Microsoft Entra ID preview program information](../fundamentals/licensing-preview-info.md).

---

## May 2024

### General Availability - Azure China 21Vianet now supports My sign-ins and MFA/SSPR Combined Registration

**Type:** Changed feature    
**Service category:** MFA        
**Product capability:** Identity Security & Protection        

Beginning end of June 2024, all organizations utilizing Microsoft Azure China 21Vianet now has access to My Sign-ins activity reporting. They're required to use the combined security information registration end-user experience for MFA and SSPR. As a result of this enablement, users now see a unified SSPR and MFA registration experience when prompted to register for SSPR or MFA. For more information, see: [Combined security information registration for Microsoft Entra overview](../identity/authentication/concept-registration-mfa-sspr-combined.md). 

---

### General Availability - $select in `signIn` API

**Type:** New feature    
**Service category:** MS Graph    
**Product capability:** Monitoring & Reporting    

The long-awaited `$select` property is now implemented into the `signIn` API. Utilize the `$select` to reduce the number of attributes that are returned for each log. This update should greatly help customers who deal with throttling issues, and allow every customer to run faster, more efficient queries.

---

### General Availability - Multiple Passwordless Phone sign-ins for Android Devices

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

End users can now enable passwordless phone sign-in for multiple accounts in the Authenticator App on any supported Android device. Consultants, students, and others with multiple accounts in Microsoft Entra can add each account to Microsoft Authenticator and use passwordless phone sign-in for all of them from the same Android device. The Microsoft Entra accounts can be in the same tenant or different tenants. Guest accounts aren't supported for multiple account sign-ins from one device. For more information, see: [Enable passwordless sign-in with Microsoft Authenticator](../identity/authentication/howto-authentication-passwordless-phone.md).

---

### Public Preview - Bicep templates support for Microsoft Graph

**Type:** New feature    
**Service category:** MS Graph    
**Product capability:** Developer Experience    

The Microsoft Graph Bicep extension brings declarative infrastructure-as-code (IaC) capabilities to Microsoft Graph resources. It allows you to author, deploy, and manage core Microsoft Entra ID resources using Bicep template files, alongside Azure resources.

- Existing Azure customers can now use familiar tools to deploy Azure resources and the Microsoft Entra resources they depend on, such as applications and service principals, IaC and DevOps practices.
- It also opens the door for existing Microsoft Entra customers to use Bicep templates and IaC practices to deploy and manage their tenant's Microsoft Entra resources.

For more information, see: [Bicep templates for Microsoft Graph resources](/graph/templates/)

---

### Public Preview - Platform Single Sign-on for macOS with Microsoft Entra ID

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Today we’re announcing that Platform SSO for macOS is available in public preview with Microsoft Entra ID. Platform SSO is an enhancement to the Microsoft Enterprise SSO plug-in for Apple Devices that makes usage and management of Mac devices more seamless and secure than ever. At the start of public preview, Platform SSO works with Microsoft Intune. Other Mobile Device Management (MDM) providers are coming soon. Contact your MDM provider for more information on support and availability. For more information, see: [macOS Platform Single Sign-on overview (preview)](../identity/devices/macos-psso.md).

---

### Public Preview - Workflow History Insights in Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management   

Customers can now monitor workflow health, and get insights throughout all their workflows in Lifecycle Workflows including viewing workflow processing data across workflows, tasks, and workflow categories. For more information, see: [Workflow Insights (preview)](../id-governance/lifecycle-workflow-insights.md).

---

### Public Preview - Configure Lifecycle Workflow Scope Using Custom Security Attributes

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management   

Customers can now apply their confidential HR data stored in custom security attributes in addition to other attributes. This update enables customers to define the scope of their workflows in Lifecycle Workflows for automating joiner, mover, and leaver scenarios. For more information, see: [Use custom security attributes to scope a workflow](../id-governance/lifecycle-workflow-insights.md).

---

### Public Preview - Enable, Disable, and Delete synchronized users accounts with Lifecycle Workflows

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Lifecycle Management   

Lifecycle Workflows can now enable, disable, and delete user accounts that are synchronized from Active Directory Domain Services (AD DS) to Microsoft Entra. This feature allows you to ensure that the offboarding processes of your employees are completed by deleting the user account after a retention period.

For more information, see: [Managing synced on-premises users with Lifecycle Workflows](../id-governance/lifecycle-workflow-on-premises.md).

---

### Public Preview - External authentication methods for multifactor authentication

**Type:** New feature    
**Service category:** MFA    
**Product capability:** User Authentication    

External authentication methods enable you to use your preferred multifactor authentication (MFA) solution with Microsoft Entra ID. For more information, see: [Manage an external authentication method in Microsoft Entra ID (Preview)](../identity/authentication/how-to-authentication-external-method-manage.md).

---

### General Availability - `LastSuccessfulSignIn`

**Type:** Changed feature    
**Service category:** MS Graph    
**Product capability:** Monitoring & Reporting    

Due to popular demand and increased confidence in the stability of the properties, the update adds `LastSuccessfulSignIn` &` LastSuccessfulSigninDateTime` into V1. Feel free to take dependencies on these properties in your production environments now. For more information, see: [signInActivity resource type](/graph/api/resources/signinactivity).

---

### General Availability - Changing default accepted token version for new applications

**Type:** Plan for change    
**Service category:** Other    
**Product capability:** Developer Experience    

Beginning in August 2024, new Microsoft Entra applications created using any interface (including the Microsoft Entra admin center, Azure portal, Powershell/CLI, or the Microsoft Graph application API) has the default value of the `requestedAccessTokenVersion` property in the app registration set to 2. This capability is a change from the previous default of null` (meaning 1). This means that new resource applications receive v2 access tokens instead of v1 by default. This update improves the security of apps. For more information on differences between token versions, see: [Access tokens in the Microsoft identity platform](../identity-platform/access-tokens.md) and [Access token claims reference](../identity-platform/access-token-claims-reference.md).

---

### General Availability - Windows Account extension is now Microsoft Single Sign On

**Type:** Changed feature    
**Service category:** Authentications (Logins)    
**Product capability:** SSO    

The Windows Account extension is now the [Microsoft Single Sign On](https://chromewebstore.google.com/detail/microsoft-single-sign-on/ppnbnpeolgkicgegkbkbjmhlideopiji) extension in docs and Chrome store. The Windows Account extension is updated to represent the new macOS compatibility. This capability is now known as the Microsoft Single Sign On (SSO) extension for Chrome, offering single sign-on and device identity features with the Enterprise SSO plug-in for Apple devices. This update is only a name change for the extension, there are no software changes to the extension itself.

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - May 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** Third Party Integration    

Microsoft added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [ClearView Trade](../identity/saas-apps/clearview-trade-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](../identity/app-provisioning/user-provisioning.md).

---

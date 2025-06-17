---
title: Archive for Microsoft Entra releases and announcements
description: The What's new release notes in the Overview section of this content set contain six months of activity. After six months, the items are removed from the main article and put into this archive article.
author: owinfreyATL
manager: dougeby
ms.service: entra
ms.subservice: fundamentals
ms.topic: whats-new
ms.date: 01/27/2025
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-adal-ref, has-azure-ad-ps-ref, sfi-ga-nochange
ms.collection: M365-identity-device-management
---

# Archive for Microsoft Entra releases and announcements

This article includes information about the releases and change announcements across the Microsoft Entra family of products that are older than six months (up to 18 months). If you're looking for more current information, see [Microsoft Entra releases and announcements](./whats-new.md).

For a more dynamic experience, you can now find the archive information in the Microsoft Entra admin center. To learn more, see [What's new (preview)](./whats-new-overview.md).

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

Microsoft Entra health monitoring, available from the Health pane, includes a set of low-latency pre-computed health metrics that can be used to monitor the health of critical user scenarios in your tenant. The first set of health scenarios includes MFA, CA-compliant devices, CA-managed devices, and SAML authentications. This set of monitor scenarios will grow over time. These health metrics are now released as general availability data streams with the public preview of an intelligent alerting capability. For more information, see: [What is Microsoft Entra Health?](../identity/monitoring-health/concept-microsoft-entra-health.md).

---

### General Availability - Microsoft Entra Connect Sync Version 2.4.27.0

**Type:** Changed feature       
**Service category:** Provisioning        
**Product capability:** Identity Governance        

On November 14, 2025, we released Microsoft Entra Connect Sync Version 2.4.27.0 that uses the OLE DB version 18.7.4 that further hardens our service. Upgrade to this latest version of connect sync to improve your security. More details are available in the [release notes](../identity/hybrid/connect/reference-connect-version-history.md#24270). 

---

### Changed feature - expansion of WhatsApp as an MFA one-time passcode delivery channel for Microsoft Entra ID

**Type:** Changed feature    
**Service category:** MFA    
**Product capability:** User Authentication    

In late 2023, Microsoft Entra ID started using WhatsApp as an alternate channel to deliver multifactor authentication (MFA) one-time passcodes to users in India and Indonesia. We saw improved deliverability, completion rates, and satisfaction when using the channel in both countries. The channel was temporarily disabled in India in early 2024. Starting early December 2024, we'll be re-enabling the channel in India, and expanding its use to more countries.

Starting December 2024, users in India, and other countries can start receiving MFA text messages via WhatsApp. Only users that are enabled to receive MFA text messages as an authentication method, and already have WhatsApp on their phone, get this experience. If a user with WhatsApp on their device is unreachable or doesn’t have internet connectivity, we'll quickly fall back to the regular SMS channel. In addition, users receiving OTPs via WhatsApp for the first time will be notified of the change in behavior via SMS text message. 

If you don’t want your users to receive MFA text messages through WhatsApp, you can disable text messages as an authentication method in your organization or scope it down to only be enabled for a subset of users. Note that we highly encourage organizations move to using more modern, secure methods like Microsoft Authenticator and passkeys in favor of telecom and messaging app methods. For more information, see: [Text message verification](../identity/authentication/concept-authentication-phone-options.md#text-message-verification).

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

Intelligent alerts in Microsoft Entra health monitoring notify tenant admins, and security engineers, whenever a monitored scenario breaks from its typical pattern. Microsoft Entra's alerting capability watches the low-latency health signals of each scenario, and fires a notification if an anomaly is detected. The set of alert-ready health signals and scenarios will grow over time. This alerts feature is now available in Microsoft Entra Health as an API-only public preview release (UX release is scheduled for February 2025). For more information, see: [How to use Microsoft Entra Health monitoring alerts (preview)](../identity/monitoring-health/howto-use-health-scenario-alerts.md).

---

### General Availability - Log analytics sign-in logs schema is in parity with MSGraph schema

**Type:** Plan for change    
**Service category:** Authentications (Logins)    
**Product capability:** Monitoring & Reporting    

To maintain consistency in our core logging principles, we've addressed a legacy parity issue where the Azure Log Analytics sign-in logs schema didn't align with the MSGraph sign-in logs schema. The updates include fields such as ClientCredentialType, CreatedDateTime, ManagedServiceIdentity, NetworkLocationDetails, tokenProtectionStatus, SessionID, among others. These changes take effect in the first week of December 2024.

We believe this enhancement provides a more consistent logging experience. As always, you can perform pre-ingestion transformations to remove any unwanted data from your Azure Log Analytics storage workspaces. For guidance on how to perform these transformations, see: [Data collection transformations in Azure Monitor](/azure/azure-monitor/essentials/data-collection-transformations).

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

The authentication methods migration guide (preview) in the Microsoft Entra admin center lets you automatically migrate method management from the [legacy MFA and SSPR policies](../identity/authentication/concept-authentication-methods-manage.md#legacy-mfa-and-sspr-policies) to the [converged authentication methods policy](../identity/authentication/concept-authentication-methods-manage.md). In 2023, it was announced that the ability to manage authentication methods in the legacy MFA and SSPR policies would be retired in September 2025. Until now, organizations had to manually migrate methods themselves by leveraging [the migration toggle](../identity/authentication/how-to-authentication-methods-manage.md#start-the-migration) in the converged policy. Now, you can migrate in just a few selections by using the migration guide. The guide evaluates what your organization currently has enabled in both legacy policies, and generates a recommended converged policy configuration for you to review and edit as needed. From there, confirm the configuration and we set it up for you and mark your migration as complete. For more information, see: [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](../identity/authentication/how-to-authentication-methods-manage.md).

---

### General availability- SMS as an MFA method in Microsoft Entra External ID

**Type:** New feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

Announcing general availability of SMS as an MFA method in Microsoft Entra External ID with built-in telecom fraud protection through integrations with the Phone Reputation Platform.

**What's new?**

- SMS sign-in experience that maintains the look and feel of the application users are accessing.
- SMS is an add-on feature. We apply an additional charge per SMS sent to the user which includes the built-in fraud protection services.
- Built-in fraud protection against telephony fraud through our integration with the Phone Reputation platform. This platform processes telephony activity in real-time and returns an "Allow", "Block", or "Challenge" based on risk and a series of heuristics.


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

To strengthen security and avoid misconfigurations, an Authentication Policy Administrator can require CBA authentication to fail if no CRL is configured for a CA that issues an end user certificate. For more information, see: [Understanding CRL validation (Preview)](../identity/authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-crl-validation).

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

### General Availability -  Device based Conditional Access to M365/Azure resources on Red Hat Enterprise Linux

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

Starting late July 2024, through end of August 2024, we're rolling out changes to the registration experience for passkey in Microsoft Authenticator (preview) on the My Security-Info page. This registration experience change will go from a WebAuthn approach, to guide users to register by signing into the Microsoft Authenticator app. This change will occur automatically, and admins won’t need to take any action. Here's more details:

- By default, we'll guide users to sign into the Authenticator app to set up passkeys. 
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

Due to popular demand and increased confidence in the stability of the properties, the update adds `LastSuccessfulSignIn` & `LastSuccessfulSigninDateTime` into V1. Feel free to take dependencies on these properties in your production environments now. For more information, see: [signInActivity resource type](/graph/api/resources/signinactivity).

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

## April 2024

### Public Preview - FIDO2 authentication in Android web browsers

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Users can now sign in with a FIDO2 security key in both Chrome, and Microsoft Edge, on Android. This change is applicable to all users who are in scope for the FIDO2 authentication method. FIDO2 registration in Android web browsers isn't available yet.

For more information, see: [Support for FIDO2 authentication with Microsoft Entra ID](../identity/authentication/concept-fido2-compatibility.md).

---

### General Availability - Security group provisioning to Active Directory using cloud sync

**Type:** New feature    
**Service category:** Provisioning    
**Product capability:** Microsoft Entra Cloud Sync    

Security groups provisioning to Active Directory (also known as Group Writeback) is now generally available through Microsoft Entra Cloud Sync in Azure Global and Azure Government clouds. With this new capability, you can easily govern Active Directory based on-premises applications (Kerberos based apps) using Microsoft Entra Governance. For more information, see: [Provision groups to Active Directory using Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md).

---

### Decommissioning of Group Writeback V2 (Public Preview) in Microsoft Entra Connect Sync

**Type:** Plan for change   
**Service category:** Provisioning                     
**Product capability:**  Microsoft Entra Connect Sync             

The public preview of Group Writeback V2 (GWB) in Microsoft Entra Connect Sync will no longer be available after June 30, 2024. After this date, Connect Sync will no longer support provisioning cloud security groups to Active Directory.

Another similar functionality in Microsoft Entra Cloud Sync is *Group Provision to AD*. You can use this functionality instead of GWB V2 for provisioning cloud security groups to AD. Enhanced functionality in Cloud Sync, along with other new features, are being developed.

Customers who use this preview feature in Connect Sync should [switch their configuration from Connect Sync to Cloud Sync](../identity/hybrid/cloud-sync/migrate-group-writeback.md). Customers can choose to move all their hybrid sync to Cloud Sync, if it supports their needs. Customers can also choose to run Cloud Sync side-by-side and move only cloud security group provisioning to Azure AD onto Cloud Sync.

Customers who use Microsoft 365 groups to AD can continue using GWB V1 for this capability.  

Customers can evaluate moving exclusively to Cloud Sync by using this wizard: https://aka.ms/EvaluateSyncOptions

---

### General availability - PIM approvals and activations on the Azure mobile app (iOS and Android) are available now

**Type:** New feature    
**Service category:** Privileged Identity Management    
**Product capability:** Privileged Identity Management    

PIM is now available on the Azure mobile app in both iOS and Android. Customers can now approve or deny incoming PIM activation requests. Customers can also activate Microsoft Entra ID and Azure resource role assignments directly from an app on their devices. For more information, see: [Activate PIM roles using the Azure mobile app](/entra/id-governance/privileged-identity-management/pim-resource-roles-activate-your-roles).

---

### General Availability - On-premises password reset remediates user risk

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Organizations who enabled password hash synchronization can now allow password changes on-premises to remediate user risk. You can also use this capability to save hybrid users time and maintain their productivity with automatic self-service remediation in risk-based Conditional Access policies. For more information, see: [Remediate risks and unblock users](../id-protection/howto-identity-protection-remediate-unblock.md).

---

### General Availability - Custom Claims Providers enable token claim augmentation from external data sources

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** Extensibility    

Custom authentication extensions allow you to customize the Microsoft Entra authentication experience by integrating with external systems. A custom claims provider is a type of custom authentication extension that calls a REST API to fetch claims from external systems. A custom claims provider maps claims from external systems into tokens and can be assigned to one or many applications in your directory. For more information, see: [Custom authentication extensions overview](../identity-platform/custom-extension-overview.md).

---

### General Availability - Dynamic Groups quota increased to 15,000.

**Type:** Changed feature    
**Service category:** Group Management    
**Product capability:** Directory    

Microsoft Entra organizations could previously have a maximum of 15,000 dynamic membership groups and dynamic administrative units combined. 

This quota is increased to 15,000. For example, you can now have 15,000 dynamic membership groups and 10,000 dynamic AUs (or any other combination that adds up to 15k). You don't need to do anything to take advantage of this change - this update is available right now. For more information, see: [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md).

---

### General Availability - Lifecycle Workflows: Export workflow history data to CSV files

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

In Lifecycle Workflows, IT admins can now export their workflow history data across users, runs, and tasks to CSV files for meeting their organization's reporting and auditing needs.

See [Download workflow history reports](../id-governance/download-workflow-history.md) to learn more.

---

### Public preview - Native Authentication for Microsoft Entra External ID

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

Native authentication empowers developers to take complete control over the design of the sign-in experience of their mobile applications. It allows them to craft stunning, pixel-perfect authentication screens that are seamlessly integrated into their apps, rather than relying on browser-based solutions. For more information, see: [Native authentication (preview)](../external-id/customers/concept-native-authentication.md).

---

### Public Preview - Passkeys in Microsoft Authenticator

**Type:** New feature    
**Service category:** Microsoft Authenticator App    
**Product capability:** User Authentication    

Users can now create device-bound passkeys in the Microsoft Authenticator to access Microsoft Entra ID resources. Passkeys in the Authenticator app provide cost-effective, phishing-resistant, and seamless authentications to users from their mobile devices. For more information, see https://aka.ms/PasskeyInAuthenticator.

---

### General Availability - Maximum workflows limit in Lifecycle workflows is now 100

**Type:** Changed feature    
**Service category:** Lifecycle Workflows        
**Product capability:** Identity Governance        

The maximum number of workflows that can be configured in Lifecycle workflows increased. Now IT admins can create up to 100 workflows in Lifecycle workflows. For more information, see: [Microsoft Entra ID Governance service limits](../id-governance/governance-service-limits.md).

---

### Public Preview - Configure custom workflows to run mover tasks when a user's job profile changes

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Lifecycle Workflows now supports the ability to trigger workflows based on job change events like changes to an employee's department, job role, or location and see them executed on the workflow schedule. With this feature, customers can use new workflow triggers to create custom workflows for executing tasks associated with employees moving within the organization including triggering:

- Workflows when a specified attribute changes
- Workflows when a user is added or removed from a group's membership
- Tasks to notify a user's manager about a move
- Tasks to assign licenses or remove selected licenses from a user

To learn more, see the [Automate employee mover tasks when they change jobs using the Microsoft Entra admin center](../id-governance/tutorial-mover-custom-workflow-portal.md) tutorial.

---

### General Availability - Microsoft Graph activity logs

**Type:** New feature    
**Service category:** Microsoft Graph    
**Product capability:** Monitoring & Reporting    

The Microsoft Graph activity logs is now generally available! Microsoft Graph activity logs give you visibility into HTTP requests made to the Microsoft Graph service in your tenant. With rapidly growing security threats, and an increasing number of attacks, this log data source allows you to perform security analysis, threat hunting, and monitor application activity in your tenant. For more information, see: [Access Microsoft Graph activity logs](/graph/microsoft-graph-activity-logs-overview).

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - April 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** Third Party Integration    

Microsoft added the following new applications in our App gallery with provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

[CultureHQ](../identity/saas-apps/culturehq-provisioning-tutorial.md)
[elia](../identity/saas-apps/elia-provisioning-tutorial.md)
[GoSkills](../identity/saas-apps/goskills-provisioning-tutorial.md)
[Island](../identity/saas-apps/island-provisioning-tutorial.md)
[Jellyfish](../identity/saas-apps/jellyfish-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see Automate user provisioning to SaaS applications with Microsoft Entra.

---

### General Availability - Quick Microsoft Entra Verified ID setup

**Type:** New feature    
**Service category:** Verified ID    
**Product capability:** Decentralized Identities    

Quick Microsoft Entra Verified ID setup, now generally available, removes several configuration steps an admin needs to complete with a single select on a Get started button. The quick setup takes care of signing keys, registering your decentralized ID, and verifying your domain ownership. It also creates a Verified Workplace Credential for you. For more information, see: [Quick Microsoft Entra Verified ID setup](../verified-id/verifiable-credentials-configure-tenant-quick.md).

---

### Public Preview - Assign Microsoft Entra roles using Entitlement Management

**Type:** New feature    
**Service category:** Entitlement Management    
**Product capability:** Entitlement Management    

By assigning Microsoft Entra roles to employees, and guests, using Entitlement Management, you can look at a user's entitlements to quickly determine which roles are assigned to that user. When you include a Microsoft Entra role as a resource in an access package, you can also specify whether that role assignment is *eligible* or *active*.

Assigning Microsoft Entra roles through access packages helps to efficiently manage role assignments at scale and improves the role. For more information, see: [Assign Microsoft Entra roles (Preview)](../id-governance/entitlement-management-roles.md).

---

### General Availability - Self-service password reset Admin policy expansion to include more roles

**Type:** Changed feature    
**Service category:** Self Service Password Reset    
**Product capability:** Identity Security & Protection    

Self-service password reset (SSPR) policy for Admins expands to include three extra built-in admin roles. These extra roles include: 

- Teams Administrator
- Teams Communications Administrator
- Teams Devices Administrator

For more information on Self-service password reset for admins, including the full list of in-scope admin roles, see [Administrator reset policy differences](../identity/authentication/concept-sspr-policy.md#administrator-reset-policy-differences). 

---

## March 2024

### Public Preview - Convert external users to internal

**Type:** New feature    
**Service category:** User Management    
**Product capability:** User Management    

External user conversion enables customers to convert external users to internal members without needing to delete and create new user objects. Maintaining the same underlying object ensures the user’s account, and access to resources, isn’t disrupted and that their history of activities remains intact as their relationship with the host organization changes. 

The external to internal user conversion feature includes the ability to convert on-premises synchronized users as well. For more information, see: [Convert external users to internal users (Preview)](../identity/users/convert-external-users-internal.md).

---

### Public Preview - Alternate Email Notifications for Lockbox Requests

**Type:** New feature    
**Service category:** Other    
**Product capability:** Access Control    

Customer Lockbox for Microsoft Azure is launching a new feature that enables customers to use alternate email IDs for getting lockbox notifications. This capability enables Lockbox customers to receive notifications in scenarios where their Azure account isn't email enabled, or if they have a service principal defined as the tenant admin or subscription owner.

---

### Plan for change - Conditional Access location condition is moving up

**Type:** Plan for change    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Beginning in mid-April 2024, the Conditional Access *Locations* condition is moving up. Locations become the *Network* assignment, with the new Global Secure Access assignment - *All compliant network locations*.

This change occurs automatically, so admins take no action. Here's more details:

- The familiar *Locations* condition is unchanged, updating the policy in the *Locations* condition are reflected in the *Network* assignment, and vice versa.
- No functionality changes, existing policies continue to work without changes.

---

### General Availability - Just-in-time application access with PIM for Groups

**Type:** New feature    
**Service category:** Privileged Identity Management    
**Product capability:** Privileged Identity Management    

Provide just-in-time access to non-Microsoft applications such as AWS & GCP. This capability integrates PIM for groups. Application provisioning with PIM reduces the activation time from 40+ minutes to roughly 2 minutes when requesting just-in-time access to a role in non-Microsoft apps.

For more information, see:

- [AWS](../identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups)
- [GCP](../identity/saas-apps/g-suite-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups)

---

### Public Preview - Azure Lockbox Approver Role for Subscription Scoped Requests

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Governance    

Customer Lockbox for Microsoft Azure is launching a new built-in Azure Role-based access control role that enables customers to use a lesser privileged role for users responsible for approving/rejecting Customer Lockbox requests. This feature is targeted to the customer admin workflow where a lockbox approver acts on the request from Microsoft Support engineer to access Azure resources in a customer subscription.

In this first phase, we're launching a new built-in Azure Role-based Access Control role. This role helps scope down the access possible for an individual with Azure Customer Lockbox approver rights on a subscription and its resources. A similar role for tenant-scoped requests is available in subsequent releases.

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - March 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** Third Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Astro](../identity/saas-apps/astro-provisioning-tutorial.md)
- [Egnyte](../identity/saas-apps/egnyte-provisioning-tutorial.md)
- [MobileIron](../identity/saas-apps/mobileiron-provisioning-tutorial.md)
- [SAS Viya SSO](../identity/saas-apps/sas-viya-sso-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - TLS 1.3 support for Microsoft Entra

**Type:** New feature    
**Service category:** Other    
**Product capability:** Platform        

We're excited to announce that Microsoft Entra, is rolling out support for Transport Layer Security (TLS) 1.3 for its endpoints to align with security best practices ([NIST - SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)). With this change, the Microsoft Entra ID related endpoints support both TLS 1.2 and TLS 1.3 protocols. For more information, see: [TLS 1.3 support for Microsoft Entra services](/troubleshoot/azure/active-directory/enable-support-tls-environment?tabs=azure-monitor#tls-13-support-for-microsoft-entra-services).

---

### General Availability - API driven inbound provisioning

**Type:** New feature    
**Service category:** Provisioning    
**Product capability:** Inbound to Microsoft Entra ID        

With API-driven inbound provisioning, Microsoft Entra ID provisioning service now supports integration with any system of record. Customers and partners can choose any automation tool to retrieve workforce data from any system of record for provisioning to Microsoft Entra ID. This capability also applies to connected on-premises Active Directory domains. IT admins have full control on how the data is processed and transformed with attribute mappings. Once the workforce data is available in Microsoft Entra ID, IT admins can configure appropriate joiner-mover-leaver business processes using Microsoft Entra ID Governance Lifecycle Workflows. For more information, see: [API-driven inbound provisioning concepts](../identity/app-provisioning/inbound-provisioning-api-concepts.md).

---

### General Availability - Changing Passwords in My Security Info

**Type:** New feature    
**Service category:** My Security Info    
**Product capability:** End User Experiences        

Now Generally Available, My Sign Ins [(My sign-ins (microsoft.com))](https://mysignins.microsoft.com/) supports end users changing their passwords inline. When a user authenticates with a password and an MFA credential, they're able to are able to change their password without entering their existing password. Beginning April 1, through a phased rollout, traffic from the [Change password (windowsazure.com)](https://account.activedirectory.windowsazure.com/ChangePassword.aspx) portal will redirect to the new My Sign Ins change experience. The [Change password (windowsazure.com)](https://account.activedirectory.windowsazure.com/ChangePassword.aspx) will no longer be available after June 2024, but will continue to redirect to the new experience.


For more information, see: 

- [Combined security information registration for Microsoft Entra overview](../identity/authentication/concept-registration-mfa-sspr-combined.md).
- [Change work or school account settings in the My Account portal](https://support.microsoft.com/account-billing/change-work-or-school-account-settings-in-the-my-account-portal-e50bfccb-58e9-4d42-939c-a60cb6d56ced)

---

## February 2024

### General Availability - Identity Protection and Risk Remediation on the Azure Mobile App

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Identity Protection, previously supported only on the portal, is a powerful tool that empowers administrators to proactively manage identity risks. Now available on the Azure Mobile app, administrators can respond to potential threats with ease and efficiency. This feature includes comprehensive reporting, offering insights into risky behaviors such as compromised user accounts and suspicious sign-ins.

With the Risky users report, administrators gain visibility into accounts flagged as compromised or vulnerable. Actions such as blocking/unblocking sign-ins, confirming the legitimacy of compromises, or resetting passwords are conveniently accessible, ensuring timely risk mitigation.

Additionally, the Risky sign-ins report provides a detailed overview of suspicious sign-in activities, aiding administrators in identifying potential security breaches. While capabilities on mobile are limited to viewing sign-in details, administrators can take necessary actions through the portal, such as blocking sign-ins. Alternatively, admins can choose to manage the corresponding risky user's account until all risks are mitigated.

Stay ahead of identity risks effortlessly with Identity Protection on the Azure Mobile app. These capabilities are intended to provide user with the tools to maintain a secure environment and peace of mind for their organization.

The mobile app can be downloaded at the following links:

- Android: https://aka.ms/AzureAndroidWhatsNew
- IOS: https://aka.ms/ReferAzureIOSWhatsNew

---

### Plan for change - Microsoft Entra ID Identity protection: Low risk age out

**Type:** Plan for change    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Starting on March 31, 2024, all "*low*" risk detections and users in Microsoft Entra ID Identity Protection that are older than six months will be automatically aged out and dismissed. This change allows customers to focus on more relevant risk and provide a cleaner investigation environment. For more information, see: [What are risk detections?](../id-protection/concept-identity-protection-risks.md).

---

### Public Preview - Expansion of the Conditional Access reauthentication policy for additional scenarios  

**Type:** Changed feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Reauthentication policy lets you require users to interactively provide their credentials again, typically before accessing critical applications and taking sensitive actions. Combined with Conditional Access session control of Sign-in frequency, you can require reauthentication for users and sign-ins with risk, or for Intune enrollment. With this public preview, you can now require reauthentication on any resource protected by Conditional Access. For more information, see: [Require reauthentication every time](../identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time).

---

### General Availability - New premium user risk detection, Suspicious API Traffic, is available in Identity Protection

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

We released a new premium user risk detection in Identity Protection called *Suspicious API Traffic*. This detection is reported when Identity Protection detects anomalous Graph traffic by a user. Suspicious API traffic might suggest that a user is compromised and conducting reconnaissance in their environment. For more information about Identity Protection detections including this one, visit our public documentation at the following link: [What are risks detections?](../id-protection/concept-identity-protection-risks.md).

---

### General Availability - Granular filtering of Conditional Access policy list

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Access Control    

Conditional Access policies can now be filtered on actor, target resources, conditions, grant control, and session control. The granular filtering experience can help admins quickly discover policies containing specific configurations. For more information, see: [What is Conditional Access?](../identity/conditional-access/overview.md).

---

### End of support - Azure Active Directory Connector for Forefront Identity Manager (FIM WAAD Connector)

**Type:** Deprecated    
**Service category:** Microsoft Identity Manager    
**Product capability:** Inbound to Microsoft Entra ID    

The Azure Active Directory Connector for Forefront Identity Manager (FIM WAAD Connector) from 2014 was deprecated in 2021. The standard support for this connector ended in April 2024. Customers must remove this connector from their MIM sync deployment, and instead use an alternative provisioning mechanism. For more information, see: [Migrate a Microsoft Entra provisioning scenario from the FIM Connector for Microsoft Entra ID](/microsoft-identity-manager/migrate-from-the-fim-connector-for-azure-active-directory).

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - February 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** Third Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Alohi](../identity/saas-apps/alohi-provisioning-tutorial.md)
- [Insightly SAML](../identity/saas-apps/insightly-saml-provisioning-tutorial.md)
- [Starmind](../identity/saas-apps/starmind-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - February 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** Third Party Integration          

In February 2024, we added the following 10 new applications in our App gallery with Federation support:

[Crosswise](../identity/saas-apps/presswise-tutorial.md), [Stonebranch Universal Automation Center (SaaS Cloud)](../identity/saas-apps/stonebranch-universal-automation-center-saas-cloud-tutorial.md), [ProductPlan](../identity/saas-apps/productplan-tutorial.md), [Bigtincan for Outlook](https://www.bigtincan.com/content/), [Blinktime](https://www.blinktime.io/), [Stargo](http://www.stargo.co/), [Garage Hive BC v2](https://garagehive.co.uk/), [Avochato](https://www.avochato.com/), [Luscii](https://vitals.luscii.com/), [LEVR](https://levr.work/), [XM Discover](../identity/saas-apps/xm-discover-tutorial.md), [Sailsdock](https://www.sailsdock.no/), [Mercado Electronic SAML](../identity/saas-apps/mercado-eletronico-saml-tutorial.md), [Moveworks](../identity/saas-apps/moveworks-tutorial.md), [Silbo](https://app.ambuliz.com/), [Alation Data Catalog](../identity/saas-apps/alation-data-catalog-tutorial.md), [Papirfly SSO](../identity/saas-apps/papirfly-sso-tutorial.md), [Secure Cloud User Integration](https://opentextcybersecurity.com/), [AlbertStudio](https://sandbox.albertinvent.com/), [Automatic Email Manager](https://www.automatic-email-manager.com/?utm_source=azuregallery), [Streamboxy](https://en.streamboxy.com/), [NewHotel PMS](http://www.newhotelcloud.com/), [Ving Room](https://www.letsving.com/), [Trevanna Tracks](../identity/saas-apps/trevanna-tracks-tutorial.md), [Alteryx Server](../identity/saas-apps/alteryx-server-tutorial.md), [RICOH Smart Integration](https://www.ricoh.com/), [Genius](), [Othership Workplace Scheduler](), [GitHub Enterprise Managed User - ghe.com](../identity/saas-apps/github-enterprise-managed-user-tutorial.md),[Thumb Technologies](https://www.thumb.is/), [Freightender SSO for TRP (Tender Response Platform)](../identity/saas-apps/freightender-sso-for-trp-tender-response-platform-tutorial.md), [BeWhere Portal (UPS Access)](http://www.bewhere.com/), [Flexiroute](https://www.flexiroute.net/), [SEEDL](https://www.seedlgroup.com/), [Isolocity](https://www.isolocity.com/), [SpotDraft](../identity/saas-apps/spotdraft-tutorial.md), [Blinq](../identity/saas-apps/blinq-tutorial.md), [Cisco Phone OBTJ](https://www.cisco.com/), [Applitools Eyes](../identity/saas-apps/applitools-eyes-tutorial.md).

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

## January 2024

### Generally Availability - New Microsoft Entra Home page

**Type:** Changed feature    
**Service category:** N/A    
**Product capability:** Directory    

We redesigned the Microsoft Entra admin center's homepage to help you do the following tasks: 

- Learn about the product suite 
- Identify opportunities to maximize feature value 
- Stay up to date with recent announcements, new features, and more!

See the new experience here: https://entra.microsoft.com/

---

### Public Preview - Granular Certificate-Based Authentication Configuration in Conditional Access

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

With the authentication strength capability in Conditional Access, you can now create a custom authentication strength policy, with advanced certificate-based authentication (CBA) options to allow access based on certificate issuer or policy OIDs. For external users whose MFA is trusted from partners' Microsoft Entra ID tenant, access can also be restricted based on these properties. For more information, see: [Custom Conditional Access authentication strengths](../identity/authentication/concept-authentication-strength-advanced-options.md).

---

### Generally Availability - Conditional Access filters for apps

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Filters for apps in Conditional Access simplify policy management by allowing admins to tag applications with custom security, and target them in Conditional Access policies, instead of using direct assignments. With this feature, customers can scale up their policies, and protect any number of apps. For more information, see: [Conditional Access: Filter for applications](../identity/conditional-access/concept-filter-for-applications.md)

---

### Public preview - Cross-tenant manager synchronization

**Type:** New feature    
**Service category:** Provisioning    
**Product capability:** Identity Governance    

Cross-tenant synchronization now supports synchronizing the manager attribute across tenants. For more information, see: [Attributes](../identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md#attributes).

---

### General Availability- Microsoft Defender for Office alerts in Identity Protection

**Type:** New feature    
**Service category:** Identity Protection        
**Product capability:** Identity Security & Protection        

The *Suspicious sending patterns* risk detection type is discovered using information provided by Microsoft Defender for Office (MDO). This alert is generated when someone in your organization sent suspicious email. The alert is because the email is either at risk of being restricted from sending email, or has been restricted from sending email. This detection moves users to medium risk, and only fires in organizations that deployed MDO. For more information, see: [What are risk detections?](../id-protection/concept-identity-protection-risks.md).

---

### Public preview - New Microsoft Entra recommendation to migrate off MFA Server

**Type:** New feature    
**Service category:** MFA        
**Product capability:** User Authentication        

We've released a new recommendation in the Microsoft Entra admin center for customers to move off MFA Server to Microsoft Entra multifactor authentication. MFA Server will be retired on September 30, 2024. Any customers with MFA Server activity in the last seven days see the recommendation that includes details about their current usage, and steps on how to move to Microsoft Entra multifactor authentication. For more information, see:  [Migrate from MFA Server to Microsoft Entra multifactor authentication](../identity/authentication/how-to-migrate-mfa-server-to-azure-mfa.md).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - January 2024

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Personify Inc](../identity/saas-apps/personify-inc-provisioning-tutorial.md)
- [Screensteps](../identity/saas-apps/screensteps-provisioning-tutorial.md)
- [WiggleDesk](../identity/saas-apps/wiggledesk-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - January 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** Third Party Integration          

In January 2024, we added the following new applications in our App gallery with Federation support:

[Boeing ToolBox](https://www.boeing.com/), [Kloud Connect Practice Management](https://www.kloudconnect.com.au/), [トーニチ・ネクスタ・メイシ ( Tonichi Nexta Meishi )](../identity/saas-apps/tonicdm-tutorial.md), [Vinkey](https://vinkey.app/), [Cognito Forms](https://www.cognitoforms.com/), [Ocurus](../identity/saas-apps/ocurus-tutorial.md), [Magister](https://www.magister.nl/), [eFlok](../identity/saas-apps/eflok-tutorial.md), [GoSkills](https://www.goskills.com/), [FortifyData](https://fortifydata.com/), [Toolsfactory platform, Briq](https://toolsfactory.nl/en/ogsm-tool/), [Mailosaur](../identity/saas-apps/mailosaur-tutorial.md), [Astro](../identity/saas-apps/astro-tutorial.md), [JobDiva / Teams VOIP Integration](https://www.jobdiva.com/), [Colossyan SAML](../identity/saas-apps/colossyan-saml-tutorial.md), [CallTower Connect](https://www.calltower.com/calltower-connect/), [Jellyfish](https://cogitogroup.net/jellyfish/), [MetLife Legal Plans Member App](../identity/saas-apps/metlife-legal-plans-member-app-tutorial.md), [Navigo Cloud SAML](../identity/saas-apps/navigo-cloud-saml-tutorial.md), [Delivery Scheduling Tool](../identity/saas-apps/delivery-scheduling-tool-tutorial.md), [Highspot for MS Teams](https://app.highspot.com/signin), [Reach 360](../identity/saas-apps/reach-360-tutorial.md), [Fareharbor SAML SSO](../identity/saas-apps/fareharbor-saml-sso-tutorial.md), [HPE Aruba Networking EdgeConnect Orchestrator](../identity/saas-apps/hpe-aruba-networking-edgeconnect-orchestrator-tutorial.md), [Terranova Security Awareness Platform](../identity/saas-apps/terranova-security-awareness-platform-tutorial.md).

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

## December 2023

### Public Preview - Configurable redemption order for B2B collaboration

**Type:** New feature   
**Service category:** B2B                     
**Product capability:**  B2B/B2C             

With configurable redemption, you can customize the order of identity providers that your guest users can sign in with when they accept your invitation. This option lets your override the default configuration order set by Microsoft and use your own. This option can be used to help with scenarios like prioritizing a SAML/WS-fed federation above a Microsoft Entra ID verified domain. This option disables certain identity providers during redemption, or even only using something like email one-time pass-code as a redemption option. For more information, see: [Configurable redemption (Preview)](../external-id/cross-tenant-access-overview.md#configurable-redemption).

---

### General Availability - Edits to Dynamic Group Rule Builder

**Type:** Changed feature   
**Service category:** Group Management                     
**Product capability:**  Directory             

The dynamic group rule builder is updated to no longer include the '*contains*' and '*notContains*' operators, as they're less performant. If needed, you can still create rules for dynamic membership groups with those operators by typing directly into the text box. For more information, see: [Rule builder in the Azure portal](../identity/users/groups-dynamic-membership.md#rule-builder-in-the-azure-portal).

---

## November 2023

### Decommissioning of Group Writeback V2 (Public Preview) in Microsoft Entra Connect Sync

**Type:** Plan for change   
**Service category:** Provisioning                     
**Product capability:**  Microsoft Entra Connect Sync             

The public preview of Group Writeback V2 (GWB) in Microsoft Entra Connect Sync will no longer be available after June 30, 2024. After this date, Connect Sync will no longer support provisioning cloud security groups to Active Directory.

Another similar functionality is offered in Microsoft Entra Cloud Sync, called 'Group Provision to AD', that maybe used instead of GWB V2 for provisioning cloud security groups to AD. Enhanced functionality in Cloud Sync, along with other new features, are being developed.

Customers who use this preview feature in Connect Sync should [switch their configuration from Connect Sync to Cloud Sync](../identity/hybrid/cloud-sync/migrate-group-writeback.md). Customers can choose to move all their hybrid sync to Cloud Sync (if it supports their needs). They can also run Cloud Sync side-by-side and move only cloud security group provisioning to AD onto Cloud Sync.

Customers who provision Microsoft 365 groups to AD can continue using GWB V1 for this capability.  

Customers can evaluate moving exclusively to Cloud Sync by using this wizard: https://aka.ms/EvaluateSyncOptions

---

### General Availability - Microsoft Entra Cloud Sync now supports ability to enable Exchange Hybrid configuration for Exchange customers

**Type:** New feature   
**Service category:** Provisioning                     
**Product capability:**  Microsoft Entra Connect            

Exchange hybrid capability allows for the coexistence of Exchange mailboxes both on-premises and in Microsoft 365. Microsoft Entra Cloud Sync synchronizes a specific set of Exchange-related attributes from Microsoft Entra ID back into your on-premises directory. It also synchronizes any disconnected forests (no network trust needed between them). With this capability, existing customers who have this feature enabled in Microsoft Entra Connect sync can now migrate, and apply, this feature with Microsoft Entra cloud sync. For more information, see: [Exchange hybrid writeback with cloud sync](../identity/hybrid/exchange-hybrid-writeback.md).

---

### General Availability - Guest Governance: Inactive Guest Insights

**Type:** New feature   
**Service category:** Reporting                     
**Product capability:**  Identity Governance             

Monitor guest accounts at scale with intelligent insights into inactive guest users in your organization. Customize the inactivity threshold depending on your organization’s needs, narrow down the scope of guest users you want to monitor, and identify the guest users that might be inactive. For more information, see: [Monitor and clean up stale guest accounts using access reviews](../identity/users/clean-up-stale-guest-accounts.md).

---

### Public Preview - lastSuccessfulSignIn property in signInActivity API

**Type:** New feature   
**Service category:** MS Graph                     
**Product capability:**  End User Experiences             

An extra property is added to signInActivity API to display the last **successful** sign in time for a specific user, regardless if the sign in was interactive or non-interactive. The data won't be backfilled for this property, so you should expect to be returned only successful sign in data starting on December 8, 2023.

---

### General Availability - Autorollout of Conditional Access policies

**Type:** New feature   
**Service category:** Conditional Access                     
**Product capability:**  Access Control             

Starting in November 2023, Microsoft begins automatically protecting customers with Microsoft managed Conditional Access policies. Microsoft creates and enables these policies in external tenants. The following policies are rolled out to all eligible tenants, who are notified before policy creation:

1. Multifactor authentication for admin portals: This policy covers privileged admin roles and requires multifactor authentication when an admin signs into a Microsoft admin portal.
1. Multifactor authentication for per-user multifactor authentication users: This policy covers users with per-user multifactor authentication and requires multifactor authentication for all resources.
1. Multifactor authentication for high-risk sign-ins: This policy covers all users and requires multifactor authentication and reauthentication for high-risk sign-ins.

For more information, see:

- [Automatic Conditional Access policies in Microsoft Entra streamline identity protection](https://www.microsoft.com/security/blog/2023/11/06/automatic-conditional-access-policies-in-microsoft-entra-streamline-identity-protection/)
- [Microsoft-managed policies](../identity/conditional-access/managed-policies.md)

---

### General Availability - Custom security attributes in Microsoft Entra ID

**Type:** New feature   
**Service category:** Directory Management                     
**Product capability:**  Directory             

Custom security attributes in Microsoft Entra ID are business-specific attributes (key-value pairs) that you can define and assign to Microsoft Entra objects. These attributes can be used to store information, categorize objects, or enforce fine-grained access control over specific Azure resources. Custom security attributes can be used with [Azure attribute-based access control (Azure ABAC)](/azure/role-based-access-control/conditions-overview). For more information, see: [What are custom security attributes in Microsoft Entra ID?](./custom-security-attributes-overview.md).

Changes were made to custom security attribute audit logs for general availability that might affect your daily operations. If you have been using custom security attribute audit logs during the preview, there are the actions you must take before February 2024 to ensure your audit log operations aren't disrupted. For more information, see: [Custom security attribute audit logs](./custom-security-attributes-manage.md#custom-security-attribute-audit-logs).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - November 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Colloquial](../identity/saas-apps/colloquial-provisioning-tutorial.md)
- [Diffchecker](../identity/saas-apps/diffchecker-provisioning-tutorial.md)
- [M-Files](../identity/saas-apps/m-files-provisioning-tutorial.md)
- [XM Fax and XM SendSecure](../identity/saas-apps/xm-fax-and-xm-send-secure-provisioning-tutorial.md)
- [Rootly](../identity/saas-apps/rootly-provisioning-tutorial.md)
- [Simple In/Out](../identity/saas-apps/simple-in-out-provisioning-tutorial.md)
- [Team Today](../identity/saas-apps/team-today-provisioning-tutorial.md)
- [YardiOne](../identity/saas-apps/yardione-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - November 2023

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** Third Party Integration          

In November 2023, we added the following 10 new applications in our App gallery with Federation support:

[Citrix Cloud](https://www.citrix.com/), [Freight Audit](/entra/identity/saas-apps/freight-audit-tutorial), [Movement by project44](/entra/identity/saas-apps/movement-by-project44-tutorial), [Alohi](/entra/identity/saas-apps/alohi-tutorial), [AMCS Fleet Maintenance](https://www.amcsgroup.com/solutions/fleet-maintenance/), [Real Links Campaign App](https://reallinks.io/), [Propely](https://www.propely.io/), [Contentstack](/entra/identity/saas-apps/contentstack-tutorial), [Jasper AI](/entra/identity/saas-apps/jasper-ai-tutorial), [IANS Client Portal](/entra/identity/saas-apps/ians-client-portal-tutorial), [Avionic Interface Technologies LSMA](https://aviftech.com/), [CultureHQ](/entra/identity/saas-apps/culturehq-tutorial), [Hone](/entra/identity/saas-apps/hone-tutorial), [Collector Systems](/entra/identity/saas-apps/collector-systems-tutorial), [NetSfere](/entra/identity/saas-apps/netsfere-tutorial), [Spendwise](https://www.spendwise.com/), [Stage and Screen](/entra/identity/saas-apps/stage-and-screen-tutorial)

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

> [!NOTE]
> In new updates from the previous version of the release notes: Microsoft Authenticator is not yet FIPS 140 compliant on Android. Microsoft Authenticator on Android is currently pending FIPS compliance certification to support our customers that may require FIPS validated cryptography.


## October 2023

### Public Preview - Managing and Changing Passwords in My Security Info 

**Type:** New feature   
**Service category:** My Profile/Account                     
**Product capability:** End User Experiences            

My Sign Ins ([My Sign-Ins (microsoft.com)](https://mysignins.microsoft.com/)) now supports end users managing and changing their passwords. Users are able to manage passwords in My Security Info and change their password inline. If a user authenticates with a password and an MFA credential, they're able to are able to change their password without entering their existing password.

For more information, see: [Combined security information registration for Microsoft Entra overview](~/identity/authentication/concept-registration-mfa-sspr-combined.md).

---

### Public Preview - Govern AD on-premises applications (Kerberos based) using Microsoft Entra Governance

**Type:** New feature   
**Service category:** Provisioning                     
**Product capability:** Microsoft Entra Cloud Sync            

Security groups provisioning to AD (also known as Group Writeback) is now publicly available through Microsoft Entra Cloud Sync. With this new capability, you can easily govern AD based on-premises applications (Kerberos based apps) using Microsoft Entra Governance.

For more information, see: [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](~/identity/hybrid/cloud-sync/govern-on-premises-groups.md)

---

### Public Preview - Microsoft Entra Permissions Management: Permissions Analytics Report PDF for multiple authorization systems

**Type:** Changed feature   
**Service category:**                      
**Product capability:** Permissions Management            

The Permissions Analytics Report (PAR) lists findings relating to permissions risks across identities and resources in Permissions Management. The PAR is an integral part of the risk assessment process where customers discover areas of highest risk in their cloud infrastructure. This report can be directly viewed in the Permissions Management UI, downloaded in Excel (XSLX) format, and exported as a PDF. The report is available for all supported cloud environments: Amazon Web Services (AWS), Microsoft Azure, and Google Cloud Platform (GCP).  

The PAR PDF was redesigned to enhance usability, align with the product UX redesign effort, and address various customer feature requests. [You can download the PAR PDF for up to 10 authorization systems](~/permissions-management/product-permissions-analytics-reports.md).

---

### General Availability - Enhanced Devices List Management Experience

**Type:** Changed feature   
**Service category:** Device Access Management                     
**Product capability:** End User Experiences            

Several changes were made to the **All Devices** list since announcing public preview, including:

- Prioritized consistency and accessibility across the different components
- Modernized the list and addressed top customer feedback
    - Added infinite scrolling, column reordering, and the ability to select all devices
    - Added filters for OS Version and Autopilot devices
- Created more connections between Microsoft Entra and Intune
    - Added links to Intune in Compliant and MDM columns
    - Added Security Settings Management column

For more information, see: [View and filter your devices](~/identity/devices/manage-device-identities.md#view-and-filter-your-devices).

---

### General Availability - Windows MAM

**Type:** New feature   
**Service category:** Conditional Access                     
**Product capability:** Access Control            

Windows MAM is the first step toward Microsoft management capabilities for unmanaged Windows devices. This functionality comes at a critical time when we need to ensure the Windows platform is on par with the simplicity and privacy promise we offer end users today on the mobile platforms. End users can access company resources without needing the whole device to be MDM managed.

For more information, see: [Require an app protection policy on Windows devices](~/identity/conditional-access/policy-all-users-windows-app-protection.md).

---

### General Availability - Microsoft Security email update and Resources for Azure Active Directory rename to Microsoft Entra ID 

**Type:** Plan for change   
**Service category:** Other                     
**Product capability:** End User Experiences            

Microsoft Entra ID is the new name for Azure Active Directory (Azure AD). The rename and new product icon are now being deployed across experiences from Microsoft. Most updates are complete by mid-November of this year. As previously announced, it's a new name change, with no effect on deployments or daily work. There are no changes to capabilities, licensing, terms of service, or support.

From October 15 to November 15, Azure AD emails previously sent from azure-noreply@microsoft.com will start being sent from MSSecurity-noreply@microsoft.com. You might need to update your Outlook rules to match this change.  

Additionally, we update email content to remove all references of Azure AD where relevant, and include an informational banner that announces this change.

Here are some resources to guide you rename your own product experiences or content where necessary:

- [How to: Rename Azure AD](how-to-rename-azure-ad.yml)
- [New name for Azure Active Directory](new-name.md)

---

### General Availability - End users will no longer be able to add password SSO apps in My Apps  

**Type:** Deprecated   
**Service category:** My Apps                     
**Product capability:** End User Experiences            

Effective November 15, 2023, end users will no longer be able to add password SSO Apps to their gallery in My Apps. However, admins can still add password SSO apps following [these instructions](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md). Password SSO apps previously added by end users remain available in My Apps.

For more information, see: [Discover applications](~/identity/enterprise-apps/myapps-overview.md#discover-applications).

---

### General Availability - Restrict Microsoft Entra ID Tenant Creation To Only Paid Subscription  

**Type:** Changed feature   
**Service category:** Managed identities for Azure resources                    
**Product capability:** End User Experiences            

The ability to create new tenants from the Microsoft Entra admin center allows users in your organization to create test and demo tenants from your Microsoft Entra ID tenant, [Learn more about creating tenants](/microsoft-365/education/deploy/intro-azure-active-directory). When used incorrectly this feature can allow the creation of tenants that aren't managed or viewable by your organization. We recommend that you restrict this capability so that only trusted admins can use this feature, [Learn more about restricting member users' default permissions](users-default-permissions.md#restrict-member-users-default-permissions). We also recommend you use the Microsoft Entra audit log to monitor for the Directory Management: Create Company event that signals a new tenant created by a user in your organization.  

To further protect your organization, Microsoft is now limiting this functionality to only paid customers. Customers on trial subscriptions are unable to create more tenants from the Microsoft Entra admin center. Customers in this situation who need a new trial tenant can sign up for a [Free Azure Account](https://azure.microsoft.com/free/).

---

### General Availability - Users can't modify GPS location when using location based access control

**Type:** Plan for change   
**Service category:** Conditional Access                     
**Product capability:** User Authentication            

In an ever-evolving security landscape, the Microsoft Authenticator is updating its security baseline for Location Based Access Control (LBAC) Conditional Access policies. Microsoft does this to disallow authentications where the user might be using a different location than the actual GPS location of the mobile device. Today, it's possible for users to modify the location reported by the device on iOS and Android devices. The Authenticator app starts to deny LBAC authentications where we detect that the user isn't using the actual location of the mobile device where the Authenticator is installed.

In the November 2023 release of the Authenticator app, users who are modifying the location of their device sees a denial message in the app when doing an LBAC authentication. Microsoft ensures that users aren’t using older app versions to continue authenticating with a modified location. Beginning January 2024, any users that are on Android Authenticator 6.2309.6329 version or prior and iOS Authenticator version 6.7.16 or prior are blocked from using LBAC. To determine which users are using older versions of the Authenticator app, you can use [our MSGraph APIs](/graph/api/resources/microsoftauthenticatorauthenticationmethod).

---

### Public Preview - Overview page in My Access portal

**Type:** New feature   
**Service category:** Entitlement Management                     
**Product capability:** Identity Governance            

Today, when users navigate to myaccess.microsoft.com, they land on a list of available access packages in their organization. The new Overview page provides a more relevant place for users to land. The Overview page points them to the tasks they need to complete and helps familiarize users with how to complete tasks in My Access.  

Admins can enable/disable the Overview page preview by signing into the Microsoft Entra admin center and navigating to Entitlement management > Settings > Opt-in Preview Features and locating My Access overview page in the table.

For more information, see: [My Access Overview page](~/id-governance/my-access-portal-overview.md#overview-page).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - October 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    
      

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Amazon Business](~/identity/saas-apps/amazon-business-provisioning-tutorial.md)
- [Bustle B2B Transport Systems](~/identity/saas-apps/bustle-b2b-transport-systems-provisioning-tutorial.md)
- [Canva](~/identity/saas-apps/canva-provisioning-tutorial.md)
- [Cybozu](~/identity/saas-apps/cybozu-provisioning-tutorial.md)
- [Forcepoint Cloud Security Gateway - User Authentication](~/identity/saas-apps/forcepoint-cloud-security-gateway-provisioning-tutorial.md)
- [Hypervault](~/identity/saas-apps/hypervault-provisioning-tutorial.md)
- [Oneflow](~/identity/saas-apps/oneflow-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### Public Preview - Microsoft Graph Activity Logs

**Type:** New feature   
**Service category:** Microsoft Graph                     
**Product capability:** Monitoring & Reporting            

The MicrosoftGraphActivityLogs provides administrators full visibility into all HTTP requests accessing your tenant’s resources through the Microsoft Graph API. These logs can be used to find activity from compromised accounts, identify anomalous behavior, or investigate application activity. For more information, see: [Access Microsoft Graph activity logs (preview)](/graph/microsoft-graph-activity-logs-overview).

---

### Public Preview - Microsoft Entra Verified ID quick setup

**Type:** New feature   
**Service category:** Other                     
**Product capability:** Identity Governance            

Quick Microsoft Entra Verified ID setup, available in preview, removes several configuration steps an admin needs to complete with a single select on a Get started button. The quick setup takes care of signing keys, registering your decentralized ID, and verifying your domain ownership. It also creates a Verified Workplace Credential for you. For more information, see: [Quick Microsoft Entra Verified ID setup](~/verified-id/verifiable-credentials-configure-tenant-quick.md).

---


## September 2023

### Public Preview - Changes to FIDO2 authentication methods and Windows Hello for Business

**Type:**  Changed feature            
**Service category:**  Authentications (Logins)                                
**Product capability:**  User Authentication                        

Beginning **January 2024**, Microsoft Entra ID supports [device-bound passkeys](https://passkeys.dev/docs/reference/terms/#device-bound-passkey) stored on computers and mobile devices as an authentication method in public preview, in addition to the existing support for FIDO2 security keys. This update enables your users to perform phishing-resistant authentication using the devices that they already have.  

We expand the existing FIDO2 authentication methods policy, and end user experiences, to support this preview release. For your organization to opt in to this preview, you need to enforce key restrictions to allow specified passkey providers in your FIDO2 policy. Learn more about FIDO2 key restrictions [here](~/identity/authentication/howto-authentication-passwordless-security-key.md).

In addition, the existing end user sign-in option for Windows Hello and FIDO2 security keys get indicated by “Face, fingerprint, PIN, or security key”. The term “passkey” will be mentioned in the updated sign-in experience to be inclusive of passkey credentials presented from security keys, mobile devices, and platform authenticators like Windows Hello.

---

### General Availability - Recovery of deleted application and service principals is now available

**Type:**  New feature            
**Service category:**  Enterprise Apps                                
**Product capability:**  Identity Lifecycle Management                        

With this release, you can now recover applications along with their original service principals, eliminating the need for extensive reconfiguration and code changes ([Learn more](~/identity/enterprise-apps/delete-recover-faq.yml)). It significantly improves the application recovery story and addresses a long-standing customer need. This change is beneficial to you on:

- **Faster Recovery**: You can now recover their systems in a fraction of the time it used to take, reducing downtime and minimizing disruptions.
- **Cost Savings**: With quicker recovery, you can save on operational costs associated with extended outages and labor-intensive recovery efforts.
- **Preserved Data**: Previously lost data, such as SMAL configurations, is now retained, ensuring a smoother transition back to normal operations.
- **Improved User Experience**: Faster recovery times translate to improved user experience and customer satisfaction, as applications are backed up and running swiftly.

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - September 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    
      

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Datadog](~/identity/saas-apps/datadog-provisioning-tutorial.md)
- [Litmos](~/identity/saas-apps/litmos-provisioning-tutorial.md)
- [Postman](~/identity/saas-apps/postman-provisioning-tutorial.md)
- [Recnice](~/identity/saas-apps/recnice-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - Web Sign-In for Windows

**Type:** Changed feature              
**Service category:** Authentications (Logins)                                 
**Product capability:** User Authentication    

We're thrilled to announce that as part of the Windows 11 September moment, we're releasing a new Web Sign-In experience that will expand the number of supported scenarios and greatly improve security, reliability, performance, and overall end-to-end experience for our users.

Web Sign-In (WSI) is a credential provider on the Windows lock/sign-in screen for AADJ joined devices that provide a web experience used for authentication and returns an auth token back to the operating system to allow the user to unlock/sign-in to the machine.

Web Sign-In was initially intended to be used for a wide range of auth credential scenarios; however, it was only previously released for limited scenarios such as: [Simplified EDU Web Sign-In](/education/windows/federated-sign-in?tabs=intune) and recovery flows via [Temporary Access Password (TAP)](~/identity/authentication/howto-authentication-temporary-access-pass.md).

The underlying provider for Web Sign-In is rewritten from the ground up with security and improved performance in mind. This release moves the Web Sign-in infrastructure from the Cloud Host Experience (CHX) WebApp to a newly written sign in Web Host (LWH) for the September moment. This release provides better security and reliability to support previous EDU & TAP experiences and new workflows enabling using various Auth Methods to unlock/sig in to the desktop.                    

---

### General Availability - Support for Microsoft admin portals in Conditional Access

**Type:** New feature             
**Service category:** Conditional Access                                   
**Product capability:** Identity Security & Protection    

When a Conditional Access policy targets the Microsoft Admin Portals cloud app, the policy is enforced for tokens issued to application IDs of the following Microsoft administrative portals:

- Azure portal
- Exchange admin center
- Microsoft 365 admin center
- Microsoft 365 Defender portal
- Microsoft Entra admin center
- Microsoft Intune admin center
- Microsoft Purview compliance portal                   

For more information, see: [Microsoft Admin Portals](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#microsoft-admin-portals).

---

## August 2023

### General Availability - Tenant Restrictions V2

**Type:** New feature         
**Service category:** Authentications (Logins)                              
**Product capability:** Identity Security & Protection                    

**Tenant Restrictions V2 (TRv2)** is now generally available for authentication plane via proxy.  

TRv2 allows organizations to enable safe and productive cross-company collaboration while containing data exfiltration risk. With TRv2, you can control what external tenants your users can access from your devices or network using externally issued identities and provide granular access control on a per org, user, group, and application basis.    

TRv2 uses the cross-tenant access policy, and offers both authentication and data plane protection. It enforces policies during user authentication, and on data plane access with Exchange Online, SharePoint Online, Teams, and MSGraph.  While the data plane support with Windows GPO and Global Secure Access is still in public preview, authentication plane support with proxy is now generally available. 

Visit https://aka.ms/tenant-restrictions-enforcement for more information on tenant restriction V2 and Global Secure Access client side tagging for TRv2 at [Universal tenant restrictions](/entra/global-secure-access/how-to-universal-tenant-restrictions).   

---

### Public Preview - Cross-tenant access settings supports custom Role-Based Access Controls roles and protected actions

**Type:** New feature         
**Service category:** B2B                               
**Product capability:** B2B/B2C                    

Cross-tenant access settings can be managed with custom roles defined by your organization. This capability enables you to define your own finely scoped roles to manage cross-tenant access settings instead of using one of the built-in roles for management. [Learn more about creating your own custom roles](~/external-id/cross-tenant-access-overview.md#custom-roles-for-managing-cross-tenant-access-settings).

You can also now protect privileged actions inside of cross-tenant access settings using Conditional Access. For example, you can require MFA before allowing changes to default settings for B2B collaboration. Learn more about [Protected actions](~/identity/role-based-access-control/protected-actions-overview.md).

---

### General Availability - Additional settings in Entitlement Management autoassignment policy
 
**Type:** Changed feature    
**Service category**: Entitlement Management    
**Product capability:** Entitlement Management    

In the Microsoft Entra ID Governance entitlement management autoassignment policy, there are three new settings. This capability allows a customer to select to not have the policy create assignments, not remove assignments, and to delay assignment removal.

---

### Public Preview - Setting for guest losing access

**Type:** Changed feature          
**Service category:** Entitlement Management                             
**Product capability:** Entitlement Management                    

An administrator can configure that when a guest brought in through entitlement management has lost their last access package assignment, they're deleted after a specified number of days. For more information, see: [Govern access for external users in entitlement management](~/id-governance/entitlement-management-external-users.md).

---

### Public Preview - Real-Time Strict Location Enforcement

**Type:** New feature         
**Service category:** Continuous Access Evaluation                              
**Product capability:** Access Control                    

Strictly enforce Conditional Access policies in real-time using Continuous Access Evaluation. Enable services like Microsoft Graph, Exchange Online, and SharePoint Online to block access requests from disallowed locations as part of a layered defense against token replay and other unauthorized access. For more information, see blog: [Public Preview: Strictly Enforce Location Policies with Continuous Access Evaluation](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/public-preview-strictly-enforce-location-policies-with/ba-p/3773133) and documentation:
[Strictly enforce location policies using continuous access evaluation (preview)](~/identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - August 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    
      

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Airbase](~/identity/saas-apps/airbase-provisioning-tutorial.md)
- [Airtable](~/identity/saas-apps/airtable-provisioning-tutorial.md)
- [Cleanmail Swiss](~/identity/saas-apps/cleanmail-swiss-provisioning-tutorial.md)
- [Informacast](~/identity/saas-apps/informacast-provisioning-tutorial.md)
- [Kintone](~/identity/saas-apps/kintone-provisioning-tutorial.md)
- [O'reilly learning platform](~/identity/saas-apps/oreilly-learning-platform-provisioning-tutorial.md)
- [Tailscale](~/identity/saas-apps/tailscale-provisioning-tutorial.md)
- [Tanium SSO](~/identity/saas-apps/tanium-sso-provisioning-tutorial.md)
- [Vbrick Rev Cloud](~/identity/saas-apps/vbrick-rev-cloud-provisioning-tutorial.md)
- [Xledger](~/identity/saas-apps/xledger-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).


---

### General Availability - Continuous Access Evaluation for Workload Identities available in Public and Gov clouds

**Type:** New feature         
**Service category:** Continuous Access Evaluation                              
**Product capability:** Identity Security & Protection                    

Real-time enforcement of risk events, revocation events, and Conditional Access location policies is now generally available for workload identities.
Service principals on line of business (LOB) applications are now protected on access requests to Microsoft Graph. For more information, see: [Continuous access evaluation for workload identities (preview)](~/identity/conditional-access/concept-continuous-access-evaluation-workload.md).

---

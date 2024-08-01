---
title: What's new? Release notes
description: Learn what is new with Microsoft Entra ID, such as the latest release notes, known issues, bug fixes, deprecated functionality, and upcoming changes.
author: owinfreyATL
manager: amycolannino
featureFlags:
 - clicktale
ms.assetid: 06a149f7-4aa1-4fb9-a8ec-ac2633b031fb
ms.service: entra
ms.subservice: fundamentals
ms.topic: whats-new
ms.date: 02/01/2024
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
---

# What's new in Microsoft Entra ID?

>Get notified about when to revisit this page for updates by copying and pasting this URL: `https://learn.microsoft.com/api/search/rss?search=%22Release+notes+-+Azure+Active+Directory%22&locale=en-us` into your ![RSS feed reader icon](./media/whats-new/feed-icon-16x16.png) feed reader.

Microsoft Entra ID (previously known as Azure Active Directory) receives improvements on an ongoing basis. To stay up to date with the most recent developments, this article provides you with information about:

- The latest releases
- Known issues
- Bug fixes
- Deprecated functionality
- Plans for changes

> [!NOTE] 
> If you're currently using Azure Active Directory today or are have previously deployed Azure Active Directory in your organizations, you can continue to use the service without interruption. All existing deployments, configurations, and integrations continue to function as they do today without any action from you.

This page updates monthly, so revisit it regularly. If you're looking for items older than six months, you can find them in [Archive for What's new in Microsoft Entra ID?](whats-new-archive.md).

## July 2024

### General Availability - Insider Risk condition in Conditional Access is GA

**Type:** New feature    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

**Insider Risk condition in Conditional Access is now GA**

Insider Risk condition, in Conditional Access, is a new feature that leverages signals from Microsoft Purview's Adaptive Protection capability to enhance the detection and automatic mitigation of Insider threats. This integration allows organizations to more effectively manage, and respond, to potential insider risks by using advanced analytics and real-time data.

For example, if Purview detects unusual activity from a user, Conditional Access can enforce extra security measures such as requiring multifactor authentication (MFA) or blocking access. This is a premium feature and requires a P2 license. For more information, see: [Common Conditional Access policy: Block access for users with insider risk](../identity/conditional-access/how-to-policy-insider-risk.md).

---

### General Availability - New SAML applications can't receive tokens through OAuth2/OIDC protocols

**Type:** Plan for change    
**Service category:** Enterprise Apps    
**Product capability:** Developer Experience    

Starting late September 2024, applications indicated as '*SAML*' applications (via the 'preferredSingleSignOnMode' property of the service principal) can't be issued JWT tokens. This means they can't be the resource application in OIDC, OAuth2.0, or other protocols using JWTs. This change will only affect SAML applications attempting to take a new dependency on JWT-based protocols; existing SAML applications already using these flows won't be affected.  This will improve the security of apps.  

For more information, see: [SAML authentication with Microsoft Entra ID](/entra/architecture/auth-saml).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - July 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In February 2024 we added the following 10 new applications in our App gallery with Federation support:

[Fullstory SAML](../identity/saas-apps/fullstory-saml-tutorial.md), [LSEG Workspace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/aad.lsegworkspace?tab=Overview)

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

### General Availability - Active Directory Federation Services (AD FS) Application Migration Wizard

**Type:** New feature    
**Service category:** AD FS Application Migration    
**Product capability:** Platform    

The Active Directory Federation Services (AD FS) application migration wizard allows the user to quickly identify which AD FS relying party applications are compatible with being migrated to Microsoft Entra ID. The tool shows the migration readiness of each application, highlights issues and the suggested actions to remediate, guides the user through preparing an individual application for migration, and configuring their new Microsoft Entra application. For more information on how to use this feature, see: [Use AD FS application migration to move AD FS apps to Microsoft Entra ID](../identity/enterprise-apps/migrate-ad-fs-application-howto.md).

---

### General Availability -  Attacker in the Middle detection alert in Identity Protection

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

The Attacker in the Middle detection is now Generally Available for users in Identity Protection. 

This high precision detection will be triggered on a user account that has been compromised by an adversary that has intercepted the user's credentials, including tokens that were issued to the user. The risk is identified through Microsoft 365 Defender and will raise the user with High risk to trigger the configured Conditional Access policy.

For more information on this feature, see: [What are risk detections?](..//id-protection/concept-identity-protection-risks.md)

---

### General Availability - Easy authentication with Azure App Service and Microsoft Entra External ID

**Type:** Changed feature    
**Service category:** B2C - Consumer Identity Management    
**Product capability:** B2B/B2C    

An improved experience when using Microsoft Entra External ID as an identity provider for Azure App Service’s built-in authentication, simplifying the process of configuring authentication and authorization for external-facing apps. You can complete initial configuration directly from the App Service authentication setup without switching into the external tenant. For more information, see: [Quickstart: Add app authentication to your web app running on Azure App Service](/azure/app-service/scenario-secure-app-authentication-app-service?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=external-configuration).

---


## June 2024


### General Availability - Security Improvements to Microsoft Entra Connect Sync and Connect Health

**Type:** Changed feature    
**Service category:** Provisioning    
**Product capability:** Entra Connect    

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

Starting June 2024, we're releasing the capability to manage user status (Enforced, Enabled, Disabled) for per-user multifactor authentication through MS Graph API. This replaces the legacy MSOnline PowerShell module that is being retired. The recommended approach to protect users with Microsoft Entra multifactor authentication is Conditional Access (for licensed organizations) and security defaults (for unlicensed organizations). For more information, see: [Enable per-user Microsoft Entra multifactor authentication to secure sign-in events](..//identity/authentication/howto-mfa-userstates.md).

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

In July, enhancements for the Microsoft Authenticator app UX roll-out. The account details page of a user account will be reorganized to help users better understand, and interact with, the information and buttons on the screen. Key actions that a user can do today will still be available in the refactored page, but they're organized in three sections or categories that help better communicate to users:

- Credentials configured in the app
- Additional sign in methods they can configure
- Account management options in the app

---

### General Availability - SLA Attainment Report at the Tenant Level

**Type:** New feature    
**Service category:** Reporting    
**Product capability:** Monitoring & Reporting    

In addition to providing global SLA performance, Microsoft Entra ID reports tenant-level SLA performance for organizations with at least 5,000 monthly active users. This feature entered general availability in May 2024. The Service Level Agreement (SLA) sets a minimum bar of 99.99% for the availability of Microsoft Entra ID user authentication, reported on a monthly basis in the Microsoft Entra admin center. For more information, see: [What is Microsoft Entra Health?](../identity/monitoring-health/concept-microsoft-entra-health.md)

---

### Private Preview – QR code sign-in, a new authentication method for Frontline Workers 

**Type:** New feature    
**Service category:** Authentications (Logins)    
**Product capability:** User Authentication    

We're introducing a new simple way for Frontline Workers to authenticate in Microsoft Entra ID with a QR code and PIN, eliminating the need to enter long UPNs and alphanumeric passwords multiple times during their shift. 

With the private preview release of this feature in August 2024, all users in your tenant see a new link ‘Sign in with QR code’ on navigating to https://login.microsoftonline.com > ‘*Sign-in options*’ > ‘*Sign in to an organization*’ page. This new link, ‘Sign in with QR code’, will be visible only on mobile devices (Android/iOS/iPadOS). If you aren't participating in the private preview, users from your tenant won't be able to sign-in through this method while we're still in private preview. They receive an error message if they try to sign-in. 

The feature has a ‘preview’ tag until it's generally available. Your organization needs to be enabled to test this feature. Broad testing will be available in public preview, which we'll announce later.   

While the feature is in private preview, no technical support is provided. Learn more about support during previews here: [Microsoft Entra ID preview program information](../fundamentals/licensing-preview-info.md).

---

## May 2024

### General Availability - Azure China 21Vianet now supports My sign-ins and MFA/SSPR Combined Registration

**Type:** Changed feature    
**Service category:** MFA        
**Product capability:** Identity Security & Protection        

Starting end of June 2024, all organizations utilizing Microsoft Azure China 21Vianet will now have access to My Sign-ins activity reporting. They're required to use the combined security information registration end-user experience for MFA and SSPR. As a result of this enablement, users now see a unified SSPR and MFA registration experience when prompted to register for SSPR or MFA. For more information, see: [Combined security information registration for Microsoft Entra overview](../identity/authentication/concept-registration-mfa-sspr-combined.md). 

---

### General Availability - $select in signIn API

**Type:** New feature    
**Service category:** MS Graph    
**Product capability:** Monitoring & Reporting    

The long-awaited `$select` has been implemented into the signIn API. Utilize the `$select` to reduce the number of attributes that are returned for each log. This should greatly help customers who deal with throttling issues, and allow every customer to run faster, more efficient queries.

---

### General Availability - Multiple Passwordless Phone Sign-ins for Android Devices

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
- It also opens the door for existing Microsoft Entra customers to use Bicep templates and IaC practices to deploy and manage their tenant's Entra resources.

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

Customers can now apply their confidential HR data stored in custom security attributes in addition to other attributes to define the scope of their workflows in Lifecycle Workflows for automating joiner, mover, and leaver scenarios. For more information, see: [Use custom security attributes to scope a workflow](../id-governance/lifecycle-workflow-insights.md).

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

### General Availability - LastSuccessfulSignIn

**Type:** Changed feature    
**Service category:** MS Graph    
**Product capability:** Monitoring & Reporting    

Due to popular demand and increased confidence in the stability of the properties, we've added LastSuccessfulSignIn & LastSuccessfulSigninDateTime into V1. Feel free to take dependencies on these properties in your production environments now. For more information, see: [signInActivity resource type](/graph/api/resources/signinactivity).

---

### General Availability - Changing default accepted token version for new applications

**Type:** Plan for change    
**Service category:** Other    
**Product capability:** Developer Experience    

Starting August 2024, new Microsoft Entra applications created using any interface (including the Microsoft Entra admin center, Azure portal, Powershell/CLI, or the Microsoft Graph application API) will have the default value of the 'requestedAccessTokenVersion' property in the app registration set to '2'; this is a change from the previous default of 'null' (meaning '1'). This means that new resource applications receive v2 access tokens instead of v1 by default. This improves the security of apps. For more information on differences between token versions, see: [Access tokens in the Microsoft identity platform](../identity-platform/access-tokens.md) and [Access token claims reference](../identity-platform/access-token-claims-reference.md).

---

### General Availability - Windows Account extension is now Microsoft Single Sign On

**Type:** Changed feature    
**Service category:** Authentications (Logins)    
**Product capability:** SSO    

The Windows Account extension is now the [Microsoft Single Sign On](https://chromewebstore.google.com/detail/microsoft-single-sign-on/ppnbnpeolgkicgegkbkbjmhlideopiji) extension in docs and Chrome store. The Windows Account extension is updated to represent the new macOS compatibility. It's now known as the Microsoft Single Sign On extension for Chrome, offering single sign-on and device identity features with the Enterprise SSO plug-in for Apple devices. This is just a name change for the extension, there are no software changes to the extension itself.

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - May 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** 3rd Party Integration    

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

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
**Product capability:** Entra Cloud Sync    

Security groups provisioning to Active Directory (also known as Group Writeback) is now generally available through Microsoft Entra Cloud Sync in Azure Global and Azure Government clouds. With this new capability, you can easily govern Active Directory based on-premises applications (Kerberos based apps) using Microsoft Entra Governance. For more information, see: [Provision groups to Active Directory using Microsoft Entra Cloud Sync](../identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md).

---

### Decommissioning of Group Writeback V2 (Public Preview) in Entra Connect Sync

**Type:** Plan for change   
**Service category:** Provisioning                     
**Product capability:**  Microsoft Entra Connect Sync             

The public preview of Group Writeback V2 (GWB) in Entra Connect Sync will no longer be available after June 30, 2024. After this date, Connect Sync will no longer support provisioning cloud security groups to Active Directory.

Another similar functionality is offered in Entra Cloud Sync, called “*Group Provision to AD*”, that maybe used instead of GWB V2 for provisioning cloud security groups to AD. Enhanced functionality in Cloud Sync, along with other new features, are being developed.

Customers who use this preview feature in Connect Sync should [switch their configuration from Connect Sync to Cloud Sync](../identity/hybrid/cloud-sync/migrate-group-writeback.md). Customers can choose to move all their hybrid sync to Cloud Sync (if it supports their needs) or Cloud Sync can be run side-by-side and move only cloud security group provisioning to AD onto Cloud Sync.

Customers who provision Microsoft 365 groups to AD can continue using GWB V1 for this capability.  

Customers can evaluate moving exclusively to Cloud Sync by using this wizard: https://aka.ms/EvaluateSyncOptions

---

### General availability - PIM approvals and activations on the Azure mobile app (iOS and Android) are available now

**Type:** New feature    
**Service category:** Privileged Identity Management    
**Product capability:** Privileged Identity Management    

PIM is now available on the Azure mobile app in both iOS and Android. Customers can now approve or deny incoming PIM activation requests, in addition to activating Microsoft Entra ID and Azure resource role assignments, directly from the app on their phone. For more information, see: [Activate PIM roles using the Azure mobile app](/entra/id-governance/privileged-identity-management/pim-resource-roles-activate-your-roles).

---

### General Availability - On-premises password reset remediates user risk

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Organizations who enabled password hash synchronization can now allow password changes on-premises to remediate user risk. You can also use this to save hybrid users time and maintain their productivity with automatic self-service remediation in risk-based Conditional Access policies. For more information, see: [Remediate risks and unblock users](../id-protection/howto-identity-protection-remediate-unblock.md).

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

Microsoft Entra organizations could previously have a maximum of 5,000 dynamic groups and dynamic administrative units combined. 

We have increased this quota to 15000. For example, you can now have 5,000 dynamic groups and 10,000 dynamic AUs (or any other combination that adds up to 15k). You don't need to do anything to take advantage of this change - its available right now. For more information, see: [Microsoft Entra service limits and restrictions](../identity/users/directory-service-limits-restrictions.md).

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

The maximum number of workflows that can be configured in Lifecycle workflows has increased. Now IT admins can create up to 100 workflows in Lifecycle workflows. For more information, see: [Microsoft Entra ID Governance service limits](../id-governance/governance-service-limits.md).

---

### Public Preview - Configure custom workflows to run mover tasks when a user's job profile changes

**Type:** New feature    
**Service category:** Lifecycle Workflows    
**Product capability:** Identity Governance    

Lifecycle Workflows now supports the ability to trigger workflows based on job change events like changes to an employee's department, job role, or location and see them executed on the workflow schedule. With this feature, customers can use new workflow triggers to create custom workflows for executing tasks associated with employees moving within the organization including:

- Trigger workflows when a specified attribute changes
- Triggering workflows when a user is added or removed from a group's membership
- Tasks to notify a user's manager about a move
- Task to assign licenses or remove selected licenses from a user

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
**Product capability:** 3rd Party Integration    

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

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

By assigning Microsoft Entra roles to employees, and guests, using Entitlement Management, you can look at a user's entitlements to quickly determine which roles are assigned to that user. When you include a Microsoft Entra role as a resource in an access package, you can also specify whether that role assignment is “eligible” or “active”.

Assigning Microsoft Entra roles through access packages helps to efficiently manage role assignments at scale and improves the role. For more information, see: [Assign Microsoft Entra roles (Preview)](../id-governance/entitlement-management-roles.md).

---

### General Availability - Self-service password reset Admin policy expansion to include additional roles

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

Customer Lockbox for Microsoft Azure is launching a new feature that enables customers to use alternate email IDs for getting lockbox notifications. This enables Lockbox customers to receive notifications in scenarios where their Azure account isn't email enabled, or if they have a service principal defined as the tenant admin or subscription owner.

---

### Plan for change - Conditional Access location condition is moving up

**Type:** Plan for change    
**Service category:** Conditional Access    
**Product capability:** Identity Security & Protection    

Starting mid-April 2024, the Conditional Access *‘Locations’* condition is moving up. Locations become the '*Network*' assignment, with the new Global Secure Access assignment - '*All compliant network locations*'.

This change will occur automatically, and admins won’t need to take any action. Here's more details:

- The familiar ‘*Locations*’ condition is unchanged, updating the policy in the ‘*Locations*’ condition are reflected in the ‘*Network*’ assignment, and vice versa.
- No functionality changes, existing policies continue to work without changes.

---

### General Availability - Just-in-time application access with PIM for Groups

**Type:** New feature    
**Service category:** Privileged Identity Management    
**Product capability:** Privileged Identity Management    

Provide just-in-time access to non-Microsoft applications such as AWS & GCP. This capability integrates PIM for groups, and application provisioning to reduce the activation time from 40+ minutes to roughly 2 minutes when requesting just-in-time access to a role in a non-Microsoft app.

For more information, see:

- [AWS](../identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups)
- [GCP](../identity/saas-apps/g-suite-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups)

---

### Public Preview - Azure Lockbox Approver Role for Subscription Scoped Requests

**Type:** New feature    
**Service category:** Other    
**Product capability:** Identity Governance    

Customer Lockbox for Microsoft Azure is launching a new built-in Azure Role-based access control role that enables customers to use a lesser privileged role for users responsible for approving/rejecting Customer Lockbox requests. This feature is targeted to the customer admin workflow where a lockbox approver acts on the request from Microsoft Support engineer to access Azure resources in a customer subscription.

In this first phase, we're launching a new built-in Azure Role-based access control role that helps scope down the access possible for an individual with Azure Customer Lockbox approver rights on a subscription and its resources. A similar role for tenant-scoped requests is available in subsequent releases.

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - March 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** 3rd Party Integration    

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

With API-driven inbound provisioning, Microsoft Entra ID provisioning service now supports integration with any system of record. Customers, and partners, can use any automation tool of their choice to retrieve workforce data from any system of record for provisioning into Microsoft Entra ID and connected on-premises Active Directory domains. The IT admin has full control on how the data is processed and transformed with attribute mappings. Once the workforce data is available in Microsoft Entra ID, the IT admin can configure appropriate joiner-mover-leaver business processes using Microsoft Entra ID Governance Lifecycle Workflows. For more information, see: [API-driven inbound provisioning concepts](../identity/app-provisioning/inbound-provisioning-api-concepts.md).

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

### Plan for change - Microsoft Entra ID Identity protection: "Low" risk age out

**Type:** Plan for change    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Starting March 31, 2024, all "*low*" risk detections and users in Microsoft Entra ID Identity Protection that are older than 6 months will be automatically aged out and dismissed. This allows customers to focus on more relevant risk and provide a cleaner investigation environment. For more information, see: [What are risk detections?](../id-protection/concept-identity-protection-risks.md).

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

Conditional access policies can now be filtered on actor, target resources, conditions, grant control and session control. The granular filtering experience can help admins quickly discover policies containing specific configurations. For more information, see: [What is Conditional Access?](../identity/conditional-access/overview.md).

---

### End of support - Windows Azure Active Directory Connector for Forefront Identity Manager (FIM WAAD Connector)

**Type:** Deprecated    
**Service category:** Microsoft Identity Manager    
**Product capability:** Inbound to Microsoft Entra ID    

The Windows Azure Active Directory Connector for Forefront Identity Manager (FIM WAAD Connector) from 2014 was deprecated in 2021. The standard support for this connector ended in April 2024. Customers must remove this connector from their MIM sync deployment, and instead use an alternative provisioning mechanism. For more information, see: [Migrate a Microsoft Entra provisioning scenario from the FIM Connector for Microsoft Entra ID](/microsoft-identity-manager/migrate-from-the-fim-connector-for-azure-active-directory).

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - February 2024

**Type:** New feature    
**Service category:** App Provisioning    
**Product capability:** 3rd Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Alohi](../identity/saas-apps/alohi-provisioning-tutorial.md)
- [Insightly SAML](../identity/saas-apps/insightly-saml-provisioning-tutorial.md)
- [Starmind](../identity/saas-apps/starmind-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - February 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In February 2024 we added the following 10 new applications in our App gallery with Federation support:

[Presswise](../identity/saas-apps/presswise-tutorial.md), [Stonebranch Universal Automation Center (SaaS Cloud)](../identity/saas-apps/stonebranch-universal-automation-center-saas-cloud-tutorial.md), [ProductPlan](../identity/saas-apps/productplan-tutorial.md), [Bigtincan for Outlook](https://www.bigtincan.com/content/), [Blinktime](https://www.blinktime.io/), [Stargo](http://www.stargo.co/), [Garage Hive BC v2](https://garagehive.co.uk/), [Avochato](https://www.avochato.com/), [Luscii](https://vitals.luscii.com/), [LEVR](https://levr.work/), [XM Discover](../identity/saas-apps/xm-discover-tutorial.md), [Sailsdock](https://www.sailsdock.no/), [Mercado Eletronico SAML](../identity/saas-apps/mercado-eletronico-saml-tutorial.md), [Moveworks](../identity/saas-apps/moveworks-tutorial.md), [Silbo](https://app.ambuliz.com/), [Alation Data Catalog](../identity/saas-apps/alation-data-catalog-tutorial.md), [Papirfly SSO](../identity/saas-apps/papirfly-sso-tutorial.md), [Secure Cloud User Integration](https://opentextcybersecurity.com/), [AlbertStudio](https://sandbox.albertinvent.com/), [Automatic Email Manager](https://www.automatic-email-manager.com/?utm_source=azuregallery), [Streamboxy](https://en.streamboxy.com/), [NewHotel PMS](http://www.newhotelcloud.com/), [Ving Room](https://www.letsving.com/), [Trevanna Tracks](../identity/saas-apps/trevanna-tracks-tutorial.md), [Alteryx Server](../identity/saas-apps/alteryx-server-tutorial.md), [RICOH Smart Integration](https://www.ricoh.com/), [Genius](), [Othership Workplace Scheduler](), [GitHub Enterprise Managed User - ghe.com](../identity/saas-apps/github-enterprise-managed-user-tutorial.md),[Thumb Technologies](https://www.thumb.is/), [Freightender SSO for TRP (Tender Response Platform)](../identity/saas-apps/freightender-sso-for-trp-tender-response-platform-tutorial.md), [BeWhere Portal (UPS Access)](http://www.bewhere.com/), [Flexiroute](https://www.flexiroute.net/), [SEEDL](https://www.seedlgroup.com/), [Isolocity](https://www.isolocity.com/), [SpotDraft](../identity/saas-apps/spotdraft-tutorial.md), [Blinq](../identity/saas-apps/blinq-tutorial.md), [Cisco Phone OBTJ](https://www.cisco.com/), [Applitools Eyes](../identity/saas-apps/applitools-eyes-tutorial.md).

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

---
title: Archive for Microsoft Entra releases and announcements
description: The What's new release notes in the Overview section of this content set contain six months of activity. After six months, the items are removed from the main article and put into this archive article.
author: owinfreyATL
manager: amycolannino
ms.service: entra 
ms.subservice: fundamentals
ms.topic: whats-new
ms.date: 09/19/2024
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-adal-ref, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
---

# Archive for Microsoft Entra releases and announcements

This article includes information about the releases and change announcements across the Microsoft Entra family of products that are older than six months (up to 18 months). If you're looking for more current information, see [Microsoft Entra releases and announcements](./whats-new.md).

For a more dynamic experience, you can now find the archive information in the Microsoft Entra admin center. To learn more, see [What's new (preview)](./whats-new-overview.md).

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

Conditional access policies can now be filtered on actor, target resources, conditions, grant control, and session control. The granular filtering experience can help admins quickly discover policies containing specific configurations. For more information, see: [What is Conditional Access?](../identity/conditional-access/overview.md).

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

In an ever-evolving security landscape, the Microsoft Authenticator is updating its security baseline for Location Based Access Control (LBAC) conditional access policies. Microsoft does this to disallow authentications where the user might be using a different location than the actual GPS location of the mobile device. Today, it's possible for users to modify the location reported by the device on iOS and Android devices. The Authenticator app starts to deny LBAC authentications where we detect that the user isn't using the actual location of the mobile device where the Authenticator is installed.

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

## July 2023

### General Availability: Azure Active Directory (Azure AD) is being renamed.

**Type:** Changed feature       
**Service category:**  N/A                          
**Product capability:** End User Experiences                

**No action is required from you, but you might need to update some of your own documentation.**

Azure AD is being renamed to Microsoft Entra ID. The name change rolls out across all Microsoft products and experiences throughout the second half of 2023. 

Capabilities, licensing, and usage of the product isn't changing. To make the transition seamless for you, the pricing, terms, service level agreements, URLs, APIs, PowerShell cmdlets, Microsoft Authentication Library (MSAL) and developer tooling remain the same.   

Learn more and get renaming details: [New name for Azure Active Directory](new-name.md).

---

### General Availability - Include/exclude My Apps in Conditional Access policies

**Type:** Fixed       
**Service category:** Conditional Access                            
**Product capability:** End User Experiences                  

My Apps can now be targeted in Conditional Access policies. This solves a top customer blocker. The functionality is available in all clouds. GA also brings a new app launcher, which improves app launch performance for both SAML and other app types. 

Learn More about setting up Conditional Access policies here: [Azure AD Conditional Access documentation](~/identity/conditional-access/index.yml).

---

### General Availability - Conditional Access for Protected Actions

**Type:** New feature         
**Service category:** Conditional Access                            
**Product capability:** Identity Security & Protection                    

Protected actions are high-risk operations, such as altering access policies or changing trust settings, that can significantly impact an organization's security. To add an extra layer of protection, Conditional Access for Protected Actions lets organizations define specific conditions for users to perform these sensitive tasks. For more information, see: [What are protected actions in Azure AD?](~/identity/role-based-access-control/protected-actions-overview.md).

---

### General Availability - Access Reviews for Inactive Users

**Type:** New feature         
**Service category:** Access Reviews                            
**Product capability:** Identity Governance                      

This new feature, part of the Microsoft Entra ID Governance SKU, allows admins to review and address stale accounts that haven’t been active for a specified period. Admins can set a specific duration to determine inactive accounts that weren't used for either interactive or non-interactive sign-in activities. As part of the review process, stale accounts can automatically be removed. For more information, see: [Microsoft Entra ID Governance Introduces Two New Features in Access Reviews](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/microsoft-entra-id-governance-introduces-two-new-features-in/ba-p/2466930).

---

### General Availability - Automatic assignments to access packages in Microsoft Entra ID Governance

**Type:** Changed feature       
**Service category:** Entitlement Management                          
**Product capability:** Entitlement Management                

Microsoft Entra ID Governance includes the ability for a customer to configure an assignment policy in an entitlement management access package that includes an attribute-based rule, similar to dynamic membership groups, of the users who should be assigned access. For more information, see: [Configure an automatic assignment policy for an access package in entitlement management](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md).

---

### General Availability - Custom Extensions in Entitlement Management 

**Type:** New feature       
**Service category:** Entitlement Management                          
**Product capability:** Entitlement Management                

Custom extensions in Entitlement Management are now generally available, and allow you to extend the access lifecycle with your organization-specific processes and business logic when access is requested or about to expire. With custom extensions you can create tickets for manual access provisioning in disconnected systems, send custom notifications to other stakeholders, or automate other access-related configuration in your business applications such as assigning the correct sales region in Salesforce. You can also use custom extensions to embed external governance, risk, and compliance (GRC) checks in the access request.

For more information, see:

- [Microsoft Entra ID Governance Entitlement Management New Generally Available Capabilities](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/microsoft-entra-id-governance-entitlement-management-new/ba-p/2466929)
- [Trigger Logic Apps with custom extensions in entitlement management](~/id-governance/entitlement-management-logic-apps-integration.md)

---

### General Availability - Conditional Access templates

**Type:** Plan for change         
**Service category:** Conditional Access                             
**Product capability:** Identity Security & Protection                  

Conditional Access templates are predefined set of conditions and controls that provide a convenient method to deploy new policies aligned with Microsoft recommendations. Customers are assured that their policies reflect modern best practices for securing corporate assets, promoting secure, optimal access for their hybrid workforce. For more information, see: [Conditional Access templates](~/identity/conditional-access/concept-conditional-access-policy-common.md).

---

### General Availability - Lifecycle Workflows

**Type:** New feature       
**Service category:** Lifecycle Workflows                            
**Product capability:** Identity Governance                  

User identity lifecycle is a critical part of an organization’s security posture, and when managed correctly, can have a positive effect on their users’ productivity for Joiners, Movers, and Leavers. The ongoing digital transformation is accelerating the need for good identity lifecycle management. However, IT and security teams face enormous challenges managing the complex, time-consuming, and error-prone manual processes necessary to execute the required onboarding and offboarding tasks for hundreds of employees at once. This capability is an ever present and complex issue IT admins continue to face with digital transformation across security, governance, and compliance.

Lifecycle Workflows, one of our newest Microsoft Entra ID Governance capabilities is now generally available to help organizations further optimize their user identity lifecycle. For more information, see: [Lifecycle Workflows is now generally available!](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/lifecycle-workflows-is-now-generally-available/ba-p/2466931)

---

### General Availability - Enabling extended customization capabilities for sign-in and sign-up pages in Company Branding capabilities.

**Type:** New feature       
**Service category:** User Experience and Management                            
**Product capability:** User Authentication                

Update the Microsoft Entra ID and Microsoft 365 sign in experience with new Company Branding capabilities. You can apply your company’s brand guidance to authentication experiences with predefined templates. For more information, see: [Company Branding](~/fundamentals/how-to-customize-branding.md) 

---

### General Availability - Enabling customization capabilities for the Self-Service Password Reset (SSPR) hyperlinks, footer hyperlinks, and browser icons in Company Branding.

**Type:** Changed feature       
**Service category:** User Experience and Management                            
**Product capability:** End User Experiences                  

Update the Company Branding functionality on the Microsoft Entra ID/Microsoft 365 sign in experience to allow customizing Self Service Password Reset (SSPR) hyperlinks, footer hyperlinks, and a browser icon. For more information, see: [Company Branding](~/fundamentals/how-to-customize-branding.md) 

---

### General Availability - User-to-Group Affiliation recommendation for group Access Reviews

**Type:** New feature       
**Service category:** Access Reviews                            
**Product capability:** Identity Governance                  

This feature provides Machine Learning based recommendations to the reviewers of Access Reviews to make the review experience easier and more accurate. The recommendation uses machine learning based scoring mechanism and compares users’ relative affiliation with other users in the group, based on the organization’s reporting structure. For more information, see:  [Review recommendations for Access reviews](~/id-governance/review-recommendations-access-reviews.md) and [Introducing Machine Learning based recommendations in Access reviews](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/introducing-machine-learning-based-recommendations-in-azure-ad/ba-p/2466923)

---

### Public Preview - Inactive guest insights

**Type:** New feature       
**Service category:** Reporting                            
**Product capability:** Identity Governance                  

Monitor guest accounts at scale with intelligent insights into inactive guest users in your organization. Customize the inactivity threshold depending on your organization’s needs, narrowing down the scope of guest users you want to monitor and identify the guest users that might be inactive. For more information, see: [Monitor and clean up stale guest accounts using access reviews](~/identity/users/clean-up-stale-guest-accounts.md).

---

### Public Preview - Just-in-time application access with PIM for Groups

**Type:** New feature       
**Service category:** Privileged Identity Management                            
**Product capability:** Privileged Identity Management                  

You can minimize the number of persistent administrators in applications such as [AWS](~/identity/saas-apps/aws-single-sign-on-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups)/[GCP](~/identity/saas-apps/g-suite-provisioning-tutorial.md#just-in-time-jit-application-access-with-pim-for-groups) and get JIT access to groups in AWS and GCP. While PIM for Groups is publicly available, we also released a public preview that integrates PIM with provisioning and reduces the activation delay from 40+ minutes to 1 – 2 minutes.

---

### Public Preview - Graph beta API for PIM security alerts on Azure Active Directory roles

**Type:** New feature       
**Service category:** Privileged Identity Management                            
**Product capability:** Privileged Identity Management                 

Announcing API support (beta) for managing PIM security alerts for Azure Active Directory roles. [Azure Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/index.yml) generates alerts when there's suspicious or unsafe activity in your organization in Azure Active Directory, part of Microsoft Entra. You can now manage these alerts using REST APIs. These alerts can also be [managed through the Azure portal](~/id-governance/privileged-identity-management/pim-resource-roles-configure-alerts.md). For more information, see:  [`unifiedRoleManagementAlert` resource type](/graph/api/resources/unifiedrolemanagementalert).

---

### General Availability - Reset Password on Azure Mobile App

**Type:** New feature       
**Service category:** Other                            
**Product capability:** End User Experiences                

The Azure mobile app is enhanced to empower admins with specific permissions to conveniently reset their users' passwords. Self Service Password Reset isn't supported at this time. However, users can still more efficiently control and streamline their own sign-in and auth methods. The mobile app can be downloaded for each platform here:

- Android: https://aka.ms/AzureAndroidWhatsNew
- IOS: https://aka.ms/ReferAzureIOSWhatsNew

---

### Public Preview - API-driven inbound user provisioning 

**Type:** New feature       
**Service category:** Provisioning                              
**Product capability:** Inbound to Azure AD                  

With API-driven inbound provisioning, Microsoft Entra ID provisioning service now supports integration with any system of record. Customers and partners can use any automation tool of their choice to retrieve workforce data from any system of record for provisioning into Microsoft Entra ID and connected on-premises Active Directory domains. The IT admin has full control on how the data is processed and transformed with attribute mappings. Once the workforce data is available in Microsoft Entra ID, the IT admin can configure appropriate joiner-mover-leaver business processes using Microsoft Entra ID Governance Lifecycle Workflows. For more information, see: [API-driven inbound provisioning concepts (Public preview)](~/identity/app-provisioning/inbound-provisioning-api-concepts.md).

---

### Public Preview - Dynamic Groups based on EmployeeHireDate User attribute

**Type:** New feature       
**Service category:** Group Management                                
**Product capability:** Directory                    

This feature enables admins to create rules for dynamic membership groups based on the user objects' employeeHireDate attribute. For more information, see: [Properties of type string](~/identity/users/groups-dynamic-membership.md#properties-of-type-string).

---

### General Availability - Enhanced Create User and Invite User Experiences

**Type:** Changed feature       
**Service category:** User Management                                  
**Product capability:** User Management                      

We've increased the number of properties admins are able to define when creating and inviting a user in the Entra admin portal, bringing our UX to parity with our Create User APIs. Additionally, admins can now add users to a group or administrative unit, and assign roles. For more information, see: [Add or delete users using Azure Active Directory](./add-users.md).

---

### General Availability - All Users and User Profile

**Type:** Changed feature       
**Service category:** User Management                                  
**Product capability:** User Management                   

The All Users list now features an infinite scroll, and admins can now modify more properties in the User Profile. For more information, see: [How to create, invite, and delete users](~/fundamentals/how-to-create-delete-users.yml).

---

### Public Preview - Windows MAM

**Type:** New feature       
**Service category:** Conditional Access                                
**Product capability:** Identity Security & Protection                    

“*When will you have MAM for Windows?*” is one of our most frequently asked customer questions. We’re happy to report that the answer is: “Now!” We’re excited to offer this new and long-awaited MAM Conditional Access capability in Public Preview for Microsoft Edge for Business on Windows.

Using MAM Conditional Access, Microsoft Edge for Business provides users with secure access to organizational data on personal Windows devices with a customizable user experience. We’ve combined the familiar security features of app protection policies (APP), Windows Defender client threat defense, and Conditional Access, all anchored to Azure AD identity to ensure unmanaged devices are healthy and protected before granting data access. This capability can help businesses to improve their security posture and protect sensitive data from unauthorized access, without requiring full mobile device enrollment.

The new capability extends the benefits of app layer management to the Windows platform via Microsoft Edge for Business. Admins are empowered to configure the user experience and protect organizational data within Microsoft Edge for Business on unmanaged Windows devices.

For more information, see: [Require an app protection policy on Windows devices (preview)](~/identity/conditional-access/policy-all-users-windows-app-protection.md).

---

### General Availability - New Federated Apps available in Azure AD Application gallery - July 2023

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** Third Party Integration          

In July 2023 we've added the following 10 new applications in our App gallery with Federation support:    

[Gainsight SAML](~/identity/saas-apps/gainsight-tutorial.md), [Dataddo](https://www.dataddo.com/), [Puzzel](https://www.puzzel.com/), [Worthix App](~/identity/saas-apps/worthix-app-tutorial.md), [iOps360 IdConnect](https://iops360.com/iops360-id-connect-azuread-single-sign-on/), [Airbase](~/identity/saas-apps/airbase-tutorial.md), [Couchbase Capella - SSO](~/identity/saas-apps/couchbase-capella-sso-tutorial.md), [SSO for Jama Connect®](~/identity/saas-apps/sso-for-jama-connect-tutorial.md), [Mediment (メディメント)](https://mediment.jp/), [Netskope Cloud Exchange Administration Console](~/identity/saas-apps/netskope-cloud-exchange-administration-console-tutorial.md), [Uber](~/identity/saas-apps/uber-tutorial.md), [Plenda](https://app.plenda.nl/), [Deem Mobile](~/identity/saas-apps/deem-mobile-tutorial.md), [40SEAS](https://www.40seas.com/), [Vivantio](https://www.vivantio.com/), [AppTweak](https://www.apptweak.com/), [Vbrick Rev Cloud](~/identity/saas-apps/vbrick-rev-cloud-tutorial.md), [OptiTurn](~/identity/saas-apps/optiturn-tutorial.md), [Application Experience with Mist](https://www.mist.com/), [クラウド勤怠管理システムKING OF TIME](~/identity/saas-apps/cloud-attendance-management-system-king-of-time-tutorial.md), [Connect1](~/identity/saas-apps/connect1-tutorial.md), [DB Education Portal for Schools](~/identity/saas-apps/db-education-portal-for-schools-tutorial.md), [SURFconext](~/identity/saas-apps/surfconext-tutorial.md), [Chengliye Smart SMS Platform](~/identity/saas-apps/chengliye-smart-sms-platform-tutorial.md), [CivicEye SSO](~/identity/saas-apps/civic-eye-sso-tutorial.md), [Colloquial](~/identity/saas-apps/colloquial-tutorial.md), [BigPanda](~/identity/saas-apps/bigpanda-tutorial.md), [Foreman](https://foreman.mn/)

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Azure AD app gallery, read the details here https://aka.ms/AzureADAppRequest

---

### Public Preview - New provisioning connectors in the Azure AD Application Gallery - July 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** Third Party Integration    


We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Albert](~/identity/saas-apps/albert-provisioning-tutorial.md)
- [Rhombus Systems](~/identity/saas-apps/rhombus-systems-provisioning-tutorial.md)
- [Axiad Cloud](~/identity/saas-apps/axiad-cloud-provisioning-tutorial.md)
- [Dagster Cloud](~/identity/saas-apps/dagster-cloud-provisioning-tutorial.md)
- [WATS](~/identity/saas-apps/wats-provisioning-tutorial.md)
- [Funnel Leasing](~/identity/saas-apps/funnel-leasing-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [Automate user provisioning to SaaS applications with Azure AD](~/identity/app-provisioning/user-provisioning.md).


---

### General Availability - Microsoft Authentication Library for .NET 4.55.0

**Type:** New feature       
**Service category:** Other                                    
**Product capability:** User Authentication                     

Earlier this month we announced the release of [MSAL.NET 4.55.0](https://www.nuget.org/packages/Microsoft.Identity.Client/4.55.0), the latest version of the [Microsoft Authentication Library for the .NET platform](/entra/msal/dotnet/). The new version introduces support for user-assigned [managed identity](/entra/msal/dotnet/advanced/managed-identity) being specified through object IDs, CIAM authorities in the `WithTenantId` API, better error messages when dealing with cache serialization, and improved logging when using the [Windows authentication broker](/entra/msal/dotnet/acquiring-tokens/desktop-mobile/wam).

---

### General Availability - Microsoft Authentication Library for Python 1.23.0

**Type:** New feature       
**Service category:** Other                                    
**Product capability:** User Authentication                  

Earlier this month, the Microsoft Authentication Library team announced the release of [MSAL for Python version 1.23.0](https://pypi.org/project/msal/1.23.0/). The new version of the library adds support for better caching when using client credentials, eliminating the need to request new tokens repeatedly when cached tokens exist.

To learn more about MSAL for Python, see: [Microsoft Authentication Library (MSAL) for Python](/entra/msal/python/).

---

---
title: Archive for What's new in Microsoft Entra ID?
description: The What's new release notes in the Overview section of this content set contain six months of activity. After six months, the items are removed from the main article and put into this archive article.
author: owinfreyATL
manager: amycolannino
ms.service: entra
ms.subservice: fundamentals
ms.topic: whats-new
ms.date: 02/01/2024
ms.author: owinfrey
ms.reviewer: dhanyahk
ms.custom: it-pro, has-adal-ref, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
---

# Archive for What's new in Microsoft Entra ID?

The primary [What's new in Microsoft Entra ID? release notes](whats-new.md) article contains updates for the last six months, while this article contains Information up to 18 months.

The What's new in Microsoft Entra ID? Release notes provide information about:

- The latest releases
- Known issues
- Bug fixes
- Deprecated functionality
- Plans for changes

---

## January 2024

### Generally Availability - New Microsoft Entra Home page

**Type:** Changed feature    
**Service category:** N/A    
**Product capability:** Directory    

We redesigned the Microsoft Entra admin center's homepage to help you do the following: 

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

The *Suspicious sending patterns* risk detection type is discovered using information provided by Microsoft Defender for Office (MDO). This alert is generated when someone in your organization has sent suspicious email, and is either at risk of being restricted from sending email, or has already been restricted from sending email. This detection moves users to medium risk, and only fires in organizations that have deployed MDO. For more information, see: [What are risk detections?](../id-protection/concept-identity-protection-risks.md).

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
**Product capability:** 3rd Party Integration    

We added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Personify Inc](../identity/saas-apps/personify-inc-provisioning-tutorial.md)
- [Screensteps](../identity/saas-apps/screensteps-provisioning-tutorial.md)
- [WiggleDesk](../identity/saas-apps/wiggledesk-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - January 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In January 2024 we added the following new applications in our App gallery with Federation support:

[Boeing ToolBox](https://www.boeing.com/), [Kloud Connect Practice Management](https://www.kloudconnect.com.au/), [トーニチ・ネクスタ・メイシ ( Tonichi Nexta Meishi )](../identity/saas-apps/tonicdm-tutorial.md), [Vinkey](https://vinkey.app/), [Cognito Forms](https://www.cognitoforms.com/), [Ocurus](../identity/saas-apps/ocurus-tutorial.md), [Magister](https://www.magister.nl/), [eFlok](../identity/saas-apps/eflok-tutorial.md), [GoSkills](https://www.goskills.com/), [FortifyData](https://fortifydata.com/), [Toolsfactory platform, Briq](https://toolsfactory.nl/en/ogsm-tool/), [Mailosaur](../identity/saas-apps/mailosaur-tutorial.md), [Astro](../identity/saas-apps/astro-tutorial.md), [JobDiva / Teams VOIP Integration](https://www.jobdiva.com/), [Colossyan SAML](../identity/saas-apps/colossyan-saml-tutorial.md), [CallTower Connect](https://www.calltower.com/calltower-connect/), [Jellyfish](https://cogitogroup.net/jellyfish/), [MetLife Legal Plans Member App](../identity/saas-apps/metlife-legal-plans-member-app-tutorial.md), [Navigo Cloud SAML](../identity/saas-apps/navigo-cloud-saml-tutorial.md), [Delivery Scheduling Tool](../identity/saas-apps/delivery-scheduling-tool-tutorial.md), [Highspot for MS Teams](https://app.highspot.com/signin), [Reach 360](../identity/saas-apps/reach-360-tutorial.md), [Fareharbor SAML SSO](../identity/saas-apps/fareharbor-saml-sso-tutorial.md), [HPE Aruba Networking EdgeConnect Orchestrator](../identity/saas-apps/hpe-aruba-networking-edgeconnect-orchestrator-tutorial.md), [Terranova Security Awareness Platform](../identity/saas-apps/terranova-security-awareness-platform-tutorial.md).

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

---

## December 2023

### Public Preview - Configurable redemption order for B2B collaboration

**Type:** New feature   
**Service category:** B2B                     
**Product capability:**  B2B/B2C             

With configurable redemption, you can customize the order of identity providers that your guest users can sign in with when they accept your invitation. This lets your override the default configuration order set by Microsoft and use your own. This can be used to help with scenarios like prioritizing a SAML/WS-fed federation above a Microsoft Entra ID verified domain, disabling certain identity providers as an option during redemption, or even only using something like email one-time pass-code as a redemption option. For more information, see: [Configurable redemption (Preview)](../external-id/cross-tenant-access-overview.md#configurable-redemption).

---

### General Availability - Edits to Dynamic Group Rule Builder

**Type:** Changed feature   
**Service category:** Group Management                     
**Product capability:**  Directory             

The dynamic group rule builder is updated to no longer include the '*contains*' and '*notContains*' operators, as they're less performant. If needed, you can still create dynamic group rules with those operators by typing directly into the text box. For more information, see: [Rule builder in the Azure portal](../identity/users/groups-dynamic-membership.md#rule-builder-in-the-azure-portal).

---

## November 2023

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

### General Availability - Microsoft Entra Cloud Sync now supports ability to enable Exchange Hybrid configuration for Exchange customers

**Type:** New feature   
**Service category:** Provisioning                     
**Product capability:**  Microsoft Entra Connect            

Exchange hybrid capability allows for the coexistence of Exchange mailboxes both on-premises and in Microsoft 365. Microsoft Entra Cloud Sync synchronizes a specific set of Exchange-related attributes from Microsoft Entra ID back into your on-premises directory and to any forests that's disconnected (no network trust needed between them). With this capability, existing customers who have this feature enabled in Microsoft Entra Connect sync can now migrate, and apply, this feature with Microsoft Entra cloud sync. For more information, see: [Exchange hybrid writeback with cloud sync](../identity/hybrid/exchange-hybrid-writeback.md).

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

### General Availability - Auto-rollout of Conditional Access policies

**Type:** New feature   
**Service category:** Conditional Access                     
**Product capability:**  Access Control             

Starting in November 2023, Microsoft begins automatically protecting customers with Microsoft managed Conditional Access policies. These are policies that Microsoft creates and enables in external tenants. The following policies are rolled out to all eligible tenants, who are notified before policy creation:

1. Multifactor authentication for admin portals: This policy covers privileged admin roles and requires multifactor authentication when an admin signs into a Microsoft admin portal.
1. Multifactor authentication for per-user multifactor authentication users: This policy covers users with per-user multifactor authentication and requires multifactor authentication for all cloud apps.
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

Changes were made to custom security attribute audit logs for general availability that might impact your daily operations. If you have been using custom security attribute audit logs during the preview, there are the actions you must take before February 2024 to ensure your audit log operations aren't disrupted. For more information, see: [Custom security attribute audit logs](./custom-security-attributes-manage.md#custom-security-attribute-audit-logs).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - November 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    

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
**Product capability:** 3rd Party Integration          

In November 2023 we added the following 10 new applications in our App gallery with Federation support:

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

The PAR PDF has been redesigned to enhance usability, align with the product UX redesign effort, and address various customer feature requests. [You can download the PAR PDF for up to 10 authorization systems](~/permissions-management/product-permissions-analytics-reports.md).

---

### General Availability - Enhanced Devices List Management Experience

**Type:** Changed feature   
**Service category:** Device Access Management                     
**Product capability:** End User Experiences            

Several changes have been made to the **All Devices** list since announcing public preview, including:

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

For more information, see: [Require an app protection policy on Windows devices](~/identity/conditional-access/how-to-app-protection-policy-windows.md).

---

### General Availability - Microsoft Security email update and Resources for Azure Active Directory rename to Microsoft Entra ID 

**Type:** Plan for change   
**Service category:** Other                     
**Product capability:** End User Experiences            

Microsoft Entra ID is the new name for Azure Active Directory (Azure AD). The rename and new product icon are now being deployed across experiences from Microsoft. Most updates are complete by mid-November of this year. As previously announced, this is just a new name, with no impact on deployments or daily work. There are no changes to capabilities, licensing, terms of service, or support.

From October 15 to November 15, Azure AD emails previously sent from azure-noreply@microsoft.com will start being sent from MSSecurity-noreply@microsoft.com. You might need to update your Outlook rules to match this.  

Additionally, we'll update email content to remove all references of Azure AD where relevant, and include an informational banner that announces this change.

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

The ability to create new tenants from the Microsoft Entra admin center allows users in your organization to create test and demo tenants from your Microsoft Entra ID tenant, [Learn more about creating tenants](/microsoft-365/education/deploy/intro-azure-active-directory). When used incorrectly this feature can allow the creation of tenants that aren't managed or viewable by your organization. We recommend that you restrict this capability so that only trusted admins can use this feature, [Learn more about restricting member users' default permissions](users-default-permissions.md#restrict-member-users-default-permissions). We also recommend you use the Microsoft Entra audit log to monitor for the Directory Management: Create Company event that signals a new tenant has been created by a user in your organization.  

To further protect your organization, Microsoft is now limiting this functionality to only paid customers. Customers on trial subscriptions are unable to create additional tenants from the Microsoft Entra admin center. Customers in this situation who need a new trial tenant can sign up for a [Free Azure Account](https://azure.microsoft.com/free/).

---

### General Availability - Users can't modify GPS location when using location based access control

**Type:** Plan for change   
**Service category:** Conditional Access                     
**Product capability:** User Authentication            

In an ever-evolving security landscape, the Microsoft Authenticator is updating its security baseline for Location Based Access Control (LBAC) conditional access policies to disallow authentications where the user might be using a different location than the actual GPS location of the mobile device. Today, it's possible for users to modify the location reported by the device on iOS and Android devices. The Authenticator app starts to deny LBAC authentications where we detect that the user isn't using the actual location of the mobile device where the Authenticator is installed.

In the November 2023 release of the Authenticator app, users who are modifying the location of their device sees a denial message in the app when doing an LBAC authentication. To ensure that users aren’t using older app versions to continue authenticating with a modified location, beginning January 2024, any users that are on Android Authenticator 6.2309.6329 version or prior and iOS Authenticator version 6.7.16 or prior will be blocked from using LBAC. To determine which users are using older versions of the Authenticator app, you can use [our MSGraph APIs](/graph/api/resources/microsoftauthenticatorauthenticationmethod).

---

### Public Preview - Overview page in My Access portal

**Type:** New feature   
**Service category:** Entitlement Management                     
**Product capability:** Identity Governance            

Today, when users navigate to myaccess.microsoft.com, they land on a list of available access packages in their organization. The new Overview page provides a more relevant place for users to land. The Overview page points them to the tasks they need to complete and helps familiarize users with how to complete tasks in My Access.  

Admins can enable/disable the Overview page preview by signing into the Microsoft Entra admin center and navigating to Entitlement management > Settings > Opt-in Preview Features and locating My Access overview page in the table.

For more information, see: [My Access Overview page (preview)](~/id-governance/my-access-portal-overview.md#overview-page-preview).

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - October 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      

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

Beginning **January 2024**, Microsoft Entra ID supports [device-bound passkeys](https://passkeys.dev/docs/reference/terms/#device-bound-passkey) stored on computers and mobile devices as an authentication method in public preview, in addition to the existing support for FIDO2 security keys. This enables your users to perform phishing-resistant authentication using the devices that they already have.  

We expand the existing FIDO2 authentication methods policy, and end user experiences, to support this preview release. For your organization to opt in to this preview, you need to enforce key restrictions to allow specified passkey providers in your FIDO2 policy. Learn more about FIDO2 key restrictions [here](~/identity/authentication/howto-authentication-passwordless-security-key.md).

In addition, the existing end user sign-in option for Windows Hello and FIDO2 security keys are now indicated by “Face, fingerprint, PIN, or security key”. The term “passkey” will be mentioned in the updated sign-in experience to be inclusive of passkey credentials presented from security keys, mobile devices, and platform authenticators like Windows Hello.

---

### General Availability - Recovery of deleted application and service principals is now available

**Type:**  New feature            
**Service category:**  Enterprise Apps                                
**Product capability:**  Identity Lifecycle Management                        

With this release, you can now recover applications along with their original service principals, eliminating the need for extensive reconfiguration and code changes ([Learn more](~/identity/enterprise-apps/delete-recover-faq.yml)). It significantly improves the application recovery story and addresses a long-standing customer need. This change is beneficial to you on:

- **Faster Recovery**: You can now recover their systems in a fraction of the time it used to take, reducing downtime and minimizing disruptions.
- **Cost Savings**: With quicker recovery, you can save on operational costs associated with extended outages and labor-intensive recovery efforts.
- **Preserved Data**: Previously lost data, such as SMAL configurations, is now retained, ensuring a smoother transition back to normal operations.
- **Improved User Experience**: Faster recovery times translate to improved user experience and customer satisfaction, as applications are back up and running swiftly.

---

### Public Preview - New provisioning connectors in the Microsoft Entra Application Gallery - September 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      

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

The underlying provider for Web Sign-In is re-written from the ground up with security and improved performance in mind. This release moves the Web Sign-in infrastructure from the Cloud Host Experience (CHX) WebApp to a newly written Login Web Host (LWH) for the September moment. This release provides better security and reliability to support previous EDU & TAP experiences and new workflows enabling using various Auth Methods to unlock/login to the desktop.                    

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

Visit https://aka.ms/tenant-restrictions-enforcement for more information on tenant restriction V2 and Global Secure Access client-side tagging for TRv2 at [Universal tenant restrictions](/entra/global-secure-access/how-to-universal-tenant-restrictions).   

---

### Public Preview - Cross-tenant access settings supports custom Role-Based Access Controls roles and protected actions

**Type:** New feature         
**Service category:** B2B                               
**Product capability:** B2B/B2C                    

Cross-tenant access settings can be managed with custom roles defined by your organization. This enables you to define your own finely scoped roles to manage cross-tenant access settings instead of using one of the built-in roles for management. [Learn more about creating your own custom roles](~/external-id/cross-tenant-access-overview.md#custom-roles-for-managing-cross-tenant-access-settings).

You can also now protect privileged actions inside of cross-tenant access settings using Conditional Access. For example, you can require MFA before allowing changes to default settings for B2B collaboration. Learn more about [Protected actions](~/identity/role-based-access-control/protected-actions-overview.md).

---

### General Availability - Additional settings in Entitlement Management autoassignment policy
 
**Type:** Changed feature    
**Service category**: Entitlement Management    
**Product capability:** Entitlement Management    

In the Microsoft Entra ID Governance entitlement management autoassignment policy, there are three new settings. This allows a customer to select to not have the policy create assignments, not remove assignments, and to delay assignment removal.

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
**Product capability:** 3rd Party Integration    
      

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

Microsoft Entra ID Governance includes the ability for a customer to configure an assignment policy in an entitlement management access package that includes an attribute-based rule, similar to dynamic groups, of the users who should be assigned access. For more information, see: [Configure an automatic assignment policy for an access package in entitlement management](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md).

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

User identity lifecycle is a critical part of an organization’s security posture, and when managed correctly, can have a positive affect on their users’ productivity for Joiners, Movers, and Leavers. The ongoing digital transformation is accelerating the need for good identity lifecycle management. However, IT and security teams face enormous challenges managing the complex, time-consuming, and error-prone manual processes necessary to execute the required onboarding and offboarding tasks for hundreds of employees at once. This is an ever present and complex issue IT admins continue to face with digital transformation across security, governance, and compliance.

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

Monitor guest accounts at scale with intelligent insights into inactive guest users in your organization. Customize the inactivity threshold depending on your organization’s needs, narrow down the scope of guest users you want to monitor and identify the guest users that might be inactive. For more information, see: [Monitor and clean up stale guest accounts using access reviews](~/identity/users/clean-up-stale-guest-accounts.md).

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

The Azure mobile app has been enhanced to empower admins with specific permissions to conveniently reset their users' passwords. Self Service Password Reset won't be supported at this time. However, users can still more efficiently control and streamline their own sign-in and auth methods. The mobile app can be downloaded for each platform here:

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

This feature enables admins to create dynamic group rules based on the user objects' employeeHireDate attribute. For more information, see: [Properties of type string](~/identity/users/groups-dynamic-membership.md#properties-of-type-string).

---

### General Availability - Enhanced Create User and Invite User Experiences

**Type:** Changed feature       
**Service category:** User Management                                  
**Product capability:** User Management                      

We have increased the number of properties admins are able to define when creating and inviting a user in the Entra admin portal, bringing our UX to parity with our Create User APIs. Additionally, admins can now add users to a group or administrative unit, and assign roles. For more information, see: [Add or delete users using Azure Active Directory](./add-users.md).

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

Using MAM Conditional Access, Microsoft Edge for Business provides users with secure access to organizational data on personal Windows devices with a customizable user experience. We’ve combined the familiar security features of app protection policies (APP), Windows Defender client threat defense, and Conditional Access, all anchored to Azure AD identity to ensure un-managed devices are healthy and protected before granting data access. This can help businesses to improve their security posture and protect sensitive data from unauthorized access, without requiring full mobile device enrollment.

The new capability extends the benefits of app layer management to the Windows platform via Microsoft Edge for Business. Admins are empowered to configure the user experience and protect organizational data within Microsoft Edge for Business on un-managed Windows devices.

For more information, see: [Require an app protection policy on Windows devices (preview)](~/identity/conditional-access/how-to-app-protection-policy-windows.md).

---

### General Availability - New Federated Apps available in Azure AD Application gallery - July 2023

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In July 2023 we've added the following 10 new applications in our App gallery with Federation support:    

[Gainsight SAML](~/identity/saas-apps/gainsight-tutorial.md), [Dataddo](https://www.dataddo.com/), [Puzzel](https://www.puzzel.com/), [Worthix App](~/identity/saas-apps/worthix-app-tutorial.md), [iOps360 IdConnect](https://iops360.com/iops360-id-connect-azuread-single-sign-on/), [Airbase](~/identity/saas-apps/airbase-tutorial.md), [Couchbase Capella - SSO](~/identity/saas-apps/couchbase-capella-sso-tutorial.md), [SSO for Jama Connect®](~/identity/saas-apps/sso-for-jama-connect-tutorial.md), [mediment (メディメント)](https://mediment.jp/), [Netskope Cloud Exchange Administration Console](~/identity/saas-apps/netskope-cloud-exchange-administration-console-tutorial.md), [Uber](~/identity/saas-apps/uber-tutorial.md), [Plenda](https://app.plenda.nl/), [Deem Mobile](~/identity/saas-apps/deem-mobile-tutorial.md), [40SEAS](https://www.40seas.com/), [Vivantio](https://www.vivantio.com/), [AppTweak](https://www.apptweak.com/), [Vbrick Rev Cloud](~/identity/saas-apps/vbrick-rev-cloud-tutorial.md), [OptiTurn](~/identity/saas-apps/optiturn-tutorial.md), [Application Experience with Mist](https://www.mist.com/), [クラウド勤怠管理システムKING OF TIME](~/identity/saas-apps/cloud-attendance-management-system-king-of-time-tutorial.md), [Connect1](~/identity/saas-apps/connect1-tutorial.md), [DB Education Portal for Schools](~/identity/saas-apps/db-education-portal-for-schools-tutorial.md), [SURFconext](~/identity/saas-apps/surfconext-tutorial.md), [Chengliye Smart SMS Platform](~/identity/saas-apps/chengliye-smart-sms-platform-tutorial.md), [CivicEye SSO](~/identity/saas-apps/civic-eye-sso-tutorial.md), [Colloquial](~/identity/saas-apps/colloquial-tutorial.md), [BigPanda](~/identity/saas-apps/bigpanda-tutorial.md), [Foreman](https://foreman.mn/)

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Azure AD app gallery, read the details here https://aka.ms/AzureADAppRequest

---

### Public Preview - New provisioning connectors in the Azure AD Application Gallery - July 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    


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

## June 2023

### Public Preview - New provisioning connectors in the Azure AD Application Gallery - June 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      
We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Headspace](~/identity/saas-apps/headspace-provisioning-tutorial.md)
- [Humbol](~/identity/saas-apps/humbol-provisioning-tutorial.md)
- [LUSID](~/identity/saas-apps/lusid-provisioning-tutorial.md)
- [Markit Procurement Service](~/identity/saas-apps/markit-procurement-service-provisioning-tutorial.md)
- [Moqups](~/identity/saas-apps/moqups-provisioning-tutorial.md)
- [Notion](~/identity/saas-apps/notion-provisioning-tutorial.md)
- [OpenForms](~/identity/saas-apps/openforms-provisioning-tutorial.md)
- [SafeGuard Cyber](~/identity/saas-apps/safeguard-cyber-provisioning-tutorial.md)
- [Uni-tel A/S](~/identity/saas-apps/uni-tel-as-provisioning-tutorial.md)
- [Vault Platform](~/identity/saas-apps/vault-platform-provisioning-tutorial.md)
- [V-Client](~/identity/saas-apps/v-client-provisioning-tutorial.md)
- [Veritas Enterprise Vault.cloud SSO-SCIM](~/identity/saas-apps/veritas-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [Automate user provisioning to SaaS applications with Azure AD](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - Include/exclude Entitlement Management in Conditional Access policies

**Type:** New feature       
**Service category:** Entitlement Management                          
**Product capability:** Entitlement Management                

The Entitlement Management service can now be targeted in the Conditional Access policy for inclusion or exclusion of applications. To target the Entitlement Management service, select “Azure AD Identity Governance - Entitlement Management” in the cloud apps picker. The Entitlement Management app includes the entitlement management part of My Access, the Entitlement Management part of the Entra and Azure portals, and the Entitlement Management part of MS Graph. For more information, see:  [Review your Conditional Access policies](~/id-governance/entitlement-management-external-users.md#review-your-conditional-access-policies).

---

### General Availability - Azure Active Directory User and Group capabilities on Azure Mobile are now available

**Type:** New feature       
**Service category:** Azure Mobile App                             
**Product capability:** End User Experiences                  

The Azure Mobile app now includes a section for Azure Active Directory. Within Azure Active Directory on mobile, user can search for and view more details about user and groups. Additionally, permitted users can invite guest users to their active tenant, assign group memberships and ownerships for users, and view user sign-in logs. For more information, see: [Get the Azure mobile app](https://azure.microsoft.com/get-started/azure-portal/mobile-app/).

---

### Plan for change - Modernizing Terms of Use Experiences

**Type:** Plan for change         
**Service category:** Terms of Use                               
**Product capability:** AuthZ/Access Delegation                   

Recently we announced the modernization of terms of use end-user experiences as part of ongoing service improvements. As previously communicated the end user experiences will be updated with a new PDF viewer and are moving from https://account.activedirectory.windowsazure.com to https://myaccount.microsoft.com. 

Starting today the modernized experience for viewing previously accepted terms of use is available via https://myaccount.microsoft.com/termsofuse/myacceptances. We encourage you to check out the modernized experience, which follows the same updated design pattern as the upcoming modernization of accepting or declining terms of use as part of the sign-in flow. We would appreciate your [feedback](https://forms.microsoft.com/r/NV0msbrqtF) before we begin to modernize the sign-in flow.

---

### General Availability - Privileged Identity Management for Groups

**Type:** New feature       
**Service category:** Privileged Identity Management                               
**Product capability:** Privileged Identity Management                 

Privileged Identity Management for Groups is now generally available. With this feature, you have the ability to grant users just-in-time membership in a group, which in turn provides access to Azure Active Directory roles, Azure roles, Azure SQL, Azure Key Vault, Intune, other application roles, and third-party applications. Through one activation, you can conveniently assign a combination of permissions across different applications and Role-Based Access Control systems.

PIM for Groups offers can also be used for just-in-time ownership. As the owner of the group, you can manage group properties, including membership. For more information, see: [Privileged Identity Management (PIM) for Groups](~/id-governance/privileged-identity-management/concept-pim-for-groups.md).

---

### General Availability - Privileged Identity Management and Conditional Access integration 

**Type:** New feature       
**Service category:** Privileged Identity Management                               
**Product capability:** Privileged Identity Management                    

The Privileged Identity Management (PIM) integration with Conditional Access authentication context is generally available. You can require users to meet various requirements during role activation such as:

- Have specific authentication method through [Authentication Strengths](~/identity/authentication/concept-authentication-strengths.md)
- Activate from a compliant device 
- Validate location based on GPS
- Not have certain level of sign-in risk identified with Identity Protection
- Meet other requirements defined in Conditional Access policies

The integration is available for all providers: PIM for Azure AD roles, PIM for Azure resources, PIM for groups. For more information, see:
- [Configure Azure AD role settings in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-how-to-change-default-settings.md)
- [Configure Azure resource role settings in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-resource-roles-configure-role-settings.md)
- [Configure PIM for Groups settings](~/id-governance/privileged-identity-management/groups-role-settings.md)

---

### General Availability - Updated look and feel for Per-user MFA

**Type:** Plan for change    
**Service category:** MFA                       
**Product capability:** Identity Security & Protection              

As part of ongoing service improvements, we're making updates to the per-user MFA admin configuration experience to align with the look and feel of Azure. This change doesn't include any changes to the core functionality and will only include visual improvements. For more information, see: [Enable per-user Microsoft Entra multifactor authentication to secure sign-in events](~/identity/authentication/howto-mfa-userstates.md).

---

### General Availability - Converged Authentication Methods in US Gov cloud

**Type:** New feature   
**Service category:** MFA                      
**Product capability:** User Authentication              

The Converged Authentication Methods Policy enables you to manage all authentication methods used for MFA and SSPR in one policy, migrate off the legacy MFA and SSPR policies, and target authentication methods to groups of users instead of enabling them for all users in the tenant. Customers should migrate management of authentication methods off the legacy MFA and SSPR policies before September 30, 2024. For more information, see: [Manage authentication methods for Azure AD](~/identity/authentication/concept-authentication-methods-manage.md).

---

### General Availability - Support for Directory Extensions using Azure AD cloud sync

**Type:** New feature  
**Service category:** Provisioning  
**Product capability:** Azure AD Connect cloud sync

Hybrid IT Admins can now sync both Active Directory and Azure AD Directory Extensions using Azure AD Connect cloud sync. This new capability adds the ability to dynamically discover the schema for both Active Directory and Azure Active Directory, thereby, allowing customers to map the needed attributes using the attribute mapping experience of cloud sync. For more information, see [Directory extensions and custom attribute mapping in cloud sync](~/identity/hybrid/cloud-sync/custom-attribute-mapping.md).

---

### Public Preview - Restricted Management Administrative Units

**Type:** New feature   
**Service category:** Directory Management                        
**Product capability:** Access Control               

Restricted Management Administrative Units allow you to restrict modification of users, security groups, and device in Azure AD so that only designated administrators can make changes.  Global Administrators and other tenant-level administrators can't modify the users, security groups, or devices that are added to a restricted management admin unit. For more information, see: [Restricted management administrative units in Azure Active Directory (Preview)](~/identity/role-based-access-control/admin-units-restricted-management.md).

---

### General Availability - Report suspicious activity integrated with Identity Protection

**Type:** Changed feature   
**Service category:** Identity Protection                        
**Product capability:** Identity Security & Protection              

Report suspicious activity is an updated implementation of the MFA fraud alert, where users can report a voice or phone app MFA prompt as suspicious. If enabled, users reporting prompts have their user risk set to high, enabling admins to use Identity Protection risk based policies or risk detection APIs to take remediation actions.  Report suspicious activity operates in parallel with the legacy MFA fraud alert at this time. For more information, see: [Configure Microsoft Entra multifactor authentication settings](~/identity/authentication/howto-mfa-mfasettings.md).

---

## May 2023

### General Availability - Conditional Access authentication strength for members, external users and FIDO2 restrictions

**Type:** New feature   
**Service category:** Conditional Access                      
**Product capability:** Identity Security & Protection              

Authentication strength is a Conditional Access control that allows administrators to specify which combination of authentication methods can be used to access a resource. For example, they can make only phishing-resistant authentication methods available to access a sensitive resource. Likewise, to access a nonsensitive resource, they can allow less secure multifactor authentication (MFA) combinations such as password + SMS.

Authentication strength is now in General Availability for members and external users from any Microsoft cloud and FIDO2 restrictions. For more information, see: [Conditional Access authentication strength](~/identity/authentication/concept-authentication-strengths.md).

---

### General Availability - SAML/Ws-Fed based identity provider authentication for Azure Active Directory B2B users in US Sec and US Nat clouds

**Type:** New feature   
**Service category:** B2B                        
**Product capability:** B2B/B2C             

SAML/Ws-Fed based identity providers for authentication in Azure AD B2B are generally available in US Sec, US Nat and China clouds. For more information, see: [Federation with SAML/WS-Fed identity providers for guest users](~/external-id/direct-federation.md).

---

### Generally Availability - Cross-tenant synchronization

**Type:** New feature   
**Service category:** Provisioning                          
**Product capability:** Identity Lifecycle Management              

Cross-tenant synchronization allows you to set up a scalable and automated solution for users to access applications across tenants in your organization. It builds upon the Azure Active Directory B2B functionality and automates creating, updating, and deleting B2B users within tenants in your organization. For more information, see: [What is cross-tenant synchronization?](~/identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md).

---

### Public Preview(Refresh) - Custom Extensions in Entitlement Management

**Type:** New feature   
**Service category:** Entitlement management                          
**Product capability:** Identity Governance                

Last year we announced the [public preview of custom extensions in Entitlement Management](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/run-custom-workflows-in-azure-ad-entitlement-management/ba-p/2466938) allowing you to automate complex processes when access is requested or about to expire. We have recently expanded the public preview to allow for the access package assignment request to be paused while your external process is running. In addition, the external process can now provide feedback to Entitlement Management to either surface additional information to end users in MyAccess or even stop the access request. This expands the scenarios of custom extension from notifications to additional stakeholders or the generation of tickets to advanced scenarios such as external governance, risk and compliance checks. In the course of this update, we have also improved the audit logs, token security and the payload sent to the Logic App. To learn more about the preview refresh, see:

-  [Trigger Logic Apps with custom extensions in entitlement management (Preview)](~/id-governance/entitlement-management-logic-apps-integration.md)
- [accessPackageAssignmentRequest: resume](/graph/api/accesspackageassignmentrequest-resume)
- [`accessPackageAssignmentWorkflowExtension` resource type](/graph/api/resources/accesspackageassignmentworkflowextension)
- [`accessPackageAssignmentRequestWorkflowExtension` resource type](/graph/api/resources/accesspackageassignmentrequestworkflowextension)

---

### General Availability - Managed Identity in Microsoft Authentication Library for .NET

**Type:** New feature   
**Service category:** Authentications (Logins)                            
**Product capability:** User Authentication               

The latest version of MSAL.NET graduates the Managed Identity APIs into the General Availability mode of support, which means that developers can integrate them safely in production workloads.

Managed identities are a part of the Azure infrastructure, simplifying how developers handle credentials and secrets to access cloud resources. With Managed Identities, developers don't need to manually handle credential retrieval and security. Instead, they can rely on an automatically managed set of identities to connect to resources that support Azure Active Directory authentication. You can learn more in [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md)

With MSAL.NET 4.54.0, the Managed Identity APIs are now stable. There are a few changes that we added that make them easier to use and integrate that might require tweaking your code if you’ve used our [experimental implementation](https://den.dev/blog/managed-identity-msal-net/):

- When using Managed Identity APIs, developers need to specify the identity type when creating an [ManagedIdentityApplication](/dotnet/api/microsoft.identity.client.managedidentityapplication).
- When acquiring tokens with Managed Identity APIs and using the default HTTP client, MSAL retries the request for certain exception codes.
- We added a new [MsalManagedIdentityException](/dotnet/api/microsoft.identity.client.msalmanagedidentityexception) class that represents any Managed Identity-related exceptions. It includes general exception information, including the Azure source from which the exception originates.
- MSAL will now proactively refresh tokens acquired with Managed Identity.

To get started with Managed Identity in MSAL.NET, you can use the [Microsoft.Identity.Client](/dotnet/api/microsoft.identity.client) package together with the [ManagedIdentityApplicationBuilder](/dotnet/api/microsoft.identity.client.managedidentityapplicationbuilder) class.

---

### Public Preview - New My Groups Experience

**Type:** Changed feature   
**Service category:** Group Management                          
**Product capability:** End User Experiences              

A new and improved My Groups experience is now available at [myaccount.microsoft.com/groups](https://myaccount.microsoft.com/groups). This experience replaces the existing My Groups experience at mygroups.microsoft.com in May.   For more information, see: [Update your Groups info in the My Groups portal](https://support.microsoft.com/account-billing/update-your-groups-info-in-the-my-apps-portal-bc0ca998-6d3a-42ac-acb8-e900fb1174a4).

---

### General Availability - Admins can restrict their users from creating tenants

**Type:** New feature   
**Service category:** User Access Management                           
**Product capability:** User Management               

The ability for users to create tenants from the Manage Tenant overview has been present in Azure AD since almost the beginning of the Azure portal.  This new capability in the User Settings pane allows admins to restrict their users from being able to create new tenants. There's also a new [Tenant Creator](~/identity/role-based-access-control/permissions-reference.md#tenant-creator) role to allow specific users to create tenants. For more information, see [Default user permissions](~/fundamentals/users-default-permissions.md#restrict-member-users-default-permissions).

---

### General Availability - Devices Self-Help Capability for Pending Devices



**Type:** New feature   
**Service category:** Device Access Management                
**Product capability:** End User Experiences          

In the **All Devices** view under the Registered column, you can now select any pending devices you have, and it opens a context pane to help troubleshoot why a device might be pending. You can also offer feedback on if the summarized information is helpful or not. For more information, see: [Pending devices in Azure Active Directory](/troubleshoot/azure/active-directory/pending-devices).


---

### General Availability - Admins can now restrict users from self-service accessing their BitLocker keys



**Type:** New feature   
**Service category:** Device Access Management                
**Product capability:** User Management            

Admins can now restrict their users from self-service accessing their BitLocker keys through the Devices Settings page. Turning on this capability hides the BitLocker key(s) of all non-admin users. This helps to control BitLocker access management at the admin level. For more information, see: [Restrict member users' default permissions](users-default-permissions.md#restrict-member-users-default-permissions).


---

### Public Preview - New provisioning connectors in the Azure AD Application Gallery - May 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      
We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Sign In Enterprise Host Provisioning](~/identity/saas-apps/sign-in-enterprise-host-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [Automate user provisioning to SaaS applications with Azure AD](~/identity/app-provisioning/user-provisioning.md).


---

### General Availability -  Microsoft Entra Permissions Management Azure Active Directory Insights

**Type:** New feature   
**Service category:** Other                               
**Product capability:** Permissions Management                 

The Azure Active Directory Insights tab in Microsoft Entra Permissions Management provides a view of all permanent role assignments assigned to Global Administrators, and a curated list of highly privileged roles. Administrators can then use the report to take further action within the Azure Active Directory console. For more information, see [View privileged role assignments in your organization (Preview)](~/permissions-management/product-privileged-role-insights.md).

---

### Public Preview - In portal guide to configure multifactor authentication

**Type:** New feature   
**Service category:** MFA                           
**Product capability:** Identity Security & Protection              

The in portal guide for configuring multifactor authentication helps you get started with Azure Active Directory's MFA capabilities. You can find this guide under the Tutorials tab in the Azure AD Overview. 

---

### General Availability - Authenticator Lite (In Outlook)

**Type:** New feature   
**Service category:** Microsoft Authenticator App                           
**Product capability:** User Authentication                

Authenticator Lite (in Outlook) is an authentication solution for users who haven't downloaded the Microsoft Authenticator app. Users are prompted in Outlook on their mobile device to register for multifactor authentication. After they enter their password at sign-in, they'll be able to send a push notification to their Android or iOS device.

Due to the security enhancement this feature provides users, the Microsoft managed value of this feature will be changed from ‘*disabled*’ to ‘*enabled*’ on June 9. We made some changes to the feature configuration, so if you made an update before GA, May 17, validate that the feature is in the correct state for your tenant before June 9. If you don't wish for this feature to be enabled on June 9, move the state to ‘*disabled*’, or set users to include and exclude groups.  


For more information, see: [How to enable Microsoft Authenticator Lite for Outlook mobile (preview)](~/identity/authentication/how-to-mfa-authenticator-lite.md).

---

### General Availability - PowerShell and Web Services connector support through the Azure AD provisioning agent

**Type:** New feature   
**Service category:** Provisioning                          
**Product capability:** Outbound to On-premises Applications               

The Azure AD on-premises application provisioning feature now supports both the [PowerShell](~/identity/app-provisioning/on-premises-powershell-connector.md) and [web services](~/identity/app-provisioning/on-premises-web-services-connector.md) connectors. You can now provision users into a flat file using the PowerShell connector or an app such as SAP ECC using the web services connector. For more information, see: [Provisioning users into applications using PowerShell](~/identity/app-provisioning/on-premises-powershell-connector.md).

---

### General Availability - Verified threat actor IP sign-in detection

**Type:** New feature   
**Service category:** Identity Protection                          
**Product capability:** Identity Security & Protection               

Identity Protection has added a new detection, using the Microsoft Threat Intelligence database, to detect sign-ins performed from IP addresses of known nation state and cyber-crime actors and allow customers to block these sign-ins by using risk-based Conditional Access policies. For more information, see: [Sign-in risk](~/id-protection/concept-identity-protection-risks.md).

---

### General Availability - Conditional Access Granular control for external user types 

**Type:** New feature   
**Service category:** Conditional Access                            
**Product capability:** Identity Security & Protection               

When configuring a Conditional Access policy, customers now have granular control over the types of external users they want to apply the policy to. External users are categorized based on how they authenticate (internally or externally) and their relationship to your organization (guest or member). For more information, see: [Assigning Conditional Access policies to external user types](~/external-id/authentication-conditional-access.md#assigning-conditional-access-policies-to-external-user-types).

---

### General Availability - New Federated Apps available in Azure AD Application gallery - May 2023


**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In May 2023 we added the following 51 new applications in our App gallery with Federation support

 [Valotalive Digital Signage Microsoft 365 integration](https://valota.live/apps/microsoft-excel/), [Tailscale](http://tailscale.com/), [MANTL](https://console.mantl.com/), [ServusConnect](~/identity/saas-apps/servusconnect-tutorial.md), [Jigx MS Graph Demonstrator](https://www.jigx.com/), [Delivery Solutions](~/identity/saas-apps/delivery-solutions-tutorial.md), [Radiant IOT Portal](~/identity/saas-apps/radiant-iot-portal-tutorial.md), [Cosgrid Networks](~/identity/saas-apps/cosgrid-networks-tutorial.md), [voya SSO](https://app.voya.ai/), [Redocly](~/identity/saas-apps/redocly-tutorial.md), [Glaass Pro](https://glaass.net/pro/), [TalentLyftOIDC](https://www.talentlyft.com/en), [Cisco Expressway](~/identity/saas-apps/cisco-expressway-tutorial.md), [IBM TRIRIGA on Cloud](~/identity/saas-apps/ibm-tririga-on-cloud-tutorial.md), [Avionte Bold SAML Federated SSO](~/identity/saas-apps/avionte-bold-saml-federated-sso-tutorial.md), [InspectNTrack](http://www.inspecttrack.com/), [CAREERSHIP](~/identity/saas-apps/careership-tutorial.md), [Cisco Unity Connection](~/identity/saas-apps/cisco-unity-connection-tutorial.md), [HSC-Buddy](https://hsc-buddy.com/), [teamecho](https://app.teamecho.at/), [AskFora](https://askfora.com/), [Enterprise Bot](https://www.enterprisebot.ai/),[CMD+CTRL Base Camp](~/identity/saas-apps/cmd-ctrl-base-camp-tutorial.md), [Debitia Collections](https://www.debitia.com/), [EnergyManager](https://energymanager.no/), [Visual Workforce](https://prod.visualworkforce.com/), [Uplifter](https://uplifter.ai/), [AI2](https://tmti.net/services/), [TES Cloud](https://www.tes.ca/),[VEDA Cloud](~/identity/saas-apps/veda-cloud-tutorial.md), [SOC SST](~/identity/saas-apps/soc-sst-tutorial.md), [Alchemer](~/identity/saas-apps/alchemer-tutorial.md), [Cleanmail Swiss](https://www.alinto.com/fr/antispam-professionnel-cleanmail/), [WOX](https://woxday.com/), [WATS](https://wats.com/), [Data Quality Assistant](https://appsource.microsoft.com/en-GB/product/office/WA200004441?exp=kyyw&tab=Overview), [Softdrive](https://www.softdrive.co/), [Fluence Portal](https://portal.fluence.app/), [Humbol](https://www.humbol.app/en/product/), [Document360](~/identity/saas-apps/document360-tutorial.md), [Engage by Local Measure](https://www.localmeasure.com/),[Gate Property Management Software](https://gatesoftware.nl/), [Locus](~/identity/saas-apps/locus-tutorial.md), [Banyan Infrastructure](https://app.banyaninfrastructure.com/), [Proactis Rego Invoice Capture](~/identity/saas-apps/proactis-rego-invoice-capture-tutorial.md), [SecureTransport](~/identity/saas-apps/securetransport-tutorial.md), [Recnice](https://recnice.com/)

 
You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial,

For listing your application in the Azure AD app gallery, read the details here https://aka.ms/AzureADAppRequest

---

### General Availability - My Security-info now shows Microsoft Authenticator type

**Type:** Changed feature   
**Service category:** MFA                        
**Product capability:** Identity Security & Protection               

We've improved My Sign-ins and My Security-Info to give you more clarity on the types of Microsoft Authenticator or other Authenticator apps a user registers. Users will now see Microsoft Authenticator registrations with additional information showing the app as being registered as Push-based MFA or Password-less phone sign-in (PSI). For other Authenticator apps (Software OATH) we now indicate they're registered as a Time-based One-time password method. For more information, see: [Set up the Microsoft Authenticator app as your verification method](https://support.microsoft.com/account-billing/set-up-the-microsoft-authenticator-app-as-your-verification-method-33452159-6af9-438f-8f82-63ce94cf3d29).

---

## April 2023

### Public Preview - Custom attributes for Azure Active Directory Domain Services

**Type:** New feature   
**Service category:** Azure Active Directory Domain Services                     
**Product capability:** Azure Active Directory Domain Services            

Azure Active Directory Domain Services will now support synchronizing custom attributes from Azure AD for on-premises accounts. For more information, see: [Custom attributes for Azure Active Directory Domain Services](/entra/identity/domain-services/concepts-custom-attributes).

---

### General Availability - Enablement of combined security information registration for MFA and  self-service password reset (SSPR)

**Type:** New feature   
**Service category:** MFA                     
**Product capability:** Identity Security & Protection            

Last year, we announced the combined registration user experience for MFA and  self-service password reset (SSPR) was rolling out as the default experience for all organizations. We're happy to announce that the combined security information registration experience is now fully rolled out. This change doesn't affect tenants located in the China region. For more information, see: [Combined security information registration for Azure Active Directory overview](~/identity/authentication/concept-registration-mfa-sspr-combined.md).

---

### General Availability - System preferred MFA method

**Type:** Changed feature   
**Service category:** Authentications (Logins)                       
**Product capability:** Identity Security & Protection            

Currently, organizations and users rely on a range of authentication methods, each offering varying degrees of security. While Multifactor Authentication (MFA) is crucial, some MFA methods are more secure than others. Despite having access to more secure MFA options, users frequently choose less secure methods for various reasons.

To address this challenge, we're introducing a new system-preferred authentication method for MFA. When users sign in, the system determines, and displays, the most secure MFA method that the user registered. This prompts users to switch from the default method to the most secure option. While users can still choose a different MFA method, they'll always be prompted to use the most secure method first for every session that requires MFA. For more information, see: [System-preferred multifactor authentication - Authentication methods policy](~/identity/authentication/concept-system-preferred-multifactor-authentication.md).

---

### General Availability - PIM alert: Alert on active-permanent role assignments in Azure or assignments made outside of PIM

**Type:** Fixed     
**Service category:** Privileged Identity Management                     
**Product capability:** Privileged Identity Management            

[Alert on Azure subscription role assignments made outside of Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-resource-roles-configure-alerts.md) provides an alert in PIM for Azure subscription assignments made outside of PIM. An owner or User Access Administrator can take a quick remediation action to remove those assignments. 

---

### Public Preview - Enhanced Create User and Invite User Experiences

**Type:** Changed feature   
**Service category:** User Management                     
**Product capability:** User Management            

We have increased the number of properties that admins are able to define when creating and inviting a user in the Entra admin portal. This brings our UX to parity with our Create User APIs. Additionally, admins can now add users to a group or administrative unit, and assign roles. For more information, see:  [How to create, invite, and delete users](~/fundamentals/how-to-create-delete-users.yml).

---

### Public Preview - Azure Active Directory Conditional Access protected actions

**Type:** Changed feature   
**Service category:** RBAC                    
**Product capability:** Access Control            

The protected actions public preview introduces the ability to apply Conditional Access to select permissions. When a user performs a protected action, they must satisfy Conditional Access policy requirements. For more information, see: [What are protected actions in Azure AD? (preview)](~/identity/role-based-access-control/protected-actions-overview.md).

---

### Public Preview - Token Protection for Sign-in Sessions

**Type:** New feature   
**Service category:** Conditional Access                  
**Product capability:** User Authentication          

Token Protection for sign-in sessions is our first release on a road-map to combat attacks involving token theft and replay. It provides Conditional Access enforcement of token proof-of-possession for supported clients and services that ensure that access to specified resources is only from a device to which the user has signed in. For more information, see: [Conditional Access: Token protection (preview)](~/identity/conditional-access/concept-token-protection.md).

---

### General Availability- New limits on number and size of group secrets starting June 2023

**Type:** Plan for change  
**Service category:** Group Management                   
**Product capability:** Directory            

Starting in June 2023, the secrets stored on a single group can't exceed 48 individual secrets, or have a total size greater than 10 KB across all secrets on a single group. Groups with more than 10 KB of secrets will immediately stop working in June 2023. In June, groups exceeding 48 secrets are unable to increase the number of secrets they have, though they could still update or delete those secrets. We highly recommend reducing to fewer than 48 secrets by January 2024.

Group secrets are typically created when a group is assigned credentials to an app using Password-based single sign-on. To reduce the number of secrets assigned to a group, we recommend creating additional groups, and splitting up group assignments to your Password-based SSO applications across those new groups. For more information, see: [Add password-based single sign-on to an application](~/identity/enterprise-apps/configure-password-single-sign-on-non-gallery-applications.md).

---

### Public Preview - Authenticator Lite in Outlook

**Type:** New feature   
**Service category:** Microsoft Authenticator App                     
**Product capability:** User Authentication           

Authenticator Lite is an additional surface for Azure Active Directory users to complete multifactor authentication using push notifications on their Android or iOS device. With Authenticator Lite, users can satisfy a multifactor authentication requirement from the convenience of a familiar app. Authenticator Lite is currently enabled in the Outlook mobile app. Users could receive a notification in their Outlook mobile app to approve or deny, or use the Outlook app to generate an OATH verification code that can be entered during sign-in. The *'Microsoft managed'* setting for this feature will be set to be enabled on May 26, 2023. This enables the feature for all users in tenants where the feature is set to Microsoft managed. If you wish to change the state of this feature do so before May 26, 2023. For more information, see: [How to enable Microsoft Authenticator Lite for Outlook mobile (preview)](~/identity/authentication/how-to-mfa-authenticator-lite.md).

---

### General Availability - Updated look and feel for Per-user MFA

**Type:** Plan for change   
**Service category:** MFA                       
**Product capability:** Identity Security & Protection             

As part of ongoing service improvements, we're making updates to the per-user MFA admin configuration experience to align with the look and feel of Azure. This change doesn't include any changes to the core functionality and will only include visual improvements. For more information, see: [Enable per-user Azure AD Multifactor Authentication to secure sign-in events](~/identity/authentication/howto-mfa-userstates.md).

---

### General Availability - Additional terms of use audit logs will be turned off

**Type:**  Fixed     
**Service category:** Terms of Use                  
**Product capability:** AuthZ/Access Delegation          

Due to a technical issue, we recently started to emit additional audit logs for terms of use. The additional audit logs will be turned off by May 1 and are tagged with the core directory service and the agreement category. If you built a dependency on the additional audit logs, you must switch to the regular audit logs tagged with the terms of use service.

---

### General Availability - New Federated Apps available in Azure AD Application gallery - April 2023



**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In April 2023 we've added the following 10 new applications in our App gallery with Federation support:    

[iTel Alert](https://www.itelalert.nl/), [goFLUENT](~/identity/saas-apps/gofluent-tutorial.md), [StructureFlow](https://app.structureflow.co/), [StructureFlow AU](https://au.structureflow.co/), [StructureFlow CA](https://ca.structureflow.co/), [StructureFlow EU](https://eu.structureflow.co/), [StructureFlow USA](https://us.structureflow.co/), [Predict360 SSO](~/identity/saas-apps/predict360-sso-tutorial.md), [Cegid Cloud](https://www.cegid.com/fr/nos-produits/), [HashiCorp Cloud Platform (HCP)](~/identity/saas-apps/hashicorp-cloud-platform-hcp-tutorial.md), [O'Reilly learning platform](~/identity/saas-apps/oreilly-learning-platform-tutorial.md), [LeftClick Web Services – RoomGuide](https://www.leftclick.cloud/digital_signage), [LeftClick Web Services – Sharepoint](https://www.leftclick.cloud/digital_signage), [LeftClick Web Services – Presence](https://www.leftclick.cloud/presence), [LeftClick Web Services - Single Sign-On](https://www.leftclick.cloud/presence), [InterPrice Technologies](http://www.interpricetech.com/), [WiggleDesk SSO](https://wiggledesk.com/), [Application Experience with Mist](https://www.mist.com/), [Connect Plans 360](https://connectplans360.com.au/), [Proactis Rego Source-to-Contract](~/identity/saas-apps/proactis-rego-source-to-contract-tutorial.md), [Danomics](https://www.danomics.com/), [Fountain](~/identity/saas-apps/fountain-tutorial.md), [Theom](~/identity/saas-apps/theom-tutorial.md), [DDC Web](~/identity/saas-apps/ddc-web-tutorial.md), [Dozuki](~/identity/saas-apps/dozuki-tutorial.md).


You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Azure AD app gallery, read the details here https://aka.ms/AzureADAppRequest

---

### Public Preview - New provisioning connectors in the Azure AD Application Gallery - April 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Alvao](~/identity/saas-apps/alvao-provisioning-tutorial.md)
- [Better Stack](~/identity/saas-apps/better-stack-provisioning-tutorial.md)
- [BIS](~/identity/saas-apps/bis-provisioning-tutorial.md)
- [Connecter](~/identity/saas-apps/connecter-provisioning-tutorial.md)
- [Howspace](~/identity/saas-apps/howspace-provisioning-tutorial.md)
- [Kno2fy](~/identity/saas-apps/kno2fy-provisioning-tutorial.md)
- [Netsparker Enterprise](~/identity/saas-apps/netsparker-enterprise-provisioning-tutorial.md)
- [uniFLOW Online](~/identity/saas-apps/uniflow-online-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [Automate user provisioning to SaaS applications with Azure AD](~/identity/app-provisioning/user-provisioning.md).


---

### Public Preview - New PIM Azure resource picker

**Type:** Changed feature   
**Service category:** Privileged Identity Management                     
**Product capability:** End User Experiences            

With this new experience, PIM now automatically manages any type of resource in a tenant, so discovery and activation is no longer required. With the new resource picker, users can directly choose the scope they want to manage from the Management Group down to the resources themselves, making it faster and easier to locate the resources they need to administer. For more information, see: [Assign Azure resource roles in Privileged Identity Management](~/id-governance/privileged-identity-management/pim-resource-roles-assign-roles.md).

---

### General availability - Self Service Password Reset (SSPR) now supports PIM eligible users and indirect group role assignment

**Type:** Changed feature   
**Service category:** Self Service Password Reset                     
**Product capability:** Identity Security & Protection          

Self Service Password Reset (SSPR) can now check for PIM eligible users, and evaluate group-based memberships, along with direct memberships when checking if a user is in a particular administrator role. This capability provides more accurate SSPR policy enforcement by validating if users are in scope for the default SSPR admin policy or your organizations SSPR user policy.


For more information, see: 

- [Administrator reset policy differences](~/identity/authentication/concept-sspr-policy.md#administrator-reset-policy-differences).
- [Create a role-assignable group in Azure Active Directory](~/identity/role-based-access-control/groups-create-eligible.md)

---

## March 2023


### Public Preview - New provisioning connectors in the Azure AD Application Gallery - March 2023

**Type:** New feature   
**Service category:** App Provisioning               
**Product capability:** 3rd Party Integration    
      

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Acunetix 360](~/identity/saas-apps/acunetix-360-provisioning-tutorial.md)
- [Akamai Enterprise Application Access](~/identity/saas-apps/akamai-enterprise-application-access-provisioning-tutorial.md)
- [Ardoq](~/identity/saas-apps/ardoq-provisioning-tutorial.md)
- [Torii](~/identity/saas-apps/torii-provisioning-tutorial.md)


For more information about how to better secure your organization by using automated user account provisioning, see: [Automate user provisioning to SaaS applications with Azure AD](~/identity/app-provisioning/user-provisioning.md).


---

### General Availability - Workload identity Federation for Managed Identities

**Type:** New feature   
**Service category:** Managed identities for Azure resources                     
**Product capability:** Developer Experience             

Workload Identity Federation enables developers to use managed identities for their software workloads running anywhere and access Azure resources without needing secrets. Key scenarios include:
- Accessing Azure resources from Kubernetes pods running in any cloud or on-premises
- GitHub workflows to deploy to Azure, no secrets necessary
- Accessing Azure resources from other cloud platforms that support OIDC, such as Google Cloud Platform.

For more information, see: 
- [Workload identity federation](~/workload-id/workload-identity-federation.md).
- [Configure a user-assigned managed identity to trust an external identity provider (preview)](~/workload-id/workload-identity-federation-create-trust-user-assigned-managed-identity.md)
- [Use Azure AD workload identity with Azure Kubernetes Service (AKS)](/azure/aks/workload-identity-overview)

---

### Public Preview - New My Groups Experience

**Type:** Changed feature   
**Service category:** Group Management                   
**Product capability:** End User Experiences          

A new and improved My Groups experience is now available at `https://www.myaccount.microsoft.com/groups`. My Groups enables end users to easily manage groups, such as finding groups to join, managing groups they own, and managing existing group memberships. Based on customer feedback, the new My Groups support sorting and filtering on lists of groups and group members, a full list of group members in large groups, and an actionable overview page for membership requests.
This experience replaces the existing My Groups experience at `https://www.mygroups.microsoft.com` in May.  


For more information, see: [Update your Groups info in the My Groups portal](https://support.microsoft.com/account-billing/update-your-groups-info-in-the-my-apps-portal-bc0ca998-6d3a-42ac-acb8-e900fb1174a4).

---

### Public preview - Customize tokens with Custom Claims Providers

**Type:** New feature   
**Service category:** Authentications (Logins)                      
**Product capability:** Extensibility             

A custom claims provider lets you call an API and map custom claims into the token during the authentication flow. The API call is made after the user has completed all their authentication challenges, and a token is about to be issued to the app. For more information, see: [Custom authentication extensions (preview)](~/identity-platform/custom-claims-provider-overview.md).

---

### General Availability - Converged Authentication Methods

**Type:** New feature   
**Service category:** MFA                     
**Product capability:** User Authentication             

The Converged Authentication Methods Policy enables you to manage all authentication methods used for MFA and SSPR in one policy, migrate off the legacy MFA and SSPR policies, and target authentication methods to groups of users instead of enabling them for all users in your tenant. For more information, see: [Manage authentication methods](~/identity/authentication/concept-authentication-methods-manage.md).

---

### General Availability - Provisioning Insights Workbook

**Type:** New feature   
**Service category:** Provisioning                     
**Product capability:** Monitoring & Reporting            

This new workbook makes it easier to investigate and gain insights into your provisioning workflows in a given tenant. This includes HR-driven provisioning, cloud sync, app provisioning, and cross-tenant sync.

Some key questions this workbook can help answer are:

- How many identities have been synced in a given time range?
- How many create, delete, update, or other operations were performed?
- How many operations were successful, skipped, or failed?
- What specific identities failed? And what step did they fail on?
- For any given user, what tenants / applications were they provisioned or deprovisioned to?

For more information, see: [Provisioning insights workbook](~/identity/app-provisioning/provisioning-workbook.md).

---

### General Availability - Number Matching for Microsoft Authenticator notifications

**Type:** Plan for Change  
**Service category:** Microsoft Authenticator App                      
**Product capability:** User Authentication             

Microsoft Authenticator app’s number matching feature has been Generally Available since Nov 2022! If you haven't already used the rollout controls (via Azure portal Admin UX and MSGraph APIs) to smoothly deploy number matching for users of Microsoft Authenticator push notifications, we highly encourage you to do so. We previously announced that we'll remove the admin controls and enforce the number match experience tenant-wide for all users of Microsoft Authenticator push notifications starting February 27, 2023. After listening to customers, we'll extend the availability of the rollout controls for a few more weeks. Organizations can continue to use the existing rollout controls until May 8, 2023, to deploy number matching in their organizations. Microsoft services will start enforcing the number matching experience for all users of Microsoft Authenticator push notifications after May 8, 2023. We'll also remove the rollout controls for number matching after that date.

If customers don’t enable number match for all Microsoft Authenticator push notifications prior to May 8, 2023, Authenticator users could experience inconsistent sign-ins while the services are rolling out this change. To ensure consistent behavior for all users, we highly recommend you enable number match for Microsoft Authenticator push notifications in advance.

For more information, see: [How to use number matching in multifactor authentication (MFA) notifications - Authentication methods policy](~/identity/authentication/how-to-mfa-number-match.md)

---

### Public Preview - IPv6 coming to Azure AD

**Type:** Plan for Change     
**Service category:** Identity Protection                     
**Product capability:** Platform             

Earlier, we announced our plan to bring IPv6 support to Microsoft Azure Active Directory (Azure AD), enabling our customers to reach the Azure AD services over IPv4, IPv6 or dual stack endpoints. This is just a reminder that we have started introducing IPv6 support into Azure AD services in a phased approach in late March 2023.  
 
If you utilize Conditional Access or Identity Protection, and have IPv6 enabled on any of your devices, you likely must take action to avoid impacting your users. For most customers, IPv4 won't completely disappear from their digital landscape, so we aren't planning to require IPv6 or to deprioritize IPv4 in any Azure AD features or services. We continue to share additional guidance on IPv6 enablement in Azure AD at this link: [IPv6 support in Azure Active Directory](/troubleshoot/azure/active-directory/azure-ad-ipv6-support).

---

### General Availability - Microsoft cloud settings for Azure AD B2B

**Type:** New feature  
**Service category:** B2B              
**Product capability:** B2B/B2C       

Microsoft cloud settings let you collaborate with organizations from different Microsoft Azure clouds. With Microsoft cloud settings, you can establish mutual B2B collaboration between the following clouds:

- Microsoft Azure commercial and Microsoft Azure Government
- Microsoft Azure commercial and Microsoft Azure operated by 21Vianet

For more information about Microsoft cloud settings for B2B collaboration, see [Microsoft cloud settings](~/external-id/cross-tenant-access-overview.md#microsoft-cloud-settings).

---

### Modernizing Terms of Use Experiences

**Type:** Plan for Change  
**Service category:** Terms of use                  
**Product capability:** AuthZ/Access Delegation        

Starting July 2023, we're modernizing the following Terms of Use end user experiences with an updated PDF viewer, and moving the experiences from https://account.activedirectory.windowsazure.com to https://myaccount.microsoft.com:
- View previously accepted terms of use.
- Accept or decline terms of use as part of the sign-in flow.

No functionalities are removed. The new PDF viewer adds functionality and the limited visual changes in the end-user experiences will be communicated in a future update. If your organization has allow-listed only certain domains, you must ensure your allowlist includes the domains ‘myaccount.microsoft.com’ and ‘*.myaccount.microsoft.com’ for Terms of Use to continue working as expected.

---

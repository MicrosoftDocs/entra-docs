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

Starting mid-April 2024, the Conditional Access *‘Locations’* condition is moving up. Locations will become the '*Network*' assignment, with the new Global Secure Access assignment - '*All compliant network locations*'.

This change will occur automatically, and admins won’t need to take any action. Here's more details:

- The familiar ‘*Locations*’ condition is unchanged, updating the policy in the ‘*Locations*’ condition will be reflected in the ‘*Network*’ assignment, and vice versa.
- No functionality changes, existing policies will continue to work without changes.

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

In this first phase, we're launching a new built-in Azure RBAC role that helps scope down the access possible for an individual with Azure Customer Lockbox approver rights on a subscription and its resources. A similar role for tenant-scoped requests is available in subsequent releases.

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

We're excited to announce that Microsoft Entra, is rolling out support for Transport Layer Security (TLS) 1.3 for its endpoints to align with security best practices ([NIST - SP 800-52 Rev. 2](https://csrc.nist.gov/pubs/sp/800/52/r2/final)). With this change, the Microsoft Entra ID related endpoints will support both TLS 1.2 and TLS 1.3 protocols. For more information, see: [TLS 1.3 support for Microsoft Entra services](/troubleshoot/azure/active-directory/enable-support-tls-environment?tabs=azure-monitor#tls-13-support-for-microsoft-entra-services).

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

Now Generally Available, My Sign Ins [(My Sign-Ins (microsoft.com))](https://mysignins.microsoft.com/) supports end users changing their passwords inline. When a user authenticates with a password and an MFA credential, they're able to are able to change their password without entering their existing password. Starting April 1st, through a phased rollout, traffic from the [Change password (windowsazure.com)](https://account.activedirectory.windowsazure.com/ChangePassword.aspx) portal will redirect to the new My Sign Ins change experience. The [Change password (windowsazure.com)](https://account.activedirectory.windowsazure.com/ChangePassword.aspx) will no longer be available after June 2024, but will continue to redirect to the new experience.


For more information, see: 

- [Combined security information registration for Microsoft Entra overview](../identity/authentication/concept-registration-mfa-sspr-combined.md).
- [Change work or school account settings in the My Account portal](https://support.microsoft.com/account-billing/change-work-or-school-account-settings-in-the-my-account-portal-e50bfccb-58e9-4d42-939c-a60cb6d56ced)

---

## February 2024

### General Availability - Identity Protection and Risk Remediation on the Azure Mobile App

**Type:** New feature    
**Service category:** Identity Protection    
**Product capability:** Identity Security & Protection    

Previously supported only on the portal, Identity Protection is a powerful tool that empowers administrators to proactively manage identity risks. Now available on the Azure Mobile app, administrators can respond to potential threats with ease and efficiency. This feature includes comprehensive reporting, offering insights into risky behaviors such as compromised user accounts and suspicious sign-ins.

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

Starting March 31st, 2024, all "*low*" risk detections and users in Microsoft Entra ID Identity Protection that are older than 6 months will be automatically aged out and dismissed. This will allow customers to focus on more relevant risk and provide a cleaner investigation environment. For more information, see: [What are risk detections?](../id-protection/concept-identity-protection-risks.md).

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

We've released a new premium user risk detection in Identity Protection called *Suspicious API Traffic*. This detection is reported when Identity Protection detects anomalous Graph traffic by a user. Suspicious API traffic might suggest that a user is compromised and conducting reconnaissance in their environment. For more information about Identity Protection detections including this one, please visit our public documentation at the following link: [What are risks detections?](../id-protection/concept-identity-protection-risks.md).

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

The Windows Azure Active Directory Connector for Forefront Identity Manager(FIM WAAD Connector) from 2014 was deprecated in 2021. The standard support for this connector will end in April 2024. Customers should remove this connector from their MIM sync deployment, and instead use an alternative provisioning mechanism. For more information, see: [Migrate a Microsoft Entra provisioning scenario from the FIM Connector for Microsoft Entra ID](/microsoft-identity-manager/migrate-from-the-fim-connector-for-azure-active-directory).

---

### General Availability - New provisioning connectors in the Microsoft Entra Application Gallery - February 2024

**Type:** New feature
**Service category:** App Provisioning
**Product capability:** 3rd Party Integration

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Alohi](../identity/saas-apps/alohi-provisioning-tutorial.md)
- [Insightly SAML](../identity/saas-apps/insightly-saml-provisioning-tutorial.md)
- [Starmind](../identity/saas-apps/starmind-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - February 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In February 2024 we've added the following 10 new applications in our App gallery with Federation support:

[Presswise](../identity/saas-apps/presswise-tutorial.md), [Stonebranch Universal Automation Center (SaaS Cloud)](../identity/saas-apps/stonebranch-universal-automation-center-saas-cloud-tutorial.md), [ProductPlan](../identity/saas-apps/productplan-tutorial.md), [Bigtincan for Outlook](https://www.bigtincan.com/content/), [Blinktime](https://www.blinktime.io/), [Stargo](http://www.stargo.co/), [Garage Hive BC v2](https://garagehive.co.uk/), [Avochato](https://www.avochato.com/), [Luscii](https://vitals.luscii.com/), [LEVR](https://levr.work/), [XM Discover](../identity/saas-apps/xm-discover-tutorial.md), [Sailsdock](https://www.sailsdock.no/), [Mercado Eletronico SAML](../identity/saas-apps/mercado-eletronico-saml-tutorial.md), [Moveworks](../identity/saas-apps/moveworks-tutorial.md), [Silbo](https://app.ambuliz.com/), [Alation Data Catalog](../identity/saas-apps/alation-data-catalog-tutorial.md), [Papirfly SSO](../identity/saas-apps/papirfly-sso-tutorial.md), [Secure Cloud User Integration](https://opentextcybersecurity.com/), [AlbertStudio](https://sandbox.albertinvent.com/), [Automatic Email Manager](https://www.automatic-email-manager.com/?utm_source=azuregallery), [Streamboxy](https://en.streamboxy.com/), [NewHotel PMS](http://www.newhotelcloud.com/), [Ving Room](https://www.letsving.com/), [Trevanna Tracks](../identity/saas-apps/trevanna-tracks-tutorial.md), [Alteryx Server](../identity/saas-apps/alteryx-server-tutorial.md), [RICOH Smart Integration](https://www.ricoh.com/), [Genius](), [Othership Workplace Scheduler](), [GitHub Enterprise Managed User - ghe.com](../identity/saas-apps/github-enterprise-managed-user-tutorial.md),[Thumb Technologies](https://www.thumb.is/), [Freightender SSO for TRP (Tender Response Platform)](../identity/saas-apps/freightender-sso-for-trp-tender-response-platform-tutorial.md), [BeWhere Portal (UPS Access)](http://www.bewhere.com/), [Flexiroute](https://www.flexiroute.net/), [SEEDL](https://www.seedlgroup.com/), [Isolocity](https://www.isolocity.com/), [SpotDraft](../identity/saas-apps/spotdraft-tutorial.md), [Blinq](../identity/saas-apps/blinq-tutorial.md), [Cisco Phone OBTJ](https://www.cisco.com/), [Applitools Eyes](../identity/saas-apps/applitools-eyes-tutorial.md).

You can also find the documentation of all the applications from here https://aka.ms/AppsTutorial.

For listing your application in the Microsoft Entra ID app gallery, read the details here https://aka.ms/AzureADAppRequest.

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

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

- [Personify Inc](../identity/saas-apps/personify-inc-provisioning-tutorial.md)
- [Screensteps](../identity/saas-apps/screensteps-provisioning-tutorial.md)
- [WiggleDesk](../identity/saas-apps/wiggledesk-provisioning-tutorial.md)

For more information about how to better secure your organization by using automated user account provisioning, see: [What is app provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md).

---

### General Availability - New Federated Apps available in Microsoft Entra Application gallery - January 2024

**Type:** New feature   
**Service category:** Enterprise Apps                
**Product capability:** 3rd Party Integration          

In January 2024 we've added the following 10 new applications in our App gallery with Federation support:

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

Starting in November 2023, Microsoft will begin automatically protecting customers with Microsoft managed Conditional Access policies. These are policies that Microsoft creates and enables in customer tenants. The following policies are rolled out to all eligible tenants, who will be notified prior to policy creation:

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

We've added the following new applications in our App gallery with Provisioning support. You can now automate creating, updating, and deleting of user accounts for these newly integrated apps:

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

In November 2023 we've added the following 10 new applications in our App gallery with Federation support:

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

### General Availability - Microsoft Security email update and Resources for Azure AD rename to Microsoft Entra ID 

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

### General Availability - End users will no longer be able to add password SSO apps in My Apps. 

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

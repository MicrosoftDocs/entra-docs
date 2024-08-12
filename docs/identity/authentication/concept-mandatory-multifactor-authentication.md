---
title: Mandatory Microsoft Entra multifactor authentication (MFA) 
description: Plan for mandatory multifactor authentication for users who sign in to Azure and other management portals
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 08/11/2024
ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: nashahid

# Customer intent: As an identity administrator, I want to plan for mandatory MFA for users who sign in to Azure portal.
---
# Planning for mandatory multifactor authentication for Azure and other administration portals 

At Microsoft, we're committed to providing our customers with the highest level of security. That's why, starting in 2024, we'll enforce mandatory multifactor authentication (MFA) for all Azure sign-in attempts. This blog post explains why this requirement is being enforced. 

## Scope of enforcement 

This section covers applications and accounts that have mandatory MFA requirement.

### Applications 

| Application Name | App ID | 
|------------------|---------------------------------------|
| Azure portal     | c44b4083-3bb0-49c1-b47d-974e53cbdf3c  |
| Microsoft Entra admin center | c44b4083-3bb0-49c1-b47d-974e53cbdf3c |
| Microsoft Intune admin center | c44b4083-3bb0-49c1-b47d-974e53cbdf3c |
| Azure Command Line Interface (CLI) | 04b07795-8ddb-461a-bbee-02f9e1bf7b46 |
| Azure PowerShell  | 1950a258-227b-4e31-a9cf-717495945fc2 |
| Azure mobile app  | 0c1307d4-29d6-4389-a11c-5cbe7f65d7fa |
| Infrastructure as Code (IaC) tools | Use Azure CLI or Azure PowerShell IDs |

### Accounts 

All users who sign into the [applications](#applications) listed previously to perform any Create, Read, Update, or Delete (CRUD) operation will require MFA when the enforcement begins. End users who access application, websites, or services hosted on Azure, but don't sign into the listed applications, aren't required to use MFA. The authentication requirements for end users is controlled by the application, website, or service owner. 

Workload identities, such as managed identities and service principals, aren't impacted by MFA enforcement. If user identities sign in as a service account to run automation (including scripts or other automated tasks), those user identities need to sign in with MFA once enforcement begins. User identities aren't recommended for automation. You should migrate those user identities to workload identities. 

Break glass or emergency access accounts are also required to sign in with MFA once enforcement begins. We recommend updating these accounts to use passkey (FIDO2) or configure certificate-based authentication for MFA. Both methods satisfy the MFA requirement. 

## Enforcement phases 

The enforcement of MFA will roll out in two phases: 

- **Phase 1**: Starting in the second half of 2024, MFA will be required to sign in to the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center. The enforcement will gradually roll out to all tenants worldwide. This phase will not impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app, or IaC tools.  

- **Phase 2**: Beginning in early 2025, MFA enforcement gradually begins for sign in to Azure Command Line Interface (CLI), Azure PowerShell, Azure mobile app, and IaC tools. Some customers may use a user account in Entra ID as a service account. It is recommended to migrate these user-based service accounts to secure cloud based service accounts with workload identities. 

## Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

- Email: Global Administrators who have configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

- Service health notification: Global Administrators will receive a service health notification through the Azure portal, with the tracking ID of **4V20-VX0**. This notification will contain the same information as the email. Global Administrators can also subscribe to receive service health notifications through email. 

- Portal notification: Global Administrators will see a notification in the Azure portal, Microsoft Entra admin center, and Microsoft Intune admin center when they sign in. The portal notification links to this topic for more information about the mandatory MFA enforcement. 

- Microsoft 365 message center: Global Administrators will also see a message in the Microsoft 365 message center with the same information as the email and service health notification. 


## External authentication methods and identity providers 

Support for external MFA solutions is in public preview with external authentication methods, and can be used to meet the MFA requirement. The deprecated Conditional Access custom controls preview will not satisfy the MFA requirement, and you should migrate to the external authentication methods preview to use an external solution with Microsoft Entra ID.  

If you are using a federated Identity Provider (IdP), such as Active Directory Federation Services, and your MFA provider is integrated directly with this federated identity provider, the Federated identity provider must be configured to send an MFA claim. 

## Requesting additional time to prepare for enforcement 

We understand that some customers may need additional time to prepare for this MFA requirement. Therefore, Microsoft will allow grace periods for customers with complex environments or technical barriers. 

Between 8/15/2024 and 10/15/2024, Global Administrators can go to this page in the Azure portal to postpone the start date of enforcement for their tenant to 3/15/2025: https://aka.ms/managemfaforazure.  Global Administrators must have elevated access before postponing the start date of MFA enforcement on this page.  

Global Administrators must perform this action for every tenant for which they would like to postpone the start date of enforcement. Elevated access 

By postponing the start date of enforcement, you are taking additional risk as accounts that access Microsoft services like the Azure portal are high value targets for threat actors. We recommend setting up MFA now to secure your cloud resources.  
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

Applications 

Application Name 

App ID 

Azure portal  

c44b4083-3bb0-49c1-b47d-974e53cbdf3c 

Microsoft Entra admin center 

c44b4083-3bb0-49c1-b47d-974e53cbdf3c 

Microsoft Intune admin center 

c44b4083-3bb0-49c1-b47d-974e53cbdf3c 

Azure Command Line Interface (CLI) 

04b07795-8ddb-461a-bbee-02f9e1bf7b46 

Azure PowerShell  

1950a258-227b-4e31-a9cf-717495945fc2 

Azure mobile app  

0c1307d4-29d6-4389-a11c-5cbe7f65d7fa 

Infrastructure as Code (IaC) tools 

CLI or PowerShell app ids are used 

 

Accounts 

All users who sign into the applications mentioned above to perform any Create, Read, Update, or Delete (CRUD) operation will require MFA when the enforcement begins. End users who are accessing apps, websites or services hosted on Azure, but not signing into the listed applications, are not subject to this requirement from Microsoft. Authentication requirements for end users will still be controlled by the app, website or service owners. 

Workload Identities, such as managed identities and service principals, will not be impacted by this enforcement. If you are leveraging user identities as a service account running automation (including scripts or other automated tasks), those will be required to use MFA once enforcement begins. Our guidance is that user identities are not recommended for automation and customers should migrate those to Workload Identities. 

Break glass or emergency access accounts will also be required to sign in with multifactor authentication once enforcement begins. We recommend updating these accounts to use FIDO2 or certificate-based authentication (when configured as MFA).  Both methods will satisfy the MFA requirements. 

TimingEnforcement phases 

The enforcement of MFA will roll out in phases:  

Phase 1: Starting in the 2nd half of calendar year 2024, MFA will be required to sign-in to the Azure portal, Microsoft Entra admin center and Microsoft Intune admin center. The enforcement will gradually roll out to all tenants worldwide. This phase will not impact other Azure clients such as Azure CLI, Azure PowerShell, Azure mobile app and Infrastructure as Code (IaC) tools.  

Phase 2: Beginning in early 2025, gradual enforcement for MFA at sign-in for  Azure Command Line Interface (CLI), Azure PowerShell, Azure mobile app and Infrastructure as Code (IaC) tools will commence.  Some customers may currently have deployed user accounts in Entra ID as a service account. It is recommended to migrate these user-based service accounts to secure cloud based service accounts with workload identities. 

Notification channels 

Microsoft will notify all Microsoft Entra Global Administrators through the following channels: 

Email: Global Administrators who have configured an email address will be informed by email of the upcoming MFA enforcement and the actions required to be prepared. 

Service health notification: Global Administrators will receive a service health notification through the Azure portal, with the tracking ID of 4V20-VX0. This notification will contain the same information as the email. Global Administrators can also subscribe to receive service health notifications through email by following the instructions <here>. 

Portal notification: Global Administrators will see a notification in the Azure portal, Microsoft Entra admin center and Microsoft Intune admin center at login. The portal notification links to this page for more information about the mandatory MFA enforcementrequirement. 

Microsoft 365 message center: Global Administrators will also see a message in the Microsoft 365 message center with the same information as the email and service health notification. 
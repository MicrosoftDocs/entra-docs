---
title: Plan deploying Microsoft Entra for provisioning with SAP source and target systems
description: Learn the detailed steps for how to bring identities from SAP SuccessFactors and other sources into Microsoft Entra ID and provision those identities with access to SAP ECC, SAP S/4HANA, and other SAP and non-SAP applications.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 04/10/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Plan deploying Microsoft Entra for provisioning with SAP source and target systems

SAP likely runs critical functions, such as HR and ERP, for your organization. At the same time, your organization relies on Microsoft for various Azure services or Microsoft 365. You can use Microsoft Entra to orchestrate the identities for your employees, contractors and others, and their access, across your SAP and non-SAP applications.

This article describes how you can use Microsoft Entra features to manage identities across your SAP applications, based on properties of those identities originating from SAP HR sources. This tutorial assumes

* your organization has a Microsoft Entra tenant in the commercial cloud with a license for at least Microsoft Entra ID P1 in that tenant
* you are an administrator of that tenant
* your organization has SAP SuccessFactors, and optionally other system of record authoritative sources
* your organization has SAP ECC, SAP S/4HANA or other SAP applications, and optionally other applications

## Overview

This tutorial illustrates how to connect Microsoft Entra with authoritative sources for the list of workers in an organization, such as SAP SuccessFactors, use Microsoft Entra to set up identities for those workers, and then use Microsoft Entra to provide them with access to sign into one or more SAP applications, such as SAP ECC or SAP S/4HANA.

The process is
 - Define the requirements for identities and access for applications in your organization.
 - Ensure Microsoft Entra ID and related Microsoft Online Services meet the organizational prerequisites for this scenario.
 - Bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials.
 - Assign users with the necessary access rights in Microsoft Entra.
 - Provision users and their access rights to applications and enable them to sign in to those applications.
 - Monitor the identity flows to watch for errors, and to adjust policies and operations as needed.

Once complete, then those individuals will be able to sign into SAP and non-SAP applications that they are authorized to use.

:::image type="content" source="media/plan-sap-source-and-target/end-to-end-integrations.png" alt-text="Diagram showing end-to-end breadth of relevant Microsoft and SAP technologies and their integrations." lightbox="media/plan-sap-source-and-target/end-to-end-integrations.png":::

## Define the requirements for identities and access for applications in your organization

Organizations with compliance requirements or risk management plans have sensitive or business-critical applications. If an application is an existing application in your environment, you may already have documented the access policies for who 'should have access' to this application. If not, you may need to consult with various stakeholders, such as compliance and risk management teams, to ensure that the policies being used to automate access decisions are appropriate for your scenario.  This section highlights the key decisions needed for integration with SAP applications. For non-SAP applications, see [define organizational policies for governing access to applications in your environment](~/id-governance/identity-governance-applications-define.md).

### Determine the sequence of application onboarding and how applications will integrate with Microsoft Entra

1. **Establish a priority order for applications to be integrated with Microsoft Entra for single-sign on and for provisioning.**

1. **Confirm how each application will integrate with Microsoft Entra.**

1. **Collect the roles and permissions that each application provides.**  Some applications may have only a single role, for example, SAP Cloud Identity Services only has one role, **User**, available for assignment. Other applications may surface multiple roles to be managed through Microsoft Entra ID. These application roles typically make broad constraints on the access a user with that role would have within the app. Other applications may also rely upon group memberships or claims for finer-grained role checks, which can be provided to the application from Microsoft Entra ID in provisioning or claims issued using federation SSO protocols, or written to AD as a security group membership.

   > [!Note]
   > If you're using an application from the Microsoft Entra application gallery that supports provisioning, then Microsoft Entra ID may import defined roles in the application and automatically update the application manifest with the application's roles automatically, once provisioning is configured.

1. **Select which roles and groups have membership that are to be governed in Microsoft Entra ID.** Based on compliance and risk management requirements, organizations often prioritize those application roles or groups that give privileged access or access to sensitive information.

1. **Determine the required schema for users to have to be able to use the application.**

### Define the organization's policy with user prerequisites and other constraints for access to an application

In this section, you'll determine the organizational policies you plan to use to determine access to each application.

1. **Identify if there are prerequisite requirements, standards that a user must meet before to they're given access to an application.** For example, under normal circumstances, only full time employees, or those in a particular department or cost center, should be allowed to have access to a particular department's application. For another example, if you're using Microsoft Entra entitlement management in Microsoft Entra ID Governance, you may choose to configure the entitlement management policy for a user from some other department requesting access to have one or more additional approvers. While having multiple stages of approval may slow the overall process of a user gaining access, these extra stages ensure access requests are appropriate and decisions are accountable. In some organizations, requests for access by an employee could have two stages of approval, first by the requesting user's manager, and second by one of the resource owners responsible for data held in the application.

1. **Determine how long a user who has been approved for access, should have access, and when that access should go away.**  For many applications, a user might retain access indefinitely, until they're no longer affiliated with the organization. In some situations, access may be tied to particular projects or milestones, so that when the project ends, access is removed automatically. Or, if only a few users are using an application through a policy, you may configure quarterly or yearly reviews of everyone's access through that policy, so that there's regular oversight. These scenarios will require Microsoft Entra ID Governance.

1. **If your organization is governing access already with an organizational role model, plan to bring that organizational role model into Microsoft Entra ID.** You may have an [organizational role](~/id-governance/identity-governance-organizational-roles.md) defined which assigns access based on a user's property, such as their position or department. These processes can ensure users lose access eventually when access is no longer needed, even if there isn't a pre-determined project end date. If you already have an organization role definition, you can [migrate organizational role definitions](~/id-governance/identity-governance-organizational-roles.md) to Microsoft Entra ID Governance.

1. **Inquire if there are separation of duties constraints.** For example, you may have an application with two app roles, *Western Sales* and *Eastern Sales*, and you want to ensure that a user can only have one sales territory at a time. Include a list of any pairs of app roles that are incompatible for your application, so that if a user has one role, they aren't allowed to request the second role. These can be enforced by Microsoft Entra entitlement management.

1. **Select the appropriate Conditional Access policy for access to the application.** We recommend that you analyze your applications and organize them into collections of applications that have the same resource requirements for the same users. If this is the first federated SSO application you're integrating with Microsoft Entra ID , you may need to create a new Conditional Access policy to express constraints, such as requirements for Multifactor authentication (MFA) or location-based access. You can configure users to be required to agree to [a terms of use](~/identity/conditional-access/require-tou.md). See [plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md) for more considerations on how to define a Conditional Access policy.

1. **Determine how exceptions to your criteria should be handled.**  For example, an application may typically only be available for designated employees, but an auditor or vendor may need temporary access for a specific project. Or, an employee who is traveling may require access from a location that is normally blocked as your organization has no presence in that location.   In these situations, if you have Microsoft Entra ID Governance, you may choose to also have an entitlement management policy for approval that may have different stages, or a different time limit, or a different approver. A vendor who is signed in as a guest user in your Microsoft Entra tenant may not have a manager, so instead their access requests could be approved by a sponsor for their organization, or by a resource owner, or a security officer.

## Ensure organizational prerequisites are met before configuring Microsoft Entra ID

Before you begin the process of provisioning business-critical application access from Microsoft Entra ID, you should check your Microsoft Entra environment is appropriately configured.

* **Ensure your Microsoft Entra ID and Microsoft Online Services environment is ready for the [compliance requirements](~/standards/standards-overview.md) for the applications**. Compliance is a shared responsibility among Microsoft, cloud service providers (CSPs), and organizations.

* **Ensure your Microsoft Entra ID tenant is properly licensed**. To use Microsoft Entra ID to automate provisioning, your tenant must have a valid [Microsoft Entra ID P1 or P2 license](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing) with as many seats as there are workers that will be sourced from the source HR application or member (non-guest) users that will be provisioned. In addition, use of [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md) and other Microsoft Entra ID Governance features in the provisioning process requires a [Microsoft Entra ID Governance license](~/id-governance/licensing-fundamentals.md) in your tenant:

  * **Microsoft Entra ID Governance** and its prerequisite, Microsoft Entra ID P1
  * **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2** and its prerequisite, either Microsoft Entra ID P2 or Enterprise Mobility + Security (EMS) E5

* **Check that Microsoft Entra ID is already sending its audit log, and optionally other logs, to Azure Monitor.** Azure Monitor is optional, but useful for governing access to apps, as Microsoft Entra only stores audit events for up to 30 days in its audit log. You can keep the audit data for longer than this default retention period, outlined in [How long does Microsoft Entra ID store reporting data?](~/identity/monitoring-health/reference-reports-data-retention.md), and use Azure Monitor workbooks and custom queries and reports on historical audit data. You can check the Microsoft Entra configuration to see if it's using Azure Monitor, in **Microsoft Entra ID** in the Microsoft Entra admin center, by clicking on **Workbooks**. If this integration isn't configured, and you have an Azure subscription and are in the `Global Administrator` or `Security Administrator` roles, you can [configure Microsoft Entra ID to use Azure Monitor](~/id-governance/entitlement-management-logs-and-reporting.md).

* **Make sure only authorized users are in the highly privileged administrative roles in your Microsoft Entra tenant.** Administrators in the *Global Administrator*, *Identity Governance Administrator*, *User Administrator*, *Application Administrator*, *Cloud Application Administrator* and *Privileged Role Administrator* can make changes to users and their application role assignments. If the memberships of those roles haven't yet been recently reviewed, you need a user who is in the *Global Administrator* or *Privileged Role Administrator* to ensure that [access review of these directory roles](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) are started. You should also ensure that users in Azure roles in subscriptions that hold the Azure Monitor, Logic Apps and other resources needed for the operation of your Microsoft Entra configuration have been reviewed.

* **Check your tenant has appropriate isolation.** If your organization is using Active Directory on-premises, and these AD domains are connected to Microsoft Entra ID, then you need to ensure that highly privileged administrative operations for cloud-hosted services are isolated from on-premises accounts. Check that you've [configured your systems to protect your Microsoft 365 cloud environment from on-premises compromise](~/architecture/protect-m365-from-on-premises-attacks.md).


## Bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials

:::image type="content" source="media/plan-sap-source-and-target/inbound-data-preparation.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to bringing in data about workers to Microsoft Entra ID." lightbox="media/plan-sap-source-and-target/inbound-data-preparation.png":::

<!-- 
Assume one SuccessFactors source, one Entra tenant, one SAP cloud directory services target; no governance, no on-prem SAP, no guests and everyone in SF is who needs to be in AD/Entra ID/SAP, at most one AD domain.   They want to get the workers from SuccessFactors into SAP cloud directory services, going through Entra and maybe AD.  The customer may or may not have existing users in SAP cloud directory services, or AD or AAD users, that correspond to their SuccessFactors workers.  In this flow, assume there’s no SAP IDM being migrated from, or on-prem SAP apps in this flow, those are added below.

Step	Description	Where	Learn doc on how to do this	Status
1.1	Ensure your SAP cloud directory has the user schema required by your SAP apps.	[SAP, TBD]		
1.2	Ensure your SuccessFactors has the worker schema required by your SAP apps.	[SAP, TBD]		

Flow 1A – with AD DS
Step	Description	Where	Learn doc on how to do this	Status
1.3	[If you plan to provision users to WS AD] For each user attribute required by 1.1 not already part of the AD User schema, either select a built-in AD schema extension or extend the AD schema for that attribute.	WS AD (AD PSh?)		
1.4	[If you plan to provision users to WS AD] Ensure that any user already in AD representing a worker has the ‘join key’ attributes of SuccessFactors from 1.2 populated so that they will be ‘joined up’ during HR initial inbound and there won’t be duplicate users created. 	WS AD (AD PSh?)		
1.5	[If you plan to provision users to WS AD and using Azure AD Connect ] Ensure all attributes from 1.3 are configured to be provisioned into Entra ID.  (This will extend the Entra ID user schema automatically)	AADC UI		
1.6	[If you plan to provision users to WS AD and using Cloud Sync, or using not provisioning users to WS AD] For each user attribute required by 1.1 not already part of the Entra ID user schema, extend the Entra ID user schema with additional attributes. 	Graph PSh		
1.7	[If you plan to provision users to WS AD and using Cloud Sync] configure the Cloud Sync mapping	Entra ; ?		
1.8	[If you plan to provision users to WS AD] Ensure that any sync from WS AD to Entra ID (with any changes you made to users in AD in step 1.4) have completed. 	?		

Flow 1B – not using AD DS
Step	Description	Where	Learn doc on how to do this	Status
1.6	[If you plan to provision users to WS AD and using Cloud Sync, or using not provisioning users to WS AD] For each user attribute required by 1.1 not already part of the Entra ID user schema, extend the Entra ID user schema with additional attributes. 	Graph PSh		

Continued

Step	Description	Where	Learn doc on how to do this	Status
1.9	Ensure that any user already in Entra ID representing a worker has the ‘join key’ attributes of SuccessFactors from 1.2 populated so that they will be ‘joined up’ during HR initial inbound and there won’t be duplicate users created.	Is there Graph PSh script for this?		
1.10	Configure the SuccessFactors inbound mapping of the worker schema from 1.2 to either the AD schema of 1.3 or the Entra ID schema of 1.6.  Perform the initial inbound sync.    Wait for all workers to be synched.	Entra > app for SF inbound 		
1.11	[If provisioning into WS AD]. wait for new users created in WS AD  or those updated in WS AD to sync from WS AD to Entra ID.			
1.12	Ensure that Entra ID has the right users for the workers in SuccessFactors and they are populated with the attributes required by SAP cloud directory in 1.1.  Ensure there are no users in Entra ID who do not correspond to SuccessFactors workers because they are orphan accounts.	Is there Graph PSh script for this?		
-->

## Assign users with the necessary access rights in Microsoft Entra

## Provision users and their access rights to applications and enable them to sign in to those applications

:::image type="content" source="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png":::


### SAP Cloud Identity Services

<!-- 

1.13	Compare the users in Entra ID with those already in SAP cloud directory. 	
1.14A	Configure the SAP cloud directory outbound SCIM with user mapping.  Enable the initial outbound sync. OR 
	Entra > app for SAP cloud directory > provisioning
1.14B	Configure SAP cloud identity services inbound	
1.15	Wait for sync from Entra ID to SAP cloud directory to complete.	
1.16	Compare the users in SAP cloud directory with those in Entra ID.  Ensure that there are no orphan users in SAP cloud directory who are not originating from Entra ID.	Export from SAP and PSh
1.17	Configure the SAP cloud directory federated SSO mapping.  	Entra >  app for SAP cloud directory > SSO
1.18	Test that a user can connect to SAP cloud directory and is correctly joined.	myapps; SAP UI

-->

### SAP ECC


## Monitor identity flows


### HR inbound

### Active Directory

### Outbound provisioning

### Single sign-on

* You can view the last 30 days of sign-ins to an application in the [sign-ins report](~/identity/monitoring-health/concept-sign-in-log-activity-details.md) in the Microsoft Entra admin center, or via [Graph](/graph/api/signin-list?view=graph-rest-1.0&tabs=http&preserve-view=true).
* You can also send the [sign in logs to Azure Monitor](~/identity/monitoring-health/concept-log-monitoring-integration-options-considerations.md) to archive sign in activity for up to two years.

### Identity Governance

If you are using Microsoft Entra ID Governance, then you can report on how users are getting access using Microsoft ID Governance features.

* An administrator, or a catalog owner, can [retrieve the list of users who have access package assignments](~/id-governance/entitlement-management-access-package-assignments.md), via the Microsoft Entra admin center, Graph or PowerShell.
* You can also send the audit logs to Azure Monitor and view a history of [changes to the access package](~/id-governance/entitlement-management-logs-and-reporting.md#view-events-for-an-access-package), in the Microsoft Entra admin center, or via PowerShell.
* For more information on these and other identity governance scenarios, see how to [monitor to adjust entitlement management policies and access as needed](~/id-governance/identity-governance-applications-deploy.md#monitor-to-adjust-entitlement-management-policies-and-access-as-needed).

## Next steps

- [Govern access by migrating an organizational role model to Microsoft Entra ID Governance](~/id-governance/identity-governance-organizational-roles.md)
- [Define organizational policies for governing access to other applications in your environment](~/id-governance/identity-governance-applications-define.md)

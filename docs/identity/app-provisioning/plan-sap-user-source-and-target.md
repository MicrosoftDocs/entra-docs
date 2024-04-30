---
title: Plan deploying Microsoft Entra for user identity provisioning with SAP source and target applications
description: Learn the detailed steps for how to bring identities from SAP SuccessFactors and other sources into Microsoft Entra ID and provision those identities with access to SAP ECC, SAP S/4HANA, and other SAP and non-SAP applications.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 04/20/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Plan deploying Microsoft Entra for user provisioning with SAP source and target applications

SAP likely runs critical functions, such as HR and ERP, for your organization. At the same time, your organization relies on Microsoft for various Azure services or Microsoft 365. You can use Microsoft Entra to orchestrate the identities for your employees, contractors and others, and their access, across your SAP and non-SAP applications.

This article describes how you can use Microsoft Entra features to manage identities across your SAP applications, based on properties of those identities originating from SAP HR sources. This tutorial assumes:

* your organization has a Microsoft Entra tenant in the commercial cloud with a license for at least Microsoft Entra ID P1 in that tenant (some steps illustrate using Microsoft Entra ID Governance features as well)
* you are an administrator of that tenant
* your organization has a system of record source of workers, SAP SuccessFactors
* your organization has SAP ECC, SAP S/4HANA, or other SAP applications, and optionally has other non-SAP applications
* you will be using SAP Cloud Identity Services for provisioning and single-sign on to SAP applications other than SAP ECC

## Overview

This tutorial illustrates how to connect Microsoft Entra with authoritative sources for the list of workers in an organization, such as SAP SuccessFactors, use Microsoft Entra to set up identities for those workers, and then use Microsoft Entra to provide them with access to sign into one or more SAP applications, such as SAP ECC or SAP S/4HANA.

The process is:

 - Plan: define the requirements for identities and access for applications in your organization, and ensure Microsoft Entra ID and related Microsoft Online Services meet the organizational prerequisites for this scenario.
 - Deploy: bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials, aAssign users with the necessary access rights in Microsoft Entra, and provision those users and their access rights to applications to enable them to sign in to those applications.
 - Monitor: monitor the identity flows to watch for errors, and to adjust policies and operations as needed.

Once complete, then those individuals who are authorized for one or more applications, will be able to sign into SAP and non-SAP applications that they are authorized to use, with Microsoft Entra user identities.

The following diagram illustrates the example topology used in this article. In this topology, workers are represented in SuccessFactors, and need to have accounts in a Windows Server Active Directory domain, in Microsoft Entra, SAP ECC and SAP cloud applications. This tutorial illustrates an organization which has a Windows Server AD domain; however, Windows Server AD is not required for this tutorial.

:::image type="content" source="media/plan-sap-source-and-target/end-to-end-integrations.png" alt-text="Diagram showing end-to-end breadth of relevant Microsoft and SAP technologies and their integrations." lightbox="media/plan-sap-source-and-target/end-to-end-integrations.png":::

This article focuses on the identity lifecycle for users representing employees and other workers. Identity lifecycle for guests, as well as access lifecycle for role assignments, requests and reviews, are outside of the scope of this article.

## Planning

In this section, you'll define the requirements for identities and access for applications in your organization. This section highlights the key decisions needed for integration with SAP applications. For non-SAP applications, see [define organizational policies for governing access to applications in your environment](~/id-governance/identity-governance-applications-define.md).

### Determine the sequence of application onboarding and how applications will integrate with Microsoft Entra

1. **Establish a priority order for applications to be integrated with Microsoft Entra for single-sign on and for provisioning.** Organizations generally start integrating with SaaS applications that support modern protocols. In the case of SAP, we recommend that organizations which have SAP cloud applications start their integrations with the single sign on and provisioning integrations with SAP Cloud Identity Services as middleware. Here, a user provisioning and single-sign integration to Microsoft Entra can benefit multiple SAP applications.

1. **Confirm how each application will integrate with Microsoft Entra.** If your application is listed as one of the [SAP Cloud Identity Services provisioning target systems](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-systems), such as SAP S/4HANA, then you will be using SAP Cloud Identity Services as middleware to bridge single sign-on and provisioning from Microsoft Entra to the application. If your application is SAP ECC, then you will be integrating Microsoft Entra directly with SAP NetWeaver for single sign-on and to BAPIs of SAP ECC for provisioning. For non-SAP applications, follow the instructions in the article [integrate the application with Microsoft Entra ID](../../id-governance/identity-governance-applications-integrate.md#integrate-the-application-with-microsoft-entra-id-to-ensure-only-authorized-users-can-access-the-application) to determine the supported integration technologies for single-sign on and provisioning for each of your applications.

1. **Collect the roles and permissions that each application provides.** Some applications may have only a single role, for example, SAP Cloud Identity Services only has one role, **User**, available for assignment. SAP Cloud Identity Services can however read groups from Microsoft Entra ID for use in application assignment. Other applications may surface multiple roles to be managed through Microsoft Entra ID. These application roles typically make broad constraints on the access a user with that role would have within the app. Other applications may also rely upon group memberships or claims for finer-grained role checks, which can be provided to each application from Microsoft Entra ID in provisioning or claims issued using federation SSO protocols, or written to AD as a security group membership.

   > [!Note]
   > If you're using an application from the Microsoft Entra application gallery that supports provisioning, then Microsoft Entra ID may import defined roles in the application and automatically update the application manifest with the application's roles automatically, once provisioning is configured.

1. **Select which roles and groups have membership that are to be governed in Microsoft Entra ID.** Based on compliance and risk management requirements, organizations often prioritize those application roles or groups that give privileged access or access to sensitive information. While this article does not include the steps for configuring access assignment, you will want to identify the roles and groups that are relevant to ensure that all their members are provisioned to the applications.

### Define the organization's policy with user prerequisites and other constraints for access to an application

In this section, you'll determine the organizational policies you plan to use to determine access to each application.

1. **Identify if there are prerequisite requirements, standards that a user must meet before to they're given access to an application.** Organizations with compliance requirements or risk management plans have also sensitive or business-critical applications. If an application is an existing application in your environment, you may already have documented the access policies for who 'should have access' to this application. If not, you may need to consult with various stakeholders, such as compliance and risk management teams, to ensure that the policies being used to automate access decisions are appropriate for your scenario. For example, under normal circumstances, only full time employees, or those in a particular department or cost center, should be allowed to have access to a particular department's application. For another example, if you're using Microsoft Entra entitlement management in Microsoft Entra ID Governance, you may choose to configure the entitlement management policy for a user from some other department requesting access to have one or more additional approvers. While having multiple stages of approval may slow the overall process of a user gaining access, these extra stages ensure access requests are appropriate and decisions are accountable. In some organizations, requests for access by an employee could have two stages of approval, first by the requesting user's manager, and second by one of the resource owners responsible for data held in the application.

1. **Determine how long a user who has been approved for access, should have access, and when that access should go away.** For many applications, a user might retain access indefinitely, until they're no longer affiliated with the organization. In some situations, access may be tied to particular projects or milestones, so that when the project ends, access is removed automatically. Or, if only a few users are using an application through a policy, you may configure quarterly or yearly reviews of everyone's access through that policy, so that there's regular oversight. These scenarios will require Microsoft Entra ID Governance.

1. **If your organization is governing access already with an organizational role model, plan to bring that organizational role model into Microsoft Entra ID.** You may have an [organizational role](~/id-governance/identity-governance-organizational-roles.md) defined which assigns access based on a user's property, such as their position or department. These processes can ensure users lose access eventually when access is no longer needed, even if there isn't a pre-determined project end date. If you already have an organization role definition, you can [migrate organizational role definitions](~/id-governance/identity-governance-organizational-roles.md) to Microsoft Entra ID Governance.

1. **Inquire if there are separation of duties constraints.** For example, you may have an application with two app roles, *Western Sales* and *Eastern Sales*, and you want to ensure that a user can only have one sales territory at a time. Include a list of any pairs of app roles that are incompatible for your application, so that if a user has one role, they aren't allowed to request the second role. These can be enforced by Microsoft Entra entitlement management.

1. **Select the appropriate Conditional Access policy for access to each application.** We recommend that you analyze your applications and organize them into collections of applications that have the same resource requirements for the same users. If this is the first federated SSO application you're integrating with Microsoft Entra ID, you may need to create a new Conditional Access policy to express constraints, such as requirements for Multifactor authentication (MFA) or location-based access. You can configure users to be required to agree to [a terms of use](~/identity/conditional-access/require-tou.md). See [plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md) for more considerations on how to define a Conditional Access policy.

1. **Determine how exceptions to your criteria should be handled.** For example, an application may typically only be available for designated employees, but an auditor or vendor may need temporary access for a specific project. Or, an employee who is traveling may require access from a location that is normally blocked as your organization has no presence in that location. In these situations, if you have Microsoft Entra ID Governance, you may choose to also have an entitlement management policy for approval that may have different stages, or a different time limit, or a different approver. A vendor who is signed in as a guest user in your Microsoft Entra tenant may not have a manager, so instead their access requests could be approved by a sponsor for their organization, or by a resource owner, or a security officer.

### Decide on the provisioning and authentication topology

<!-- -->

1. **Authoritative sources.** Configuring Cloud HR driven user provisioning from SuccessFactors to Microsoft Entra ID requires considerable planning covering different aspects, including determining the Matching ID, and defining attribute mappings, attribute transformation, and scoping filters. Refer to the [cloud HR deployment plan](~/identity/app-provisioning/plan-cloud-hr-provision.md) for comprehensive guidelines around these topics, and to the [SAP SuccessFactors integration reference](~/identity/app-provisioning/sap-successfactors-integration-reference.md) to learn about the supported entities, processing details and how to customize the integration for different HR scenarios.


1. **Determine if users exist or need to be provisioned into Windows Server AD.** <!-- -->  <!--The organization may or may not have existing users in SAP cloud directory services, or AD or AAD users, that correspond to their SuccessFactors workers. -->
1. **Determine if you will be using Microsoft Entra ID to provision to SAP Cloud Identity Services, or using SAP Cloud Identity Services to read from Microsoft Entra ID.** For more information on Microsoft Entra provisioning capabilities, see [Automate user provisioning and deprovisioning to SAP Cloud Identity Services with Microsoft Entra ID](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md). SAP Cloud Identity Services also has its own separate connector to read users and groups from Microsoft Entra ID. For more information, see [SAP Cloud Identity Services - Identity Provisioning - Microsoft Entra ID as a source system](https://help.sap.com/docs/identity-provisioning/identity-provisioning/microsoft-azure-active-directory).
1. **SAP ECC.** <!-- -->
1. **Credential** <!-- -->

### Ensure organizational prerequisites are met before configuring Microsoft Entra ID

Before you begin the process of provisioning business-critical application access from Microsoft Entra ID, you should check your Microsoft Entra environment is appropriately configured.

1. **Ensure your Microsoft Entra ID and Microsoft Online Services environment is ready for the [compliance requirements](~/standards/standards-overview.md) for the applications**. Compliance is a shared responsibility among Microsoft, cloud service providers (CSPs), and organizations.

1. **Ensure your Microsoft Entra ID tenant is properly licensed**. To use Microsoft Entra ID to automate provisioning, your tenant must have as many [Microsoft Entra ID P1 or P2 license](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing) as there are workers that will be sourced from the source HR application or member (non-guest) users that will be provisioned. In addition, use of [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md) and other Microsoft Entra ID Governance features such as Microsoft Entra entitlement management auto-assignment policies in the provisioning process requires a [Microsoft Entra ID Governance license](~/id-governance/licensing-fundamentals.md) in your tenant, either **Microsoft Entra ID Governance** and its prerequisite, Microsoft Entra ID P1, or **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2** and its prerequisite, either Microsoft Entra ID P2 or Enterprise Mobility + Security (EMS) E5.

1. **Check that Microsoft Entra ID is already sending its audit log, and optionally other logs, to Azure Monitor.** Azure Monitor is optional, but useful for governing access to apps, as Microsoft Entra only stores audit events for up to 30 days in its audit log. You can keep the audit data for longer than this default retention period, outlined in [How long does Microsoft Entra ID store reporting data?](~/identity/monitoring-health/reference-reports-data-retention.md), and use Azure Monitor workbooks and custom queries and reports on historical audit data. You can check the Microsoft Entra configuration to see if it's using Azure Monitor, in **Microsoft Entra ID** in the Microsoft Entra admin center, by clicking on **Workbooks**. If this integration isn't configured, and you have an Azure subscription and are in the `Global Administrator` or `Security Administrator` roles, you can [configure Microsoft Entra ID to use Azure Monitor](~/id-governance/entitlement-management-logs-and-reporting.md).

1. **Make sure only authorized users are in the highly privileged administrative roles in your Microsoft Entra tenant.** Administrators in the *Global Administrator*, *Identity Governance Administrator*, *User Administrator*, *Application Administrator*, *Cloud Application Administrator*, and *Privileged Role Administrator* can make changes to users and their application role assignments. If the memberships of those roles haven't yet been recently reviewed, you need a user who is in the *Global Administrator* or *Privileged Role Administrator* to ensure that [access review of these directory roles](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) are started. You should also ensure that users in Azure roles in subscriptions that hold the Azure Monitor, Logic Apps, and other resources needed for the operation of your Microsoft Entra configuration have been reviewed.

1. **Check your tenant has appropriate isolation.** If your organization is using Active Directory on-premises, and these AD domains are connected to Microsoft Entra ID, then you need to ensure that highly privileged administrative operations for cloud-hosted services are isolated from on-premises accounts. Check that you've [configured to protect your Microsoft 365 cloud environment from on-premises compromise](~/architecture/protect-m365-from-on-premises-attacks.md).

1. **Evaluate your environment against the Security best practices.** Review the [Best practices for all isolation architectures](../../architecture/secure-best-practices.md) to evaluate how to secure your Microsoft Entra ID tenant.

1. **Document the token lifetime and application's session settings.** In this guide, you will be integrating SAP applications with Microsoft Entra with federated single sign-on. How long a user who has been denied continued access can continue to use a federated application depends upon the application's own session lifetime, and on the access token lifetime. The session lifetime for an application depends upon the application itself. To learn more about controlling the lifetime of access tokens, see [configurable token lifetimes](~/identity-platform/configurable-token-lifetimes.md).

### Confirm the SAP Cloud Identity Services have the necessary schema mappings for your applications

Each of your organization's SAP applications may have have their own requirements that users of those applications have certain attributes populated when they are being provisioned into the application. If you are using SAP Cloud Identity Services to provision to SAP S/4HANA or other SAP applications, then you will need to ensure that SAP Cloud Identity Services has the mappings to send these attributes from Microsoft Entra ID through SAP Cloud Identity Services into those applications. If you are not using SAP Cloud Identity Services, then continue at the next section.

1. **Ensure your SAP cloud directory has the user schema required by your SAP cloud applications.**  <!-- 1.1 Ensure your SAP cloud directory has the user schema required by your SAP apps. [SAP, TBD] -->

1. **Ensure your HR source has the worker schema able to supply the required schema for those SAP cloud applications.** <!--1.2 Ensure your SuccessFactors has the worker schema required by your SAP apps. [SAP, TBD]-->

1. **Record the required schema for Microsoft Entra to supply to SAP cloud applications.** <!-- -->

1. **Record the required schema for correlation between Microsoft Entra ID and your systems of record.** <!-- -->

### Confirm that necessary BAPIs for SAP ECC are ready for use by Microsoft Entra

The Microsoft Entra provisioning agent and generic web services connector provides connectivity to on-premises SOAP endpoints, including SAP BAPIs.

If you are not using SAP ECC, and are only provisioning to SAP cloud services, then continue at the next section.

1. **Confirm the BAPIs needed for provisioning are published.** Expose the necessary APIs in SAP ECC NetWeaver 7.51 to create, update, and delete users. The [Connectors for Microsoft Identity Manager 2016](https://www.microsoft.com/download/details.aspx?id=51495) file named `Deploying SAP NetWeaver AS ABAP 7.pdf` walks through how you can expose the necessary APIs.

1. **Record the required schema for Microsoft Entra to supply to SAP BAPIs.** <!-- -->

### Document the end to end attribute flow

<!-- Decide on the location for attribute transformations -->



### Prepare to issue new authentication credentials

<!-- -->


1. **Verify users are ready for Microsoft Entra multifactor authentication.** We recommend requiring Microsoft Entra multifactor authentication for business critical applications integrated via federation. For these applications, there should be a policy that requires the user to have met a multifactor authentication requirement prior to Microsoft Entra ID permitting them to sign into the application. Some organizations may also block access by locations, or [require the user to access from a registered device](~/identity/conditional-access/howto-conditional-access-policy-compliant-device.md). If there's no suitable policy already that includes the necessary conditions for authentication, location, device, and TOU, then [add a policy to your Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md).

## Deploy Microsoft Entra integrations

In this section you will:
* Bring the necessary users into Microsoft Entra ID and have a process to keep those users up-to-date with appropriate credentials.
  :::image type="content" source="media/plan-sap-source-and-target/inbound-data-preparation.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to bringing in data about workers to Microsoft Entra ID." lightbox="media/plan-sap-source-and-target/inbound-data-preparation.png":::

* Provision users and their access rights to applications and enable them to sign in to those applications.
  :::image type="content" source="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png":::

### Update the Windows Server AD user schema

If you will be provisioning users into Windows Server AD as well as into Microsoft Entra ID, then you will need to ensure that your Windows Server AD environment and associated Microsoft Entra agents are ready to transport users into and out of Windows Server AD with the necessary schema for your SAP applications.

If you do not use Windows Server AD, then continue at the next section.

1. **Extend the Windows Server AD schema, if needed.** <!-- 1.3 For each user attribute required by 1.1 not already part of the AD User schema, either select a built-in AD schema extension or extend the AD schema for that attribute. WS AD (AD PSh?)  -->
1. **Confirm any existing Windows Server AD users have necessary attributes for correlation with the HR source.** <!-- 1.4 Ensure that any user already in AD representing a worker has the ‘join key’ attributes of SuccessFactors from 1.2 populated so that they will be correlated during HR initial inbound and there won’t be duplicate users created. WS AD (AD PSh?)  -->
1. **If you are using Microsoft Entra Connect sync, configure mappings from the Windows Server AD schema to the Microsoft Entra ID user schema.** <!-- 1.5 [If you are using Azure AD Connect ] Ensure all attributes from 1.3 are configured to be provisioned into Entra ID. (This will extend the Entra ID user schema automatically) AADC UI  -->
1. **If you are using Microsoft Entra Connect cloud sync, extend the Microsoft Entra ID schema and configure the mappings from the Windows Server AD schema.** <!-- 1.6 [If you are using Cloud Sync] For each user attribute required by 1.1 not already part of the Entra ID user schema, extend the Entra ID user schema with additional attributes. Graph PSh  --><!-- 1.7 [If you are using Cloud Sync] configure the Cloud Sync mapping Entra ; ?  -->
1. **Wait for synchronization from Windows Server AD to Microsoft Entra ID to complete.** If you have made changes to the mappings to provision more attributes from Windows Server AD, then wait until those changes for the users have made their way from Windows Server AD to Microsoft Entra ID, so that the Microsoft Entra ID representation of the users have the complete set of attributes from WIndows Server AD. If you are using Microsoft Entra Connect cloud sync, you can monitor the `steadyStateLastAchievedTime` of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal representing cloud sync. If you do not have the service principal ID, see [view the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema).
 <!-- 1.8 Ensure that any sync from WS AD to Entra ID (with any changes you made to users in AD in step 1.4) have completed.  ?  -->

### Update the Microsoft Entra ID user schema

If you are using Windows Server AD, then you will have already extended the Microsoft Entra ID user schema as part of configuring mappings from Windows Server AD. If so, then continue at the next section.

If you do not use Windows Server AD, then follow the steps in this section to extend the Microsoft Entra ID user schema.

1. **Create an application to hold the Microsoft Entra schema extensions.** For tenants which are not synchronized from Windows Server AD, schema extensions must be part of a new application. If you have not already done so, create an application to represent schema extensions. This application will not have any users assigned to it.
1. **Extend the Microsoft Entra ID user schema.** Create directory schema extensions for each attribute required by the SAP applications which are not already part of the Microsoft Entra ID user schema. These will provide a way for Microsoft Entra to store more data about users. You can extend the schema by [creating an extension attribute](user-provisioning-sync-attributes-for-mapping.md#create-an-extension-attribute-in-a-tenant-with-cloud-only-users). <!-- 1.6  -->

### Ensure users in Microsoft Entra ID can be correlated with worker records in the HR source

1. **Ensure that any user already in Microsoft Entra ID representing a worker can be correlated.** <!-- 1.9 Ensure that any user already in Entra ID representing a worker has the ‘join key’ attributes of SuccessFactors from 1.2 populated so that they will be correlated during HR initial inbound and there won’t be duplicate users created. Is there Graph PSh script for this? -->

### Set up the prerequisites for identity governance features

If you have identified a need for a Microsoft Entra ID governance capability, such as Microsoft Entra entitlement management or Microsoft Entra lifecycle workflows, then deploy those features before bringing in additional workers as users.

1. **Upload the terms of use (TOU) document, if needed.** If you require users to accept a term of use (TOU) prior to accessing the application, then create and [upload the TOU document](~/identity/conditional-access/terms-of-use.md) so that it can be included in a Conditional Access policy.

1. **Create a catalog, if needed.** By default, when an administrator first interacts with Microsoft Entra entitlement management, then a default catalog is automatically created. However, access packages for governed applications should be in a designated catalog. To create a catalog in the Microsoft Entra admin center, follow the steps in the section [Create a catalog](../../id-governance/entitlement-management-catalog-create.md#create-a-catalog). To create a catalog using PowerShell, follow the steps in the sections [Authenticate to Microsoft Entra ID](../../id-governance/entitlement-management-access-package-create-app.md#authenticate-to-microsoft-entra-id) and [Create a catalog](../../id-governance/entitlement-management-access-package-create-app.md#create-a-catalog-in-microsoft-entra-entitlement-management).

### Connect users in Microsoft Entra ID to worker records from the HR source

This section illustrates how to integrate Microsoft Entra ID with SAP SuccessFactors as the HR source.

1. **Configure the system of record with a service account and grant appropriate permissions for Microsoft Entra ID.** If you are using SAP SuccessFactors, follow the steps in the section [Configuring SuccessFactors for the integration](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#configuring-successfactors-for-the-integration).

1. **Configure inbound mappings from your system of record to Windows Server AD or Microsoft Entra ID.** If you are using SAP SuccessFactors and provisioning users into Windows Server AD as well as Microsoft Entra ID, then follow the steps in the section [Configuring user provisioning from SuccessFactors to Active Directory](../saas-apps/sap-successfactors-inbound-provisioning-tutorial.md#configuring-user-provisioning-from-successfactors-to-active-directory). If you are using SAP SuccessFactors and not provisioning into Windows Server AD, then follow the steps in the section [Configuring user provisioning from SuccessFactors to Microsoft Entra ID](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#configuring-user-provisioning-from-successfactors-to-microsoft-entra-id). <!--1.10 Configure the SuccessFactors inbound mapping of the worker schema from 1.2 to either the AD schema of 1.3 or the Entra ID schema of 1.6. -->

1. **Perform the initial inbound provisioning from the system of record.** If you are using SAP SuccessFactors and provisioning users into Windows Server AD as well as Microsoft Entra ID, then follow the steps in the section [Enable and launch provisioning](../saas-apps/sap-successfactors-inbound-provisioning-tutorial.md#enable-and-launch-user-provisioning). If you are using SAP SuccessFactors and not provisioning into Windows Server AD, then follow the steps in the section [Enable and launch provisioning](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#enable-and-launch-user-provisioning). 

1. **Wait for the initial sync from the system of record is complete.** If you are synching from SAP SuccessFactors to Windows Server AD, or to Microsoft Entra ID, then once the initial sync to that directory is completed, Microsoft Entra will audit summary report in the **Provisioning** tab of the SAP SuccessFactors application in the Microsoft Entra admin center, as shown below.

   > [!div class="mx-imgBorder"]
   > ![Provisioning progress bar](../saas-apps/media/sap-successfactors-inbound-provisioning/prov-progress-bar-stats.png)


1. **If provisioning into Windows Server AD, wait for the new users created in Windows Server AD, or those updated in Windows Server AD, to be synchronized from Windows Server AD to Microsoft Entra ID.** Wait until changes for the users in Windows Server AD have made their way to Microsoft Entra ID, so that the Microsoft Entra ID representation of the users have the complete set of users and their attributes from Windows Server AD. If you are using Microsoft Entra Connect cloud sync, you can monitor the `steadyStateLastAchievedTime` of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal representing cloud sync. If you do not have the service principal ID, see [view the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema). <!--1.11 -->

1. **Ensure that the users have been provisioned into Microsoft Entra ID**. <!--1.12 Ensure that Entra ID has the right users for the workers in SuccessFactors and they are populated with the attributes required by SAP cloud directory in 1.1. -->

1. **Ensure there are no unexpected uncorrelated accounts in Microsoft Entra ID.** <!--Ensure there are no users in Entra ID who do not correspond to SuccessFactors workers because they are orphan accounts. Is there Graph PSh script for this? -->

### Provision users and their access rights to applications and enable them to sign in to those applications

Now that the users exist in Microsoft Entra ID, in the next sections you'll provision them to the target applications.

:::image type="content" source="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram showing Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-source-and-target/outbound-provisioning-and-sso.png":::

### Provision users to SAP Cloud Identity Services

The steps in this section configure provisioning from Microsoft Entra ID to SAP Cloud Identity Services. By default, you will set up Microsoft Entra ID to automatically provision and deprovision users to SAP Cloud Identity Services, so that those users can authenticate to SAP Cloud Identity Services and have access to other SAP workloads integrated with SAP Cloud Identity Services. SAP Cloud Identity Services supports provisioning from its local identity directory to other SAP applications as [target systems](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-systems).

Alternatively, you can configure SAP Cloud Identity Services to read from Microsoft Entra ID. If you will be using SAP Cloud Identity Services to read from Microsoft Entra ID, follow the SAP guidance on how to configure SAP Cloud Identity Services, then continue at the next section of this article.

If you are not using SAP Cloud Identity Services, then continue at the next section of this article.

1. **Ensure that you have [a SAP Cloud Identity Services tenant](https://www.sap.com/products/cloud-platform.html) with a user account in SAP Cloud Identity Services with Admin permissions.**

1. **Set up SAP Cloud Identity Services for provisioning.** Sign into your SAP Cloud Identity Services Admin Console and follow the steps in the section [Set up SAP Cloud Identity Services for provisioning](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#set-up-sap-cloud-identity-services-for-provisioning).

1. **Add SAP Cloud Identity Services from the gallery and configure automatic user provisioning to SAP Cloud Identity Services.** Follow the steps in the sections [Add SAP Cloud Identity Services from the gallery](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#add-sap-cloud-identity-services-from-the-gallery) and [Configure automatic user provisioning to SAP Cloud Identity Services](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#configure-automatic-user-provisioning-to-sap-cloud-identity-services).

1. **Provision a test user from Microsoft Entra ID to SAP Cloud Identity Services.** Validate that provisioning integration is ready by following the steps in the section [Provision a new test user from Microsoft Entra ID to SAP Cloud Identity Services](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#provision-a-new-test-user-from-microsoft-entra-id-to-sap-cloud-identity-services).

1. **Ensure existing users in both Microsoft Entra and SAP Cloud Identity Services can be correlated.** Follow the steps in the sections [Ensure existing SAP Cloud Identity Services users have the necessary matching attributes](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-sap-cloud-identity-services-users-have-the-necessary-matching-attributes) and [Ensure existing Microsoft Entra users have the necessary attributes](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-microsoft-entra-users-have-the-necessary-attributes) to compare the users in Microsoft Entra ID with those already in SAP Cloud Identity Services. <!-- 1.13 -->

1. **Assign existing users of SAP Cloud Identity Services to the application in Microsoft Entra ID.**. Follow the steps in the section [Assign users to the SAP Cloud Identity Services application in Microsoft Entra ID](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#assign-users-to-the-sap-cloud-identity-services-application-in-microsoft-entra-id). In those steps you will address any provisioning issues so that provisioning is not quarantined, check for users who are present in SAP Cloud Identity Services and are not already assigned to the application in Microsoft Entra ID, assign the remaining users and monitor initial sync.

1. **Wait for synchronization from Microsoft Entra ID to SAP Cloud Identity Services.** Wait until all the users that were assigned to the application have been provisioned. An initial cycle takes between 20 minutes and several hours, depending on the size of the Microsoft Entra directory and the number of users in scope for provisioning. You can monitor the `steadyStateLastAchievedTime` of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal representing SAP Cloud Identity Services. <!-- 1.15  -->

1. **Check for provisioning errors.** Check the provisioning log through the [Microsoft Entra admin center](~/identity/monitoring-health/concept-provisioning-logs.md) or [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-provisioning-events-using-the-provisioning-logs). Filter the log to the status **Failure**. If there are failures with an ErrorCode of **DuplicateTargetEntries**, this indicates an ambiguity in your provisioning matching rules, and you'll need to update the Microsoft Entra users or the mappings that are used for matching to ensure each Microsoft Entra user matches one application user. Then filter the log to the action **Create** and status **Skipped**. If users were skipped with the SkipReason code of **NotEffectivelyEntitled**, this may indicate that the user accounts in Microsoft Entra ID were not matched because the user account status was **Disabled**.

1. **Compare the users in SAP Cloud Identity Services with those in Microsoft Entra ID.** <!-- 1.16 Ensure that there are no orphan users in SAP cloud directory who are not originating from Entra ID. Export from SAP and PSh -->

1. **Configure federated single sign on from Microsoft Entra to SAP Cloud Identity Services.** Enable SAML-based single sign-on for SAP Cloud Identity Services, following the instructions provided in the [SAP Cloud Identity Services Single sign-on tutorial](../saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial.md). <!-- 1.17 Configure the SAP cloud directory federated SSO mapping. Entra > app for SAP cloud directory > SSO -->

1. **Bring the application web endpoint into scope of the appropriate Conditional Access policy**. If you have an existing Conditional Access policy that was created for another application subject to the same governance requirements, you could update that policy to have it apply to this application as well, to avoid having a large number of policies. Once you have made the updates, check to ensure that the expected policies are being applied. You can see what policies would apply to a user with the [Conditional Access what if tool](~/identity/conditional-access/troubleshoot-conditional-access-what-if.md).

1. **Validate a test user can connect to the SAP applications.** You can use Microsoft My Apps to test the application single-sign on. Ensure a test user has been assigned to the SAP Cloud Identity Services application and provisioned from Microsoft Entra ID to SAP Cloud Identity Services. Then, sign into Microsoft Entra as that user, and visit `myapps.microsoft.com`. When you click the SAP Cloud Identity Services tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow. If configured in IDP mode, you should be automatically signed in to the SAP Cloud Identity Services for which you set up the SSO. <!-- 1.18  -->

### Provision users to SAP ECC

Now that you have the users in Microsoft Entra ID, you can provision them into SAP on-premises.

If you are not using SAP ECC, then continue at the next section.

1. **Configure provisioning.** Follow the instructions in the article [Configure Microsoft Entra ID to provision users into SAP ECC with NetWeaver AS ABAP 7.0 or later](on-premises-sap-connector-configure.md).

1. **Wait for synchronization from Microsoft Entra ID to SAP Cloud Identity Services.** Wait until all the users that were assigned to the application have been provisioned. An initial cycle takes between 20 minutes and several hours, depending on the size of the Microsoft Entra directory and the number of users in scope for provisioning. You can monitor the `steadyStateLastAchievedTime` of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal.

1. **Check for provisioning errors.** Check the provisioning log through the [Microsoft Entra admin center](~/identity/monitoring-health/concept-provisioning-logs.md) or [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-provisioning-events-using-the-provisioning-logs). Filter the log to the status **Failure**. If there are failures with an ErrorCode of **DuplicateTargetEntries**, this indicates an ambiguity in your provisioning matching rules, and you'll need to update the Microsoft Entra users or the mappings that are used for matching to ensure each Microsoft Entra user matches one application user. Then filter the log to the action **Create** and status **Skipped**. If users were skipped with the SkipReason code of **NotEffectivelyEntitled**, this may indicate that the user accounts in Microsoft Entra ID were not matched because the user account status was **Disabled**.

1. **Compare the users in SAP ECC with those in Microsoft Entra ID.** <!-- 1.16 Ensure that there are no orphan users in SAP ECC who are not originating from Entra ID. Export from SAP and PSh -->

1. **Configure federated single sign on from Microsoft Entra to SAP.** Enable SAML-based single sign-on for SAP applications. If you are using SAP NetWeaver, following the instructions provided in the [SAP NetWeaver single sign-on tutorial](../saas-apps/sap-netweaver-tutorial.md). <

1. **Bring the application web endpoint into scope of the appropriate Conditional Access policy**. If you have an existing Conditional Access policy that was created for another application subject to the same governance requirements, you could update that policy to have it apply to this application as well, to avoid having a large number of policies. Once you have made the updates, check to ensure that the expected policies are being applied. You can see what policies would apply to a user with the [Conditional Access what if tool](~/identity/conditional-access/troubleshoot-conditional-access-what-if.md).

1. **Validate a test user can connect to the SAP.**

### Configure provisioning to SuccessFactors other applications

You can configure Microsoft Entra to write specific attributes from Microsoft Entra ID to SAP SuccessFactors Employee Central, including work email. For more information, see [Configure SAP SuccessFactors writeback in Microsoft Entra ID](../saas-apps/sap-successfactors-writeback-tutorial.md).

Microsoft Entra can also provision into many other applications, including those using [standards](~/architecture/auth-sync-overview.md) such as OpenID Connect, SAML, SCIM, SQL, LDAP, SOAP and REST. For more information, see [integrating applications with Microsoft Entra ID](../../id-governance/identity-governance-applications-integrate.md).

### Assign users the necessary application access rights in Microsoft Entra

Unless this is a fully isolated tenant configured specifically for SAP application access, it is unlikely that everyone in the tenant will need access to SAP applications. So the SAP applications in the tenant will be configured that only users with an application role assignment to an application will be provisioned to the application and be able to sign in from Microsoft Entra ID.

As users that are in assigned to the application are updated in Microsoft Entra ID, those changes will be automatically provisioned to the application.

If you have Microsoft Entra ID Governance, you can automate changes to the application role assignments for SAP Cloud Identity Services or SAP ECC in Microsoft Entra ID, to add or remove assignments as people join the organization, or leave or change roles.

1. **Review existing assignments.** Optionally, [perform a one-time access review of the application role assignments](~/id-governance/access-reviews-application-preparation.md). This will remove assignments that are no longer necessary.
1. **Configure the process to keep application role assignments up to date.** If you are using Microsoft Entra entitlement management, then follow the steps in the article [Create an access package in entitlement management for an application with a single role using PowerShell](../../id-governance/entitlement-management-access-package-create-app.md) to configure assignments to the application representing SAP cloud identity services or SAP ECC. In that access package, you can have policies for users to be assigned access, either when they request, [by an administrator](~/id-governance/entitlement-management-access-package-assignments.md#directly-assign-a-user), [automatically based on rules](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md), or through [lifecycle workflows](~/id-governance/entitlement-management-scenarios.md#administrator-assign-employees-access-from-lifecycle-workflows).

If you do not have Microsoft Entra ID Governance, then you can [assign each individual user to the application](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) in the Microsoft Entra admin center, and you can assign individual users to the application via PowerShell cmdlet `New-MgServicePrincipalAppRoleAssignedTo`.

### Distribute credentials to newly-created Microsoft Entra users or Windows Server AD users

At this point, all users will be present in Microsoft Entra ID and provisioned to the relevant SAP applications. Any users that were created during this process, for workers that were not previously present in Windows Server AD or Microsoft Entra ID, will have new credentials.

<!-- -->

1. **Create a recurring access review if any users will need temporary policy exclusions**. In some cases, it may not be possible to immediately enforce Conditional Access policies for every authorized user. For example, some users may not have an appropriate registered device. If it's necessary to exclude one or more users from the Conditional Access policy and allow them access, then configure an access review for the group of [users who are excluded from Conditional Access policies](~/id-governance/conditional-access-exclusion.md).
 
## Monitor identity flows

You can use automation in Microsoft Entra to monitor ongoing provisioning from the authoritative systems of records to the target applications.

### Monitoring inbound provisioning

<!-- -->

### Monitoring changes in Windows Server AD

As described in [Windows Server audit policy recommendations](/windows-server/identity/ad-ds/plan/security-best-practices/audit-policy-recommendations), ensure that *User Account Management* success audit events are enabled on all domain controllers, and collected for analysis.

### Monitoring application role assignments

If you have configured Microsoft Entra ID to [send audit events to Azure Monitor](../../id-governance/entitlement-management-logs-and-reporting.md), then you can use Azure Monitor workbooks to get insights on how users have been receiving their access.

* If you are using Microsoft Entra entitlement management, the workbook named *Access Package Activity* displays each event related to a particular access package.

    ![View access package events](../../id-governance/media/entitlement-management-logs-and-reporting/view-events-access-package.png)

* To see if there have been changes to application role assignments for an application that weren't created due to access package assignments, then you can select the workbook named *Application role assignment activity*. If you select to omit entitlement activity, then only changes to application roles that weren't made by entitlement management are shown. For example, you would see a row if a global administrator had directly assigned a user to an application role.

    ![View app role assignments](../../id-governance/media/entitlement-management-access-package-incompatible/workbook-ara.png)

### Monitoring outbound provisioning

For each application integrated with Microsoft Entra, you can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on the application. You can also monitor the provisioning project via the Microsoft [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-the-provisioning-job-status).

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

### Monitoring single sign-on

<!-- -->

* You can view the last 30 days of sign-ins to an application in the [sign-ins report](~/identity/monitoring-health/concept-sign-in-log-activity-details.md) in the Microsoft Entra admin center, or via [Graph](/graph/api/signin-list?view=graph-rest-1.0&tabs=http&preserve-view=true).
* You can also send the [sign in logs to Azure Monitor](~/identity/monitoring-health/concept-log-monitoring-integration-options-considerations.md) to archive sign in activity for up to two years.

### Monitoring assignments in Microsoft Entra ID Governance

If you are using Microsoft Entra ID Governance, then you can report on how users are getting access using Microsoft Entra ID Governance features.

* An administrator, or a catalog owner, can [retrieve the list of users who have access package assignments](~/id-governance/entitlement-management-access-package-assignments.md), via the Microsoft Entra admin center, Microsoft Graph, or PowerShell.
* You can also send the audit logs to Azure Monitor and view a history of [changes to the access package](~/id-governance/entitlement-management-logs-and-reporting.md#view-events-for-an-access-package), in the Microsoft Entra admin center, or via PowerShell.
* For more information on these and other identity governance scenarios, see how to [monitor to adjust entitlement management policies and access as needed](~/id-governance/identity-governance-applications-deploy.md#monitor-to-adjust-entitlement-management-policies-and-access-as-needed).

## Next steps

- [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)
- [Govern access by migrating an organizational role model to Microsoft Entra ID Governance](~/id-governance/identity-governance-organizational-roles.md)
- [Define organizational policies for governing access to other applications in your environment](~/id-governance/identity-governance-applications-define.md)
- [Using Microsoft Entra ID to secure access to SAP platforms and applications](~/fundamentals/scenario-azure-first-sap-identity-integration.md)
- [Explore the foundations of identity and governance for SAP on Azure](/training/paths/explore-foundations-of-identity-governance/)

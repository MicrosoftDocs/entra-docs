---
title: Plan deploying Microsoft Entra for user provisioning with SAP source and target apps
description: Learn how to bring identities from SAP SuccessFactors and other sources into Microsoft Entra ID and give them access to SAP ECC, SAP S/4HANA, and other apps.
author: markwahl-msft
manager: dougeby
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/04/2025
ms.author: mwahl
ms.reviewer: mwahl
---

# Plan deploying Microsoft Entra for user provisioning with SAP source and target apps

Your organization relies on Microsoft for various Azure services or Microsoft 365. SAP software and services might also provide critical functions, such as human resources (HR) and enterprise resource planning (ERP) for your organization. You can use Microsoft Entra to orchestrate the identities for your employees, contractors, and others, and their access, across your SAP and non-SAP applications.

This tutorial shows how you can use Microsoft Entra features to manage identities across your SAP applications based on properties of those identities originating from SAP HR sources. This tutorial assumes that:

* Your organization has a Microsoft Entra tenant in the commercial cloud with a license for at least Microsoft Entra ID P1 in that tenant. (Some steps also illustrate using Microsoft Entra ID Governance features.)
* You're an administrator of that tenant.
* Your organization has a system of record source of workers, which is SAP SuccessFactors.
* Your organization has SAP ERP Central Component (ECC), SAP S/4HANA, other SAP applications, SAP BTP-based applications, and optionally has other non-SAP applications.
* You're using SAP Cloud Identity Services for provisioning and single sign-on (SSO) to any SAP applications other than SAP ECC.

## Overview

This tutorial illustrates how to connect Microsoft Entra with authoritative sources for the list of workers in an organization, such as SAP SuccessFactors. It also shows you how to use Microsoft Entra to set up identities for those workers. Then you learn how to use Microsoft Entra to provide workers with access to sign in to one or more SAP applications, such as SAP ECC or SAP S/4HANA.

The process is:

 - **Plan**: Define the requirements for identities and access for applications in your organization. Ensure that Microsoft Entra ID and related Microsoft Online Services meet the organizational prerequisites for this scenario.
 - **Deploy**: Bring the necessary users into Microsoft Entra ID and have a process to keep those users up to date with appropriate credentials. Assign users with the necessary access rights in Microsoft Entra. Provision those users and their access rights to applications to enable them to sign in to those applications.
 - **Monitor**: Monitor the identity flows to watch for errors and adjust policies and operations, as needed.

After the process is finished, individuals can sign in to SAP and non-SAP applications that they're authorized to use with Microsoft Entra user identities.

The following diagram depicts the example topology used in this tutorial. In this topology, workers are represented in SuccessFactors and need to have accounts in a Windows Server Active Directory (Windows Server AD) domain, in Microsoft Entra, SAP ECC, and SAP cloud applications. This tutorial illustrates an organization that has a Windows Server AD domain. However, Windows Server AD isn't required for this tutorial.

:::image type="content" source="media/plan-sap-user-source-and-target/end-to-end-integrations.png" alt-text="Diagram that shows the end-to-end breadth of relevant Microsoft and SAP technologies and their integrations." lightbox="media/plan-sap-user-source-and-target/end-to-end-integrations.png":::

This tutorial focuses on the identity lifecycle for users who represent employees and other workers. Identity lifecycle for guests and the access lifecycle for role assignments, requests, and reviews are outside the scope of this tutorial.

## Plan the integrations with SAP sources and targets

In this section, you define the requirements for identities and access for applications in your organization. This section highlights the key decisions needed for integration with SAP applications. For non-SAP applications, you can also [define organizational policies for governing access to those applications](~/id-governance/identity-governance-applications-define.md).

If you've been using SAP IDM, then you can migrate your identity management scenarios from SAP IDM to Microsoft Entra. For more information, see [Migrate identity management scenarios from SAP IDM to Microsoft Entra](~/identity/app-provisioning/migrate-from-sap-idm.md).

### Determine the sequence of application onboarding and how applications integrate with Microsoft Entra

Maybe your organization already integrated some applications with Microsoft Entra for a subset of the available integration scenarios. For example, perhaps you integrated SAP Cloud Identity Services with Microsoft Entra for SSO to gain the benefit of Conditional Access, but you're still relying on manual provisioning and deprovisioning. Or, you might have applications such as SAP ECC in your organization that you haven't yet integrated with Microsoft Entra.

1. **Establish a priority order for applications to be integrated with Microsoft Entra for SSO and for provisioning.** Organizations generally start integrating with software as a service (SaaS) applications that support modern protocols. For SAP applications, we recommend that organizations that have SAP cloud applications start their integrations with the SSO and provisioning integrations with SAP Cloud Identity Services as middleware. Here, a user provisioning and SSO integration to Microsoft Entra can benefit multiple SAP applications.

1. **Confirm how each application integrates with Microsoft Entra.** If your application is listed as one of the [SAP Cloud Identity Services provisioning target systems](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-systems), such as SAP S/4HANA, or uses SAP BTP, you can use SAP Cloud Identity Services as middleware to bridge SSO and provisioning from Microsoft Entra to the application. If your application is SAP ECC, you can integrate Microsoft Entra directly with SAP NetWeaver for SSO and to Business Application Programming Interfaces (BAPIs) of SAP ECC for provisioning.

   For non-SAP applications, follow the instructions in [Integrate the application with Microsoft Entra ID](../../id-governance/identity-governance-applications-integrate.md#integrate-the-application-with-microsoft-entra-id-to-ensure-only-authorized-users-can-access-the-application) to determine the supported integration technologies for SSO and provisioning for each of your applications.

1. **Collect the roles and permissions that each application provides.** Some applications have only a single role. For example, SAP Cloud Identity Services has only one role, **User**, which is available for assignment. SAP Cloud Identity Services can read groups from Microsoft Entra ID for use in application assignment. Other applications might surface multiple roles to be managed through Microsoft Entra ID. These application roles typically make broad constraints on the access that a user with that role has within the app.

   Other applications might also rely on group memberships or claims for finer-grained role checks. They can be provided to each application from Microsoft Entra ID in provisioning or claims issued by using federation SSO protocols. They can also be written to Active Directory as a security group membership.

   > [!Note]
   > If you're using an application from the Microsoft Entra application gallery that supports provisioning, Microsoft Entra ID might import defined roles in the application and automatically update the application manifest with the application's roles automatically, after provisioning is configured.

1. **Select which roles and groups have membership that are to be governed in Microsoft Entra ID.** Based on compliance and risk management requirements, organizations often prioritize those application roles or groups that give privileged access or access to sensitive information. Although this tutorial doesn't include the steps for configuring access assignment, you might need to identify the roles and groups that are relevant to ensure that all their members are provisioned to the applications.

### Define the organization's policy with user prerequisites and other constraints for access to an application

In this section, you determine the organizational policies you plan to use to determine access to each application.

1. **Identify if there are prerequisite requirements or standards that a user must meet before they're given access to an application.** Organizations with compliance requirements or risk management plans have sensitive or business-critical applications. Perhaps you already documented the access policies for who should have access to those applications, prior to their integration with Microsoft Entra ID. If not, you might need to consult with stakeholders like compliance and risk management teams. You need to ensure that the policies used to automate access decisions are appropriate for your scenario.

   For example, under normal circumstances, only full-time employees, or employees in a specific department or cost center, should by default have access to a particular department's application. If you're using Microsoft Entra entitlement management in Microsoft Entra ID Governance, you might choose to configure the entitlement management policy for a user from some other department who's requesting access to have one or more approvers so that those users can get access via exception.

   In some organizations, requests for access by an employee might have two stages of approval. The first stage is by requesting the user's manager. The second stage is by requesting one of the resource owners responsible for data held in the application.

1. **Decide how long a user who was approved for access should have access and when that access should go away.** For many applications, a user might retain access indefinitely until they're no longer affiliated with the organization. In some situations, access might be tied to particular projects or milestones so that when the project ends, access is removed automatically. Or, if only a few users are using an application through a policy, you might configure quarterly or yearly reviews of everyone's access through the policy so that there's regular oversight. These scenarios require Microsoft Entra ID Governance.

1. **If your organization is already governing access with an organizational role model, plan to bring that organizational role model into Microsoft Entra ID.** You might have an [organizational role model](~/id-governance/identity-governance-organizational-roles.md) defined that assigns access based on a user's property, such as their position or department. These processes can ensure that users lose access eventually when access is no longer needed, even if there isn't a predetermined project end date.

   If you already have an organization role definition, you can [migrate organizational role definitions](~/id-governance/identity-governance-organizational-roles.md) to Microsoft Entra ID Governance.

1. **Inquire if there are constraints based on separation of duties.** This tutorial focuses on identity lifecycle to provide a user with basic access to applications. However, when you plan application onboarding, you can identify constraints based on separation of duties to be enforced.

   For example, suppose there's an application with two app roles, Western Sales and Eastern Sales. You want to ensure that a user has only one sales territory role at a time. Include a list of any pairs of app roles that are incompatible for your application. Then if a user has one role, they aren't allowed to request the second role. Microsoft Entra entitlement management incompatibility settings on access packages can enforce these constraints.

1. **Select the appropriate Conditional Access policy for access to each application.** We recommend that you analyze your applications and organize them into collections of applications that have the same resource requirements for the same users.

   The first time you integrate a federated SSO application with Microsoft Entra ID, you might need to create a new Conditional Access policy to express constraints. You might need to enforce requirements for multifactor authentication (MFA) or location-based access for that application and subsequent applications. You can also configure in Conditional Access that users must agree to [terms of use](~/identity/conditional-access/policy-all-users-require-terms-of-use.md).

   For more considerations on how to define a Conditional Access policy, see [Plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md).

1. **Decide how exceptions to your criteria should be handled.** For example, an application might typically only be available for designated employees, but an auditor or vendor might need temporary access for a specific project. Or, an employee who's traveling might require access from a location that's normally blocked because your organization has no presence in that location.

   In these situations, if you have Microsoft Entra ID Governance, you might choose to also have an entitlement management policy for approval that has different stages, a different time limit, or a different approver. A vendor who's signed in as a guest user in your Microsoft Entra tenant might not have a manager. Instead, a sponsor for their organization, a resource owner, or a security officer could approve their access requests.

### Decide on the provisioning and authentication topology

Now that you've determined the applications to integrate with Microsoft Entra for user provisioning and SSO, decide on the data flow for how user identities and their attributes are provided to those applications, based on data originating from authoritative system of record sources.

1. **Select the authoritative sources for each identity and their attributes.** This tutorial assumes SuccessFactors is the authoritative system of record source for the users who need access to SAP applications. Configuring cloud HR-driven user provisioning from SuccessFactors to Microsoft Entra ID requires planning that covers different aspects. These factors include determining the matching ID and defining attribute mappings, attribute transformation, and scoping filters.

   For comprehensive guidelines on these subjects, refer to the [cloud HR deployment plan](~/identity/app-provisioning/plan-cloud-hr-provision.md). To learn about the supported entities, processing details, and how to customize the integration for different HR scenarios, refer to the [SAP SuccessFactors integration reference](~/identity/app-provisioning/sap-successfactors-integration-reference.md). You might also have other authoritative sources for other identities, and some identities, such as break-glass accounts or other IT administrators, that have Microsoft Entra ID as their authoritative source.
1. **Decide if users exist or need to be provisioned into Windows Server AD in addition to Microsoft Entra ID.** You might already have existing users in Windows Server AD, which correspond to your workers in your authoritative HR source. Or perhaps you configured SAP ECC or other applications to rely on Windows Server via Lightweight Directory Access Protocol (LDAP) or Kerberos. In these situations, you provision users into Windows Server AD. These users are then synchronized into Microsoft Entra ID.
1. **Design the Microsoft Entra Connect provisioning agent deployment topology.** If you are using SuccessFactors and have Windows Server AD, then you will need to install the provisioning agent to provision users into those domains. The Microsoft Entra Connect provisioning agent deployment topology depends on the number of cloud HR app tenants and Active Directory child domains that you plan to integrate. If you have multiple Active Directory domains, it depends on whether the Active Directory domains are contiguous or [disjoint](/windows-server/identity/ad-ds/plan/disjoint-namespace). For more information, see [Design the Microsoft Entra Connect provisioning agent deployment topology](plan-cloud-hr-provision.md#design-the-microsoft-entra-connect-provisioning-agent-deployment-topology).
1. **Determine if you will be using multiple containers in Windows Server AD.** If you are using SuccessFactors and have Windows Server AD, then in each domain you will need to determine whether the users representing workers are organized into a container hierarchy. Some organizations may create all the users representing employees in a single `organizationalUnit`; other organizations may have multiple. For more information, see [configure Active Directory OU container assignment](plan-cloud-hr-provision.md#configure-active-directory-ou-container-assignment).
1. **Decide if you want to use Microsoft Entra ID to provision to SAP Cloud Identity Services or use SAP Cloud Identity Services to read from Microsoft Entra ID.** For more information on Microsoft Entra provisioning capabilities, see [Automate user provisioning and deprovisioning to SAP Cloud Identity Services with Microsoft Entra ID](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md). SAP Cloud Identity Services also has its own separate connector to read users and groups from Microsoft Entra ID. For more information, see [SAP Cloud Identity Services - Identity Provisioning - Microsoft Entra ID as a source system](https://help.sap.com/docs/identity-provisioning/identity-provisioning/microsoft-azure-active-directory).
1. **Decide if you need to provision users into SAP ECC.** You can provision users from Microsoft Entra ID into SAP ECC (formerly SAP R/3) NetWeaver 7.0 or later. If you're using other versions of SAP R/3, you can still use the guides provided in the [Connectors for Microsoft Identity Manager 2016](https://www.microsoft.com/download/details.aspx?id=51495) download as a reference to build your own template for provisioning.

### Ensure that organizational prerequisites are met before you configure Microsoft Entra ID

Before you begin the process of provisioning business-critical application access from Microsoft Entra ID, make sure that your Microsoft Entra environment is appropriately configured.

1. **Ensure that your Microsoft Entra ID and Microsoft Online Services environment is ready for the** [compliance requirements](~/standards/standards-overview.md) **for the applications.** Compliance is a shared responsibility among Microsoft, cloud service providers, and organizations.

1. **Ensure that your Microsoft Entra ID tenant is properly licensed.** To use Microsoft Entra ID to automate provisioning, your tenant must have as many licenses for [Microsoft Entra ID P1](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing), at a minimum, as there are workers that are sourced from the source HR application or member (nonguest) users that are provisioned.

   In addition, use of [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md) and other Microsoft Entra ID Governance features, such as Microsoft Entra entitlement management automatic assignment policies in the provisioning process, requires [Microsoft Entra ID Governance licenses](~/id-governance/licensing-fundamentals.md) for your workers. These licenses are either Microsoft Entra ID Governance or Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2.

1. **Check that Microsoft Entra ID is already sending its audit log, and optionally other logs, to Azure Monitor.** Azure Monitor is optional but useful for governing access to apps because Microsoft Entra stores audit events only for up to 30 days in its audit log. You can keep the audit data for longer than this default retention period. For more information, see [How long does Microsoft Entra ID store reporting data?](~/identity/monitoring-health/reference-reports-data-retention.md).

   You can also use Azure Monitor workbooks and custom queries and reports on historical audit data. You can check the Microsoft Entra configuration to see if it's using Azure Monitor, in **Microsoft Entra ID** in the Microsoft Entra admin center, by selecting **Workbooks**. If this integration isn't configured and you have an Azure subscription and are at least a Security Administrator, you can [configure Microsoft Entra ID to use Azure Monitor](~/id-governance/entitlement-management-logs-and-reporting.md).

1. **Make sure only authorized users are in the highly privileged administrative roles in your Microsoft Entra tenant.** Administrators who are at least an Identity Governance Administrator, User Administrator, Application Administrator, Cloud Application Administrator, or Privileged Role Administrator can make changes to users and their application role assignments. If you haven't recently reviewed the memberships of those roles, you need a user who's at least a Privileged Role Administrator to ensure that [access review of these directory roles](~/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md) has started.

   You should also review the users in Azure roles in subscriptions that hold the Azure Monitor, Logic Apps, and other resources needed for the operation of your Microsoft Entra configuration.

1. **Check that your tenant has appropriate isolation.** If your organization is using Active Directory on-premises, and these Active Directory domains are connected to Microsoft Entra ID, you need to ensure that highly privileged administrative operations for cloud-hosted services are isolated from on-premises accounts. Make sure that you [configured to protect your Microsoft 365 cloud environment from on-premises compromise](~/architecture/protect-m365-from-on-premises-attacks.md).

1. **Evaluate your environment against the security best practices.** To evaluate how to secure your Microsoft Entra ID tenant, review [Best practices for all isolation architectures](../../architecture/secure-best-practices.md).

1. **Document the token lifetime and application's session settings.** At the end of this tutorial, you integrate SAP ECC or SAP Cloud Identity Services applications with Microsoft Entra for SSO. How long a user who was denied continued access can continue to use a federated application depends on the application's own session lifetime and on the access token lifetime. The session lifetime for an application depends on the application itself. To learn more about controlling the lifetime of access tokens, see [Configurable token lifetimes](~/identity-platform/configurable-token-lifetimes.md).

### Confirm that SAP Cloud Identity Services has the necessary schema mappings for your applications

Each of your organization's SAP applications might have their own requirements that users of those applications have certain attributes populated when they're being provisioned into the application.

If you're using SAP Cloud Identity Services to provision to SAP S/4HANA or other SAP applications, ensure that SAP Cloud Identity Services has the mappings to send these attributes from Microsoft Entra ID through SAP Cloud Identity Services into those applications. If you aren't using SAP Cloud Identity Services, skip to the next section.

1. **Ensure that your SAP cloud directory has the user schema required by your SAP cloud applications.** In SAP Cloud Identity Services, each target system that's configured adds transformations from the data model of the source for identities supplied to SAP Cloud Identity Services to the requirements of the target. You might need to change those transformations in SAP Cloud Identity Services to correspond to how you plan to model identity, especially if you have multiple target systems configured. Then, record the required schema for Microsoft Entra to supply to SAP cloud applications via SAP Cloud Identity Services.

### Define the relationship between worker records in your system of record sources and users in Microsoft Entra

Each attribute required by your applications needs to originate from some source in your organization. Some attributes might have values that are constants or that are transformed from other attributes. Other values might be assigned by a Microsoft online service, such as a user's email address. Other attributes, such as a user's name, department, or other organizational properties, typically originate in an HR system of record that's authoritative. To ensure the right HR records are mapped to users in Microsoft Entra ID, work with your HR and IT teams to ensure data consistency and plan for any data cleansing tasks.

1. **Determine how to map changes in the system of record source to join and leave events.** If you wish to automate processes for worker join and leave, you'll need to correlate the status information of a worker to the attributes in Microsoft Entra. For more information, se [determine user account status](plan-cloud-hr-provision.md#determine-user-account-status).

1. **Ensure that your HR source has the worker schema able to supply the required schema for those SAP applications.** Ensure that each required attribute of a SAP cloud or on-premises application, that doesn't originate in Microsoft Entra or another Microsoft online service, can be tracked to a property available from your source, such as SuccessFactors. If your source doesn't have the required schema, or the attributes aren't populated on one or more identities who will be given access to the applications, or aren't available to Microsoft Entra to read, you must address these schema requirements before you enable provisioning.

1. **Record the schema used for correlation between Microsoft Entra ID and your systems of record.** You might have existing users in Windows Server AD or Microsoft Entra ID that correspond to workers in SAP SuccessFactors. If those users weren't created by Microsoft Entra ID but by some other process, see the [SAP SuccessFactors attribute reference](sap-successfactors-attribute-reference.md) and your Windows Server or Microsoft Entra user schema to select which attributes on the user objects contain a unique identifier for the worker in SAP SuccessFactors.

   This attribute must be present with a unique value on each user that corresponds to a worker so that Microsoft Entra inbound provisioning can determine which users already exist for workers and avoid creating duplicate users.   The default matching attribute is based on Employee ID. Before importing workers from the HR source, you will need to ensure that the value of this attribute, such as employee ID, is populated in Microsoft Entra ID (for cloud-only users) and Windows Server AD (for hybrid users) before initiating full sync and its value uniquely identifies each user. For more information, see [determine matching attributes](plan-cloud-hr-provision.md#determine-matching-attributes) and [generate a unique attribute value](plan-cloud-hr-provision.md#generate-a-unique-attribute-value).

1. **Select scoping filters to skip HR records that are no longer relevant.** HR systems have several years of employment data including workers who have not been employees for years. On the other hand, your IT team may only be interested in the list of currently active employees, new hires, and termination records that come through after go-live. To filter out HR records that are no longer relevant from your IT team perspective, work with your HR team to add flags on the HR record that can be used in the Microsoft Entra provisioning scoping filters. For more information, see [define scoping filters](plan-cloud-hr-provision.md#define-scoping-filters).

1. **Plan for handling special characters which may form a new user's username.** It's a common practice to use the worker's first name and last or family name to create a unique ```userPrincipalName``` for the user. In Windows Server AD and Microsoft Entra ID, the ```userPrincipalName``` does not allow accent characters and only the following characters are allowed `A - Z, a - z, 0 - 9, ' . - _ ! # ^ ~`. Use the function [NormalizeDiacritics](functions-for-customizing-application-data.md#normalizediacritics) to handle accent characters and construct appropriate ```userPrincipalName```.

1. **Plan for handling long strings originating in your HR source.** Check if your HR data has long string values associated with HR fields that you'll use to populate Microsoft Entra ID and Windows Server AD attributes. Every Microsoft Entra ID attribute has a max string length. If the value in the HR field mapped to the Microsoft Entra ID attribute contains more characters, then the attribute update may fail. One option is to review your attribute mapping and check if there is a possibility of truncating/updating long string values in the HR system. If that's not an option, you can either use functions like [Mid](functions-for-customizing-application-data.md#mid) to truncate long strings or you can use functions like [Switch](functions-for-customizing-application-data.md#switch) to map long values to shorter values/abbreviations.

1. **Address potentially empty values for mandatory attributes.** It's mandatory to populate certain attributes like ```firstName```, ```lastName```, ```CN```, or ```UPN``` when creating an account in Microsoft Entra ID or Windows Server AD. If any of the corresponding HR fields mapped to such attributes are null, then the user creation operation fails. For example, if you map the AD ```CN``` attribute to "display name" and if the "display name" is not set for all users, then you encounter an error. One option is to review such mandatory attribute mappings and ensure that the corresponding fields are populated in HR. You may also consider the option of checking for null values in an expression mapping. For example, if display name is empty, concatenate first name and last or family name to form the display name.

### Confirm that necessary BAPIs for SAP ECC are ready for use by Microsoft Entra

The Microsoft Entra provisioning agent and generic web services connector provides connectivity to on-premises SOAP endpoints, including SAP BAPIs.

If you aren't using SAP ECC and are only provisioning to SAP cloud services, skip to the next section.

1. **Confirm that the BAPIs needed for provisioning are published.** Expose the necessary APIs in SAP ECC NetWeaver 7.51 to create, update, and delete users. The [Connectors for Microsoft Identity Manager 2016](https://www.microsoft.com/download/details.aspx?id=51495) file named `Deploying SAP NetWeaver AS ABAP 7.pdf` walks through how you can expose the necessary APIs.

1. **Record the schema available for the existing SAP users.** Perhaps you have existing users in SAP ECC that correspond to the workers in your authoritative system of record source. But if those users weren't created by Microsoft Entra ID, you need to have a field populated on those users that can be used as the unique identifier for the worker. This field is required to be present with a unique value on each user that corresponds to a worker. Then Microsoft Entra provisioning can determine which users already exist for workers and avoid creating duplicate users.

   For example, you might be using the SAP BAPIs `BAPI_USER_GETLIST` and `BAPI_USER_GETDETAIL`. One of the fields returned by `BAPI_USER_GETDETAIL` should be chosen as the unique identifier to correlate to the source. If you don't have a field that corresponds to a unique identifier from the source, you might need to use a different unique identifier. For example, you might need to use the SAP field `address.e_mail` if its values are unique on each SAP user and also present on the Microsoft Entra ID users.

1. **Record the required schema for Microsoft Entra to supply to SAP BAPIs.** For example, you might be using the SAP BAPI `BAPI_USER_CREATE1`, which requires `ADDRESS`,`COMPANY`,`DEFAULTS`,`LOGONDATA`,`PASSWORD`,`SELF_REGISTER`, and `USERNAME` fields to create a user. When you configure the mapping from Microsoft Entra ID user schema to the SAP ECC requirements, map Microsoft ID user attributes or constants to each of those fields.

### Document the end-to-end attribute flow and transformations

You've identified the schema requirements of your applications and the available worker fields from your system of record sources. Now document the paths for how those fields flow through Microsoft Entra and, optionally, Windows Server AD and SAP Cloud Identity Services, to the applications.

In some cases, the attributes required by the applications don't correspond directly to the data values available from the source. Then it's necessary to transform the values before those values can be supplied to the target application.

There are several processing stages where a transformation can be applied.

| Stage | Considerations | Links for more information |
| ------- | --------------------- | --- |
| In the system of record itself | Microsoft Entra identity lifecycle management might not be the only solution reading from a system of record source. Performing the data normalization before exposing data to Microsoft Entra might also benefit other solutions that need similar data. | See the system of record documentation |
| In the inbound provisioning flow, from the system of record to Microsoft Entra or Windows Server AD | You can write a custom value to a Windows Server AD user attribute, or a Microsoft Entra ID user attribute, based on one or more SuccessFactors attributes.| [Expression with functions for customization](~/identity/app-provisioning/functions-for-customizing-application-data.md)|
| When you synchronize from Windows Server AD to Microsoft Entra ID | If you already have users in Windows Server AD, you might be transforming attributes of those users as they're brought into Microsoft Entra ID. | [How to customize a synchronization rule in Microsoft Entra Connect](~/identity/hybrid/connect/how-to-connect-create-custom-sync-rule.md) and [Use the expression builder with Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/how-to-expression-builder.md)|
| In the outbound provisioning flow from Microsoft Entra ID to SAP Cloud Identity Services, SAP ECC, or other non-SAP applications | When you configure provisioning to an application, one of the types of attribute mappings that you can specify is an expression mapping one or more of the attributes in Microsoft Entra ID to an attribute in the target.| [Expression with functions for customization](~/identity/app-provisioning/functions-for-customizing-application-data.md)|
| In outbound federated SSO | By default, the Microsoft identity platform issues a SAML token to an application that contains a claim with a value of the user's username (also known as the user principal name), which can uniquely identify the user. The SAML token also contains other claims that include the user's email address or display name, and you can use claims transformation functions. |[Customize SAML token claims](~/identity-platform/saml-claims-customization.md) and [Customer JSON web token claims](~/identity-platform/jwt-claims-customization.md) |
| In SAP Cloud Identity Services | In SAP Cloud Identity Services, each target system that's configured adds transformations from the data model of the source for identities supplied to SAP Cloud Identity Services to the requirements of the target. You might need to change those transformations in SAP Cloud Identity Services to correspond to how you plan to model identity, especially if you have multiple target systems configured. This approach might be appropriate where the attribute requirement is specific to one or more SAP applications connected to SAP Cloud Identity Services. | [SAP Cloud Identity Services - Manage transformation](https://help.sap.com/docs/identity-provisioning/identity-provisioning/manage-transformations) |

### Prepare to issue new authentication credentials

1. **If you're using Windows Server AD, plan to issue Windows Server AD credentials for workers who need application access and didn't have Windows Server AD user accounts previously.** Historically, in some organizations, users were provisioned directly into application repositories. Workers only received Windows Server AD user accounts if they required a Microsoft Exchange mailbox or access to Windows Server AD-integrated applications.

   In this scenario, if you're configuring inbound provisioning to Windows Server AD, Microsoft Entra creates users in Windows Server AD, both for existing workers who didn't previously have Windows Server AD user accounts and any new workers. If users are signing in to the Windows domain, we recommend that users enroll in [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/) for stronger authentication than just a password.

1. **If you aren't using Windows Server AD, plan to issue Microsoft Entra ID credentials for workers who need application access and didn't have Microsoft Entra ID user accounts previously.** If you're configuring inbound provisioning to Microsoft Entra ID, not going first into Windows Server AD, Microsoft Entra creates users in Microsoft Entra, both for existing workers who didn't previously have Microsoft Entra ID user accounts and any new workers.

If users need passwords, you can roll out the Microsoft Entra ID [self-service password reset (SSPR)](~/identity/authentication/tutorial-enable-sspr.md) capability for the user to reset their password. You can provision the **Mobile Number** attribute from the cloud HR app. After the **Mobile Number** attribute is in Microsoft Entra ID, you can enable SSPR for the user's account. Then on day one, the new user can use the registered and verified mobile number for authentication. Refer to the [SSPR documentation](~/identity/authentication/howto-sspr-authenticationdata.md) for details on how to prepopulate authentication contact information.

If users will be using stronger authentication, enable the [Temporary Access Pass policy](../authentication/howto-authentication-temporary-access-pass.md) so that you can generate Temporary Access Passes for new users.

1. **Verify that users are ready for Microsoft Entra MFA.** We recommend requiring Microsoft Entra MFA for business-critical applications integrated via federation. For these applications, a policy should require the user to meet an MFA requirement prior to Microsoft Entra ID that permits them to sign in to an application. Some organizations might also block access by locations or [require the user to access from a registered device](~/identity/conditional-access/policy-alt-all-users-compliant-hybrid-or-mfa.md).

   If there's no suitable policy already that includes the necessary conditions for authentication, location, device, and terms of use, [add a policy to your Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md).

1. **Prepare to issue a Temporary Access Pass for new workers.** If you have Microsoft Entra ID Governance and are configuring inbound provisioning to Microsoft Entra ID, plan to configure Lifecycle Workflows to issue a [Temporary Access Pass](~/id-governance/lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager) for new workers.

### Plan a pilot

Integrating HR business processes and identity workflows from HR sources to target systems requires a considerable amount of data validation, data transformation, data cleansing, and end-to-end testing before you can deploy the solution into production.

Run the initial configuration in a [pilot environment](~/architecture/deployment-plans.md#best-practices-for-a-pilot) before you scale it to all users in production.

## Deploy Microsoft Entra integrations

In this section, you:

* Bring the users into Microsoft Entra ID from an authoritative source system.

  :::image type="content" source="media/plan-sap-user-source-and-target/inbound-data-preparation.png" alt-text="Diagram that shows Microsoft and SAP technologies relevant to bringing in data about workers to Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/inbound-data-preparation.png":::

* Provision those users to SAP Cloud Identity Services or SAP ECC to enable them to sign in to SAP applications or applications on SAP BTP.

  :::image type="content" source="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram that shows Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png":::

### Update the Windows Server AD user schema

If you're provisioning users into Windows Server AD and Microsoft Entra ID, ensure that your Windows Server AD environment and associated Microsoft Entra agents are ready to transport users into and out of Windows Server AD with the necessary schema for your SAP applications.

If you don't use Windows Server AD, skip to the next section.

1. **Extend the Windows Server AD schema, if needed.** For each user attribute required by Microsoft Entra and your applications that isn't already part of the Windows Server AD user schema, you need to select a built-in Windows Server AD user extension attribute. Or you need to extend the Windows Server AD schema to have a place for Windows Server AD to hold that attribute. This requirement also includes attributes used for automation, such as a worker's join date and leave date.

   For example, some organizations might use the attributes `extensionAttribute1` and `extensionAttribute2` to hold these properties. If you choose to use the built-in extension attributes, ensure that those attributes aren't already in use by any other LDAP-based applications of Windows Server AD, or by applications integrated with Microsoft Entra ID. Other organizations create new Windows Server AD attributes with names specific to their requirements, such as `contosoWorkerId`.
1. **Confirm that any existing Windows Server AD users have necessary attributes for correlation with the HR source.** Perhaps you have existing users in Windows Server AD that correspond to workers. Those users must have an attribute whose value is unique and corresponds to a property in the authoritative system of record source for those workers.

   For example, some organizations use an attribute such as `employeeId` in Windows Server AD. If there are users who don't have that attribute, they might not be considered during the subsequent integration. Then automated provisioning results in duplicate users created in Windows Server AD. When a user leaves, the original users aren't updated or removed. You can use:

   - The PowerShell pipeline on a domain-joined computer with the command `Get-ADUser` to [get all the users in an Active Directory container](/powershell/module/activedirectory/get-aduser?#example-1-get-all-of-the-users-in-a-container).
   - The `where-object` command to filter to users who have a missing attribute with a filter like `{$_.employeeId -eq $null}`.
   - The `export-csv` command to export the resulting users to a CSV file.

   Ensure that no users correspond to workers who are missing that attribute. If there are, you must edit those users in Windows Server AD to add the missing attribute before you proceed.
1. **Extend the Microsoft Entra ID schema and configure the mappings from the Windows Server AD schema to the Microsoft Entra ID user schema.** If you're using Microsoft Entra Connect Sync, perform the steps in [Microsoft Entra Connect Sync: Directory extensions](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) to extend the Microsoft Entra ID user schema with attributes. Configure the Microsoft Entra Connect Sync mappings for the attributes of Windows Server AD to those attributes.

   If you're using Microsoft Entra Cloud Sync, perform the steps in [Microsoft Entra Cloud Sync directory extensions and custom attribute mapping](~/identity/hybrid/cloud-sync/custom-attribute-mapping.md) to extend the Microsoft Entra ID user schema with any other necessary attributes. Configure the Microsoft Entra Cloud Sync mappings for the attributes of Windows Server AD to those attributes. Ensure that you're synchronizing the [attributes required by Lifecycle Workflows](~/id-governance/how-to-lifecycle-workflow-sync-attributes.md).
1. **Wait for synchronization from Windows Server AD to Microsoft Entra ID to finish.** If you made changes to the mappings to provision more attributes from Windows Server AD, wait until those changes for the users make their way from Windows Server AD to Microsoft Entra ID so that the Microsoft Entra ID representation of the users has the complete set of attributes from Windows Server AD.

   If you're using Microsoft Entra Cloud Sync, you can monitor the `steadyStateLastAchievedTime` property of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal that represents Microsoft Entra Cloud Sync. If you don't have the service principal ID, see [View the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema).

1. **Create any necessary containers in Windows Server AD.**  If you will be provisioning users into organizational units in the domain, then ensure those `organizationalUnit` containers exist prior to enabling the provisioning agent.

### Update the Microsoft Entra ID user schema

If you're using Windows Server AD, you've already extended the Microsoft Entra ID user schema as part of configuring mappings from Windows Server AD. If this step is finished, skip to the next section.

If you don't use Windows Server AD, follow the steps in this section to extend the Microsoft Entra ID user schema.

1. **Create an application to hold the Microsoft Entra schema extensions.** For tenants that aren't synchronized from Windows Server AD, schema extensions must be part of a new application. If you haven't already done so, create an application to represent schema extensions. This application won't have any users assigned to it.
1. **Identify the attribute for correlation with the system of record.** Perhaps you have existing users in Microsoft Entra ID that correspond to workers. Then those users must have an attribute whose value is unique and corresponds to a property in the authoritative system of record source for those workers.

   For example, some organizations extend their Microsoft Entra ID user schema to have a new attribute for this purpose. If you haven't already created an attribute for that purpose, include that as an attribute in the next step.
1. **Extend the Microsoft Entra ID user schema for new attributes.** Create directory schema extensions for each attribute required by the SAP applications that aren't already part of the Microsoft Entra ID user schema. These attributes provide a way for Microsoft Entra to store more data about users. You can extend the schema by [creating an extension attribute](user-provisioning-sync-attributes-for-mapping.md#create-an-extension-attribute-in-a-tenant-with-cloud-only-users).

### Ensure that users in Microsoft Entra ID can be correlated with worker records in the HR source

Perhaps you have existing users in Microsoft Entra ID that correspond to workers. Then those users must have an attribute whose value is unique and corresponds to a property in the authoritative system of record source for those workers.

For example, some organizations might extend their Microsoft Entra ID user schema to have a new attribute for this purpose. If there are users who don't have that attribute, they might not be considered during the subsequent integration. Then automated provisioning results in duplicate users being created in Windows Server AD. When a user leaves, the original users aren't updated or removed.

1. **Retrieve the users from Microsoft Entra ID. Ensure that any user already in Microsoft Entra ID that represents a worker has an attribute so that it can be correlated.** Typically, a few users in Microsoft Entra ID don't correspond to workers in your authoritative system of record source. These users include the break-glass account for emergency administrative access, accounts for IT vendors, and business guests. The rest of the users must already have an attribute with a unique value to be used for correlation.

   If some users aren't correlated, they might be missed for updates and deprovisioning. Microsoft Entra might even create duplicate users. For example, if the requirement is that all member users (apart from the break-glass account) have an `employeeid` attribute, you could identify those users with a PowerShell command pipeline similar to the following script:

   ```powershell
   $u = get-mguser -all -property id,displayname,userprincipalname,usertype,employeeid | Where-Object {$_.UserType -ne 'Guest' -and $_.EmployeeId -eq $null}
   ```

### Set up the prerequisites for identity governance features

If you identified a need for a Microsoft Entra ID governance capability, such as Microsoft Entra entitlement management or Microsoft Entra Lifecycle Workflows, deploy those features before you bring in workers as users into Microsoft Entra ID.

1. **Upload the terms of use document, if needed.** If you require users to accept terms of use before they can access an application, create and [upload the terms of use document](~/identity/conditional-access/terms-of-use.md) so that it can be included in a Conditional Access policy.

1. **Create a catalog, if needed.** By default, when an administrator first interacts with Microsoft Entra entitlement management, a default catalog is automatically created. However, access packages for governed applications should be in a designated catalog. To create a catalog in the Microsoft Entra admin center, follow the steps in the section [Create a catalog](../../id-governance/entitlement-management-catalog-create.md#create-a-catalog).

   To create a catalog by using PowerShell, follow the steps in the sections [Authenticate to Microsoft Entra ID](../../id-governance/entitlement-management-access-package-create-app.md#authenticate-to-microsoft-entra-id) and [Create a catalog](../../id-governance/entitlement-management-access-package-create-app.md#create-a-catalog-in-microsoft-entra-entitlement-management).

1. **Create a joiner workflow.** If you're configuring inbound provisioning to Microsoft Entra ID, configure a Lifecycle Workflow joiner workflow with a task to issue a [Temporary Access Pass](~/id-governance/lifecycle-workflow-tasks.md#generate-temporary-access-pass-and-send-via-email-to-users-manager) for new workers.

1. **Create a leaver workflow that blocks sign-ins.** In Microsoft Entra Lifecycle Workflows, configure a leaver workflow with a task that blocks users from sign-in. This workflow can run on-demand. If you didn't configure inbound provisioning from the sources of record to block workers from signing in after their scheduled leave date, configure a leaver workflow to run on those workers' scheduled leave dates.

1. **Create a leaver workflow to delete user accounts.** Optionally, configure a leaver workflow with a task to delete a user. Schedule this workflow to run for some period of time, such as 30 or 90 days, after the worker's scheduled leave date.

### Connect users in Microsoft Entra ID to worker records from the HR source

This section illustrates how to integrate Microsoft Entra ID with SAP SuccessFactors as the HR source system of record.

1. **Configure the system of record with a service account and grant appropriate permissions for Microsoft Entra ID.** If you're using SAP SuccessFactors, follow the steps in the section [Configuring SuccessFactors for the integration](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#configuring-successfactors-for-the-integration).

1. **Configure inbound mappings from your system of record to Windows Server AD or Microsoft Entra ID.** If you're using SAP SuccessFactors and provisioning users into Windows Server AD and Microsoft Entra ID, follow the steps in the section [Configuring user provisioning from SuccessFactors to Active Directory](../saas-apps/sap-successfactors-inbound-provisioning-tutorial.md#configuring-user-provisioning-from-successfactors-to-active-directory).

   If you're using SAP SuccessFactors and not provisioning into Windows Server AD, follow the steps in the section [Configuring user provisioning from SuccessFactors to Microsoft Entra ID](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#configuring-user-provisioning-from-successfactors-to-microsoft-entra-id).

   When you configure the mappings, ensure that you configured a mapping with **Match objects using this attribute** for the Windows Server AD attribute or Microsoft Entra ID user attribute used for correlation. Also configure mappings for the attributes required for the worker join and leave dates, and all the attributes required by the destination applications, that originate from the HR source.

1. **Perform the initial inbound provisioning from the system of record.** If you're using SAP SuccessFactors and provisioning users into Windows Server AD and Microsoft Entra ID, follow the steps in the section [Enable and launch provisioning](../saas-apps/sap-successfactors-inbound-provisioning-tutorial.md#enable-and-launch-user-provisioning). If you're using SAP SuccessFactors and not provisioning into Windows Server AD, follow the steps in the section [Enable and launch provisioning](../saas-apps/sap-successfactors-inbound-provisioning-cloud-only-tutorial.md#enable-and-launch-user-provisioning). For large cloud HR app tenants (>30,000 users), run the initial cycle in progressive stages, as described in [plan for the initial cycle](plan-cloud-hr-provision.md#plan-for-initial-cycle).

1. **Wait for the initial sync from the system of record to finish.** If you're syncing from SAP SuccessFactors to Windows Server AD or Microsoft Entra ID, after the initial sync to the directory is finished, Microsoft Entra updates the audit summary report on the **Provisioning** tab of the SAP SuccessFactors application in the Microsoft Entra admin center.

   > [!div class="mx-imgBorder"]
   > ![Screenshot that shows the provisioning progress bar.](../saas-apps/media/sap-successfactors-inbound-provisioning/prov-progress-bar-stats.png)

1. **If you're provisioning into Windows Server AD, wait for the new users created in Windows Server AD, or those updated in Windows Server AD, to be synchronized from Windows Server AD to Microsoft Entra ID.** Wait until changes for the users in Windows Server AD make their way to Microsoft Entra ID so that the Microsoft Entra ID representation of the users has the complete set of users and their attributes from Windows Server AD.

   If you're using Microsoft Entra Cloud Sync, you can monitor the `steadyStateLastAchievedTime` of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal representing Microsoft Entra Cloud Sync. If you don't have the service principal ID, see [View the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema).

1. **Ensure that the users were provisioned into Microsoft Entra ID.** At this point, the users should be present in Microsoft Entra ID with the attributes required by the target applications. For example, you might require users to have the `givenname`, `surname`, and `employeeID` attributes. To display the number of users with particular attributes, or that are missing attributes, you can use PowerShell commands similar to the following script:

   ```powershell
   $u = get-mguser -all -property id,displayname,userprincipalname,usertype,givenname,surname,employeeid
   $u2 = $u | where-object {$_.usertype -ne 'Guest' -and $_.employeeid -ne $null}
   $u2c = $u2.Count
   write-output "member users with employeeID attribute: $u2c"
   $u3 = $u| Where-Object {$_.UserType -ne 'Guest' -and ($_.EmployeeId -eq $null -or $_.GivenName -eq $null -or $_.Surname -eq $null)}
   $u3c = $u3.Count
   write-output "member users missing employeeID, givenname or surname attributes: $u3c"
   ```

1. **Ensure that no unexpected uncorrelated accounts are in Microsoft Entra ID.** Typically, a few users in Microsoft Entra ID don't correspond to workers in your authoritative system of record source. They include the break-glass account for emergency administrative access, accounts for IT vendors, and business guests.

   However, they might also be orphan accounts in Microsoft Entra that resemble those accounts of current workers but that weren't synchronized with a worker record. Orphan accounts can result from former employees who are no longer in the HR system. They can also come from matching errors. Or they can arise from data quality issues, such as a person who changed their name or was rehired.

1. **Test the join, update and leave activities in an upstream system of record flow correctly to Microsoft Entra.** For more information, see [plan testing](plan-cloud-hr-provision.md#plan-testing).

### Provision users and their access rights to applications and enable them to sign in to those applications

Now that the users exist in Microsoft Entra ID, in the next sections you provision them to the target applications.

:::image type="content" source="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png" alt-text="Diagram that shows Microsoft and SAP technologies relevant to provisioning identities from Microsoft Entra ID." lightbox="media/plan-sap-user-source-and-target/outbound-provisioning-and-sso.png":::

### Provision users to SAP Cloud Identity Services

The steps in this section configure provisioning from Microsoft Entra ID to SAP Cloud Identity Services. By default, set up Microsoft Entra ID to automatically provision and deprovision users to SAP Cloud Identity Services. Then those users can authenticate to SAP Cloud Identity Services and have access to other SAP workloads that are integrated with SAP Cloud Identity Services. SAP Cloud Identity Services supports provisioning from its local identity directory to other SAP applications as [target systems](https://help.sap.com/docs/identity-provisioning/identity-provisioning/target-systems).

Alternatively, you can configure SAP Cloud Identity Services to read from Microsoft Entra ID. If you're using SAP Cloud Identity Services to read users and optionally groups from Microsoft Entra ID, follow the SAP guidance on how to configure SAP Cloud Identity Services. Then move on to the next section.

If you aren't using SAP Cloud Identity Services, skip to the next section.

1. **Ensure that you have a** [SAP Cloud Identity Services tenant](https://www.sap.com/products/cloud-platform.html) **with a user account in SAP Cloud Identity Services with Admin permissions.**

1. **Set up SAP Cloud Identity Services for provisioning.** Sign in to your SAP Cloud Identity Services Admin Console and follow the steps in the section [Set up SAP Cloud Identity Services for provisioning](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#set-up-sap-cloud-identity-services-for-provisioning).

1. **Add SAP Cloud Identity Services from the gallery and configure automatic user provisioning to SAP Cloud Identity Services.** Follow the steps in the sections [Add SAP Cloud Identity Services from the gallery](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#add-sap-cloud-identity-services-from-the-gallery) and [Configure automatic user provisioning to SAP Cloud Identity Services](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#configure-automatic-user-provisioning-to-sap-cloud-identity-services).

1. **Provision a test user from Microsoft Entra ID to SAP Cloud Identity Services.** Validate that provisioning integration is ready by following the steps in the section [Provision a new test user from Microsoft Entra ID to SAP Cloud Identity Services](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#provision-a-new-test-user-from-microsoft-entra-id-to-sap-cloud-identity-services).

1. **Ensure that existing users in both Microsoft Entra and SAP Cloud Identity Services can be correlated.** To compare the users in Microsoft Entra ID with those users already in SAP Cloud Identity Services, follow the steps in these sections:

   - [Ensure that existing SAP Cloud Identity Services users have the necessary matching attributes](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-sap-cloud-identity-services-users-have-the-necessary-matching-attributes)
   - [Ensure that existing Microsoft Entra users have the necessary attributes](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-microsoft-entra-users-have-the-necessary-attributes)

1. **Assign existing users of SAP Cloud Identity Services to the application in Microsoft Entra ID.** Follow the steps in the section [Assign users to the SAP Cloud Identity Services application in Microsoft Entra ID](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#assign-users-to-the-sap-cloud-identity-services-application-in-microsoft-entra-id). In those steps, you should:

    - Address any provisioning issues so that provisioning isn't quarantined.
    - Check for users who are present in SAP Cloud Identity Services and aren't already assigned to the application in Microsoft Entra ID.
    - Assign the remaining users.
    - Monitor the initial sync.

1. **Wait for synchronization from Microsoft Entra ID to SAP Cloud Identity Services.** Wait until all the users that were assigned to the application are provisioned. An initial cycle takes between 20 minutes and several hours. Timing depends on the size of the Microsoft Entra directory and the number of users in scope for provisioning. You can monitor the `steadyStateLastAchievedTime` property of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal that represents SAP Cloud Identity Services.

1. **Check for provisioning errors.** Check the provisioning log through the [Microsoft Entra admin center](~/identity/monitoring-health/concept-provisioning-logs.md) or [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-provisioning-events-using-the-provisioning-logs). Filter the log to the status **Failure**.

   If there are failures with an error code of `DuplicateTargetEntries`, this code indicates an ambiguity in your provisioning matching rules. To ensure that each Microsoft Entra user matches one application user, you need to update the Microsoft Entra users or the mappings that are used for matching. Then filter the log to the action **Create** and the status **Skipped**.

   If users were skipped with the `SkipReason` code of *`NotEffectivelyEntitled`, this log event might indicate that the user accounts in Microsoft Entra ID weren't matched because the user account status was **Disabled**.

1. **Compare the users in SAP Cloud Identity Services with those in Microsoft Entra ID.** Repeat the steps in the section [Ensure existing SAP Cloud Identity Services users have the necessary matching attributes](../saas-apps/sap-cloud-platform-identity-authentication-provisioning-tutorial.md#ensure-existing-sap-cloud-identity-services-users-have-the-necessary-matching-attributes) to re-export the users from SAP Cloud Identity Services. Then, check that the exported users have the necessary properties for the SAP applications. You can use the PowerShell `where-object` command to filter the list of users to just those users who have a missing attribute, with a filter like `{$_.employeeId -eq $null}`.

1. **Configure federated SSO from Microsoft Entra to SAP Cloud Identity Services.** Enable SAML-based SSO for SAP Cloud Identity Services. Follow the instructions provided in the [SAP Cloud Identity Services single sign-on tutorial](../saas-apps/sap-hana-cloud-platform-identity-authentication-tutorial.md).

1. **Create groups for SAP BTP application roles and assign groups to the BTP role collection.** If you have applications on BTP, then you can create Microsoft Entra security groups, and map those group IDs to the application roles. For more information, see [Managing access to SAP BTP](https://community.sap.com/t5/technology-blogs-by-members/identity-and-access-management-with-microsoft-entra-part-i-managing-access/ba-p/13873276).

1. **Bring the application web endpoint into scope of the appropriate Conditional Access policy.** Perhaps you have an existing Conditional Access policy that was created for another application subject to the same governance requirements. Then you can update that policy to have it also apply to this application to avoid having a large number of policies.

   After you make the updates, check to ensure that the expected policies are being applied. You can see what policies would apply to a user with the [Conditional Access what-if tool](~/identity/conditional-access/troubleshoot-conditional-access-what-if.md).

1. **Validate that a test user can connect to the SAP applications.** You can use Microsoft **My Apps** to test the application SSO. Ensure that a test user was assigned to the SAP Cloud Identity Services application and provisioned from Microsoft Entra ID to SAP Cloud Identity Services. Then, sign in to Microsoft Entra as that user and go to  `myapps.microsoft.com`.

   When you select the SAP Cloud Identity Services tile in **My Apps**, if you've configured the integration in service provider (SP) mode, you're redirected to the application sign-in page for initiating the sign-in flow. If you've configured in identity provider (IDP) mode, you're automatically signed in to the SAP Cloud Identity Services for which you set up the SSO.

### Provision users to SAP ECC

Now that you have the users in Microsoft Entra ID, you can provision them into SAP on-premises.

If you aren't using SAP ECC, skip to the next section.

1. **Configure provisioning.** Follow the instructions in [Configure Microsoft Entra ID to provision users into SAP ECC with NetWeaver AS ABAP 7.0 or later](on-premises-sap-connector-configure.md).

1. **Wait for synchronization from Microsoft Entra ID to SAP ECC.** Wait until all the users that were assigned to the SAP ECC application are provisioned. An initial cycle takes between 20 minutes and several hours. Timing depends on the size of the Microsoft Entra directory and the number of users in scope for provisioning. You can monitor the `steadyStateLastAchievedTime` property of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&&preserve-view=true&tabs=powershell#example) of the service principal.

1. **Check for provisioning errors.** Check the provisioning log through the [Microsoft Entra admin center](~/identity/monitoring-health/concept-provisioning-logs.md) or [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-provisioning-events-using-the-provisioning-logs). Filter the log to the status **Failure**.

   If there are failures with an error code of `DuplicateTargetEntries`, this log event indicates an ambiguity in your provisioning matching rules. You need to update the Microsoft Entra users or the mappings that are used for matching to ensure that each Microsoft Entra user matches one application user. Then filter the log to the action **Create** and the status **Skipped**.

   If users were skipped with the `SkipReason` code of `NotEffectivelyEntitled`, this code might indicate that the user accounts in Microsoft Entra ID weren't matched because the user account status was **Disabled**.

1. **Compare the users in SAP ECC with those in Microsoft Entra ID.** On the Windows Server hosting the provisioning agent for provisioning to SAP ECC, restart the `Microsoft ECMA2Host` Windows service. When the service restarts, it performs a full import of the users from SAP ECC.

1. **Configure federated SSO from Microsoft Entra to SAP.** Enable SAML-based SSO for SAP applications. If you're using SAP NetWeaver, follow the instructions provided in the [SAP NetWeaver SSO tutorial](../saas-apps/sap-netweaver-tutorial.md).

1. **Bring the application web endpoint into scope of the appropriate Conditional Access policy.** Perhaps you have an existing Conditional Access policy that was created for another application subject to the same governance requirements. Then you can update that policy to have it also apply to this application to avoid having a large number of policies.

   After you make the updates, check to ensure that the expected policies are being applied. You can see what policies would apply to a user with the [Conditional Access what-if tool](~/identity/conditional-access/troubleshoot-conditional-access-what-if.md).

1. **Validate that a test user can be provisioned and sign in to SAP NetWeaver.** Follow the instructions in the section [Test SSO](../saas-apps/sap-netweaver-tutorial.md#test-sso) to ensure that users can sign in after Conditional Access was configured.

### Configure provisioning to SuccessFactors and other applications

You can configure Microsoft Entra to write specific attributes from Microsoft Entra ID to SAP SuccessFactors Employee Central, including work email. For more information, see [Configure SAP SuccessFactors writeback in Microsoft Entra ID](../saas-apps/sap-successfactors-writeback-tutorial.md).

Microsoft Entra can also provision into many other applications, including those apps that use [standards](~/architecture/auth-sync-overview.md) such as OpenID Connect, SAML, SCIM, SQL, LDAP, SOAP, and REST. For more information, see [Integrating applications with Microsoft Entra ID](../../id-governance/identity-governance-applications-integrate.md).

### Assign users the necessary application access rights in Microsoft Entra

Unless the tenant you're configuring is a fully isolated tenant configured specifically for SAP application access, it's unlikely that everyone in the tenant needs access to SAP applications. The SAP applications in the tenant are configured so that only users with an application role assignment to an application are provisioned to the application and can sign in from Microsoft Entra ID to that application.

As users that are assigned to an application are updated in Microsoft Entra ID, those changes are automatically provisioned to that application.

If you have applications in SAP BTP, you can also assign groups managed in Microsoft Entra to the roles of that application in SAP Cloud Identity Services.

If you have Microsoft Entra ID Governance, you can automate changes to the application role assignments for SAP Cloud Identity Services or SAP ECC, and groups, in Microsoft Entra ID. You can use automation to add or remove assignments as people join the organization or leave or change roles.

1. **Review existing assignments.** Optionally, [perform a one-time access review of the application role assignments](~/id-governance/access-reviews-application-preparation.md) or group membership. When this review finishes, the access review removes assignments or members of the group that are no longer necessary.
1. **Configure the process to keep application role assignments up to date.** If you're using Microsoft Entra entitlement management and have SAP applications, see [Create an access package in entitlement management for an application with a single role by using PowerShell](../../id-governance/entitlement-management-access-package-create-app.md) to configure assignments to the application that represent SAP cloud identity services or SAP ECC. If you have applications in SAP BTP, you can configure entitlement management to assign users to Microsoft Entra security groups. For more information, see [Managing access to SAP BTP](https://community.sap.com/t5/technology-blogs-by-members/identity-and-access-management-with-microsoft-entra-part-i-managing-access/ba-p/13873276).

   In that access package, you can have policies for users to be assigned access when they request it. Assignments can be made [by an administrator](~/id-governance/entitlement-management-access-package-assignments.md#directly-assign-a-user), [automatically based on rules](~/id-governance/entitlement-management-access-package-auto-assignment-policy.md), or generated through [Lifecycle Workflows](~/id-governance/entitlement-management-scenarios.md#administrator-assign-employees-access-from-lifecycle-workflows).

If you don't have Microsoft Entra ID Governance, you can [assign each individual user to the application](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) in the Microsoft Entra admin center. You can assign individual users to the application via the PowerShell cmdlet `New-MgServicePrincipalAppRoleAssignedTo`.

### Distribute credentials to newly created Microsoft Entra users or Windows Server AD users

At this point, all users are present in Microsoft Entra ID and provisioned to the relevant SAP applications. Any users that were created during this process, for workers that weren't previously present in Windows Server AD or Microsoft Entra ID, require new credentials.

1. **If Microsoft Entra inbound provisioning is creating users in Windows Server AD, distribute the Windows Server AD initial credentials for newly created users.** You can retrieve a list of events for Microsoft Entra interactions with Windows Server AD by using the [Get-MgAuditLogProvisioning](/powershell/module/microsoft.graph.reports/get-mgauditlogprovisioning?) command.

   You can use the [`Set-ADAccountPassword` command with the `-Reset` parameter](/powershell/module/activedirectory/set-adaccountpassword?#example-1-set-a-password-for-a-user-account-using-a-distinguished-name) on a domain-joined computer to set a new Windows Server AD password for a user. Then use the [`Set-ADUser` command with the `-ChangePasswordAtLogon` parameter](/powershell/module/activedirectory/set-aduser) to require the user to select a new password at the next sign-in.

1. **If Microsoft Entra inbound provisioning is creating users in Microsoft Entra ID, distribute the Microsoft Entra ID initial credentials for newly created users.** You can retrieve a list of newly created users with the [Get-MgAuditLogDirectoryAudit](/powershell/module/microsoft.graph.reports/get-mgauditlogdirectoryaudit) command, with parameters such as `Get-MgAuditLogDirectoryAudit -Filter "category eq 'UserManagement' and activityDisplayName eq 'Add user' and result eq 'success' and activityDateTime+ge+2024-05-01" -all`.

   To generate a Temporary Access Pass for a user, you can use the [New-MgUserAuthenticationTemporaryAccessPassMethod](/powershell/module/microsoft.graph.identity.signins/new-mguserauthenticationtemporaryaccesspassmethod) and [Get-MgUserAuthenticationTemporaryAccessPassMethod](/powershell/module/microsoft.graph.identity.signins/get-mguserauthenticationtemporaryaccesspassmethod?view=graph-powershell-1.0&preserve-view=true&viewFallbackFrom=graph-powershell-beta) commands, as illustrated in [Create a Temporary Access Pass](../authentication/howto-authentication-temporary-access-pass.md#create-a-temporary-access-pass).

1. **Confirm that users are registered for MFA.** You can identify users who aren't registered for MFA by running the PowerShell commands in the section [PowerShell reporting on users registered for MFA](../authentication/howto-mfa-reporting.md#powershell-reporting-on-users-registered-for-mfa).

1. **Create a recurring access review if any users need temporary policy exclusions.** In some cases, it might not be possible to immediately enforce Conditional Access policies for every authorized user. For example, some users might not have an appropriate registered device. If it's necessary to exclude one or more users from the Conditional Access policy and allow them access, configure an access review for the group of [users who are excluded from Conditional Access policies](~/id-governance/conditional-access-exclusion.md).

## Monitor identity flows

Now that you have inbound and outbound provisioning configured with your applications, you can use automation in Microsoft Entra to monitor ongoing provisioning from the authoritative systems of records to the target applications.

### Monitor inbound provisioning

Activities performed by the provisioning service are recorded in the Microsoft Entra [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md). You can access the provisioning logs in the Microsoft Entra admin center. You can search the provisioning data based on the name of the user or the identifier in either the source system or the target system. For more information, see [Provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md).

### Monitor changes in Windows Server AD

As described in [Windows Server audit policy recommendations](/windows-server/identity/ad-ds/plan/security-best-practices/audit-policy-recommendations), ensure that User Account Management success audit events are enabled on all domain controllers and collected for analysis.

### Monitor application role assignments

If you configured Microsoft Entra ID to [send audit events to Azure Monitor](../../id-governance/entitlement-management-logs-and-reporting.md), you can use Azure Monitor workbooks to get insights on how users receive their access.

* If you're using Microsoft Entra entitlement management, the workbook named Access Package Activity displays each event related to a particular access package.

    ![Screenshot that shows the access package events.](../../id-governance/media/entitlement-management-logs-and-reporting/view-events-access-package.png)

* To see if changes to application role assignments for an application weren't created because of access package assignments, select the workbook named **Application role assignment activity**. If you select to omit entitlement activity, only changes to application roles that weren't made by entitlement management are shown. For example, you would see a row if another administrator directly assigned a user to an application role.

    ![Screenshot that shows the app role assignments.](../../id-governance/media/entitlement-management-access-package-incompatible/workbook-ara.png)

### Monitor outbound provisioning

For each application integrated with Microsoft Entra, you can use the **Synchronization Details** section to monitor progress and follow links to the provisioning activity report. The report describes all the actions performed by the Microsoft Entra provisioning service on the application. You can also monitor the provisioning project via the Microsoft [Graph APIs](~/identity/app-provisioning/application-provisioning-configuration-api.md#monitor-the-provisioning-job-status).

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

### Monitor SSO

You can view the last 30 days of sign-ins to an application in the [sign-ins report](~/identity/monitoring-health/concept-sign-in-log-activity-details.md) in the Microsoft Entra admin center or via [Microsoft Graph](/graph/api/signin-list?view=graph-rest-1.0&tabs=http&preserve-view=true). You can also send the [sign-in logs to Azure Monitor](~/identity/monitoring-health/concept-log-monitoring-integration-options-considerations.md) to archive sign-in activity for up to two years.

### Monitor assignments in Microsoft Entra ID Governance

If you're using Microsoft Entra ID Governance, you can report on how users are getting access by using Microsoft Entra ID Governance features. For example:

* An administrator or a catalog owner can [retrieve the list of users who have access package assignments](~/id-governance/entitlement-management-access-package-assignments.md) via the Microsoft Entra admin center, Microsoft Graph, or PowerShell.
* You can also send the audit logs to Azure Monitor and view a history of [changes to the access package](~/id-governance/entitlement-management-logs-and-reporting.md#view-events-for-an-access-package) in the Microsoft Entra admin center or via PowerShell.

For more information on these scenarios and other identity governance scenarios, see how to [monitor to adjust entitlement management policies and access as needed](~/id-governance/identity-governance-applications-deploy.md#monitor-to-adjust-entitlement-management-policies-and-access-as-needed).

## Related content

- [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)
- [Govern access by migrating an organizational role model to Microsoft Entra ID Governance](~/id-governance/identity-governance-organizational-roles.md)
- [Define organizational policies for governing access to other applications in your environment](~/id-governance/identity-governance-applications-define.md)
- [Use Microsoft Entra ID to secure access to SAP platforms and applications](~/fundamentals/scenario-azure-first-sap-identity-integration.md)
- [Explore the foundations of identity and governance for SAP on Azure](/training/paths/explore-foundations-of-identity-governance/)

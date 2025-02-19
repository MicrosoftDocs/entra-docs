---
title: Increase the resilience of authentication for federated on-premises applications at sites with colocated users
description: Resilience guidance for application deployments for federated applications with orchestration of a relying party security token service
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: markwahl-msft
ms.author: mwahl
manager: martinco
ms.date: 02/14/2025
---

# Increase the resilience of authentication for sites with federated on-premises applications at sites with colocated users

One scenario that many organizations [building for resilience](resilience-overview.md) in their identity and access management architecture need to accommodate is continuity of application access during temporary site disconnection. The organization may have one or more physical sites at which their applications are deployed. Some of their users are colocated at those sites and need to be able to access the applications. For example, employees at a factory or at a store may need to be able to sign-in to in-house-developed business applications managing operations at that site.

Historically, organizations could use Active Directory Domain Services, deploy [domain controllers at each site](/windows-server/identity/ad-ds/plan/planning-domain-controller-placement), so that users could authenticate to a local domain controller. Authenticating users through Microsoft Entra and connecting applications to Microsoft Entra ID via federation protocols such as SAML brings benefits, including multifactor authentication and risk based conditional access. When applications are federated to Microsoft Entra, the users authenticate themselves to Microsoft Entra, and Microsoft Entra then provides tokens that carries claims and indicate their authentication status to the applications. However, if the users and applications are unable to access Microsoft Entra cloud endpoints, which can occur if there is a break in the network connectivity between the site and the Internet, then no more tokens can be issued to applications via that route until the break is repaired. Users already authenticated to the application may be able to continue to use the application until the application requires the user to reauthenticate, but will not be able to get a new access token from Microsoft Entra, and any user who hadn't previously connected to the application may find themselves unable to use the application as well.

One approach to solving this problem and ensuring tokens can be issued to federated applications even during temporary site disconnection is:

* maintain an Active Directory domain controller at each site
* ensure users at a site can authenticate to either the Active Directory or Microsoft Entra and that the same claims are available from both identity providers
* configure applications to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-without-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application and both Windows Server AD and Microsoft Entra ID as an identity provider.":::

For prepackaged or existing federated applications, it may not be feasible to configure the applications to have multiple trusted identity providers, or may require significant engineering effort to implement a process that changes many applications with different configuration models.

An alternative approach is to add a relying party security token service (STS), such as AD FS. In this topology,
* maintain an Active Directory domain controller at each site
* ensure users at a site can authenticate to either the Active Directory or Microsoft Entra
* configure applications to trust the local relying party security token service (STS)
* configure the relying party STS to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-with-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application, a relying party STS, and both Windows Server AD and Microsoft Entra ID as an identity provider.":::

This tutorial illustrates how to configure Microsoft Entra for a federated application, using a relying party STS. In normal operations, users will authenticate to Microsoft Entra, and Microsoft Entra will issue tokens for the application. And in a site disconnect situation, users can authenticate to Active Directory, and obtain tokens for that application with similar claims as that provided by Microsoft Entra. While the capabilities of multifactor authentication, risk-based conditional access, and other Microsoft Entra features won't be available for applications during the time of disconnection, users will continue to be able to be authenticated to access to those applications.

We recommend that you use a nonproduction environment to test the steps in this article, before configuring an application or failover in a production tenant.

## Prerequisites

This tutorial relies upon both a Microsoft Entra tenant and an Active Directory domain. Before you begin, ensure you have one of the following roles in Microsoft Entra: `Cloud Application Administrator`, `Application Administrator`.

You will need to ensure that at each site there is sufficient infrastructure to support your applications without relying upon connections to the Internet or other sites. This tutorial illustrates configuration for:

* An application which implements a federation protocol such as SAML
* A relying party STS, such as Active Directory Federation Services. This tutorial assumes Windows Server 2025.
* An Active Directory domain controller

Applications may have other requirements beyond these, such as log retention, DNS/DHCP, or other network and infrastructure services, which are beyond the scope of this tutorial.

## Ensure consistent user identities and attributes across Windows Server AD and Microsoft Entra ID

For the applications to receive the same claims for the same users in a federation token as expected from Microsoft Entra ID, even when Microsoft Entra ID is unreachable, there must be a source of user identities and their attributes local to the site that can be used to generate the claims. AD FS supports Windows Server AD as a identity source and its attributes as a claims source.

One way to maintain consistency is to define an identity management process that creates and updates users in Windows Server AD, and then synchronizes those users from AD to Microsoft Entra. Check that your Windows Server AD environment and associated Microsoft Entra agents are ready to transport users into and out of Windows Server AD with the necessary schema for your applications. If you already have users being synchronized from Active Directory to Microsoft Entra, then continue at the next section.

1. **Enable the Active Directory Recycle Bin**. The recycle bin feature is needed for the Microsoft Entra lifecycle workflows to be able to delete users from AD. For more information, see [Enabling and Managing the Active Directory Recycle Bin Using Active Directory Administrative Center](/windows-server/identity/ad-ds/get-started/adac/Advanced-AD-DS-Management-Using-Active-Directory-Administrative-Center--Level-200-#enabling-and-managing-the-active-directory-recycle-bin-using-active-directory-administrative-center).

1. **Extend the Windows Server AD schema, if needed.** For each user attribute required by Microsoft Entra and your applications that isn't already part of the Windows Server AD user schema, you need to select a built-in Windows Server AD user extension attribute. Or you need to extend the Windows Server AD schema to have a place for Windows Server AD to hold that attribute. This requirement also includes attributes used for automation, such as a worker's join date and leave date.

   For example, some organizations might use the attributes `extensionAttribute1` and `extensionAttribute2` to hold these properties. If you choose to use the built-in extension attributes, ensure that those attributes aren't already in use by any other LDAP-based applications of Windows Server AD, or by applications integrated with Microsoft Entra ID. Other organizations create new Windows Server AD attributes with names specific to their requirements, such as `contosoWorkerId`.

2. **Bring in attributes from authoritative sources**. If you have not already done so, configure Microsoft Entra to provision workers from [Workday](~/identity/saas-apps/workday-inbound-tutorial.md), [SuccessFactors](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md), or [other HR sources](~/identity/app-provisioning/inbound-provisioning-api-configure-app.md) as users in Windows Server AD. You can map the properties of worker records to the user attributes in the AD schema.

3. **Set up synchronization between Microsoft Entra and Windows Server AD**. Configure Microsoft Entra Connect sync or [Microsoft Entra cloud sync](~/identity/hybrid/cloud-sync/tutorial-single-forest.md) to synchronize those users from AD to Microsoft Entra. Also deploy the provisioning agent, in order to [lifecycle workflow user account tasks](~/id-governance/lifecycle-workflow-on-premises.md#user-account-tasks).

4. **Extend the Microsoft Entra ID schema and configure the mappings from the Windows Server AD schema to the Microsoft Entra ID user schema.** If you're using Microsoft Entra Connect Sync, perform the steps in [Microsoft Entra Connect Sync: Directory extensions](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) to extend the Microsoft Entra ID user schema with attributes. Configure the Microsoft Entra Connect Sync mappings for the attributes of Windows Server AD to those attributes.

   If you're using Microsoft Entra Cloud Sync, perform the steps in [Microsoft Entra Cloud Sync directory extensions and custom attribute mapping](~/identity/hybrid/cloud-sync/custom-attribute-mapping.md) to extend the Microsoft Entra ID user schema with any other necessary attributes. Configure the Microsoft Entra Cloud Sync mappings for the attributes of Windows Server AD to those attributes. Ensure that you're synchronizing the [attributes required by Lifecycle Workflows](~/id-governance/how-to-lifecycle-workflow-sync-attributes.md).

5. **Wait for synchronization from Windows Server AD to Microsoft Entra ID to finish.** If you made changes to the mappings to provision more attributes from Windows Server AD, wait until those changes for the users make their way from Windows Server AD to Microsoft Entra ID so that the Microsoft Entra ID representation of the users has the complete set of attributes from Windows Server AD.

   If you're using Microsoft Entra Cloud Sync, you can monitor the `steadyStateLastAchievedTime` property of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal that represents Microsoft Entra Cloud Sync. If you don't have the service principal ID, see [View the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema).

6. **Create a leaver workflow that blocks sign-ins.** In Microsoft Entra Lifecycle Workflows, configure a leaver workflow with a `Disable user account` task that blocks users from sign-in to on-premises. This workflow can run on-demand. If you didn't configure inbound provisioning from the sources of record to block workers from signing in after their scheduled leave date, configure a leaver workflow with that task to run on those workers' scheduled leave dates. For more information, see [Manage users synchronized from on-premises](~/id-governance/manage-workflow-on-premises.md).

7. **Create a leaver workflow to delete user accounts.** In Microsoft Entra Lifecycle Workflows, configure a leaver workflow with a `Delete user` task to delete a user from Active Directory. Schedule this workflow to run for some period of time, such as 30 or 90 days, after the worker's scheduled leave date.

For more information on setting up HR inbound flows for applications with additional attributes, see [Plan deploying Microsoft Entra for user provisioning](identity/app-provisioning/plan-sap-user-source-and-target.md).

## Provide a user authentication option for Windows Server AD

When you're configuring inbound provisioning to Windows Server AD, Microsoft Entra creates users in Windows Server AD, both for existing workers who didn't previously have Windows Server AD user accounts and any new workers. Those users will need to be able to authenticate to Windows Server AD while they are disconnected, and also be able to authenticate to Microsoft Entra ID during normal operations. You will need to plan to issue Windows Server AD credentials for workers who need application access and didn't have Windows Server AD user accounts previously.

One way to have consistent authentication is to turn on [password hash synchronization](~/identity/hybrid/connect/whatis-phs.md) for hybrid accounts that are synchronized from Windows Server AD to Microsoft Entra. Ensure users have passwords set in AD and they know their password in AD. While they may have additional multifactor authentication requirements during normal operations, during a disconnected network event they would be able to authenticate to the Active Directory domain with their passwords.

If users will be interacting with applications from devices which support Windows Hello for Business, then also consider having users enroll in [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/) for stronger authentication than just a password.

## Deploy a relying party STS and configure two identity providers

* [Enable single sign-on for an enterprise application with a relying party security token service](~/identity/enterprise-apps/add-application-portal-setup-sso-rpsts.md)
* add users to app role
* configure AD as LDAP source
* configure rules to app

## Orchestrate changing the identity providers applicable to the application in the relying party STS configuration

* [Configure an identity provider list per relying party](/windows-server/identity/ad-fs/operations/home-realm-discovery-customization#configure-an-identity-provider-list-per-relying-party)

## Next steps

* [What is application management in Microsoft Entra ID?](~/identity/enterprise-apps/what-is-application-management.md)
* [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)

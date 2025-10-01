---
title: Increase the resilience of authentication for federated applications deployed at sites with colocated users
description: Resilience guidance for application deployments with orchestration of a relying party security token service to change its identity provider
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: markwahl-msft
ms.author: mwahl
manager: martinco
ms.date: 02/19/2025
---

# Increase the resilience of authentication for federated applications deployed at sites with colocated users

One scenario that many organizations [building for resilience](resilience-overview.md) in their identity and access management architecture need to accommodate is continuity of application access during temporary site disconnection. The organization may have one or more physical sites at which their applications are deployed. Some of their users are colocated at those sites and need to be able to access local applications. For example, employees at a factory or at a store may need to be able to sign-in to in-house-developed business applications managing operations at that site.

Historically, organizations could use Active Directory Domain Services, deploy [domain controllers at each site](/windows-server/identity/ad-ds/plan/planning-domain-controller-placement), so that users could authenticate to a local domain controller. Authenticating users through Microsoft Entra and connecting applications to Microsoft Entra ID via federation protocols such as SAML brings benefits, including multifactor authentication and risk based Conditional Access. When applications are federated to Microsoft Entra, the users authenticate themselves to Microsoft Entra, and Microsoft Entra then provides tokens that carry claims and indicate their authentication status to the applications. However, if there is a break in the network connectivity between the site and the Internet, then users and applications are unable to access Microsoft Entra cloud endpoints. With that break in connectivity, no more tokens can be issued from Microsoft Entra to applications via that route until the break is repaired. Users already authenticated to the application and able to connect to the application may be able to continue to use the application for a time. However, if the application requires the user to reauthenticate and the break has not yet been repaired, then the user won't be able to get a new access token from Microsoft Entra. In addition, until the break is repaired, any user who hadn't previously connected to the application may find themselves unable to use the application as well.

One approach to solving this problem and ensuring tokens can be issued to federated applications even during temporary site disconnection is:

* Maintain an Active Directory domain controller at each site
* Ensure users at a site can authenticate to either the Active Directory or Microsoft Entra and that the same claims are available from both identity providers
* Configure applications to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-without-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application that has both Windows Server Active Directory and Microsoft Entra ID as its identity providers.":::

However, for some prepackaged federated applications, the application may have been designed to operate with a single identity provider at a time, and it may not be feasible to configure the applications to have multiple trusted identity providers. Even for organizations with in-house developed applications that were designed for a single identity provider, may require significant engineering effort to implement a process that changes many applications with different configuration models.

An alternative approach, described in this tutorial, is to add a relying party security token service (STS), such as AD FS to the topology. In this topology,

* Maintain an Active Directory domain controller at each site
* Ensure users at a site can authenticate to either the Active Directory or Microsoft Entra
* Configure applications to trust the local relying party security token service (STS)
* Configure the relying party STS to trust Microsoft Entra as the identity provider during normal operations, but during a disconnect event, trust Active Directory as the identity provider

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-with-relying-party-sts.png" alt-text="Diagram showing the trust relationship between an application, a relying party STS, and identity providers. Both Windows Server Active Directory and Microsoft Entra ID are configured in the relying party STS as identity providers.":::

This tutorial illustrates how to configure Microsoft Entra for a federated application, using a relying party STS. In normal operations, users will authenticate to Microsoft Entra, and Microsoft Entra will issue tokens for the application. And in a site disconnect situation, users can authenticate to Active Directory, and obtain tokens for that application with similar claims as that provided by Microsoft Entra. While Microsoft Entra features including multifactor authentication or risk-based Conditional Access won't be available for applications during the time of disconnection, users will continue to be able to be authenticated to access to those applications.

   > [!IMPORTANT]
   > This guide is intended for organizations that are already familiar with deploying domain controllers across multiple sites and using federation technology such as AD FS to [provide Active Directory users with access to claims-Aware applications](/windows-server/identity/ad-fs/design/provide-your-active-directory-users-access-to-your-claims-aware-applications-and-services). Architecture and deployment of Active Directory, AD FS, and related technologies for high availability and resilience to network outages is a substantial investment. Before beginning the journey described in this article, [determine Your AD FS Deployment Topology](/windows-server/identity/ad-fs/design/determine-your-ad-fs-deployment-topology). If you have not deployed an AD domain for high availability, or [verified that your production environment can support an AD FS deployment](/windows-server/identity/ad-fs/design/ad-fs-deployment-topology-considerations#verifying-that-your-production-environment-can-support-an-ad-fs-deployment), then select an alternative approach for resilience.

We recommend that you use a nonproduction environment to test the steps in this article, before configuring an application or failover in a production tenant.

## Prerequisites

This tutorial relies upon both a Microsoft Entra tenant and an Active Directory domain. Before you begin, ensure you have one of the following roles in Microsoft Entra: `Cloud Application Administrator`, `Application Administrator`. You will also need permissions to administer AD.

You will need to ensure that at each site there are sufficient infrastructure components to support your applications without relying upon connections to the Internet or other sites. This tutorial illustrates configuration for:

* One or more applications, each of which implement a federation protocol such as SAML with the relying party initiated sign-on pattern. For more information, see [Single sign-on SAML protocol](~/identity-platform/single-sign-on-saml-protocol.md). This tutorial illustrates a configuration in which, if you have more than one application, the same set of users can be authenticated and are authorized for all the applications. Configuring different user sets for each application is outside the scope of this tutorial.
* An identity component which can be configured to operate as a relying party STS, such as Active Directory Federation Services. This tutorial assumes Windows Server 2025. As a security best practice, place Active Directory Federation Services federation servers behind a firewall and connect them to your corporate network to prevent exposure from the Internet. This practice is important because federation servers have full authorization to grant security tokens. Therefore, they should have the same protection as a domain controller. If a federation server is compromised, a malicious user has the ability to issue full access tokens to all Web applications protected by Active Directory Federation Services. For more information, see [where to place a federation server](/windows-server/identity/ad-fs/design/where-to-place-a-federation-server).
* An Active Directory domain controller. In a production environment, you will need multiple domain controllers, configured for high availability.

Applications may have other requirements beyond these identity requirements, such as requirements for log retention, DNS/DHCP, or other network and infrastructure services, which are beyond the scope of this tutorial.

### Ensure consistent user identities and attributes across Active Directory and Microsoft Entra ID

Applications will expect to receive the same claims for users in the federation token from a relying party STS, regardless of the configured identity provider. For the relying party STS to provide  the same claims as expected from Microsoft Entra ID, even when Microsoft Entra ID is unreachable, there must be a source of user identities and their attributes local to the site that can be used by the relying party STS to generate the claims. AD FS supports Windows Server Active Directory as an identity source and those Active Directory user attributes as a claims source.

One way to maintain consistency is to define an identity management process that creates and updates users in AD, and then synchronizes those users from AD to Microsoft Entra. Check that your AD environment and associated Microsoft Entra agents are ready to transport users into and out of AD with the necessary schema for your applications.

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/active-directory-user-object-data-flow.png" alt-text="Diagram showing the data flow for a user object between Microsoft Entra and Active Directory.":::

If you already have configured users to be synchronized from Active Directory to Microsoft Entra, then continue at the next section.

1. **Enable the Active Directory Recycle Bin**. The recycle bin feature is needed for the Microsoft Entra lifecycle workflows to be able to delete users from AD. For more information, see [Enabling and Managing the Active Directory Recycle Bin Using Active Directory Administrative Center](/windows-server/identity/ad-ds/get-started/adac/Advanced-AD-DS-Management-Using-Active-Directory-Administrative-Center--Level-200-#enabling-and-managing-the-active-directory-recycle-bin-using-active-directory-administrative-center).

1. **Extend the Active Directory schema, if needed.** For each user attribute required by Microsoft Entra and your applications that isn't already part of the AD user schema, you need to select a built-in user extension attribute. Or you need to [extend the Windows Server AD schema](/windows/win32/ad/how-to-extend-the-schema) to have a place for AD to hold that attribute. This requirement also includes attributes used for automation, such as a worker's join date and leave date.

   For example, some organizations might use the attributes `extensionAttribute1` and `extensionAttribute2` to hold these properties. If you choose to use the built-in extension attributes, ensure that those attributes aren't already in use by any other LDAP-based applications, or by other applications integrated with Microsoft Entra ID. Some organizations have created new AD attributes with names specific to their requirements, such as `contosoWorkerId`. However, extending the schema with new attributes has significant implications on Windows Server domain management. For more information, see [extending the schema](/windows/win32/ad/extending-the-schema).

1. **Bring in users with their attributes from authoritative sources**. If you haven't already done so, configure Microsoft Entra to provision workers from [Workday](~/identity/saas-apps/workday-inbound-tutorial.md), [SuccessFactors](~/identity/saas-apps/sap-successfactors-inbound-provisioning-tutorial.md), or [other HR sources](~/identity/app-provisioning/inbound-provisioning-api-configure-app.md) as users in AD. You can map the properties of worker records to the user attributes in the AD schema.

1. **Set up synchronization between Microsoft Entra and Active Directory**. Configure Microsoft Entra Connect sync or [Microsoft Entra cloud sync](~/identity/hybrid/cloud-sync/tutorial-single-forest.md) to synchronize those users from AD to Microsoft Entra. Also deploy the provisioning agent, in order to perform [lifecycle workflow user account tasks](~/id-governance/lifecycle-workflow-on-premises.md#user-account-tasks), such as deleting users from AD.

1. **Extend the Microsoft Entra ID schema and configure the mappings from the Active Directory schema to the Microsoft Entra ID user schema.** If you're using Microsoft Entra Connect Sync, perform the steps in [Microsoft Entra Connect Sync: Directory extensions](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) to extend the Microsoft Entra ID user schema with attributes. Configure the Microsoft Entra Connect Sync mappings for the attributes of AD to the attributes in Microsoft Entra ID.

   If you're using Microsoft Entra Cloud Sync, perform the steps in [Microsoft Entra Cloud Sync directory extensions and custom attribute mapping](~/identity/hybrid/cloud-sync/custom-attribute-mapping.md) to extend the Microsoft Entra ID user schema with any other necessary attributes. Configure the Microsoft Entra Cloud Sync mappings for the attributes of AD to the attributes in Microsoft Entra. Ensure that you're synchronizing the [attributes required by Lifecycle Workflows](~/id-governance/how-to-lifecycle-workflow-sync-attributes.md).

1. **Create a leaver workflow that blocks sign-ins.** In Microsoft Entra Lifecycle Workflows, configure a leaver workflow with a `Disable user account` task that blocks users from sign-in to on-premises. This workflow can run on-demand. If you didn't configure inbound provisioning from the sources of record to block workers from signing in after their scheduled leave date, configure a leaver workflow with that task to run on those workers' scheduled leave dates. For more information, see [Manage users synchronized from on-premises](~/id-governance/manage-workflow-on-premises.md).

1. **Create a leaver workflow to delete user accounts.** In Microsoft Entra Lifecycle Workflows, configure a leaver workflow with a `Delete user` task to delete a user from Active Directory. Schedule this workflow to run for some period of time, such as 30 or 90 days, after the worker's scheduled leave date.

For more information on setting up HR inbound flows for applications with multiple attributes, see [Plan deploying Microsoft Entra for user provisioning](~/identity/app-provisioning/plan-sap-user-source-and-target.md).

### Provide an authentication option for users in Active Directory

When you're configuring inbound provisioning from an HR source to AD, Microsoft Entra creates users in AD, both for existing workers who didn't previously have AD user accounts and any new workers that later join. Those users will need to be able to authenticate to AD while they are disconnected, and also be able to authenticate to Microsoft Entra ID during normal operations. You'll need to plan to issue credentials for workers who need application access they can use with AD.

If the only applications connected to AD are those being configured for resilience, then one way to have consistent authentication is to create users in AD, and then turn on [password hash synchronization](~/identity/hybrid/connect/whatis-phs.md) for those users that are synchronized from AD to Microsoft Entra. Ensure users have passwords set in AD and they know their password in AD. While they may have multifactor authentication requirements during normal operations, during a disconnected network event they would be able to authenticate to the Active Directory domain with their passwords.

Another option is to use [Microsoft Entra certificate-based authentication (CBA)](~/identity/authentication/concept-certificate-based-authentication.md), which enables Microsoft Entra to authenticate users using X.509 certificates issued by an Enterprise Public Key Infrastructure (PKI). AD also supports certificate authentication, and some organizations have issued smartcards, virtual smartcards, or software certificates to their users. If users will be interacting with applications from devices which support Windows Hello for Business, then also consider having users enroll in [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/) for stronger authentication.

## Deploy a relying party STS

If you haven't already done so, [deploy AD FS](/windows-server/identity/ad-fs/ad-fs-deployment) or a similar identity technology on one or more Windows Servers at a site. This AD FS will be configured to operate as a relying party STS, so can't be the same installation as another AD FS configured as an identity provider to provide claims to Microsoft Entra.

   > [!NOTE]
   > If you're already using AD FS as an identity provider for Microsoft Entra, then this relying party STS should be a distinct installation on separate domain joined servers. Separating AD FS deployments by role will help to avoid a circular dependency between Microsoft Entra and AD FS.

   :::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/topology-trust-with-identity-provider-and-relying-party-sts.png" alt-text="Diagram showing the topology of having separate identity provider and relying party security token service connected to the same Active Directory.":::

 > [!NOTE]
 > This guide doesn't cover how to deploy AD for high availability or how to deploy [a federation server farm](/windows-server/identity/ad-fs/design/when-to-create-a-federation-server-farm) or other considerations for high availability in the Windows Server environment.

If you are using certificate based authentication, then you will also need to configure AD FS to authenticate users with certificates. For more information, see [Configure AD FS support for user certificate authentication](/windows-server/identity/ad-fs/operations/configure-user-certificate-authentication).

## Secure the relying party STS

The relying party STS will be trusted by applications to provide tokens indicating users have been authenticated. This requires that you ensure the STS, the servers hosting it, and any upstream domain controllers or other resources, are locked down to the same security standards as the other identity infrastructure in your environment.

For more information, see [Best practices for securing Active Directory Federation Services](/windows-server/identity/ad-fs/deployment/best-practices-securing-ad-fs).

## Connect federated applications to the relying party STS

You will need to identify which applications at a site are in scope for being connected to the relying party STS, rather than being connected directly to Microsoft Entra. This should be the minimum set needed to maintain operations during a loss of connectivity. Considerations include:

* Applications which rely solely on an [Microsoft Authentication Library (MSAL) SDK](~/identity-platform/msal-overview.md) for token issuance cannot be connected to a relying party STS.
* Applications which have been previously hardcoded with a single federation metadata endpoint or issuer certificate may require additional changes to remove that dependency prior to being integrated with a relying party STS.
* Applications which are capable of supporting multiple identity providers may wish to retain the existing connection to Microsoft Entra.
* The applications which are associated with a relying party STS will be represented as a single application in Microsoft Entra, so those applications will need to have the same users, CA policies, supplied claims, and other settings applicable to them. If two applications rely upon Microsoft Entra to limit token issuance to different user populations, or have different CA requirements, they cannot both be connected to the same relying party STS.

## Configure Microsoft Entra as an identity provider to the relying party STS

Perform the steps in the [Enable single sign-on for an enterprise application with a relying party security token service](~/identity/enterprise-apps/add-application-portal-setup-sso-rpsts.md) tutorial. In that tutorial, you create a representation of application in Microsoft Entra, configure single sign-on for that application from Microsoft Entra to the relying party STS, and configure single sign-on from the relying party STS to the application. Performing that tutorial will validate that, during normal operations, tokens with claims can flow from Microsoft Entra through the relying party STS to the application.

 > [!NOTE]
 > A single application representation is used in Microsoft Entra for each relying party STS, independent of the number of applications connected to that relying party STS. If you have multiple applications connected to a single relying party STS, then they will share a common application in Microsoft Entra, so must have the same users, CA policies, supplied claims, and other settings in Microsoft Entra.

## Configure AD as an LDAP source in the relying party STS

Next, configure in the relying party STS that Active Directory is a claims source for the claims needed by the applications. The following steps are shown using AD FS, but another relying party STS could be used instead.

1. Sign in as an administrator on a server where AD FS is deployed.
1. Launch `AD FS Management`.
1. In the `AD FS` menu, select `Claims Provider Trusts`.
1. Ensure that there are two claims providers, `Microsoft Entra` and `Active Directory`, and that both are enabled. The `Active Directory` claims provider is present by default. 
1. Select `Active Directory` and select `Edit Claim Rules`.
1. Confirm that there are rules for the LDAP attributes needed as claims by the applications in your environment.
1. In the `AD FS` menu, select `Relying Party Trusts`.
1. Select the target application and select `Edit Claim Issuance Policy`.
1. Confirm the rules for the claims sent to the applications provide all necessary claims. For more information, see [Pass through or Filter an Incoming Claim](/windows-server/identity/ad-fs/operations/create-a-rule-to-pass-through-or-filter-an-incoming-claim).

## Prepare an AD test user to be ready to sign-in to an application via Microsoft Entra

When testing the configuration, you should assign a designated test user that was created in Active Directory to a role of an application in Microsoft Entra. This choice of an AD user will validate that the user is able to sign on to the application via Microsoft Entra and the relying party STS.

1. Identify a test user in Active Directory. Ensure that you know the password of that user, so that you can authenticate as that user to both Active Directory and Microsoft Entra.
1. If you recently created the user in AD, wait for synchronization from AD to Microsoft Entra ID to finish.

   If you're using Microsoft Entra Cloud Sync, you can monitor the `steadyStateLastAchievedTime` property of the synchronization status by retrieving the [synchronization job](/graph/api/synchronization-synchronization-list-jobs?view=graph-rest-1.0&preserve-view=true&tabs=powershell#example) of the service principal that represents Microsoft Entra Cloud Sync. If you don't have the service principal ID, see [View the synchronization schema](~/identity/hybrid/cloud-sync/concept-attributes.md#view-the-synchronization-schema).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Enter the name of the existing application in the search box, and select the application from the search results.
1. In the **Manage** section of the left menu, select **Properties**.
1. Ensure that the value of **Enabled for users to sign-in** is set to **Yes**.
1. Ensure that the value of **Assignment required** is set to **Yes**.
1. If you made any changes, select **Save**.
1. In the **Manage** section of the left menu, select **Users and groups**.
1. Select **Add user/group**.
1. Select **None selected**.
1. In the search box, type the name of the test user, then pick the user and select **Select**.
1. Select **Assign** to assign the user to the default **User** role of the application.
1. In the **Security** section of the left menu, select **Conditional Access**.
1. Select **What if**.
1. Select **No user or service principal selected**, select **No user selected**, and select the user previously assigned to the application.
1. Select **Any cloud app**, and select the enterprise application.
1. Select **What if**. Validate that any policies that will apply allow the user to sign into the application.

## Set the claims provider for each application to be Microsoft Entra

After an application is configured in Microsoft Entra and your relying party STS, users can sign into it. Users will begin by authenticating to Microsoft Entra, and a token provided by Microsoft Entra will be transformed by your relying party STS, such as AD FS, into the format and claims required by your application. In addition, users will be able to sign into it by authenticating to AD, and have a token provided by AD FS with similar claims.

In this section, you'll configure the relying party STS to offer Microsoft Entra as the identity provider for each application during normal operations. The following steps are shown using AD FS, but another relying party STS could be used instead.

1. Launch PowerShell on a Windows Server where AD FS is installed.
1. Obtain the list of applications, using the command `Get-AdfsRelyingPartyTrust | ft Name,ClaimsProviderName`.
1. Obtain the list of claims providers, using the command `Get-AdfsClaimsProviderTrust | ft Name`. There should be two names, one for Active Directory and the other for Microsoft Entra.
1. Configure that Microsoft Entra is the sole claims provider for each application, using the [Set-AdfsRelyingPartyTrust](/powershell/module/adfs/set-adfsrelyingpartytrust) command. For example, if the application is named `appname`, then type `Set-AdfsRelyingPartyTrust -TargetName "appname" -ClaimsProviderName "Microsoft Entra"`. Repeat this for each application. For more information, see [Configure an identity provider list per relying party](/windows-server/identity/ad-fs/operations/home-realm-discovery-customization#configure-an-identity-provider-list-per-relying-party).

## Validate single sign-on during normal operations

In this section, you'll validate that users can seamlessly authenticate to Microsoft Entra and sign-in to an application during normal operations.

:::image type="content" source="~/identity/enterprise-apps/media/add-application-portal-setup-sso-rpsts/saml-redirects.png" alt-text="Diagram showing the web browser redirects between an application, a relying party STS, and Microsoft Entra ID as an identity provider.":::

1. In a web browser private browsing session, connect to an application and initiate the login process. The application redirects the web browser to the relying party STS AD FS, and AD FS determines the identity providers which can provide appropriate claims.
1. Based on the configuration in the previous section, AD FS will select the Microsoft Entra identity provider. AD FS redirects the web browser to the Microsoft Entra login endpoint, `https://login.microsoftonline.com` if using the Microsoft Entra ID global service.
1. Sign in to Microsoft Entra using the identity of the test user, previously configured in the section [prepare an AD test user to be ready to sign-in to an application](#prepare-an-ad-test-user-to-be-ready-to-sign-in-to-an-application-via-microsoft-entra). Microsoft Entra then locates the enterprise application based on the entity identifier, and redirects the web browser to AD FS at its reply URL endpoint, with the web browser transporting the SAML token.
1. AD FS validates the SAML token was issued by Microsoft Entra, then extracts and transforms the claims from the SAML token, and redirects the web browser to the application. Confirm that your application has received the required claims from Microsoft Entra via this process.

## Validate single sign-on after changing the claims provider trusted by the application to Active Directory

In this section, you'll validate that when you switch the identity provider for an application to Active Directory, users can still authenticate and sign-in to the application.

:::image type="content" source="media/resilience-for-federated-applications-with-colocated-users/saml-redirects-without-microsoft-entra.png" alt-text="Diagram showing the web browser redirects when Microsoft Entra ID is not configured as an identity provider for an application.":::

1. Launch PowerShell on a Windows Server where AD FS is installed.
1. In the PowerShell session, configure that Active Directory is now the sole claims provider for the application, replacing Microsoft Entra, using the command `Set-AdfsRelyingPartyTrust`. For example, if the application is named `appname`, then type `Set-AdfsRelyingPartyTrust -TargetName "appname" -ClaimsProviderName "Active Directory"`.
1. To clear any sign-in state in the browser, close any previously opened web browser private browsing session.
1. In a new web browser private browsing session, connect to that application and initiate the login process. The application redirects the web browser to AD FS, and AD FS determines the identity providers which can provide appropriate claims.
1. Based on the configuration in step 2, AD FS will select Active Directory.
1. Sign in to AD FS using the Active Directory identity of the test user. AD FS will authenticate the user in Active Directory.
1. AD FS transforms the LDAP attributes of the user into claims, and redirects the web browser to the application. Confirm that your application has received the required claims from Active Directory via this process.
1. In the PowerShell session, configure that Microsoft Entra is again the claims provider for the application, using the command `Set-AdfsRelyingPartyTrust` and provide the value of the `-ClaimsProviderName` parameter. You can also allow all claims providers with a command like `Set-AdfsRelyingPartyTrust -TargetName "appname" -ClaimsProviderName @()`.

## Configure who can sign-in to the application

You'll next need to configure who can sign-in to each application. AD FS and Microsoft Entra have different mechanisms for scoping token issuance in their policies, so you may need to make changes in both.

1. Previously you assigned a test user in Microsoft Entra to an application's role, you may wish to remove that test user's role assignment now.
1. If you have multiple applications connected to the same relying party STS, then in Microsoft Entra, you may only be able to have a single application object representing all those applications. For the role assignments, you can use features like dynamic groups or entitlement management to assign users to an application role. If the user has a role membership on the application role, then the user will be able to receive a token from Microsoft Entra.
1. In addition, AD FS also applies access control policies that are assigned to the applications. Any policy you select for the application needs to able to be evaluated by AD FS for both tokens from Microsoft Entra and for users which authenticate to AD. As tokens from Microsoft Entra do not pass through Active Directory, you can't use the **Permit specific group** access control policy, as that would deny Microsoft Entra tokens. If you wish to control access in AD FS for token issuance from AD, you'll need to use a different policy instead. For more information on access control policies, see [Access Control Policies in AD FS](/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

## Configure a task to perform automatic failover to AD and to Microsoft Entra

You'll next need to configure a monitor for connectivity from the site. This monitor will trigger an automatic switch of the identity provider for each application in AD FS from `Microsoft Entra` to `Active Directory` when a disconnect is detected, by invoking the `Set-AdfsRelyingPartyTrust` command for that application. Optionally, you may wish to configure a monitor to reset the AD FS configuration back to `Microsoft Entra` when connectivity is detected to have been restored.

For a simple environment, you can implement a monitor by using a PowerShell script and the built-in Task Scheduler. For a scaled out deployment, deploying a monitor depends upon the IT automation system in use in your organization and is outside of the scope of this article.

### Configuring an example scheduled task for AD FS to failover to AD

1. Create a script which detects a network connection failure from the site, and invokes `Set-AdfsRelyingPartyTrust` to change the identity provider. An example of a script can be found at [https://github.com/microsoft/Entra-reporting/blob/main/PowerShell/sample-changeover-multiple-apps.ps1](https://raw.githubusercontent.com/microsoft/Entra-reporting/refs/heads/main/PowerShell/sample-changeover-multiple-apps.ps1). Note that if you download a script, then you will need to use File Explorer to unblock the script before you can run it in PowerShell.
1. Copy the script to a Windows Server with AD FS.
1. Edit the script to match the AD FS configuration and list of applications configured in AD FS at that site.
1. Launch PowerShell on a Windows Server where AD FS is installed.
1. Register a source so the script can write to the Application event log. For example, if the script is named `AD FS changeover script`, then type the command `New-EventLog -LogName Application -Source "AD FS changeover script"`.
1. Launch **Event Viewer** and navigate to the newly created log.
1. Test the script by running it in PowerShell, to ensure it operates correctly from an interactive session.
1. Launch **Task Scheduler** and view the Task Scheduler Library.
1. If you don't already have a folder for your tasks in Task Scheduler, create a folder.
1. Select the folder for your tasks, then select **Create task**.
1. Fill out the **General** tab settings for the task.
1. Change to the **Triggers** tab. Select **New** and provide a recurrence schedule for your task, in alignment with your organization's risk and network guidance.
1. Change to the **Actions** tab. Select **New** and select an action to **Start a program**. Specify `powershell.exe` as the program, and specify arguments needed to invoke the PowerShell script. For example, `-NonInteractive -WindowStyle Hidden -File c:\scripts\ad_fs_changeover_script.ps1`. Then Select **OK** to close the action window and **OK** to close the task window. For more information, see [about powershell.exe](/powershell/module/microsoft.powershell.core/about/about_powershell_exe).
1. Select **Run**, wait one minute, then select **Refresh**. Ensure that the script started and completed successfully, and check **Event Viewer** to see if any errors were recorded.

### Configure session invalidation (optional)

Your applications may also have user sessions that are derived from the user having been authenticated. For example, a browser-based application may authenticate a user and then store a browser cookie indicating the user has been authenticated. You may wish to have your applications rely upon the disconnected identity providers for as short a period as possible. For example, if a user had not used an application before, and then the first time the user tried to connect to an application was when the site was disconnected, then the authentication was performed by Windows Server AD. Following that authentication, the application may have stored a session cookie for the user to be able to continue to interact with the application without needing to re-authenticate. However, once the site is reconnected, you may wish to have the user be re-authenticated by Microsoft Entra, so that the Microsoft Entra policies such as Conditional Access can be applied. This will require invalidating any session state for those users that was derived from Windows Server AD, such as by informing the application to not allow session state generated during a particular time window. How this is provided to the application will vary by applications.

## Complete configuration

After testing the initial sign-on configuration, you'll need to ensure that your relying party STS stays up to date as new certificates are added to Microsoft Entra. Some relying party STS may have a built-in process to monitor the federation metadata of the identity provider.

For more information on configuring AD FS for high availability, see how to deploy [a federation server farm](/windows-server/identity/ad-fs/design/when-to-create-a-federation-server-farm).

## Next steps

* [What is application management in Microsoft Entra ID?](~/identity/enterprise-apps/what-is-application-management.md)
* [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)
* [Enable single sign-on for an enterprise application with a relying party security token service](~/identity/enterprise-apps/add-application-portal-setup-sso-rpsts.md)

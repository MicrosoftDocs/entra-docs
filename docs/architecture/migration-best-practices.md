---
title: Best practices to migrate applications and authentication to Microsoft Entra ID
description: Learn best practices to migrate Active Directory Federation Service (AD FS) to cloud authentication in Microsoft Entra ID.
author: gargisinha
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 02/14/2023
ms.author: gasinh
ms.reviewer: martinco
---

# Best practices to migrate applications and authentication to Microsoft Entra ID

You've heard that [Azure Active Directory is now Microsoft Entra ID](https://www.microsoft.com/security/business/identity-access/microsoft-entra-id) and you're thinking it's a good time to migrate your Active Directory Federation Service (AD FS) [to cloud authentication (AuthN) in Microsoft Entra ID](/azure/active-directory/hybrid/connect/migrate-from-federation-to-cloud-authentication). As you review your options, see our extensive [resources to migrate apps to Microsoft Entra ID](/azure/active-directory/manage-apps/migration-resources), and best practices.

Until you're able to migrate AD FS to Microsoft Entra ID, protect your on-premises resources with [Microsoft Defender for Identity](/defender-for-identity/what-is). You can find and correct vulnerabilities proactively. Use assessments, analytics and data intelligence, user investigation priority scoring, and automatic response to compromised identities. Migration to the cloud means your organization can benefit from modern authentication, such as passwordless methods to authenticate.

Here are reasons that you might choose not to migrate AD FS:

- Your environment has flat usernames (such as employee ID).
- You need more options for [custom multifactor authentication providers](#custom-mfa-solutions).
- You use device authentication solutions from third-party Mobile Device Management (MDM) systems like VMware.
- Your AD FS is dual fed with multiple clouds.
- You need to air gap networks.

## Migrate applications

Plan a staged application migration rollout and select users to authenticate to Microsoft Entra ID for testing. Use guidance in, [plan application migration to Microsoft Entra ID](/azure/active-directory/manage-apps/migrate-adfs-apps-phases-overview) and, [resources to migrate apps to Microsoft Entra ID](/azure/active-directory/manage-apps/migration-resources).

Learn more in the following video, Effortless Application Migration Using Microsoft Entra ID. </br></br>
> [!VIDEO https://www.youtube.com/embed/qJYmEOK6UJo]

### Application migration tool

Currently in preview, [AD FS application migration to move AD FS apps to Microsoft Entra ID](~/identity/enterprise-apps/migrate-ad-fs-application-howto.md) is a guide for IT administrators to migrate AD FS relying party applications from AD FS to Microsoft Entra ID. The AD FS application Migration Wizard gives you a unified experience to discover, evaluate, and configure new Microsoft Entra applications. It has one-click configuration for basic SAML URLs, claims mapping, and user assignments to integrate an application with Microsoft Entra ID. There's end-to-end support to migrate on-premises AD FS applications, with these features:

- To help identify application usage and impact, evaluate AD FS relying party application sign-in activities
- To help determine migration blockers and required actions to migrate applications to Microsoft Entra ID, analyze AD FS to Microsoft Entra migration feasibility
- To automatically configure a new Microsoft Entra application for an AD FS application, configure new Microsoft Entra applications with a one-click application migration process

### Phase 1: Discover and scope apps

While [discovering apps](/azure/active-directory/manage-apps/migrate-adfs-discover-scope-apps), include in-development and planned apps. Scope them to use Microsoft Entra ID to authenticate after migration completes.

Use the [activity report to move AD FS apps to Microsoft Entra ID](/azure/active-directory/manage-apps/migrate-adfs-application-activity). This report helps you identify applications that can migrate to Microsoft Entra ID. It assesses AD FS applications for Microsoft Entra compatibility, checks for issues, and gives guidance on preparing individual applications for migration.

Use the [AD FS to Microsoft Entra App Migration Tool](https://github.com/AzureAD/Deployment-Plans/tree/master/ADFS%20to%20AzureAD%20App%20Migration) to collect relying party applications from your AD FS server and analyze configuration. From this analysis, the report shows which apps are eligible for migration to Microsoft Entra ID. For ineligible apps, you can review explanations of why they can't migrate.

Install [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) for on-premises environments with [Microsoft Entra Connect AD FS health agents](https://go.microsoft.com/fwlink/?LinkID=518973).

Learn more on, [What is Microsoft Entra Connect?](~/identity/hybrid/connect/whatis-azure-ad-connect.md)

### Phase 2: Classify apps and plan pilot

[Classifying the migration of apps](/azure/active-directory/manage-apps/migrate-adfs-classify-apps-plan-pilot) is an important exercise. Plan app migration and transition in phases after you decide the order in which you migrate apps. Include the following criteria for app classification:

- Modern authentication protocols, such as third-party Software as a service (SaaS) apps in the [Microsoft Entra application gallery](/azure/active-directory/manage-apps/overview-application-gallery) but not through Microsoft Entra ID.
- Legacy authentication protocols to modernize, such as third-party SaaS apps (not in the gallery, but you can add to the gallery).
- Federated apps that are using AD FS and can migrate to Microsoft Entra ID.
- Legacy authentication protocols NOT to modernize. Modernization might exclude protocols behind Web Application Proxy (WinSCP (WAP)) that can use [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy-configure-single-sign-on-with-kcd) and application delivery network/application delivery controllers that can use [Secure Hybrid Access](/azure/active-directory/manage-apps/secure-hybrid-access).
- New Line of Business (LOB) apps.
- Apps for deprecation might have functionality that is redundant with other systems and no business owner or usage.

When choosing the first apps for migration, keep it simple. Criteria can include SaaS apps in the gallery that support multiple identity provider (IdP) connections. There are apps with test-instance access, apps with simple claim rules, and apps controlling audience access.

### Phase 3: Plan your migration and test

[Migration and testing tools](/azure/active-directory/manage-apps/migrate-adfs-plan-migration-test) include the [Microsoft Entra apps migration toolkit](/azure/active-directory/manage-apps/migration-resources) to discover, classify, and migrate apps. Reference the list of [SaaS app tutorials](/azure/active-directory/saas-apps/tutorial-list) and the [Microsoft Entra Single Sign-on (SSO) deployment plan](/azure/active-directory/manage-apps/plan-sso-deployment) that walk through the end-to-end process.

Learn about [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy) and use the complete [Microsoft Entra application proxy deployment plan](https://aka.ms/AppProxyDPDownload). Consider [secure hybrid access (SHA)](/azure/active-directory/manage-apps/secure-hybrid-access) to protect your on-premises and cloud legacy authentication applications by connecting them to Microsoft Entra ID. Use [Microsoft Entra Connect](/azure/active-directory/hybrid/connect/whatis-azure-ad-connect-v2) to synchronize AD FS users and groups with Microsoft Entra ID.

### Phase 4: Plan management and insights

After you migrate apps, follow [management and insight guidance](/azure/active-directory/manage-apps/migrate-adfs-plan-management-insights) to ensure that users can securely access and manage apps. Acquire and share insights into usage and app health.

From the [Microsoft Entra admin center](https://entra.microsoft.com/), audit all apps using these methods:

- Audit apps with **Enterprise Applications, Audit**, or access the same information from the [Microsoft Entra reporting API](/azure/active-directory/reports-monitoring/howto-configure-prerequisites-for-reporting-api) to integrate into your favorite tools.
- View app permissions with **Enterprise Applications, Permissions** for apps using Open Authorization (OAuth)/OpenID Connect.
- Get sign-in insights with **Enterprise Applications, Sign-Ins** and from the [Microsoft Entra reporting API](/azure/active-directory/reports-monitoring/howto-configure-prerequisites-for-reporting-api).
- Visualize app usage from the [Microsoft Entra workbooks](/azure/active-directory/reports-monitoring/howto-use-workbooks).

### Prepare validation environment

Manage, troubleshoot, and report on Microsoft Identity products and services with [MSIdentityTools](https://www.powershellgallery.com/packages/MSIdentityTools/) in the PowerShell Gallery. Monitor your AD FS infrastructure with [Microsoft Entra Connect Health](/azure/active-directory/hybrid/connect/how-to-connect-health-adfs). Create test apps in AD FS and regularly generate user activity, monitoring the activity in the Microsoft Entra admin center.

As you [synchronize objects to Microsoft Entra ID](/azure/active-directory/hybrid/connect/how-to-connect-single-object-sync), check AD FS [relying party trust](/windows-server/identity/ad-fs/operations/create-a-relying-party-trust) claim rules for groups, users, and user attributes used on claims rules available in the cloud. Ensure container and attribute synchronization.

### Differences in app migration scenarios

Your app migration plan needs specific attention when your environment includes the following scenarios. Follow the links for further guidance.

- **Certificates.** ([AD FS global signing certificate](/windows-server/identity/ad-fs/design/certificate-requirements-for-federation-servers)). In Microsoft Entra ID, you can use one certificate per application or one certificate for all applications. Stagger expiration dates and configure reminders. Delegate certificate management to least-privileged roles. Review common questions and information [related to certificates that Microsoft Entra ID creates](/azure/active-directory/manage-apps/tutorial-manage-certificates-for-federated-single-sign-on) to establish federated SSO to SaaS applications.
- **Claim rules and basic attribute mapping.** For SaaS applications, you might need only basic attribute-to-claim mapping. Learn how to [customize SAML token claims](/azure/active-directory/develop/saml-claims-customization).
- **Extract username from UPN.** Microsoft Entra ID supports regex-based transformation (also related to [SAML token claim customization](/azure/active-directory/develop/saml-claims-customization)).
- **Group claims.** Emit group claims filtered by the users who are members and assigned to the application. You can [configure group claims for applications by using Microsoft Entra ID](/azure/active-directory/hybrid/connect/how-to-connect-fed-group-claims).
- **Web Application Proxy.** Publish with [Microsoft Entra application proxy](/azure/active-directory/app-proxy/application-proxy-configure-single-sign-on-with-kcd) to connect securely to on-premises web apps without a VPN. Provide remote access to on-premises web apps and native support for legacy authentication protocols.

### Application migration process plan

Consider including the following steps in your application migration process.

- **Clone the AD FS app configuration.** Set up a test instance of the app, or use a mock app on a test Microsoft Entra tenant. Map AD FS settings to Microsoft Entra configurations. Plan for a rollback. Switch the test instance to Microsoft Entra ID and validate.
- **Configure claims and identifiers.** To confirm and troubleshoot, mimic production apps. Point a test instance of the app to the Microsoft Entra ID test application. Validate and troubleshoot access, updating configuration as needed.
- **Prepare the production instance for migration.** Add the production application to Microsoft Entra ID based on the test results. For applications that allow multiple identity providers (IdPs), configure Microsoft Entra ID as an added IdP to the production instance.
- **Switch production instance to use Microsoft Entra ID.** For applications that allow multiple simultaneous IdPs, change the default IdP to Microsoft Entra ID. Otherwise, configure Microsoft Entra ID as the IdP to the production instance. Update the production instance to use the Microsoft Entra production application as primary IdP.
- **Migrate first app, run migration tests, and fix issues.** Reference migration status in [AD FS application activity reports](/azure/active-directory/manage-apps/migrate-adfs-application-activity) that provide guidance on how to address potential migration issues.
- **Migrate at scale.** Migrate apps and users in phases. Use Microsoft Entra ID to manage migrated apps and users while sufficiently testing authentication.
- **Remove the federation.** Confirm that your AD FS farm is no longer used for authentication. Use fail-back, back-up, and export related configurations.

## Migrate authentication

As you prepare for authentication migration, decide which [authentication methods](/azure/active-directory/hybrid/connect/choose-ad-authn) are needed for your organization.

- [Password hash synchronization (PHS) with Microsoft Entra ID](/azure/active-directory/hybrid/connect/whatis-phs) is available for failover, or as the primary end user authentication. Configure [risk detection](/azure/active-directory/identity-protection/concept-identity-protection-risks) as part of Microsoft Entra ID Protection. Review the [identify and remediate risk using Microsoft Graph API](/graph/tutorial-riskdetection-api) tutorial and learn how to [implement password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/connect/how-to-connect-password-hash-synchronization).
- [Microsoft Entra certificate-based authentication (CBA)](/azure/active-directory/authentication/concept-certificate-based-authentication) authenticates directly against Microsoft Entra ID without the need for a federated IdP. Key benefits include features that help improve security with phish-resistant CBA, and meet Executive Order (EO) 14028 requirements for phish-resistant multifactor authentication. You cut costs and risks associated with on-premises federation infrastructure, and simplify management experience in Microsoft Entra ID with granular controls.
- [Microsoft Entra Connect: Pass-through Authentication (PTA)](/azure/active-directory/hybrid/connect/how-to-connect-pta) uses a software agent to connect to passwords stored on-premises for validation. Users sign in to cloud apps with the same username and password for on-premises resources, working seamlessly with [Microsoft Entra Conditional Access](~/identity/conditional-access/overview.md) policies. Smart Lockout prevents brute force attacks. Install authentication agents on-premises with current Microsoft Windows Server Active Directory infrastructure. Use PTA if regulatory requirements specify that password hashes can't synchronize to Microsoft Entra ID; otherwise, use PHS.
- Current SSO experience without AD FS. [Seamless single sign-on (SSO)](/azure/active-directory/hybrid/connect/how-to-connect-sso-faq) provides an SSO experience from domain-joined devices in your corpnet (Kerberos). It works with PHS, PTA, and CBA and needs no other on-premises infrastructure. You can let users [sign in to Microsoft Entra ID with email as an alternate login ID](/azure/active-directory/authentication/howto-authentication-use-email-signin) using the same credentials as their on-premises directory environment. With hybrid authentication, users need one set of credentials.
- Recommendation: PHS over PTA, [passwordless authentication in Microsoft Entra ID](/azure/active-directory/authentication/howto-authentication-passwordless-deployment) with [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification), [FIDO2 security keys](/azure/active-directory/authentication/howto-authentication-passwordless-security-key), or [Microsoft Authenticator](/azure/active-directory/authentication/howto-authentication-passwordless-phone). If you plan to use [Windows Hello for Business hybrid certificate trust](/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust), migrate to Cloud trust first to reenroll all users.

### Password and authentication policies

With dedicated policies for on-premises AD FS and Microsoft Entra ID, align password expiry policies on-premises and in Microsoft Entra ID. Consider implementing a [combined password policy and check for weak passwords in Microsoft Entra ID](/azure/active-directory/authentication/concept-password-ban-bad-combined-policy#microsoft-entra-password-policies). After you switch to a managed domain, both password expiry policies apply.

Allow users to reset forgotten passwords with [Self-Service Password Reset (SSPR)](/azure/active-directory/authentication/concept-sspr-howitworks) to reduce help desk costs. Limit [device-based authentication methods](/azure/active-directory/devices/faq#how-can-users-change-their-temporary-or-expired-password-on-microsoft-entra-joined-devices). Modernize your password policy to have no periodic expirations with the ability to revoke when at risk. Block weak passwords and check passwords against banned password lists. Enable [password protection](/azure/active-directory/authentication/concept-password-ban-bad-combined-policy) for both on-premises AD FS and the cloud.

Migrate Microsoft Entra ID [legacy policy settings](/azure/active-directory/authentication/concept-authentication-methods-manage#legacy-mfa-and-sspr-policies) that separately control multifactor authentication and SSPR to unified management with the [Authentication methods policy](/azure/active-directory/authentication/concept-authentication-methods-manage). [Migrate policy settings](/azure/active-directory/authentication/how-to-authentication-methods-manage) with a reversible process. You can continue to use tenant-wide multifactor authentication and SSPR policies while you configure authentication methods precisely for users and groups.

Because Windows sign-in and other passwordless methods require detailed configuration, enable sign-in with [Microsoft Authenticator](/azure/active-directory/authentication/howto-authentication-passwordless-phone) and [FIDO2 security keys](/azure/active-directory/authentication/howto-authentication-passwordless-security-key). Use groups to manage deployment and scope users.

You can [configure sign-in autoacceleration using Home Realm Discovery](/azure/active-directory/manage-apps/configure-authentication-for-federated-users-portal?pivots=powershell-hrd). Learn to use autoacceleration sign-in to skip the username entry screen and automatically forward users to federated sign-in endpoints. [Prevent sign-in autoacceleration using the Home Realm Discovery policy](/azure/active-directory/manage-apps/prevent-domain-hints-with-home-realm-discovery?pivots=powershell-hrd) to have multiple ways to control how and where users authenticate.

### Account expiration policies

The **accountExpires** attribute of user account management doesn't synchronize to Microsoft Entra ID. As a result, an [expired Active Directory account](/azure/active-directory/hybrid/connect/how-to-connect-password-hash-synchronization#account-expiration) in an environment configured for password hash synchronization is active in Microsoft Entra ID. Use a scheduled PowerShell script to disable user Microsoft Windows Server Active Directory accounts after they expire, such as the [Set-ADUser cmdlet](/powershell/module/activedirectory/set-aduser?view=windowsserver2022-ps&preserve-view=true). Conversely, when removing the expiration from a Microsoft Windows Server Active Directory account, reenable the account.

With Microsoft Entra ID, you can [prevent attacks using smart lockout](/azure/active-directory/authentication/howto-password-smart-lockout). Lock accounts in the cloud before locking them on-premises to mitigate brute-force attacks. Have a shorter interval for the cloud, ensuring that the on-premises threshold is at least two to three times greater than the Microsoft Entra threshold. Set the Microsoft Entra lock-out duration longer than the on-premises duration. When your migration is complete, [configure AD FS Extranet Smart Lockout (ESL) protection](/windows-server/identity/ad-fs/operations/configure-ad-fs-extranet-smart-lockout-protection).

### Plan Conditional Access deployment

Conditional Access policy flexibility requires careful planning. Go to [Plan a Microsoft Entra Conditional Access deployment](/azure/active-directory/conditional-access/plan-conditional-access) for planning steps. Here are key points to keep in mind:

- Draft [Conditional Access policies](/azure/active-directory/conditional-access/concept-conditional-access-policies) with meaningful naming conventions
- Use a design decision points spreadsheet with the following fields:
  - [Assignment factors](/azure/active-directory/conditional-access/concept-conditional-access-users-groups): user, cloud apps
  - [Conditions](/azure/active-directory/conditional-access/concept-conditional-access-conditions): locations, device type, type of client apps, sign-in risk
  - [Controls](/azure/active-directory/conditional-access/concept-conditional-access-grant): block, multifactor authentication required, hybrid Microsoft Windows Server Active Directory joined, compliant device required, approved client app type
- Select small sets of test users for Conditional Access policies
- Test Conditional Access policies in [Reporting-only mode](/azure/active-directory/conditional-access/concept-conditional-access-report-only)
- Validate Conditional Access policies with the [what if policy tool](/azure/active-directory/conditional-access/what-if-tool)
- Use [Conditional Access templates](~/identity/conditional-access/concept-conditional-access-policy-common.md), especially if your organization is new to Conditional Access

### Conditional Access policies

When you complete first-factor authentication, enforce [Conditional Access policies](/azure/active-directory/conditional-access/concept-conditional-access-policies). Conditional Access isn't frontline defense for scenarios like denial-of-service (DoS) attacks. But Conditional Access can use signals from these events, such as sign-in risk and location of a request to determine access. The flow of a Conditional Access policy looks at a session and its conditions, then it feeds results into the central policy engine.

With Conditional Access, restrict access to [approved, modern authentication-capable, client apps with Intune app protection policies](/azure/active-directory/conditional-access/concept-conditional-access-grant#require-app-protection-policy). For older client apps that might not support app protection policies, restrict access to [approved client apps](/azure/active-directory/conditional-access/concept-conditional-access-grant#require-approved-client-app).

Automatically protect apps based on attributes. To change customer security attributes, use [dynamic filtering](/azure/active-directory/conditional-access/concept-filter-for-applications) of cloud applications to add and remove application policy scope. Use custom security attributes to target Microsoft first-party applications that don't appear in the Conditional Access application picker.

Use the Conditional Access [authentication strength](/azure/active-directory/authentication/concept-authentication-strengths) control to specify which combination of authentication methods access a resource. For example, make phishing-resistant authentication methods available to access a sensitive resource.

Evaluate [custom controls in Conditional Access](/azure/active-directory/conditional-access/controls). Users redirect to a compatible service to satisfy authentication requirements outside Microsoft Entra ID. Microsoft Entra ID verifies the response and, if the user authenticated or validated, then they continue in the Conditional Access flow. As mentioned in [Upcoming changes to Custom Controls](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/upcoming-changes-to-custom-controls/ba-p/1144696), partner-provided authentication capabilities work seamlessly with Microsoft Entra administrator and end user experiences.

<a name='custom-mfa-solutions'></a>

### Custom multifactor authentication solutions

If you use custom multifactor authentication providers, consider [migrating from Multi-Factor Authentication Server to Microsoft Entra multifactor authentication](/azure/active-directory/authentication/how-to-migrate-mfa-server-to-azure-mfa). If needed, use the [Multi-Factor Authentication Server Migration Utility to migrate to multifactor authentication](/azure/active-directory/authentication/how-to-mfa-server-migration-utility). [Customize the end user experience](/azure/active-directory/authentication/howto-mfa-mfasettings) with settings for account lockout threshold, fraud alert, and notification.

Learn how to [migrate to multifactor authentication and Microsoft Entra user authentication](/azure/active-directory/authentication/how-to-migrate-mfa-server-to-mfa-user-authentication). Move all applications, multifactor authentication service, and user authentication to Microsoft Entra ID.

You can [enable Microsoft Entra multifactor authentication](/azure/active-directory/authentication/tutorial-enable-azure-mfa) and learn how to create Conditional Access policies for user groups, configure policy conditions that prompt for multifactor authentication, and test user configuration and use of multifactor authentication.

The Network Policy Server (NPS) extension for multifactor authentication adds cloud-based multifactor authentication capabilities to your authentication infrastructure using your servers. If you use [Microsoft Entra multifactor authentication with NPS](/azure/active-directory/authentication/howto-mfa-nps-extension), determine what can migrate to modern protocols such as Security Assertion Markup Language (SAML) and OAuth2. Evaluate Microsoft Entra application proxy for remote access and use [secure hybrid access (SHA) to protect legacy apps with Microsoft Entra ID](/azure/active-directory/manage-apps/secure-hybrid-access).

### Monitor sign-ins

Use [Connect Health to integrate AD FS sign-ins](/azure/active-directory/hybrid/connect/how-to-connect-health-ad-fs-sign-in) to correlate multiple Event IDs from AD FS, depending on the server version, for information about request and error details. The [Microsoft Entra sign-ins report](/azure/active-directory/reports-monitoring/concept-all-sign-ins) includes information about when users, applications, and managed resources sign in to Microsoft Entra ID and access resources. This information correlates to the Microsoft Entra sign-in report schema and appears in the Microsoft Entra sign-in report user experience. With the report, a Log Analytics stream provides AD FS data. Use and modify the Azure Monitor Workbook template for scenario analysis. Examples include AD FS account lockouts, bad password attempts, and increases in unexpected sign-in attempts.

Microsoft Entra logs all sign-ins into an Azure tenant that includes internal apps and resources. Review sign-in errors and patterns to gain insight into how users access applications and services. [Sign-in logs in Microsoft Entra ID](/azure/active-directory/reports-monitoring/concept-sign-ins) are useful [activity logs](/azure/active-directory/reports-monitoring/howto-access-activity-logs) for analysis. Configure logs with up to 30 days [data retention](/azure/active-directory/reports-monitoring/reference-reports-data-retention), depending on licensing, and export them to [Azure Monitor](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-azure-monitor-logs), Sentinel, Splunk, and other security information and event management (SIEM) systems.

### Inside corporate network claims

Regardless of where requests originate or what resources they access, the [Zero Trust model](/security/zero-trust/zero-trust-overview) teaches us to "Never trust, always verify." Secure all locations as if they're outside the corporate network. Declare inside networks as [trusted locations](../identity/conditional-access/concept-assignment-network.md#trusted-locations) to reduce identity-protection false positives. Enforce multifactor authentication for all users and establish [device-based Conditional Access policies](/mem/intune/protect/create-conditional-access-intune).

Run a query on sign-in logs to discover users that connect from inside the corporate network, but aren't [Microsoft Entra hybrid joined or compliant](/azure/active-directory/conditional-access/howto-conditional-access-policy-compliant-device). Consider users on compliant devices and use of unsupported browsers such as Firefox or Chrome without the extension. Instead, use computer domain and compliance status.

### Staged authentication migration testing and cutover

For testing, use [Microsoft Entra Connect cloud authentication with Staged Rollout](/azure/active-directory/hybrid/connect/how-to-connect-staged-rollout) to control test user authentication with groups. Selectively test user groups with cloud authentication capabilities like [Microsoft Entra multifactor authentication](/azure/active-directory/authentication/tutorial-enable-azure-mfa), [Conditional Access](/azure/active-directory/conditional-access/overview), and [Microsoft Entra ID Protection](/azure/active-directory/identity-protection/overview-identity-protection). However, don't use Staged Rollout for incremental migrations.

To complete your migration to cloud authentication, use Staged Rollout to test new sign-in methods. Convert domains [from federated to managed](/azure/active-directory/hybrid/connect/migrate-from-federation-to-cloud-authentication#convert-domains-from-federated-to-managed) authentication. Start with a test domain or with the domain with the lowest number of users.

Plan domain cutover during off-business hours, in case a rollback is needed. To [plan for rollback](/azure/active-directory/hybrid/connect/migrate-from-federation-to-cloud-authentication#plan-for-rollback), use the current federation settings. See the [federation design and deployment guide](/windows-server/identity/ad-fs/deployment/windows-server-2012-r2-ad-fs-deployment-guide).

Include conversion of managed domains to federated domains in your rollback process. Use the [New-MgDomainFederationConfiguration](/powershell/module/microsoft.graph.identity.directorymanagement/new-mgdomainfederationconfiguration?view=graph-powershell-1.0&preserve-view=true) cmdlet. If necessary, configure extra claims rules. To ensure a completed process, leave Rollback Staged Rollout for 24 to 48 hours after cutover. Remove users and groups from Staged Rollout and then turn it off.

After cutover, every 30 days, roll over the key for [seamless SSO](/azure/active-directory/hybrid/connect/how-to-connect-sso-faq):

```azurecli
Update-AzureADSSOForest -OnPremCredentials $creds -PreserveCustomPermissionsOnDesktopSsoAccount
```

## Decommission AD FS

Monitor AD FS activity from [Connect Health Usage Analytics for AD FS](/azure/active-directory/hybrid/connect/how-to-connect-health-adfs#usage-analytics-for-ad-fs). First, [enable auditing for AD FS](/azure/active-directory/hybrid/connect/how-to-connect-health-agent-install#enable-auditing-for-ad-fs). Before you decommission the AD FS farm, ensure there's no AD FS activity. Use the [AD FS decommission guide](/windows-server/identity/ad-fs/decommission/adfs-decommission-guide) and the [AD FS decommission reference](/windows-server/identity/ad-fs/ad-fs-decommission). Here's a summary of key decommission steps.

1. Make a [final backup](/windows-server/identity/ad-fs/operations/ad-fs-rapid-restore-tool#create-a-backup) before decommissioning AD FS servers.
1. Remove AD FS entries from internal and external load balancers.
1. Delete corresponding Domain Name Server (DNS) entries for AD FS server farm names.
1. On the primary AD FS server, run [Get-ADFSProperties](/powershell/module/adfs/get-adfsproperties?view=windowsserver2022-ps&preserve-view=true) and look for **CertificateSharingContainer**.
   > [!NOTE]
   > Delete the Domain Name (DN) near the end of the installation, after a few reboots, and when it's no longer available.
1. Delete the AD FS configuration database, if it uses a SQL Server database instance as the store.
1. Uninstall WAP servers.
1. Uninstall AD FS servers.
1. Delete AD FS Secure Sockets Layer (SSL) certificates from each server storage.
1. Reimage AD FS servers with full disk formatting.
1. Delete your AD FS account.
1. Use Active Directory Service Interfaces (ADSI) Edit to remove the content of the **CertificateSharingContainer** DN.

## Next steps

- [Migrate from federation to cloud authentication in Microsoft Entra ID](~/identity/hybrid/connect/migrate-from-federation-to-cloud-authentication.md) explains how to deploy cloud user authentication with Microsoft Entra password hash synchronization (PHS) or pass-through authentication (PTA)
- [Resources to migrate apps to Microsoft Entra ID](~/identity/enterprise-apps/migration-resources.md) helps you migrate application access and authentication to Microsoft Entra ID
- [Plan application migration to Microsoft Entra ID](~/identity/enterprise-apps/migrate-adfs-apps-phases-overview.md) describes benefits of Microsoft Entra ID and how to plan to migrate your application authentication
- [Use Microsoft Entra Connect Health with AD FS](~/identity/hybrid/connect/how-to-connect-health-adfs.md) documentation about monitoring your AD FS infrastructure with Microsoft Entra Connect Health
- [Manage authentication methods](~/identity/authentication/concept-authentication-methods-manage.md) has authentication methods that support sign-in scenarios
- [Plan Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md) explains how to use Conditional Access to automate decisions and enforce organizational access policies for resources
- [Microsoft Entra Connect: Cloud authentication via Staged Rollout](~/identity/hybrid/connect/how-to-connect-staged-rollout.md) describes how to selectively test groups of users with cloud authentication capabilities before cutting over your domains
- [Active Directory Federation Services (AD FS) decommission guide](/windows-server/identity/ad-fs/decommission/adfs-decommission-guide) has decommissioning recommendations

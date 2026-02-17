---
title: "Cloud-first Identity Management: Guidance for IT Architects"
description: This is a guide for IT architects on how to transition their hybrid environment into a cloud-first approach. Including best practices, scenarios, and considerations of transferring source of authority to Microsoft Entra ID.
author: OWinfreyATL
ms.author: owinfrey
ms.reviewer: dhanyak
ms.date: 09/17/2025
ms.topic: concept-article
ms.service: entra-id
ms.subservice: hybrid


#customer intent: As an IT Architect, I want to learn best practices for beginning the process to transfer SOA and become cloud-first within my environment.

---

# Cloud-First identity management: Guidance for IT architects

Modern enterprises are under increasing pressure to improve security by modernizing identity management and streamlining operations. This document provides a strategic and technical framework for IT architects to shift user and group management from on-premises Active Directory (AD) to Microsoft Entra ID using Source of Authority (SOA) conversion. A legacy AD environment can be complex, costly to maintain, and if not kept up to date, increasingly vulnerable to modern threats. Microsoft's goal is to provide options to secure hybrid customers by allowing them to establish Microsoft Entra ID for identity management. Transferring SOA enables a phased, low-risk migration path—avoiding the disruption of a “big bang” cutover.

This guide provides IT architects with a comprehensive overview of cloud-first identity management. It explains the business and security benefits of moving to cloud-based identity, outlines a phased roadmap for transitioning from hybrid environments to cloud-first and AD-minimized states, and describes how to assess readiness for SOA transfer of users and groups. This guide also details an app-centric approach for organizations not yet ready to fully shift, covers integration strategies for Kerberos and LDAP-based applications, highlights key limitations and considerations for hybrid coexistence, and offers a practical checklist to support planning, execution, and governance throughout the migration process.

## Business and Security Benefits

Active Directory has long been considered the “**keys to the kingdom**” for organizations, making it an attractive target for attackers if compromised. Reducing reliance on AD, by migrating application authentication to use Microsoft Entra ID, improves security with users protected by Conditional Access and MFA. Migrating identities and authentication to Microsoft Entra ID also unlocks modern capabilities such as Conditional Access policies, password-less authentication, and advanced identity governance for users and applications, including those originally managed on-premises. In essence, centralizing management in Microsoft Entra ID strengthens an organization’s overall security posture.

### Enhance IT efficiency and user experience

A cloud-first approach can help enhance IT efficiency and user experience in your organization in the following ways:

- IT administrators can manage user identities, groups, and federated or provisioned application access policies through Microsoft Entra ID’s admin center and Microsoft Graph APIs.

- Microsoft Entra ID governance features such as Entitlement Management, Access Reviews, and Lifecycle Workflows streamline governance for apps relying on groups formerly managed in AD. This introduces automation, which helps compliance throughout the identity lifecycle.

- Users benefit from **single sign-on** across both cloud, and on-premises, applications using modern access controls such as risk-based conditional access policies. After migration, employees can use their Microsoft Entra ID credentials, such as phishing-resistant password-less methods, to seamlessly access legacy intranet applications. This reduces the need to manage multiple AD passwords and mitigates credential sprawl.

## Roadmap to Cloud Identity: Hybrid to Cloud-First/AD minimized state

Organizations typically advance through distinct stages on the “*road to the cloud*,” beginning with a **hybrid** approach that consists of using both cloud and on-premises AD within their environment. This is followed by the [cloud-first](../../architecture/road-to-the-cloud-posture.md#state-3-cloud-first) stage, where resources are increasingly shifted to the cloud. The next stage organizations achieve is the [AD-minimized](../../architecture/road-to-the-cloud-posture.md#state-4-active-directory-minimized) state. SOA transfer of users, groups, and contacts facilitates this journey by allowing incremental migration of identities to Microsoft Entra ID. Rather than decommissioning AD all at once, which would necessitate rewriting or re-platforming numerous applications, SOA enables a *phased approach*. With this approach, organizations can migrate suitable identities to the cloud immediately, and gradually reduce their AD footprint over time.

> [!NOTE]
> Always begin with an application inventory before initiating SOA transfer. This helps you maintain access for users tied to legacy AD apps.

## Scenarios you can unlock

### Minimize AD footprint for users and groups no longer needed in AD

After you transition to cloud services and modern applications, certain AD accounts and groups might become obsolete. Today these users and groups are still created in AD through traditional identity management solutions such as MIM. This is done because manually creating these objects in the cloud is an intensive manual effort. When you begin deciding for whom you want to transfer SOA, you can decide to remove AD out of the picture for these users and groups. This allows you to remove them from both AD and Microsoft Entra, or if they're only needed in Microsoft Entra, they can have their SOA transferred before being [removed from AD alone](how-to-active-directory-group-cleanup.md). This targeted transition allows organizations to automate the migration, and monitor its progress while minimizing operational disruption. For more information, see: [Minimizing AD Users and Govern user lifecycle with Microsoft Entra ID Governance](user-source-of-authority-overview.md#minimizing-ad-users-and-governing-user-lifecycle-with-microsoft-entra-id-governance).

### Shifting lifecycle management to the cloud

You can use Microsoft Entra ID Governance to enable lifecycle and access governance of SOA transferred users and groups from the cloud. For Users, this means you're now provisioning the users directly into Microsoft Entra ID and can use Microsoft Entra's ID Governance capabilities to govern these users. For groups, you can modernize your groups and enable access governance of apps tied to them from the cloud. Some caveats apply here where groups that are Exchange constructs like Mail-Enabled Security Groups (MESGs) and Distribution Lists (DLs), require modernization before being managed in the cloud. Refer to [Group SOA guidance for more info](../../identity/hybrid/concept-source-of-authority-overview.md).


## Is SOA the right solution for you?

The following diagram outlines if you're ready to transfer the source of authority (SOA) of users and groups:


:::image type="content" source="media/guidance-it-architects-source-of-authority/source-of-authority-readiness-diagram.png" alt-text="diagram of steps to take to prepare for source of authority transfer." lightbox="media/guidance-it-architects-source-of-authority/source-of-authority-readiness-diagram.png":::

### Considerations

**Users:** SOA is suitable for users who don't have any application dependencies linked to AD DS. Identifying which users are associated with specific applications is crucial for effective migration planning. 

**Groups:** For groups, we recommend you start with shifting security groups to the cloud. Once in the cloud, provision them back to AD from Microsoft Entra ID if needed. For Distribution Lists (DLs) and Mail-Enabled Security Groups (MESGs), our recommendation is to shift them once all your Exchange workloads is in the cloud, and you no longer need an On-premises Exchange server.

## Application-Centric Approach: Modernize on-premises authentication

This section outlines a principal cloud migration strategy for AD-heavy environments called the application-centric approach. This approach enables on-premises applications to utilize Microsoft Entra ID for identity. This section also includes detailed steps, prerequisites, and guidance for addressing challenges like legacy application password synchronization. The application-centric approach works for customers who are far into their password-less journey. For apps that require password, currently, there’s no path to shift users to the cloud.

The application-centric approach tackles cloud migration from the perspective of your applications. In this approach, you try to modernize your app authentication by applying the following framework:

- **Inventory Applications:** List all on-premises apps that use AD for authentication (Kerberos/NTLM or LDAP).

- **Integration Goal:** Reconfigure each app to use Microsoft Entra ID for authentication, reducing reliance on on-premises AD.

- **Bridging Solutions:** Use Microsoft Entra Application Proxy, Microsoft Entra Domain Services, or other cloud services to connect legacy apps to Microsoft Entra ID without major rewrites.

### Recommended sequence for application-centric migration

There can also be some apps already using modern protocols like SAML/OIDC via Active Directory Federation Service (AD FS) or third-party IdPs. These apps are easier to migrate directly to Microsoft Entra, while some other legacy cases like hardcoded NTLM-only apps, might need special handling.

## Application inventory and authentication analysis

It’s critical to **discover and categorize all on-premises applications** before planning the migration. The goal is to determine for each app: *How does it currently authenticate users*, and *what is the best path to integrate or modernize that authentication with Microsoft Entra ID?*

:::image type="content" source="media/guidance-it-architects-source-of-authority/application-inventory.png" alt-text="Checklist of what needs to be considered as far as application owners, and telemetry, before transferring source of authority.":::

A thorough application analysis forms the foundation for a successful migration to cloud-based identity management in AD-heavy environments. This process involves methodically assessing every application that depends on Active Directory for authentication, determining how each authenticates users, and mapping a modernization or integration plan that fits each application's unique requirements. The following steps are the recommended sequence for an app centric migration:

### Step 1. Cataloging Active Directory–Integrated applications

Start your migration by identifying all applications that use AD for authentication or authorization. Understand their dependencies to plan a move to cloud identity management, noting which AD groups and user accounts connect with each application. This helps prioritize which users and groups transition first, particularly those linked to business-critical apps.

#### Discover Active Directory–Integrated applications

Use tools like [Microsoft Entra Global Secure Access Application Discovery](../../global-secure-access/how-to-application-discovery.md) and AD Domain Controller logs to determine what apps employees are accessing, and how those apps interact with AD. Prioritize high-usage applications using dashboards that sort by user count and filter by individual user activity.

#### Map applications to AD Security Groups

For every app found, identify the AD security groups that control its access. Collaborate with owners, or review configurations, to list these groups. Use scripts or AD queries when necessary to locate relevant groups, especially if group names or descriptions reference the app. For more information on identifying security groups, see: [Clean up unused Active Directory Domain Services groups in a single domain](how-to-active-directory-group-cleanup.md).

#### Identify users for each application

Determine users by extracting group memberships for each application's AD groups and analyzing actual usage data. Combine membership lists and usage logs to create a definitive list of users for each app. Use this information to guide cloud migration planning, ensuring access is maintained throughout the process.

###  Step 2. Determine authentication method

For each application in your inventory, identify the authentication mechanism it uses. This step is essential for choosing the most appropriate migration, or integration, strategy. The main categories to consider include:

- **Integrated Windows Authentication (Kerberos/NTLM)** – Common in IIS/.NET applications using Windows Authentication, file servers, SharePoint, and similar platforms. These typically allow users to sign in with domain credentials, often without a separate prompt.

- **LDAP Authentication/Queries** – Applications can have [LDAP server settings pointing to AD](../../architecture/auth-ldap.md) and perform binds or lookups, custom-developed or third-party products prompting users for AD credentials.

- **Federation/Modern Authentication** – Some applications are already federated via [AD FS](/windows-server/identity/ad-fs/ad-fs-overview), or support modern protocols such as SAML or OAuth. These can generally be reconfigured to use Microsoft Entra ID with minimal effort.

- **Other Legacy Methods** – Includes cases where apps use RADIUS against AD or local accounts. Though not the primary focus, these should be documented for completeness. For more information, see: [RADIUS authentication with Microsoft Entra ID](../../architecture/auth-radius.md).

### Step 3. Assess modernization feasibility

Evaluate each application's ability to adopt modern authentication protocols (SAML/OIDC) natively. If a vendor update is available, or if the app was developed in-house and can be re-coded, transitioning to Microsoft Entra ID as the identity provider is typically the best long-term solution. This approach removes AD dependency and unlocks the full benefits of cloud identity management. However, for older applications that can't be easily updated, plan for a "*bridge*" solution to integrate them with Microsoft Entra ID, even if indirect integration is required.

Some older applications might have hard-coded assumptions about AD such as expecting to find a user in a specific OU, or writing attributes to AD. Those apps are **out of scope** for this kind of identity migration. These applications aren't easily supported by Microsoft Entra ID or Microsoft Entra Domain Services unless you keep write permissions there, which is possible, but then you have divergent data. Make sure to identify if any app does LDAP writes or depends on obscure AD features such as dynamic auxiliary classes. Those might have to remain on AD until they’re retired. The focus should be on apps that *read/authenticate* via AD as those can be moved to cloud auth as described.


### Step 4. Categorize applications and plan integration approach

After you determine authentication methods and modernization feasibility, group applications into distinct categories to guide your integration plan:

- **Minimize number of Apps that you need to manage:** For apps that are in plans to be sunset with a target date, these can be considered out of scope and any management of users/groups tied to these apps can be shifted to the cloud. For apps that are redundant, consolidate the app and determine if it can be modernized or not.

- **Apps already using or capable of modern auth:** These can be migrated directly to Microsoft Entra ID as the identity provider, such as updating AD FS applications to point to Microsoft Entra ID or moving files to Azure file shares. While not the central focus, addressing these reduces overall legacy dependency. Any management of users/groups tied to these apps is in scope to be transferred to the cloud.

- **Kerberos/NTLM Apps (not easily modernized):** Use Microsoft Entra as a front-end through Application Proxy or similar solutions. The application remains on-premises, but user authentication switches to Microsoft Entra ID tokens, which are translated into Kerberos tickets within AD.

- **LDAP-Binding Apps:** Introduce a managed AD instance in Azure, specifically Microsoft Entra Domain Services, allowing these apps to bind to a cloud-managed AD instead of the on-premises environment.

- **Other Special Cases:** For applications that can't be altered or proxied, such as older client-server apps limited to AD joined machines, consider hosting them on VDI solutions like Azure Virtual Desktop, Windows 365 Cloud PC, or others. This maintains a managed environment for these apps while enabling cloud migration elsewhere. This should be a last resort due to added complexity and cost.

- **Disconnected apps:** For apps that have business requirements of working without internet connections or work in a disconnected environment, you need to stay on-premises. Users using these apps aren't eligible to transfer SOA.

### Step 5. Mapping and planning

By concluding the analysis phase, you should have a clear mapping of which applications fall into the "*Kerberos category*," "*LDAP category*," or other buckets, along with the specific integration mechanism each will require. This planning step is vital as each application has unique characteristics that must be carefully considered before selecting a migration strategy. Microsoft Entra ID fortunately offers solutions for most AD-based authentication patterns, and even legacy applications that can't be modified can benefit from secure hybrid access and modern governance.

### Step 6. Migrate groups to the cloud

In an app-centric approach, it's best to migrate security groups and app access controls to the cloud first. This enables centralized access management, and ensures group memberships remain intact before moving users. Microsoft recommends transferring group's SOA ahead of users to maintain membership integrity and allow testing. You can also adjust the sequence for each app, such as piloting an application with its groups, and test users end-to-end. When shifting to the cloud, we have outlined specific guidance on how you can map them to cloud groups as outlined in [Guidance for using Group Source of Authority (SOA) in Microsoft Entra ID](../../identity/hybrid/concept-group-source-of-authority-guidance.md) or watch the following video:

> [!VIDEO https://www.youtube.com/embed/VpRDtulXcUw]


> [!TIP]
> Migrate security groups to the cloud first. This allows you to test app access controls before moving user

### Step 7. Handling LDAP-based applications (Directory-Bound Apps)

**LDAP-bound applications** or services directly query Active Directory Domain Services (AD DS) via LDAP, most often for authentication using a simple bind with username and password, or for directory reads. Common examples include older enterprise applications, network appliances, or custom-developed apps that rely on LDAP binds to validate credentials. These applications typically require an LDAP server, and can't easily transition to modern authentication protocols. For more information, see: [LDAP authentication with Microsoft Entra ID](../../architecture/auth-ldap.md).

#### Recommended Solution: Microsoft Entra Domain Services

The recommended solution for supporting LDAP-bound apps in the cloud is Microsoft Entra Domain Services. Hosted on Azure, Microsoft Entra Domain Services provides LDAP, Kerberos, and NTLM endpoints, syncing user accounts, and credentials from your Microsoft Entra ID tenant. This allows legacy applications to use cloud-hosted AD for authentication without switching
to modern protocols. The managed domain mainly supports read and authentication for LDAP clients. For more information, see: [What is Microsoft Entra Domain Services?](../../identity/domain-services/overview.md)

### Step 8. Handling Kerberos-Based Applications (Windows Integrated Auth)

**Kerberos-based apps** typically encompass internal web applications using Windows Authentication, file servers (SMB) that rely on Kerberos tickets, and other services where Active Directory (AD) sign in is required. Microsoft offers intermediary solutions to integrate these applications with Microsoft Entra ID.

**Microsoft Entra Application Proxy or Private Access with Kerberos Constrained Delegation (KCD):**

*Recommended solution:*

- **Microsoft Entra Application Proxy or Private Access with Kerberos Constrained Delegation (KCD):** This cloud service enables the publication of an on-premises web application through Microsoft Entra ID. Users authenticate to Microsoft Entra ID, such as using OAuth/OpenID Connect, and the Application Proxy connector operating on-premises obtains a Kerberos ticket to the backend application on the user’s behalf using KCD. Microsoft Entra ID serves as the authentication gateway, translating authentication to Kerberos for the application. This solution supports web-based applications (HTTP/HTTPS) and can provide single sign-on (SSO) for cloud-managed users *provided those users have an account in AD*. For more information, see: [Microsoft Entra Application Proxy](../../identity/app-proxy/overview-what-is-app-proxy.md) and [Microsoft Entra Private Access](../../global-secure-access/concept-private-access.md)

- **Passwordless with Cloud Kerberos Trust:** This method lets Microsoft Entra ID
issue Kerberos tickets for on-premises AD resources when users sign in with Microsoft Entra ID credentials using password-less authentication such as Windows Hello for Business and FIDO2. It requires configuring the AD domain to trust Microsoft Entra ID’s cloud Kerberos service and ensuring users’ AD objects have the necessary keys. The process is fully password-less, making it ideal for cloud users to access on-premises resources. For more information, see: [Cloud Kerberos Trust](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust).

### Key Considerations Before Migrating Kerberos Workloads

The following are key considerations for Kerberos applications before shifting  user and group workloads associated with these apps:

- **User lifecycle management:** Even after you transition a user to cloud management, an AD account with matching UserPrincipalName must remain for Kerberos functionality.

- **Authentication and Attributes:** Don't migrate users who require access to applications that rely on passwords to authenticate, and can't be updated to use Kerberos authentication. Applications that can support Kerberos authentication and query attributes from Active Directory require those attributes to be in sync, potentially using a dual-write to Microsoft Entra ID and Active Directory.

- **Microsoft Entra ID joined devices:** For true single sign-on, devices accessing Kerberos resources should be Microsoft Entra ID-joined or hybrid-joined. When a user logs into a device using Microsoft Entra ID credentials, the device can obtain a token from Microsoft Entra ID that's convertible to a Kerberos ticket via trust or connector. If a device is only domain-joined, and the user is cloud-managed, seamless SSO can be difficult, possibly requiring manual credential entry. Microsoft recommends migrating devices to Microsoft Entra ID join with cloud trust as part of cloud transformation so that user and device trust are aligned. 

    > [!NOTE]
    > Device migration is outside the current scope for transferring SOA.

- **Conditional Access for on-prem apps:** Once App Proxy or Microsoft Entra Private Access is deployed for an application, Conditional Access policies such as MFA can be enforced on application access since authentication passes through Microsoft Entra ID. This enhances security as even legacy apps benefit from Zero Trust conditions without modification. For Kerberos trust scenarios, Conditional Access applies when the user initially authenticates to Microsoft Entra ID on the device.


### Step 9. Verify and optimize


Test each integrated application thoroughly. Ensure that existing AD-sourced users can access the application via the new method. Verify that group memberships from Microsoft Entra ID are honored via group provisioning to AD. Monitor performance and sign in logs. Optimize any settings for production use.

Ensure that all users whose source of authority was transferred are able to still access the application. Ensure that group memberships that were present in AD is also present in Microsoft Entra ID. Verify using [Group logs](how-to-source-of-authority-auditing-monitoring.md) and [User logs](user-source-of-authority-audit-monitor.md) that source of authority was successfully transferred.



## Conclusion

The following table is a summary of the options for handling on-premises apps in a cloud-first model:


| App Type | Cloud Integration Method & Tools | Requirements & Considerations |
|:--------:|:-------------------------------:|:-----------------------------|
| **Kerberos-based Apps**<br>(Windows Integrated Authentication, intranet web apps, file shares) | **Microsoft Entra ID Application Proxy with Kerberos (KCD):** Publish on-prem web apps through Microsoft Entra ID and use a connector for Kerberos on-prem.<br>**Microsoft Entra ID Cloud Kerberos Trust:** For Microsoft Entra ID joined devices (non-web, e.g. file shares). | **Requirements:**<br>- Microsoft Entra Private Access installed on-prem<br>- Configured SPN and delegation rights<br>- Entra ID P1/P2 or Suite licenses<br>- AD account for user (synced or provisioned)<br>**Considerations:**<br>- Provides seamless SSO using Entra ID credentials or go passwordless for Kerberos based apps and use phish-resistant method to secure and access on-premises resources |
| **LDAP-based Apps**<br>(Apps that bind to AD DS over LDAP for auth/queries) | **Entra ID Domain Services (Managed AD):** Cloud-hosted AD domain synced with Microsoft  ID; repoint app’s LDAP connection to this domain (LDAPS). | **Requirements:**<br>- Set up Microsoft Entra Domain Services instance in Azure<br>- Configure virtual network, secure LDAP cert, firewall rules<br>- Users/groups must be in Microsoft Entra ID (synced to Microsoft Entra Domain Services)<br>- May require password reset to generate hashes<br>**Considerations:**<br>- Minimal app changes (just new LDAP endpoint)<br>- Cloud users’ passwords present in Microsoft Entra ID DS<br>- If Microsoft Entra Domain Services not feasible, fallback is provisioning users into on-prem AD and maintaining password parity manually |





## SOA Transfer Checklist for IT Architects

### Understand Strategic Benefits

- Reduce security risks by minimizing on-premises AD dependency.

- Enable modern identity features (Conditional Access, password-less,
  Zero Trust).

- Streamline identity management and governance in Microsoft Entra ID.

### Assess Readiness

- Inventory all users, groups, and applications.

- Identify users/groups no longer tied to AD-dependent apps.

- Map authentication dependencies for each application (Kerberos, LDAP, SAML/OIDC).

### Plan Group Migration

- [Shift security groups to the cloud](concept-source-of-authority-overview.md); provision back to AD from Microsoft Entra ID if needed.

- Shift DLs and MESGs only after Exchange workloads are fully cloud-based.

### Modernize Application Authentication

- For Kerberos/NTLM apps:  
  [Cloud Kerberos Trust](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust)

- For LDAP apps:  
  [LDAP Overview](/entra/architecture/auth-ldap)

- For modern/federated apps:  
  Reconfigure to authenticate directly against Microsoft Entra ID (SAML/OIDC).

### Enable Password-less Authentication

- Deploy [Hello For Business](/windows/security/identity-protection/hello-for-business)

- Integrate with [cloud kerberos trust](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust) for seamless ticket-based authentication.

### Implement Entra ID Governance

- [Lifecycle Workflows in Microsoft Entra ID](/entra/id-governance/what-are-lifecycle-workflows)
- [Entitlement Management Overview](/entra/id-governance/entitlement-management-overview)
- [Access Reviews Overview](/entra/id-governance/access-reviews-overview)
- [Privileged Identity Management for Resource Roles](/entra/id-governance/privileged-identity-management/pim-configure)

### Address Key Limitations

- No password writeback for cloud-only users. Keep hybrid directory if you need writeback

- Legacy apps with hardcoded AD dependencies might require custom proxies or remain on-premises.

### Monitor & Iterate

- Track migration progress: users/groups converted, apps modernized.

- Continuously review security posture and compliance.

> [!TIP]
> Always start with an app-centric analysis to avoid breaking access for users tied to legacy AD apps. Use phased migration to avoid a “*big bang*” cutover.

## Next step


- [Embrace cloud-first posture: Convert Group Source of Authority to the cloud](concept-source-of-authority-overview.md)
- [Embrace cloud-first posture: Transfer User Source of Authority (SOA) to the cloud](user-source-of-authority-overview.md)
---
title: "Cloud-First Identity Management: Guidance for IT Architects"
description: This is a guide for IT architects on how to transition their hybrid environment into a cloud-first approach. Including best practices, scenarios, and considerations.
author: OWinfreyATL
ms.author: owinfrey
ms.reviewer: owinfrey
ms.date: 09/18/2025
ms.topic: concept-article
ms.service: entra-id
ms.subservice: hybrid
ms.reviewer: dhanyak

#customer intent: As an IT Architect, I want to learn best practices for beginning the process to transfer SOA and become cloud-first within my environment.

---

# Cloud-First Identity Management: Guidance for IT Architects

Modern enterprises are under increasing pressure to modernize identity management, reduce security risks, and streamline operations. This guide provides a strategic and technical framework for IT architects to shift user and group management from on-premises Active Directory (AD) to Microsoft Entra ID using Source of Authority (SOA) conversion. Legacy AD environments are complex, costly to maintain, and increasingly vulnerable to modern threats. Microsoft’s long-term vision is to minimize on-premises AD dependencies, and move identity workloads to the cloud. SOA conversion enables a phased, low-risk migration path—avoiding the disruption of a “*big bang*” cutover.

**This guide covers the following areas**:

1. [The business and security benefits of cloud-based identity](guidance-for-it-architects-for-source-of-authority-conversion.md#business-and-security-benefits).

1. [A phased roadmap from going from hybrid, to cloud-first, to AD-minimized environments](guidance-for-it-architects-for-source-of-authority-conversion.md#roadmap-to-cloud-identity-hybrid-to-cloud-firstad-minimized-state).

1. [Criteria to determine SOA readiness for users and groups]().

1. [An app-centric approach to shift your user and group management to the cloud if you aren't yet ready]().

1. [Integration strategies for Kerberos and LDAP-based applications]().

1. [Key limitations and considerations for hybrid coexistence]().

1. [A practical checklist to guide planning, execution, and governance]().

## Business and Security Benefits

Active Directory has long been considered the **“keys to the kingdom”** for organizations, making it an attractive target for attackers if compromised. By shifting towards a cloud first approach, you are able to see business and security benefits in the following ways:

### Reducing reliance on AD

A breach of on-premises AD can result in broad access to corporate resources. By shifting to Microsoft Entra ID, you gain access to robust, integrated security controls. Migrating identities and authentication to Microsoft Entra ID also unlocks **modern capabilities** such as Conditional Access policies, password-less authentication, and advanced identity governance for users and applications, including those originally managed on-premises. Centralizing management using Microsoft Entra ID enhances an organization’s security posture by allowing you to take advantage of these capabilities.



### Enhanced IT efficiency and user experience

A cloud-first approach can help enhance IT efficiency and user experience in your organization in the following ways:

- IT administrators can manage identities, groups, and access policies centrally through Microsoft Entra ID’s admin center and Microsoft Graph APIs. This reduces the usage of legacy AD administration tools, and minimizes the footprint of complex on-premises IAM infrastructure. This reduces risk surface area, and streamlines administration.

- Microsoft Entra ID governance features such as Entitlement Management, Access Reviews, and Lifecycle Workflows streamline governance for apps relying on groups formerly managed in AD. This introduces automation to ensure compliance throughout the identity lifecycle.

- Users benefit from **single sign-on** across both cloud, and on-premises, applications using modern access controls such as risk-based conditional access policies. After migration, employees can use their Microsoft Entra ID credentials, such as phishing-resistant password-less methods,to seamlessly access legacy intranet applications. This reduces the need to manage multiple AD passwords and mitigates credential sprawl.

## Roadmap to Cloud Identity: Hybrid to Cloud-First/AD Minimized state.

Organizations typically advance through distinct stages on the “*road to the cloud*,” beginning with a **hybrid** approach that consists of using both cloud and on-prem AD within their environment. This is followed by the [cloud-first](../../architecture/road-to-the-cloud-posture.md#state-3-cloud-first) stage, where resources are increasingly shifted to the cloud. The final stage organizations achieve is the [AD-minimized](../../architecture/road-to-the-cloud-posture.md#state-4-active-directory-minimized) state. Source of Authority (SOA) transfer for users, groups, and contacts facilitates this journey by allowing incremental migration of identities to Microsoft Entra ID. Rather than decommissioning AD all at once, which would necessitate rewriting or re-platforming numerous applications, SOA enables a *phased approach*. With this approach, organizations can migrate suitable identities to the cloud, and gradually reduce their AD footprint over time.

> [!NOTE]
> Always begin with an application inventory before initiating SOA transfer. This ensures you don’t break access for users tied to legacy AD apps.

## Scenarios you can unlock

### Minimize AD footprint for Users and Groups No Longer Needed in AD

After transitioning to cloud services and modern applications, certain AD accounts and groups might become obsolete. Today, these users and groups are still being created in AD through traditional identity management IDP solutions such as MIM since manually creating these in the cloud is a high effort manual effort. With SOA, you can now decide to remove AD out of the picture for these users and groups. They can be converted to cloud-only (SOA) and removed from AD. This targeted transition allows organizations to automate the migration and monitor its progress—such as the percentage of groups and users migrated—while minimizing operational disruption.

### Shifting Lifecycle Management to the Cloud

You can now use Microsoft Entra ID Governance to enable lifecycle and access governance of SOA transferred users and groups from the cloud. For Users, this means, you are now provisioning the users directly into Microsoft Entra ID and can use Microsoft Entra ID Governance capabilities to govern these users. You can also use Microsoft Entra ID as your authentication provider to secure and access on-premises AD resources using Entra Private Access. For groups, you can modernize your groups and enable access governance of apps tied to them from the cloud. Some caveats apply here where groups that are Exchange constructs like mail-enabled security groups and Distribution Lists, require modernization before being managed in the cloud. Refer to [Group SOA guidance for more info](../../identity/hybrid/concept-source-of-authority-overview.md).

> [!TIP]
> Use Microsoft Entra ID Governance features like Access Reviews and Lifecycle Workflows to automate compliance and reduce manual overhead.

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/image1.png" alt-text="Screenshot of a green and red sign indicating AI-generated content may be incorrect.":::

## Is SOA the right solution for you? (ARTICLE 2)

The following diagram outlines if you are ready to transfer the source of authority (SOA) of users and groups:

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/source-of-authority-readiness-diagram.png" alt-text="Screenshot of a diagram of steps to show if you are ready to transfer source of authority.":::

### Considerations

**Users:** For users who are still tied to legacy applications and dependence on AD DS, SOA is not recommended due to gaps in capabilities present today in the cloud to manage password based applications. Identifying which applications require passwords vs. not and planning their migration is critical.

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/image1.png" alt-text="A green and red signs AI-generated content may be incorrect.":::

**Groups:** For groups, we recommend you start with shifting security groups to the cloud and provisioning them back to AD from Microsoft Entra ID if needed. For DLs and MESGs, our recommendation is to shift them once all your exchange workload is in the cloud and you no longer need On-premises Exchange server.


## Application-Centric Approach: Modernize On-Prem Authentication (ARTICLE 3)

This guide outlines principal cloud migration strategy for AD-heavy environments: the application-centric approach, which enables on-premises applications to utilize Microsoft Entra ID for identity. Detailed steps, prerequisites, and guidance for addressing challenges such as password synchronization for legacy applications are also included.

## Application-Centric Approach: Modernize On-Prem Authentication

**The application-centric approach tackles the problem from the perspective of your applications.** In this approach, you try to modernize your app authentication by leveraging the following framework:

- **Inventory Applications:** List all on-premises apps that use AD for authentication (Kerberos/NTLM or LDAP).

- **Integration Goal:** Reconfigure each app to use Microsoft Entra ID for authentication, reducing reliance on on-prem AD.

- **Bridging Solutions:** Use Microsoft Entra Application Proxy, Microsoft Entra Domain Services, or other cloud services to connect legacy apps to Microsoft Entra ID without major rewrites.

There may also be some apps already using modern protocols (SAML/OIDC via AD FS or third-party IdPs) – those are easier to migrate directly to Entra ID, and some truly legacy cases (like hardcoded NTLM-only apps) that might need special handling. Below is the recommended sequence for an app centric migration.

## Recommended sequence for application-centric migration:

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/source-of-authority-phase-list.png" alt-text="A screenshot of an overview of the phases to complete application-centric migration.":::

# [Phase 1: Application Inventory and Authentication Analysis](#tab/application-inventory)

It’s critical to **discover and categorize all on-premises applications** before planning the migration. The goal is to determine for each app: *How does it currently authenticate users, and what is the best path to integrate or modernize that authentication with Microsoft Entra ID?*

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/application-inventory.png" alt-text="Visualization":::

A thorough application analysis forms the foundation for a successful migration to cloud-based identity management in AD-heavy environments. The process involves methodically assessing every application that depends on Active Directory for authentication, determining how each authenticates users, and mapping a modernization or integration plan that fits each application's unique requirements.

### Step 1: Cataloging Active Directory–Integrated Applications

Start your migration by identifying all applications that Active Directory (AD) for authentication or authorization. Understand their dependencies to plan a move to cloud identity management, noting which AD groups and user accounts connect with each application. This helps prioritize which users and groups transition first, particularly those linked to business-critical apps.

#### Discover Active Directory–Integrated Applications

Use tools like Microsoft Entra Global Secure Access Application Discovery and AD Domain Controller logs to determine what apps employees are accessing and how those apps interact with AD. Prioritize high-usage applications using dashboards that sort by user count and filter by individual user activity.

#### Map Applications to AD Security Groups

For every app found, identify the AD security groups that control its access. Collaborate with owners or review configurations to list these groups. Use scripts or AD queries when necessary to locate relevant groups, especially if group names or descriptions reference the app.

#### Identify Users for Each Application

Determine users by extracting group memberships for each application's AD groups and analyzing actual usage data through analytics platforms. Combine membership lists and usage logs to create a definitive list of users for each app. Use this information to guide cloud migration planning, ensuring access is maintained throughout the process.

###  Step 2. Determine Authentication Method

For each application in your inventory, identify the authentication mechanism it uses. This step is essential for choosing the most appropriate migration or integration strategy. The main categories to consider include:

- *Integrated Windows Authentication (Kerberos/NTLM)* – Common in
  IIS/.NET applications using Windows Authentication, file servers,
  SharePoint, and similar platforms. These typically allow users to log
  in with domain credentials, often without a separate prompt.

- *LDAP Authentication/Queries* – Applications may have LDAP server
  settings pointing to AD and perform binds or lookups, usually
  custom-developed or third-party products prompting users for AD
  credentials.

- *Federation/Modern Authentication* – Some applications are already
  federated via AD FS or support modern protocols such as SAML or OAuth.
  These can generally be reconfigured to use Entra ID with minimal
  effort.

- *Other Legacy Methods* – Includes cases where apps use RADIUS against
  AD or local accounts. Though not the primary focus, these should be
  documented for completeness.

### Step 3. Assess Modernization Feasibility

Evaluate each application's ability to adopt modern authentication protocols (SAML/OIDC) natively. If a vendor update is available or if the app is in-house and can be re-coded, transitioning to Microsoft Entra ID as the identity provider is typically the best long-term solution. This approach removes AD dependency and unlocks the full benefits of cloud identity management. However, for older applications that cannot be easily updated, plan for a "bridge" solution to integrate them with Microsoft Entra ID, even if indirect integration is required.

Some older applications may have hard-coded assumptions about AD such as expecting to find a user in a specific OU, or writing attributes to AD. Those apps are **out of scope** for this kind of identity migration. Applications that *write*, and not just read, to LDAP are particularly problematic. These applications are not easily supported by Microsoft Entra ID or Microsoft Entra ID DS unless you keep write permissions there, which is possible, but then you have divergent data. Make sure to identify if any app does LDAP writes or depends on obscure AD features (like dynamic auxiliary classes, etc.). Those might have to remain on AD until they’re retired. The focus should be on apps that *read/authenticate* via AD – those can be moved to cloud auth as described.


> [!NOTE]  
>  **Avoid This Mistake**: Don’t migrate users tied to password-based legacy apps.


### Step 4. Categorize Applications and Plan Integration Approach

After determining authentication methods and modernization feasibility, group applications into distinct categories to guide your integration plan:

- **Minimize # of Apps that you need to manage:** For apps that are in plans to be sunset with a target date, these can be considered out of scope and any management of users/groups tied to these apps can be shifted to the cloud. For apps that are redundant (apps doing the same thing), consolidate the app and determine if it can be modernized or not.

- **Apps Already Using or Capable of Modern Auth:** These can be migrated directly to Entra ID as the identity provider, such as updating AD FS applications to point to Entra ID or moving files to Azure file shares. While not the central focus, addressing these reduces overall legacy dependency. Any management of users/groups tied to these apps are in scope to be converted to the cloud.

- **Kerberos/NTLM Apps (Not Easily Modernizable):** Use Microsoft Entra as a front-end through Application Proxy or similar solutions. The application remains on-premises, but user authentication switches to Entra ID tokens, which are translated into Kerberos tickets within AD.

- **LDAP-Binding Apps:** Introduce a managed AD instance in Azure—specifically, Microsoft Entra Domain Services—allowing these apps to bind to a cloud-managed AD instead of the on-premises environment.

- **Other Special Cases:** For applications that cannot be altered or proxied (such as older client-server apps limited to AD-joined machines), consider hosting them on VDI solutions like Azure Virtual Desktop Windows 365 Cloud PC etc. This maintains a managed environment for these apps while enabling cloud migration elsewhere, though this should be a last resort due to added complexity and cost.

- **Disconnected apps:** For apps that have business requirements to be working without internet connections and work in a disconnected environment, you need to keep on-premises and users leveraging these won’t be eligible for SOA conversion.

### Step 5. Mapping and Planning

By concluding the analysis phase, you should have a clear mapping of which applications fall into the "Kerberos category," "LDAP category," or other buckets, along with the specific integration mechanism each will require. This planning step is vital: each application has unique characteristics that must be carefully considered before selecting a migration strategy. Fortunately, Microsoft Entra ID offers solutions for most AD-based authentication patterns, and even legacy applications that cannot be modified can benefit from secure hybrid access and modern governance.

# [Phase 2: Migrate groups to the cloud](#tab/migrate-groups-to-cloud)

In an app-centric approach, it's generally best to migrate groups (and
app access controls) to the cloud first. This enables centralized access
management and ensures group memberships remain intact before moving
users. Microsoft recommends converting groups to SOA ahead of users to
maintain membership integrity and allow testing. However, you can adjust
the sequence for each app, such as piloting an application with its
groups and test users end-to-end. When shifting them to the cloud, we
have outlined specific guidance on how you can map them to cloud groups
as outlined in 
[Guidance for using Group Source of Authority (SOA) in Microsoft Entra ID (Preview)](../../identity/hybrid/concept-group-source-of-authority-guidance.md)
or watch the following video:

> [!VIDEO https://www.youtube.com/embed/VpRDtulXcUw]


> [!TIP]
> Migrate security groups to the cloud first. This allows you to
> test app access controls before moving user

# [Phase 3: Handling LDAP-Based Applications (Directory-Bound Apps)](#tab/handling-LDAP-Applications)

**LDAP-bound applications** present a unique challenge in identity
migration strategies. These applications or services directly query
Active Directory Domain Services (AD DS) via LDAP, most often for
authentication using a simple bind with username and password, or for
directory reads. Common examples include older enterprise applications,
network appliances, or custom-developed apps that rely on LDAP binds to
validate credentials. These applications typically require an LDAP
server and cannot easily transition to modern authentication protocols.

#### Recommended Solution: Microsoft Entra Domain Services

The recommended solution for supporting LDAP-bound apps in the cloud is
Microsoft Entra Domain Services (Entra ID DS). Hosted on Azure, Entra ID
DS provides LDAP, Kerberos, and NTLM endpoints, syncing user accounts
and credentials from your Entra ID tenant. This allows legacy
applications to use cloud-hosted AD for authentication without switching
to modern protocols. While implementing Entra ID DS adds cost and
requires network connectivity, it enables organizations to migrate
LDAP-dependent apps and retire on-premises AD. Management occurs
directly in Entra ID; the managed domain mainly supports read and
authentication for LDAP clients.

# [Phase 4: Handling Kerberos-Based Applications (Windows Integrated Auth)](#tab/handling-kerberos-based-applications)

**Kerberos-based apps** typically encompass internal web applications
using Windows Authentication, file servers (SMB) that rely on Kerberos
tickets, and other services where Active Directory (AD) login is
required. Microsoft offers intermediary solutions to integrate these
applications with Entra ID.

**Microsoft Entra Application Proxy or Private Access with Kerberos Constrained Delegation (KCD):**

*Recommended solution:*

- **Microsoft Entra Application Proxy or Private Access with Kerberos Constrained Delegation (KCD):** This cloud service enables the publication of an on-premises web application through Entra ID. Users authenticate to Entra ID (for instance, using OAuth/OpenID Connect), and the Application Proxy connector operating on-premises obtains a Kerberos ticket to the backend application on the user’s behalf using KCD. Entra ID serves as the authentication gateway, translating
authentication to Kerberos for the application. This solution supports web-based applications (HTTP/HTTPS) and can provide single sign-on (SSO) for cloud-managed users *provided those users have an account in AD*.

- **Passwordless with Cloud Kerberos Trust:** This method lets Microsoft Entra ID
issue Kerberos tickets for on-premises AD resources when users sign in with Microsoft Entra ID credentials using password-less authentication (like WHfB and FIDO2). It requires configuring the AD domain to trust Microsoft Entra ID’s cloud Kerberos service and ensuring users’ AD objects have the necessary keys. The process is fully password-less, making it ideal for cloud users to access on-prem resources.


> [!NOTE]
> **Security Insight:** Reducing your AD footprint lowers your attack surface. Every group or user left in AD is a potential vulnerability.

### Key Considerations Before Migrating Kerberos Workloads

The following are Key considerations for Kerberos applications before shifting  user and group workloads associated with these apps:

- **User lifecycle management:** Even after transitioning a user to cloud management, an AD account (with matching UserPrincipalName) must remain for Kerberos functionality.

- **Authentication:** If using password-based sign-ins, **the Active Directory account’s credentials must be usable**. Currently, there is no capability to provision users from Entra ID to AD and synchronize the Microsoft Entra ID password to AD. Until this feature is available, users should remain in a hybrid state. If using the Cloud Kerberos Trust type and password-less methods (WHfB, FIDO2, Microsoft Entra CBA, Passkeys etc), a password is not required, but other on-premises user attributes must be kept in sync. These can be managed through MS Graph API (dual write to both Microsoft Entra ID and AD) for SOA transferred users.

- **Entra ID joined devices:** For true single sign-on, devices accessing Kerberos resources should be Microsoft Entra ID-joined or hybrid-joined. When a user logs into a device using Microsoft Entra ID credentials, the device can obtain a token from Entra ID that is convertible to a Kerberos ticket (via trust or connector). If a device is only domain-joined and the user is cloud-managed, seamless SSO may
be difficult, possibly requiring manual credential entry. Microsoft recommends migrating devices to Microsoft Entra ID join with Cloud trust as part of cloud transformation so that user and device trust are aligned. 

> [!NOTE]
> Device migration is outside the current scope.

- **Conditional Access for on-prem apps:** Once App Proxy or Microsoft Entra Private Access is deployed for an application, Conditional Access policies (MFA, trusted device, etc.) can be enforced on application access since authentication passes through Microsoft Entra ID. This enhances security—even legacy apps benefit from Zero Trust conditions without modification. For Kerberos trust scenarios, Conditional Access applies when the user initially authenticates to Microsoft Entra ID on the device.

## Challenges and Important Considerations in the App-Centric Approach

While the app-centric migration approach allows for gradual transition,
it introduces a complex hybrid architecture during the interim. Key
challenges and mitigation strategies include:

- **User Provision to AD and Password writeback gap:** This is a significant current limitation. When a user is converted to cloud management, **Microsoft Entra ID does not provision the user to AD and automatically synchronize the user’s password into AD**. Microsoft Entra ID Connect’s password writeback only works for users originally from AD (hybrid identities). For cloud-originated users, there is no built-in solution to push their password to AD, meaning their AD account may
have an empty or unknown password. **The user cannot log in to on-prem apps with their usual password**.

---

## Conclusion

This approach works for customers who are far into their password-less
journey. For apps that require password, currently, there’s no path to
shift users to the cloud. Below is a summary of the options for handling
on-prem apps in a cloud-first model:

> Integration Options for On-Premises AD Applications:

| App Type | Cloud Integration Method & Tools | Requirements & Considerations |
|:--------:|:-------------------------------:|:-----------------------------|
| **Kerberos-based Apps**<br>(Windows Integrated Authentication, intranet web apps, file shares) | **Microsoft Entra ID Application Proxy with Kerberos (KCD):** Publish on-prem web apps through Microsoft Entra ID and use a connector for Kerberos on-prem.<br>**Microsoft Entra ID Cloud Kerberos Trust:** For Microsoft Entra ID joined devices (non-web, e.g. file shares). | **Requirements:**<br>- Microsoft Entra Private Access installed on-prem<br>- Configured SPN and delegation rights<br>- Microsoft Entra ID P1/P2 or Suite licenses<br>- AD account for user (synced or provisioned)<br>**Considerations:**<br>- Seamless SSO using Entra ID credentials<br>- Password-less and phish-resistant methods for Kerberos apps<br>- Secure access to on-prem resources |
| **LDAP-based Apps**<br>(Apps that bind to AD DS over LDAP for auth/queries) | **Entra ID Domain Services (Managed AD):** Cloud-hosted AD domain synced with Entra ID; repoint app’s LDAP connection to this domain (LDAPS). | **Requirements:**<br>- Set up Microsoft Entra ID DS instance in Azure<br>- Configure virtual network, secure LDAP cert, firewall rules<br>- Users/groups must be in Microsoft Entra ID (synced to Microsoft Entra ID DS)<br>- May require password reset to generate hashes<br>**Considerations:**<br>- Minimal app changes (just new LDAP endpoint)<br>- Cloud users’ passwords present in Microsoft Entra ID DS<br>- If Microsoft Entra ID DS not feasible, fallback is provisioning users into on-prem AD and maintaining password parity manually. |

## SOA Conversion Executive Checklist for IT Architects

**Understand Strategic Benefits**

- Reduce security risks by minimizing on-prem AD dependency.

- Enable modern identity features (Conditional Access, password-less,
  Zero Trust).

- Streamline identity management and governance in Microsoft Entra ID.

**Assess Readiness**

- Inventory all users, groups, and applications.

- Identify users/groups no longer tied to AD-dependent apps.

- Map authentication dependencies for each application (Kerberos, LDAP,
  SAML/OIDC).

**Choose the Right Approach**

- User-centric: Only for users not tied to password-based AD apps.

- App-centric: Required if any apps still use AD for authentication
  (recommended).

**Plan Group Migration**

- Shift security groups to the cloud; provision back to AD from Entra ID
  if needed.

- Shift DLs and MESGs only after Exchange workloads are fully
  cloud-based.

**Modernize Application Authentication**

- For Kerberos/NTLM apps:  
  <https://learn.microsoft.com/entra/identity/hybrid/connect/kerberos/cloud-kerberos-trust>

- For LDAP apps:  
  <https://learn.microsoft.com/entra/identity/hybrid/ldap/ldap-overview>

- For modern/federated apps:  
  Reconfigure to authenticate directly against Entra ID (SAML/OIDC).

**Enable Password-less Authentication**

- Deploy
  [https://learn.microsoft.com/windows/security/identity-protection/hello-for-business/hello-feature-fido2
  and
  https://learn.microsoft.com/entra/identity/authentication-methods-fido2
  keys.](https://learn.microsoft.com/windows/security/identity-protection/hello-for-business/hello-feature-fido2%20and%20https:/learn.microsoft.com/entra/identity/authentication-methods-fido2%20keys.)

- Integrate with
  [https://learn.microsoft.com/entra/identity/hybrid/connect/kerberos/cloud-kerberos-trust
  for seamless ticket-based
  authentication.](https://learn.microsoft.com/entra/identity/hybrid/connect/kerberos/cloud-kerberos-trust%20for%20seamless%20ticket-based%20authentication.)

**Implement Entra ID Governance**

- <https://learn.microsoft.com/entra/governance/entitlement/lifecycle-workflows>

- <https://learn.microsoft.com/entra/governance/entitlement-management/overview>

- <https://learn.microsoft.com/entra/governance/access-review/overview>

- <https://learn.microsoft.com/entra/privileged-identity-management/pim-resource-roles-overview>

**Address Key Limitations**

- No password writeback for cloud-only users—keep hybrid directory if
  you need writeback.

- Legacy apps with hardcoded AD dependencies may require custom proxies
  or remain on-prem.

**Monitor & Iterate**

- Track migration progress: users/groups converted, apps modernized.

- Continuously review security posture and compliance.

> [!TIP]
> Always start with an app-centric analysis to avoid breaking
> access for users tied to legacy AD apps. Use phased migration—avoid a
> “*big bang*” cutover.



## Checklist before transferring Source of Authority

:::image type="content" source="media/guidance-for-it-architects-for-source-of-authority-conversion/conversion-checklist.png" alt-text="Screenshot of the checklist to view before transferring Source of Authority.":::

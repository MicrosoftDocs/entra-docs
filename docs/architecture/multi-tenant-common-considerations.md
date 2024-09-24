---
title: Common considerations for multitenant user management in Microsoft Entra ID
description: Learn about the common design considerations for user access across Microsoft Entra tenants with guest accounts
author: janicericketts
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 09/25/2024
ms.author: jricketts
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Common considerations for multitenant user management

This article is the third in a series of articles that provide guidance for configuring and providing user lifecycle management in Microsoft Entra multitenant environments. The following articles in the series provide more information as described.

- [Multitenant user management introduction](multi-tenant-user-management-introduction.md) is the first in the series of articles that provide guidance for configuring and providing user lifecycle management in Microsoft Entra multitenant environments.
- [Multitenant user management scenarios](multi-tenant-user-management-scenarios.md) describes three scenarios for which you can use multitenant user management features: end user-initiated, scripted, and automated.
- [Common solutions for multitenant user management](multi-tenant-common-solutions.md) when single tenancy doesn't work for your scenario, this article provides guidance for these challenges:  automatic user lifecycle management and resource allocation across tenants, sharing on-premises apps across tenants.

The guidance helps to you achieve a consistent state of user lifecycle management. Lifecycle management includes provisioning, managing, and deprovisioning users across tenants using the available Azure tools that include [Microsoft Entra B2B collaboration](~/external-id/what-is-b2b.md) (B2B) and [cross-tenant synchronization]((~/identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md)).

Synchronization requirements are unique to your organization's specific needs. As you design a solution to meet your organization's requirements, the following considerations in this article help you identify your best options.

- Cross-tenant synchronization
- Directory object
- Microsoft Entra Conditional Access
- Additional access control
- Office 365

## Cross-tenant synchronization

[Cross-tenant synchronization](~/identity/multi-tenant-organizations/cross-tenant-synchronization-overview.md) can address collaboration and access challenges of multitenant organizations. The following table shows common synchronization use cases. You can use both cross-tenant synchronization and customer development to satisfy use cases when considerations are relevant to more than one collaboration pattern.

| Use case | Cross-tenant sync | Custom development |
| - | - | - |
| User lifecycle management | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| File sharing and app access | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Support sync to/from sovereign clouds |  | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Control sync from resource tenant |  | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Sync Group objects |  | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Sync Manager links | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Attribute level Source of Authority |  | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |
| Microsoft Entra write-back to Microsoft Windows Server Active Directory |  | ![Check mark icon](media/multi-tenant-user-management-scenarios/checkmark.svg) |

## Directory object considerations

### Inviting an external user with UPN versus SMTP Address

Microsoft Entra B2B expects that a user's **UserPrincipalName** (UPN) is the primary Simple Mail Transfer Protocol (SMTP) (Email) address for sending invitations. When the user's UPN is the same as their primary SMTP address, B2B works as expected. However, if the UPN is different than the external user's primary SMTP address, it might fail to resolve when a user accepts an invitation. This issue might be a challenge if you don't know the user's real UPN. You need to discover and use the UPN when sending invitations for B2B.

The [Microsoft Exchange Online](#microsoft-exchange-online) section of this article explains how to change the default primary SMTP on external users. This technique is useful if you want all email and notifications for an external to flow to the real primary SMTP address as opposed to the UPN. It might be a requirement if the UPN isn't route-able for mail flow.

### Converting an external user's UserType

When you use the console to manually create an invitation for an external user account, it creates the user object with a Guest User type. Using other techniques to create invitations enable you to set the user type to something other than an external guest account. For example, when using the API, you can configure whether the account is an external member account or an external guest account.

- Some of the [limits on guest functionality can be removed](~/external-id/user-properties.md#guest-user-permissions).
- You can [convert guest accounts to member user type](~/external-id/user-properties.md#can-azure-ad-b2b-users-be-added-as-members-instead-of-guests).

If you convert from an external Guest User to an external member user account, there might be issues with how Exchange Online handles B2B accounts. You can't mail-enable accounts that you invited as external member users. To mail-enable an external member account, use the following best approach.

- Invite the cross-org users as external Guest User accounts.
- Show the accounts in the GAL.
- Set the UserType to Member.

When you use this approach, the accounts show up as MailUser objects in Exchange Online and across Office 365. Also, note there's a timing challenge. Make sure the user is visible in the GAL by checking both Microsoft Entra user ShowInAddressList property aligns with the Exchange Online PowerShell HiddenFromAddressListsEnabled property (that are reverse of each other). The [Microsoft Exchange Online](#microsoft-exchange-online) section of this article provides more information on changing visibility.

It's possible to convert a member user to a Guest User, which is useful for internal users that you want to restrict to guest-level permissions. Internal guest users are users that aren't employees of your organization but for whom you manage their users and credentials. It might allow you to avoid licensing the internal Guest User.

### Issues with using mail contact objects instead of external users or members

You can represent users from another tenant using a traditional GAL synchronization. If you perform a GAL synchronization rather than using Microsoft Entra B2B collaboration, it creates a mail contact object.

- Mail contact object and a mail-enabled external member or Guest User can't coexist in the same tenant with the same email address at the same time.
- If a mail contact object exists for the same mail address as the invited external user, it creates the external user but isn't mail-enabled.
- If the mail-enabled external user exists with the same mail, an attempt to create a mail contact object throws an exception at creation time.

> [!IMPORTANT]
> Using mail contacts requires Active Directory Services (AD DS) or Exchange Online PowerShell. Microsoft Graph doesn't provide an API call for managing contacts.

The following table displays the results of mail contact objects and external user states.

| Existing state | Provisioning scenario | Effective result |
| - | - | - |
| None | Invite B2B Member | Non-mail-enabled member user. See important note. |
| None | Invite B2B Guest | Mail-enable external user. |
| Mail contact object exists | Invite B2B Member | Error. Conflict of Proxy Addresses. |
| Mail contact object exists | Invite B2B Guest | Mail-contact and Non-Mail enabled external user. See important note. |
| Mail-enabled external Guest User | Create mail contact object | Error |
| Mail-enabled external member user exists | Create mail-contact | Error |

Microsoft recommends using Microsoft Entra B2B collaboration (instead of traditional GAL synchronization) to create:

- External users that you enable to show in the GAL.
- External member users that show in the GAL by default but aren't mail-enabled.

You can choose to use the mail contact object to show users in the GAL. This approach integrates a GAL without providing other permissions because mail contacts aren't security principals.

Follow this recommended approach to achieve the goal:

- Invite guest users.
- Unhide them from the GAL.
- Disable them by [blocking them from sign-in](/powershell/module/microsoft.graph.users/update-mguser).

A mail contact object can't convert to a user object. Therefore, properties associated with a mail contact object can't transfer (such as group memberships and other resource access). Using a mail contact object to represent a user comes with the following challenges.

- **Office 365 Groups.** Office 365 Groups support policies governing the types of users allowed to be members of groups and interact with content associated with groups. For example, a group might not allow guest users to join. These policies can't govern mail contact objects.
- **Microsoft Entra Self-service group management (SSGM).** Mail contact objects aren't eligible to be members in groups using the SSGM feature. You might need more tools to manage groups with recipients represented as contacts instead of user objects.
- **Microsoft Entra ID Governance, Access Reviews.** You can use the access reviews feature to review and attest to membership of Office 365 group. Access reviews are based on user objects. Members represented by mail contact objects are out of scope for access reviews.
- **Microsoft Entra ID Governance, Entitlement Management (EM).** When you use EM to enable self-service access requests for external users in the company's EM portal, it creates a user object the time of request. It doesn't support mail contact objects.

<a name='azure-ad-conditional-access-considerations'></a>

## Microsoft Entra Conditional Access considerations

The state of the user, device, or network in the user's home tenant doesn't convey to the resource tenant. Therefore, an external user might not satisfy Conditional Access policies that use the following controls.

Where allowed, you can override this behavior with [Cross-Tenant Access Settings (CTAS)](~/external-id/cross-tenant-access-overview.md) that honor multifactor authentication and device compliance from the home tenant.

- **Require multifactor authentication.** Without CTAS configured, an external user must register/respond to multifactor authentication in the resource tenant (even if multifactor authentication was satisfied in the home tenant). This scenario results in multiple multifactor authentication challenges. If they need to reset their multifactor authentication proofs, they might not be aware of the multiple multifactor authentication proof registrations across tenants. The lack of awareness might require the user to contact an administrator in the home tenant, resource tenant, or both.
- **Require device to be marked as compliant.** Without CTAS configured, device identity isn't registered in the resource tenant, so the external user can't access resources that require this control.
- **Require Microsoft Entra hybrid joined device.** Without CTAS configured, device identity isn't registered in the resource tenant (or on-premises Active Directory connected to resource tenant). Therefore, the external user can't access resources that require this control.
- **Require approved client app or Require app protection policy.** Without CTAS configured, external users can't apply the resource tenant Intune Mobile Application Management (MAM) policy because it also requires device registration. Resource tenant Conditional Access policy, using this control, doesn't allow home tenant MAM protection to satisfy the policy. Exclude external users from every MAM-based Conditional Access policy.

Additionally, while you can use the following Conditional Access conditions, be aware of the possible ramifications.

- **Sign-in risk and user risk.** User behavior in their home tenant determines in part the sign-in risk and user risk. The home tenant stores the data and risk score. If resource tenant policies block an external user, a resource tenant admin might not be able to enable access. [Microsoft Entra ID Protection and B2B users](~/id-protection/concept-identity-protection-b2b.md) explains how Microsoft Entra ID Protection detects compromised credentials for Microsoft Entra users.
- **Locations.** The named location definitions in the resource tenant determine the scope of the policy. The scope of the policy doesn't evaluate trusted locations managed in the home tenant. If your organization wants to share trusted locations across tenants, define the locations in each tenant where you define the resources and Conditional Access policies.

<a name='securing-your-multi-tenant-environment'></a>

## Securing your multitenant environment

Securing a multitenant environment starts by ensuring each tenant adheres to security best practices. Review the [security checklist](/azure/security/fundamentals/steps-secure-identity) and [best practices](/azure/security/fundamentals/operational-best-practices) for guidance on securing your tenant. Ensure these best practices are followed and review them with any tenants that you collaborate closely with.

### Protect admin accounts and ensure least privilege

- Find and address gaps in [strong authentication coverage](~/identity/authentication/how-to-authentication-find-coverage-gaps.md) for your administrators
- Enhance security with the principle of least privilege for both [users](~/identity/role-based-access-control/best-practices.md) and [applications](~/identity-platform/secure-least-privileged-access.md). Review the least privilege [roles](~/identity/role-based-access-control/delegate-by-task.md) by task in Microsoft Entra ID.
- Minimize persistent administrator access by enabling [Privileged Identity Management](/azure/security/fundamentals/steps-secure-identity#implement-privilege-access-management).

### Monitor your multitenant environment

- Monitor for changes to cross-tenant access policies using the [audit logs UI](~/identity/monitoring-health/concept-audit-logs.md), [API](/graph/api/resources/azure-ad-auditlog-overview), or [Azure Monitor integration](~/identity/monitoring-health/tutorial-configure-log-analytics-workspace.md) (for proactive alerts). The audit events use the categories "CrossTenantAccessSettings" and "CrossTenantIdentitySyncSettings." By monitoring for audit events under these categories, you can identify any cross-tenant access policy changes in your tenant and take action. When creating alerts in Azure Monitor, you can create a query such as the following one to identify any cross-tenant access policy changes.

```
AuditLogs
| where Category contains "CrossTenant"
```

- Monitor for any new partners added to cross-tenant access settings.

```
AuditLogs
| where OperationName == "Add a partner to cross-tenant access setting"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[0].displayName == "tenantId"
| extend initiating_user=parse_json(tostring(InitiatedBy.user)).userPrincipalName
| extend source_ip=parse_json(tostring(InitiatedBy.user)).ipAddress
| extend target_tenant=parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue
| project TimeGenerated, OperationName,initiating_user,source_ip, AADTenantId,target_tenant
| project-rename source_tenant= AADTenantId
````

  - Monitor for changes to cross-tenant access policies allowing / disallowing sync. 

```
AuditLogs
| where OperationName == "Update a partner cross-tenant identity sync setting"
| extend a = tostring(TargetResources)
| where a contains "true"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue contains "true"
```

- Monitor application access in your tenant using the [cross-tenant access activity](~/identity/monitoring-health/workbook-cross-tenant-access-activity.md) dashboard. Monitoring allows you to see who is accessing resources in your tenant and where those users are coming from.

## Dynamic membership groups

If your organization is using the [**all users** dynamic membership group](~/external-id/use-dynamic-groups.md) condition in your existing Conditional Access policy, this policy affects external users because they are in scope of **all users**.

### Deny by default
- Require user assignment for applications. If an application has the **User assignment required?** property set to **No**, external users can access the application. [Restrict your Microsoft Entra app to a set of users in a Microsoft Entra tenant](~/identity-platform/howto-restrict-your-app-to-a-set-of-users.md) explains how registered applications in a Microsoft Entra tenant are, by default, available to all users of the tenant who successfully authenticate.
- Update your external collaboration settings so that only "Member users and users assigned to specific admin roles can invite guest users including guests with member permissions." This prevents guests in your tenant from inviting other users.
- Only enable cross-tenant synchronization or cross-tenant access policies trusting MFA with tenants that you have a high level of trust in.
- Create a default block outbound policy and only allow users to sign in as guests to approved tenants with their corporate identity. This will ensure isolation of tenants and cross flow of information between tenants.
- Limit external user access to a pre-defined list of tenants using [tenant restrictions](/entra/external-id/tenant-restrictions-v2).
- Verify guest access restriction is not set to ‘Guest users have the same access as members (most inclusive).
- Check if ‘Enable guest self-service sign up via user flows’ is disabled. Self-service sign up flow allows creation of guest identities in the tenant without initiation from internal users. 


### Defense in Depth

**Conditional access**.

- Define [access control policies](~/external-id/authentication-conditional-access.md) to control access to resources.
- Design Conditional Access policies with external users in mind.
- Check if a sign in frequency CA policy is applied to all guest sign ins. The sign in frequency should be limited to a maximum of 24 hours. Tokens of guests signing in from unmanaged devices are at a higher risk of token exfiltration and token replay attacks. Limiting the token lifetime reduces the exposure from this risk. This will ensure that even if a token is exfiltrated the threat actor has a limited window of usage. 
- Create dedicated Conditional Access policies for external accounts. If your organization is using the [**all users** dynamic membership group](~/external-id/use-dynamic-groups.md) condition in your existing Conditional Access policy, this policy affects external users because they are in scope of **all users**.

<a name='monitoring-your-multi-tenant-environment'></a>

**Govern cross-tenant access**

- [Govern](~/identity/multi-tenant-organizations/cross-tenant-synchronization-governance.md) cross-tenant access using entitlement management, access reviews, and lifecycle workflows. 

**Restricted Management Units**

When using security groups to control who is in scope for cross-tenant synchronization, limit who can make changes to the security group. Minimize the number of owners of the security groups assigned to the cross-tenant synchronization job and include the groups in a [restricted management unit](~/identity/role-based-access-control/admin-units-restricted-management.md). This will limit the number of people that can add or remove group members and provision accounts across tenants.

## Other access control considerations

### Terms and conditions

[Microsoft Entra terms of use](~/identity/conditional-access/terms-of-use.md) provides a simple method that organizations can use to present information to end users. You can use terms of use to require external users to approve terms of use before accessing your resources.

<a name='licensing-considerations-for-guest-users-with-azure-ad-premium-features'></a>

### Licensing considerations for guest users with Microsoft Entra ID P1 or P2 features

Microsoft Entra External ID pricing is based on monthly active users (MAU). The number of active users is the count of unique users with authentication activity within a calendar month. [Billing model for Microsoft Entra External ID](~/external-id/external-identities-pricing.md) describes how pricing is based on MAU.

## Office 365 considerations

The following information addresses Office 365 in the context of this paper's scenarios. Detailed information is available at [Microsoft 365 intertenant collaboration 365 intertenant collaboration](/microsoft-365/enterprise/microsoft-365-inter-tenant-collaboration). This article describes options that include using a central location for files and conversations, sharing calendars, using IM, audio/video calls for communication, and securing access to resources and applications.

### Microsoft Exchange Online

Exchange Online limits certain functionality for external users. You can lessen the limits by creating external member users instead of external guest users. Support for external users has the following limitations.

- You can assign an Exchange Online license to an external user. However, you can't issue to them a token for Exchange Online. The results are that they can't access the resource.
    - External users can't use shared or delegated Exchange Online mailboxes in the resource tenant.
    - You can assign an external user to a shared mailbox but they can't access it.
- You need to unhide external users to include them in the GAL. By default, they're hidden.
    - Hidden external users are created at invite time. The creation is independent of whether the user redeemed their invitation. So, if all external users are unhidden, the list includes user objects of external users who haven't redeemed an invitation. Based on your scenario, you may or might not want the objects listed.
    - External users might be unhidden using [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell-v2). You can execute the [Set-MailUser](/powershell/module/exchange/set-mailuser) PowerShell cmdlet to set the **HiddenFromAddressListsEnabled** property to a value of **\$false**.

For example:

`Set-MailUser [ExternalUserUPN] -HiddenFromAddressListsEnabled:\$false\`

Where **ExternalUserUPN** is the calculated **UserPrincipalName.**

For example:

`Set-MailUser externaluser1_contoso.com#EXT#@fabricam.onmicrosoft.com\ -HiddenFromAddressListsEnabled:\$false`

External users might be unhidden in the Microsoft 365 admin center.

- You can only set updates to Exchange-specific properties (such as the **PrimarySmtpAddress**, **ExternalEmailAddress**, **EmailAddresses**, and **MailTip**) using [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell-v2). The Exchange Online Admin Center doesn't allow you to modify the attributes using the graphical user interface (GUI).

As shown in the example, you can use the [Set-MailUser](/powershell/module/exchange/set-mailuser) PowerShell cmdlet for mail-specific properties. There are user properties that you can modify with the [Set-User](/powershell/module/exchange/set-user) PowerShell cmdlet. You can modify most properties with the Microsoft Graph APIs.

One of the most useful features of **Set-MailUser** is the ability to manipulate the **EmailAddresses** property. This multivalued attribute might contain multiple proxy addresses for the external user (such as SMTP, X500, Session Initiation Protocol (SIP)). By default, an external user has the primary SMTP address stamped correlating to the **UserPrincipalName** (UPN). If you want to change the primary SMTP or add SMTP addresses, you can set this property. You can't use the Exchange Admin Center; you must use Exchange Online PowerShell. [Add or remove email addresses for a mailbox in Exchange Online](/exchange/recipients-in-exchange-online/manage-user-mailboxes/add-or-remove-email-addresses) shows different ways to modify a multivalued property such as **EmailAddresses.**

<a name='microsoft-sharepoint-online'></a>

### Microsoft SharePoint in Microsoft 365

SharePoint in Microsoft 365 has its own service-specific permissions depending on whether the user (internal or external) is of type member or guest in the Microsoft Entra tenant. [Microsoft 365 external sharing and Microsoft Entra B2B collaboration](~/external-id/what-is-b2b.md) describes how you can enable integration with SharePoint and OneDrive to share files, folders, list items, document libraries, and sites with people outside your organization. Microsoft 365 does this while using Azure B2B for authentication and management.

After you enable external sharing in SharePoint in Microsoft 365, the ability to search for guest users in the SharePoint in Microsoft 365 people picker is **OFF** by default. This setting prohibits guest users from being discoverable when they're hidden from the Exchange Online GAL. You can enable guest users to become visible in two ways (not mutually exclusive):

- You can enable the ability to search for guest users in these ways:
    - Modify the **ShowPeoplePickerSuggestionsForGuestUsers** setting at the tenant and site collection level.
    - Set the feature using the [Set-SPOTenant](/powershell/module/sharepoint-online/set-spotenant) and [Set-SPOSite](/powershell/module/sharepoint-online/set-sposite) [SharePoint in Microsoft 365 PowerShell](/powershell/sharepoint/sharepoint-online/connect-sharepoint-online) cmdlets.
- Guest users that are visible in the Exchange Online GAL are also visible in the SharePoint in Microsoft 365 people picker. The accounts are visible regardless of the setting for **ShowPeoplePickerSuggestionsForGuestUsers**.

### Microsoft Teams

Microsoft Teams has features to limit access and based on user type. Changes to user type can affect content access and features available. Microsoft Teams requires users to change their context using the tenant switching mechanism of their Teams client when working in Teams outside their home tenant.

The tenant switching mechanism for Microsoft Teams might require users to manually switch the context of their Teams client when working in Teams outside their home tenant.

You can enable Teams users from another entire external domain to find, call, chat, and set up meetings with your users with Teams Federation. [Manage external meetings and chat with people and organizations using Microsoft identities](/microsoftteams/trusted-organizations-external-meetings-chat) describes how you can allow users in your organization to chat and meet with people outside the organization who are using Microsoft as an identity provider.

### Licensing considerations for guest users in Teams

When you use Azure B2B with Office 365 workloads, key considerations include instances in which guest users (internal or external) don't have the same experience as member users.

- **Microsoft Groups.** [Adding guests to Office 365 Groups](https://support.office.com/article/adding-guests-to-office-365-groups-bfc7a840-868f-4fd6-a390-f347bf51aff6) describes how guest access in Microsoft 365 Groups lets you and your team collaborate with people from outside your organization by granting them access to group conversations, files, calendar invitations, and the group notebook.
- **Microsoft Teams.** [Team owner, member, and guest capabilities in Teams](https://support.office.com/article/team-owner-member-and-guest-capabilities-in-teams-d03fdf5b-1a6e-48e4-8e07-b13e1350ec7b) describes the guest account experience in Microsoft Teams. You can enable a full fidelity experience in Teams by using external member users.
    - For multiple tenants in our Commercial cloud, users licensed in their home tenant might access resources in another tenant within the same legal entity. You can grant access using the external members setting with no extra licensing fees. This setting applies for SharePoint and OneDrive for Teams and Groups.
    - For multiple tenants in other Microsoft clouds and for multiple tenants in different clouds, B2B Member license checks aren't yet available. Usage of B2B Member with Teams requires an additional license for each B2B Member. This requirement might also affect other workloads such as Power BI.
    - B2B Member usage for tenants not part of the same legal entity are subject to additional license requirements.
- **Identity Governance features.** Entitlement Management and access reviews might require other licenses for external users.
- **Other products.** Products such as Dynamics customer relationship management (CRM) might require licensing in every tenant in which a user is represented.

## Next steps

- [Multitenant user management introduction](multi-tenant-user-management-introduction.md) is the first in the series of articles that provide guidance for configuring and providing user lifecycle management in Microsoft Entra multitenant environments.
- [Multitenant user management scenarios](multi-tenant-user-management-scenarios.md) describes three scenarios for which you can use multitenant user management features: end user-initiated, scripted, and automated.
- [Common solutions for multitenant user management](multi-tenant-common-solutions.md) when single tenancy doesn't work for your scenario, this article provides guidance for these challenges:  automatic user lifecycle management and resource allocation across tenants, sharing on-premises apps across tenants.
- [Microsoft Collaboration Framework for the US Defense Industrial Base](https://techcommunity.microsoft.com/t5/public-sector-blog/microsoft-collaboration-framework-for-the-us-defense-industrial/ba-p/3975346) describes candidate reference architectures for identity to accommodate Multitenant Organizations (MTO). This scenario applies specifically to those MTOs that have a deployment in the US Sovereign Cloud with Microsoft 365 US Government (GCC High) and Azure Government. It also addresses external collaboration in highly regulated environments, inclusive of organizations that are homed in either Commercial or in the US Sovereign Cloud.

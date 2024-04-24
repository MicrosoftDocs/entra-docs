---
title: Limitations in multitenant organizations
description: Learn about the limitations when you work with multitenant organizations in Microsoft Entra ID.
author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: troubleshooting
ms.date: 04/23/2024
ms.author: rolyon
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# Limitations in multitenant organizations

This article describes limitations to be aware of when you work with multitenant organization functionality across Microsoft Entra ID and Microsoft 365. To provide feedback about the multitenant organization functionality on UserVoice, see [Microsoft Entra UserVoice](https://feedback.azure.com/d365community/forum/22920db1-ad25-ec11-b6e6-000d3a4f0789?category_id=360892). We watch UserVoice closely so that we can improve the service.

## Scope

The limitations described in this article have the following scope.

| Scope | Description |
| --- | --- |
| In scope | - Microsoft Entra administrator limitations related to multitenant organizations to support seamless collaboration experiences in new Teams, with reciprocally provisioned B2B members |
| Related scope | - Microsoft 365 admin center limitations related to multitenant organizations<br/>- Microsoft 365 multitenant organization people search experiences<br/>- Cross-tenant synchronization limitations related to Microsoft 365 |
| Out of scope | - Cross-tenant synchronization unrelated to Microsoft 365<br/>- End user experiences in new Teams<br/>- End user experiences in Power BI<br/>- Tenant migration or consolidation |
| Unsupported scenarios | - Seamless collaboration experience across multitenant organizations in classic Teams<br/>- Self-service for multitenant organizations larger than 100 tenants<br/>- Multitenant organizations in Azure Government or Microsoft Azure operated by 21Vianet<br/>- Cross-cloud multitenant organizations |

## Microsoft 365 admin center versus cross-tenant synchronization

- Whether you use the Microsoft 365 admin center share users functionality or Microsoft Entra cross-tenant synchronization, the following items apply:

    - In the identity platform, both methods are represented as Microsoft Entra cross-tenant synchronization jobs.
    - Synchronization jobs created with Microsoft Entra ID will not appear in the Microsoft 365 admin center.
    - If you created your synchronization job in the Microsoft 365 admin center, do not modify the synchronization job name using Microsoft Entra ID, otherwise it will no longer appear in the admin center.
    - You might adjust the attribute mappings to match your organizations' needs.
    - By default, new B2B users are provisioned as B2B members, while existing B2B guests remain B2B guests.
    - You can opt to convert B2B guests into B2B members by setting [**Apply this mapping** to **Always**](cross-tenant-synchronization-configure.md#step-9-review-attribute-mappings).

- If you're using Microsoft Entra cross-tenant synchronization to provision your users, rather than the Microsoft 365 admin center share users functionality, Microsoft 365 admin center indicates an **Outbound sync status** of **Not configured**. This is expected behavior. Currently, Microsoft 365 admin center only shows the status of Microsoft Entra cross-tenant synchronization jobs created and managed by Microsoft 365 admin center and doesn't display Microsoft Entra cross-tenant synchronizations created and managed in Microsoft Entra ID.

- If you view Microsoft Entra cross-tenant synchronization in Microsoft Entra admin center, after adding tenants to or after joining a multitenant organization in Microsoft 365 admin center, you'll see a cross-tenant synchronization configuration with the name `MTO_Sync_<TenantID>`. Refrain from editing or changing the name if you want Microsoft 365 admin center to recognize the configuration as created and managed by Microsoft 365 admin center.

- Microsoft Entra cross-tenant synchronization doesn't support establishing a cross-tenant synchronization configuration before the tenant in question allows inbound synchronization in their cross-tenant access settings for identity synchronization. Hence the usage of the cross-tenant access settings template for identity synchronization is encouraged, with `userSyncInbound` set to true, as facilitated by Microsoft 365 admin center.

- There's no established or supported pattern for Microsoft 365 admin center to take control of pre-existing Microsoft Entra cross-tenant synchronization configurations and jobs.

## Join requests

- There are multiple reasons why a join request might fail. If the Microsoft 365 admin center doesn't indicate why a join request isn't succeeding, try examining the join request response by using the Microsoft Graph APIs or Microsoft Graph Explorer.

- If you followed the correct sequence to create a multitenant organization and add a tenant to the multitenant organization, and the added tenant's join request keeps failing, submit a support request in the Microsoft Entra or Microsoft 365 admin center.

## Microsoft apps

- In [SharePoint OneDrive](/sharepoint/), the promotion of B2B guests to B2B members might not happen automatically. If faced with a user type mismatch between Microsoft Entra ID and SharePoint OneDrive, try [Set-SPUser [-SyncFromAD]](/powershell/module/sharepoint-server/set-spuser).

- In [SharePoint OneDrive](/sharepoint/) user interfaces, when sharing a file with *People in Fabrikam*, the current user interfaces might be counterintuitive, because B2B members in Fabrikam from Contoso count towards *People in Fabrikam*.

- In [Microsoft Forms](/office365/servicedescriptions/microsoft-forms-service-description), B2B member users might not be able to access forms.

- In [Microsoft Power BI](/power-bi/enterprise/service-admin-azure-ad-b2b#who-can-you-invite), B2B member users are not yet supported. B2B guest users can continue to access Power BI dashboards.

- In [Microsoft Power Apps](/power-platform/), [Microsoft Dynamics 365](/dynamics365/), and related workloads, B2B member users may have restricted functionality. For more information, see [Invite users with Microsoft Entra B2B collaboration](/power-platform/admin/invite-users-azure-active-directory-b2b-collaboration).

## B2B users or B2B members

- The promotion of B2B guests to B2B members represents a strategic decision by multitenant organizations to consider B2B members as trusted users of the organization. Review the [default permissions](../../fundamentals/users-default-permissions.md) for B2B members.

- To promote B2B guests to B2B members, a source tenant administrator can amend the [attribute mappings](cross-tenant-synchronization-configure.md#step-9-review-attribute-mappings), or a target tenant administrator can [change the userType](../../fundamentals/how-to-manage-user-profile-info.yml#add-or-change-profile-information) if the property is not recurringly synchronized.

- As your organization rolls out the multitenant organization functionality including provisioning of B2B users across multitenant organization tenants, you might want to provision some users as B2B guests, while provision others users as B2B members. To achieve this, you might want to establish two Microsoft Entra cross-tenant synchronization configurations in the source tenant, one with userType attribute mappings configured to B2B guest, and another with userType attribute mappings configured to B2B member, each with [**Apply this mapping** set to **Always**](cross-tenant-synchronization-configure.md#step-9-review-attribute-mappings). By moving a user from one configuration's scope to the other, you can easily control who will be a B2B guest or a B2B member in the target tenant.

- As part of a multitenant organization, [reset redemption for an already redeemed B2B user](../../external-id/reset-redemption-status.md) is currently disabled.

- The at-scale provisioning of B2B users might collide with contact objects. The handling or conversion of contact objects is currently not supported.

- Using Microsoft Entra cross-tenant synchronization to target hybrid identities that have been converted to B2B users has not been tested in source of authority conflicts and is not supported.

## Cross-tenant synchronization deprovisioning

- By default, when provisioning scope is reduced while a synchronization job is running, users fall out of scope and are soft deleted, unless [Target Object Actions for Delete](cross-tenant-synchronization-configure.md#step-8-optional-define-who-is-in-scope-for-provisioning-with-scoping-filters) is disabled. For more information, see [Deprovisioning](cross-tenant-synchronization-overview.md#deprovisioning) and [Define who is in scope for provisioning](cross-tenant-synchronization-configure.md#step-8-optional-define-who-is-in-scope-for-provisioning-with-scoping-filters).

- Currently, [SkipOutOfScopeDeletions](../app-provisioning/skip-out-of-scope-deletions.md?toc=/entra/identity/multi-tenant-organizations/toc.json&pivots=cross-tenant-synchronization) works for application provisioning jobs, but not for Microsoft Entra cross-tenant synchronization. To avoid soft deletion of users taken out of scope of cross-tenant synchronization, set [Target Object Actions for Delete](cross-tenant-synchronization-configure.md#step-8-optional-define-who-is-in-scope-for-provisioning-with-scoping-filters) to disabled.

## Next steps

- [Known issues for provisioning in Microsoft Entra ID](../app-provisioning/known-issues.md?toc=/entra/identity/multi-tenant-organizations/toc.json&pivots=cross-tenant-synchronization)

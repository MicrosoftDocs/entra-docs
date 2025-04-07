---
title: Quarantining unsanctioned tenants
description: Isolate unsanctioned tenants using Microsoft Entra features. Follow steps to quarantine unapproved tenants and strengthen security.
author: barclayn
manager: femila
ms.service: entra
ms.subservice: fundamentals
ms.topic: concept-article
ms.date: 04/07/2025
ms.author: barclayn
#customer intent: As an administrator, I want to quarantine unsanctioned tenants to reduce security risks and ensure compliance with security policies.
---
# Quarantining unsanctioned tenants

Quarantining unsanctioned tenants involves using Microsoft Entra features to isolate tenants that may pose security risks due to lack of administrative oversight. Controlled restrictions can mitigate potential vulnerabilities while encouraging administrators of these tenants to reach out for assistance. This process allows you to validate the legitimacy of their access or regain control over the tenants. If no contact is made, the tenants can remain in a quarantined state to safeguard your environment.

>[!IMPORTANT]
> This article complements the Microsoft Cloud Footprint FAQ, a document published to help customers find all tenants within their environments, outlining the specific existing Microsoft Entra capabilities administrators can use within their primary tenant to implement the quarantine process against suspected unsanctioned tenants in their discovered inventory. 
Refer to this article only after reviewing the Microsoft Cloud Footprint FAQ to discover your organization’s inventory of tenants.


## When should I quarantine a tenant?

You are an IT Admin for "Contoso". Your primary tenant is "Contoso.com". To secure data in the central Contoso tenant, you need to ensure users and applications with privileged access to your tenant are in tenants that properly secure these resources. Likewise, you want to ensure that external tenants in which your tenant has permissions into are known and following secure practices. To do this, you want to find all tenants that have inbound or outbound relationships with your primary tenant. 
After following the [Microsoft Cloud Footprint FAQ](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/discover-cloud-footprint), you identified a few potential tenants that may or may not belong to your company. Let’s call these tenants ContosoTest.com and ContosoDemo.com for scenario purposes. Because you don't know who the global admins are for these tenants, you worry they are possibly employee-managed and may not comply with your organization’s security policies, posing a major security risk to your environment if they stay unmanaged.
Since you don’t have direct control over ContosoTest.com and ContosoDemo.com and can only modify settings on the Contoso.com tenant, you want to quarantine them to minimize potential vulnerabilities that come from exposure to these tenants. However, it's crucial that any changes you make are easily reversible, ensuring that no critical systems are unintentionally affected in the process. Quarantining introduces enough friction between your tenant and the suspected tenants to encourage their administrators to contact your helpdesk. 

:::image type="content" source="media/quarantine-unsanctioned-tenant/quarantine-unsanctioned-tenant-overview.png" alt-text="Overview of quarantining unsanctioned tenants":::


The administrator of the ContosoTest.com tenant contacts you at which point you determine that the tenant was employee-created, and you should be added as an administrator within the tenant to regain control. You no longer quarantine the ContosoTest.com tenant. However, no administrators from the ContosoDemo.com tenant contact you, so you leave the tenant in the quarantined state.

:::image type="content" source="media/quarantine-unsanctioned-tenant/quarantined.png" alt-text="Quarantined tenant state":::

## How can I use Microsoft Entra's capabilities to quarantine suspected tenants?
Microsoft Entra includes features that help administrators quarantine suspected tenants effectively. Administrators can use features like [External ID Cross-tenant Access Settings](../external-id/cross-tenant-access-overview.md), [Global Secure Access](../global-secure-access/overview-what-is-global-secure-access.md), and [Universal Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md) to restrict interactions with potentially risky tenants, enhancing security and compliance within their environments.

### Using External ID Cross-tenant Access Settings to block user sign-in

**License Required: Entra ID P1**

**Actions Against Suspected Tenant**:

Microsoft Entra organizations can use Cross-tenant access with Microsoft External ID to scope inbound access users of other external Microsoft Entra organizations have to your resources and outbound access users of your organization have to external Microsoft Entra organizations. These policies let you restrict inbound or outbound sign in attempts with a suspect tenant without disrupting collaboration with other tenants. An administrator can add an organization and configure customized settings to block inbound and outbound user-sign for the suspected tenant. 

**Secure-by-default**: 
An administrator can configure default settings to block all inbound sign-in attempts from external users of a suspected tenant and, likewise, block all outbound user sign-in for users of your own tenant into a suspected tenant. Then, you can add organizations and configure customized settings to allow user sign-in only inbound from and outbound to specified tenants. This would enable you to secure your tenant by default and only allow B2B collaboration with trusted tenants.

For more information on managing Cross-tenant access settings, see:
    
  - [Cross-tenant access overview](https://learn.microsoft.com/en-us/entra/external-id/cross-tenant-access-overview).
  - [Cross-tenant access settings](https://learn.microsoft.com/en-us/entra/external-id/cross-tenant-access-settings-b2b-collaboration?source=recommendations).

## Using Global Secure Access and Universal Tenant Restrictions to block user sign-in

**License Required: Entra ID P1**

**Actions Against Suspected Tenant**:
Tenant Restrictions v2 (TRv2) and Global Secure Access (GSA) effectively prevent authentication into unauthorized or suspect tenants across all managed devices and networks. As an administrator, you can create policies to [block users from signing into and accessing the specific suspected tenant using custom TRv2 configurations](https://learn.microsoft.com/en-us/entra/external-id/tenant-restrictions-v2#step-2-configure-tenant-restrictions-v2-for-specific-partners). You can then apply these created policies using [Universal Tenant Restrictions v2](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-universal-tenant-restrictions) as part of GSA to provide both authentication plane and data plane protection without disrupting authentication for other existing tenants. 


**Secure-by-default**:

As an administrator, you can [configure default restrictions](https://learn.microsoft.com/en-us/entra/external-id/tenant-restrictions-v2#step-1-configure-default-tenant-restrictions-v2) and then [allow users to sign into and access specific organizations](https://learn.microsoft.com/en-us/entra/external-id/tenant-restrictions-v2#step-2-configure-tenant-restrictions-v2-for-specific-partners), and Microsoft Entra ID would prevent authentication to all other tenants once applying policies using [Universal Tenant Restrictions v2](https://learn.microsoft.com/en-us/entra/global-secure-access/how-to-universal-tenant-restrictions) as part of GSA. Enabling TRv2 in audit mode and applying TRv2 policies with GSA will show all activity including attempts to access foreign tenants. 

For more information on using TRv2 and GSA, see 
- What is Global Secure Access? – Global Secure Access | Microsoft Learn
- Global Secure Access and Universal Tenant Restrictions – Global Secure Access | Microsoft Learn
- Configure tenant restrictions - Microsoft Entra ID - Microsoft Entra External ID | Microsoft Learn


## Revoking permissions for Multi-Tenants Applications and Service Principals

**License Required: Entra ID P1**

**Actions Against Suspected Tenant**:
Entra allows customers to restrict inbound application access for third-party multi-tenant apps where the tenant in which the app was registered is considered a suspect tenant. To do this, administrators must find the correct service principal, which corresponds to the application registered in the suspect tenant. The appOwnerOrganizationId property on the service principal object will list the tenantId in which the application was registered. At this time, this can only be done programmatically via MSGraph API:

**MSGraph**:
Request Headers: { ConsistencyLevel: eventual }
GET https://graph.microsoft.com/v1.0/servicePrincipals?$count=true&$filter=appOwnerOrganizationId eq {tenantId}

After finding the correct service principal, you can either [review and revoke permissions granted to the application](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-application-permissions?pivots=ms-graph) or [delete the service principal](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/delete-application-portal?pivots=ms-graph) all together. Note that, deleting a service principal is a [restorable action up to 30 days](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/delete-recover-faq#how-do-i-restore-deleted-applications-or-service-principals-).

For more information on multi-tenant apps and service principals, see [Apps & service principals in Microsoft Entra ID - Microsoft identity platform | Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity-platform/app-objects-and-service-principals?tabs=browser).

## Cancelling subscriptions provisioned in suspected tenants

License Required: None, available to all paying customers with a Microsoft billing account

### Actions Against Suspected Tenant:

The following resources can be used when you discover a tenant based on your billing account relationships, but do not recognize the tenant which the subscription services are provisioned within. Note that cancelled Azure and M365 subscriptions can be reactivated during the grace period (30 to 90 days after cancelling) before being permanently deleted. If needed, please contact support for assistance on cancelling and deleting subscriptions.

## Related content

- [Cancel and delete your Azure subscription](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/cancel-azure-subscription)
- [Cancel your Microsoft business subscription in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/commerce/subscriptions/cancel-your-subscription?view=o365-worldwide)
---  
title: Quarantine unsanctioned tenants  
description: Isolate unsanctioned tenants using Microsoft Entra features. Follow steps to quarantine unapproved tenants and strengthen security.  
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals  
ms.topic: concept-article  
ms.date: 04/14/2025  
ms.author: barclayn  
#customer intent: As an administrator, I want to quarantine unsanctioned tenants to reduce security risks and ensure compliance with security policies.  
---  

# Quarantine unsanctioned tenants  

>[!IMPORTANT]
> Refer to this article only after reviewing [the Microsoft Cloud Footprint FAQ](/azure/cost-management-billing/manage/discover-cloud-footprint) to discover your organization's inventory of tenants. This article outlines the specific existing Microsoft Entra capabilities administrators can leverage within their primary tenant to quarantine suspected unsanctioned tenants in their discovered list of tenants. 

## What does it mean to quarantine a tenant?

Quarantine involves isolating suspected unsanctioned tenants by using existing Microsoft Entra capabilities. This immediately reduces security risk that exists from exposure to such tenants that you do not have administrative control of within your environment. By isolating, you introduce friction between your tenant and theirs, which acts as a scream test. This friction prompts administrators of the suspected tenants to contact you in need of assistance, giving you the opportunity to verify the legitimacy of the relationships with these tenants and/or regain control over them. If no one is to contact you, then you can leave the tenants in the quarantined state indefinitely.


## When should I quarantine a tenant? 

You are an IT Admin for the company "Contoso" with the primary tenant of "Contoso.com."  To secure data in the central Contoso tenant, you need to ensure users and applications with privileged access to your tenant are in tenants that properly secure these resources. Likewise, you want to ensure that external tenants in which your tenant has permissions into are known and following secure practices. To secure Contoso, you want to find all tenants that have inbound or outbound relationships with your primary tenant. 
After following the [Microsoft Cloud Footprint FAQ](/azure/cost-management-billing/manage/discover-cloud-footprint), you have identified a few potential tenants that may or may not belong to your company. Let's call these tenants ContosoTest.com and ContosoDemo.com for scenario purposes. Because you don't know who the global admins are for these tenants, you worry they are possibly employee-managed and do not comply with your organization's security policies. This poses a major security risk to your environment if they stay unmanaged.
Since you don't have direct control over ContosoTest.com and ContosoDemo.com, you can only modify settings on the Contoso.com tenant. You want to quarantine them to minimize potential vulnerabilities that come from the exposure to these tenants. However, it's crucial that any changes you make are easily reversible, ensuring that no critical systems are unintentionally affected in the process. After quarantine, you introduced enough friction between your tenant and the suspected tenants to encourage the administrators of the tenants to contact your helpdesk. 


:::image type="content" source="media/quarantine-unsanctioned-tenant/identified.png" alt-text="Diagram that showed unsactioned tenants discovered in the environment.":::  


The administrator of the ContosoTest.com tenant contacts you. At this point, you determine that the tenant was employee-created and that you should be added as an administrator within the tenant to regain control. You no longer quarantine the ContosoTest.com tenant. However, no administrators from the ContosoDemo.com tenant contact you, so you leave the tenant in the quarantined state.

:::image type="content" source="media/quarantine-unsanctioned-tenant/quarantine-unsanctioned-tenant-overview.png" alt-text="Diagram showing an overview of quarantine unsanctioned tenants":::  


## How can I use Microsoft Entra's capabilities to quarantine suspected tenants?  

### Using External ID Cross-tenant Access Settings to block user sign-in  

**License Required: Entra ID P1**  

**Actions Against Suspected Tenant**:  

Microsoft Entra organizations can use Cross-tenant access with External ID to scope which users of other external Entra organizations have access to your resources and which users from your organization have access to other external Entra organizations. These policies let you restrict inbound or outbound login attempts with a suspect tenant without disrupting collaboration with other tenants. An administrator can [add an organization](../external-id/cross-tenant-access-settings-b2b-collaboration.yml?source=recommendations#add-an-organization) and configure customized settings to block [inbound](../external-id/cross-tenant-access-settings-b2b-collaboration.yml#modify-inbound-access-settings) and [outbound](../external-id/cross-tenant-access-settings-b2b-collaboration.yml#modify-outbound-access-settings) user-sign for the suspected tenant. 

**Secure-by-default**:  

An administrator can [configure default settings](../external-id/cross-tenant-access-settings-b2b-collaboration.yml?source=recommendations#configure-default-settings) to block all inbound sign-in attempts from external users of a suspected tenant. Likewise, one can block all outbound user sign-in for users of your own tenant into a suspected tenant. Then, you can [add an organization](../external-id/cross-tenant-access-settings-b2b-collaboration.yml?source=recommendations#add-an-organization) and configure customized settings to allow user sign-in only [inbound](../external-id/cross-tenant-access-settings-b2b-collaboration.yml#modify-inbound-access-settings)  from and [outbound](../external-id/cross-tenant-access-settings-b2b-collaboration.yml#modify-outbound-access-settings) to specified tenants. These settings would enable you to secure your tenant by default and only allow B2B collaboration with trusted tenants.

For more information on managing Cross-tenant access settings, see:  

- [Cross-tenant access overview](../external-id/cross-tenant-access-overview.md).  
- [Cross-tenant access settings](../external-id/cross-tenant-access-settings-b2b-collaboration.yml?source=recommendations).  

### Using Global Secure Access and Universal Tenant Restrictions to block user sign-in  

**License Required**: Entra ID P1  

**Actions Against Suspected Tenant**:  
Tenant Restrictions v2 (TRv2) and Global Secure Access (GSA) effectively prevent authentication into unauthorized or suspect tenants across all managed devices and networks. As an administrator, you can create policies to [block users from signing into and accessing the specific suspected tenant using custom TRv2 configurations](../external-id/tenant-restrictions-v2.md#step-2-configure-tenant-restrictions-v2-for-specific-partners). You can then apply these created policies using [Universal Tenant Restrictions v2](../global-secure-access/how-to-universal-tenant-restrictions.md) as part of GSA to provide both authentication plane and data plane protection without disrupting authentication for other existing tenants.  

**Secure-by-default**:  

As an administrator, you can [configure default restrictions](../external-id/tenant-restrictions-v2.md#step-1-configure-default-tenant-restrictions) and then [allow users to sign into and access specific organizations](../external-id/tenant-restrictions-v2.md#step-2-configure-tenant-restrictions-v2-for-specific-partners), Microsoft Entra ID would prevent authentication on to all other tenants once applying policies using [Universal Tenant Restrictions v2](../global-secure-access/how-to-universal-tenant-restrictions.md) as part of GSA. Enabling TRv2 in audit mode and applying TRv2 policies with GSA shows all activity including attempts to access foreign tenants.    

For more information on using TRv2 and GSA, see:

- [What is Global Secure Access?](../global-secure-access/overview-what-is-global-secure-access.md)  
- [Global Secure Access and Universal Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md)  
- [Configure tenant restrictions - Microsoft Entra ID](../external-id/tenant-restrictions-v2.md)  


### Revoking permissions for multitenants Applications and Service Principals

**License Required**: Entra ID P1

**Actions Against Suspected Tenant**:

Microsoft Entra allows customers to restrict inbound application access for third-party multitenant apps where the tenant in which the app was registered is considered a suspect tenant. To restrict access, administrators must find the correct service principal, which corresponds to the application registered in the suspect tenant. The appOwnerOrganizationId property on the service principal object lists the tenantId in which the application was registered. Capturing these service principals can only be done programmatically via MSGraph API: :

MSGraph:
Request Headers: { ConsistencyLevel: eventual }

```http

GET https://graph.microsoft.com/v1.0/servicePrincipals?$count=true&$filter=appOwnerOrganizationId eq {tenantId}
```

After finding the correct service principal, you can either [review and revoke permissions granted to the application](../identity/enterprise-apps/manage-application-permissions.md?pivots=ms-graph) or [delete the service principal](../identity/enterprise-apps/delete-application-portal.md?pivots=ms-graph) all together. Deleting a service principal is a [restorable action up to 30 days](../identity/enterprise-apps/delete-recover-faq.yml#how-do-i-restore-deleted-applications-or-service-principals-).

For more information on multitenant apps and service principals, see Apps & service principals in Microsoft Entra ID.

- [Apps & service principals in Microsoft Entra ID](../identity-platform/app-objects-and-service-principals.md)

## Canceling subscriptions provisioned in suspected tenants  

License Required: None, available to all paying customers with a Microsoft billing account  

**Actions Against Suspected Tenant**:

Use the following resources when you discover a tenant based on your billing account relationships but do not recognize the tenant which the subscription services are provisioned within. Canceled Azure and Microsoft 365 subscriptions can be reactivated during the grace period ([30 to 90 days after canceling](/azure/cost-management-billing/manage/cancel-azure-subscription)) before being permanently deleted. If needed, contact [support](https://support.microsoft.com/topic/customer-service-phone-numbers-c0389ade-5640-e588-8b0e-28de8afeb3f2) for assistance on canceling and deleting subscriptions.

- For more information on quarantining by canceling Azure, see  [Cancel and delete your Azure subscription](/azure/cost-management-billing/manage/cancel-azure-subscription). 
- For more information on quarantining by canceling Microsoft 365, see [Cancel your Microsoft business subscription in the Microsoft 365 admin center](/microsoft-365/commerce/subscriptions/cancel-your-subscription).

## Related content  

- [Microsoft Cloud Footprint FAQ](/azure/cost-management-billing/manage/discover-cloud-footprint) 

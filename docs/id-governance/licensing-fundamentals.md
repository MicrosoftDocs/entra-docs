---
title: 'Microsoft Entra ID Governance licensing fundamentals'
description: This article describes shows the licensing requirements for Microsoft Entra ID Governance features.
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: conceptual
ms.date: 11/5/2024
ms.author: billmath
---

# Microsoft Entra ID Governance licensing fundamentals
This following document discusses Microsoft Entra ID Governance licensing. It's intended for IT decision makers, IT administrators, and IT professionals who are considering Microsoft Entra ID Governance services for their organizations. 

## Types of licenses

The following licenses are available for use with Microsoft Entra ID Governance in the commercial cloud.  The choice of licenses you need in a tenant depends on the features you're using in that tenant.

- **Free** - Included with Microsoft cloud subscriptions such as Microsoft Azure, Microsoft 365, and others.
- **Microsoft Entra ID P1** - Microsoft Entra ID P1 is available as a standalone product or included with Microsoft 365 E3 for enterprise customers and Microsoft 365 Business Premium for small to medium businesses. 
- **Microsoft Entra ID P2** - Microsoft Entra ID P2 is available as a standalone product or included with Microsoft 365 E5 for enterprise customers.
- **Microsoft Entra ID Governance** - Microsoft Entra ID Governance is an advanced set of identity governance capabilities available for Microsoft Entra ID P1 and P2 customers. Microsoft Entra ID Governance is available as three products **Microsoft Entra ID Governance**, **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2** and **Microsoft Entra ID Governance Step up for Microsoft Entra ID F2**.  These three products differ only in their prerequisites; they contain both the basic identity governance capabilities that were in Microsoft Entra ID P2, and additional advanced identity governance capabilities.

>[!NOTE]
>Some Microsoft Entra ID Governance scenarios can be configured to depend upon other features that aren't covered by Microsoft Entra ID Governance.  These features might have additional licensing requirements.  See the [Identity Governance overview](identity-governance-overview.md) for more information on governance scenarios that rely on additional features.

Microsoft Entra ID Governance products aren't yet available in the US national clouds.

### Governance products and prerequisites

The Microsoft Entra ID Governance capabilities are currently available in three products in the commercial cloud. These three products provide the same identity governance capabilities. The difference between the three products is that they have different prerequisites.

- A subscription to **Microsoft Entra ID Governance**, listed in the product terms as the **Microsoft Entra ID Governance (User SL)** license, requires that the tenant also have an active subscription to another product, one that contains the `AAD_PREMIUM` or `AAD_PREMIUM_P2` service plan. Examples of products meeting this prerequisite include **Microsoft Entra ID P1**, **Microsoft 365 E3/E5/A3/A5/G3/G5**, **Enterprise Mobility + Security E3/E5** or **Microsoft 365 F1/F3**.
- A subscription to **Microsoft Entra ID Governance Step Up for Microsoft Entra ID P2**, listed in the product terms as the **Microsoft Entra ID Governance P2** license, requires that the tenant also have an active subscription to another product, one that contains the `AAD_PREMIUM_P2` service plan.  Examples of products meeting this prerequisite include **Microsoft Entra ID P2**, **Microsoft 365 E5/A5/G5**, **Enterprise Mobility + Security E5**, **Microsoft 365 E5/F5 Security** or **Microsoft 365 F5 Security + Compliance**.
- A subscription to **Microsoft Entra ID Governance Step up for Microsoft Entra ID F2**, listed in the product terms as  the **Microsoft Entra ID Governance F2** license, requires that the tenant also have an active subscription to another product, one that contains the `AAD_PREMIUM_P2` service plan. Examples of products meeting this prerequisite include **Microsoft Entra ID F2**.

The [product names and service plan identifiers for licensing](../identity/users/licensing-service-plan-reference.md) lists additional products that include the prerequisite service plans.

>[!NOTE]
>A subscription to a prerequisite for a Microsoft Entra ID Governance product must be active in the tenant. If a prerequisite is not present, or the subscription expires, then Microsoft Entra ID Governance scenarios might not function as expected.  

To check if the prerequisite products for a Microsoft Entra ID Governance product are present in a tenant, you can use the Microsoft Entra admin center or the Microsoft 365 admin center to view the list of products.

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as a [License Administrator](../identity/role-based-access-control/permissions-reference.md#license-administrator).

1. In the **Identity** menu, expand **Billing** and select **Licenses**.

1. In the **Manage** menu, select **Licensed features**.  The information bar indicates the current Microsoft Entra ID license plan.

1. To view the existing products in the tenant, in the **Manage** menu, select **All products**.

## Starting a trial

A Global Administrator in a commercial tenant that has an appropriate prerequisite product, such as Microsoft Entra ID P1, already purchased, and isn't already using or has previously trialed Microsoft Entra ID Governance, can request a trial of Microsoft Entra ID Governance in their tenant.

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal/Home) as a [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator)

1. In the **Billing** menu, select **Purchase services**.

1. In the **Search all product categories** box, type `"Microsoft Entra ID Governance"`.

1. Select **Details** below **Microsoft Entra ID Governance** to view the trial and purchase information for the product.  If your tenant has Microsoft Entra ID P2, then select  **Details** below **Microsoft Entra ID Governance Step-Up for Microsoft Entra ID P2**.

1. In the product details page, select **Start free trial**.

[!INCLUDE [licensing](../includes/licensing-governance.md)]




## Privileged Identity Management

[!INCLUDE [licensing](../includes/licensing-pim.md)]

## API-driven provisioning

This feature is available with Microsoft Entra ID P1, P2, and Microsoft Entra ID Governance subscriptions. A subscription license is required for every identity that is sourced using the [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API and provisioned to either on-premises Active Directory or Microsoft Entra ID.

### License scenarios

|Customer License  |Usage limits enforced at tenant level for API-driven provisioning  |
|---------|---------|
|Microsoft Entra ID P1 or P2      |   Daily usage quota (number of user records that can be uploaded over 24-hour period): **100K user records (2000 /bulkUpload API calls with each request containing max of 50 records)**.<br><br>Max number of API-driven provisioning jobs for each flow: 2<br>o Max 2 apps for API-driven provisioning to on-premises Active Directory.<br>o Max 2 apps for API-driven provisioning to Microsoft Entra ID.      |
|Microsoft Entra ID Governance alongside Microsoft Entra ID P1 or P2     | Daily usage quota (number of user records that can be uploaded over 24-hour period): **300K user records  (6000 /bulkUpload API calls with each request containing max of 50 records)**.<br><br>Max number of API-driven provisioning jobs for each flow: 20<br>o Max 20 apps for API-driven provisioning to on-premises Active Directory.<br>o Max 20 apps for API-driven provisioning to Microsoft Entra ID.        |

## Licensing FAQs

### Do licenses need to be assigned to users to use Identity Governance features?

Users don't need to be assigned a Microsoft Entra ID Governance license, but there needs to be as many license seats to include all users in scope of, or who configures, the Identity Governance features.

### How can I license usage of Microsoft Entra ID Governance features for business guests?

All users who are in scope of Microsoft Entra ID Governance features, including business guests such as contractors, partners, and external collaborators, need a license.  We're creating a new Microsoft Entra ID Governance license for business guests. This license operates on a monthly active usage (MAU) model. Customers are able to acquire licenses matching their anticipated business guest MAU.

We anticipate making these licenses available in late 2024. In the interim, organizations that govern the identities of their employees with Microsoft Entra ID Governance can govern the identities of their business guests for no additional cost. At this time, existing customers of Microsoft Entra ID P1 or P2 with Microsoft Entra External ID can continue using the subset of features that are included in P1 or P2 with their business guests through their Microsoft Entra External ID license.

For more information, see: [Microsoft Entra ID Governance licensing for business guests](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/microsoft-entra-id-governance-licensing-for-business-guests/ba-p/3575579).

### What happens to PIM when a license expires?

If a Microsoft Entra ID P2 or Microsoft Entra ID Governance license expires or trial ends, Privileged Identity Management features will no longer be available in your directory. The changes discussed below are applicable to PIM for Microsoft Entra roles, PIM for Azure resources, and PIM for Groups.

- Active permanent assignments aren't affected.
- Active time-bound assignments become active permanent, which means they'll no longer expire at a designated time.
- Eligible role assignments are removed, as users will no longer be able to activate privileged roles.
- Privileged Identity Management blades on Microsoft Entra admin center or Azure portal, API, and PowerShell interfaces of Privileged Identity Management, will no longer be available for users to activate roles, manage assignments, or perform access reviews of privileged roles.
- Any ongoing access reviews of Microsoft Entra roles end, and Privileged Identity Management configuration settings are removed.
- Privileged Identity Management will no longer send emails on role assignment changes and PIM Alerts.

<a name='will-any-iga-features-and-capabilities-be-added-under-the-entra-id-p2-license'></a>

### Will any IGA features and capabilities be added under the Microsoft Entra ID P2 License?

All currently Generally Available features in Microsoft Entra ID P2 will remain, but no new IGA features or capabilities will be added to the Microsoft Entra ID P2 SKU.

## Next steps

- [What is Microsoft Entra ID Governance?](identity-governance-overview.md)

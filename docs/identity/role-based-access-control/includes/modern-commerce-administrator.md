---
title: Modern Commerce Administrator
description: Modern Commerce Administrator
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: include
ms.date: 07/10/2025
ms.custom: include file
---

Template ID: d24aef57-1500-4070-84db-2666f29cf966

Do not use. This role isn't returned by PowerShell or the Microsoft Graph API. It's automatically assigned from Commerce, and is not intended or supported for any other use.

The Modern Commerce Administrator role gives certain users permission to access Microsoft 365 admin center and see the left navigation entries for **Home**, **Billing**, and **Support**. The content available in these areas is controlled by [commerce-specific roles](/azure/cost-management-billing/manage/understand-mca-roles) assigned to users to manage products that they bought for themselves or your organization. This might include tasks like paying bills, or for access to billing accounts and billing profiles.

Users with the Modern Commerce Administrator role typically have administrative permissions in other Microsoft purchasing systems, but do not have Global Administrator or Billing Administrator roles used to access the admin center.

**When is the Modern Commerce Administrator role assigned?**

* **Self-service purchase in Microsoft 365 admin center** – Self-service purchase gives users a chance to try out new products by buying or signing up for them on their own. These products are managed in the admin center. Users who make a self-service purchase are assigned a role in the commerce system, and the Modern Commerce Administrator role so they can manage their purchases in admin center. Admins can block self-service purchases (for Fabric, Power BI, Power Apps, Power automate) through [PowerShell](/microsoft-365/commerce/subscriptions/allowselfservicepurchase-powershell). For more information, see [Self-service purchase FAQ](/microsoft-365/commerce/subscriptions/self-service-purchase-faq).
* **Purchases from Microsoft commercial marketplace** – Similar to self-service purchase, when a user buys a product or service from Microsoft AppSource or Azure Marketplace, the Modern Commerce Administrator role is assigned if they don't have the Global Administrator or Billing Administrator role. In some cases, users might be blocked from making these purchases. For more information, see [Microsoft commercial marketplace](/azure/marketplace/marketplace-faq-publisher-guide#what-could-block-a-customer-from-completing-a-purchase-).
* **Proposals from Microsoft** – A proposal is a formal offer from Microsoft for your organization to buy Microsoft products and services. When the person who is accepting the proposal doesn't have a Global Administrator or Billing Administrator role in Microsoft Entra ID, they are assigned both a commerce-specific role to complete the proposal and the Modern Commerce Administrator role to access admin center. When they access the admin center they can only use features that are authorized by their commerce-specific role.
* **Commerce-specific roles** – Some users are assigned commerce-specific roles. If a user isn't a Global Administrator or Billing Administrator, they get the Modern Commerce Administrator role so they can access the admin center.

If the Modern Commerce Administrator role is unassigned from a user, they lose access to Microsoft 365 admin center. If they were managing any products, either for themselves or for your organization, they won't be able to manage them. This might include assigning licenses, changing payment methods, paying bills, or other tasks for managing subscriptions.

> [!div class="mx-tableFixed"]
> | Actions | Description |
> | --- | --- |
> | microsoft.commerce.billing/partners/read |  |
> | microsoft.commerce.volumeLicenseServiceCenter/allEntities/allTasks | Manage all aspects of Volume Licensing Service Center |
> | microsoft.office365.supportTickets/allEntities/allTasks | Create and manage Microsoft 365 service requests |
> | microsoft.office365.webPortal/allEntities/basic/read | Read basic properties on all resources in the Microsoft 365 admin center |

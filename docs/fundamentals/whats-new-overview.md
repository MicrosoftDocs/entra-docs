---
title: What's new
description: Overview of the What's new experience in the Microsoft Entra admin center.
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: overview
ms.date: 11/13/2024
ms.author: barclayn

# Customer intent: As a customer, I want an overview of the What's new experience in the Microsoft Entra admin center.
---

# What's new

Microsoft Entra is updated regularly to deliver new features, enhance existing functionality, fix defects, and address customer feedback. The best way to stay current with these developments is to visit **What's new** in the [Microsoft Entra admin center](./entra-admin-center.md). 

**What's new** is an information hub that provides a consolidated view of the Microsoft Entra roadmap and change announcements. It gives administrators a centralized location to track, learn, and plan for the releases and changes across the Microsoft Entra family of products. 

The remaining sections describe the features and functionality of the **What's new** experience.

## Explore What's new

### Highlights

The **Highlights** tab summarizes important product releases and impactful changes. From the Highlights tab, you can select an announcement or release to view its details and access links to documentation for more information.

:::image type="content" source="./media/whats-new/entra-whats-new-highlights.png" alt-text="Screenshot of the Microsoft Entra What's new Highlights experience in the Microsoft Entra admin center.":::

### Roadmap

The **Roadmap** tab lists the details of public preview and recent general availability releases in a sortable table. From the table, you can select a release to view the release **Details** which includes an overview and link to learn more.

:::image type="content" source="./media/whats-new/entra-whats-new-roadmap.png" alt-text="Screenshot of the Microsoft Entra What's new Roadmap experience in the Microsoft Entra admin center.":::

To find a release, you can customize the table view using the following controls:

* **Search**: Enter keywords to find a specific release.
* **Add filter**: Filter by **Release Type** or by **State**.
* **Category**: Filter by product and/or feature category (for example, *User Authentication*, *Identity Governance*)
* **Release Date**: Filter by date range.
* **Manage view**: Remove or add columns.

#### Roadmap column descriptions

The following are the descriptions for the sortable columns in the roadmap table:

|Column  |Description |
|---------|---------|
|**Title**| Brief description of the product or feature. |
|**Category**| The identity and network access category of the product or feature (for example, *Identity Governance*, *Identity Security & Protection*). |
|**Service**| The Microsoft Entra service of the product or feature (for example, *Entitlement Management*, *Conditional Access*). |
|**Release Type**| The [lifecycle phase](./licensing-preview-info.md) of the release: <ul><li>*Public Preview*: Available to all customers with the required license. The release might include limited customer support, and standard service level agreements don't apply.</li><li>*GA* (general availability): Available to all licensed customers. The release is supported via all Microsoft support channels.</li></ul> |
|**Release Date**| Date the release is made available. |
|**State**| Indicates whether the release is *Available* or *Coming Soon*. |

### Change announcements

The **Change announcements** tab lists the upcoming changes to existing products and features in a sortable table. From the table, you can select a change announcement to view the change **Details** which includes an overview of what's changing and link to learn more.

:::image type="content" source="./media/whats-new/entra-whats-new-change-announcements.png" alt-text="Screenshot of the Microsoft Entra What's new Change announcements experience in the Microsoft Entra admin center.":::

To find a change announcement, you can customize the table view using the following controls:

* **Search**: Enter keywords to find a specific release.
* **Add filter**: Filter by **Action Required** or by **Change Type**.
* **Service**: Filter by the product or feature service (for example, *Entitlement Management*, *Conditional Access*)
* **Release Date**: Filter by date range.
* **Manage view**: Remove or add columns.

#### Roadmap column descriptions

The following are the descriptions for the sortable columns in the roadmap table:

|Column  |Description |
|---------|---------|
|**Title**| Brief description of the product or feature. |
|**Service**| The Microsoft Entra service of the product or feature (for example, *Entitlement Management*, *Conditional Access*). |
|**Change Type**| The scope of the change: <ul><li>*UX Change*: A user experience change that doesn't require action.</li><li>*Feature Change*: A change to existing functionality that might require action.</li><li>*Breaking Change* A change that is expected to break the user experience if no action is taken.</li><li>*Deprecation*: The product or feature is no longer available to new customers and is scheduled for retirement. Deprecated products or features are still available and supported for existing customers.</li><li>*Retirement*: The product or feature is no longer available or supported.</li><li>End of Support: Product or feature is no longer supported for existing customers.</li></ul> |
|**Announcement Date**| Date of the announcement. |
|**Target Date**| The release date of the change. |
|**Action Required**| Indicates whether the change requires a user to take action. |

## What's new FAQ

### Why do we need a What's new feature when we already have the Microsoft 365 and Azure roadmaps?

Not all Microsoft Entra products are part of Microsoft 365 and Azure (for example, Microsoft Entra Permissions Management, Microsoft Entra External ID). The What's new feature ensures transparency about new features and changes across all Microsoft Entra products in a centralized location.

### Is What's new publicly accessible like the Microsoft 365 roadmap? 

No, to access What's new you must sign in to the Microsoft Entra admin center. The sign in requirement enables us to provide a more personalized experience, tailored specifically to each tenant in future versions of What's new.

### Can I consume Microsoft Entra updates programmatically and automate processes? 

Yes, in the future you can use [Microsoft Graph](/graph/identity-network-access-overview) to retrieve updates (currently in beta) and automate processes. For example, you can automate responses to feature lifecycle events or integrate them with a product lifecycle management system.

### Can I still use the existing RSS feeds and view the public release notes for What's new information?

Yes, the existing RSS feeds and [release notes](./whats-new.md) are still available.

### Can I access What's new in the Microsoft 365 or Azure portal? 

No, What's new is available only in the Microsoft Entra admin center.

### How can I provide feedback about this feature?

To share feedback, go to the **Roadmap** tab or the **Change announcements** tab and select **Got feedback?**.

### Do I need a specific Microsoft Entra role to access What's new?

No, all Microsoft Entra ID roles can access the What's new feature.

### Are there any licensing requirements to access What's new?

No, What's new is available to all Microsoft Entra customers, including Microsoft Entra ID Free.

### Can guest users in my tenant access What's new?

Yes, What's new is accessible to your business guests.

###	Is What’s new available to government cloud customers? 

Currently, What's new is only available to public cloud customers. But, there are plans to deliver the What's new experience to government clouds in the future.

###	Does What's new include all Microsoft Entra products?

Yes, What's new provides a consolidated view of the releases and change announcements across the Microsoft Entra product family.

## Related content

[Microsoft Entra releases and announcements](./whats-new.md)
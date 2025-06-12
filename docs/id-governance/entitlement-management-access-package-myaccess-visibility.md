---
title: Understanding Access Package Visibility in the My Access portal
description: Get an overview of access package visibility in the My Access portal.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: overview
ms.date: 06/12/2025
ms.author: owinfrey

#Customer intent: As an Identity Governance Administrators, Catalog Owners, or Access Package Manager, I want detailed information about which access packages are visible to users when discovering packages in the My Access portal.

---


# Understanding Access Package Visibility in the My Access Portal

**Introduction**


The [My Access portal](https://myaccess.microsoft.com) is the central place for users to request, approve, and review their access to resources within Microsoft Entra. For administrators, the portal provides additional functionalities through the Microsoft Entra admin center, enabling them to configure access packages and conduct access reviews.

When managing access to resources in Microsoft Entra, understanding how access packages appear to users in the [My Access portal](https://myaccess.microsoft.com) is essential for administrators, catalog owners, and access package managers. Access package visibility determines which packages users can discover and request, and is influenced by several configuration settings and upcoming changes. This article provides a detailed overview of the factors that control access package visibility in the My Access portal, outlines the current logic, and highlights important updates effective September 30, 2025. 

**Deep Dive: Discovering Requestable Access Packages**

When a user lands on the "Available" tab, searches for requestable packages, or clicks "View all", Microsoft Entra evaluates which access packages they should be able to see and potentially request. This visibility is determined by a specific sequence of checks.

The following flow diagram illustrates the logic used to determine if an access package appears in the browse/search view for a specific user (valid until September 30, 2025 - see Upcoming Changes section below):

:::image type="content" source="media/entitlement-management-access-package-myaccess-visibility/image1.png" alt-text="Screenshot of visibility diagram for access package.":::

Explaining the Visibility Flow

Let's walk through the decision points in the diagram:

1.  Is the catalog enabled? The system first checks if the Catalog containing the access package is enabled. If the entire Catalog is disabled, none of its packages will be visible for discovery.

1.  Is the end-user an external user? The system checks if the user is an external user or an internal user. This affects the next step.

    1.  (If external user) Is the catalog enabled for external users? For external users, the catalog must *also* be specifically enabled for external users in its settings. If not, external users won't see packages from this catalog. Internal users skip this check.

1.  Is the access package hidden? This checks the specific 'hidden' setting directly on the Access Package's properties (under 'Edit'). If set to 'Yes', the package is hidden from the browse/search view, regardless of policies.

1.  Does at least one enabled policy exist for the access package where 'Who can request' matches the end-user? This is the final, crucial policy check. The system looks for *at least one policy* associated with the access package that meets ALL these criteria:
    1.  The policy itself is enabled (the 'Enable new requests' setting in the policy UI is toggled on).

    1.  The policy's "Who can request" setting logically includes the current user based on their identity, group memberships, or
        connected organization affiliation.

    1.  Policies set to "None (Administrator direct assignments only)" do not make a package visible for Browse or searching.

If **all** these checks pass, then the access package is Visible in the user's browse/search view. Otherwise, it's not visible.


> [!IMPORTANT]
> Effective September 30, 2025: The visibility behavior described above for policies scoped to "Specific users and groups" is
> changing. See the [Upcoming Changes to Visibility](entitlement-management-access-package-myaccess-visibility.md) section for crucial details and required actions.

## Upcoming Changes to visibility

Effective September 30 2025, the visibility on the [My Access portal](myaccess.microsoft.com) will change for access packages configured with one or more policies where "Who can request access" is set to **"For users in your directory: Specific users and groups.** Access packages configured for "Specific users and groups" will be visible to all members (excluding guests) in the My Access portal. If you do not want these access packages visible to all members, you must hide the access package by this date.

The visibility change will only impact how end-users can discover access packages via the 'Available' tab, the 'View all' option, or when using the search bar within these sections to find requestable access packages. The change will not impact the visibility logic for other tabs like 'Suggested', 'Active', or 'Expired' (even when using search within those tabs), nor does it impact other My Access portal sections such as 'Request history' or 'Approvals'.

Updated diagram

<img src="media/entitlement-management-access-package-myaccess-visibility/image2.png" style="width:2.3125in;height:6.5in"
alt="A diagram of a diagram AI-generated content may be incorrect." />

[AP visibility
post-change.png](https://microsoft-my.sharepoint-df.com/:i:/p/alfilipi/EVxarE4n0CtOg7MI8a7MkagBRiT6AKKBCkwCYTIePU1sKQ?e=K43gxu)
(mermaid also in appendix)

Next Steps:

We recommend you review the access packages currently configured with policies scoped to "Specific users and groups" in your tenant. If the access package contains sensitive information that you would not want all members (excluding guests) to see, hide the access package by **September 30, 2025**, to ensure the desired end-user experience on the My Access portal.

To hide an access package, follow this article: [Change the Hidden section](entitlement-management-access-package-edit.md#change-the-hidden-setting).

To see all access packages that are scoped to specific users and groups in your tenant, see the following PowerShell script:

<span class="mark">\[PowerShell script/ MS Graph call to see all access
packages scoped to users and groups\]</span>

**Resource Role Visibility Control**

Coinciding with this change, we are also introducing a **new tenant-wide setting** that allows you to control the end-user visibility of the resource roles (e.g., group and app names) contained within access packages. This setting applies tenant-wide to *all* access packages and offers the following visibility options:

- None: The ‘Resource’ tab after selecting a given access package on the My Access portal will never be available.

- All members (excluding guests): The ‘Resource’ tab after selecting a given access package on the My Access portal will be available to member users.

- All users (including guests) - *this will be the default*: The ‘Resource’ tab after selecting a given access package on the My Access portal will be available to all users.


> [!NOTE]
> If the access package is not visible for the end-user according to the **Deep Dive: Discovering Requestable Access Packages**, then the ‘resource’ tab won’t be available either. To configure this setting, go to the Microsoft Entra Admin Center with at least the Identity Governance role, and navigate to Entitlement Lifecycle Management > Control Configurations > My Access settings to see the resource role visibility control setting.

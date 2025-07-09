---
title: Understanding access package visibility in the My Access portal
description: A conceptual article describing access package visibility in the My Access portal.
author: owinfreyATL
manager: dougeby
ms.service: entra-id-governance
ms.subservice: lifecycle-workflows
ms.topic: conceptual
ms.date: 06/12/2025
ms.author: owinfrey

#Customer intent: As an Identity Governance Administrator, Catalog Owner, or Access Package Manager, I want detailed information about which, and why, access packages are visible to users when discovering packages in the My Access portal.

---


# Understanding access package visibility in the My Access portal

The [My Access portal](https://myaccess.microsoft.com) is the central place for users to request, approve, and review their access to resources within Microsoft Entra. For administrators, the Microsoft Entra admin center provides extra functionalities, enabling configuration of access packages and the ability to conduct access reviews.

When you manage access to resources in Microsoft Entra, understanding how access packages appear to users in the [My Access portal](https://myaccess.microsoft.com) is essential. Access package visibility determines which packages users can discover and request, and is influenced by several configuration settings and planned changes. This article provides a detailed overview of the factors that control access package visibility in the My Access portal, explains how it currently works, and highlights important changes effective October 10, 2025. 

## Discovering requestable access packages

When a user lands on the "*Available*" tab, searches for requestable packages, or selects "*View all*," Microsoft Entra evaluates which access packages they should be able to see and potentially request. This visibility is determined by a specific sequence of checks.

The following flow diagram illustrates the current logic used to determine if an access package appears in the browse/search view for a specific user:

> [!IMPORTANT]
> Effective October 10, 2025: The visibility behavior described here for policies scoped to "*Specific users and groups*" is changing. See the [Upcoming Changes to Visibility](entitlement-management-access-package-visibility.md#upcoming-changes-to-visibility) section for crucial details and required actions.

:::image type="content" source="media/entitlement-management-access-package-visibility/visibility-diagram.png" alt-text="Screenshot of access package visibility diagram current workflow." lightbox="media/entitlement-management-access-package-visibility/visibility-diagram.png":::

**Explaining the current visibility flow**

The logic of this diagram is as follows:

1.  **Is the catalog enabled?** The system first checks if the catalog containing the access package is enabled. If the entire catalog is disabled, none of its packages are visible for discovery.

1.  **Is the end-user an external user?** The system checks if the user is an external user or an internal user. This affects the next step.

    1.  **(If external user) Is the catalog enabled for external users?** For external users, the catalog must **also** be enabled for external users in its settings. If not, external users don't see packages from this catalog. Internal users skip this check.

1.  **Is the access package hidden?** This checks the specific "hidden" setting directly on the access package's properties (under "Edit"). If set to "Yes," the package is hidden from the browse/search view, regardless of policies.

1.  **Does at least one enabled policy exist for the access package where 'Who can request' matches the end-user?** This is the final, crucial policy check. The system looks for *at least one policy* associated with the access package that meets ALL these criteria:
    1.  The policy itself is enabled (the 'Enable new requests' setting in the policy UI is toggled on).

    1.  The policy's "*Who can request*" setting logically includes the current user based on their identity, group memberships, or connected organization affiliation.

    1.  Policies set to "None (Administrator direct assignments only)" don't make a package visible for Browse or searching.

If **all** these checks pass, then the access package is Visible in the user's browse/search view. Otherwise, it's not visible.

## Upcoming changes to visibility

Effective October 10, 2025, the visibility on the [My Access portal](https://myaccess.microsoft.com) will change for access packages configured with one or more policies where "Who can request access" is set to **"For users in your directory: Specific users and groups.** Access packages configured for "Specific users and groups" will be visible to all members (excluding guests) in the My Access portal. If you don't want the access packages visible to all members, you must hide the access package by this date.

The visibility change will only impact how end-users can discover access packages via the "Available" tab, the "View all" option, or when using the search bar within these sections to find requestable access packages. The change won't impact the visibility logic for other tabs like "Suggested," "Active," or "Expired" (even when using search within those tabs), nor does it impact other My Access portal sections such as "Request history" or "Approvals."

The following flow diagram illustrates the logic, effective October 10, 2025, used to determine if an access package appears in the browse/search view for a specific user:

:::image type="content" source="media/entitlement-management-access-package-visibility/visibility-diagram-2.png" alt-text="Screenshot of updated my access visibility access package diagram." lightbox="media/entitlement-management-access-package-visibility/visibility-diagram-2.png":::


### Next Steps

We recommend you review the access packages currently configured with policies scoped to "Specific users and groups" in your tenant. If the access package name, description, or the name and description of the contained resource roles are sensitive information that you wouldn't want all members, excluding guests, to see, hide the access package by **October 10, 2025** to ensure the desired end-user experience on the My Access portal.

To hide an access package, follow these steps: [Change the Hidden section](entitlement-management-access-package-edit.md#change-the-hidden-setting).

To see all access packages that are scoped to specific users and groups in your tenant, see the following PowerShell script:

<span class="mark">\[PowerShell script/ MS Graph call to see all access
packages scoped to users and groups\]</span>

## Resource role visibility control

Coinciding with this change, we're also introducing a **new tenant-wide setting** that allows you to control the end-user visibility of the resource roles (for example, group and app names) contained within access packages. This setting applies tenant-wide to *all* access packages and offers the following visibility options:

- None: The "Resource" tab after selecting a given access package on the My Access portal will never be available.

- All members (excluding guests): The "Resource" tab after selecting a given access package on the My Access portal will be available to member users.

- All users (including guests) - *this will be the default*: The "Resource" tab after selecting a given access package on the My Access portal will be available to all users.


> [!NOTE]
> If the access package isn't visible for the end-user according to the **Deep Dive: Discovering Requestable Access Packages**, then the "resource" tab won’t be available either. To configure this setting, go to the Microsoft Entra Admin Center with at least the Identity Governance role, and navigate to Entitlement Management > Control Configurations > My Access settings to see the resource role visibility control setting.

## Related content

- [Microsoft Entra ID Governance](identity-governance-overview.md)
- [What is the My Access portal?](my-access-portal-overview.md)


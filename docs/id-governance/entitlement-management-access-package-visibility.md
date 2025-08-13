---
title: Understand access package visibility in the My Access portal
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


# Understand access package visibility in the My Access portal

> [!IMPORTANT]
> In July 2025 we announced that the visibility behavior for access packages scoped to "Specific users and groups" would be changing. The previously announced changes to access package visibility have been cancelled. No action is required at this time.

The [My Access portal](https://myaccess.microsoft.com) is the central place for users to request, approve, and review their access to resources within Microsoft Entra. For administrators, the Microsoft Entra admin center provides extra functionalities, enabling configuration of access packages and the ability to conduct access reviews.

When you manage access to resources in Microsoft Entra, understanding how access packages appear to users in the [My Access portal](https://myaccess.microsoft.com) is essential. Access package visibility determines which packages users can discover and request, and is influenced by several configuration settings and planned changes. This article provides a detailed overview of the factors that control access package visibility in the My Access portal, explains how it currently works, and highlights important changes effective October 10, 2025. 

## Discover requestable access packages

When a user lands on the "*Available*" tab, searches for requestable packages, or selects "*View all*," Microsoft Entra evaluates which access packages they should be able to see and potentially request. This visibility is determined by a specific sequence of checks.

The following flow diagram, which can be selected to enlarge, illustrates the current logic used to determine if an access package appears in the browse/search view for a specific user:

:::image type="content" source="media/entitlement-management-access-package-visibility/visibility-diagram-small.png" alt-text="Diagram of access package visibility before October changes." lightbox="media/entitlement-management-access-package-visibility/visibility-diagram.png":::

**Explaining the current visibility flow**

The logic of this diagram is as follows:

1.  **Is the catalog enabled?** The system first checks if the catalog containing the access package is enabled. If the entire catalog is disabled, none of its packages are visible for discovery.

1.  **Is the end-user an external user?** The system checks if the user is an external user or an internal user. This affects the next step.

    - **(If external user) Is the catalog enabled for external users?** For external users, the catalog must **also** be enabled for external users in its settings. If not, external users don't see packages from this catalog. Internal users skip this check.

1.  **Is the access package hidden?** This checks the specific "hidden" setting directly on the access package's properties (under "Edit"). If set to "Yes," the package is hidden from the browse/search view, regardless of policies.

1.  **Does at least one enabled policy exist for the access package where 'Who can request' matches the end-user?** This is the final, crucial policy check. The system looks for *at least one policy* associated with the access package that meets ALL these criteria:
    1.  The policy itself is enabled (the 'Enable new requests' setting in the policy UI is toggled on).

    1.  The policy's "*Who can request*" setting logically includes the current user based on their identity, group memberships, or connected organization affiliation.

    1.  Policies set to "None (Administrator direct assignments only)" don't make a package visible for Browse or searching.

If **all** these checks pass, then the access package is Visible in the user's browse/search view. Otherwise, it's not visible.

## Related content

- [Microsoft Entra ID Governance](identity-governance-overview.md)
- [What is the My Access portal?](my-access-portal-overview.md)


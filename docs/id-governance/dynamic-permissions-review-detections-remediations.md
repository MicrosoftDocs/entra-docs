---
title: View detections and remediations (Preview)
description: Learn how to see the dynamic permissions detection results and remediation details for non-human identities in catalog resources in Microsoft Entra ID Governance.
ms.topic: how-to
ms.date: 11/14/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to see the dynamic permissions detection results and remediation details so that I can understand planned remediation actions and remediation status for identities in catalog resources.
---

# View detections and remediations (Preview)

As an Identity Governance Administrator, you can see results of dynamic permission detection of non-human identities across resources in a catalog in Microsoft Entra ID Governance. You can then select an identity to view more detection details, including the planned remediation action and remediation status.

This feature focuses on overpermissioned non-human identities. For viewing the discovered users and groups in applications, see [Discover identities in target applications with account discovery](../identity/app-provisioning/how-to-account-discovery.md).

## Prerequisites

### Licensing

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

### Resource setup

Before viewing detections, you will need to 

 * Have one or more resource in the catalog already set up for permission remediation.
 * Optionally, configured [separation of duties rules for non-human identities](dynamic-permissions-manage-separation-duties.md).

If you're getting started, see [Tutorial: Mitigate permission risk of agents in Snowflake with Microsoft Entra dynamic permissions](tutorial-dynamic-permissions-prevent-excessive-permissions.md).

## View detections and remediations

To see detections and remediation details for the resources in a catalog, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).
1. Browse to **ID Governance** > **Dynamic permissions (preview)**.
1. Select **Detections**.
1. Select a catalog which has the desired resources:

    - If you're visiting **Detections** for the first time, select a catalog when prompted.
    - If you've already selected a catalog and want to see the detections from another catalog, select **Change catalog**, and then select the other catalog.

1. The detections are shown for each identity in a resource impacted by a rule. Select an identity to view the detection details, including the planned remediation action and remediation status, if configured.

    :::image type="content" source="media/dynamic-permissions-review-detections-remediations/view-detections.png" alt-text="Screenshot of the Detections page showing an identity's risk categories, resource, and remediation status." lightbox="media/dynamic-permissions-review-detections-remediations/view-detections-expanded.png" border="true":::

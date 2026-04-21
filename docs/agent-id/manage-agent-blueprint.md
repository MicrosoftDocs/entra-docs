---
title: Manage agent identity blueprints in the Microsoft Entra admin center
titleSuffix: Microsoft Entra Agent ID
description: Learn how to manage agent identity blueprints in the Microsoft Entra admin center, including viewing permissions, managing credentials, and configuring owners and sponsors.
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.topic: how-to

#customer intent: As an IT administrator, I want to manage agent identity blueprints through the Microsoft Entra admin center so that I can monitor their status, configure permissions, and maintain proper governance oversight.
ms.reviewer: alamaral

---

# View and manage agent identity blueprints in your tenant

The Microsoft Entra admin center allows you to view all agent identity blueprint principals in your tenant. You can search, filter, sort, and manage blueprint principals including their credentials, permissions, and owners.

[!INCLUDE [entra-agent-id-preview-note](../includes/entra-agent-id-preview-note.md)]

## Navigate to the agent identity blueprint list

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agent ID** > **Agent blueprints**.
1. Select a blueprint principal to open its management page.

## Search and filter blueprints

1. Enter the **name** or **object ID** of the blueprint principal in the search box.
1. To look up a blueprint by its **Agent Blueprint ID**, select **Add filters** and add the **Agent Blueprint ID** filter.
1. You can further refine the list using filters based on various criteria.

## Select viewing options

To customize your view, select **Choose columns** to configure which columns are shown. The available columns are:

| Column Name | Description | Sortable | Filterable | Special notes
|-------------|-------------|:--------:|:----------:|------------------|
| **Name** | Display name of the agent identity blueprint principal | ✓ | ✓ | Primary search field; clickable to view details of the agent identity blueprint principal |
| **Agent identities** | The number of child agent identities created by the agent blueprint principal| ✗ | ✗ | Select this to see a list of linked child agent identities for that agent identity blueprint principal|
| **Status** | Current operational state (Active, or Disabled) | ✓ | ✓ |  |
| **Agent Blueprint ID** | Unique identifier for the agent identity blueprint of this agent identity blueprint principal | ✗ | ✓ | |
| **Object ID** | Unique identifier for agent blueprint principal | ✗ | ✓ | |

## View linked agent identities

View the agent identities that were created from a blueprint.

1. From the blueprint's management page, select **Linked agent identities** from the left menu.
1. The list shows each linked identity with its **Name**, **Status**, **View Access** link, and **Owners and Sponsors**.
1. Select an identity name to navigate to its detail page.
1. Use **Add filters** to refine the list.

## View granted permissions

Review the permissions assigned to a blueprint principal, organized by consent type.

1. From the blueprint's management page, select **Granted permissions** under **Access**.
1. Select the **Admin consent** tab to view permissions granted through administrator consent, or select the **User consent** tab to view permissions granted through user consent.
1. The list shows the **API name**, **Claim value**, **Permission**, **Type**, **Granted through**, and **Granted by** for each permission entry.

## Manage credentials

Configure the credentials that agent identities use to authenticate. The credentials page has three tabs for different credential types.

:::image type="content" source="media/manage-agent-blueprint/blueprint-credentials-page.png" alt-text="Screenshot of the blueprint credentials page showing three tabs for certificates, client secrets, and federated credentials." lightbox="media/manage-agent-blueprint/blueprint-credentials-page.png":::

> [!IMPORTANT]
> To best align with Zero Trust principles, use federated credentials or certificates instead of client secrets.

### Upload a certificate

1. From the blueprint's management page, select **Credentials** under **Developer settings**.
1. Select the **Certificates** tab.
1. Select **Upload certificate**.
1. Browse to and select the certificate file, and optionally add a description.
1. Select **Add**.

### Create a client secret

1. From the blueprint's management page, select **Credentials** under **Developer settings**.
1. Select the **Client secrets** tab.
1. Select **New client secret**.
1. Enter a **Description** for the secret.
1. Select an expiration period under **Expires**. For custom expiration, set the **Start** and **End** dates.
1. Select **Add**.
1. Copy the secret **Value** immediately. The value isn't displayed again after you leave the page.

> [!NOTE]
> Your tenant policy might limit the maximum lifetime for client secrets.

### Add a federated credential

Federated credentials use workload identity federation to establish trust between Microsoft Entra and external identity providers without storing secrets. For more information about these scenarios and how workload identity federation works, see [Workload identity federation](/entra/workload-id/workload-identity-federation).
 
Take the following steps to add a federated credential for an agent identity blueprint principal.

1. From the blueprint's management page, select **Credentials** under **Developer settings**.
1. Select the **Federated credentials** tab.
1. Select **Add credential**.
1. Under **Federated credential scenario**, select a scenario:
    - **Managed Identity** — Configure a managed identity to get tokens and access resources across tenants.
    - **GitHub Actions deploying Azure resources** — Configure a GitHub workflow to get tokens and deploy to Azure.
    - **Kubernetes accessing Azure resources** — Configure a Kubernetes service account to get tokens and access Azure resources.
    - **Other issuer** — Configure an identity managed by an external OpenID Connect provider.
1. Complete the required fields for the selected scenario.
1. Select **Add**.

## Manage owners and sponsors

Owners and sponsors help establish governance for your blueprint. From the **Owners and sponsors** page in the left menu, you can manage ownership for both the agent blueprint and the agent blueprint principal.

The page displays owners and sponsors for both the agent blueprint and agent blueprint principal. Owners have full access to manage the agent, while sponsors are responsible parties who can manage lifecycle workflows and access.

### Agent blueprint owners and sponsors

1. From the blueprint's management page, select **Owners and sponsors** from the left menu under **Access**.
1. Select the **Agent blueprint** tab.
1. Use this tab to view, add, or remove owners and sponsors for the identity blueprint. The identity blueprint defines the shared identity and access settings for multiple agent instances.
1. To add owners or sponsors, select **Add** and search for users by name or email.
1. To remove owners or sponsors, select the checkbox next to their name and select **Remove**.

### Agent blueprint principal owners and sponsors

1. From the blueprint's management page, select **Owners and sponsors** from the left menu under **Access**.
1. Select the **Agent blueprint principal** tab.
1. Use this tab to view, add, or remove owners and sponsors specifically for the blueprint principal.
1. To add owners or sponsors, select **Add** and search for users by name or email.
1. To remove owners or sponsors, select the checkbox next to their name and select **Remove**.

For detailed steps on managing owners and sponsors, see [Add and manage owners and sponsors for agent identities](manage-owners-sponsors-agents.md).

## View audit and sign-in logs

You can view logs for both the agent blueprint principal and the blueprint itself from the blueprint's management page.

### Agent blueprint principal activity

- To view administrative actions taken on the blueprint principal, select **Audit logs** from the left menu under **Agent blueprint principal activity**.
- To view sign-in activity for the blueprint principal, select **Sign-in logs** from the left menu under **Agent blueprint principal activity**. For more information, see [view sign-in logs for agents](sign-in-audit-logs-agents.md).

### Agent blueprint activity 

- To view administrative actions related to the blueprint configuration, select **Audit logs** from the left menu under **Agent blueprint activity**.
- To view sign-in activity related to the blueprint, select **Sign-in logs** from the left menu under **Agent blueprint activity**. For more information, see [view sign-in logs for agents](sign-in-audit-logs-agents.md).

## Disable an agent identity blueprint principal

To disable an agent identity blueprint principal, select the **Disable** button in the command bar at the top of the blueprint's overview page.

---
title: "Tutorial: Mitigate permission risk of agents in Snowflake with Microsoft Entra dynamic permissions"
description: Learn how to prepare Snowflake, configure dynamic permissions for a catalog, and view the resulting permission rule detections for AI agents in Microsoft Entra ID Governance.
ms.topic: tutorial
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to prevent excessive permissions for AI agents so that I can limit their access with dynamic permissions.
---

# Tutorial: Mitigate permission risk of agents in Snowflake with Microsoft Entra dynamic permissions

Microsoft Entra ID Governance dynamic permissions helps organizations ensure least privilege for permissions assigned to identities in their applications. During preview, it evaluates privilege levels and separation of duties conflicts to identify agents with powerful permissions and combinations of access that violate your organization's rules.

In this tutorial, you connect Snowflake, enable permission remediation for a catalog, and review detections and planned remediation actions for Snowflake agent identities. For more information, see [What is dynamic permissions?](dynamic-permissions-overview.md).

During preview, dynamic permissions assesses excessive access for Snowflake users with `TYPE = SERVICE_AGENT`. For more information, see the user `TYPE` property in [Snowflake's CREATE USER reference](https://docs.snowflake.com/en/sql-reference/sql/create-user#optional-object-properties-objectproperties).

In this tutorial, you:

> [!div class="checklist"]
> - Prepare your Snowflake account for discovery.
> - Enable dynamic permissions remediation for a catalog.
> - Add Snowflake to the catalog and configure permission remediation.
> - Start recurring discovery to refresh Snowflake identity and permission data.
> - See the resulting detections and remediation details.

## Prerequisites

- A Snowflake account. Microsoft recommends piloting dynamic permissions with a non-production Snowflake account during preview.
- Access to a Snowflake user with the `ACCOUNTADMIN` role.
- A catalog in Microsoft Entra ID Governance. If you don't have one, [create a catalog](entitlement-management-catalog-create.md).
- A **Snowflake** enterprise application added from the Microsoft Entra application gallery. Use the gallery application, not a custom non-gallery application.
    - Be an owner of the existing application, or [add a new Snowflake gallery application](../identity/saas-apps/snowflake-tutorial.md#add-snowflake-from-the-gallery) as at least a [Cloud Application Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
- Access to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

Typically, you'll use a Snowflake application already integrated with Microsoft Entra ID for single sign-on (SSO) and System for Cross-domain Identity Management (SCIM) provisioning. However, neither integration is required for this tutorial. You can add a new Snowflake gallery application without configuring SSO or SCIM. For integration guidance, see [Configure single sign-on for Snowflake](../identity/saas-apps/snowflake-tutorial.md) and [Configure automatic user provisioning for Snowflake](../identity/saas-apps/snowflake-provisioning-tutorial.md).

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

## Prepare your Snowflake account for discovery

To analyze permissions for AI agents in Snowflake, Microsoft Entra uses a dedicated service user separate from the Snowflake SCIM security integration. The dedicated service user currently authenticates with a Programmatic Access Token (PAT).

Microsoft recommends piloting dynamic permissions with a non-production Snowflake account during preview.

[!INCLUDE [snowflake-prepare-discovery-identity-governance](~/includes/snowflake-prepare-discovery-identity-governance.md)]

## Add an overpermissioned test agent (optional)

To validate permission remediation, you can add an overpermissioned test agent in your Snowflake test account.

> [!WARNING]
> This example grants the test agent the `ACCOUNTADMIN` role. Run it only in a non-production Snowflake test account.

1. Sign in to your Snowflake account as a user with the `ACCOUNTADMIN` role.
1. Run the following SQL commands:

    ```sql
    USE ROLE ACCOUNTADMIN;

    CREATE USER MY_SERVICE_AGENT
      TYPE = SERVICE_AGENT;

    GRANT ROLE ACCOUNTADMIN TO USER MY_SERVICE_AGENT;

    SHOW GRANTS TO USER MY_SERVICE_AGENT;
    ```

> [!IMPORTANT]
> After completing this tutorial, remove the `MY_SERVICE_AGENT` test user from your Snowflake test account.

## Enable dynamic permissions remediation for a catalog

Enable permission remediation for the catalog you'll use in this tutorial.

Enabling permission remediation for a catalog automatically enables it for all supported resources in that catalog, provided connectivity to those resources is established. Currently, only Snowflake is supported.

[!INCLUDE [Dynamic permissions reporting phase](~/includes/dynamic-permissions-reporting-phase.md)]

1. Sign in to the Microsoft Entra admin center as at least an Identity Governance Administrator.
1. Browse to **ID Governance** > **Dynamic permissions (preview)**.
1. Select **Resources**, and then select **Enable dynamic permissions**.

    :::image type="content" source="media/dynamic-permissions-manage-catalog-settings/enable-dynamic-permissions.png" alt-text="Screenshot of the Dynamic permissions Resources page with the Enable dynamic permissions button highlighted." lightbox="media/dynamic-permissions-manage-catalog-settings/enable-dynamic-permissions.png" border="true":::

1. Select the catalog for which you want to enable permission remediation.
1. Confirm the information, and set **Permission remediation** to **Enabled**.
1. Select **Enable dynamic permissions**.

## Add Snowflake to the catalog

Continue with the catalog you selected in the previous section. If the Snowflake application isn't already part of that catalog, follow these steps to add it.

1. On the **Resources** page in **Dynamic permissions (preview)**, select **Add resources**.
1. Select **+Applications**.
1. In the picker, search for your Snowflake application and select it.
1. Select **Select** to complete the picker.
1. Select **Add**.

## Configure permission remediation for Snowflake

Configure the discovery connection and enable permission remediation for the Snowflake application in your catalog. The following steps apply when **Discovery connection** shows **Not configured**.

For details about the data collected from Snowflake, see [Data collection for dynamic permissions](dynamic-permissions-data-collection.md).

> [!NOTE]
> If you already provided the discovery and identity governance connectivity information through the enterprise application and provisioning pages, enabling permission remediation for the catalog is sufficient. You don't need to explicitly enable permission remediation for Snowflake.

1. On the **Resources** page in **Dynamic permissions (preview)**, select the checkbox next to your Snowflake application. Don't select the application name.
1. Select **Configure permission remediation** at the top of the page.

    :::image type="content" source="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-snowflake-permission-remediation.png" alt-text="Screenshot of the selected Snowflake resource with the Configure permission remediation action highlighted." lightbox="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-snowflake-permission-remediation.png" border="true":::

1. Under **Discovery connection**, select **Configure**.

    :::image type="content" source="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-discovery-connection-action.png" alt-text="Screenshot of permission remediation prerequisites with Configure highlighted beside the unconfigured discovery connection." lightbox="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-discovery-connection-action.png" border="true":::

1. Enter the following connection information:

    - Your Snowflake tenant URL in the format `https://<organization-name>-<account-name>.snowflakecomputing.com`. In Snowsight, open **View account details** and copy **Account/Server URL**. For details, see [Find your Snowflake account identifier](https://docs.snowflake.com/en/user-guide/admin-account-identifier#finding-the-organization-and-account-name-for-an-account).
    - The API token generated when you prepared your Snowflake account for discovery.
    - The same Snowflake warehouse you specified in the script in [Prepare your Snowflake account for discovery](#prepare-your-snowflake-account-for-discovery).

    :::image type="content" source="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-snowflake-discovery-connection.png" alt-text="Screenshot of Snowflake discovery and identity governance connectivity settings with Tenant URL, API token, and Warehouse fields." lightbox="media/tutorial-dynamic-permissions-prevent-excessive-permissions/configure-snowflake-discovery-connection.png" border="true":::

1. Select **Save**.
1. Select **X** to close the connection configuration window and return to **Configure permission remediation**.
1. Select **Next**.
1. Select **Enable permission remediation**.

> [!NOTE]
> Microsoft is partnering with Snowflake to move both the discovery connection and the SCIM connection between Snowflake and Microsoft Entra to workload identity-based authentication in a future update.

## Start recurring discovery

After configuring permission remediation, return to the **Resources** page in **Dynamic permissions (preview)** to start recurring discovery for your Snowflake application.

1. Select the name of the Snowflake resource in your catalog to open its enterprise application page.
1. Select **Provisioning**.
1. Select **Discover identities**.

    :::image type="content" source="media/tutorial-dynamic-permissions-prevent-excessive-permissions/discover-snowflake-identities.png" alt-text="Screenshot of the Snowflake enterprise application with Discover identities highlighted in the left navigation and toolbar." lightbox="media/tutorial-dynamic-permissions-prevent-excessive-permissions/discover-snowflake-identities.png" border="true":::

1. On the **Discover identities** page, select **Discover identities** to start discovery.

> [!NOTE]
> Discovery starts immediately and then runs every 24 hours to refresh the data. The time needed to complete discovery depends on the number of identities and the amount of relevant data in the Snowflake application.

## Add separation of duties rules for Snowflake (optional)

If you want to add separation of duties rules for Snowflake, follow [Import separation of duties rules](dynamic-permissions-manage-separation-duties.md#import-separation-of-duties-rules). Then return to this tutorial to see the resulting detections and remediations.

## View detections and remediations

You can see the resulting detected non-human identities which triggered a rule for the catalog's resources, including planned remediation actions and remediation status for those identities.

1. Sign in to the Microsoft Entra admin center as at least an Identity Governance Administrator.
1. Browse to **ID Governance** > **Dynamic permissions (preview)**.
1. Select **Detections**.
1. Select the catalog you used in this tutorial. If another catalog is already selected, select **Change catalog**, and then select your catalog.
1. The detections are shown for an identity in a resource. Select an identity to view the detection details, including the planned remediation action and remediation status.

    :::image type="content" source="media/dynamic-permissions-review-detections-remediations/view-detections.png" alt-text="Screenshot of the Detections page showing an identity's risk categories, resource, and remediation status." lightbox="media/dynamic-permissions-review-detections-remediations/view-detections-expanded.png" border="true":::

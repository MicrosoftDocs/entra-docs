---
title: Configure SAP SuccessFactors API user
description: Learn how to configure an API user in SAP SuccessFactors that can be used for provisioning integrations.
author: jenniferf-skc
ms.author: jfields
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 05/26/2026
ms.reviewer: cmmdesai
ms.custom: sap-successfactors, provisioning
---

# Configure SAP SuccessFactors API user

A common requirement of all the SuccessFactors provisioning connectors is that they require credentials of a SuccessFactors account with the right permissions to invoke the SuccessFactors OData APIs. This section describes steps to create the service account in SuccessFactors and grant appropriate permissions.

## Create/identify API user account in SuccessFactors

Work with your SuccessFactors admin team or implementation partner to create or identify a user account in SuccessFactors to invoke the OData APIs. The username and password credentials of this account are required when configuring the provisioning apps in Microsoft Entra ID.

## Create an API permissions role

1. Sign in to SAP SuccessFactors with a user account that has access to the Admin Center.
1. Search for **Manage Permission Roles**, then select **Manage Permission Roles** from the search results.

    ![Screenshot of the Manage Permission Roles search result in the SAP SuccessFactors Admin Center.](./media/configure-successfactors-api-user/manage-permission-roles.png)
1. From the Permission Role List, select **Create New**.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Create New button on the Permission Role List page.](./media/configure-successfactors-api-user/create-new-permission-role-1.png)
1. Add a **Role Name** and **Description** for the new permission role. The name and description should indicate that the role is for API usage permissions.
1. Under Permission settings, select **Permission...**, then scroll down the permission list and select **Manage Integration Tools**. Check the box for **Allow Admin to Access to OData API through Basic Authentication**.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Manage Integration Tools permission with the Allow Admin to Access to OData API through Basic Authentication option selected.](./media/configure-successfactors-api-user/manage-integration-tools.png)
1. Scroll down in the same box and select **Employee Central API**. Add permissions to read using ODATA API and edit using ODATA API. Select the edit option if you plan to use the same account for the Writeback to SuccessFactors scenario.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Employee Central API permissions showing read and edit using ODATA API options.](./media/configure-successfactors-api-user/odata-read-write-perm.png)

1. In the same permissions box, go to **User Permissions** > **Employee Data** and review the attributes that the service account can read from the SuccessFactors tenant. For example, to retrieve the **Username** attribute from SuccessFactors, ensure that "View" permission is granted for this attribute. Similarly review each attribute for view permission.

    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Employee Data user permissions list for reviewing view access to attributes.](./media/configure-successfactors-api-user/review-employee-data-permissions.png)

    >[!NOTE]
    >For the complete list of attributes retrieved by this provisioning app, see [SuccessFactors Attribute Reference](~/identity/app-provisioning/sap-successfactors-attribute-reference.md).

1. Select **Done**. Select **Save Changes**.

## Create a permission group for the API user

1. In the SuccessFactors Admin Center, search for **Manage Permission Groups**, then select **Manage Permission Groups** from the search results.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Manage Permission Groups search result in the SAP SuccessFactors Admin Center.](./media/configure-successfactors-api-user/manage-permission-groups.png)
1. From the Manage Permission Groups window, select **Create New**.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Create New button on the Manage Permission Groups window.](./media/configure-successfactors-api-user/create-new-group.png)
1. Add a Group Name for the new group. The group name should indicate that the group is for API users.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of the Group Name field when creating a new permission group.](./media/configure-successfactors-api-user/permission-group-name.png)
1. Add members to the group. For example, you could select **Username** from the People Pool dropdown menu and then enter the username of the API account that's used for the integration.
    > [!div class="mx-imgBorder"]
    > ![Screenshot of adding members to a permission group by selecting Username from the People Pool dropdown.](./media/configure-successfactors-api-user/add-group-members.png)
1. Select **Done** to finish creating the Permission Group.

## Grant the permission role to the permission group

1. In SuccessFactors Admin Center, search for **Manage Permission Roles**, then select **Manage Permission Roles** from the search results.
1. From the **Permission Role List**, select the role that you created for API usage permissions.
1. Under **Grant this role to...**, select the **Add...** button.
1. Select **Permission Group...** from the dropdown menu, then select **Select...** to open the Groups window to search and select the group that you created.
1. Review the Permission Role grant to the Permission Group.
1. Select **Save Changes**.

## Related content

- [Configuring SuccessFactors for the integration](../saas-apps/sap-successfactors-inbound-provisioning-tutorial.md#configuring-successfactors-for-the-integration)

---
title: Configure Snowflake for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and deprovision user accounts to Snowflake.

author: jeevansd
ms.topic: how-to
ms.date: 03/24/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Snowflake so that I can streamline the user management process and ensure that users have the appropriate access to Snowflake.
---

# Configure Snowflake for automatic user provisioning with Microsoft Entra ID

This article demonstrates the steps that you perform in Snowflake and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and deprovision users and groups to [Snowflake](https://www.Snowflake.com/pricing/). For important details on what this service does, how it works, and frequently asked questions, see [What is automated SaaS app user provisioning in Microsoft Entra ID?](~/identity/app-provisioning/user-provisioning.md). 

## Capabilities supported

> [!div class="checklist"]
>
> * Create users in Snowflake
> * Remove users in Snowflake when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Snowflake
> * Provision groups and group memberships in Snowflake
> * Allow [single sign-on](./snowflake-tutorial.md) to Snowflake (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* [A Snowflake tenant](https://www.Snowflake.com/pricing/)
* At least one user in Snowflake with the **ACCOUNTADMIN** role.

## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Snowflake](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-snowflake-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Snowflake to support provisioning with Microsoft Entra ID

Before you configure Snowflake for automatic user provisioning with Microsoft Entra ID, you need to enable System for Cross-domain Identity Management (SCIM) provisioning on Snowflake.

1. Sign in to Snowflake as an administrator and execute the following from either the Snowflake worksheet interface or SnowSQL.

   ```
   use role accountadmin;
   
    create role if not exists aad_provisioner;
    grant create user on account to role aad_provisioner;
    grant create role on account to role aad_provisioner;
   grant role aad_provisioner to role accountadmin;
    create or replace security integration aad_provisioning
        type = scim
        scim_client = 'azure'
        run_as_role = 'AAD_PROVISIONER';
    select system$generate_scim_access_token('AAD_PROVISIONING');
   ```

1. Use the ACCOUNTADMIN role.

    ![Screenshot of a worksheet in the Snowflake UI with the SCIM access token called out.](media/Snowflake-provisioning-tutorial/step-2.png)

1. Create the custom role AAD_PROVISIONER. All users and roles in Snowflake created by Microsoft Entra ID is owned by the scoped down AAD_PROVISIONER role.

    ![Screenshot showing the custom role.](media/Snowflake-provisioning-tutorial/step-3.png)

1. Let the ACCOUNTADMIN role create the security integration using the AAD_PROVISIONER custom role.

    ![Screenshot showing the security integrations.](media/Snowflake-provisioning-tutorial/step-4.png)

1. Create and copy the authorization token to the clipboard and store securely for later use. Use this token for each SCIM REST API request and place it in the request header. The access token expires after six months and a new access token can be generated with this statement.

    ![Screenshot showing the token generation.](media/Snowflake-provisioning-tutorial/step-5.png)

<a name='step-3-add-snowflake-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Snowflake from the Microsoft Entra application gallery

Add Snowflake from the Microsoft Entra application gallery to start managing provisioning to Snowflake. If you previously set up Snowflake for single sign-on (SSO), you can use the same application. However, we recommend that you create a separate app when you're initially testing the integration. [Learn more about adding an application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Snowflake

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in Snowflake. You can base the configuration on user and group assignments in Microsoft Entra ID.

To configure automatic user provisioning for Snowflake in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.

    ![Screenshot that shows the Enterprise applications pane.](common/enterprise-applications.png)

1. In the list of applications, select **Snowflake**.

   ![Screenshot that shows a list of applications.](common/all-applications.png)

1. Select the **Provisioning** tab.

   ![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Admin Credentials** section, enter the SCIM 2.0 base URL and authentication token that you retrieved earlier in the **Tenant URL** and **Secret Token** boxes, respectively.
    >[!NOTE]
    >The Snowflake SCIM endpoint consists of the Snowflake account URL appended with `/scim/v2/`. For example, if your Snowflake account name is `acme` and your Snowflake account is in the `east-us-2` Azure region, the **Tenant URL** value is `https://acme.east-us-2.azure.snowflakecomputing.com/scim/v2`.

1. Select **Test Connection** to ensure Microsoft Entra ID can connect to Snowflake. If the connection fails, ensure your Snowflake account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Snowflake in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Snowflake for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |active|Boolean|
   |displayName|String|
   |emails[type eq "work"].value|String|
   |userName|String|
   |name.givenName|String|
   |name.familyName|String|
   |externalId|String|
   |urn:ietf:params:scim:schemas:extension:2.0:User:type [User management - Snowflake Documentation](https://docs.snowflake.com/en/user-guide/admin-user-management#label-user-management-types)|String|
 
    >[!NOTE]
    >Group display name editing is now unlocked. Previously, the group display name in Snowflake could not be changed, preventing customers from editing the mapping. It is now editable.

    >[!NOTE]
    >Snowflake supported custom extension user attributes during SCIM provisioning:
    >* DEFAULT_ROLE
    >* DEFAULT_WAREHOUSE
    >* DEFAULT_SECONDARY_ROLES
    >* SNOWFLAKE NAME AND LOGIN_NAME FIELDS TO BE DIFFERENT

    > How to set up Snowflake custom extension attributes in Microsoft Entra SCIM user provisioning is explained [here](https://community.snowflake.com/s/article/HowTo-How-to-Set-up-Snowflake-Custom-Attributes-in-Azure-AD-SCIM-for-Default-Roles-and-Default-Warehouses).

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Snowflake in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Snowflake for update operations. Select the **Save** button to commit any changes.

    |Attribute|Type|
    |---|---|
    |displayName|String|
    |members|Reference|

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Connector limitations

Snowflake-generated SCIM tokens expire in 6 months. Be aware that you need to refresh these tokens before they expire, to allow the provisioning syncs to continue working.

## Troubleshooting tips

The Microsoft Entra provisioning service currently operates under particular [IP ranges](~/identity/app-provisioning/use-scim-to-provision-users-and-groups.md#ip-ranges). If necessary, you can restrict other IP ranges and add these particular IP ranges to the allowlist of your application. That technique will allow traffic flow from the Microsoft Entra provisioning service to your application.

## Change log

* 07/21/2020: Enabled soft-delete for all users (via the active attribute).
* 10/12/2022: Updated Snowflake SCIM Configuration.

## Additional resources

* [Managing user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What are application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

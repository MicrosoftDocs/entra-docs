---
title: Configure Zendesk for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Zendesk.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Zendesk so that I can streamline the user management process and ensure that users have the appropriate access to Zendesk.
---

# Configure Zendesk for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Zendesk and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Zendesk](http://www.zendesk.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Zendesk.
> * Remove users in Zendesk when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and Zendesk.
> * Provision groups and group memberships in Zendesk.
> * [Single sign-on](./zendesk-tutorial.md) to Zendesk (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in Zendesk with Admin rights.
* A Zendesk tenant with the Professional plan or better enabled.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and Zendesk](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-zendesk-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Zendesk to support provisioning with Microsoft Entra ID

1. Sign in to [Zendesk Admin Center](https://support.zendesk.com/hc/en-us/articles/4581766374554#topic_hfg_dyz_1hb).
1. Navigate to **Apps and integrations** > **APIs** > **Zendesk APIs**.
1. Select the **Settings** tab, and make sure Token Access is **enabled**.
1. Select the **Add API token** button to the right of **Active API Tokens**. The token is generated and displayed.
1. Enter an **API token description**.
1. **Copy** the token and paste it somewhere secure. Once you close this window, the full token will never be displayed again.
1. Select **Save** to return to the API page. If you select the token to reopen it, a truncated version of the token is displayed.

<a name='step-3-add-zendesk-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Zendesk from the Microsoft Entra application gallery

Add Zendesk from the Microsoft Entra application gallery to start managing provisioning to Zendesk. If you have previously setup Zendesk for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Zendesk

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Zendesk based on user and/or group assignments in Microsoft Entra ID.

### Important tips for assigning users to Zendesk

* Today, Zendesk roles are automatically and dynamically populated in the Azure portal UI. Before you assign Zendesk roles to users, make sure that an initial sync is completed against Zendesk to retrieve the latest roles in your Zendesk tenant.

* We recommend that you assign a single Microsoft Entra user to Zendesk to test your initial automatic user provisioning configuration. You can assign more users or groups later after the tests are successful.

* When you assign a user to Zendesk, select any valid application-specific role, if available, in the assignment dialog box. Users with the **Default Access** role are excluded from provisioning.


<a name='configure-automatic-user-provisioning-for-zendesk-in-azure-ad'></a>

### Configure automatic user provisioning for Zendesk in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Zendesk**.

	![Screenshot of the Zendesk link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input the admin username, secret token, and domain of your Zendesk account. Examples of these values are:

   * In the **Admin Username** box, fill in the username of the admin account on your Zendesk tenant. An example is admin@contoso.com.

   * In the **Secret Token** box, fill in the secret token as described in Step 6.

   * In the **Domain** box, fill in the subdomain of your Zendesk tenant. For example, for an account with a tenant URL of `https://my-tenant.zendesk.com`, your subdomain is **my-tenant**.

1. The secret token for your Zendesk account can be generated by following steps mentioned in **Step 2** above.

1. After you fill in the boxes shown in Step 5, select **Test Connection** to make sure that Microsoft Entra ID can connect to Zendesk. If the connection fails, make sure your Zendesk account has admin permissions and try again.

	![Screenshot of Zendesk Test Connection](./media/zendesk-provisioning-tutorial/ZenDesk19.png)

1. In the **Notification Email** box, enter the email address of the person or group to receive the provisioning error notifications. Select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Zendesk**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Zendesk in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the user accounts in Zendesk for update operations. To save any changes, select **Save**.

	![Screenshot of Zendesk matching user attributes](./media/zendesk-provisioning-tutorial/ZenDesk11.png)

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Zendesk**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Zendesk in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the groups in Zendesk for update operations. To save any changes, select **Save**.

	![Screenshot of Zendesk matching group attributes](./media/zendesk-provisioning-tutorial/ZenDesk13.png)

1. To configure scoping filters, follow the instructions in the [scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Zendesk, in the **Settings** section, change **Provisioning Status** to **On**.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users or groups that you want to provision to Zendesk. In the **Settings** section, select the values you want in **Scope**.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than later syncs. They occur approximately every 40 minutes as long as the Microsoft Entra provisioning service runs. 

You can use the **Synchronization Details** section to monitor progress and follow links to the provisioning activity report. The report describes all the actions performed by the Microsoft Entra provisioning service on Zendesk.

For information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Connector limitations

* Zendesk supports the use of groups for users with **Agent** roles only. For more information, see the [Zendesk documentation](https://support.zendesk.com/hc/en-us/articles/203661966-Creating-managing-and-using-groups).

* When a custom role is assigned to a user or group, the Microsoft Entra automatic user provisioning service also assigns the default role **Agent**. Only Agents can be assigned a custom role. For more information, see the [Zendesk API documentation](https://developer.zendesk.com/rest_api/docs/support/users#json-format-for-agent-or-admin-requests). 

* Import of all roles fails if any of the custom roles has a display name similar to the built-in roles of "agent" or "end-user". To avoid this, ensure that none of the custom roles being imported has the above display names. 

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

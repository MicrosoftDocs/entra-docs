---
title: Configure Twingate for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Twingate.
author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Twingate so that I can streamline the user management process and ensure that users have the appropriate access to Twingate.
---

# Configure Twingate for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Twingate and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Twingate](https://www.twingate.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).


## Capabilities Supported
> [!div class="checklist"]
> * Create users in Twingate
> * Remove users in Twingate when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Twingate
> * Provision groups and group memberships in Twingate
> * Single sign-on to Twingate (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md)
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Twingate tenant in a product tier that supports identity provider integration. See [Twingate pricing](https://www.twingate.com/pricing/) for details on different product tiers.
* A user account in Twingate with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Twingate](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-twingate-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Twingate to support provisioning with Microsoft Entra ID

1. Sign in to your [Twingate Admin Console](https://auth.twingate.com/).
2. Navigate to **Settings > Identity Provider**
3. Select the `...` button to open the action menu. Select **Regenerate SCIM Token**. Note that this would invalidate your existing token if any.

      ![Screenshot of Microsoft Entra action menu.](media/twingate-provisioning-tutorial/token.png)

4. Copy the **SCIM Endpoint** and **SCIM token** from the modal. These values are entered in the **Tenant URL** and **Secret Token** fields respectively in the Provisioning tab of your Twingate application.

      ![Screenshot of SCIM info modal.](media/twingate-provisioning-tutorial/tenant.png)


<a name='step-3-add-twingate-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Twingate from the Microsoft Entra application gallery

Add Twingate from the Microsoft Entra application gallery to start managing provisioning to Twingate. If you have previously setup Twingate for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who is in scope for provisioning

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Twingate

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Twingate based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-twingate-in-azure-ad'></a>

### To configure automatic user provisioning for Twingate in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Twingate**.

	![Screenshot of The Twingate link in the Applications list.](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Twingate Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Twingate. If the connection fails, ensure your Twingate account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Twingate**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Twingate in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Twingate for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Twingate API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|---|
   |externalId|String|&check;|
   |userName|String|
   |active|Boolean|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Twingate**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Twingate in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Twingate for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported For Filtering|
      |---|---|---|
      |externalId|String|&check;|
      |displayName|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Twingate, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Twingate by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.


## Step 6: Change Assignment required setting
The default setting is **No** which allows users to log into Twingate without being assigned in the enterprise application.

1. Select **Properties**.

   ![Screenshot of Properties.](common/properties.png)

2. Set **Assignment required** to **Yes**

   ![Screenshot of Properties assignment.](media/twingate-provisioning-tutorial/properties-assignment-required.png)

3. Select **Save**

   ![Screenshot of Properties saved.](media/twingate-provisioning-tutorial/properties-save.png)

## Step 7: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

1. Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
2. Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it's to completion
3. If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

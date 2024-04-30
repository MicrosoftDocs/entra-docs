---
title: 'Tutorial: Configure getAbstract for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to getAbstract.

documentationcenter: ''
author: twimmers
writer: twimmers
manager: jeedes

ms.assetid: bd8898f9-7a01-4e85-9dd4-61ae4b01ab5b
ms.service: entra-id
ms.subservice: saas-apps

ms.tgt_pltfrm: na
ms.topic: tutorial
ms.date: 12/04/2023
ms.author: thwimmer

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to getAbstract so that I can streamline the user management process and ensure that users have the appropriate access to getAbstract.
---

# Tutorial: Configure getAbstract for automatic user provisioning

This tutorial describes the steps you need to perform in both getAbstract and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and deprovisions users and groups to [getAbstract](https://www.getabstract.com) by using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to software as a service (SaaS) applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Capabilities supported

> [!div class="checklist"]
> * Create users in getAbstract.
> * Remove users in getAbstract when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and getAbstract.
> * Provision groups and group memberships in getAbstract.
> * Enable [single sign-on (SSO)](getabstract-tutorial.md) to getAbstract (recommended).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md).
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning. Examples are Application Administrator, Cloud Application Administrator, Application Owner, or Global Administrator.
* A getAbstract tenant (getAbstract corporate license).
* SSO enabled on Microsoft Entra tenant and getAbstract tenant.
* Approval and System for Cross-domain Identity Management (SCIM) enabling for getAbstract. (Send email to b2b.itsupport@getabstract.com.)

## Step 1: Plan your provisioning deployment

1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and getAbstract](~/identity/app-provisioning/customize-application-attributes.md).

<a name='step-2-configure-getabstract-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure getAbstract to support provisioning with Microsoft Entra ID

1. Sign in to getAbstract.
1. Select the person icon located in the upper-right corner, and select the **My Central Admin** option.

	![Screenshot that shows the getAbstract My Central Admin.](media/getabstract-provisioning-tutorial/my-account.png)

1. At the left side menu, click on **User Management** and click on the **configure scim** button.

	![Screenshot that shows the getAbstract SCIM Admin.](media/getabstract-provisioning-tutorial/scim-admin.png)

1. Select **Go**.

	![Screenshot that shows the getAbstract SCIM Client Id.](media/getabstract-provisioning-tutorial/scim-client-go.png)

1. Click on the **Generate new token** button.

	![Screenshot that shows the getAbstract SCIM Token 1.](media/getabstract-provisioning-tutorial/scim-generate-token-step-2.png)

1. If you're sure, then select **Generate new token** button. Otherwise, select **Cancel**.

	![Screenshot that shows the getAbstract SCIM Token 2.](media/getabstract-provisioning-tutorial/scim-generate-token-step-1.png)

1. Lastly, you can either click on the copy-to-clipboard icon or select the whole token and copy it. Also make a note that the Tenant/Base URL is `https://www.getabstract.com/api/scim/v2`. These values will be entered in the **Secret Token** and **Tenant URL** boxes on the **Provisioning** tab of your getAbstract application.

	![Screenshot that shows the getAbstract SCIM Token 3.](media/getabstract-provisioning-tutorial/scim-generate-token-step-3.png)

<a name='step-3-add-getabstract-from-the-azure-ad-application-gallery'></a>

## Step 3: Add getAbstract from the Microsoft Entra application gallery

Add getAbstract from the Microsoft Entra application gallery to start managing provisioning to getAbstract. If you've previously set up getAbstract for SSO, you can use the same application. We recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery, see [this quickstart](~/identity/enterprise-apps/add-application-portal.md).

## Step 4: Define who will be in scope for provisioning

You can use the Microsoft Entra provisioning service to scope who will be provisioned based on assignment to the application or based on attributes of the user or group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described in [Provision apps with scoping filters](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* When you assign users and groups to getAbstract, you must select a role other than **Default Access**. Users with the default access role are excluded from provisioning and will be marked as not effectively entitled in the provisioning logs. If the only role available on the application is the default access role, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add more roles.

* Start small. Test with a small set of users and groups before you roll out to everyone. When scope for provisioning is set to assigned users and groups, you can control this option by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute-based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

## Step 5: Configure automatic user provisioning to getAbstract

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users or groups in TestApp based on user or group assignments in Microsoft Entra ID.

<a name='configure-automatic-user-provisioning-for-getabstract-in-azure-ad'></a>

### Configure automatic user provisioning for getAbstract in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.

	![Screenshot that shows the Enterprise applications pane.](common/enterprise-applications.png)

1. In the list of applications, select **getAbstract**.

	![Screenshot that shows the getAbstract link in the list of applications.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot that shows the Provisioning tab.](common/provisioning.png)

1. Set **Provisioning Mode** to **Automatic**.

	![Screenshot that shows Provisioning Mode set to Automatic.](common/provisioning-automatic.png)

1. In the **Admin Credentials** section, enter your getAbstract **Tenant URL** and **Secret token** information. Select **Test Connection** to ensure that Microsoft Entra ID can connect to getAbstract. If the connection fails, ensure that your getAbstract account has admin permissions and try again.

 	![Screenshot that shows the Tenant URL and Secret Token boxes.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** box, enter the email address of a person or group who should receive the provisioning error notifications. Select the **Send an email notification when a failure occurs** check box.

	![Screenshot that shows the Notification Email box.](common/provisioning-notification-email.png)

1. Select **Save**.

1. In the **Mappings** section, select **Synchronize Microsoft Entra users to getAbstract**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to getAbstract in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in getAbstract for update operations. If you change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you'll need to ensure that the getAbstract API supports filtering users based on that attribute. Select **Save** to commit any changes.

   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|
   |externalId|String|
   |preferredLanguage|String|

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to getAbstract**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to getAbstract in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in getAbstract for update operations. Select **Save** to commit any changes.

    |Attribute|Type|Supported for filtering|
    |---|---|---|
    |displayName|String|&check;|
    |externalId|String|
    |members|Reference|

1. To configure scoping filters, see the instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for getAbstract, change **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot that shows the Provisioning Status toggled On.](common/provisioning-toggle-on.png)

1. Define the users or groups that you want to provision to getAbstract by selecting the desired values in **Scope** in the **Settings** section.

	![Screenshot that shows the Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot that shows the Save button.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running.

## Step 6: Monitor your deployment

Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users were provisioned successfully or unsuccessfully.
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion.
* If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. To learn more about quarantine states, see [Application provisioning status of quarantine](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Additional resources

* [Managing user account provisioning for enterprise apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)
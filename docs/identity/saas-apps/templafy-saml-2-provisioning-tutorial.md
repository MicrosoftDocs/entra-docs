---
title: 'Tutorial: Configure Templafy SAML2 for automatic user provisioning with Microsoft Entra ID'
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Templafy SAML2.
author: thomasakelo
manager: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Templafy SAML2 so that I can streamline the user management process and ensure that users have the appropriate access to Templafy SAML2.
---

# Tutorial: Configure Templafy SAML2 for automatic user provisioning

The objective of this tutorial is to demonstrate the steps to be performed in Templafy SAML2 and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Templafy SAML2.

> [!NOTE]
> This tutorial describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* A Microsoft Entra tenant.
* [A Templafy tenant](https://www.templafy.com/pricing/).
* A user account in Templafy with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Templafy SAML2](~/identity/app-provisioning/customize-application-attributes.md). 

## Assigning users to Templafy SAML2

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Templafy SAML2. Once decided, you can assign these users and/or groups to Templafy SAML2 by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to Templafy SAML2

* It is recommended that a single Microsoft Entra user is assigned to Templafy SAML2 to test the automatic user provisioning configuration. More users and/or groups may be assigned later.

* When assigning a user to Templafy SAML2, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

<a name='step-2-configure-templafy-saml2-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Templafy SAML2 to support provisioning with Microsoft Entra ID

Before configuring Templafy SAML2 for automatic user provisioning with Microsoft Entra ID, you will need to enable SCIM provisioning on Templafy SAML2.

1. Sign in to your Templafy Admin Console. Click on **Administration**.

	![Templafy Admin Console](media/templafy-saml-2-provisioning-tutorial/templafy-admin.png)

2. Click on **Authentication Method**.

	![Screenshot of the Templafy administration section with the Authentication method option called out.](media/templafy-saml-2-provisioning-tutorial/templafy-auth.png)

3. Copy the **SCIM Api-key** value. This value will be entered in the **Secret Token** field in the Provisioning tab of your Templafy SAML2 application.

	![A screenshot of the S C I M A P I key.](media/templafy-saml-2-provisioning-tutorial/templafy-token.png)

## Step 3: Add Templafy SAML2 from the gallery

To configure Templafy SAML2 for automatic user provisioning with Microsoft Entra ID, you need to add Templafy SAML2 from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Templafy SAML2 from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Templafy SAML2**, select **Templafy SAML2** in the search box.
1. Select **Templafy SAML2** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Templafy SAML2 in the results list](common/search-new-app.png)

## Step 4: Configure automatic user provisioning to Templafy SAML2 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Templafy SAML2 based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Templafy, following the instructions provided in the [Templafy Single sign-on tutorial](templafy-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-templafy-saml2-in-azure-ad'></a>

### To configure automatic user provisioning for Templafy SAML2 in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Templafy SAML2**.

	![The Templafy SAML2 link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input `https://scim.templafy.com/scim` in **Tenant URL**. Input the **SCIM API-key** value retrieved earlier in **Secret Token**. Click **Test Connection** to ensure Microsoft Entra ID can connect to Templafy. If the connection fails, ensure your Templafy account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

7. Click **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Templafy SAML2**.

	![Templafy SAML2 User Mappings](media/templafy-saml-2-provisioning-tutorial/user-mapping.png)

9. Review the user attributes that are synchronized from Microsoft Entra ID to Templafy SAML2 in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the user accounts in Templafy SAML2 for update operations. Select the **Save** button to commit any changes.


   |Attribute|Type|Supported for filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean|
   |displayName|String|
   |title|String|
   |preferredLanguage|String|
   |name.givenName|String|
   |name.familyName|String|
   |phoneNumbers[type eq "work"].value|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |phoneNumbers[type eq "fax"].value|String|
   |externalId|String|
   |addresses[type eq "work"].locality|String|
   |addresses[type eq "work"].postalCode|String|
   |addresses[type eq "work"].region|String|
   |addresses[type eq "work"].streetAddress|String|
   |addresses[type eq "work"].country|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String|

      > [!NOTE]
      > Schema Discovery feature is enabled for this application.

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Templafy**.

	![Templafy SAML2 Group Mappings](media/templafy-saml-2-provisioning-tutorial/group-mapping.png)

11. Review the group attributes that are synchronized from Microsoft Entra ID to Templafy SAML2 in the **Attribute Mappings** section. The attributes selected as **Matching** properties are used to match the groups in Templafy SAML2 for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for filtering|
      |---|---|---|
      |displayName|String|&check;|
      |members|Reference|
      |externalId|String|      

      > [!NOTE]
      > Schema Discovery feature is enabled for this application.

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Templafy SAML2, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Templafy SAML2 by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

	This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on Templafy SAML2.

## Step 5: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
* If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).

## Change log

* 05/04/2023 - Added support for **Schema Discovery**.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

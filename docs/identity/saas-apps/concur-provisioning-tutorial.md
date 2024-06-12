---
title: 'Tutorial: Configure Concur for automatic user provisioning with Microsoft Entra ID| Microsoft Docs'
description: Learn how to configure single sign-on between Microsoft Entra ID and Concur.

author: jeevansd
manager: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Concur so that I can streamline the user management process and ensure that users have the appropriate access to Concur.
---
# Tutorial: Configure Concur for automatic user provisioning

The objective of this tutorial is to show you the steps you need to perform in Concur and Microsoft Entra ID to automatically provision and de-provision user accounts from Microsoft Entra ID directly to Concur.

> [!WARNING]
> This provisioning integration is no longer supported and the direct provisioning functionality of the SAP Concur application in the Microsoft Entra Enterprise App Gallery is being removed. The application's SSO functionality will remain intact. Customers should instead provision to SAP Concur via SAP Cloud Identity Services. For more information, see how to configure provisioning of users [from Microsoft Entra ID to SAP Cloud Identity Services](sap-cloud-platform-identity-authentication-provisioning-tutorial.md), and how to configure provisioning of users [from SAP Cloud Identity Services to SAP Concur](https://help.sap.com/docs/cloud-identity-services/cloud-identity-services/target-sap-concur).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following items:

*   A Microsoft Entra tenant.
*   A Concur single sign-on enabled subscription.
*   A user account in Concur with Team Admin permissions.

## Assigning users to Concur

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user account provisioning, only the users and groups that are "assigned" to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling the provisioning service, you need to decide what users and/or groups in Microsoft Entra ID represent the users who need access to your Concur app. Once decided, you can assign these users to your Concur app by following the instructions here:

[Assign a user or group to an enterprise app.](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Concur

*   It is recommended that a single Microsoft Entra user be assigned to Concur to test the provisioning configuration. Additional users and/or groups may be assigned later.

*   When assigning a user to Concur, you must select a valid user role. The "Default Access" role does not work for provisioning.

## Enable user provisioning

This section guides you through connecting your Microsoft Entra ID to Concur's user account provisioning API, and configuring the provisioning service to create, update, and disable assigned user accounts in Concur based on user and group assignment in Microsoft Entra ID.

> [!Tip] 
> You may also choose to enabled SAML-based Single Sign-On for Concur, following the instructions provided in the [Azure portal](https://portal.azure.com). Single sign-on can be configured independently of automatic provisioning, though these two features complement each other.

### To configure user account provisioning:

The objective of this section is to outline how to enable provisioning of Active Directory user accounts to Concur.

To enable apps in the Expense Service, there has to be proper setup and use of a Web Service Admin profile. Don't add the WS Admin role to your existing administrator profile that you use for T&E administrative functions.

Concur Consultants or the client administrator must create a distinct Web Service Administrator profile and the Client administrator must use this profile for the Web Services Administrator functions (for example, enabling apps). These profiles must be kept separate from the client administrator's daily T&E admin profile (the T&E admin profile should not have the WSAdmin role assigned).

When you create the profile to be used for enabling the app, enter the client administrator's name into the user profile fields. This assigns ownership to the profile. Once one or more profiles is created, the client must log in with this profile to click the "*Enable*" button for a Partner App within the Web Services menu.

For the following reasons, this action should not be done with the profile they use for normal T&E administration.

* The client has to be the one that clicks "*Yes*" on the dialogue window that is displayed after an app is enabled. This click acknowledges the client is willing for the Partner application to access their data, so you or the Partner cannot click that Yes button.

* If a client administrator that has enabled an app using the T&E admin profile leaves the company (resulting in the profile being inactivated), any apps enabled using that profile do not function until the app is enabled with another active WS Admin profile. This reason is why you should create distinct WS Admin profiles.

* If an administrator leaves the company, the name associated to the WS Admin profile can be changed to the replacement administrator if desired without impacting the enabled app because that profile does not need to be inactivated.

**To configure user provisioning, perform the following steps:**

1. Log on to your **Concur** tenant.

1. From the **Administration** menu, select **Web Services**.
   
    ![Concur tenant](./media/concur-provisioning-tutorial/IC721729.png "Concur tenant")

1. On the left side, from the **Web Services** pane, select **Enable Partner Application**.
   
    ![Enable Partner Application](./media/concur-provisioning-tutorial/ic721730.png "Enable Partner Application")

1. From the **Enable Application** list, select **Microsoft Entra ID**, and then click **Enable**.
   
    ![Microsoft Entra ID](./media/concur-provisioning-tutorial/ic721731.png "Microsoft Entra ID")

1. Click **Yes** to close the **Confirm Action** dialog.
   
    ![Confirm Action](./media/concur-provisioning-tutorial/ic721732.png "Confirm Action")

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity** > **Applications** > **Enterprise applications**.

1. If you have already configured Concur for single sign-on, search for your instance of Concur using the search field. Otherwise, select **Add** and search for **Concur** in the application gallery. Select Concur from the search results, and add it to your list of applications.

1. Select your instance of Concur, then select the **Provisioning** tab.

1. Set the **Provisioning Mode** to **Automatic**. 
 
    ![Screenshot of the Provisioning tab for Concur in Azure portal. Provisioning Mode is set to Automatic and the Test Connection button is highlighted.](./media/concur-provisioning-tutorial/provisioning.png)

1. Under the **Admin Credentials** section, enter the **user name** and the **password** of your Concur administrator.

1. Select **Test Connection** to ensure Microsoft Entra ID can connect to your Concur app. If the connection fails, ensure your Concur account has Team Admin permissions.

1. Enter the email address of a person or group who should receive provisioning error notifications in the **Notification Email** field, and check the checkbox.

1. Click **Save.**

1. Under the Mappings section, select **Synchronize Microsoft Entra users to Concur.**

1. In the **Attribute Mappings** section, review the user attributes that are synchronized from Microsoft Entra ID to Concur. The attributes selected as **Matching** properties are used to match the user accounts in Concur for update operations. Select the Save button to commit any changes.

1. To enable the Microsoft Entra provisioning service for Concur, change the **Provisioning Status** to **On** in the **Settings** section

1. Click **Save.**

You can now create a test account. Wait for up to 20 minutes to verify that the account has been synchronized to Concur.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](tutorial-list.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Configure Single Sign-on](concur-tutorial.md)

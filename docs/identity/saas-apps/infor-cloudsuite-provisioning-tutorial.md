---
title: 'Tutorial: Configure Infor CloudSuite for automatic user provisioning with Microsoft Entra ID'
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to Infor CloudSuite.

author: thomasakelo
manager: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Infor CloudSuite so that I can streamline the user management process and ensure that users have the appropriate access to Infor CloudSuite.
---

# Tutorial: Configure Infor CloudSuite for automatic user provisioning

The objective of this tutorial is to demonstrate the steps to be performed in Infor CloudSuite and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to Infor CloudSuite.

> [!NOTE]
> This tutorial describes a connector built on top of the Microsoft Entra user Provisioning Service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* A Microsoft Entra tenant
* [An Infor CloudSuite tenant](https://www.infor.com/products)
* A user account in Infor CloudSuite with Admin permissions.

## Assigning users to Infor CloudSuite

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to Infor CloudSuite. Once decided, you can assign these users and/or groups to Infor CloudSuite by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to Infor CloudSuite

* It is recommended that a single Microsoft Entra user is assigned to Infor CloudSuite to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to Infor CloudSuite, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up Infor CloudSuite for provisioning

1. Sign in to your [Infor CloudSuite Admin Console](https://www.infor.com/customer-center). Click on the user icon and then navigate to **user management**.

	![Infor CloudSuite Admin Console](media/infor-cloudsuite-provisioning-tutorial/admin.png)

2.	Click on the menu icon on the left top corner of the screen. Click on **Manage**.

	![Infor CloudSuite Add SCIM](media/infor-cloudsuite-provisioning-tutorial/manage.png)

3.	Navigate to **SCIM Accounts**.

	![Infor CloudSuite SCIM Account](media/infor-cloudsuite-provisioning-tutorial/scim.png)

4.	Add an admin user by clicking on the plus icon. Provide a **SCIM Password** and type the same password under **Confirm Password**. Click on the folder icon to save the password. You will then see an **User Identifier** generated for the admin user.

	![Infor CloudSuite Admin user](media/infor-cloudsuite-provisioning-tutorial/newuser.png)
	
	![Infor CloudSuite password](media/infor-cloudsuite-provisioning-tutorial/password.png)

	:::image type="content" source="media/infor-cloudsuite-provisioning-tutorial/identifier.png" alt-text="Screenshot of the Infor CloudSuite admin console showing a highlighted table row. That row contains a user identifier, passwords, and a time stamp." border="false":::

5. To generate the bearer token, copy the **User Identifier** and **SCIM Password**. Paste them in notepad++ separated by a colon. Encode the string value by navigating to **Plugins > MIME Tools > Basic64 Encode**. 

	:::image type="content" source="media/infor-cloudsuite-provisioning-tutorial/token.png" alt-text="Screenshot of a Notepad++ document. In the Plugins menu, MIME tools is highlighted. In the MIME tools menu, Base64 encode is highlighted." border="false":::
	
	To generate the bearer token using PowerShell instead of Notepad++, use the following commands:
	 ```powershell
    $Identifier = "<User Identifier>"
	$SCIMPassword = "<SCIM Password>"
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($($Identifier):$($SCIMPassword))
	[Convert]::ToBase64String($bytes)
   	 ```

3.	Copy the bearer token. This value will be entered in the Secret Token field in the Provisioning tab of your Infor CloudSuite application.

## Add Infor CloudSuite from the gallery

Before configuring Infor CloudSuite for automatic user provisioning with Microsoft Entra ID, you need to add Infor CloudSuite from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Infor CloudSuite from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Infor CloudSuite**, select **Infor CloudSuite** in the search box.
1. Select **Infor CloudSuite** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![Infor CloudSuite in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to Infor CloudSuite 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in Infor CloudSuite based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for Infor CloudSuite, following the instructions provided in the [Infor CloudSuite Single sign-on tutorial](./infor-cloud-suite-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-infor-cloudsuite-in-azure-ad'></a>

### To configure automatic user provisioning for Infor CloudSuite in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Infor CloudSuite**.

	![The Infor CloudSuite link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input `https://mingle-t20b-scim.mingle.awsdev.infor.com/INFORSTS_TST/v2/scim` in **Tenant URL**. Input the bearer token value retrieved earlier in **Secret Token**. Click **Test Connection** to ensure Microsoft Entra ID can connect to Infor CloudSuite. If the connection fails, ensure your Infor CloudSuite account has Admin permissions and try again.

	![Tenant URL + Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

	![Notification Email](common/provisioning-notification-email.png)

7. Click **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Infor CloudSuite**.

	![Infor CloudSuite User Mappings](media/infor-cloudsuite-provisioning-tutorial/usermappings.png)

9. Review the user attributes that are synchronized from Microsoft Entra ID to Infor CloudSuite in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Infor CloudSuite for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Infor CloudSuite|
	|---|---|---|---|
	|userName|String|&check;|&check;
	|active|Boolean||
	|displayName|String||
	|externalId|String||
	|name.familyName|String||
	|name.givenName|String||
	|displayName|String||
	|title|String||
	|emails[type eq "work"].value|String||
	|urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String||
	|urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
	|urn:ietf:params:scim:schemas:extension:infor:2.0:User:actorId|String||
	|urn:ietf:params:scim:schemas:extension:infor:2.0:User:federationId|String||
	|urn:ietf:params:scim:schemas:extension:infor:2.0:User:ifsPersonId|String||
	|urn:ietf:params:scim:schemas:extension:infor:2.0:User:lnUser|String||
	|urn:ietf:params:scim:schemas:extension:infor:2.0:User:userAlias|String||


10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Infor CloudSuite**.

	![Infor CloudSuite Group Mappings](media/infor-cloudsuite-provisioning-tutorial/groupmappings.png)

11. Review the group attributes that are synchronized from Microsoft Entra ID to Infor CloudSuite in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Infor CloudSuite for update operations. Select the **Save** button to commit any changes.

	|Attribute|Type|Supported for filtering|Required by Infor CloudSuite|
	|---|---|---|---|
	|displayName|String|&check;|&check;
	|members|Reference||
	|externalId|String||

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Infor CloudSuite, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Infor CloudSuite by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it's to completion
* If the provisioning configuration seems to be in an unhealthy state, the application goes into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).


## Change log
02/15/2023 - Added support for custom extension user attributes **urn:ietf:params:scim:schemas:extension:infor:2.0:User:actorId**, **urn:ietf:params:scim:schemas:extension:infor:2.0:User:federationId**, **urn:ietf:params:scim:schemas:extension:infor:2.0:User:ifsPersonId**, **urn:ietf:params:scim:schemas:extension:infor:2.0:User:inUser**,  and **urn:ietf:params:scim:schemas:extension:infor:2.0:User:userAlias**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

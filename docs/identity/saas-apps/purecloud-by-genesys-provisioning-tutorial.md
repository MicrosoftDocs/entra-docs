---
title: Configure Genesys Cloud for Azure for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Genesys Cloud for Azure.

author: adimitui
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Genesys Cloud for Azure so that I can streamline the user management process and ensure that users have the appropriate access to Genesys Cloud for Azure.
---

# Configure Genesys Cloud for Azure for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Genesys Cloud for Azure and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [Genesys Cloud for Azure](https://www.genesys.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Genesys Cloud for Azure
> * Remove users in Genesys Cloud for Azure when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Genesys Cloud for Azure
> * Provision groups and group memberships in Genesys Cloud for Azure
> * [Single sign-on](./purecloud-by-genesys-tutorial.md) to Genesys Cloud for Azure (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A PureCloud [organization](https://help.mypurecloud.com/?p=81984).
* A User with [permissions](https://help.mypurecloud.com/?p=24360) to create an Oauth Client.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Genesys Cloud for Azure](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-genesys-cloud-for-azure-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Genesys Cloud for Azure to support provisioning with Microsoft Entra ID

1. Create an [Oauth Client](https://help.mypurecloud.com/?p=188023) configured in your PureCloud organization.
2. Generate a token [with your oauth client](https://developer.mypurecloud.com/api/rest/authorization/use-client-credentials.html).
3. If you're wanting to automatically provision Group membership within PureCloud, you must [create Groups](https://help.mypurecloud.com/?p=52397) in PureCloud with an identical name to the group in Microsoft Entra ID.

<a name='step-3-add-genesys-cloud-for-azure-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Genesys Cloud for Azure from the Microsoft Entra application gallery

Add Genesys Cloud for Azure from the Microsoft Entra application gallery to start managing provisioning to Genesys Cloud for Azure. If you have previously setup Genesys Cloud for Azure for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Genesys Cloud for Azure 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-genesys-cloud-for-azure-in-azure-ad'></a>

### To configure automatic user provisioning for Genesys Cloud for Azure in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Genesys Cloud for Azure**.

	![The Genesys Cloud for Azure link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of the Provisioning Mode dropdown list with the Automatic option called out.](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Genesys Cloud for Azure API URL and Oauth Token in the **Tenant URL** and **Secret Token** fields respectively. The API URL is structured as `{{API Url}}/api/v2/scim/v2`, using the API URL for your PureCloud region from the [PureCloud Developer Center](https://developer.mypurecloud.com/api/rest/index.html). Select **Test Connection** to ensure Microsoft Entra ID can connect to Genesys Cloud for Azure. If the connection fails, ensure your Genesys Cloud for Azure account has Admin permissions and try again.

 	![Screenshot shows the Admin Credentials dialog box, where you can enter your Tenant U R L and Secret Token.](./media/purecloud-by-genesys-provisioning-tutorial/provisioning.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Genesys Cloud for Azure**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Genesys Cloud for Azure in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Genesys Cloud for Azure for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Genesys Cloud for Azure API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

     |Attribute|Type|Supported for filtering|Required by Genesys Cloud for Azure|
     |---|---|---|---|
     |userName|String|&check;|&check;|
	 |active|Boolean||&check;|
	 |displayName|String||&check;|
	 |emails[type eq "work"].value|String|
	 |title|String|
	 |phoneNumbers[type eq "mobile"].value|String|
	 |phoneNumbers[type eq "work"].value|String|
	 |phoneNumbers[type eq "work2"].value|String|
	 |phoneNumbers[type eq "work3"].value|String|
	 |phoneNumbers[type eq "work4"].value|String|
	 |phoneNumbers[type eq "home"].value|String|
	 |phoneNumbers[type eq "microsoftteams"].value|String|
	 |roles|String|
	 |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
     |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference|
	 |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|
	 |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|
	 |urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘microsoftteams’].value|String|	 
	 |urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘ringcentral’].value|String|	 
	 |urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘zoomphone].value|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Genesys Cloud for Azure**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to Genesys Cloud for Azure in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Genesys Cloud for Azure for update operations. Select the **Save** button to commit any changes. Genesys Cloud for Azure doesn't support group creation or deletion and only supports updating of groups.

      |Attribute|Type|Supported for filtering|Required by Genesys Cloud for Azure|
      |---|---|---|---|
      |displayName|String|&check;|&check;|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for Genesys Cloud for Azure, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to Genesys Cloud for Azure by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Change log

* 09/10/2020 - Added support for extension enterprise attribute **employeeNumber**.
* 05/18/2021 - Added support for core attributes **phoneNumbers[type eq "work2"]**, **phoneNumbers[type eq "work3"]**, **phoneNumbers[type eq "work4"]**, **phoneNumbers[type eq "home"]**, **phoneNumbers[type eq "microsoftteams"]** and roles. And also added support for custom extension attributes **urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘microsoftteams’]**, **urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘zoomphone]** and **urn:ietf:params:scim:schemas:extension:genesys:purecloud:2.0:User:externalIds[authority eq ‘ringcentral’]**.

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

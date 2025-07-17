---
title: Configure Freshservice Provisioning for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to Freshservice Provisioning.


author: adimitui
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Freshservice Provisioning so that I can streamline the user management process and ensure that users have the appropriate access to Freshservice Provisioning.
---

# Configure Freshservice Provisioning for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both Freshservice Provisioning and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [Freshservice Provisioning](https://effy.co.in/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in Freshservice Provisioning
> * Remove users in Freshservice Provisioning when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and Freshservice Provisioning

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A [Freshservice account](https://www.freshservice.com) with the Organizational Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and Freshservice Provisioning](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-freshservice-provisioning-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure Freshservice Provisioning to support provisioning with Microsoft Entra ID

1. On your Freshservice account, install the **Azure Provisioning (SCIM)** app from the marketplace by navigating to **Freshservice Admin** > **Apps** > **Get Apps**.
2. In the configuration screen, provide your **Freshservice Domain** (for example, `acme.freshservice.com`) and the **Organization Admin API key**.
3. Select **Continue**.
4. Highlight and copy the **Bearer Token**. This value is entered in the **Secret Token** field in the Provisioning tab of your Freshservice Provisioning application.
5. Select **Install** to complete the installation.
6. The **Tenant URL** is `https://scim.freshservice.com/scim/v2`. This value is entered in the **Tenant URL** field in the Provisioning tab of your Freshservice Provisioning application.

<a name='step-3-add-freshservice-provisioning-from-the-azure-ad-application-gallery'></a>

## Step 3: Add Freshservice Provisioning from the Microsoft Entra application gallery

Add Freshservice Provisioning from the Microsoft Entra application gallery to start managing provisioning to Freshservice Provisioning. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to Freshservice Provisioning 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Freshservice Provisioning based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-freshservice-provisioning-in-azure-ad'></a>

### To configure automatic user provisioning for Freshservice Provisioning in Microsoft Entra ID

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Freshservice Provisioning**.

	![The Freshservice Provisioning link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your Freshservice Provisioning Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to Freshservice Provisioning. If the connection fails, ensure your Freshservice Provisioning account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Freshservice Provisioning**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to Freshservice Provisioning in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Freshservice Provisioning for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Freshservice Provisioning API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported For Filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |emails[type eq "work"].value|String||
   |displayName|String||
   |name.givenName|String||
   |name.familyName|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |addresses[type eq "work"].formatted|String||
   |locale|String||
   |title|String||
   |timezone|String||
   |externalId|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference||
   |urn:ietf:params:scim:schemas:extension:freshservice:2.0:User:isAgent|String||

> [!NOTE]
> Custom extension attributes can be added to your schema to meet your application's needs by following the below steps:
> * Under Mappings, select **Provision Microsoft Entra users**.
> * At the bottom of the page, select **Show advanced options**.
> * Select **Edit attribute list for Freshservice**.
> * At the bottom of the attribute list, enter information about the custom attribute in the fields provided. The custom attribute urn namespace must follow the pattern as shown in the below example. The **CustomAttribute** can be customized per your application's requirements, for example: urn:ietf:params:scim:schemas:extension:freshservice:2.0:User:**isAgent**.
> * The appropriate data type has to be selected for the custom attribute and select **Save**.
> * Navigate back to the default mappings screen and select **Add  New Mapping**. The custom attributes will show up in the **Target Attribute** list dropdown.

10. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

11. To enable the Microsoft Entra provisioning service for Freshservice Provisioning, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

12. Define the users that you would like to provision to Freshservice Provisioning by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

13. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

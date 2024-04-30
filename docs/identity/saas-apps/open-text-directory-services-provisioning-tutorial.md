---
title: 'Tutorial: Configure OpenText Directory Services for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to OpenText Directory Services.

documentationcenter: ''
author: twimmers
writer: twimmers
manager: jeedes

ms.assetid: ad55ba5f-c56c-4ed0-bdfd-163d2883ed80
ms.service: entra-id
ms.subservice: saas-apps

ms.tgt_pltfrm: na
ms.topic: tutorial
ms.date: 11/21/2022
ms.author: thwimmer

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to OpenText Directory Services so that I can streamline the user management process and ensure that users have the appropriate access to OpenText Directory Services.
---

# Tutorial: Configure OpenText Directory Services for automatic user provisioning

This tutorial describes the steps you need to perform in both OpenText Directory Services and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to OpenText Directory Services using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in OpenText Directory Services
> * Remove users in OpenText Directory Services when they do not require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and OpenText Directory Services
> * Provision groups and group memberships in OpenText Directory Services
> * [Single sign-on](./directory-services-tutorial.md) to OpenText Directory Services (recommended)

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md) 
* A user account in Microsoft Entra ID with [permission](~/identity/role-based-access-control/permissions-reference.md) to configure provisioning (for example, Application Administrator, Cloud Application administrator, Application Owner, or Global Administrator). 
* An OTDS installation accessible by Microsoft Entra ID.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and OpenText Directory Services](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-opentext-directory-services-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure OpenText Directory Services to support provisioning with Microsoft Entra ID

> [!NOTE]
> The below steps  apply to an OpenText Directory Services installation. They do not apply for OpenText CoreShare or OpenText OT2 tenants.

1. Create a dedicated confidential **OAuth client**.
2. Set a long **Access token lifetime**.

      ![Access Token Life](media/open-text-directory-services-provisioning-tutorial/token-life.png)

3. Do not specify any redirect URLs. They are not required. 
4. OTDS will generate and display the **client secret**. Save the **client id** and **client secret** in a secure location.

      ![Client Secret](media/open-text-directory-services-provisioning-tutorial/client-secret.png)

5. Create a partition for the users and groups to be synchronized from Microsoft Entra ID.

      ![Partition page](media/open-text-directory-services-provisioning-tutorial/partition.png)

6. Grant administrative rights to the OAuth client you created on the partition you will use for the Microsoft Entra users and groups being synchronized.    
      * Partition -> Actions -> Edit Administrators

      ![Administrator page](media/open-text-directory-services-provisioning-tutorial/administrator.png)

5. A secret token must be retrieved and configured in Microsoft Entra ID. Any HTTP client application can be used for this. Below are steps to retrieve using the Swagger API application included in OTDS.
      * In a web browser, go to {OTDS URL}/otdsws/oauth2
      * Go to /token and click the lock icon at the top right. Enter the OAuth client ID and secret retrieved earlier as the username and password respectively. Click Authorize.

      ![Authorization button](media/open-text-directory-services-provisioning-tutorial/authorization.png)

6. Select **client_credentials** for the grant_type and click **Execute**.

      ![Execute button](media/open-text-directory-services-provisioning-tutorial/execute.png)

7. The access token in the response should be used in the **Secret Token** field in Microsoft Entra ID.

      ![Access Token](media/open-text-directory-services-provisioning-tutorial/access-token.png)

<a name='step-3-add-opentext-directory-services-from-the-azure-ad-application-gallery'></a>

## Step 3: Add OpenText Directory Services from the Microsoft Entra application gallery

Add OpenText Directory Services from the Microsoft Entra application gallery to start managing provisioning to OpenText Directory Services. If you have previously setup OpenText Directory Services for SSO, you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to OpenText Directory Services 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-opentext-directory-services-in-azure-ad'></a>

### To configure automatic user provisioning for OpenText Directory Services in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **OpenText Directory Services**.

	![The OpenText Directory Services link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your OpenText Directory Services Tenant URL
   * Non-specific tenant URL : {OTDS URL}/scim/{partitionName}
   * Specific tenant URL :  {OTDS URL}/otdstenant/{tenantID}/scim/{partitionName}

6. Enter the Secret Token retrieved from Step 2. Click **Test Connection** to ensure Microsoft Entra ID can connect to OpenText Directory Services. If the connection fails, ensure your OpenText Directory Services account has Admin permissions and try again.

      ![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to OpenText Directory Services**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to OpenText Directory Services in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in OpenText Directory Services for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the OpenText Directory Services API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |displayName|String|
   |title|String|
   |emails[type eq "work"].value|String|
   |preferredLanguage|String|
   |name.givenName|String|
   |name.familyName|String|
   |name.formatted|String|
   |addresses[type eq "work"].formatted|String|
   |addresses[type eq "work"].streetAddress|String|
   |addresses[type eq "work"].locality|String|
   |addresses[type eq "work"].region|String|
   |addresses[type eq "work"].postalCode|String|
   |addresses[type eq "work"].country|String|
   |phoneNumbers[type eq "work"].value|String|
   |phoneNumbers[type eq "mobile"].value|String|
   |phoneNumbers[type eq "fax"].value|String|
   |externalId|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference| 

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to OpenText Directory Services**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to OpenText Directory Services in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in OpenText Directory Services for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for OpenText Directory Services, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to OpenText Directory Services by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

1. Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
2. Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
3. If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).  

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

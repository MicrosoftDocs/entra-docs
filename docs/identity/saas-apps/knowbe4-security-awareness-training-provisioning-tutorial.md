---
title: 'Tutorial: Configure KnowBe4 Security Awareness Training for automatic user provisioning with Microsoft Entra ID'
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to KnowBe4 Security Awareness Training.


author: thomasakelo
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: tutorial
ms.date: 03/25/2024
ms.author: thomasakelo

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to KnowBe4 Security Awareness Training so that I can streamline the user management process and ensure that users have the appropriate access to KnowBe4 Security Awareness Training.
---

# Tutorial: Configure KnowBe4 Security Awareness Training for automatic user provisioning

This tutorial describes the steps you need to perform in both KnowBe4 Security Awareness Training and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [KnowBe4 Security Awareness Training](https://www.knowbe4.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in KnowBe4 Security Awareness Training.
> * Remove users in KnowBe4 Security Awareness Training when they do not require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and KnowBe4 Security Awareness Training.
> * Provision groups and group memberships in KnowBe4 Security Awareness Training.
> * [Single sign-on](knowbe4-tutorial.md) to KnowBe4 Security Awareness Training (recommended).

## Prerequisites

The scenario outlined in this tutorial assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in KnowBe4 Security Awareness Training with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who will be in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and KnowBe4 Security Awareness Training](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-knowbe4-security-awareness-training-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure KnowBe4 Security Awareness Training to support provisioning with Microsoft Entra ID
Follow the steps below to configure your SCIM settings in the console.
>[!NOTE]
>If you are switching from ADI to SCIM, please note that if you are using alias email addresses, our integration with SCIM does not support that connection, so this information will be removed once you disable **Test Mode** and a sync runs.

1. From your KnowBe4 console, click your email address in the top right corner and select **Account Settings**.
1. Navigate to the **User Management > User Provisioning** section of your settings.
1. Select **Enable User Provisioning (User Syncing)** to display more provisioning settings.

	![User Provisioning (User Syncing)](media/knowbe4-security-awareness-training-provisioning-tutorial\user-sync.png) 

1. By default, the toggle will be set to **ADI**. Click the **SCIM** toggle to begin setting up.
1. Expand your SCIM settings by clicking **+ SCIM Settings**.

	![Tenant Url](media/knowbe4-security-awareness-training-provisioning-tutorial\tenant-url.png)

1. Click **Generate SCIM Token**. This will open a new window with your token ID. Copy this ID and save it to a place that you can easily access later. It is important that you save this token because once you close this window, you cannot view the token again. Once you’ve saved the information, click **OK** to close the window.

   >[!NOTE]
   >Once your SCIM token is generated, this button will change to the **Regenerate SCIM Token** button. See the **Troubleshooting Tips** section of this article for more information.

   >[!NOTE]
   >Your identity provider will need the token (step 5) and the tenant ID (step 6) in order to establish a connection with KnowBe4. Make sure that you save this information so it is readily available when you are ready to set up the connection with your identity provider.

1. Copy the Tenant URL and save it to a place that you can easily access later.
1. Make sure that the Test Mode option is selected.

	![Tenant Mode](media/knowbe4-security-awareness-training-provisioning-tutorial\test-mode.png)

   >[!NOTE]
   >We recommend keeping **Test Mode** enabled until you’ve configured the connection between KnowBe4 and your identity provider and have run a successful sync. Test Mode is used to generate a report of what will happen when SCIM is enabled. This means no changes are made to your console so you can configure your setup without worrying about changes to your console. When you are ready, you can disable **Test Mode** from your **Account Settings** to enable syncing.If you are switching from ADI to SCIM, **Test Mode** will be enabled automatically after you save your **Account Settings**.

1. Scroll down to the bottom of the **Account Settings** page and click **Save Changes**.
Now that you have enabled SCIM in your KnowBe4 account, you are ready to finalize the connection with your identity provider. See one of the articles below to find instructions on configuring SCIM for the identity provider that you are using.

<a name='step-3-add-knowbe4-security-awareness-training-from-the-azure-ad-application-gallery'></a>

## Step 3: Add KnowBe4 Security Awareness Training from the Microsoft Entra application gallery

Add KnowBe4 Security Awareness Training from the Microsoft Entra application gallery to start managing provisioning to KnowBe4 Security Awareness Training. If you have previously setup KnowBe4 Security Awareness Training for SSO you can use the same application. However it is recommended that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who will be in scope for provisioning 

The Microsoft Entra provisioning service allows you to scope who will be provisioned based on assignment to the application and or based on attributes of the user / group. If you choose to scope who will be provisioned to your app based on assignment, you can use the following [steps](~/identity/enterprise-apps/assign-user-or-group-access-portal.md) to assign users and groups to the application. If you choose to scope who will be provisioned based solely on attributes of the user or group, you can use a scoping filter as described [here](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md). 

* Start small. Test with a small set of users and groups before rolling out to everyone. When scope for provisioning is set to assigned users and groups, you can control this by assigning one or two users or groups to the app. When scope is set to all users and groups, you can specify an [attribute based scoping filter](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

* If you need additional roles, you can [update the application manifest](~/identity-platform/howto-add-app-roles-in-apps.md) to add new roles.


## Step 5: Configure automatic user provisioning to KnowBe4 Security Awareness Training 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in KnowBe4 Security Awareness Training based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-knowbe4-security-awareness-training-in-azure-ad'></a>

### To configure automatic user provisioning for KnowBe4 Security Awareness Training in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **KnowBe4 Security Awareness Training**.

	![The KnowBe4 Security Awareness Training link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your KnowBe4 Security Awareness Training Tenant URL and Secret Token. Click **Test Connection** to ensure Microsoft Entra ID can connect to KnowBe4 Security Awareness Training. If the connection fails, ensure your KnowBe4 Security Awareness Training account has Admin permissions and try again.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to KnowBe4 Security Awareness Training**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to KnowBe4 Security Awareness Training in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in KnowBe4 Security Awareness Training for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you will need to ensure that the KnowBe4 Security Awareness Training API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by KnowBe4 Security Awareness Training|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager.value|Reference||
   |active|Boolean||
   |title|String||
   |name.givenName|String||
   |name.familyName|String||
   |externalId|String||
   |displayName|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String||
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customDate1|DateTime||
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customDate2|DateTime|
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customField1|String||             
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customField2|String||
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customField3|String||
   |urn:ietf:params:scim:schemas:extension:knowbe4:kmsat:2.0:User:customField4|String||
|

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to KnowBe4 Security Awareness Training**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to KnowBe4 Security Awareness Training in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in KnowBe4 Security Awareness Training for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by KnowBe4 Security Awareness Training|
   |---|---|---|---|
   |displayName|String|&check;|&check;
   |members|Reference||   
   |externalId|String||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter tutorial](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for KnowBe4 Security Awareness Training, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to KnowBe4 Security Awareness Training by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

1. When you are ready to provision, click **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment
Once you've configured provisioning, use the following resources to monitor your deployment:

* Use the [provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) to determine which users have been provisioned successfully or unsuccessfully
* Check the [progress bar](~/identity/app-provisioning/application-provisioning-when-will-provisioning-finish-specific-user.md) to see the status of the provisioning cycle and how close it is to completion
* If the provisioning configuration seems to be in an unhealthy state, the application will go into quarantine. Learn more about quarantine states [here](~/identity/app-provisioning/application-provisioning-quarantine-status.md).  

## Step 7: Troubleshooting Tips
* Once SCIM has been enabled, you'll see three buttons in the SCIM section of your Account Settings that can be used for troubleshooting purposes. For more information on these options, see the list below.

	![Troubleshooting Tips](media/knowbe4-security-awareness-training-provisioning-tutorial\troubleshoot.png)

   * **Regenerate SCIM token**: Use this button to generate a new SCIM token. This token can only be viewed once, so make sure you save this information before closing the window. The link between your identity providers and your KnowBe4 console will be disabled until you provide the new SCIM token.

   * **Revoke SCIM token**: Use this button to disable your current SCIM token. Identity providers currently using this token will no longer be linked to your KnowBe4 console.

   * **Force Sync Now**: Use this button to manually force a SCIM sync at any time, without requiring a change from your identity provider.
## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Next steps

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

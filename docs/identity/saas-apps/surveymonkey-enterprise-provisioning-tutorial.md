---
title: Configure SurveyMonkey Enterprise for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to SurveyMonkey Enterprise.

author: adimitui
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to SurveyMonkey Enterprise so that I can streamline the user management process and ensure that users have the appropriate access to SurveyMonkey Enterprise.
---

# Configure SurveyMonkey Enterprise for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both SurveyMonkey Enterprise and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users to [SurveyMonkey Enterprise](https://www.surveymonkey.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in SurveyMonkey Enterprise.
> * Remove users in SurveyMonkey Enterprise when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and SurveyMonkey Enterprise.
> * [Single sign-on](surveymonkey-enterprise-tutorial.md) to SurveyMonkey Enterprise (recommended).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications). 
* A user account in SurveyMonkey Enterprise with Admin or Primary Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and SurveyMonkey Enterprise](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-surveymonkey-enterprise-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure SurveyMonkey Enterprise to support provisioning with Microsoft Entra ID

### Set Up SCIM Provisioning
Only the Primary Admin can set up SCIM provisioning for your organization. To make sure SCIM is a good fit for your IdP, the Primary Admin should check in with their SurveyMonkey Customer Success Manager (CSM) and their organization’s IT department.

Once the team is aligned, the Primary Admin can:

1. Go to [**Settings**](https://www.surveymonkey.com/team/settings/).
1. Select **User provisioning with SCIM**.
1. Copy the SCIM endpoint link and provide it to your IT partner.
1. Select **Generate token**. Treat this unique token as you would your Primary Admin password and only give it to your IT partner.

Your organization’s IT partner will use the SCIM endpoint link and access token during setup of the IdP. They will also need to adjust the default mapping for your team’s needs.

### Revoke SCIM Provisioning
If you need to disconnect Surveymonkey from your IdP so the systems no longer sync, the Primary Admin can revoke SCIM provisioning. As long as SSO is enabled, there is no impact to users who have already been synced.

To revoke the SCIM provisioning:

1. Go to [**Settings**](https://www.surveymonkey.com/team/settings/).
1. Select **User provisioning with SCIM**.
1. Next to the access token, select **Revoke**.

<a name='step-3-add-surveymonkey-enterprise-from-the-azure-ad-application-gallery'></a>

## Step 3: Add SurveyMonkey Enterprise from the Microsoft Entra application gallery

Add SurveyMonkey Enterprise from the Microsoft Entra application gallery to start managing provisioning to SurveyMonkey Enterprise. If you have previously setup SurveyMonkey Enterprise for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to SurveyMonkey Enterprise 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in SurveyMonkey Enterprise based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-surveymonkey-enterprise-in-azure-ad'></a>

### To configure automatic user provisioning for SurveyMonkey Enterprise in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **SurveyMonkey Enterprise**.

	![Screenshot of the SurveyMonkey Enterprise link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab.](common/provisioning.png)

1. Set the **Provisioning Mode** to **Automatic**.

	![Screenshot of Provisioning tab automatic.](common/provisioning-automatic.png)

1. Under the **Admin Credentials** section, input your SurveyMonkey Enterprise Tenant URL and corresponding Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to SurveyMonkey Enterprise.

 	![Screenshot of Token.](common/provisioning-testconnection-tenanturltoken.png)

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Screenshot of Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to SurveyMonkey Enterprise**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to SurveyMonkey Enterprise in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in SurveyMonkey Enterprise for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the SurveyMonkey Enterprise API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by SurveyMonkey Enterprise|
   |---|---|---|---|
   |userName|String|&check;|&check;
   |emails[type eq "work"].value|String||&check;
   |active|Boolean|||
   |name.givenName|String|||
   |name.familyName|String|||
   |externalId|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String|||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|||
	
1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for SurveyMonkey Enterprise, change the **Provisioning Status** to **On** in the **Settings** section.

	![Screenshot of Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users that you would like to provision to SurveyMonkey Enterprise by choosing the desired values in **Scope** in the **Settings** section.

	![Screenshot of Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

	![Screenshot of Saving Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

---
title: Configure AWS IAM Identity Center(successor to AWS single sign-On) for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to AWS IAM Identity Center.


author: adimitui
manager: jeedes

ms.service: entra-id
ms.subservice: saas-apps


ms.topic: how-to
ms.date: 03/25/2025
ms.author: addimitu

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to AWS IAM Identity Center so that I can streamline the user management process and ensure that users have the appropriate access to AWS IAM Identity Center.
---

# Configure AWS IAM Identity Center(successor to AWS single sign-On) for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both AWS IAM Identity Center(successor to AWS single sign-On) and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [AWS IAM Identity Center](https://console.aws.amazon.com/singlesignon) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in AWS IAM Identity Center
> * Remove users in AWS IAM Identity Center when they no longer require access
> * Keep user attributes synchronized between Microsoft Entra ID and AWS IAM Identity Center
> * Provision groups and group memberships in AWS IAM Identity Center
> * [IAM Identity Center](aws-single-sign-on-tutorial.md) to AWS IAM Identity Center

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A SAML connection from your Microsoft Entra account to AWS IAM Identity Center, as described in Tutorial

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and AWS IAM Identity Center](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-aws-iam-identity-center-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure AWS IAM Identity Center to support provisioning with Microsoft Entra ID

1. Open the [AWS IAM Identity Center](https://console.aws.amazon.com/singlesignon).

2. Choose **Settings** in the left navigation pane

3. In **Settings**, select Enable in the Automatic provisioning section.

	![Screenshot of enabling automatic provisioning.](media/aws-single-sign-on-provisioning-tutorial/automatic-provisioning.png)

4. In the Inbound automatic provisioning dialog box, copy and save the **SCIM endpoint** and **Access Token** (visible after selecting Show Token). These values are entered in the **Tenant URL** and **Secret Token** field in the Provisioning tab of your AWS IAM Identity Center application.
	![Screenshot of extracting provisioning configurations.](media/aws-single-sign-on-provisioning-tutorial/inbound-provisioning.png)

<a name='step-3-add-aws-iam-identity-center-from-the-azure-ad-application-gallery'></a>

## Step 3: Add AWS IAM Identity Center from the Microsoft Entra application gallery

Add AWS IAM Identity Center from the Microsoft Entra application gallery to start managing provisioning to AWS IAM Identity Center. If you have previously setup AWS IAM Identity Center for SSO, you can use the same application. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to AWS IAM Identity Center 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-aws-iam-identity-center-in-azure-ad'></a>

### To configure automatic user provisioning for AWS IAM Identity Center in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **AWS IAM Identity Center**.

	![Screenshot of the AWS IAM Identity Center link in the Applications list.](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, input your AWS IAM Identity Center **Tenant URL** and **Secret Token** retrieved earlier in Step 2. Select **Test Connection** to ensure Microsoft Entra ID can connect to AWS IAM Identity Center.

 	![Token](common/provisioning-testconnection-tenanturltoken.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to AWS IAM Identity Center**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to AWS IAM Identity Center in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in AWS IAM Identity Center for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the AWS IAM Identity Center API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for Filtering|
   |---|---|---|
   |userName|String|&check;|
   |active|Boolean||
   |displayName|String||
   |title|String||
   |emails[type eq "work"].value|String||
   |preferredLanguage|String||
   |name.givenName|String||
   |name.familyName|String||
   |name.formatted|String||
   |addresses[type eq "work"].formatted|String||
   |addresses[type eq "work"].streetAddress|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].region|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].country|String||
   |phoneNumbers[type eq "work"].value|String||
   |externalId|String||
   |locale|String||
   |timezone|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:organization|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference||

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to AWS IAM Identity Center**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to AWS IAM Identity Center in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in AWS IAM Identity Center for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|Supported for Filtering|
      |---|---|---|
      |displayName|String|&check;|
      |externalId|String||
      |members|Reference||

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for AWS IAM Identity Center, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to AWS IAM Identity Center by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Just-in-time (JIT) application access with PIM for groups 
With PIM for Groups, you can provide just-in-time access to groups in Amazon Web Services and reduce the number of users that have permanent access to privileged groups in AWS. 

**Configure your enterprise application for SSO and provisioning**
1. Add AWS IAM Identity Center to your tenant, configure it for provisioning as described in the article above, and start provisioning. 
1. Configure [single sign-on](aws-single-sign-on-provisioning-tutorial.md) for AWS IAM Identity Center.
1. Create a [group](/azure/active-directory/fundamentals/how-to-manage-groups) that provides all users access to the application.
1. Assign the group to the AWS Identity Center application.
1. Assign your test user as a direct member of the group created in the previous step, or provide them access to the group through an access package. This group can be used for persistent, non-admin access in AWS.

**Enable PIM for groups**
1. Create a second group in Microsoft Entra ID. This group provides access to admin permissions in AWS.
1. Bring the group under [management in Microsoft Entra PIM](/azure/active-directory/privileged-identity-management/groups-discover-groups).
1. Assign your test user as [eligible for the group in PIM](/azure/active-directory/privileged-identity-management/groups-assign-member-owner) with the role set to member.
1. Assign the second group to the AWS IAM Identity Center application.
1. Use on-demand provisioning to create the group in AWS IAM Identity Center.
1. Sign-in to AWS IAM Identity Center and assign the second group the necessary permissions to perform admin tasks.  

Now any end user that was made eligible for the group in PIM can get JIT access to the group in AWS by [activating their group membership](/azure/active-directory/privileged-identity-management/groups-activate-roles#activate-a-role).

**Key considerations**
* How long does it take to have a user provisioned to the application?: 
  * When a user is added to a group in Microsoft Entra ID outside of activating their group membership using Microsoft Entra ID Privileged Identity Management (PIM):
    * The group membership is provisioned in the application during the next synchronization cycle. The synchronization cycle runs every 40 minutes. 
  * When a user activates their group membership in Microsoft Entra ID PIM: 
    * The group membership is provisioned in 2 – 10 minutes. When there is a high rate of requests at one time, requests are throttled at a rate of five requests per 10 seconds.  
    * For the first five users within a 10-second period activating their group membership for a specific application, group membership is provisioned in the application within 2-10 minutes. 
    * For the sixth user and above within a 10-second period activating their group membership for a specific application, group membership is provisioned to the application in the next synchronization cycle. The synchronization cycle runs every 40 minutes. The throttling limits are per enterprise application. 
* If the user is unable to access the necessary group in AWS, please review the troubleshooting tips below, PIM logs, and provisioning logs to ensure that the group membership was updated successfully. Depending on how the target application has been architected, it may take additional time for the group membership to take effect in the application.
* You can create alerts for failures using [Azure Monitor](/entra/identity/app-provisioning/application-provisioning-log-analytics). 
* Deactivation is done during the regular incremental cycle. It isn't processed immediately through on-demand provisioning.
  
>[!VIDEO https://www.youtube.com/embed/aXp2CUFe7vk]

## Troubleshooting Tips

### Missing attributes
When provisioning a user to AWS, they're required to have the following attributes

* firstName
* lastName
* displayName
* userName 

Users who don't have these attributes fail with the following error

![errorcode](https://user-images.githubusercontent.com/83957767/146811532-8b95a90b-2a32-4094-87a3-1b8180793a66.png)


### Multi-valued attributes
AWS doesn't support the following multi-valued attributes:

* email
* phone numbers

Trying to flow the above as multi-valued attributes results in the following error message

![errorcode2](https://user-images.githubusercontent.com/83957767/146811704-8980c317-aa6b-43ad-bfb8-a17534fcb9d0.png)


There are two ways to resolve this

1. Ensure the user only has one value for phoneNumber/email
2. Remove the duplicate attributes. For example, having two different attributes being mapped from Microsoft Entra ID both mapped to "phoneNumber___" on the AWS side  would result in the error if both attributes have values in Microsoft Entra ID. Only having one attribute mapped to a "phoneNumber____ " attribute would resolve the error.

### Invalid characters
Currently AWS IAM Identity Center isn't allowing some other characters that Microsoft Entra ID supports like tab (\t), new line (\n), return carriage (\r), and characters such as " <|>|;|:% ".

You can also check the AWS IAM Identity Center  troubleshooting tips [here](https://docs.aws.amazon.com/singlesignon/latest/userguide/azure-ad-idp.html#azure-ad-troubleshooting) for more troubleshooting tips

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and IAM Identity Center with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

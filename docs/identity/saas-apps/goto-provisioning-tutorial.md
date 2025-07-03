---
title: Configure GoTo for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to GoTo.
author: thomasakelo
manager: jeedes
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: thomasakelo
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to GoTo so that I can streamline the user management process and ensure that users have the appropriate access to GoTo.
---

# Configure GoTo for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to perform in both GoTo and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [GoTo](https://www.goto.com/) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities Supported
> [!div class="checklist"]
> * Create users in GoTo
> * Remove users in GoTo when they don't require access anymore
> * Keep user attributes synchronized between Microsoft Entra ID and GoTo
> * Provision groups and group memberships in GoTo
> * [Single sign-on](./goto-tutorial.md) to GoTo (recommended)

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* An organization created in the GoTo Organization Center with at least one verified domain 
* A user account in the GoTo Organization Center with [permission](https://support.goto.com/meeting/help/manage-organization-users-g2m710102) to configure provisioning (for example, organization administrator role with Read & Write permissions) as shown in Step 2.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
2. Determine who's in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
3. Determine what data to [map between Microsoft Entra ID and GoTo](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-goto-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure GoTo to support provisioning with Microsoft Entra ID

1. Log in to the [Organization Center](https://organization.logmeininc.com).

2. The domain used in your account's email address is the domain that you're prompted to verify within 10 days.  

3. You can verify ownership of your domain using either of the following methods:

   **Method 1:  Add a DNS record to your domain zone file.**  
   To use the DNS method, you place a DNS record at the level of the email domain within your DNS zone.  Examples using "main.com" as the domain would resemble:  `@ IN TXT "goto-verification-code=00aa00aa-bb11-cc22-dd33-44ee44ee44ee"` OR `main.com. IN TXT “goto-verification-code=00aa00aa-bb11-cc22-dd33-44ee44ee44ee”`

   Detailed instructions are as follows:
     1. Sign in to your domain's account at your domain host.
     2. Navigate to the page for updating your domain's DNS records.
     3. Locate the TXT records for your domain, then add a TXT record for the domain and for each subdomain.
     4. Save all changes.
     5. You can verify that the change has taken place by opening a command line and entering one of the following commands below (based on your operating system, with "main.com" as the domain example):
         * For Unix and Linux systems:  `$ dig TXT main.com`
         * For Windows systems:  `c:\ > nslookup -type=TXT main.com`
     6. The response will display on its own line.

   **Method 2: Upload a web server file to the specific website.**
   Upload a plain-text file to your web server root containing a verification string without any blank spaces or special characters outside of the string.
   
      * Location: `http://<yourdomain>/goto-verification-code.txt`
      * Contents: `goto-verification-code=00aa00aa-bb11-cc22-dd33-44ee44ee44ee`

4. Once you have added the DNS record or TXT file, return to [Organization Center](https://organization.logmeininc.com) and select **Verify**.

5. You have now created an organization in the Organization Center by verifying your domain, and the account used during this verification process is now the organization admin.

<a name='step-3-add-goto-from-the-azure-ad-application-gallery'></a>

## Step 3: Add GoTo from the Microsoft Entra application gallery

Add GoTo from the Microsoft Entra application gallery to start managing provisioning to GoTo. If you have previously setup GoTo for SSO, you can use the same application. However, we recommend that you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to GoTo 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in TestApp based on user and/or group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-goto-in-azure-ad'></a>

### To configure automatic user provisioning for GoTo in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **GoTo**.

	![The GoTo link in the Applications list](common/all-applications.png)

3. Select the **Provisioning** tab.

	![Provisioning tab](common/provisioning.png)

4. Set the **Provisioning Mode** to **Automatic**.

	![Provisioning tab automatic](common/provisioning-automatic.png)

5. Under the **Admin Credentials** section, select **Authorize**. You be redirected to **GoTo**'s authorization page. Input your GoTo username and select the **Next** button. Input your GoTo password and select the **Sign In** button. Select **Test Connection** to ensure Microsoft Entra ID can connect to GoTo. If the connection fails, ensure your GoTo account has Admin permissions and try again.

 	![authorization](./media/goto-provisioning-tutorial/admin.png)

      ![login](./media/goto-provisioning-tutorial/username.png)

      ![connection](./media/goto-provisioning-tutorial/password.png)

6. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

	![Notification Email](common/provisioning-notification-email.png)

7. Select **Save**.

8. Under the **Mappings** section, select **Synchronize Microsoft Entra users to GoTo**.

9. Review the user attributes that are synchronized from Microsoft Entra ID to GoTo in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in GoTo for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the GoTo API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |externalId|String|
   |active|Boolean|
   |name.givenName|String|
   |name.familyName|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:costCenter|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:division|String|

10. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to GoTo**.

11. Review the group attributes that are synchronized from Microsoft Entra ID to GoTo in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in GoTo for update operations. Select the **Save** button to commit any changes.

      |Attribute|Type|
      |---|---|
      |displayName|String|
      |externalId|String|
      |members|Reference|

12. To configure scoping filters, refer to the following instructions provided in the [Scoping filter  article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

13. To enable the Microsoft Entra provisioning service for GoTo, change the **Provisioning Status** to **On** in the **Settings** section.

	![Provisioning Status Toggled On](common/provisioning-toggle-on.png)

14. Define the users and/or groups that you would like to provision to GoTo by choosing the desired values in **Scope** in the **Settings** section.

	![Provisioning Scope](common/provisioning-scope.png)

15. When you're ready to provision, select **Save**.

	![Saving Provisioning Configuration](common/provisioning-configuration-save.png)

This operation starts the initial synchronization cycle of all users and groups defined in **Scope** in the **Settings** section. The initial cycle takes longer to perform than subsequent cycles, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. 

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

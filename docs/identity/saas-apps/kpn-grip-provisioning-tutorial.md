---
title: Configure KPN Grip for automatic user provisioning with Microsoft Entra ID
description: Learn how to automatically provision and de-provision user accounts from Microsoft Entra ID to KPN Grip.


author: jeevansd
manager: pmwongera

ms.topic: how-to
ms.date: 04/13/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to KPN Grip so that I can streamline the user management process and ensure that users have the appropriate access to KPN Grip.
---

# Configure KPN Grip for automatic user provisioning with Microsoft Entra ID

This article describes the steps you need to do in both KPN Grip and Microsoft Entra ID to configure automatic user provisioning. When configured, Microsoft Entra ID automatically provisions and de-provisions users and groups to [KPN Grip](https://grip.kpn.com) using the Microsoft Entra provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS apps with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md). 


## Capabilities supported
> [!div class="checklist"]
> * Create users in KPN Grip.
> * Remove users in KPN Grip when they don't require access anymore.
> * Keep user attributes synchronized between Microsoft Entra ID and KPN Grip.
> * [Single sign-on](~/identity/enterprise-apps/add-application-portal-setup-oidc-sso.md) to KPN Grip.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [A Microsoft Entra tenant](~/identity-platform/quickstart-create-new-tenant.md). 
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A user account in KPN Grip with Admin permissions.

## Step 1: Plan your provisioning deployment
1. Learn about [how the provisioning service works](~/identity/app-provisioning/user-provisioning.md).
1. Determine who is in [scope for provisioning](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).
1. Determine what data to [map between Microsoft Entra ID and KPN Grip](~/identity/app-provisioning/customize-application-attributes.md). 

<a name='step-2-configure-kpn-grip-to-support-provisioning-with-azure-ad'></a>

## Step 2: Configure KPN Grip to support provisioning with Microsoft Entra ID

To configure KPN Grip to support provisioning with Microsoft Entra ID refer KPN Grip Microsoft Entra Settings at `https://grip.kpn.com/en/documentation/article/connectentraid#`.

<a name='step-3-add-kpn-grip-from-the-azure-ad-application-gallery'></a>

## Step 3: Add KPN Grip from the Microsoft Entra application gallery

Add KPN Grip from the Microsoft Entra application gallery to start managing provisioning to KPN Grip. If you have previously setup KPN Grip for SSO, you can use the same application. However it's recommended you create a separate app when testing out the integration initially. Learn more about adding an application from the gallery [here](~/identity/enterprise-apps/add-application-portal.md). 

## Step 4: Define who is in scope for provisioning 

[!INCLUDE [create-assign-users-provisioning.md](~/identity/saas-apps/includes/create-assign-users-provisioning.md)]

## Step 5: Configure automatic user provisioning to KPN Grip 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and groups in KPN Grip based on user and group assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-kpn-grip-in-azure-ad'></a>

### To configure automatic user provisioning for KPN Grip in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Screenshot of Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **KPN Grip**.

	![Screenshot of The KPN Grip link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of Provisioning tab](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your KPN Grip Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to KPN Grip. If the connection fails, ensure your KPN Grip account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine notifications. Enable **Accidental deletions prevention**. Select **Apply** to save the changes.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to KPN Grip in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in KPN Grip for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the KPN Grip API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by KPN Grip
   |---|---|---|---|
   |userName|String|&check;|&check;
   |displayName|String||&check;
   |active|Boolean|| 
   |name.givenName|String||
   |name.familyName|String||
   |emails[type eq "work"].value|String||
   |emails[type eq "alternate"].value|String||
   |phoneNumbers[type eq "work"].value|String||
   |phoneNumbers[type eq "mobile"].value|String||
   |addresses[type eq "work"].region|String||
   |addresses[type eq "work"].streetAddress|String||
   |addresses[type eq "work"].locality|String||
   |addresses[type eq "work"].postalCode|String||
   |addresses[type eq "work"].country|String||    
   |externalId|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|String||
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:employeeNumber|String||

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Step 6: Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## More resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

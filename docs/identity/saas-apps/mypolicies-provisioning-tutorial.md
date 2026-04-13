---
title: Configure myPolicies for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to myPolicies.

author: jeevansd
ms.topic: how-to
ms.date: 04/13/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to myPolicies so that I can streamline the user management process and ensure that users have the appropriate access to myPolicies.
---

# Configure myPolicies for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in myPolicies and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to myPolicies.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

* [!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A myPolicies tenant](https://mypolicies.com/).
* A user account in myPolicies with Admin permissions.

## Assigning users to myPolicies

Microsoft Entra ID uses a concept called *assignments* to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been assigned to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to myPolicies. Once decided, you can assign these users and/or groups to myPolicies by following the instructions here:
* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

## Important tips for assigning users to myPolicies

* It's recommended that a single Microsoft Entra user is assigned to myPolicies to test the automatic user provisioning configuration. Additional users and/or groups may be assigned later.

* When assigning a user to myPolicies, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Set up myPolicies for provisioning

Before configuring myPolicies for automatic user provisioning with Microsoft Entra ID, you need to enable SCIM provisioning on myPolicies.

1. Reach out to your myPolicies representative at **support@mypolicies.com** to obtain the secret token needed to configure SCIM provisioning.

1.  Save the token value provided by the myPolicies representative. This value is entered in the **Secret Token** field in the Provisioning tab of your myPolicies application.

## Add myPolicies from the gallery

To configure myPolicies for automatic user provisioning with Microsoft Entra ID, you need to add myPolicies from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add myPolicies from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **myPolicies**, select **myPolicies** in the search box.
1. Select **myPolicies** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.
	![myPolicies in the results list](common/search-new-app.png)

## Configuring automatic user provisioning to myPolicies 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in myPolicies based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for myPolicies, following the instructions provided in the [myPolicies Single sign-on  article](mypolicies-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-mypolicies-in-azure-ad'></a>

### To configure automatic user provisioning for myPolicies in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **myPolicies**.

	![The myPolicies link in the Applications list](common/all-applications.png)

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, enter your myPolicies Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to myPolicies. If the connection fails, ensure your myPolicies account has the required admin permissions and try again.

   > [!NOTE]
   > Enter `https://scim.mx3.app` in the **Tenant URL**.`https://<myPoliciesCustomDomain>.mypolicies.com/scim` in **Tenant URL** where `<myPoliciesCustomDomain>` is your myPolicies custom domain. You can retrieve your myPolicies customer domain, from your URL.
   > Example: `<demo0-qa>`.mypolicies.com.

	![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. In the **Notification Email** field, enter the email address of a person who should receive the provisioning error notifications and select the **Send an email notification when a failure occurs** check box.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to myPolicies in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in myPolicies for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the myPolicies API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|
   |---|---|
   |userName|String|
   |active|Boolean|
   |emails[type eq "work"].value|String|
   |name.givenName|String|
   |name.familyName|String|
   |name.formatted|String|
   |externalId|String|
   |addresses[type eq "work"].country|String|
   |urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:manager|Reference|

1. To configure scoping filters, refer to the instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Connector limitations

* myPolicies always requires **userName**, **email** and **externalId**.
* myPolicies doesn't support hard deletes for user attributes.

## Change log

* 09/15/2020 - Added support for "country" attribute for Users.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

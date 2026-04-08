---
title: Configure MerchLogix for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and de-provision user accounts to MerchLogix.

author: zhchia
ms.topic: how-to
ms.date: 03/16/2026
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Merchlogix so that I can streamline the user management process and ensure that users have the appropriate access to Merchlogix.
---

# Configure MerchLogix for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in MerchLogix and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and de-provision users and/or groups to MerchLogix.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user Provisioning Service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* A MerchLogix tenant
* A technical contact at MerchLogix who can provide the SCIM endpoint URL and secret token required for user provisioning

## Adding MerchLogix from the gallery

Before configuring MerchLogix for automatic user provisioning with Microsoft Entra ID, you need to add MerchLogix from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add MerchLogix from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **MerchLogix** in the search box.
1. Select **MerchLogix** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

## Assigning users to MerchLogix

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been "assigned" to an application in Microsoft Entra ID are synchronized. 

Before configuring and enabling automatic user provisioning, you should decide which users and/or groups in Microsoft Entra ID need access to MerchLogix. Once decided, you can assign these users and/or groups to MerchLogix by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to MerchLogix

* It's recommended that a single Microsoft Entra user is assigned to MerchLogix to test your initial automatic user provisioning configuration. Additional users and/or groups may be assigned later once the tests are successful.

* When assigning a user to MerchLogix, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Configuring automatic user provisioning to MerchLogix 

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users and/or groups in MerchLogix based on user and/or group assignments in Microsoft Entra ID.

> [!TIP]
> You may also choose to enable SAML-based single sign-on for MerchLogix, following the instructions provided in the [MerchLogix single sign-on  article](merchlogix-tutorial.md). Single sign-on can be configured independently of automatic user provisioning, though these two features complement each other.

<a name='to-configure-automatic-user-provisioning-for-merchlogix-in-azure-ad'></a>

### To configure automatic user provisioning for MerchLogix in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**

1. Select **MerchLogix** from your list of applications.

1. Select the **Provisioning** tab.

	![Screenshot of the Manage options with the Provisioning option called out.](common/provisioning.png)

1. Select **+ New configuration**.

	![Screenshot of Provisioning tab automatic.](common/application-provisioning.png)

1. In the **Tenant URL** field, input your MerchLogix Tenant URL and Secret Token. Select **Test Connection** to ensure Microsoft Entra ID can connect to MerchLogix. If the connection fails, ensure your MerchLogix account has the required admin permissions and try again.

   ![Screenshot of Provisioning test connection.](common/provisioning-test-connection.png)

1. Select **Create** to create your configuration.

1. Select **Properties** on the **Overview** page.

1. Select the **Edit** icon to edit the properties. Enable notification emails and provide an email to receive quarantine emails. Enable accidental deletions prevention. Select **Apply** to save the changes.

   ![Screenshot of Provisioning properties.](common/provisioning-properties.png)

1. Select **Attribute Mapping** in the left panel and select **users**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to MerchLogix in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in MerchLogix for update operations. Select the **Save** button to commit any changes.

1. Select **Groups**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to MerchLogix in the **Attribute Mapping** section. The attributes selected as **Matching** properties are used to match the groups in MerchLogix for update operations. Select the **Save** button to commit any changes.

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. Use [on-demand provisioning](~/identity/app-provisioning/provision-on-demand.md) to validate sync with a small number of users before deploying more broadly in your organization.  

1. When you're ready to provision, select **Start Provisioning** from the **Overview** page.

## Monitor your deployment

[!INCLUDE [monitor-deployment.md](~/identity/saas-apps/includes/monitor-deployment.md)]

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

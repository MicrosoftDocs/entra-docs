---
title: Configure Cisco Webex for automatic user provisioning with Microsoft Entra ID
description: Learn how to configure Microsoft Entra ID to automatically provision and deprovision user accounts to Cisco Webex.

author: jeevansd
manager: mwongerapk
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to automatically provision and deprovision user accounts from Microsoft Entra ID to Cisco Webex so that I can streamline the user management process and ensure that users have the appropriate access to Cisco Webex.
---

# Configure Cisco Webex for automatic user provisioning with Microsoft Entra ID

The objective of this article is to demonstrate the steps to be performed in Cisco Webex  and Microsoft Entra ID to configure Microsoft Entra ID to automatically provision and deprovision users to Cisco Webex.

> [!NOTE]
> This article describes a connector built on top of the Microsoft Entra user provisioning service. For important details on what this service does, how it works, and frequently asked questions, see [Automate user provisioning and deprovisioning to SaaS applications with Microsoft Entra ID](~/identity/app-provisioning/user-provisioning.md).
>
> This connector is currently in Preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)].
* [A Cisco Webex tenant](https://www.webex.com/pricing/index.html).
* A user account in Cisco Webex  with Admin permissions.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Adding Cisco Webex from the gallery

Before configuring Cisco Webex for automatic user provisioning with Microsoft Entra ID, you need to add Cisco Webex from the Microsoft Entra application gallery to your list of managed SaaS applications.

**To add Cisco Webex from the Microsoft Entra application gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cisco Webex**, select **Cisco Webex** from result panel then select **Add** button to add the application.

    ![Screenshot shows the Cisco Webex in the results list.](media/cisco-webex-provisioning-tutorial/search-cisco-app.png)

## Assigning users to Cisco Webex

Microsoft Entra ID uses a concept called "assignments" to determine which users should receive access to selected apps. In the context of automatic user provisioning, only the users and/or groups that have been "assigned" to an application in Microsoft Entra ID are synchronized.

Before configuring and enabling automatic user provisioning, you should decide which users in Microsoft Entra ID need access to Cisco Webex. Once decided, you can assign these users to Cisco Webex by following the instructions here:

* [Assign a user or group to an enterprise app](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)

### Important tips for assigning users to Cisco Webex

* It's recommended that a single Microsoft Entra user is assigned to Cisco Webex to test the automatic user provisioning configuration. Additional users may be assigned later.

* When assigning a user to Cisco Webex, you must select any valid application-specific role (if available) in the assignment dialog. Users with the **Default Access** role are excluded from provisioning.

## Configuring automatic user provisioning to Cisco Webex

This section guides you through the steps to configure the Microsoft Entra provisioning service to create, update, and disable users in Cisco Webex based on user assignments in Microsoft Entra ID.

<a name='to-configure-automatic-user-provisioning-for-cisco-webex-in-azure-ad'></a>

### To configure automatic user provisioning for Cisco Webex in Microsoft Entra ID:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cisco Webex**.

    ![Screenshot shows the Enterprise applications blade.](common/enterprise-applications.png)

1. In the applications list, select **Cisco Webex**.

    ![Screenshot shows the Cisco Webex link in the Applications list.](common/all-applications.png)

1. Select the **Provisioning** tab.

    :::image type="content" source="common/provisioning.png" alt-text="Screenshot of a menu. Under Manage, Provisioning is highlighted." border="false":::

1. Set the **Provisioning Mode** to **Automatic**.

    :::image type="content" source="common/provisioning-automatic.png" alt-text="Screenshot of the Provisioning mode list box, with Automatic highlighted." border="false":::

1. Under the **Admin Credentials** section, input the **Tenant URL**, and **Secret Token** of your Cisco Webex account.

    :::image type="content" source="./media/cisco-webex-provisioning-tutorial/secrettoken1.png" alt-text="Screenshot of the Admin Credentials section. The Tenant U R L and Secret token boxes are highlighted but are empty." border="false":::

1.  In the **Tenant URL** field, enter a value in the form of `https://api.ciscospark.com/v1/scim/[OrgId]`. To obtain `[OrgId]`, sign into your [Cisco Webex Control Hub](https://admin.webex.com/login). Select your organization name on the bottom left and copy the value from **Organization ID**. 

    * To obtain the value for **Secret Token**, navigate to this [URL](https://idbroker.webex.com/idb/saml2/jsp/doSSO.jsp?type=login&goto=https%3A%2F%2Fidbroker.webex.com%2Fidb%2Foauth2%2Fv1%2Fauthorize%3Fresponse_type%3Dtoken%26client_id%3DC4ca14fe00b0e51efb414ebd45aa88c1858c3bfb949b2405dba10b0ca4bc37402%26redirect_uri%3Dhttp%253A%2f%2flocalhost%253A3000%2fauth%2fcode%26scope%3Dspark%253Apeople_read%2520spark%253Apeople_write%2520Identity%253ASCIM%26state%3Dthis-should-be-a-random-string-for-security-purpose). From the webex sign in page that appears, sign in with the full Cisco Webex admin account for your organization. An error page appears saying that the site can't be reached, but this is normal.

        :::image type="content" source="./media/cisco-webex-provisioning-tutorial/test.png" alt-text="Screenshot of a webpage displaying an error message. The message says that the site can't be reached and includes a few troubleshooting tips." border="false":::
 
    * Copy the value of the generated bearer token from the URL as highlighted below. This token is valid for 365 days.
        
        :::image type="content" source="./media/cisco-webex-provisioning-tutorial/test1.png" alt-text="Screenshot showing a long U R L. Part of the address is indecipherable but is highlighted and labeled Bearer token." border="false":::

1. Upon populating the fields shown in Step 5, select **Test Connection** to ensure Microsoft Entra ID can connect to Cisco Webex. If the connection fails, ensure your Cisco Webex account has Admin permissions and try again.

    ![Screenshot shows the Tenant URL and Token.](common/provisioning-testconnection-tenanturltoken.png)
   
1. In the **Notification Email** field, enter the email address of a person or group who should receive the provisioning error notifications and check the checkbox - **Send an email notification when a failure occurs**.

    ![Screenshot shows the Notification Email.](common/provisioning-notification-email.png)

1. Select **Save**.

1. Under the **Mappings** section, select **Synchronize Microsoft Entra users to Cisco Webex**.

1. Review the user attributes that are synchronized from Microsoft Entra ID to Cisco Webex in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the user accounts in Cisco Webex for update operations. If you choose to change the [matching target attribute](~/identity/app-provisioning/customize-application-attributes.md), you need to ensure that the Cisco Webex API supports filtering users based on that attribute. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Cisco Webex|
   |---|---|---|---|
   |userName|String|&check;|&check;|
   |name.givenName|String|||
   |name.familyName|String|||
   |active|Boolean|||
   |displayName|String|||
   |externalId|String|||

1. Under the **Mappings** section, select **Synchronize Microsoft Entra groups to Cisco Webex**.

1. Review the group attributes that are synchronized from Microsoft Entra ID to Cisco Webex in the **Attribute-Mapping** section. The attributes selected as **Matching** properties are used to match the groups in Cisco Webex for update operations. Select the **Save** button to commit any changes.

   |Attribute|Type|Supported for filtering|Required by Cisco Webex|
   |---|---|---|---|
   |displayName|String|&check;|&check;|
   |members|Reference|||
   |externalId|String|||

1. To configure scoping filters, refer to the following instructions provided in the [Scoping filter article](~/identity/app-provisioning/define-conditional-rules-for-provisioning-user-accounts.md).

1. To enable the Microsoft Entra provisioning service for Cisco Webex, change the **Provisioning Status** to **On** in the **Settings** section.

    ![Screenshot shows the Provisioning Status Toggled On.](common/provisioning-toggle-on.png)

1. Define the users and/or groups that you would like to provision to Cisco Webex by choosing the desired values in **Scope** in the **Settings** section.

    ![Screenshot shows the Provisioning Scope.](common/provisioning-scope.png)

1. When you're ready to provision, select **Save**.

    ![Screenshot shows to Save Provisioning Configuration.](common/provisioning-configuration-save.png)

This operation starts the initial synchronization of all users and/or groups defined in **Scope** in the **Settings** section. The initial sync takes longer to perform than subsequent syncs, which occur approximately every 40 minutes as long as the Microsoft Entra provisioning service is running. You can use the **Synchronization Details** section to monitor progress and follow links to provisioning activity report, which describes all actions performed by the Microsoft Entra provisioning service on Cisco Webex.

For more information on how to read the Microsoft Entra provisioning logs, see [Reporting on automatic user account provisioning](~/identity/app-provisioning/check-status-user-account-provisioning.md).

## Connector limitations

* Cisco Webex is currently in Cisco's Early Field Testing (EFT) phase. For more information, please contact [Cisco's support team](https://www.webex.co.in/support/support-overview.html). 
* For more information on Cisco Webex configuration, refer to the Cisco documentation [here](https://help.webex.com/en-us/aumpbz/Synchronize-Azure-Active-Directory-Users-into-cisco-webex-Control-Hub).

## Change log

* 02/07/2023 - Added support for **Group Provisioning**.

## Additional resources

* [Managing user account provisioning for Enterprise Apps](~/identity/app-provisioning/configure-automatic-user-provisioning-portal.md)
* [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

## Related content

* [Learn how to review logs and get reports on provisioning activity](~/identity/app-provisioning/check-status-user-account-provisioning.md)

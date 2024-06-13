---

title: Add B2B collaboration users as an information worker
description: B2B collaboration allows information workers and app owners to add guest users to Microsoft Entra ID for access.
ms.service: entra-external-id
ms.topic: how-to
ms.date: 06/13/2024
ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.custom: it-pro
ms.collection: M365-identity-device-management
# Customer intent: As an application owner in Microsoft Entra, I want to be able to invite guest users to an app and manage their access, so that I can easily share the app with external users and control their permissions.
---

# How users in your organization can invite guest users to an app

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

After a guest user has been added to the directory in Microsoft Entra ID, an application owner can send the guest user a direct link to the app they want to share. Microsoft Entra admins can also set up self-service management for gallery or SAML-based apps in their Microsoft Entra tenant. This way, application owners can manage their own guest users, even if the guest users haven’t been added to the directory yet. When an app is configured for self-service, the application owner uses their Access Panel to invite a guest user to an app or add a guest user to a group that has access to the app. 

Self-service app management for gallery and SAML-based apps requires some initial setup by an admin. Follow the summary of the setup steps (for more detailed instructions, see [Prerequisites](#prerequisites) later on this page):

 - Enable self-service group management for your tenant
 - Create a group to assign to the app and make the user an owner
 - Configure the app for self-service and assign the group to the app

> [!NOTE]
> * This article describes how to set up self-service management for gallery and SAML-based apps that you’ve added to your Microsoft Entra tenant. You can also [set up self-service Microsoft 365 groups](~/identity/users/groups-self-service-management.md) so your users can manage access to their own Microsoft 365 groups. For more ways users can share Office files and apps with guest users, see [Guest access in Microsoft 365 groups](https://support.office.com/article/guest-access-in-office-365-groups-bfc7a840-868f-4fd6-a390-f347bf51aff6) and [Share SharePoint files or folders](https://support.office.com/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c).
> * Users are only able to invite guests if they have the **Guest inviter** role.

## Invite someone to join a group that has access to the app
After an app is configured for self-service, application owners can invite guest users to the groups they manage that have access to the apps they want to share. The guest users don't have to already exist in the directory. The application owner follows these steps to invite a guest user to the group so that they can access the app.

1. Make sure you're an owner of the self-service group that has access to the app you want to share.
2. Open your Access Panel by going to `https://myapps.microsoft.com`.
3. Select the **Groups** app.
   
:::image type="content" source="media/add-users-iw/access-panel-groups.png" alt-text="Screenshot showing the Groups app in the Access Panel.":::
   
4. Under **Groups I own**, select the group that has access to the app you want to share.
   
:::image type="content" source="media/add-users-iw/access-panel-groups-i-own.png" alt-text="Screenshot showing where to select a group under the Groups I own.":::
   
5. At the top of the group members list, select **+**.
   
:::image type="content" source="media/add-users-iw/access-panel-groups-add-member.png" alt-text="Screenshot showing the plus symbol for adding members to the group.":::
   
6. In the **Add members** search box, type the email address for the guest user. Optionally, include a welcome message.
   
:::image type="content" source="media/add-users-iw/access-panel-invitation.png" alt-text="Screenshot showing the Add members window for adding a guest.":::
   
7. Select **Add** to automatically send the invitation to the guest user. After you send the invitation, the user account is automatically added to the directory as a guest.


## Prerequisites

Self-service app management requires some initial setup by a Microsoft Entra administrator. As part of this setup, you'll configure the app for self-service and assign a group to the app that the application owner can manage. You can also configure the group to allow anyone to request membership but require a group owner's approval. (Learn more about [self-service group management](~/identity/users/groups-self-service-management.md).) 

> [!NOTE]
> You cannot add guest users to a dynamic group or to a group that is synced with on-premises Active Directory.

### Enable self-service group management for your tenant

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Groups** > **All groups**.
4. Under **Settings**, select **General**.
5. Under **Self Service Group Management**, next to **Owners can manage group membership requests in the Access Panel**, select **Yes**.
6. Select **Save**.

### Create a group to assign to the app and make the user an owner

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Groups** > **All groups**.
4. Select **New group**.
5. Under **Group type**, select **Security**.
6. Type a **Group name** and **Group description**.
7. Under **Membership type**, select **Assigned**.
8. Select **Create**, and close the **Group** page.
9. On the **Groups - All groups** page, open the group. 
10. Under **Manage**, select **Owners** > **Add owners**. Search for the user who should manage access to the application. Select the user, and then select **Select**.

### Configure the app for self-service and assign the group to the app

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
4. Select **All applications**, in the application list, find and open the app.
5. Under **Manage**, select **Single sign-on**, and configure the application for single sign-on. (For details, see [how to manage single sign-on for enterprise apps](~/identity/enterprise-apps/add-application-portal-setup-sso.md).)
6. Under **Manage**, select **Self-service**, and set up self-service app access. (For details, see [how to use self-service app access](~/identity/enterprise-apps/manage-self-service-access.md).) 

    > [!NOTE]
    > For the setting **To which group should assigned users be added?** select the group you created in the previous section.
7. Under **Manage**, select **Users and groups**, and verify that the self-service group you created appears in the list.
8. To add the app to the group owner's Access Panel, select **Add user** > **Users and groups**. Search for the group owner and select the user, select **Select**, and then select **Assign** to add the user to the app.

## Next steps

See the following articles on Microsoft Entra B2B collaboration:

- [What is Microsoft Entra B2B collaboration?](what-is-b2b.md)
- [How do Microsoft Entra admins add B2B collaboration users?](add-users-administrator.yml)
- [B2B collaboration invitation redemption](redemption-experience.md)
- [External ID pricing](external-identities-pricing.md)

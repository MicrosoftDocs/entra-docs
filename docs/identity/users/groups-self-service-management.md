---
title: Set up self-service group management
description: Create and manage security groups or Microsoft 365 groups in Microsoft Entra ID and request security group or Microsoft 365 group memberships.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 07/23/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Set up self-service group management in Microsoft Entra ID

You can enable users to create and manage their own security groups or Microsoft 365 groups in Microsoft Entra ID. The owner of the group can approve or deny membership requests and delegate control of group membership. Self-service group management features aren't available for [mail-enabled security groups or distribution lists](~/fundamentals/concept-learn-about-groups.md).

## Self-service group membership

You can allow users to create security groups, which are used to manage access to shared resources. Users can create security groups in the Azure portal by using Azure Active Directory (Azure AD) PowerShell or from the [My Groups access panel](https://myaccount.microsoft.com/groups).  

:::image type="content" source="./media/groups-self-service-management/my-groups.png" alt-text="Screenshot that shows the My Groups access panel." lightbox="./media/groups-self-service-management/my-groups.png":::

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

Only the group's owners can update membership, but you can provide group owners with the ability to approve or deny membership requests from the My Groups access panel. Security groups created by self-service through the My Groups access panel are available to join for all users, whether owner-approved or autoapproved. In the My Groups access panel, you can change membership options when you create the group.

Microsoft 365 groups provide collaboration opportunities for your users. You can create groups in any of the Microsoft 365 applications, such as SharePoint, Microsoft Teams, and Planner. You can also create Microsoft 365 groups in Azure portals by using Microsoft Graph PowerShell or from the My Groups access panel. For more information on the difference between security groups and Microsoft 365 groups, see [Learn about groups](~/fundamentals/concept-learn-about-groups.md#what-to-know-before-creating-a-group).

Groups created in | Security group default behavior | Microsoft 365 group default behavior
------------------ | ------------------------------- | ---------------------------------
[Microsoft Graph PowerShell](/entra/identity/users/groups-settings-v2-cmdlets) | Only owners can add members.<br>Visible but not available to join in MyApp Groups Access Panel. | Open to join for all users.
[Azure portal](https://portal.azure.com) | Only owners can add members.<br>Visible but not available to join in My Groups access panel.<br>Owner isn't assigned automatically at group creation. | Open to join for all users.
[My Groups access panel](https://myaccount.microsoft.com/groups) | Users can manage groups and request access to join groups here.<br>Membership options can be changed when a group is created. | Open to join for all users.<br>Membership options can be changed when a group is created.

## Self-service group management scenarios

Two scenarios help to explain self-service group management.

### Delegated group management

In this example scenario, an administrator manages access to a software as a service (SaaS) application that the company is using. Managing the access rights is cumbersome, so the administrator asks the business owner to create a new group. The administrator assigns access for the application to the new group and adds to the group all people already accessing the application. The business owner then can add more users, and those users are automatically provisioned to the application.

The business owner doesn't need to wait for the administrator to manage access for users. If the administrator grants the same permission to a manager in a different business group, that person can also manage access for their own group members. The business owner and the manager can't view or manage each other's group memberships. The administrator can still see all users who have access to the application and block access rights, if needed.

> [!NOTE]
> For delegated scenarios, the administrator needs to have at least a [Privileged Role Administrator Microsoft Entra](~/identity/role-based-access-control/permissions-reference.md) role.

### Self-service group management

In this example scenario, two users have SharePoint Online sites that they set up independently. They want to give each other's teams access to their sites. To accomplish this task, they can create one group in Microsoft Entra ID. In SharePoint Online, each of them selects that group to provide access to their sites.

When someone wants access, they request it from the [My Groups access panel](https://myaccount.microsoft.com/groups). After approval, they get access to both SharePoint Online sites automatically. Later, one of them decides that all people accessing the site should also get access to a particular SaaS application. The administrator of the SaaS application can add access rights for the application to the SharePoint Online site. From then on, any requests that get approved give access to the two SharePoint Online sites and also to the SaaS application.

## Make a group available for user self-service

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
1. Select **Microsoft Entra ID**.

1. Select **All groups** > **Groups**, and then select **General** settings.

    > [!NOTE]
    > This setting only restricts access of group information in **My Groups**. It doesn't restrict access to group information via other methods like Microsoft Graph API calls or the Microsoft Entra admin center.

   :::image type="content" source="./media/groups-self-service-management/groups-settings-general.png" alt-text="Screenshot that shows Microsoft Entra groups General settings." lightbox="./media/groups-self-service-management/groups-settings-general.png":::

   > [!NOTE]
   > Changes regarding the Self Service Group Management setting, initially scheduled for June 2024, are currently under review and will not take place as originally planned. A deprecation date will be announced in the future.

1. Set **Owners can manage group membership requests in the Access Panel** to **Yes**.
1. Set **Restrict user ability to access groups features in the Access Panel** to **No**.
1. Set **Users can create security groups in Azure portals, API or PowerShell** to **Yes** or **No**.

    For more information about this setting, see [Group settings](#group-settings).

1. Set **Users can create Microsoft 365 groups in Azure portals, API or PowerShell** to **Yes** or **No**.

    For more information about this setting, see [Group settings](#group-settings).

You can also use **Owners who can assign members as group owners in the Azure portal** to achieve more granular access control over self-service group management for your users.

When users can create groups, all users in your organization are allowed to create new groups. As the default owner, they can then add members to these groups. You can't specify individuals who can create their own groups. You can specify individuals only for making another group member a group owner.

> [!NOTE]
> A Microsoft Entra ID P1 or P2 license is required for users to request to join a security group or Microsoft 365 group and for owners to approve or deny membership requests. Without a Microsoft Entra ID P1 or P2 license, users can still manage their groups in the MyApp Groups Access Panel. But they can't create a group that requires owner approval, and they can't request to join a group.

## Group settings

The group settings enable you to control who can create security and Microsoft 365 groups.

:::image type="content" source="./media/groups-self-service-management/security-groups-setting.png" alt-text="Screenshot that shows Microsoft Entra security groups setting change.":::

 The following table helps you decide which values to choose.

| Setting | Value | Effect on your tenant |
| --- | :---: | --- |
| Users can create security groups in the Azure portal, API, or PowerShell. | Yes | All users in your Microsoft Entra organization are allowed to create new security groups and add members to these groups in the Azure portal, API, or PowerShell. These new groups also show up in the Access Panel for all other users. If the policy setting on the group allows it, other users can create requests to join these groups. |
|  | No | Users can’t create security groups. They can still manage the membership of groups for which they’re an owner and approve requests from other users to join their groups. |
| Users can create Microsoft 365 groups in the Azure portal, API, or PowerShell. | Yes | All users in your Microsoft Entra organization are allowed to create new Microsoft 365 groups and add members to these groups in the Azure portal, API, or PowerShell. These new groups also show up in the Access Panel for all other users. If the policy setting on the group allows it, other users can create requests to join these groups. |
|  | No | Users can’t create M365 Groups. They can still manage the membership of groups for which they’re an owner and approve requests from other users to join their groups. |

Here are some more details about these group settings:

- These settings can take up to 15 minutes to take effect.
- If you want to enable some, but not all, of your users to create groups, you can assign those users a role that can create groups, such as [Groups Administrator](~/identity/role-based-access-control/permissions-reference.md#groups-administrator).
- These settings are for users and don't affect service principals. For example, if you had a service principal with permissions to create groups, even if you set these settings to **No**, the service principal can still create groups.

## Configure group settings by using Microsoft Graph

To configure the **Users can create Microsoft 365 groups in Azure portals, API or PowerShell** setting by using Microsoft Graph, configure the `EnableGroupCreation` object in the `groupSettings` object. For more information, see [Overview of group settings](/graph/group-directory-settings).

To configure the **Users can create security groups in Azure portals, API or PowerShell** setting by using Microsoft Graph, update the `allowedToCreateSecurityGroups` property of `defaultUserRolePermissions` in the [authorizationPolicy](/graph/api/resources/authorizationpolicy) object.

## Next steps

For more information on Microsoft Entra ID, see:

* [Manage access to resources with Microsoft Entra groups](~/fundamentals/concept-learn-about-groups.md)
* [Microsoft Entra cmdlets for configuring group settings](~/identity/users/groups-settings-cmdlets.md)
* [Application management in Microsoft Entra ID](~/identity/enterprise-apps/what-is-application-management.md)
* [What is Microsoft Entra ID?](~/fundamentals/whatis.md)
* [Integrate your on-premises identities with Microsoft Entra ID](~/identity/hybrid/whatis-hybrid-identity.md)

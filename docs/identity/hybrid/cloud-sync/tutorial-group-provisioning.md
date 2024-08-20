---
title: 'Tutorial - Provision groups to Active Directory using Microsoft Entra Cloud Sync'
description: This tutorial shows how to setup and configure Microsoft Entra Cloud Sync's Group Provision to AD with cloud sync.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 04/26/2024
ms.subservice: hybrid-cloud-sync
ms.author: billmath
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---

# Tutorial - Provision groups to Active Directory using Microsoft Entra Cloud Sync

This tutorial walks you through creating and configuring cloud sync to synchronize groups to on-premises Active Directory. 

[!INCLUDE [pre-requisites](../includes/gpad-prereqs.md)]

## Assumptions
This tutorial assumes the following:
- You have an Active Directory on-premises environment
- You have cloud sync setup to synchronize users to Microsoft Entra ID.
- You have two users that are synchronized.  Britta Simon and Lola Jacobson.  These users exist on-premises and in Microsoft Entra ID.
- Three Organizational Units have been created in Active Directory - Groups, Sales, and Marketing.  They have the following distinguishedNames:  
 - OU=Marketing,DC=contoso,DC=com
 - OU=Sales,DC=contoso,DC=com
 - OU=Groups,DC=contoso,DC=com

## Create two groups in Microsoft Entra ID.
To begin, we create two groups in Microsoft Entra ID.  One group is Sales and the other is Marketing.

To create two groups, follow these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Identity** > **Groups** > **All groups**.
3.  At the top, click **New group**.
4.  Make sure the **Group type** is set to **security**.
5.  For the **Group Name** enter **Sales**
6.  For **Membership type** keep it at assigned.
7.  Click **Create**.
8.  Repeat this process using **Marketing** as the **Group Name.**


## Add users to the newly created groups
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Identity** > **Groups** > **All groups**.
3. At the top, in the search box, enter **Sales**.
4. Click on the new **Sales** group.
5. On the left, click **Members**
6. At the top, click **Add members**.
7. At the top, in the search box, enter **Britta Simon**.
8. Put a check next to **Britta Simon** and click **Select**
9. It should successfully add her to the group.
10. On the far left, click **All groups** and repeat this process using the **Sales** group and adding **Lola Jacobson** to that group.


## Configure provisioning
To configure provisioning, follow these steps.

   [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]
   3. Select **New configuration**.
   4. Select **Microsoft Entra ID to AD sync**.
   :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

   5. On the configuration screen, select your domain and whether to enable password hash sync. Click **Create**. 
    :::image type="content" source="media/how-to-configure/new-ux-configure-2.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-2.png":::

   6. The **Get started** screen opens. From here, you can continue configuring cloud sync
   7. On the left, click **Scoping filters**.
   8. Under **Group scope** set it to **All Security groups**
   9.  Under **Target container** click **Edit attribute mapping**.
     :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png" alt-text="Screenshot of the scoping filters sections." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png":::

   10.  Change **Mapping type** to **Expression**
   11. In the expression box, enter the following:
     ```Switch([displayName],"OU=Groups,DC=contoso,DC=com","Marketing","OU=Marketing,DC=contoso,DC=com","Sales","OU=Sales,DC=contoso,DC=com") ```
   12. Change the **Default value** to be OU=Groups,DC=contoso,DC=com.
     :::image type="content" source="media/tutorial-group-provision/group-provision-2.png" alt-text="Screenshot of the scoping filters expression." lightbox="media/tutorial-group-provision/group-provision-2.png":::

   13. Click **Apply** - This changes the target container depending on the group displayName attribute.
   14. Click **Save**
   15. On the left, click **Overview**
   16. At the top, click **Review and enable**
   17. On the right, click **Enable configuration**


## Test configuration 
>[!NOTE]
>When using on-demand provisioning, members aren't automatically provsisioned. You need to select which members you wish to test on and there's a 5 member limit.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Enter **Sales** in the **Selected group** box
 6. From the **Selected users** section, select some users to test.
   :::image type="content" source="media/tutorial-group-provision/group-provision-1.png" alt-text="Screenshot of adding members." lightbox="media/tutorial-group-provision/group-provision-1.png":::

 7. Click **Provision**.
 8. You should see the group provisioned.
 
   :::image type="content" source="media/tutorial-group-provision/group-provision-3.png" alt-text="Screenshot of successful provisioning on demand." lightbox="media/tutorial-group-provision/group-provision-3.png":::

## Verify in Active Directory
Now you can make sure the group is provisioned to Active Directory.

Do the following:

1.  Sign-in to your on-premises environment.
2.  Launch **Active Directory Users and Computers**
3.  Verify the new group is provisioned.
   :::image type="content" source="media/tutorial-group-provision/group-provision-4.png" alt-text="Screenshot of the newly provisioned group." lightbox="media/tutorial-group-provision/group-provision-4.png":::



## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)

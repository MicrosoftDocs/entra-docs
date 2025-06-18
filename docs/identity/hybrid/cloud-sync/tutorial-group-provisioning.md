---
title: 'Tutorial - Provision groups to Active Directory using Microsoft Entra Cloud Sync'
description: This tutorial shows how to setup and configure Microsoft Entra Cloud Sync's Group Provision to AD with cloud sync.
author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: billmath
ms.custom: no-azure-ad-ps-ref, sfi-image-nochange
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
2. Browse to **Entra ID** > **Groups** > **All groups**.
3.  At the top, click **New group**.
4.  Make sure the **Group type** is set to **security**.
5.  For the **Group Name** enter **Sales**
6.  For **Membership type** keep it at assigned.
7.  Click **Create**.
8.  Repeat this process using **Marketing** as the **Group Name.**


## Add users to the newly created groups
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Entra ID** > **Groups** > **All groups**.
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




## How GPAD behaves with SOA converted groups

When you flip the **Source of Authority (SOA)** to cloud for an on-prem
group, that group becomes eligible for **Group Provisioning to Active Directory (GPAD)**.

- If you are running **Sync All**, then the group will automatically
  come into scope for Group Provisioning to AD.

- If you are running **Sync Selected**, then you must manually select
  the SOA-flipped group.

### Known issue

- If you sync a group which is not universal, i.e global group and then
  try to flip SOA and then run a GPAD job on that, then it will give an
  Entry level error. Make sure the group has universal scope.  

  <img src="media/tutorial-group-provisioning/image25.png" style="width:3.37517in;height:3.46546in"
  alt="A screenshot of a computer AI-generated content may be incorrect." />

### Use GPAD to provision groups to AD

**Example: SOAGroup2 Provisioning**

In the diagram below, **SOATestGroup1** has been flipped to the cloud.
As a result, it has become available for the **GPAD job scope**.

<img src="media/tutorial-group-provisioning/image26.jpg" style="width:5in;height:5.30208in"
alt="A screenshot of a group AI-generated content may be incorrect." />

- When a **GPAD job** runs, the SOA-converted group is provisioned
  successfully.

- In the **Provisioning Logs**, you can search for the group name and
  verify that the group was provisioned.

<img src="media/tutorial-group-provisioning/image27.jpg" style="width:6.5in;height:1.16667in"
alt="A screenshot of a chat AI-generated content may be incorrect." />

- The details will show that the group was matched with an existing
  target group.

<img src="media/tutorial-group-provisioning/image28.jpg" style="width:6.5in;height:5.47917in"
alt="A screenshot of a computer AI-generated content may be incorrect." />

- Additionally, you can confirm that the **Admin Description** and **CN
  (Common Name)** of the target group have been updated.

<img src="media/tutorial-group-provisioning/image29.jpg" style="width:6.5in;height:3.52083in"
alt="A screenshot of a computer AI-generated content may be incorrect." />

- When you look at AD, you can find that the Original AD group has been
  updated.

> <img src="media/tutorial-group-provisioning/image30.jpg" style="width:3.54167in;height:3.75in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

<img src="media/tutorial-group-provisioning/image31.png" style="width:5.45381in;height:4.00035in"
alt="A screenshot of a computer AI-generated content may be incorrect." />


### Status of attributes after SOA switch

The following table explains the status for **isCloudManaged** and **dirSyncEnabled** attributes when an admin acts to switch the source of authority (SOA) of an object.

Admin step | isCloudManaged value | dirSyncEnabled value | Description  
-----|----------------------|----------------------|------------
Admin syncs an object from AD to Microsoft Entra ID | `false` | `true` | When an object is originally synchronized to Microsoft Entra ID, the **dirSyncEnabled** attribute is set to` true` and **isCloudManaged** is set to `false`.  
Admin switches the source of authority (SOA) of the object to the cloud | `true` | `null` | After an admin switches the SOA of an object to the cloud, the **isCloudManaged** attribute becomes set to `true` and the **dirSyncEnabled** attribute value is set to `null`. 
Admin rolls back the SOA operation | `false` | `null` | If an admin switches the SOA back to AD, the **isCloudManaged** is set to `false` and **dirSyncEnabled** is set to `null` until the sync client takes over the object.    

### Roll back group soa and group provision to AD

- Flip back the SOA of the group SOATestGroup1.

<!-- -->

- When SOA transfer is rolled back to on-prem, **Group Provisioning to
  AD** (GPAD) stops syncing changes without deleting the on-prem group.
  It also removes the group from GPAD configuration scope. The on-prem
  group remains intact and resumes control in the next sync cycle.

<!-- -->

- You can verify in audit logs that sync will not happen for this object
  as it is managed on premises. Further you can go and check in AD that
  the group is still intact and is not deleted.  
  <img src="media/tutorial-group-provisioning/image32.png" style="width:4.4375in;height:2.84375in"
  alt="A screenshot of a computer AI-generated content may be incorrect." />  
    
  <img src="media/tutorial-group-provisioning/image33.png" style="width:5.40625in;height:4.81711in"
  alt="A screenshot of a computer AI-generated content may be incorrect." />


## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)

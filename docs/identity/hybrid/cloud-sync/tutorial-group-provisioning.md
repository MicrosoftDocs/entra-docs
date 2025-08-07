---
title: 'Tutorial - Provision groups to Active Directory Domain Services (AD DS) by using Microsoft Entra Cloud Sync'
description: This tutorial shows how to set up and configure Microsoft Entra Cloud Sync to provision groups to Active Directory Domain Services (AD DS).
author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: how-to
ms.date: 08/04/2025
ms.subservice: hybrid-cloud-sync
ms.author: jomondi
ms.custom: no-azure-ad-ps-ref, sfi-image-nochange
---

# Tutorial - Provision groups to Active Directory Domain Services by using Microsoft Entra Cloud Sync

This tutorial walks you through how to configure Cloud Sync to sync groups to on-premises Active Directory Domain Services (AD DS). 

> [!IMPORTANT]
> We recommend using **Selected security groups** as the default scoping filter when you configure group provisioning to AD DS. This default scoping filter helps prevent any performance issues when you provision groups.  

[!INCLUDE [pre-requisites](../includes/gpad-prereqs.md)]

## Assumptions
This tutorial assumes:
- You have an AD DS on-premises environment
- You have cloud sync setup to synchronize users to Microsoft Entra ID.
- You have two users that are synchronized: Britta Simon and Lola Jacobson. These users exist on-premises and in Microsoft Entra ID.
- An organizational unit (OU) is created in AD DS for each of the following departments:

  Display name | Distinguished name
  -------------|-------------------
  Groups       | OU=Marketing,DC=contoso,DC=com
  Sales        | OU=Sales,DC=contoso,DC=com
  Marketing    | OU=Groups,DC=contoso,DC=com


## Add users to cloud-native or Source of Authority (SOA) converted security groups

To add synced users, follow these steps:

>[!NOTE]
>Only synced user member references are provisioned to AD DS. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Entra ID** > **Groups** > **All groups**.
3. At the top, in the search box, enter **Sales**.
4. Select the new **Sales** group.
5. On the left, select **Members**.
6. At the top, select **Add members**.
7. At the top, in the search box, enter **Britta Simon**.
8. Put a check next to **Britta Simon** and select **Select**.
9. It should successfully add the user to the group.
10. On the far left, select **All groups**. Repeat this process by using the **Sales** group, and add **Lola Jacobson** to that group.

## Configure provisioning

To configure provisioning, follow these steps:

   [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]
   3. Select **New configuration**.
   4. Select **Microsoft Entra ID to AD sync**.

      :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

   5. On the configuration screen, select your domain and whether to enable password hash sync. Select **Create**. 

      :::image type="content" source="media/how-to-configure/new-ux-configure-2.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-2.png":::

   6. The **Get started** screen opens. From here, you can continue configuring cloud sync.
   7. On the left, select **Scoping filters**.
   8. For **Groups scope**, select **Selected security groups**.

      :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png" alt-text="Screenshot of the scoping filters sections." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png":::

   9. There are two possible approaches to set the OU:

      - You can preserve the original OU path from on-premises. With this approach, you need to set the attribute mapping based on an extensionAttribute value. For more information, see [Preserve the original OU path](how-to-preserve-original-organizational-unit.md).
   
      Or

      - Under **Target container** select **Edit attribute mapping**.

   10. Change **Mapping type** to **Expression**.
   11. In the expression box, enter:

       ```Switch([displayName],"OU=Groups,DC=contoso,DC=com","Marketing","OU=Marketing,DC=contoso,DC=com","Sales","OU=Sales,DC=contoso,DC=com") ```

   12. Change the **Default value** to be `OU=Groups,DC=contoso,DC=com`.

       :::image type="content" source="media/tutorial-group-provision/change-default.png" alt-text="Screenshot of how to change the default value of the OU." lightbox="media/tutorial-group-provision/change-default.png":::

   13. Select **Apply** - This changes the target container depending on the group displayName attribute.
   14. Select **Save**.
   15. On the left, select **Overview**.
   16. At the top, select **Review and enable**.
   17. On the right, select **Enable configuration**.


## Test configuration 
>[!NOTE]
>When you run on-demand provisioning, members aren't automatically provisioned. You need to select the members you want to test, and the limit is five members.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Enter **Sales** in the **Selected group** box.
 6. From the **Selected users** section, select some users to test.
    
    :::image type="content" source="media/tutorial-group-provision/select-user.png" alt-text="Screenshot of adding members." lightbox="media/tutorial-group-provision/select-user.png":::

 7. Select **Provision**.
 8. You should see the group provisioned.
 
   :::image type="content" source="media/tutorial-group-provision/success.png" alt-text="Screenshot of successful provisioning on demand." lightbox="media/tutorial-group-provision/success.png":::

## Verify in AD DS

Follow these steps to make sure the group is provisioned to AD DS:

1.  Sign in to your on-premises environment.
2.  Launch **Active Directory Users and Computers**.
3.  Verify the new group is provisioned.

    :::image type="content" source="media/tutorial-group-provision/verify.png" alt-text="Screenshot of the newly provisioned group." lightbox="media/tutorial-group-provision/verify.png":::

## Group provision to AD DS behavior for SOA converted objects

When you convert the Source of Authority (SOA) to cloud for an on-premises group, that group becomes eligible for group provisioning to AD DS.

For example, in the following diagram, the SOA or **SOATestGroup1** is converted to the cloud.
As a result, it becomes available for the job scope in group provisioning to AD DS.

:::image type="content" border="true" source="media/tutorial-group-provision/group-scope.png" alt-text="Screenshot of job in scope." lightbox="media/tutorial-group-provision/group-scope.png":::

- When a job runs, **SOATestGroup1** is provisioned successfully.

- In the **Provisioning logs**, you can search for **SOATestGroup1** and verify that the group was provisioned.

  :::image type="content" border="true" source="media/tutorial-group-provision/provisioning-logs.png" alt-text="Screenshot of the Provisioning logs." lightbox="media/tutorial-group-provision/provisioning-logs.png":::

- The details show that **SOATestGroup1** was matched with an existing target group.

  :::image type="content" border="true" source="media/tutorial-group-provision/matched.png" alt-text="Screenshot of matched attributes." lightbox="media/tutorial-group-provision/matched.png":::

- You can also confirm that the **adminDescription** and **cn** of the target group are updated.

  :::image type="content" border="true" source="media/tutorial-group-provision/confirm-updates.png" alt-text="Screenshot of updated attributes." lightbox="media/tutorial-group-provision/confirm-updates.png":::

- When you look at AD DS, you can find that the original group is updated.

  :::image type="content" border="true" source="media/tutorial-group-provision/updated-group.png" alt-text="Screenshot of the updated group." lightbox="media/tutorial-group-provision/updated-group.png":::

  :::image type="content" border="true" source="media/tutorial-group-provision/group-properties.png" alt-text="Screenshot of group properties." lightbox="media/tutorial-group-provision/group-properties.png":::

## Cloud skips provisioning converted SOA objects to Microsoft Entra ID 

If you try to edit an attribute of a group in AD DS after you convert SOA to the cloud, Cloud Sync skips the object during provisioning.

Let's say we have a group **SOAGroup3**, and we update its group name to **SOA Group3.1**.

:::image type="content" border="true" source="media/tutorial-group-provision/update-group-name.png" alt-text="Screenshot of an object name update.":::

In the **Provisioning Logs**, you can see that **SOAGroup3 was skipped**.

:::image type="content" border="true" source="media/tutorial-group-provision/skipped.png" alt-text="Screenshot of a skipped object.":::

The details explain that the object isn't synced because its SOA is converted to the cloud.

:::image type="content" border="true" source="media/tutorial-group-provision/sync-blocked.png" alt-text="Screenshot of a blocked sync.":::

### Nested groups and membership references handling

The following table explains how the provisioning handles membership references after you convert SOA in different use cases.

Use case | Parent group type | Member group type | Job | How sync works
---------|-------------------|-------------------|-----|-----------------------
A Microsoft Entra parent security group has only Microsoft Entra members. | Microsoft Entra security group |Microsoft Entra security group |AAD2ADGroupProvisioning (group provisioning to AD DS) | The job provisions the parent group with all its member references (member groups).
A Microsoft Entra parent security group has some members that are synced groups. |Microsoft Entra security group |AD DS security groups (synced groups)| AAD2ADGroupProvisioning (group provisioning to AD DS)| The job provisions the parent group, but all the member references (member Groups) that are AD DS groups aren't provisioned.
A Microsoft Entra parent security group has some members that are synced groups whose SOA is converted to cloud. |Microsoft Entra security group | AD DS security groups whose SOA is converted to cloud. |AAD2ADGroupProvisioning (group provisioning to AD DS)| The job provisions the parent group with all its member references (member groups).
You convert the SOA of a synced group (parent) that has cloud-owned groups as members. | AD DS security groups with SOA converted to cloud | Microsoft Entra security group| AAD2ADGroupProvisioning (group provisioning to AD DS)| The job provisions the parent group with all its member references (member groups).
You convert the SOA of a synced group (parent) that has other synced groups as members. |AD DS security groups with SOA converted to cloud| AD DS security groups (synced groups) | AAD2ADGroupProvisioning (group provisioning to AD DS) |The job provisions the parent group, but all the member references (member Groups) that are AD DS security groups aren't provisioned.
You convert the SOA of a synced group (parent) whose members are other synced groups that have SOA converted to cloud. | AD DS security groups with SOA converted to cloud | AD DS security groups with SOA converted to cloud | AAD2ADGroupProvisioning (group provisioning to AD DS) | The job provisions the parent group with all its member references (member groups).

## Group provision to AD DS behavior after you roll back SOA converted groups

If you have SOA converted groups in scope and you roll back the SOA converted group to make it owned by AD DS, group provisioning to AD DS stops syncing the changes, but it doesn't delete the on-premises group. It also removes the group from configuration scope. On-premises control of the group resumes in the next sync cycle.

- You can verify in the Audit Logs that sync doesn't happen for this object because it's managed on-premises. 
  
  :::image type="content" border="true" source="media/tutorial-group-provision/audit-log-details.png" alt-text="Screenshot of Audit log details." lightbox="media/tutorial-group-provision/audit-log-details.png":::

  You can also check in AD DS that the group is still intact and not deleted.  

  :::image type="content" border="true" source="media/tutorial-group-provision/users-and-computers.png" alt-text="Screenshot of Users and Computers." lightbox="media/tutorial-group-provision/users-and-computers.png":::

## Next steps 
- [Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises AD DS based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)

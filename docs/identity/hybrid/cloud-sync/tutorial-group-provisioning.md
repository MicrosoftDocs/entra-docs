---
title: 'Tutorial - Provision groups to Active Directory Domain Services (AD DS) by using Microsoft Entra Cloud Sync'
description: This tutorial shows how to set up and configure Microsoft Entra Cloud Sync to provision groups to Active Directory Domain Services (AD DS).
ms.topic: how-to
ms.date: 11/26/2025
ms.subservice: hybrid-cloud-sync
ms.custom: no-azure-ad-ps-ref, sfi-image-nochange
---

# Tutorial - Provision groups to Active Directory Domain Services by using Microsoft Entra Cloud Sync

This tutorial walks you through how to configure Cloud Sync to sync groups to on-premises Active Directory Domain Services (AD DS). 

> [!IMPORTANT]
> We recommend using **Selected security groups** as the default scoping filter when you configure group provisioning to AD DS. This default scoping filter helps prevent any performance issues when you provision groups.  

[!INCLUDE [pre-requisites](../includes/gpad-prereqs.md)]

## Group and User SOA Scenarios

Use case | Parent group type | User member group type | Sync Direction | How sync works 
----------|--------------------|-------------------------|----------------|----------------
A security group whose SOA is in **cloud** and **all user members** have SOA **on-premises** | Security group whose SOA is in cloud | Users whose SOA is on-premises | **Entra to AD (AAD2ADGroup provisioning)** | The job provisions the parent group with all its member references (member users). 
A security group whose SOA is in **cloud** and **all user members** have SOA **in cloud** | Security group whose SOA is in cloud | Users whose SOA is in cloud | **Entra to AD (AAD2ADGroup provisioning)** | The job provisions the security group but does not provision any member references. 
A security group whose SOA is in **cloud** and **some user members** have SOA **in cloud** while others have SOA **on-premises** | Security group whose SOA is in cloud | Some users have SOA in cloud while some have SOA on-premises | **Entra to AD (AAD2ADGroup provisioning)** | The job provisions the security group and includes only member references whose SOA is on-premises. It skips member references whose SOA is in cloud. 
A security group whose SOA is in **cloud** and has **no user members** | Security group whose SOA is in cloud | No user members | **Entra to AD (AAD2ADGroup provisioning)** | The job provisions the security group (empty membership). 
A security group whose SOA is in **on-premises** and **all user members** have SOA **on-premises** | Security group whose SOA is on-premises | Users whose SOA is on-premises | **Entra to AD (AAD2ADGroup provisioning)** | The job does **not** provision the security group. 
A security group whose SOA is in **on-premises** and **all user members** have SOA in **cloud** | Security group whose SOA is on-premises | Users whose SOA is in cloud | **Entra to AD (AAD2ADGroup provisioning)** | The job does **not** provision the security group. 
A security group whose SOA is in **on-premises** and some **user members** have SOA in **cloud** while others have SOA **on-premises** | Security group whose SOA is on-premises | Some users have SOA in cloud while some have SOA on-premises | **Entra to AD (AAD2ADGroup provisioning)** | The job does **not** provision the security group. 
A security group whose SOA is in **on-premises** and **all user members** have SOA **on-premises** | Security group whose SOA is on-premises | Users whose SOA is on-premises | **AD to Entra (AD2AADprovisioning)** | The job provisions the security group with all its member references (member users). 
A security group whose SOA is in **on-premises** and **all user members** have SOA in **cloud** | Security group whose SOA is on-premises | Users whose SOA is in cloud | **AD to Entra (AD2AADprovisioning)** | The job provisions the security group with all its member references (member users). So member references whose SOA is converted to cloud for these on-prem groups will also be synced. 
A security group whose SOA is in **on-premises** and **some user members** have SOA in **cloud** while others have SOA **on-premises** | Security group whose SOA is on-premises | Some users have SOA in cloud while some have SOA on-premises | **AD to Entra (AD2AADprovisioning)** | The job provisions the parent group with all its member references (member users). So member references whose SOA is converted to cloud for these on-prem groups will also be synced.
A security group whose SOA is in **on-premises** and has **no user members** | Security group whose SOA is on-premises | No user members | **AD to Entra (AD2AADprovisioning)** | The job provisions the security group (empty membership). 
A security group whose SOA is in **cloud** and **all user members** have SOA **on-premises** | Security group whose SOA is cloud | Users whose SOA is on-premises | **AD to Entra (AD2AADprovisioning)** | The job does **not** provision the security group. 
A security group whose SOA is in **cloud** and **all user members** have SOA in **cloud** | Security group whose SOA is cloud | Users whose SOA is in cloud | **AD to Entra (AD2AADprovisioning)** | The job does **not** provision the security group. 
A security group whose SOA is in **cloud** and **some user members** have SOA in **cloud** while others have SOA **on-premises** | Security group whose SOA is cloud | Some users have SOA in cloud while some have SOA on-premises | **AD to Entra (AD2AADprovisioning)** | The job does **not** provision the security group. 


## Assumptions
This tutorial assumes:
- You have an AD DS on-premises environment
- You have cloud sync setup to synchronize users to Microsoft Entra ID.
- You have two users that are synchronized: Britta Simon and Lola Jacobson. These users exist on-premises and in Microsoft Entra ID.
- An organizational unit (OU) is created in AD DS for each of the following departments:

  Display name | Distinguished name
  -------------|-------------------
  Marketing    | OU=Marketing,DC=contoso,DC=com
  Sales        | OU=Sales,DC=contoso,DC=com
  Groups       | OU=Groups,DC=contoso,DC=com


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

[!INCLUDE [pre-requisites](../includes/prepare-converted-groups.md)]

## Configure provisioning

To configure provisioning, follow these steps:

   [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]
   
   3. Select **New configuration**.
   4. Select **Microsoft Entra ID to AD sync**.

      :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

   5. On the configuration screen, select your domain. Select **Create**.

      :::image type="content" source="media/how-to-configure/new-ux-configure-19.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-19.png":::

   6. The **Get started** screen opens. From here, you can continue configuring cloud sync.
   7. On the left, select **Scoping filters**.

      :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-2.png" alt-text="Screenshot Overview page." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-2.png":::
   
   8. For **Groups scope**, select **Selected security groups**.

      :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png" alt-text="Screenshot of the scoping filters sections." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-3.png":::

   9. There are three possible approaches to set the target OU where the groups are provisioned:

      - You can use a constant OU mapping to provision all groups in the same OU:

        1. Under **Target container**, select **Edit attribute mapping**.
        2. For **Constant value** enter the DistinguishedName for the target OU.

           :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-12.png" alt-text="Screenshot of target OU configuration." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-12.png":::
        3. Select **Apply**.
        4. Select **Save**.
           
      - You can use custom expressions to ensure the group is re-created with the same OU. This expression can strip the CN portion of the Group's DN and preserve the parent DN path, handling escaped commas, and provide a default OU if the extension value is empty. Use the following expression for `ParentDistinguishedName` mapping by adapting the sample expression, or by running the PowerShell script to generate the final expression.

        >[!NOTE]
        >This expression assumes you have already created an extension property for GroupDN. If not, please do that first before using the sample expression or running the script.
        
        1. From the following sample expression, replace the placeholders with your respective values for your extension attribute name `extension_<AppIdWithoutHyphens>_GroupDN`. For your default target OU (in case the extension value is `NULL`), replace the `<Default ParentDistinguishedName>` :
        
        ```
        IIF(
            IsPresent([extension_<AppIdWithoutHyphens>_GroupDN]),
            Replace(
                Mid(
                    Mid(
                        Replace([extension_<AppIdWithoutHyphens>_GroupDN], "\,", , , "\2C", , ),
                        Instr(Replace([extension_<AppIdWithoutHyphens>_GroupDN], "\,", , , "\2C", , ), ",", , ),
                        9999
                    ),
                    2,
                    9999
                ),
                "\2C", , , ",", ,
            ),
        "<Default ParentDistinguishedName>"
        )
        ```
        
        2. Or, provide the value for the `$defaultGroupOU` parameter and execute the script to generate the final expression as a text file:
      
        ```PowerShell
        # Provide the Default OU for groups that don't have the GroupDN extension populated.
        $defaultGroupOU = 'OU=Groups,OU=SYNC,DC=adatum,DC=com'

        # Get the extension name
        $tenantId = (Get-MgOrganization).Id
        $app = Get-MgApplication -Filter "identifierUris/any(uri:uri eq 'API://$tenantId/CloudSyncCustomExtensionsApp')" 
        $ext = Get-MgApplicationExtensionProperty -ApplicationId $app.Id | Where-Object { $_.Name -like '*GroupDN' }
        $groupDN_extension = $ext.Name
        "GroupDN extension name: $groupDN_extension"
        
        # Sample expression
        $groupDN_expression = @'
        IIF(
        IsPresent([{groupDN_extension}]),
            Replace(
                Mid(
                    Mid(
                        Replace([{groupDN_extension}], "\,", , , "\2C", , ),
                        Instr(Replace([{groupDN_extension}], "\,", , , "\2C", , ), ",", , ),
                        9999
                    ),
                    2,
                    9999
                ),
                "\2C", , , ",", ,
            ),
            "{defaultGroupOU}"
        )
        '@
        
        # Generate the expression by replacing the placeholders with actual values
        $groupDN_expression -replace ('{groupDN_extension}', $groupDN_extension) -replace ('{defaultGroupOU}', $defaultGroupOU) | 
            Out-File -FilePath '.\GroupDN_expression.txt' -Encoding utf8
        &'.\GroupDN_expression.txt'
        ```

        3. Change **Mapping type** to **Expression**.
        4. In the expression box, insert the updated expression and Select **Apply**.
        5. Select **Save**.

      - If you want to place groups into different organizational units based on their DisplayName:

        1. Adapt the following expression and place it in expression box:

           ```
           Switch([displayName],"OU=Groups,DC=contoso,DC=com","Marketing","OU=Marketing,DC=contoso,DC=com","Sales","OU=Sales,DC=contoso,DC=com")
           ```

        2. Update the **Default value** to be the default target OU, for example, `OU=Groups,DC=contoso,DC=com`.

           :::image type="content" source="media/tutorial-group-provision/change-default.png" alt-text="Screenshot of how to change the default value of the OU." lightbox="media/tutorial-group-provision/change-default.png":::

        3. Select **Apply**. The target container changes depending on the group displayName attribute.
        4. Select **Save**.

        >[!NOTE]
        >These changes cause a full sync and don’t affect existing groups. Test setting the GroupDN attribute for an existing group using Microsoft Graph and ensure that it writes back to original OU.

   10. You can use a custom expression to ensure the group is re-created with the same CommonName (CN). This expression can extract the CN value, handling escaped commas by temporarily replacing them with hex values, and provide a fallback CN from DisplayName + ObjectId if the extension is empty. Use the following expression for `cn` mapping by adapting the sample expression, or by running the PowerShell script to generate the final expression.

        > [!NOTE]
        > This expression assumes you have already created an extension property for GroupDN. If not, do that first before using the sample expression or running the script.
        
        1. If you want to adapt a sample expression, replace the placeholders with your respective values for your extension attribute name `extension_<AppIdWithoutHyphens>_GroupDN`. 
      
        ```
        IIF(
           IsPresent([extension_<AppIdWithoutHyphens>_GroupDN]),
               Replace(
                   Replace(
                       Replace(
                           Word(Replace([extension_<AppIdWithoutHyphens>_GroupDN], "\,", , , "\2C", , ), 1, ","),
                           "CN=", , , "", ,
                       ),
                       "cn=", , , "", ,
                   ),
                   "\2C", , , ",", ,
               ),
           Append(Append(Left(Trim([displayName]), 51), "_"), Mid([objectId], 25, 12))
        )
        ```
        
        2. Or, if you want to use a Microsoft Graph PowerShell script:

        ```PowerShell
        # Get the extension name
        $tenantId = (Get-MgOrganization).Id
        $app = Get-MgApplication -Filter "identifierUris/any(uri:uri eq 'API://$tenantId/CloudSyncCustomExtensionsApp')" 
        $ext = Get-MgApplicationExtensionProperty -ApplicationId $app.Id | Where-Object { $_.Name -like '*GroupDN' }
        $groupDN_extension = $ext.Name
        "GroupDN extension name: $groupDN_extension"
        
        # Sample expression
        $groupCN_expression = @'
        IIF(
            IsPresent([{groupDN_extension}]),
            Replace(
                Replace(
                    Replace(
                        Word(Replace([{groupDN_extension}], "\,", , , "\2C", , ), 1, ","),
                        "CN=", , , "", ,
                    ),
                    "cn=", , , "", ,
                ),
                "\2C", , , ",", ,
            ),
            Append(Append(Left(Trim([displayName]), 51), "_"), Mid([objectId], 25, 12))
        )
        '@
        
        # Generate the expression by replacing the placeholders with actual values
        $groupCN_expression -replace ('{groupDN_extension}', $groupDN_extension) | 
            Out-File -FilePath '.\GroupCN_expression.txt' -Encoding utf8
        &'.\GroupCN_expression.txt'
        ```

        3. Go to **Attribute mapping**
        4. Edit the `cn` attribute mapping
        5. Change **Mapping type** to **Expression**.
        6. In the expression box, insert the updated expression and select **Apply**.
        7. Select **Save schema**.
   
   11. On the left, select **Overview**.
   12. At the top, select **Review and enable**.
   13. On the right, select **Enable configuration**.


## Test configuration 
>[!NOTE]
>When you run on-demand provisioning, members aren't automatically provisioned. You need to select the members you want to test, and the limit is five members. If you want to test after removing a member, select **View all users** and then select the member(s) that have been removed from the group.

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
- [Group writeback with Microsoft Entra Cloud Sync](../group-writeback-cloud-sync.md)
- [Govern on-premises AD DS based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)

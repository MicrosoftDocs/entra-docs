---
title: Scenario - Using directory extensions with group provisioning to Active Directory
description: This topic describes how to extend the schema of a group with a new attribute. Then use the new attribute to filter groups for provisioning to Active Directory.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: tutorial
ms.date: 04/26/2024
ms.subservice: hybrid-cloud-sync
ms.author: billmath

---

# Scenario - Using directory extensions with group provisioning to Active Directory

Scenario: You have hundreds of groups in Microsoft Entra ID. You want to provision some of these groups but not all back to Active Directory. You would like a quick filter that can be applied to groups without having to make a more complicated scoping filter.

 :::image type="content" source="../media/common-scenarios/group-writeback-1.png" alt-text="Diagram of group writeback with cloud sync." lightbox="../media/common-scenarios/group-writeback-1.png":::

You can use the environment you create in this scenario for testing or for getting more familiar with cloud sync.

## Assumptions

- This scenario assumes that you already have a working environment that is synchronizing users to Microsoft Entra ID.
- We have 4 users that are synchronized. Britta Simon, Lola Jacobson, Anna Ringdahl, and John Smith.
- Three organizational Units have been created in Active Directory - Sales, Marketing, and Groups
- The Britta Simon and Anna Ringdahl user accounts reside in the Sales OU.
- The Lola Jacobson and John Smith user accounts reside in the Marketing OU.
- The Groups OU is where our groups from Microsoft Entra ID are provisioned.

## Create two groups in Microsoft Entra ID
To begin, create two groups in Microsoft Entra ID. One group is Sales and the Other is Marketing.

To create two groups, follow these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Identity** > **Groups** > **All groups**.
3. At the top, click **New group**.
4. Make sure the **Group type** is set to **security**.
5. For the **Group Name** enter **Sales**
6. For **Membership type** keep it at assigned.
7. Click **Create**.
8. Repeat this process using **Marketing** as the **Group Name.**


## Add users to the newly created groups
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Identity** > **Groups** > **All groups**.
3. At the top, in the search box, enter **Sales**.
4. Click on the new **Sales** group.
5. On the left, click **Members**
6. At the top, click **Add members**.
7. At the top, in the search box, enter **Britta Simon**.
8. Put a check next to **Britta Simon** and **Anna Ringdahl** and click **Select**
9. It should successfully add her to the group.
10. On the far left, click **All groups** and repeat this process using the **Marketing** group and adding **Lola Jacobson** and **John Smith** to that group.

>[!NOTE]
> When adding users to the Marketing group, make note of the group ID on the overview page. This ID is used later to add our newly created property to the group.

## Get your tenant ID
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
2. Browse to **Identity** > **Overview**.
3. Note your tenant ID and copy it down for use later.

## Create the CloudSyncCustomExtensionApp and service principal
>[!Important]
> Directory extension for Microsoft Entra Cloud Sync is only supported for applications with the identifier URI “api://&LT;tenantId&GT;/CloudSyncCustomExtensionsApp” and the [Tenant Schema Extension App](../connect/how-to-connect-sync-feature-directory-extensions.md#configuration-changes-in-azure-ad-made-by-the-wizard) created by Microsoft Entra Connect. 

 1. On an on-premises machine, open PowerShell with Administrative privileges
 2. To set the execution policy, run (press [A] Yes to all when prompted):

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
 3. To install the v1 module of the SDK in PowerShell Core or Windows PowerShell, run the following command. Press [Y] Yes when prompted.

   ```powershell
   Install-Module Microsoft.Graph -Scope CurrentUser
   ```
 4. Connect to your tenant (Be sure to accept on-behalf of when signing in)

   ```powershell
   Connect-MgGraph -Scopes "Application.ReadWrite.All", "Group.ReadWrite.All", "User.ReadWrite.All"
   ```
 5. Check to see if the CloudSyncCustomExtensionApp exists.
   
   ```powershell
   Get-MgApplication -Filter "identifierUris/any(uri:uri eq 'api://<tenantId>/CloudSyncCustomExtensionsApp')"
   ```
 6. If it exists, note the **appId** and skip to step 8. Otherwise, create the app.
 7. Create the CloudSyncCustomExtensionApp. Replace &lt;tenant ID&gt; with your tenant ID. Copy the ID and App ID that appears after creation. 
  
   ```powershell
   New-MgApplication -DisplayName "CloudSyncCustomExtensionsApp" -IdentifierUris "api://<tenant ID>/CloudSyncCustomExtensionsApp"
   ```
 8. If the app exists, check to see if it has a security principal. Replace &lt;application id&gt; with your appId. If you just created the app
   
   ```powershell
   Get-MgServicePrincipal -Filter "AppId eq '<application id>'"
   ```
9. If you just created the app, create a new security principal. Replace &lt;application id&gt; with your appId. If you just created the app
  
   ```powershell
   New-MgServicePrincipal -AppId '<appId>'
   ```

## Create our extension and cloud sync configuration

 1. Now we create our custom attribute and assign it to the CloudSyncCustomExtensionApp. Replace &lt;id&gt; with your ID. Use the object ID of the application.
  
   ```powershell
   New-MgApplicationExtensionProperty -Id <id> -Name “SynchGroup” -DataType “Boolean” -TargetObjects “Group”
   ```
 2. You may be prompted again to enter the ID.
  :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-3.png" alt-text="Screenshot of PowerShell New-MgApplicationExtensionProperty." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-3.png":::
 
 3. This cmdlet creates an attribute that looks like extension_&lt;guid&gt;_SynchGroup. You need this to associate it with a group, however the graph PowerShell cmdlet doesn't return this. 
 4. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
 5. Browse to **Identity** > **Hybrid Management** > **Microsoft Entra Connect** > **Cloud sync**.
 6. Select **New configuration**.
 7. Select **Microsoft Entra ID to AD sync**.
  :::image type="content" source="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png" alt-text="Screenshot of configuration selection." lightbox="media/how-to-configure-entra-to-active-directory/entra-to-ad-1.png":::

 8. On the configuration screen, select your domain and whether to enable password hash sync. Click **Create**. 
  :::image type="content" source="media/how-to-configure/new-ux-configure-2.png" alt-text="Screenshot of a new configuration." lightbox="media/how-to-configure/new-ux-configure-2.png":::

 9. The **Get started** screen opens. From here, you can continue configuring cloud sync
 10. On the left, click **Scoping filters** select **Group scope** - **All groups**
 11. Click **Edit attribute mapping** and change the **Target Contaniner** to OU=Groups,DC=contoso,DC=com. Click **Save**.
 11. Click **Add Attribute scoping filter**
 12. Under **Target Attribute** select the newly created attribute that looks like extension_&lt;guid&gt;_SynchGroup. Also, **write this down** because we need to use this in order to add this attribute to one of our groups.
  :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-4.png" alt-text="Screenshot of available attributes." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-4.png":::
 
 13. Under **Operator** select **PRESENT**
 14. Click **Save**. And click **Save**.
 15. Leave the configuration disabled and come back to it.

## Add new extension property to one of our groups
For this portion, we're going to be adding our newly created property to one of our existing groups, Marketing. To do this, we use Microsoft Graph Explorer.  You need to make sure that you have consented to Group.ReadWrite.All. You can do this by selecting **Modify permissions**.

1. Navigate to https://developer.microsoft.com/graph/graph-explorer
2. Sign-in using your tenant administrator account. This may need to be a global admin account. A global admin account was used in creating this scenario. A hybrid administrator account may be sufficient.
3. At the top, change the **GET** to **PATCH**
4. In the address box enter: https://graph.microsoft.com/v1.0/groups/&lt;group id&gt;
5. In the Request body enter:
   ```
   {
    extension_<guid>_SynchGroup: true
   }
  
   ```
6. Click **Run query**
  :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-1.png" alt-text="Screenshot of running the graph query." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-1.png":::

7. If done correctly, you see [].
8. Now at the top, change **PATCH** to **GET** and look at the properties of the marketing group. 
9. Click **Run query**. You should see the newly created attribute. 
  :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-2.png" alt-text="Screenshot of group properties." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-2.png":::


## Test our configuration
>[!NOTE]
>When using on-demand provisioning, members aren't automatically provisioned. You need to select which members you wish to test on and there's a 5 member limit.

 [!INCLUDE [sign in](../../../includes/cloud-sync-sign-in.md)]

 3. Under **Configuration**, select your configuration.
 4. On the left, select **Provision on demand**.
 5. Enter **Marketing** in the **Selected group** box
 6. From the **Selected users** section, select some users to test. Select **Lola Jacobson** and **John Smith**.
 7. Click **Provision**. It should successfully provision.
   :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-5.png" alt-text="Screenshot of successful provision." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-5.png":::
 8. Now try with the **Sales** group and add **Britta Simon** and **Anna Ringdahl**. This shouldn't provision.
    :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-6.png" alt-text="Screenshot of provisioning being blocked." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-6.png":::
 
 9. In Active Directory, you should see the newly created Marketing group.
    :::image type="content" source="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-7.png" alt-text="Screenshot of new group in active directory users and computers." lightbox="media/tutorial-directory-extension-group-provision/directory-extension-group-provision-7.png":::

## Next steps 
- [Use Group writeback with Microsoft Entra Cloud Sync ](../group-writeback-cloud-sync.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](migrate-group-writeback.md)

---
title: Delete a Microsoft Entra tenant
description: Learn how to prepare a Microsoft Entra tenant, including a self-service tenant, for deletion.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 01/12/2024
ms.author: barclayn
ms.reviewer: addimitu
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done

---
# Delete a tenant in Microsoft Entra ID

When an organization (tenant) is deleted in Microsoft Entra ID, all resources in the organization are also deleted. Prepare your organization by minimizing its associated resources before you delete. Only a Global Administrator can delete a Microsoft Entra organization from the Microsoft Entra Admin center.

## Prepare the organization

You can't delete an organization in Microsoft Entra ID until it passes several checks. These checks reduce the risk that deleting a Microsoft Entra organization negatively affects user access, such as the ability to sign in to Microsoft 365 or access resources in Azure. For example, if the organization associated with a subscription is unintentionally deleted, users can't access the Azure resources for that subscription. 

Check the following conditions:

* You've paid all outstanding invoices and amounts due or overdue.
* No users are in the Microsoft Entra tenant, except one Global Administrator who will delete the organization. You must delete any other users before you can delete the organization. 

  If users are synchronized from on-premises, turn off the sync first. You must delete the users in the cloud organization by using the Microsoft Entra admin center or Azure PowerShell cmdlets.
* No applications are in the organization. You must remove any applications before you can delete the organization.
* No multifactor authentication providers are linked to the organization.
* No subscriptions for any Microsoft Online Services offerings (such as Azure, Microsoft 365, or Microsoft Entra ID P1 or P2) are associated with the organization. 

  For example, if a default Microsoft Entra tenant was created for you, you can't delete this organization if your subscription still relies on it for authentication. You also can't delete a tenant if another user has associated a subscription with it.

> [!NOTE]
> Microsoft is aware that customers with certain tenant configurations might be unable to successfully delete their Microsoft Entra organization. We're working to address this problem. If you need more information, contact Microsoft support.

## Delete the organization

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select Microsoft Entra ID.
1. On a tenant's **Overview** page, select **Manage tenants**.
  
   :::image type="content" source="./media/directory-delete-howto/manage-tenants-command.png" alt-text="Screenshot that shows the button for managing tenants.":::

1. Select the checkbox for the tenant that you want to delete, and then select **Delete**.
  
   :::image type="content" source="./media/directory-delete-howto/manage-tenants-delete-command.png" alt-text="Screenshot that shows the button for deleting an organization.":::

1. If your organization doesn't pass one or more checks, you'll get a link to more information on how to pass. After you pass all checks, select **Delete** to complete the process.

## Deprovision subscriptions to allow organization deletion

When you configured your Microsoft Entra organization, you might have also activated license-based subscriptions for your organization, like Microsoft Entra ID P2, Microsoft 365 Business Standard, or Enterprise Mobility + Security E5. To avoid accidental data loss, you can't delete an organization until the subscriptions are fully deleted. The subscriptions must be in a **Deprovisioned** state to allow organization deletion. An **Expired** or **Canceled** subscription moves to the **Disabled** state, and the final stage is the **Deprovisioned** state.

For what to expect when a trial Microsoft 365 subscription expires (not including paid Partner/CSP, Enterprise Agreement, or Volume Licensing), see the following table. For more information on Microsoft 365 data retention and subscription lifecycle, see [What happens to my data and access when my Microsoft 365 for business subscription ends?](https://support.office.com/article/what-happens-to-my-data-and-access-when-my-office-365-for-business-subscription-ends-4436582f-211a-45ec-b72e-33647f97d8a3). 

Subscription state | Data | Access to data
----- | ----- | -----
**Active** (30 days for trial) | Data is accessible to all.	| Users have normal access to Microsoft 365 files or apps.<br>Admins have normal access to the Microsoft 365 admin center and resources. 
**Expired** (30 days) | Data is accessible to all.| Users have normal access to Microsoft 365 files or apps.<br>Admins have normal access to the Microsoft 365 admin center and resources.
**Disabled** (30 days) | Data is accessible to admins only. | Users can't access Microsoft 365 files or apps.<br>Admins can access the Microsoft 365 admin center but can't assign licenses to or update users.
**Deprovisioned**  (30 days after **Disabled**) | Data is deleted (automatically deleted if no other services are in use). | Users can't access Microsoft 365 files or apps.<br>Admins can access the Microsoft 365 admin center to purchase and manage other subscriptions.

## Delete an Office 365 or Microsoft 365 subscription

You can use the Microsoft admin center to put a subscription into the **Deprovisioned** state for deletion in three days:

1. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com) with an account that is a Global Administrator in your organization. If you're trying to delete the Contoso organization that has the initial default domain `contoso.onmicrosoft.com`, sign in with a User Principal Name (UPN) such as `admin@contoso.onmicrosoft.com`.

1. You need to cancel a subscription before you can delete it. Select **Billing** > **Your products**, and then select **Cancel subscription** for the subscription that you want to cancel. 

   :::image type="content" source="./media/directory-delete-howto/cancel-choose-subscription.png" alt-text="Screenshot that shows choosing a subscription to cancel.":::

1. Complete the feedback form, and then select **Cancel subscription**.

   :::image type="content" source="./media/directory-delete-howto/cancel-command.png" alt-text="Screenshot that shows feedback options and the button for canceling a subscription.":::

1. Select **Delete** for the subscription that you want to delete. If you can't find the subscription on the **Your products** page, make sure that you have **Subscription status** set to **All**.

   :::image type="content" source="./media/directory-delete-howto/delete-command.png" alt-text="Screenshot that shows subscription status and the delete link.":::

1. Select the checkbox to accept terms and conditions, and then select **Delete subscription**. All data for the subscription is permanently deleted in three days. You can [reactivate the subscription](/microsoft-365/commerce/subscriptions/reactivate-your-subscription) during the three-day period if you change your mind.
  
   :::image type="content" source="./media/directory-delete-howto/delete-terms.png" alt-text="Screenshot that shows the link for terms and conditions, along with the button for deleting a subscription.":::  

   Now the subscription state has changed to **Disabled**, and the subscription is marked for deletion. The subscription enters the **Deprovisioned** state 72 hours later.

1. After you've deleted a subscription in your organization and 72 hours have elapsed, sign in to the Microsoft Entra admin center again. Confirm that no required actions or subscriptions are blocking your organization deletion. You should be able to successfully delete your Microsoft Entra organization.

   :::image type="content" source="./media/directory-delete-howto/delete-checks-passed.png" alt-text="Screenshot that shows resources that have passed a subscription check.":::
   
## Delete an Azure subscription

If you have an active or canceled Azure subscription associated with your Microsoft Entra tenant, you can't delete the tenant. After you cancel, billing is stopped immediately. After you cancel a subscription, your billing stops immediately. You can delete your subscription directly using the Azure portal seven days after you cancel it, when the Delete subscription option becomes available. Once your subscription is deleted. Microsoft waits 30 to 90 days before permanently deleting your data in case you need to access it or reactivate your subscription. We don't charge you for retaining this data. To learn more, see [Microsoft Trust Center - How we manage your data](https://go.microsoft.com/fwLink/p/?LinkID=822930&clcid=0x409). 

If you have a free trial or pay-as-you-go subscription. You can delete your subscription three days after you cancel it, when the **Delete subscription** option becomes available. For details, read through [Delete free trial or pay-as-you-go subscriptions](/azure/cost-management-billing/manage/cancel-azure-subscription#delete-subscriptions).

All other subscription types are deleted only through the [subscription cancellation](/azure/cost-management-billing/manage/cancel-azure-subscription#cancel-a-subscription-in-the-azure-portal) process. In other words, you can't delete a subscription directly unless it's a free trial or pay-as-you-go subscription.

Alternatively, you can move the Azure subscription to another tenant. When you transfer billing ownership of your subscription to an account in another tenant, you can move the subscription to the new account's tenant. Performing a **Switch Directory** action on the subscription wouldn't help, because the billing would still be aligned with the Microsoft Entra tenant that was used to sign up for the subscription. For more information, review [Transfer a subscription to another Microsoft Entra tenant account](/azure/cost-management-billing/manage/billing-subscription-transfer#transfer-a-subscription-to-another-azure-ad-tenant-account).

After you have all the Azure, Office 365, and Microsoft 365 subscriptions canceled and deleted, you can clean up the rest of the things within a Microsoft Entra tenant before you delete it.

## Remove enterprise apps that you can't delete

A few enterprise applications can't be deleted in the Microsoft Entra admin center and might block you from deleting the tenant. 

> [!WARNING]
> This code is provided as an example for demonstration purposes. If you intend to use it in your environment, consider testing it first on a small scale, or in a separate test organization. You may have to adjust the code to meet the specific needs of your environment.

Use the following PowerShell code to remove those applications:

1. [Install](/powershell/microsoftgraph/installation) the Microsoft Graph PowerShell module by running the following command:

   ```powershell
   Install-Module Microsoft.Graph
   ```

2. Install the Az PowerShell module by running the following command:

   ```powershell
   Install-Module -Name Az
   ```

3. Create or use a managed administrative account from the tenant that you want to delete. For example: `newAdmin@tenanttodelete.onmicrosoft.com`.

4. Open PowerShell and connect to Microsoft Entra ID by using admin credentials with the following command: `Connect-MgGraph`

   >[!WARNING]
   > You must run PowerShell by using admin credentials for the tenant that you're trying to delete. Only homed-in admins have access to manage the directory via Powershell. You can't use guest user admins, Microsoft accounts, or multiple directories. 
   >
   > Before you proceed, verify that you're connected to the tenant that you want to delete with the Microsoft Graph PowerShell module. We recommend that you run the `Get-MgDomain` command to confirm that you're connected to the correct tenant ID and `onmicrosoft.com` domain.

5. Run the following commands to set the tenant context.  DO NOT skip these steps or you run the risk of deleting enterprise apps from the wrong tenant.

   ```powershell
   Clear-AzContext -Scope CurrentUser
   Connect-AzAccount -Tenant <object id of the tenant you are attempting to delete>
   Get-AzContext
   ```

   >[!WARNING]
   > Before you proceed, verify that you're connected to the tenant that you want to delete with the Az PowerShell module. We recommend that you run the `Get-AzContext` command to check the connected tenant ID and `onmicrosoft.com` domain.  Do NOT skip the above steps or you run the risk of deleting enterprise apps from the wrong tenant.

6. Run the following command to remove any enterprise apps that you can't delete:

   ```powershell
   Get-MgServicePrincipal | ForEach-Object { Remove-MgServicePrincipal -ObjectId $_.Id }
   ```

7. Run the following command to remove applications and service principals:

   ```powershell
   Get-MgServicePrincipal | ForEach-Object { Remove-MgServicePrincipal -ServicePrincipalId $_.Id }
   ```

8. Run the following command to disable any blocking service principals:

   ```powershell
   $ServicePrincipalUpdate =@{ "accountEnabled" = "false" }

   Get-MgServicePrincipal | ForEach-Object { Update-MgServicePrincipal -ServicePrincipalId $_.Id -BodyParameter $ServicePrincipalUpdate }
   ```

9. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator)., and remove any new admin account that you created in step 3.

10. Retry tenant deletion from the Microsoft Entra admin center.

## Handle a trial subscription that blocks deletion

There are [self-service sign-up products](/microsoft-365/admin/misc/self-service-sign-up) like Microsoft Power BI, Azure Rights Management (Azure RMS), Microsoft Power Apps, and Dynamics 365. Individual users can sign up via Microsoft 365, which also creates a guest user for authentication in your Microsoft Entra organization. 

These self-service products block directory deletions until the products are fully deleted from the organization, to avoid data loss. Only the Microsoft Entra admin can delete them, whether the user signed up individually or was assigned the product.

There are two types of self-service sign-up products, in terms of how they're assigned: 

* Organizational-level assignment: a Microsoft Entra administrator assigns the product to the entire organization. A user can actively use the service with the organizational-level assignment, even if the user isn't licensed individually.
* User-level assignment: An individual user during self-service sign-up essentially self-assigns the product without an admin. After an admin starts managing the organization (see [Administrator takeover of an unmanaged organization](domains-admin-takeover.md)), the admin can directly assign the product to users without self-service sign-up.  

When you begin the deletion of a self-service sign-up product, the action permanently deletes the data and removes all user access to the service. Any user who was assigned the offer individually or on the organization level is then blocked from signing in or accessing any existing data. If you want to prevent data loss with a self-service sign-up product like [Microsoft Power BI dashboards](/power-bi/create-reports/service-export-to-pbix) or [Azure RMS policy configuration](/previous-versions/azure/information-protection/configure-policy#how-to-configure-the-azure-information-protection-policy), ensure that the data is backed up and saved elsewhere.

For more information about currently available self-service sign-up products and services, see [Available self-service programs](/microsoft-365/admin/misc/self-service-sign-up#available-self-service-programs).

For what to expect when a trial Microsoft 365 subscription expires (not including paid Partner/CSP, Enterprise Agreement, or Volume Licensing), see the following table. For more information on Microsoft 365 data retention and subscription lifecycle, see [What happens to my data and access when my Microsoft 365 for Business subscription ends?](/microsoft-365/commerce/subscriptions/what-if-my-subscription-expires).

Product state | Data | Access to data
------------- | ---- | --------------
**Active** (30 days for trial) | Data is accessible to all. | Users have normal access to self-service sign-up products, files, or apps.<br>Admins have normal access to the Microsoft 365 admin center and resources.
**Deleted** | Data is deleted. | Users can't access self-service sign-up products, files, or apps.<br>Admins can access the Microsoft 365 admin center to purchase and manage other subscriptions.

## Delete a self-service sign-up product

You can put a self-service sign-up product like Microsoft Power BI or Azure RMS into a **Delete** state to be immediately deleted in the Microsoft Entra admin center:

>[!NOTE]
> If you're trying to delete the Contoso organization that has the initial default domain `contoso.onmicrosoft.com`, sign in with a UPN such as `admin@contoso.onmicrosoft.com`.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select Microsoft Entra ID.
1. Select **Licenses**, and then select **Self-service sign-up products**. You can see all the self-service sign-up products separately from the seat-based subscriptions. Choose the product that you want to permanently delete. Here's an example in Microsoft Power BI:

    :::image type="content" source="./media/directory-delete-howto/licenses-page.png" alt-text="Screenshot that shows a list of self-service sign-up products.":::

1. Select **Delete** to delete the product. This action will remove all users and remove organization access to the product. A dialog warns you that deleting the product will immediately and irrevocably delete data. Select **Yes** to confirm.  

    :::image type="content" source="./media/directory-delete-howto/delete-product.png" alt-text="Screenshot of the confirmation dialog that warns about deletion of data.":::

    A notification tells you that the deletion is in progress.  

    :::image type="content" source="./media/directory-delete-howto/progress-message.png" alt-text="Screenshot of a notification that a deletion is in progress.":::

1. The self-service sign-up product state has changed to **Deleted**. Refresh the page, and verify that the product is removed from the **Self-service sign-up products** page.  

    :::image type="content" source="./media/directory-delete-howto/product-deleted.png" alt-text="Screenshot that shows the list of self-service sign-up products and a pane that confirms the deletion of a self-service sign-up product.":::

1. After you've deleted all the products, sign in to the Microsoft Entra admin center again. Confirm that no required actions or products are blocking your organization deletion. You should be able to successfully delete your Microsoft Entra organization.

    :::image type="content" source="./media/directory-delete-howto/delete-checks-passed.png" alt-text="Screenshot that shows status information for resources.":::

## Next steps

[Microsoft Entra documentation](../index.yml)

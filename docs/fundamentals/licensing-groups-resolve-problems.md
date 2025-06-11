---
title: Resolve group license assignment problems.
description: How to identify and resolve license assignment problems when you're using Microsoft Entra group-based licensing.
keywords: Microsoft Entra ID licensing
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 03/03/2025
ms.author: barclayn
ms.reviewer: sumitp
ms.custom: it-pro
---

# Identify and resolve license assignment problems for a group in the Microsoft 365 Admin Portal

[!INCLUDE [licensing updates](~/includes/licensing-change.md)]

Group-based licensing (GBL) in Microsoft 365 Admin Portal, introduces the concept of users in a licensing error state. This article explains the reasons why users might end up in this state. 

When you assign licenses directly to individual users or using group-based licensing (or both), the assignment operation might fail for reasons that are related to business logic.  
 
Some example issues include but aren't limited to: 

- An insufficient number of licenses  

- Conflict between two service plans that can't be assigned at the same time 

- Service plans in one license depend on service plans from another license 


## Find license assignment errors on users members of a group when using group based licensing

When you're using group-based licensing, these errors happen in the background while the service is assigning licenses. For this reason, the errors can't be communicated to you immediately. Instead, they're recorded on the user object within the group. The original intent to license the user is never lost, but is recorded in an error state for future investigation and resolution. You can also [use audit logs to monitor group-based licensing activity](/azure/security/fundamentals/log-audit).

### To find Users in an error state within a group

1. Sign in to the [Microsoft 365 Admin Portal](https://admin.microsoft.com) as at least a [License Administrator](~/identity/role-based-access-control/permissions-reference.md#license-administrator).
1. Browse to **Billing** > **Licenses** to open a page where you can see and manage all license products in the organization.
1. Select the affected license and to view the status of each group assigned to the selected license navigate to the group selection option. 

   :::image type="content" source="./media/licensing-groups-resolve-problems/licenses.png" alt-text="Screenshot of group and error notifications messages.":::

1. A notification appears if there are any users of the group in an error state. The status of license assignment for each group would be one of the following values: 
    - **All licenses Assigned** – no issues 
    - **In progress** – pending assignment of licenses to users 
    - **Errors and issues** – need to investigate 

 
   :::image type="content" source="./media/licensing-groups-resolve-problems/errors-issues.png" alt-text="Screenshot of list of users in group licensing error state.":::

1. Select the **group name** to review errors for the affected users in the group. 
1. You can also filter the errors using the **Filter** option on the top right if you have a large number of affected users. 

   :::image type="content" source="./media/licensing-groups-resolve-problems/action-needed.png" alt-text="Screenshot of entries that require administration intervention.":::


The following sections give a description of each potential problem and ways to try resolving it.

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Not enough licenses

**Problem:** There aren't enough available licenses for one of the products specified in the group. You need to either purchase more licenses for the product or free up unused licenses from other users or groups.

To see how many licenses are available, go to the **Entra Admin Portal** > **Billing** > **Licenses** > **All products**.

:::image type="content" source="./media/licensing-groups-resolve-problems/license-count.png" alt-text="Screenshot of available licenses.":::

To see which users and groups are consuming licenses, navigate to the **M365 Admin portal** under **Billing** > **Licenses** and select a product. Under **Users**, you see a list of all users who have licenses assigned directly or via one or more groups. Under **Groups**, you see all groups that have that product assigned.

## Conflicting service plans

**Problem:** One of the products specified in the group contains a service plan that conflicts with another service plan already assigned to the user via a different product. Some service plans are configured in a way that they can't be assigned to the same user as another related service plan.
The decision about how to resolve conflicting product licenses always belongs to the administrator. Microsoft Entra ID doesn't automatically resolve license conflicts.
**PowerShell**: PowerShell cmdlets report this error as ***MutuallyExclusiveViolation***.
**Audit log Details**:

```
Licensing Error Message
License assignment failed because service plans [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx], [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx] are mutually exclusive.  
```

## Missing dependent service plans

**Problem:** One of the products specified in the group contains a service plan that must be enabled for another service plan, in another product, to function. This error occurs when Microsoft Entra ID attempts to remove the underlying service plan. For example, this problem can happen when you remove the user from the group.
To solve this problem, you need to make sure that the required plan is still assigned to users through some other method or that the dependent services are disabled for those users. After doing that, you can properly remove the group license from those users.

**PowerShell:** PowerShell cmdlets report this error as DependencyViolation.

**Audit log Details:**  
```
Licensing Error Message

License assignment failed because service plan [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx] depends on
the service plan(s) [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx], [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx].
``` 

## Usage location not specified

**Problem:** Some Microsoft services aren't available in all locations because of local laws and regulations. Before you can assign a license to a user, you must specify the Usage location property for the user. You can specify the location under the User > Profile > Edit section in the portal.
When Microsoft Entra ID attempts to assign a group license to a user in an unsupported usage location, it fails. The system records an error on the user.
To solve this problem, remove users from unsupported locations from the licensed group. If the current usage location values don't represent the actual user location, you can modify them so licenses are correctly assigned next time (if the new location is supported).

**PowerShell:** PowerShell cmdlets report this error as ProhibitedInUsageLocationViolation.

>[!NOTE]
> When Microsoft Entra ID assigns group licenses, any users without a specified usage location inherit the location of the directory. Microsoft recommends that administrators set the correct usage location values on users before using group-based licensing to comply with local laws and regulations. - The attributes of First name, Last name, Other email address, and User type aren't mandatory for license assignment.

## Duplicate proxy addresses

**Problem**: If you use Exchange Online, some users in your organization might be incorrectly configured with the same proxy address value. When group-based licensing tries to assign a license to such a user, it fails and shows “Proxy address is already being used”.


>[!TIP] 
> To see if there's a duplicate proxy address, execute the following PowerShell cmdlet against Exchange Online:

```powershell
Get-Recipient -Filter "EmailAddresses -eq 'user@contoso.onmicrosoft.com'" | fl DisplayName, RecipientType,Emailaddresses
```

For more information about this problem, see [Proxy address is already being used](https://support.microsoft.com/help/3042584/-proxy-address-address-is-already-being-used-error-message-in-exchange-online) error message in Exchange Online.

## Other

**Other** errors are typically the result of an error with another license assigned by the same group.   

:::image type="content" source="./media/licensing-groups-resolve-problems/other.png" alt-text="Screenshot of other type errors.":::
 
To identify the other licensing assigned to the affected user from the same group, you can review the user licenses from the Microsoft Entra Admin Portal. 
 
In the **Entra Admin Portal**, navigate to **Users – All Users** – locate the affected user and then review their **Licenses**. 
 
You can review the user's audit logs for more information about the error as long as the error occurred in the last 30 days in most cases (depending on the number of days Audit logs available in the tenant, some may have only seven days) 
 
Audit log License Assignment Error Records can be identified using the following details: 
 
**Activity Type**:  Change user license 

**Status**:  failure 

**Initiated by** (actor) 
 - **Type**:  Application 
 - **Display Name**:  Microsoft Entra ID Group-Based Licensing 

## Force user license processing to resolve errors 

**Problem:** Depending on what steps you took to resolve the errors, it might be necessary to manually trigger the processing of a user to update the users state. 

For example, after you resolve a dependency violation error for an affected user, you need to trigger the reprocessing of the user. To reprocess a user, navigate back to the **M365 Admin Portal > Billing > Licenses**.  Select the license and navigate to the group where one or more affected users show in error, select the user(s) and then select the **Reprocess** button on the toolbar. 

Alternately, you can use Graph for PowerShell [Invoke-MgLicenseUser](/powershell/module/microsoft.graph.users.actions/invoke-mglicenseuser) to reprocess users.

## More than one product license assigned to a group

You can assign more than one product license to a group. For example, you can assign Office 365 Enterprise E3 and Enterprise Mobility + Security to a group to easily enable all included services for users.

**Problem**: Group based licensing processing attempts to assign all specified licenses in the group to each user within the group. However, if the processing of the licenses encounters issues such as insufficient licenses or conflicts with other services enabled, it doesn't assign other licenses in the group either. You need to check which users have license assignment failures and which products are affected.
If a problem occurs during license assignment, the process may not complete. For example, issues like insufficient licenses or service plans that can't be assigned at the same time, would prevent the process from finishing.

## When a licensed group is deleted

**Problem**: You must remove all licenses assigned to a group before you can delete the group. However, removing licenses from all the users in the group may take time. When an administrator removes license assignments from a group, there can be failures if user has a dependent license assigned or if there's a proxy address conflict issue that prevents the license removal. If a user has a license assigned dependent on a license being removed due to group deletion, all licenses assigned by the deleted group enter an error state on the affected user and it can't be removed until the dependency is resolved.
Once the dependency is resolved, you need to reprocess the user licensing using Graph for PowerShell.

## Manage licenses for products with prerequisites

Some Microsoft Online products you might own have prerequisites. These include add-ons and other service plans which may require a prerequisite service plan to be enabled on a user or a group before the dependent service plans can be added to the user or group. 
With group-based licensing, the system requires that both the prerequisite and add-on service plans or other dependent service plans be present in the same group. This requirement exists to ensure that any users who are added to the group can receive the fully working product. Let's consider the following example:
Microsoft Workplace Analytics is an add-on product. It contains a single service plan with the same name. You can only assign this service plan to a user, or group, when one of the following prerequisites is also assigned:

- Exchange Online (Plan 1)
- Exchange Online (Plan 2)

**Problem**: If you try to assign this product on its own to a group, the portal returns a notification message. 
To assign this add-on license to a group, you must ensure that the group contains the prerequisite service plan. 
It's also possible to create a standalone group that contains only the minimum required products to make the add-on work. It can be used to license only selected users for the add-on product. Based on the previous example, you would assign the following products to the same group:

- Office 365 Enterprise E3 with only the Exchange Online (Plan 2) service plan enabled
- Microsoft Workplace Analytics

From now on, any users added to this group consume one license of the E3 product and one license of the Workplace Analytics product. At the same time, those users can be members of another group that gives them the full E3 product, and they still consume only one license for that product.

>[!TIP] 
>You can create multiple groups for each prerequisite service plan. For example, if you use both Office 365 Enterprise E1 and Office 365 Enterprise E3 for your users, you can create two groups to license Microsoft Workplace Analytics: one that uses E1 as a prerequisite and the other that uses E3. This approach lets you distribute the add-on to E1 and E3 users without consuming other licenses.


## License removal of dynamic membership groups with rules based on licenses with an initial static group

This error occurs because users are added and removed from another batch of dynamic membership groups. The cascading setup of dynamic membership groups, with rules based on licenses in an initial static group, creates this issue. This error can affect multiple dynamic membership groups and demands extensive reprocessing to restore access.

>[!WARNING] 
> When you change an existing static group to a dynamic group, all existing members are removed from the group, and then the membership rule is processed to add new members. If the group is used to control access to apps or resources, the original members might lose access until the membership rule is fully processed.

We recommend that you test the new membership rule beforehand to make sure that the new membership in the group is as expected. If you encounter errors during your test, see Use audit logs to monitor group-based licensing activity.


## Microsoft Entra ID Mail and ProxyAddresses attribute change

**Problem**: While updating license assignment on a user or a group, you might see that the Mail and ProxyAddresses attribute of some users are changed.
Updating license assignment on a user causes the proxy address calculation to be triggered, which can change user attributes. To understand the exact reason of the change and solve the problem, see [this article](../identity/hybrid/connect/how-to-connect-syncservice-shadow-attributes.md#proxyaddresses) on how the proxyAddresses attribute is populated in Microsoft Entra ID.


## Next steps

To learn more about other scenarios for license management through groups, see:

* [What is group-based licensing in Microsoft Entra ID?](~/fundamentals/concept-group-based-licensing.md)


---
title: Create an access review of Azure resource and Microsoft Entra roles in PIM
description: Learn how to create an access review of Azure resource and Microsoft Entra roles in Privileged Identity Management (PIM).
author: barclayn
manager: femila
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 04/30/2025
ms.author: barclayn
ms.custom: pim, sfi-image-nochange
---

# Create an access review of Azure resource and Microsoft Entra roles in PIM

The need for access to privileged Azure resource and Microsoft Entra roles by your users changes over time. To reduce the risk associated with stale role assignments, you should regularly review access. You can use Microsoft Entra Privileged Identity Management (PIM) to create access reviews for privileged access to Azure resource and Microsoft Entra roles. You can also configure recurring access reviews that occur automatically. This article describes how to create one or more access reviews.

## Prerequisites

[!INCLUDE [entra-id-license-pim.md](~/includes/entra-id-license-pim.md)]

For more information about licenses for PIM, see [License requirements to use Privileged Identity Management](~/id-governance/licensing-fundamentals.md).

To create access reviews for Azure resources, you must be assigned to the [Owner](/azure/role-based-access-control/built-in-roles#owner) or the [User Access Administrator](/azure/role-based-access-control/built-in-roles#user-access-administrator) role for the Azure resources. To create access reviews for Microsoft Entra roles, you must be assigned at least the [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role.

Using Access Reviews for **Service Principals** requires a Microsoft Entra Workload ID Premium plan in addition to a Microsoft Entra ID P2 or Microsoft Entra ID Governance license. 

- Workload Identities Premium licensing: You can view and acquire licenses on the [Workload Identities blade](https://portal.azure.com/#view/Microsoft_Azure_ManagedServiceIdentity/WorkloadIdentitiesBlade) in the Microsoft Entra admin center.


> [!NOTE]
> Access reviews capture a snapshot of access at the beginning of each review instance. Any changes made during the review process will be reflected in the subsequent review cycle. Essentially, with the commencement of each new recurrence, pertinent data regarding the users, resources under review, and their respective reviewers is retrieved.

## Create access reviews


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a user that is assigned to one of the prerequisite roles.

1. Browse to **ID Governance** > **Privileged Identity Management**.

1. For **Microsoft Entra roles**, select **Microsoft Entra roles**. For **Azure resources**, select **Azure resources**

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/identity-governance.png" alt-text="Select Identity Governance in the Microsoft Entra admin center screenshot." lightbox="./media/pim-create-azure-ad-roles-and-resource-roles-review/identity-governance.png"::: 
 
4. For **Microsoft Entra roles**, select **Microsoft Entra roles** again under **Manage**. For **Azure resources**, select the subscription you want to manage.


5. Under Manage, select **Access reviews**, and then select **New** to create a new access review.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/access-reviews.png" alt-text="Microsoft Entra roles - Access reviews list showing the status of all reviews screenshot.":::
 
6. Name the access review. Optionally, give the review a description. The name and description are shown to the reviewers.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/name-description.png" alt-text="Create an access review - Review name and description screenshot.":::

7. Set the **Start date**. By default, an access review occurs once. It starts at creation time, and it ends in one month. You can change the start and end dates to have an access review start in the future and last however many days you want.

   :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/start-end-dates.png" alt-text="Start date, frequency, duration, end, number of times, and end date screenshot.":::

8. To make the access review recurring, change the **Frequency** setting from **One time** to **Weekly**, **Monthly**, **Quarterly**, **Annually**, or **Semi-annually**. Use the **Duration** slider or text box to specify review duration. For example, the maximum duration that you can set for a monthly review is 27 days, to avoid overlapping reviews.

9. Use the **End** setting to specify how to end the recurring access review series. The series can end in three ways: it runs continuously to start reviews indefinitely, until a specific date, or after a defined number of occurrences completes. You, or another administrator who can manage reviews, can stop the series after creation by changing the date in **Settings**, so that it ends on that date.


10. In the **Users Scope** section, select the scope of the review. For **Microsoft Entra roles**, the first scope option is Users and Groups. Directly assigned users and [role-assignable groups](~/identity/role-based-access-control/groups-concept.md) are included in this selection. For **Azure resource roles**, the first scope is Users. Groups assigned to Azure resource roles are expanded to display transitive user assignments in the review with this selection. You may also select **Service Principals** to review the machine accounts with direct access to either the Azure resource or Microsoft Entra role.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/users.png" alt-text="Users scope to review role membership of screenshot.":::

11. Or, you can create access reviews only for inactive users. In the *Users scope* section, set the **Inactive users (on tenant level) only** to **true**. If the toggle is set to *true*, the scope of the review focuses on inactive users only. Then, specify **Days inactive**. You can specify up to 730 days (two years). Users inactive for the specified number of days are the only users in the review.
 
12. Under **Review role membership**, select the privileged Azure resource or Microsoft Entra roles to review.

    > [!NOTE]
    > Selecting more than one role will create multiple access reviews. For example, selecting five roles will create five separate access reviews.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/review-role-membership.png" alt-text="Review role memberships screenshot.":::

13. In **assignment type**, scope the review by how the principal was assigned to the role. Choose **eligible assignments only** to review eligible assignments (regardless of activation status when the review is created) or **active assignments only** to review active assignments. Choose **all active and eligible assignments** to review all assignments regardless of type.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/assignment-type-select.png" alt-text="Reviewers list of assignment types screenshot.":::

14. In the **Reviewers** section, select one or more people to review all the users. Or you can select to have the members review their own access.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/reviewers.png" alt-text="Reviewers list of selected users or members (self)":::

    - **Selected users** - Use this option to designate a specific user to complete the review. This option is available regardless of the scope of the review, and the selected reviewers can review users, groups, and service principals.
    - **Members (self)** - Use this option to have the users review their own role assignments. This option is only available if the review is scoped to **Users and Groups** or **Users**. For **Microsoft Entra roles**, role-assignable groups aren't part of the review when this option is selected. 
    - **Manager** – Use this option to have the user’s manager review their role assignment. This option is only available if the review is scoped to **Users and Groups** or **Users**. Upon selecting Manager, you also can specify a fallback reviewer. Fallback reviewers are asked to review a user when the user has no manager specified in the directory. For **Microsoft Entra roles**, role-assignable groups are reviewed by the fallback reviewer if one is selected. 

### Upon completion settings

1. To specify what happens after a review completes, expand the **Upon completion settings** section.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/upon-completion-settings.png" alt-text="Screenshot showing the upon completion settings to auto apply, and choices should reviewer not respond.":::

2. If you want to automatically remove access for users that were denied, set **Auto apply results to resource** to **Enable**. If you want to manually apply the results when the review completes, set the switch to **Disable**.

3. Use the **If reviewer don't respond** list to specify what happens for users that aren't reviewed by the reviewer within the review period. This setting doesn't impact users who were already reviewed.

    - **No change** - Leave user's access unchanged
    - **Remove access** - Remove user's access
    - **Approve access** - Approve user's access
    - **Take recommendations** - Take the system's recommendation on denying or approving the user's continued access
    
4. Use the **Action to apply on denied guest users** list to specify what happens for guest users that are denied. This setting isn't editable for Microsoft Entra ID and Azure resource role reviews at this time; guest users, like all users, always lose access to the resource if denied.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/action-to-apply-on-denied-guest-users.png" alt-text="Upon completion settings - Action to apply on denied guest users screenshot.":::

5. You can send notifications to other users or groups to receive review completion updates. This feature allows for stakeholders other than the review creator to be updated on the progress of the review. To use this feature, select **Select User(s) or Group(s)** and add any users, or groups you want receive completion status notifications.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/upon-completion-settings-additional-receivers.png" alt-text="Upon completion settings - Add additional users to receive notifications screenshot.":::

### Advanced settings

1. To configure more settings, expand the **Advanced settings** section.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/advanced-settings.png" alt-text="Advanced settings for show recommendations, require reason on approval, mail notifications, and reminders screenshot.":::

1. Set **Show recommendations** to **Enable** to show the reviewers the system recommendations based the user's access information. Recommendations are based on a 30-day interval period. Users who have logged in the past 30 days are shown with recommended approval of access, while users who haven't logged in are shown with recommended denial of access. These sign-ins are irrespective of whether they were interactive. The last sign-in of the user is also displayed along with the recommendation. 

1. Set **Require reason on approval** to **Enable** to require the reviewer to supply a reason for approval.

1. Set **Mail notifications** to **Enable** to have Microsoft Entra ID send email notifications to reviewers when an access review starts, and to administrators when a review completes.

1. Set **Reminders** to **Enable** to have Microsoft Entra ID send reminders of access reviews in progress to reviewers who haven't completed their review.
1. The content of the email sent to reviewers is autogenerated based on the review details, such as review name, resource name, due date, and so on. If you need a way to communicate additional information such as more instructions or contact information, you can specify these details in the **Additional content for reviewer email** are included in the invitation and reminder emails sent to assigned reviewers. The highlighted section is where this information is displayed.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/email-info.png" alt-text="Content of the email sent to reviewers with highlights"::: 

## Manage the access review

You can track the progress as the reviewers complete their reviews on the **Overview** page of the access review. No access rights are changed in the directory until the review is completed.
:::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/access-review-overview.png" alt-text="Access reviews overview page showing the details of the access review for Microsoft Entra roles screenshot." lightbox="./media/pim-create-azure-ad-roles-and-resource-roles-review/access-review-overview.png":::

 After the access review, follow the steps in [Complete an access review of Azure resource and Microsoft Entra roles](./pim-complete-roles-and-resource-roles-review.md) to see and apply the results.  

If you are managing a series of access reviews, navigate to the access review, and you find upcoming occurrences in Scheduled reviews, and edit the end date or add/remove reviewers accordingly.

Based on your selections in **Upon completion settings**, auto-apply will be executed after the review's end date or when you manually stop the review. The status of the review changes from **Completed** through intermediate states such as **Applying** and finally to state **Applied**. You should expect to see denied users, if any, being removed from roles in a few minutes.

<a name='impact-of-groups-assigned-to-azure-ad-roles-and-azure-resource-roles-in-access-reviews'></a>

## Impact of groups assigned to Microsoft Entra roles and Azure resource roles in access reviews

•	For **Microsoft Entra roles**, role-assignable groups can be assigned to the role using [role-assignable groups](~/identity/role-based-access-control/groups-concept.md). When a review is created on a Microsoft Entra role with role-assignable groups assigned, the group name shows up in the review without expanding the group membership. The reviewer can approve or deny access of the entire group to the role. Denied groups lose their assignment to the role when review results are applied.

•	For **Azure resource roles**, any security group can be assigned to the role. When a review is created on an Azure resource role with a security group assigned, role reviewers can see a fully expanded view of the group's membership. When a reviewer denies a user that was assigned to the role via the security group, the user won't be removed from the group. This is because a group may be shared with other Azure or non-Azure resources. Administrators must implement the changes resulting from an access denial.

> [!NOTE]
> It is possible for a security group to have other groups assigned to it. In this case, only the users assigned directly to the security group assigned to the role will appear in the review of the role.


## Update the access review

After one or more access reviews have been started, you may want to modify or update the settings of your existing access reviews. Here are some common scenarios that you might want to consider:

- **Adding and removing reviewers** - When updating access reviews, you may choose to add a fallback reviewer in addition to the primary reviewer. Primary reviewers may be removed when updating an access review. However, fallback reviewers aren't removable by design.

    > [!Note]
    > Fallback reviewers can only be added when reviewer type is manager. Primary reviewers can be added when reviewer type is selected user.

- **Reminding the reviewers** - When updating access reviews, you may choose to enable the reminder option under Advanced Settings. Once enabled, users receive an email notification at the midpoint of the review period. Reviewers receive notifications regardless of whether they have completed the review or not. 

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/reminder-setting.png" alt-text="Screenshot of the reminder option under access reviews settings.":::

- **Updating the settings** - If an access review is recurring, there are separate settings under "Current" versus under "Series". Updating the settings under "Current" will only apply changes to the current access review while updating the settings under "Series" will update the setting for all future recurrences.

    :::image type="content" source="./media/pim-create-azure-ad-roles-and-resource-roles-review/current-v-series-setting.png" alt-text="Screenshot of the settings page under access reviews." lightbox="./media/pim-create-azure-ad-roles-and-resource-roles-review/current-v-series-setting.png":::
    
## Next steps

- [Perform an access review of Azure resource and Microsoft Entra roles in PIM](./pim-perform-roles-and-resource-roles-review.md)
- [Complete an access review of Azure resource and Microsoft Entra roles in PIM](./pim-complete-roles-and-resource-roles-review.md)
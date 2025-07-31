---
title: How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 07/31/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID (Preview)

Admins can use **Audit Logs** in the Azure portal or the onPremisesSyncBehavior Microsoft Graph API to monitor and report SOA changes in their environment. They can also integrate SOA changes with third-party monitoring systems. For more information, see [onPremisesSyncBehavior](/graph/api/resources/onpremisessyncbehavior).

## How to use Audit Logs to see SOA changes  

You can access Audit Logs in the Azure portal. They retain a record of SOA changes for the last 30 days. 

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD DS to cloud**.

   :::image type="content" source="media/how-to-source-of-authority-auditing-monitoring/audit-logs.png" alt-text="Screenshot of the Azure portal showing the Change Source of Authority from AD DS to cloud activity selection.":::

## How to use Microsoft Graph API to create reports for SOA 

You can use Microsoft Graph to report data such as:

- Report how many objects are SOA converted
- Filter data for converted groups
- Identify objects that were SOA converted and rolled back

### Filter and count converted objects

The [onPremisesSyncBehavior API](/graph/api/resources/onpremisessyncbehavior) helps you view the *isCloudManaged* property for a group. You can set the *isCloudManaged* property to `true` to convert the Group SOA. 

You can also call the onPremisesSyncBehavior API to query how many groups converted their SOA to cloud-managed:

```https
GET groups/{ID}/onPremisesSyncBehavior?$select=id,isCloudManaged
```

You can use $search and $count to view all group objects with converted SOA. Before you can use $filter or $count, you need to set consistencyLevel = eventual in **Request headers** in Microsoft Graph Explorer:

```https
GET groups?$filter=onPremisesSyncBehavior/isCloudManaged eq true&$select=id,displayName,isCloudManaged&$count=true
```

<!---NL2MSGraph is a new platform that allows customers to use Security Co-Pilot to get answers using MSGraph calls. We can simplify customer experience by adding this filter at "all users" level
Given SOA feature has no UX, this enables the ability to view bulk SOA changes after it's made.--->


## How to use Azure Monitor to create workbooks and reports using Log Analytics 

You can integrate Audit Logs with Azure Monitoring and search the following events to get SOA operations:

- Event ID 6956 is logged if an object isn't synced to the cloud because the SOA of the object is cloud-managed.

- When SOA transfer is rolled back to on-premises, group provisioning to AD DS stops syncing changes without deleting the AD DS group. The AD DS group is also removed from the configuration scope. The AD DS group remains intact, and AD DS resumes control in the next sync cycle. You can verify in the **Audit Logs** that sync doesn't happen for this object because it's managed on-premises. 

  :::image type="content" border="true" source="media/how-to-source-of-authority-auditing-monitoring/audit-log-details.png" alt-text="Screenshot of Audit log details." lightbox="media/how-to-source-of-authority-auditing-monitoring/audit-log-details.png":::

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).

## Related content

- [Group SOA overview](concept-source-of-authority-overview.md)
- [How to configure Group SOA](how-to-group-source-of-authority-configure.md)
- [onPremisesSyncBehavior API](/graph/api/resources/onpremisessyncbehavior)
---
title: How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 09/16/2025

#CustomerIntent: As a <type of user>, I want <what?> so that <why?>.
---

# How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)

Admins can use **Audit Logs** in the Azure portal or the onPremisesSyncBehavior Microsoft Graph API to monitor and report SOA changes in their environment. They can also integrate SOA changes with third-party monitoring systems. For more information, see [onPremisesSyncBehavior](/graph/api/resources/onpremisessyncbehavior).



## How to use Audit Logs to see SOA changes  

You can access Audit Logs in the Azure portal. They retain a record of SOA changes for the last 30 days. 

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD DS to cloud**.

   :::image type="content" source="media/how-to-source-of-authority-auditing-monitoring/audit-logs.png" alt-text="Screenshot of the Azure portal showing the Change Source of Authority from AD DS to cloud activity selection.":::


## How to use Microsoft Graph API to create reports for SOA 

You can use Microsoft Graph to report data such as:

- Report how many objects are SOA converted
- Filter data for converted users
- Identify objects that were SOA converted and rolled back

### Filter and count converted objects

The [onPremisesSyncBehavior API](/graph/api/resources/onpremisessyncbehavior) helps you view the *isCloudManaged* property for an user. You can set the *isCloudManaged* property to `true` to convert the user SOA. 

You can also call the onPremisesSyncBehavior API to query how many users converted their SOA to cloud-managed:

```https
GET users/{ID}/onPremisesSyncBehavior?$select=id,isCloudManaged
```

You can use $search and $count to view all user objects with converted SOA. Before you can use $filter or $count, you need to set consistencyLevel = eventual in **Request headers** in Microsoft Graph Explorer:

```https
GET users?$filter=onPremisesSyncBehavior/isCloudManaged eq true&$select=id,displayName,isCloudManaged&$count=true
```



## How to use Azure Monitor to create workbooks and reports using Log Analytics 

You can integrate Audit Logs with Azure Monitoring and search the following events to get SOA operations:

- Event ID 6956 is logged if an object isn't synced to the cloud because the SOA of the object is cloud-managed.

- When SOA transfer is rolled back to on-premises, user provisioning to AD DS stops syncing changes without deleting the AD DS user. The AD DS user is also removed from the configuration scope. The AD DS user remains intact, and AD DS resumes control in the next sync cycle. You can verify in the **Audit Logs** that sync doesn't happen for this object because it's managed on-premises. 

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).


## Related content

TODO: Add your next step link(s)

- [Configure User Source of Authority (SOA) (Preview)](how-to-user-source-of-authority-configure.md)


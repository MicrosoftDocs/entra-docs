---
title: How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID
description: Learn how to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 07/21/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID

Admins can use **Audit Logs** in the Azure portal or the onPremisesSyncBehavior Microsoft Graph API to monitor and report SOA changes in their environment. They can also integrate SOA changes with third-party monitoring systems.

## How to use Audit Logs to see SOA changes  

You can access Audit Logs in the Azure portal. They retain a record SOA changes for the last 30 days. 

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD to cloud**.

   :::image type="content" source="media/how-to-source-of-authority-auditing-monitoring/audit-logs.png" alt-text="Screenshot of the Azure portal showing the Change Source of Authority from AD to cloud activity selection.":::

## How to use Microsoft Graph API to create reports for SOA 

You can use Microsoft Graph to report data such as how many objects are converted to SOA, filter data for converted groups, or identify objects that were converted to SOA and rolled back. 

### Filter and count converted objects

The onPremisesSyncBehavior API helps you view the *isCloudManaged* property for user or a group. You can set the *isCloudManaged* property to `true` to convert the SOA of an object. 

You can also call the onPremisesSyncBehavior API and input each user object to query how many objects have their SOA converted to cloud-managed:

```https
GET users/%USER_ID%/onPremisesSyncBehavior?$select=id,isCloudManaged
```

To view all objects whose SOA has changed:

```https
GET users?$filter=onPremisesSyncBehavior/isCloudManaged eq true&$select=id,displayName,isCloudManaged
```

<!---NL2MSGraph is a new platform that allows customers to use Security Co-Pilot to get answers using MSGraph calls. We can simplify customer experience by adding this filter at "all users" level
Given SOA feature has no UX, this enables the ability to view bulk SOA changes after it's made.--->


### Identify SOA objects that are rolled back 

To help troubleshoot during rollback, you can use the **onPremisesImmutableId** in combination with **isCloudManaged** attribute to determine if an object is a cloud-native or converted for SOA. If the **onPremisesImmutableId** is set to null, it's a cloud-native object. You can use Microsoft Graph to set the **onPremisesImmutableId** attribute value, and then the sync client can manage an object.

Query for **onPremisesImmutableId** != null and **DirSyncEnabled** != true. You need to use the ConsistencyLevel:eventual header.

```https
GET https://graph.microsoft.com/v1.0/users?$count=true&$filter=onPremisesSyncEnabled ne true and onPremisesImmutableId ne null
```

## How to use Azure Monitor to create workbooks and reports using Log Analytics 

You can integrate Audit Logs with Azure Monitoring and search the following events to get SOA operations:

- Event ID 6956 is logged if an object isn't synced to the cloud because the SOA of the object is cloud-managed.

- When SOA transfer is rolled back to on-premises, **Group Provisioning to AD (GPAD)** stops syncing changes without deleting the on-premises group. It also removes the group from GPAD configuration scope. The on-premises group remains intact, and resumes control in the next sync cycle. You can verify in the audit logs that sync won't happen for this object because it's managed on-premises. 

  :::image type="content" border="true" source="media/how-to-source-of-authority-auditing-monitoring/audit-log-details.png" alt-text="Screenshot of Audit log details." lightbox="media/how-to-source-of-authority-auditing-monitoring/audit-log-details.png":::

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).

## Related content

- How to configure Group SOA
- How Group SOA works

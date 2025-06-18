---
title: How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID
description: Learn how to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID.
author: Justinha
manager: dougeby
ms.topic: concept-article
ms.date: 06/13/2025
ms.author: justinha
ms.reviewer: dhanyak
---

# How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID

Give an overview for the section and calls out what the article covers. 







## How to use audit logs to see SOA changes  

You can access Audit logs in the Azure portal.


1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD to cloud**.

   :::image type="content" source="media/how-to-source-of-authority-auditing-monitoring/audit-logs.png" alt-text="Screenshot of the Azure portal showing the Change Source of Authority from AD to cloud activity selection.":::

## How to use Microsoft Graph API to create reports for SOA 

You can use Microsoft Graph to report data such as how many objects are converted to SOA, filter data for converted groups, or identify objects that were converted to SOA and rolled back. 

### Get a count of all SOA converted objects

how to use MS Graph API $count to get the count of SOA converted groups, add details from https://identitydivision.visualstudio.com/Engineering/_workitems/edit/3127457

### Filter reports for SOA converted objects

how to use MS Graph API $filter to filter on SOA Converted groups, add details from https://identitydivision.visualstudio.com/Engineering/_workitems/edit/3127457

### Identify SOA objects that are rolled back 

To help troubleshoot during rollback, you can use an immutable ID in combination with **isCloudManaged** attribute to determine if an object is a cloud native or converted for SOA. If the Immutable ID is set to null, then, it will be treated as a cloud native object. If anyone uses MSGraph to set the Immutable ID, then, sync client can take over if there's a hard match.

Here is how it works:

Query for **OnPremisesImmutableID** != null and **DirSyncEnabled** != true

`https://graph.microsoft.com/v1.0/users?$count=true&$filter=OnPremisesSyncEnabled ne true and OnPremisesImmutableId ne null`

Note that ConsistencyLevel:eventual header must be used.

We can continue to use the Audit logs to determine the status for last 30 days.


## How to use Azure Monitor to create workbooks and reports using Log Analytics 

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).


Talk about how to integrate with Azure Monitoring and talk about which events Admins should pull to get SOA operations.


## Related content

- For more information about how to configure Group SOA, see How to configure Group SOA.

- For more information about how Group SOA works, see How Group SOA works.

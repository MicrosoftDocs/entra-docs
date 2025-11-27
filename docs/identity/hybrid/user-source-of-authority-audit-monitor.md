---
title: How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)
description: Learn how to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: hybrid
ms.topic: concept-article #Required; leave this attribute/value as-is.
ms.date: 09/16/2025

#CustomerIntent: As a IT administrator , I want to learn how to view logs so that I can see information about source of authority for my users.
---

# How to audit and monitor User Source of Authority (SOA) in Microsoft Entra ID (Preview)

Admins can use **Audit Logs** in the Azure portal or the onPremisesSyncBehavior Microsoft Graph API to monitor and report SOA changes in their environment. They can also integrate SOA changes with third-party monitoring systems. For more information, see [onPremisesSyncBehavior](/graph/api/resources/onpremisessyncbehavior).



## How to use Audit Logs to see SOA changes  

You can access Audit Logs in the Azure portal. They retain a record of SOA changes for the last 30 days. 

1. Sign in to the [Azure portal](https://portal.azure.com) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader). 

1. Select **Manage Microsoft Entra ID** > **Monitoring** > **Audit logs** or search for **audit logs** in the search bar.

1. Select activity as **Change Source of Authority from AD DS to cloud**.
    :::image type="content" source="media/user-source-of-authority-audit-monitor/audit-logs.png" alt-text="Screenshot of the user source of authority audit logs.":::
1. Alternatively, you can also see activity of when a user has their source of authority reverted away from the cloud.
    :::image type="content" source="media/user-source-of-authority-audit-monitor/undo-source-of-authority-logs.png" alt-text="Screenshot of audit logs when source of authority is reverted.":::
1. You can also get a full list of all users who have had their SOA reverted by making the following API call:
    ```https
   GET https://graph.microsoft.com/v1.0/users?$count=true&$filter=OnPremisesSyncEnabled ne true and OnPremisesImmutableId ne null
   ```


## How to use Azure Monitor to create workbooks and reports using Log Analytics 

You can integrate Audit Logs with Azure Monitoring and search the following events to get SOA operations:

- Event ID 6956 is logged if an object isn't synced to the cloud because the SOA of the object is cloud-managed.

- When SOA transfer is rolled back to on-premises, user provisioning to AD DS stops syncing changes without deleting the AD DS user. The AD DS user is also removed from the configuration scope. The AD DS user remains intact, and AD DS resumes control in the next sync cycle. You can verify in the **Audit Logs** that sync doesn't happen for this object because it's managed on-premises. 

For more information about how to create custom queries, see [Understand how provisioning integrates with Azure Monitor logs](/entra/identity/app-provisioning/application-provisioning-log-analytics).


## Related content

- [Configure User Source of Authority (SOA) (Preview)](how-to-user-source-of-authority-configure.md)


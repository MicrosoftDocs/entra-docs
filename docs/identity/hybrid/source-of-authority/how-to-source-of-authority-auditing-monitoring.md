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

## How to audit and monitor Group Source of Authority (SOA) in Microsoft Entra ID

Audit logs can be accessed from Azure Portal -\> Manage Microsoft Entra
ID -\> Monitoring -\> Audit Logs or by searching for “audit logs” in the
search bar.

Select activity as "**Change Source of Authority from AD to cloud**.”

<img src="media/how-to-group-source-of-authority/image10.png" style="width:6.5in;height:1.05208in" />

Talk about how to integrate with Azure Monitoring and talk about which events Admins should pull

We need to include 2 additional reporting instructions on how to use MS Graph API $count and $filter to get the count of SOA converted groups as well as filter on SOA Converted groups.

Add another troubleshooting scenario for rollback... We can use immutable ID to determine if an object is a cloud native object or a SOA converted object (in combination with isCloudManaged attribute). If the Immutable ID is set to null, then, it will be treated as a cloud native object. If anyone uses MSGraph to set the Immutable ID, then, sync client can take over if there's a hard match. 

How it works
Query for OnPremisesImmutableID != null and DirSyncEnabled != true

https://graph.microsoft.com/v1.0/users?$count=true&$filter=OnPremisesSyncEnabled ne true and OnPremisesImmutableId ne null

Note that ConsistencyLevel:eventual header must be used.

We can continue to use the Audit logs to determine the status for last 30 days.


## Related content

- For more information about how to configure Group SOA, see How to configure Group SOA. 
- For more information about how Group SOA works, see How Group SOA works.
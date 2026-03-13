---
title: Entra Backup Administrator
description: Entra Backup Administrator
ms.topic: include
ms.date: 03/19/2026
ms.custom: include file
---

Assign the Entra Backup Administrator role to users who need to do the following tasks:

- List all the snapshots in a tenant
- Create a difference report (preview job) of a backup in the past and optionally include scoping filters
- Compare states of changed directory objects that are in backup and recovery scope
- Filter directory objects with supported scoping filters
- Read status of a job
- List all the jobs including preview and recovery jobs
- Trigger recovery jobs and optionally include scoping filters

> [!div class="mx-tableFixed"]
> | Actions | Description |
> | --- | --- |
> | microsoft.directory/backup/preview/cancel | Cancel a Microsoft Entra backup operation to compare a backup snapshot with the current state. |
> | microsoft.directory/backup/preview/create | Create a Microsoft Entra backup operation that allows a user to compare a backup snapshot with the current state. |
> | microsoft.directory/backup/recovery/cancel | Cancel a Microsoft Entra recovery operation to recover the contents of a backup snapshot |
> | microsoft.directory/backup/recovery/create | Create a Microsoft Entra recovery operation that allows a user to recover the contents of a backup snapshot. |
> | microsoft.directory/backup/standard/read | List Microsoft Entra backups (for example, backup IDs and timestamps), view difference reports, and list recovery jobs and their associated properties. |

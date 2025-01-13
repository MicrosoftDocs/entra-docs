---
title: include file
description: include file
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.topic: include
ms.date: 07/15/2024
ms.author: barclayn
ms.custom: include file
---

> [!NOTE]
> When performing bulk operations, such as import or create, you may encounter a problem if the bulk operation does not complete within the hour. To work around this issue, we recommend splitting the number of records processed per batch. For example, before starting an export you could limit the result set by filtering on a group type or user name to reduce the size of the results. By refining your filters, essentially you are limiting the data returned by the bulk operation. For more information, see [Bulk operations service limitations](~/fundamentals/bulk-operations-service-limitations.md).
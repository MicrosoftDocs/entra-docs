---
title: 'On-demand provisioning using cloud sync'
description: This article describes how to use on-demand provisioning with Microsoft Entra Cloud Sync.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 11/06/2023
ms.subservice: hybrid
ms.author: billmath

---

# On-demand provisioning using cloud sync

You can use cloud sync to test configuration changes by applying these changes to a single user. This on-demand provisioning helps you validate and verify that the changes made to the configuration were applied properly and are being correctly synchronized to Microsoft Entra ID.  This feature is only available in cloud sync and not Microsoft Entra Connect.

## Steps to use on-demand provisioning
To use on-demand provisioning, follow these steps:

[!INCLUDE [sign in](~/includes/cloud-sync-sign-in.md)]
 4. Under **Configuration**, select your configuration.
 5. On the left, select **Provision on demand**.
 6. Enter the distinguished name of a user and select the **Provision** button.
 7. Once the process completes, a success screen appears with four green check marks. Any errors appear on the left side of the screen.

## Next steps

For more information, see [on-demand provisioning in cloud sync](cloud-sync/how-to-on-demand-provision.md)

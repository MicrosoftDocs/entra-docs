---
title: 'Tutorial: Use password hash sync for hybrid identity in a single Active Directory forest'
description: Learn how to set up a hybrid identity environment by using password hash sync to integrate a Windows Server Active Directory forest with Microsoft Entra ID.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.tgt_pltfrm: na
ms.topic: tutorial
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath


---

# Tutorial: Use password hash sync for hybrid identity in a single Active Directory forest

This tutorial shows you how to create a hybrid identity environment in Azure by using password hash sync and Windows Server Active Directory (Windows Server AD). You can use the hybrid identity environment you create for testing or to get more familiar with how hybrid identity works.

:::image type="content" source="~/includes/governance/media/tutorial-password-hash-sync/diagram.png" border="false" alt-text="Diagram that shows how to create a hybrid identity environment in Azure by using password hash sync.":::

In this tutorial, you learn how to:

> [!div class="checklist"]
>
> - Create a virtual machine.
> - Create a Windows Server Active Directory environment.
> - Create a Windows Server Active Directory user.
> - Create a Microsoft Entra tenant.
> - Create a Hybrid Identity Administrator account in Azure.
> - Set up Microsoft Entra Connect.
> - Test and verify that users are synced.


[!INCLUDE [governance-ad-to-entra-connect-sync](~/includes/governance/governance-active-directory-to-entra-connect-sync.md)]

## Next steps

- Review [Microsoft Entra Connect hardware and prerequisites](how-to-connect-install-prerequisites.md).
- Learn how to use [Express settings](how-to-connect-install-express.md) in Microsoft Entra Connect.
- Learn more about [password hash sync](how-to-connect-password-hash-synchronization.md) with Microsoft Entra Connect.

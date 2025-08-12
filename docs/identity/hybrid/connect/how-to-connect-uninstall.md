---
title: Uninstall Microsoft Entra Connect
description: This document describes how to uninstall Microsoft Entra Connect.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: article
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: jomondi

---

# Uninstall Microsoft Entra Connect

This document describes how to correctly uninstall Microsoft Entra Connect.

<a name='uninstall-azure-ad-connect-from-the-server'></a>

## Uninstall Microsoft Entra Connect from the server
The first thing you need to do is remove Microsoft Entra Connect from the server that it's running on. Use the following steps:

 1. On the server running Microsoft Entra Connect, navigate to **Control Panel**.
 2. Select **Uninstall a program**
 ![Uninstall a program](media/how-to-connect-uninstall/uninstall-1.png)</br>
 
 3. Select **Microsoft Entra Connect**.
 ![Select Microsoft Entra Connect](media/how-to-connect-uninstall/uninstall-2.png)</br>
 
 4. When prompted, select **Yes** to confirm.
 5. This confirmation brings up the Microsoft Entra Connect screen. Select **Remove**.
 ![Remove](media/how-to-connect-uninstall/uninstall-3.png)</br>
 
 6. Once this action completes, select **Exit**.
 7. ![Exit](media/how-to-connect-uninstall/uninstall-4.png)</br>
 
 8. Back in **Control Panel** select **Refresh** and all of the components should be removed.


## Next steps

- Learn more about [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md).
- [Install Microsoft Entra Connect using an existing ADSync database](how-to-connect-install-existing-database.md)
- [Install Microsoft Entra Connect using SQL delegated administrator permissions](how-to-connect-install-sql-delegation.md)

---
title: 'Verify your version of cloud sync or connect sync'
description: This article describes the steps to verify the version of the provisioning agent or connect sync.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 04/09/2025
ms.subservice: hybrid
ms.author: jomondi

---

# Verify your version of the provisioning agent or connect sync
This article describes the steps to verify the installed version of the provisioning agent and connect sync.

## Verify the provisioning agent
To see what version of the provisioning agent you're using, use the following steps:

[!INCLUDE [active-directory-cloud-sync-how-to-verify-installation](~/includes/entra-cloud-sync-how-to-verify-installation.md)]

## Verify connect sync
To see what version of connect sync you're using, use the following steps:

### On the local server

To verify that the agent is running, follow these steps:

 1. Sign in to the server with an administrator account.
 2. Open **Services** either by navigating to it or by going to *Start/Run/Services.msc*.
 3. Under **Services**, make sure that **Microsoft Entra ID Sync** is present and the status is **Running**.


### Verify the connect sync version

To verify the version of the agent that is running, follow these steps:

1.  Navigate to 'C:\Program Files\Microsoft Azure AD Connect'
2.  Right-click on **AzureADConnect.exe** and select **properties**.
3.  Click the **details** tab and the version number ID next to the Product version.

## Next steps
- [Common scenarios](common-scenarios.md)
- [Choosing the right sync tool](https://setup.microsoft.com/azure/add-or-sync-users-to-azure-ad)
- [Steps to start](get-started.md)
- [Prerequisites](prerequisites.md)

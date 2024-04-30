---
title: 'Disable pass-through authentication by using Microsoft Entra Connect or PowerShell'
description: This article describes how to disable pass-through authentication by using the Microsoft Entra Connect Do Not Configure feature or by using PowerShell.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath

---

# Disable pass-through authentication 

In this article, you learn how to disable pass-through authentication by using Microsoft Entra Connect or PowerShell.

## Prerequisites

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Before you begin, ensure that you have the following prerequisite.

- A Windows machine with pass-through authentication agent version 1.5.1742.0 or later installed. Any earlier version might not have the requisite cmdlets for completing this operation.

   If you don't already have an agent, you can install it.

   1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
   1. Download the latest Auth Agent.
   1. Install the feature by running either of the following commands.
      * `.\AADConnectAuthAgentSetup.exe`  
      * `.\AADConnectAuthAgentSetup.exe ENVIRONMENTNAME=<identifier>`
        > [!IMPORTANT]
        > If you're using the Azure Government cloud, pass in the ENVIRONMENTNAME parameter with the following value: 
        >
        >| Environment Name | Cloud |
        >| - | - |
        >| AzureUSGovernment | US Gov |

- An Azure Hybrid Identity Administrator account for running the PowerShell cmdlets.

<a name='use-azure-ad-connect'></a>

## Use Microsoft Entra Connect

If you're using pass-through authentication with Microsoft Entra Connect and you have it set to **Do not configure**, you can disable the setting. 

>[!NOTE]
>If you already have password hash synchronization enabled, disabling pass-through authentication will result in a tenant fallback to password hash synchronization.

## Use PowerShell

In a PowerShell session, run the following cmdlets:

1. PS C:\Program Files\Microsoft Azure AD Connect Authentication Agent> `Import-Module .\Modules\PassthroughAuthPSModule`
2. `Get-PassthroughAuthenticationEnablementStatus`
3. `Disable-PassthroughAuthentication`

## Next steps

- [User sign-in with Microsoft Entra pass-through authentication](how-to-connect-pta.md)

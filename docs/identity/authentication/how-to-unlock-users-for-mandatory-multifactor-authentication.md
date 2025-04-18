---
title: How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory Microsoft Entra multifactor authentication (MFA) requirement 
description: A script to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory Microsoft Entra multifactor authentication (MFA) requirement.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 04/18/2025
ms.author: justinha
author: najshahid
manager: femila
ms.reviewer: nashahid

# Customer intent: As an identity administrator, I want to unlock users who are locked out by mandatory Microsoft Entra multifactor authentication (MFA).
---
# How to postpone enforcement for a tenant where users are unable to sign in after rollout of mandatory MFA requirement

Users might not be able to sign into the Azure portal, Microsoft Entra admin center or Microsoft Intune admin center if they have trouble using their MFA method after the mandatory requirement to use MFA is rolled out to their tenant. 
 
If users are unable to sign in, you can run the following script as a Global Administrator to temporarily postpone the MFA enforcement for your tenant. The script does the following actions:

- Asks for tenant ID, and optionally the date of enforcement. The default date is September 30th, 2025. 

  If you don't know your tenant ID, the script tries to find it based on your username. If you have multiple tenants, the script confirms which tenant is affected.

- Logs the user into that tenant.
- Gets the relevant authentication tokens.
- Checks if user has elevated access. If not, the script does the elevation.
- Checks if the appropriate role is assigned for the user on the settings resource provider (RP). If not, the script assigns the appropriate role.
- Updates the enforcement date in Entra ID.
- If the script added elevated access, it tries to remove it.

## Prerequisites

- [Az PowerShell module](/powershell/azure/what-is-azure-powershell)
- [Global Administrator role](/entra/identity/role-based-access-control/permissions-reference#global-administrator)

## Script

```powershell

```

## Related content

- [Planning for mandatory MFA for Azure and other admin portals](concept-mandatory-multifactor-authentication.md)
- [How to verify that users are set up for mandatory MFA](how-to-mandatory-multifactor-authentication.md)
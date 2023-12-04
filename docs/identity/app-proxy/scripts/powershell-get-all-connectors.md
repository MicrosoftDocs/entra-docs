---
title: PowerShell sample - List all Microsoft Entra application proxy connector groups
description: PowerShell example that lists all Microsoft Entra application proxy connector groups and connectors in your directory.
services: active-directory
author: kenwith
manager: amycolannino
ms.service: active-directory
ms.subservice: app-proxy
ms.workload: identity
ms.custom: has-azure-ad-ps-ref
ms.topic: sample
ms.date: 08/29/2022
ms.author: kenwith
ms.reviewer: ashishj
---

# Get all Application Proxy connector groups and connectors in the directory

This PowerShell script example lists all Microsoft Entra application proxy connector groups and connectors in your directory.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

[!code-azurepowershell[main](~/../powershell_scripts/application-proxy/get-all-connectors.ps1 "Get all connector groups and connectors in the directory")]

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph |
|Get-MgBetaOnPremisePublishingProfileConnectorGroup(/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroup)| Gets a connector group |
|Get-MgBetaOnPremisePublishingProfileConnectorGroupMember(/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisespublishingprofileconnectorgroupmember)|Gets the members of a connector group |

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).

---
title: PowerShell sample - Move Microsoft Entra application proxy apps to another group
description: Microsoft Entra application proxy PowerShell example used to move all applications currently assigned to a connector group to a different connector group.
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

# Move all Microsoft Entra application proxy apps assigned to a connector group to another connector group

This PowerShell script example moves all Microsoft Entra application proxy applications currently assigned to a connector group to a different connector group.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

[!code-azurepowershell[main](~/../powershell_scripts/application-proxy/move-all-apps-to-a-connector-group.ps1 "Move all apps assigned to a connector group to another connector group")]

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal)| Gets a service principal|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroup](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplication)| Gets an Enterprise Application|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroupApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroupapplication)| Lists applications assigned to a connector group |
|[Set-MgBetaApplicationConnectorGroupByRef](/powershell/module/microsoft.graph.beta.applications/set-mgbetaapplicationconnectorgroupbyref)| Assigns an application to the connector group|

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).

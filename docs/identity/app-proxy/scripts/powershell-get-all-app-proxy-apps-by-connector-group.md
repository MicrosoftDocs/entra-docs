---
title: List Microsoft Entra application proxy connector groups for apps
description: PowerShell example that lists all Microsoft Entra application proxy Connector groups with the assigned applications.
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

# Get all Application Proxy apps and list by connector group

This PowerShell script example lists information about all Microsoft Entra application proxy Connector groups with the assigned applications.

[!INCLUDE [quickstarts-free-trial-note](~/../azure-docs-pr/includes/quickstarts-free-trial-note.md)]

[!INCLUDE [updated-for-az](~/../azure-docs-pr/includes/updated-for-az.md)]

[!INCLUDE [cloud-shell-try-it.md](~/../azure-docs-pr/includes/cloud-shell-try-it.md)]

This sample requires the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer.

## Sample script

[!code-azurepowershell[main](~/../powershell_scripts/application-proxy/get-all-appproxy-apps-by-connectorgroup.ps1 "Get all Application Proxy Connector groups with the assigned applications")]

## Script explanation

| Command | Notes |
|---|---|
|[Connect-MgGraph](/powershell/module/microsoft.graph.authentication/connect-mggraph)| Connects to Microsoft Graph|
|[Get-MgBetaServicePrincipal](/powershell/module/microsoft.graph.applications/get-mgserviceprincipal)| Gets a service principal|
|[Get-MgBetaApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaapplication)| Gets an Enterprise Application|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroup](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroup)| Gets a connector group|
|[Get-MgBetaOnPremisePublishingProfileConnectorGroupApplication](/powershell/module/microsoft.graph.beta.applications/get-mgbetaonpremisepublishingprofileconnectorgroupapplication)| Gets applications assigned to a connector group|

## Next steps

For more information on the Microsoft Graph PowerShell module, see [Microsoft Graph PowerShell overview](/powershell/microsoftgraph/overview).

For other PowerShell examples for Application Proxy, see [Microsoft Entra application proxy PowerShell examples](../application-proxy-powershell-samples.md).

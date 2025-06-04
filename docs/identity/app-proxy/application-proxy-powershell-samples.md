---
title: PowerShell samples for Microsoft Entra application proxy
description: Use these PowerShell samples for Microsoft Entra application proxy to get information about application proxy apps and connectors in your directory, assign users and groups to apps, and get certificate information.
author: kenwith
manager: 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: sample
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Microsoft Entra application proxy PowerShell examples

The following table includes links to PowerShell script examples for Microsoft Entra application proxy. These samples require the [Microsoft Graph Beta PowerShell module](/powershell/microsoftgraph/installation) 2.10 or newer, unless otherwise noted.


For more information about the cmdlets used in these samples, see [application proxy application management](/powershell/module/azuread/#application_proxy_application_management) and [private network connector management](/powershell/module/azuread/#application_proxy_connector_management).

| Link | Description |
|---|---|
|**Application proxy apps**||
| [List basic information for all application proxy apps](scripts/powershell-get-all-app-proxy-apps-basic.md) | Lists basic information (AppId, DisplayName, ObjId) about all the application proxy apps in your directory. |
| [List extended information for all application proxy apps](scripts/powershell-get-all-app-proxy-apps-extended.md) | Lists extended information  (AppId, DisplayName, ExternalUrl, InternalUrl, ExternalAuthenticationType) about all the application proxy apps in your directory.  |
| [List all application proxy apps by connector group](scripts/powershell-get-all-app-proxy-apps-by-connector-group.md) | Lists information about all the application proxy apps in your directory and which connector groups the apps are assigned to. |
| [Get all application proxy apps with a token lifetime policy](scripts/powershell-get-all-app-proxy-apps-with-policy.md) | Lists all application proxy apps in your directory with a token lifetime policy and its details.|
|**Connector groups**||
| [Get all connector groups and connectors in the directory](scripts/powershell-get-all-connectors.md) | Lists all the connector groups and connectors in your directory. |
| [Move all apps assigned to a connector group to another connector group](scripts/powershell-move-all-apps-to-connector-group.md) | Moves all applications currently assigned to a connector group to a different connector group. |
|**Users and group assigned**||
| [Display users and groups assigned to an application proxy application](scripts/powershell-display-users-group-of-app.md) | Lists the users and groups assigned to a specific application proxy application. |
| [Assign a user to an application](scripts/powershell-assign-user-to-app.md) | Assigns a specific user to an application. |
| [Assign a group to an application](scripts/powershell-assign-group-to-app.md) | Assigns a specific group to an application. |
|**External URL configuration**||
| [Get all application proxy apps using default domains (.msappproxy.net)](scripts/powershell-get-all-default-domain-apps.md)  | Lists all the application proxy applications using default domains (.msappproxy.net). |
| [Get all application proxy apps using wildcard publishing](scripts/powershell-get-all-wildcard-apps.md) | Lists all application proxy apps using wildcard publishing. |
|**Custom Domain configuration**||
| [Get all application proxy apps using custom domains and certificate information](scripts/powershell-get-all-custom-domains-and-certs.md) | Lists all application proxy apps that are using custom domains and the certificate information associated with the custom domains. |
| [Get all Microsoft Entra ID Proxy application apps published with no certificate uploaded](scripts/powershell-get-all-custom-domain-no-cert.md) | Lists all application proxy apps that are using custom domains but don't have a valid TLS/SSL certificate uploaded. |
| [Get all Microsoft Entra ID Proxy application apps published with the identical certificate](scripts/powershell-get-custom-domain-identical-cert.md) | Lists all the Microsoft Entra ID Proxy application apps published with the identical certificate. |
| [Get all Microsoft Entra ID Proxy application apps published with the identical certificate and replace it](scripts/powershell-get-custom-domain-replace-cert.md) | For Microsoft Entra ID Proxy application apps that are published with an identical certificate, allows you to replace the certificate in bulk. |

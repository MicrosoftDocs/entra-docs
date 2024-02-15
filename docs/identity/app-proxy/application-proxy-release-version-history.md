---
title: 'Microsoft Entra application proxy: Version release history'
description: This article lists all releases of Microsoft Entra application proxy and describes new features and fixed issues.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.date: 02/14/2024
ms.subservice: app-proxy
ms.author: kenwith
ms.reviewer: ashishj
---

# Microsoft Entra application proxy: Version release history
This article lists the versions and features of Microsoft Entra application proxy. The Microsoft Entra ID team regularly updates application proxy with new features and functionality. Application proxy connectors are [updated automatically when a new major version is released](application-proxy-faq.yml#why-is-my-connector-still-using-an-older-version-and-not-auto-upgraded-to-latest-version-). 

Make sure that auto updates are enabled for your connectors to get the latest features and bug fixes. Microsoft Support might ask you to install the latest connector version to resolve a problem.

Here's a list of related resources:

| Resource                                         | Details                                                      |
| ------------------------------------------------ | ------------------------------------------------------------ |
| How to enable application proxy                  | Prerequisites for enabling application proxy and installing and registering a connector are described in this [tutorial](application-proxy-add-on-premises-application.md). |
| Understand Microsoft Entra application proxy connectors | Find out more about [connector management](application-proxy-connectors.md) and how connectors [autoupgrade](application-proxy-connectors.md#automatic-updates). |
| Microsoft Entra application proxy connector Download    | [Download the latest connector](https://download.msappproxy.net/subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/connector/download). |

## Version 1.5.3437.0

### Release status

June 20, 2023: Released for download. This version is only available for install via the download page.

### New features and improvements

- Support for Microsoft Entra Private Access.
- Updated third party notices.

### Fixed issues
- Silent registration of connector with credentials. For more information, see [Create an unattended installation script for the Microsoft Entra application proxy connector](application-proxy-register-connector-powershell.md).
- Fixed dropping of `Secure` and `HttpOnly` attributes on the cookies passed by backend servers when there are trailing spaces in these attributes.
- Fixed services crash when back-end server of an application sets "Set-Cookie" header with empty value.

> [!IMPORTANT]
> **.NET Framework**
>
> You must have .NET version 4.7.1 or higher to install, or upgrade, application proxy version 1.5.3437.0 or later. Windows Server 2012 R2 and Windows Server 2016 may not have this by default. For more information, see [How to: Determine which .NET Framework versions are installed](/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed).

## Version 1.5.2846.0

### Release status

March 22, 2022: Released for download. This version is only available for install via the download page.

### New features and improvements

- Increased the number of HTTP headers supported on HTTP requests from 41 to 60.
- Improved error handling of SSL failures between the connector and Azure services.
- Updated the default connection limit to 200 for connector traffic when going through outbound proxy. To learn more about outbound proxy, see [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md#use-the-outbound-proxy-server).
- Deprecated the use of Active Directory Authentication Library (ADAL) and implemented Microsoft Authentication Library (MSAL) as part of the connector installation flow.

### Fixed issues
- Return original error code and response instead of a 400 Bad Request code for failing websocket connect attempts.

## Version 1.5.1975.0

### Release status

July 22, 2020: Released for download.
This version is only available for install via the download page. 

### New features and improvements
-	Improved support for Azure Government cloud environments. For steps on how to properly install the connector for Azure Government cloud review the [prerequisites](~/identity/hybrid/connect/reference-connect-government-cloud.md#allow-access-to-urls) and [installation steps](~/identity/hybrid/connect/reference-connect-government-cloud.md#install-the-agent-for-the-azure-government-cloud).
- Support for using the Remote Desktop Services web client with application proxy. For more information, see [Publish Remote Desktop with Microsoft Entra application proxy](application-proxy-integrate-with-remote-desktop-services.md).
- Improved websocket extension negotiations. 
- Support for optimized routing between connector groups and application proxy cloud services based on region. For more information, see [Optimize traffic flow with Microsoft Entra application proxy](application-proxy-network-topology.md). 

### Fixed issues
- Fixed a websocket issue that forced lowercase strings.
- Fixed an issue that caused connectors to be occasionally unresponsive.

## Version 1.5.1626.0

### Release status

July 17, 2020: Released for download. 
This version is only available for install via the download page. 

### Fixed issues
- Resolved memory leak issues present in previous version.
- Completed general improvements for websocket support.

## Version 1.5.1526.0

### Release status

April 07, 2020: Released for download.
This version is only available for install via the download page. 

### New features and improvements
- Connectors only use Transport Layer Security (TLS) 1.2 for all connections. See [connector prerequisites](application-proxy-add-on-premises-application.md#prerequisites) for more details.
- Improved signaling between the connector and Azure services. The signaling supports reliable sessions for Windows Communication Foundation (WCF) communication between the connector and Azure services and Domain Name System (DNS) caching improvements for WebSocket communications.
- Support for configuring a proxy between the connector and the backend application. For more information, see [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md).

### Fixed issues
- Removed falling back to port 8080 for communications from the connector to Azure services.
- Added debug traces for WebSocket communications. 
- Resolved preserving the SameSite attribute when set on backend application cookies.

## Version 1.5.612.0

### Release status

September 20, 2018: Released for download.

### New features and improvements

- Added WebSocket support for the QlikSense application. To learn more about how to integrate QlikSense with application proxy, see this [walkthrough](application-proxy-qlik.md). 
- Improved the installation wizard to make it easier to configure an outbound proxy. 
- Set TLS 1.2 as the default protocol for connectors. 
- Added a new End-User License Agreement (EULA).  

### Fixed issues

- A bug that caused memory leaks in the connector was fixed.
- Azure Service Bus version updated, which includes a bug fix for connector timeout issues.

## Version 1.5.402.0

### Release status

January 19, 2018: Released for download.

### Fixed issues

- Added support for custom domains that need domain translation in the cookie.

## Version 1.5.132.0

### Release status 

May 25, 2017: Released for download.

### New features and improvements 

Improved control over connectors' outbound connection limits. 

## Version 1.5.36.0

### Release status

April 15, 2017: Released for download.

### New features and improvements

- Simplified onboarding and management with fewer required ports. Application proxy now requires opening only two standard outbound ports: 443 and 80. Application proxy continues to use only outbound connections, so you still don't need any components in a public facing network. For more information, see our [configuration documentation](application-proxy-add-on-premises-application.md).  
- If supported by your external proxy or firewall, you can now open your network by DNS instead of IP range. Application proxy services require connections to `*.msappproxy.net` and `*.servicebus.windows.net` only.


## Earlier versions

If you're using an application proxy connector version earlier than 1.5.36.0, update to the latest version to ensure you have the latest fully supported features.

## Next steps
- [Remote access to on-premises applications through Microsoft Entra application proxy](overview-what-is-app-proxy.md)
- [Tutorial: Add an on-premises application for remote access through application proxy](application-proxy-add-on-premises-application.md)

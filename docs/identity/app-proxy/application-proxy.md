---
title: Understand remote access to on-premises apps - Microsoft Entra application proxy
description: Microsoft Entra application proxy provides secure remote access to on-premises web applications. After a single sign-on to Microsoft Entra ID, users can access both cloud and on-premises applications through an external URL or an internal application portal. For example, application proxy can provide remote access and single sign-on to Remote Desktop, SharePoint, Teams, Tableau, Qlik, and line of business (LOB) applications.
services: active-directory
author: kenwith
manager: amycolannino
ms.service: active-directory
ms.subservice: app-proxy
ms.topic: conceptual
ms.date: 09/14/2023
ms.author: kenwith
ms.reviewer: ashishj
---

# Understand remote access to on-premises applications through Microsoft Entra application proxy

Microsoft Entra application proxy provides secure remote access to on-premises web applications. After a single sign-on to Microsoft Entra ID, users can access both cloud and on-premises applications through an external URL or an internal application portal. For example, application proxy can provide remote access and single sign-on to Remote Desktop, SharePoint, Teams, Tableau, Qlik, and line of business (LOB) applications.

Microsoft Entra application proxy is:

- **Simple to use**. Users can access your on-premises applications the same way they access Microsoft 365 and other SaaS apps integrated with Microsoft Entra ID. You don't need to change or update your applications to work with application proxy.

- **Secure**. On-premises applications can use Azure's authorization controls and security analytics. For example, on-premises applications can use Conditional Access and two-step verification. Application proxy doesn't require you to open inbound connections through your firewall.

- **Cost-effective**. On-premises solutions typically require you to setup and maintain demilitarized zones (DMZs), edge servers, or other complex infrastructures. Application proxy runs in the cloud, which makes it easy to use. To use application proxy, you don't need to change the network infrastructure or install more appliances in your on-premises environment.

## What is application proxy?
Application proxy is a feature of Microsoft Entra ID that enables users to access on-premises web applications from a remote client. Application proxy includes both the application proxy service, which runs in the cloud, and the application proxy connector, which runs on an on-premises server. Microsoft Entra ID, the application proxy service, and the application proxy connector work together to securely pass the user sign-on token from Microsoft Entra ID to the web application.

Application proxy works with:

* Web applications that use [Integrated Windows authentication](./how-to-configure-sso-with-kcd.md) for authentication
* Web applications that use form-based or [header-based](./application-proxy-configure-single-sign-on-with-headers.md) access
* Web APIs that you want to expose to rich applications on different devices
* Applications hosted behind a [Remote Desktop Gateway](./application-proxy-integrate-with-remote-desktop-services.md)
* Rich client apps that are integrated with the Microsoft Authentication Library (MSAL)

Application proxy supports single sign-on. For more information on supported methods, see [Choosing a single sign-on method](~/identity/enterprise-apps/plan-sso-deployment.md#choosing-a-single-sign-on-method).

Application proxy is recommended for giving remote users access to internal resources. Application proxy replaces the need for a VPN or reverse proxy. It isn't intended for internal users on the corporate network.  These users who unnecessarily use application proxy can introduce unexpected and undesirable performance issues.

## How application proxy works

The diagram shows how Microsoft Entra ID and application proxy work together to provide single sign-on to on-premises applications.

![Microsoft Entra application proxy diagram](./media/application-proxy/azureappproxxy.png)

1. A user is directed to the Microsoft Entra sign-in page after accessing the application through an endpoint.
2. Microsoft Entra ID sends a token to the user's client device after a successful sign-in.
3. The client sends the token to the application proxy service. The service retrieves the user principal name (UPN) and security principal name (SPN) from the token. Application proxy then sends the request to the connector.
4. The connector performs single sign-on (SSO) authentication required on behalf of the user.
5. The connector sends the request to the on-premises application.
6. The response is sent through the connector and application proxy service to the user.

> [!NOTE]
> Like most Microsoft Entra hybrid agents, the application proxy connector doesn't require you to open inbound connections through your firewall. User traffic in step 3 terminates at the application proxy Service (in Microsoft Entra ID). The application proxy connector (on-premises) is responsible for the rest of the communication.
>


| Component | Description |
| --------- | ----------- |
| Endpoint  | The endpoint is a URL or an [end-user portal](~/identity/enterprise-apps/end-user-experiences.md). Users can reach applications while outside of your network by accessing an external URL. Users within your network can access the application through a URL or an end-user portal. When users go to one of these endpoints, they authenticate in Microsoft Entra ID and then are routed through the connector to the on-premises application.|
| Microsoft Entra ID | Microsoft Entra ID performs the authentication using the tenant directory stored in the cloud. |
| Application proxy service | This application proxy service runs in the cloud as part of Microsoft Entra ID. It passes the sign-on token from the user to the application proxy connector. Application proxy forwards any accessible headers on the request and sets the headers as per its protocol, to the client IP address. If the incoming request to the proxy already has that header, the client IP address is added to the end of the comma separated list that is the value of the header.|
| Application proxy connector | The connector is a lightweight agent that runs on a Windows Server inside your network. The connector manages communication between the application proxy service in the cloud and the on-premises application. The connector only uses outbound connections, so you don't have to open inbound ports in Internet facing networks. The connectors are stateless and pull information from the cloud as necessary. For more information about connectors, like how they load-balance and authenticate, see [Understand Microsoft Entra application proxy connectors](application-proxy-connectors.md).|
| Active Directory (AD) | Active Directory runs on-premises to perform authentication for domain accounts. When single sign-on is configured, the connector communicates with AD to perform any extra authentication required.
| On-premises application | Finally, the user is able to access an on-premises application.

## Next steps

- [Tutorial: Add an on-premises application for remote access through application proxy](application-proxy-add-on-premises-application.md)

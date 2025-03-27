---
title: Troubleshoot Application Proxy
description: Learn how to troubleshoot errors in Microsoft Entra application proxy.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 02/21/2025
ms.author: kenwith
ms.reviewer: ashishj
---

# Troubleshoot application proxy problems and error messages

This article describes steps to troubleshoot issues and error messages in Microsoft Entra application proxy.

## Before you begin

The first thing to check is the connector. To learn how to debug a private network connector, see [Debug private network connector issues](application-proxy-debug-connectors.md). If you're still having issues, return to this article to troubleshoot the application.  

If errors occur in accessing a published application or in publishing applications, check the following options to see if Microsoft Entra application proxy is working correctly:

* Open the Windows Services console. Verify that the **Microsoft Entra private network connector** service is enabled and running. Look at the application proxy service properties page, as shown in the image.  
  ![Microsoft Entra private network connector Properties window screenshot](./media/application-proxy-troubleshoot/connectorproperties.png)
* Open Event Viewer and look for private network connector events in **Applications and Services Logs** > **Microsoft** > **Microsoft Entra private network** > **Connector** > **Admin**.
* Review detailed logs. [Turn on private network connector session logs](application-proxy-connectors.md#under-the-hood).

## The page doesn't render correctly

You have problems with your application rendering or it functions incorrectly, but no specific error messages appear.

This problem occurs if you published the article path, but the application requires content that exists outside that path.

For example, if you publish the path `https://yourapp/app` but the application calls images in `https://yourapp/media`, they aren't rendered. Make sure that you publish the application by using the highest-level path you need to include all relevant content. In this example, that level is `http://yourapp/`.

## An application proxy application takes too long to load

Applications can be functional but experience a long latency.

You can make changes to your network topology to improve the application speed. For an evaluation of different topologies, review [network considerations](application-proxy-network-topology.md).

## The application page doesn't display correctly for an application proxy app

When you publish an application proxy app, only pages in your root directory are accessible when you access the application. If the page doesn't render correctly, the root internal URL that's used for the application might be missing some page resources.

Verify that the issue is missing resources:

1. Open your network tracker, such as by using Fiddler or browser developer tools. To use the browser's developer tools (F12 tools in Internet Explorer or Microsoft Edge), check for publishing issues as described in [Application page doesn't display correctly](application-proxy-page-appearance-broken-problem.md).
1. Load the page.
1. Look for 404 errors.

A 404 error indicates that pages can't be found and that you need to publish them.

To resolve this issue, publish *all* the resources for the page as part of your application.

For example, you publish an expenses application by using the internal URL `http://myapps/expenses`, but the app uses the stylesheet `http://myapps/style.css`. The stylesheet isn't in the folder that you published, so the stylesheet isn't yet published. Loading the expenses app shows a 404 error when the app tries to load `style.css`. In this example, resolve the problem by publishing the application by using the internal URL `http://myapp/`. That is, publish a path that includes all the resources the application uses.

## Problems with publishing as a single application

If you can't publish all resources in the same application, publish multiple applications and set up links between them. For this scenario, we recommend that you use [custom domains](how-to-configure-custom-domain.md). However, this solution requires that you own the certificate for your domain and that your applications use fully qualified domain names (FQDNs). For other options, see the [troubleshoot broken links documentation](application-proxy-page-links-broken-problem.md).

For more information, see [I can get to my application, but the links on the application page don't work](application-proxy-page-links-broken-problem.md).

## Connectivity problem with an application

For causes and suggested resolutions, see [I don't know what ports to open for my application](application-proxy-add-on-premises-application.md).

## Problem configuring the Microsoft Entra application proxy in the admin portal

For causes and suggested resolutions, see [I don't know how to configure single sign-on to my application proxy application](how-to-configure-sso.md).

## Problem setting up back-end authentication to the application

For causes and suggested resolutions, see these articles:

* [I don't know how to configure Kerberos constrained delegation](application-proxy-back-end-kerberos-constrained-delegation-how-to.md).
* [I don't know how to configure my application by using PingAccess](application-proxy-ping-access-publishing-guide.md).

## Problem signing in to the application

You might be unable to sign in to your application, and you see the error "Can't Access this Corporate Application." To solve this issue, see [Bad gateway timeout error](application-proxy-sign-in-bad-gateway-timeout-error.md).

## Problem with the private network connector

For causes and suggested resolutions, see [I have issues installing the private network connector](application-proxy-connector-installation-problem.md).

## Kerberos errors

For descriptions and suggested resolutions for more common errors in Kerberos setup and configuration, see the following table:

| Error | Recommended steps |
| ----- | ----------------- |
| `Failed to retrieve the current execution policy for running PowerShell scripts.` | If the connector installation fails, check to make sure that the PowerShell execution policy isn't disabled.<br><br>1. Open the Group Policy Editor.<br>2. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows PowerShell**, and then double-click **Turn on Script Execution**.<br>3. The execution policy can be set to either **Not Configured** or **Enabled**. If the policy is set to **Enabled**, make sure that under **Options**, the execution policy is set to either **Allow local scripts and remote signed scripts** or **Allow all scripts**. |
| `12008 - Microsoft Entra exceeded the maximum number of permitted Kerberos authentication attempts to the backend server.` | This error indicates incorrect configuration between Microsoft Entra ID and the back-end application server, or there's a problem with the time and date configuration on both computers. The back-end server declined the Kerberos ticket that Microsoft Entra ID created. Verify that Microsoft Entra ID and the back-end application server are configured correctly. Make sure that the time and date configuration on the Microsoft Entra ID and back-end application server are synchronized. |
| `13016 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because there is no UPN in the edge token or in the access cookie.` | There's a problem with the Security Token Service (STS) configuration. Fix the User Principal Name (UPN) claim configuration in the STS. |
| `13019 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because of the following general API error.` | This event indicates incorrect configuration between Microsoft Entra ID and the domain controller server, or a problem in time and date configuration on both machines. The domain controller declined the Kerberos ticket created by Microsoft Entra ID. Verify that Microsoft Entra ID and the back-end application server are configured correctly, especially the service principal name (SPN) configuration. Make sure the domain controller establishes trust with Microsoft Entra ID. Both should use the same domain. Make sure the time and date configuration on the Microsoft Entra ID and the domain controller are synchronized. |
| `13020 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because the back-end server SPN is not defined.` | This event indicates incorrect configuration between Microsoft Entra ID and the domain controller server, or a problem in time and date configuration on both machines. The domain controller declined the Kerberos ticket created by Microsoft Entra ID. Verify that Microsoft Entra ID and the back-end application server are configured correctly, especially the SPN configuration. Make sure the domain controller establishes trust with Microsoft Entra ID. Both should use the same domain. Make sure that the time and date configuration on the Microsoft Entra ID and the domain controller are synchronized. |
| `13022 - Microsoft Entra ID cannot authenticate the user because the back-end server responds to Kerberos authentication attempts with an HTTP 401 error.` | This event indicates incorrect configuration between Microsoft Entra ID and the back-end application server, or a problem in time and date configuration on both machines. The back-end server declined the Kerberos ticket created by Microsoft Entra ID. Verify that Microsoft Entra ID and the back-end application server are configured correctly. Make sure that the time and date configuration on the Microsoft Entra ID and the back-end application server are synchronized. For more information, see [Troubleshoot Kerberos constrained delegation configurations for application proxy](application-proxy-back-end-kerberos-constrained-delegation-how-to.md).  |

## End-user errors

This list covers errors that your end users might encounter when they try to access the app and fail.

| Error | Recommended steps |
| ----- | ----------------- |
| `The website cannot display the page.` | Your user gets this error when trying to access the app you published if the application is an Integrated Windows Authentication (IWA) application. The defined SPN for this application is incorrect. For IWA apps, make sure that the SPN configured for this application is correct. |
| `The website cannot display the page.` | A user sees this error when they try to access an Outlook Web Application (OWA) app you published. The issue results from: <br><li>The defined SPN for this application is incorrect. Make sure that the SPN configured for this application is correct.</li><li>The user who tried to access the application is using a Microsoft account rather than the proper corporate account to sign in, or the user is a guest user. Make sure the user signs in by using their corporate account that matches the domain of the published application. Microsoft Account users and guest can't access IWA applications.</li><li>The user who tried to access the application isn't properly defined for this application on the on premises side. Make sure that this user has the proper permissions as defined for this back-end application on the on premises machine. |
| `This corporate app can’t be accessed. You are not authorized to access this application. Authorization failed. Make sure to assign the user with access to this application.` | Your user gets this error when trying to access the app you published if they use Microsoft accounts instead of their corporate account to sign in. Guest users get this error. Microsoft Account users and guests can't access IWA applications. Make sure the user signs in by using their corporate account that matches the domain of the published application.<br><br>You must assign the user for this application. Go to the **Application** tab, and under **Users and Groups**, assign this user or user group to this application.|
| `This corporate app can’t be accessed right now. Please try again later… The connector timed out.` | Your user gets this error when trying to access the app you published if they aren't properly defined for this application on the on-premises side. Make sure that your users have the proper permissions as defined for this back-end application on the on premises machine. |
| `This corporate app can’t be accessed. You are not authorized to access this application. Authorization failed. Make sure that the user has a license for Microsoft Entra ID P1 or P2.` | Your user gets this error when trying to access the app you published if they weren't explicitly assigned with a Premium license by the subscriber’s administrator. Go to the subscriber’s Active Directory **Licenses** tab and make sure that this user or user group is assigned a Premium license. |
| `A server with the specified host name could not be found.` | Your user gets this error when trying to access the app you published if the application's custom domain isn't configured correctly. Check the certificate for the domain and configure the Domain Name System (DNS) record correctly. For more information, see [Working with custom domains in Microsoft Entra application proxy](./how-to-configure-custom-domain.md). |
| `Forbidden: This corporate app can't be accessed OR The user could not be authorized. Make sure the user is defined in your on-premises AD and that the user has access to the app in your on-premises AD.` | The issue could be a problem with access to authorization information. To learn more, see (<https://support.microsoft.com/help/331951/some-applications-and-apis-require-access-to-authorization-information>). In a nutshell, add the private network connector machine account to the "Windows Authorization Access Group" builtin domain group to resolve. |
| `InternalServerError: This corporate app can’t be accessed right now. Please try again later… ConnectorError:Unauthorized.` | The connector secures outbound connections to the Microsoft Entra application proxy cloud service endpoints by using a client certificate. The error occurs when the client certificate fails to reach the endpoint. For example, a network device performing Transport Layer Security (TLS) inspection or breaking the TLS connection. Avoid inline inspection and termination of outbound TLS communications. Inspection and termination must not happen between Microsoft Entra private network connectors and Microsoft Entra application proxy cloud services.|

## Related content

* [Enable application proxy for Microsoft Entra ID](application-proxy-add-on-premises-application.md)
* [Publish applications with application proxy](application-proxy-add-on-premises-application.md)
* [Enable single sign-on](how-to-configure-sso-with-kcd.md)
* [Enable Conditional Access](./application-proxy-integrate-with-sharepoint-server.md)

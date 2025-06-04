---
title: Troubleshoot Application Proxy
description: Learn how to troubleshoot errors in Microsoft Entra application proxy.
author: kenwith
manager: 
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: ashishj
ai-usage: ai-assisted
---

# Troubleshoot application proxy issues and errors

This article describes steps you can take to troubleshoot issues and error messages in Microsoft Entra application proxy.

## Before you begin

The first thing to check is the connector. To learn how to debug a private network connector, see [Debug private network connector issues](application-proxy-debug-connectors.md). If you still have issues connecting to your application, return to this article to troubleshoot the application.  

If a user encounters an error while accessing or publishing an application, use these steps to verify that Microsoft Entra application proxy is functioning properly:

* Open the Windows Services console. Verify that the **Microsoft Entra private network connector** service is enabled and running. Look at the application proxy service properties page.

  :::image type="content" source="media/application-proxy-troubleshoot/connectorproperties.png" alt-text="Screenshot that shows the Microsoft Entra private network connector status as Running.":::
* Open Event Viewer. Go to **Applications and Services Logs** > **Microsoft** > **Microsoft Entra private network** > **Connector** > **Admin** and check for private network connector events.
* Review detailed logs. Learn how to [turn on private network connector session logs](application-proxy-connectors.md#under-the-hood).

## Application configuration errors

Review the following sections for common configuration issues and suggested resolutions.

### App doesn't render correctly

You have problems with your application rendering or it functions incorrectly, but no specific error message appears.

This problem occurs if an application requires content that exists outside the path you used to publish the app.

For example, if you publish the path `https://yourapp/app`, but the application refers to images that are located in `https://yourapp/media`, the images don't appear in the application.

Make sure that you publish the application by using the highest-level path you need to include all referenced content and files. In the example, that level is `http://yourapp/`.

Verify that the missing resources caused the issue:

1. Open your network tracker, such as by using Fiddler or browser developer tools (select F12 in Internet Explorer or Microsoft Edge).
1. Load the page.
1. Look for error ID 404 errors.

A 404 error indicates that pages can't be found and that you need to publish them.

### App takes too long to load

Applications can be functional but have a long latency.

You can make changes to your network topology to improve the application speed. Review [network considerations](application-proxy-network-topology.md).

### Problem publishing as a single application

If you can't publish all resources in the same application, publish multiple applications and set up links between them. For this scenario, we recommend that you use [custom domains](how-to-configure-custom-domain.md). However, this solution requires that you own the certificate for your domain and that your applications use fully qualified domain names (FQDNs). For other options, [troubleshoot broken links](application-proxy-page-links-broken-problem.md).

### Problem setting up connectivity for an app

For causes and suggested resolutions, see [Ports to open for an application proxy application](application-proxy-add-on-premises-application.md).

### Problem configuring the Microsoft Entra application proxy in the admin portal

For causes and suggested resolutions, see [Single sign-on in an application proxy application](how-to-configure-sso.md).

### Problem setting back-end authentication to the application

For causes and suggested resolutions, see these articles:

* [Troubleshoot Kerberos constrained delegation](application-proxy-back-end-kerberos-constrained-delegation-how-to.md)
* [Single sign-on by using application proxy and PingAccess](application-proxy-ping-access-publishing-guide.md)

### Can't sign in to the application

If you see the error `This corporate app can’t be accessed` and you can't sign in to your application, a configuration error occurred. For suggested resolutions, see [Troubleshoot bad gateway time-out errors](application-proxy-sign-in-bad-gateway-timeout-error.md).

### Private network connector errors

For causes and suggested resolutions, see [Install the private network connector](application-proxy-connector-installation-problem.md).

## Kerberos errors

The following table describes the more common errors and their resolution in Kerberos setup and configuration:

| Error | Explanation and steps to take |
| ----- | ----------------- |
| `Failed to retrieve the current execution policy for running PowerShell scripts.` | If the connector installation fails, check to make sure that the PowerShell execution policy isn't disabled.<br><br>1. Open the Group Policy Editor.<br>2. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows PowerShell**, and then double-click **Turn on Script Execution**.<br>3. The execution policy can be set to either **Not Configured** or **Enabled**. If the policy is set to **Enabled**, make sure that under **Options**, the execution policy is set to either **Allow local scripts and remote signed scripts** or **Allow all scripts**. |
| `12008 - Microsoft Entra exceeded the maximum number of permitted Kerberos authentication attempts to the backend server.` | This error indicates incorrect configuration between Microsoft Entra ID and the back-end application server, or there's a problem with the time and date configuration on both computers. The back-end server declined the Kerberos ticket that Microsoft Entra ID created. <br><br> Verify that Microsoft Entra ID and the back-end application server are configured correctly. Make sure that the time and date configuration on the Microsoft Entra ID and back-end application server are synchronized. |
| `13016 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because there is no UPN in the edge token or in the access cookie.` | There's a problem with the security token service (STS) configuration. Fix the User Principal Name (UPN) claim configuration in the STS. |
| `13019 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because of the following general API error.` | This event indicates incorrect configuration between Microsoft Entra ID and the domain controller server, or a problem in time and date configuration on both machines. The domain controller declined the Kerberos ticket created by Microsoft Entra ID. <br><br> Verify that Microsoft Entra ID and the back-end application server are configured correctly, especially the service principal name (SPN) configuration. Make sure the domain controller establishes trust with Microsoft Entra ID. Both should use the same domain. Make sure the time and date configuration on the Microsoft Entra ID and the domain controller are synchronized. |
| `13020 - Microsoft Entra ID cannot retrieve a Kerberos ticket on behalf of the user because the back-end server SPN is not defined.` | This event indicates incorrect configuration between Microsoft Entra ID and the domain controller server, or a problem in time and date configuration on both machines. The domain controller declined the Kerberos ticket created by Microsoft Entra ID. <br><br> Verify that Microsoft Entra ID and the back-end application server are configured correctly, especially the SPN configuration. Make sure the domain controller establishes trust with Microsoft Entra ID. Both should use the same domain. Make sure that the time and date configuration on the Microsoft Entra ID and the domain controller are synchronized. |
| `13022 - Microsoft Entra ID cannot authenticate the user because the back-end server responds to Kerberos authentication attempts with an HTTP 401 error.` | This event indicates incorrect configuration between Microsoft Entra ID and the back-end application server, or a problem in time and date configuration on both machines. The back-end server declined the Kerberos ticket created by Microsoft Entra ID. <br><br> Verify that Microsoft Entra ID and the back-end application server are configured correctly. Make sure that the time and date configuration on the Microsoft Entra ID and the back-end application server are synchronized. <br><br> For more information, see [Troubleshoot Kerberos constrained delegation configurations for application proxy](application-proxy-back-end-kerberos-constrained-delegation-how-to.md).  |

## App user errors

The following table describes errors an app user might encounter when they try to access an application proxy app:

| Error | Explanation and steps to take |
| ----- | ----------------- |
| `The website cannot display the page.` | A user sees the error when they try to access an Integrated Windows Authentication (IWA) app you published. The defined SPN for the application is incorrect. <br><br> Make sure the SPN for the application is correct. |
| `The website cannot display the page.` | A user sees the error when they try to access an Outlook Web Application (OWA) app you published. The issue results from: <br><br>- The defined SPN for the application is incorrect. Make sure the SPN for the application is correct.<br><br>- The user who tried to access the application is using a Microsoft account instead of their corporate account to sign in, or the user is a guest user. Make sure the user signs in by using a corporate account that matches the domain of the published application. Microsoft Account users and guests can't access IWA applications.<br><br>- The user who tried to access the application isn't properly defined for the application in the on-premises configuration. Make sure that the user has the required on-premises permissions to access the back-end application. |
| `This corporate app can’t be accessed. You are not authorized to access the application. Authorization failed. Make sure to assign the user with access to the application.` | This error occurs when a user tries to access an app using a Microsoft account or as a guest user. Microsoft Account users and guests can't access IWA applications. Ensure the user signs in with a corporate account matching the app's domain.<br><br>To fix the issue, go to the **Application** tab, under **Users and Groups**, and assign the user or group to the app. |
| `This corporate app can’t be accessed right now. Please try again later… The connector timed out.` | The user who tried to access the application isn't properly defined for the application in the on-premises configuration. Make sure that the user has the required on-premises permissions to access the back-end application. |
| `This corporate app can’t be accessed. You are not authorized to access the application. Authorization failed. Make sure that the user has a license for Microsoft Entra ID P1 or P2.` | A user sees the error when they try to access the app you published if they weren't explicitly assigned with a Premium license by the subscriber’s administrator. <br><br>On the subscriber’s Microsoft Entra ID **Licenses** tab, make sure that the user or user group is assigned a Premium license. |
| `A server with the specified host name could not be found.` | A user sees the error when they try to access the app you published and the application's custom domain isn't configured correctly. <br><br> Check the certificate for the domain and configure the Domain Name System (DNS) record correctly. <br><br> For more information, see [Work with custom domains in Microsoft Entra application proxy](./how-to-configure-custom-domain.md). |
| `Forbidden: This corporate app can't be accessed OR The user could not be authorized. Make sure the user is defined in your on-premises AD and that the user has access to the app in your on-premises AD.` | The issue might be a problem with access to authorization information. To learn more, see (<https://support.microsoft.com/help/331951/some-applications-and-apis-require-access-to-authorization-information>). <br><br> To resolve the error, add the private network connector machine account to the Windows Authorization Access Group built-in domain group. |
| `InternalServerError: This corporate app can’t be accessed right now. Please try again later… ConnectorError:Unauthorized.` | The connector uses a client certificate to secure outbound connections to Microsoft Entra application proxy cloud service endpoints. The error occurs when the client certificate fails to reach the endpoint. For example, it might occur when a network device performs Transport Layer Security (TLS) inspection or breaks the TLS connection. <br><br> To resolve the error, avoid inline inspection and termination of outbound TLS communications. Inspection and termination must not happen between Microsoft Entra private network connectors and Microsoft Entra application proxy cloud services.|

## Related content

* [Enable application proxy for Microsoft Entra ID](application-proxy-add-on-premises-application.md)
* [Publish applications with application proxy](application-proxy-add-on-premises-application.md)
* [Enable single sign-on](how-to-configure-sso-with-kcd.md)
* [Enable Conditional Access](./application-proxy-integrate-with-sharepoint-server.md)

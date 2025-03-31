---
title: Debug Application Proxy Issues
description: Learn how to debug issues that might occur when you configure Microsoft Entra application proxy.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 02/21/2025
ms.author: kenwith
ms.reviewer: ashishj
---

# Debug application proxy issues

This article describes steps you can take to troubleshoot issues with Microsoft Entra application proxy. Use the flowchart to troubleshoot remote access to an on-premises web application.

## Before you begin

The first thing to check is the connector. To learn how, see [Debug private network connector issues](application-proxy-debug-connectors.md).

If you still have application proxy issues, return to this article to troubleshoot the application.  

## Flowchart for application issues

The flowchart contains the steps to debug common issues.

The table that appears after the flowchart contains details about each step.

![Diagram of a flowchart that shows steps to debug an application for application proxy issues.](media/application-proxy-debug-apps/application-proxy-apps-debugging-flowchart.png)

| Step | Action | Description |
|---------|---------|---------|
|1 | Open a browser, access the app, and enter your credentials | Try using your username and password to sign in to the app. Check for any user-related errors, like [This corporate app can't be accessed](application-proxy-sign-in-bad-gateway-timeout-error.md). |
|2 | Verify user assignment to the app | Make sure that your user account has permissions to access the app from inside the corporate network. Then test signing in to the app by completing the steps in [Test the application](application-proxy-add-on-premises-application.md#test-the-application). If sign-in issues persist, see [How to troubleshoot sign-in errors](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context).  |
|3 | Open a browser and try to access the app | If an error appears immediately, check to see that application proxy is configured correctly. For details about specific error messages, see [Troubleshoot application proxy problems and error messages](application-proxy-troubleshoot.md).  |
|4 | Check your custom domain setup or troubleshoot the error | If the page doesn't display at all, make sure that your custom domain is configured correctly. Review the information in [Work with custom domains](how-to-configure-custom-domain.md).<br></br>If the page doesn't load and an error message appears, troubleshoot the error by using the information in [Troubleshoot application proxy problems and error messages](application-proxy-troubleshoot.md). <br></br>If it takes longer than 20 seconds for an error message to appear, there might be a connectivity issue. Complete the steps described in [Debug private network connectors](application-proxy-debug-connectors.md).  |
|5 | If issues persist, go to connector debugging | There might be a connectivity issue between the proxy and the connector or between the connector and the back end. Complete the steps described in [Debug private network connectors](application-proxy-debug-connectors.md). |
|6 | Publish all resources, check browser developer tools, and fix links | Make sure that the publishing path includes all the necessary images, scripts, and style sheets for your application. For details, see [Add an on-premises app to Microsoft Entra ID](application-proxy-add-on-premises-application.md). <br></br>Use the browser's developer tools (F12 tools in Internet Explorer or Microsoft Edge) to check for publishing issues as described in [Application page doesn't display correctly](application-proxy-page-appearance-broken-problem.md). <br></br>Review options to resolve broken links in [Links on the page don't work](application-proxy-page-links-broken-problem.md). |
|7 | Check for network latency | If the page loads slowly, learn about ways to minimize network latency in [Considerations for reducing latency](application-proxy-network-topology.md#considerations-for-reducing-latency). |
|8 | See more troubleshooting help | If issues persist, find more articles about [troubleshooting application proxy](application-proxy-troubleshoot.md). |

## Related content

- [Understand private network connectors](application-proxy-connectors.md)
- [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md)
- [Troubleshoot application proxy and connector errors](application-proxy-troubleshoot.md)

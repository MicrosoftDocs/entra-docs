---
title: Debug application proxy applications
description: Debug issues with Microsoft Entra application proxy applications.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 02/26/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Debug application proxy application issues 

This article includes steps to troubleshoot issues with Microsoft Entra application proxy. Use the flowchart to troubleshoot remote access to an on-premises web application. 

## Before you begin

The first thing to check is the connector. To learn how to debug a private network connector, see [Debug private network connector issues](application-proxy-debug-connectors.md). If you're still having issues, return to this article to troubleshoot the application.  

## Flowchart for application issues

The flowchart contains the steps for debugging common issues. The table after the flowchart contains details about each step.

![Flowchart showing steps for debugging an application](media/application-proxy-debug-apps/application-proxy-apps-debugging-flowchart.png)

| Step | Action | Description |
|---------|---------|---------|
|1 | Open a browser, access the app, and enter your credentials | Try using your credentials to sign in to the app, and check for any user-related errors, like [This corporate app can't be accessed](application-proxy-sign-in-bad-gateway-timeout-error.md). |
|2 | Verify user assignment to the app | Make sure your user account has permission to access the app from inside the corporate network, and then test signing in to the app by following the steps in [Test the application](application-proxy-add-on-premises-application.md#test-the-application). If sign-in issues persist, see [How to troubleshoot sign-in errors](~/identity/monitoring-health/concept-provisioning-logs.md?context=azure/active-directory/manage-apps/context/manage-apps-context).  |
|3 | Open a browser and try to access the app | If an error appears immediately, check to see that application proxy is configured correctly. For details about specific error messages, see [Troubleshoot application proxy problems and error messages](application-proxy-troubleshoot.md).  |
|4 | Check your custom domain setup or troubleshoot the error | If the page doesn't display at all, make sure your custom domain is configured correctly by reviewing [Working with custom domains](how-to-configure-custom-domain.md).<br></br>If the page doesn't load and an error message appears, troubleshoot the error by referring to  [Troubleshoot application proxy problems and error messages](application-proxy-troubleshoot.md). <br></br>If it takes longer than 20 seconds for an error message to appear, there could be connectivity issue. Go to the [Debug private network connectors](application-proxy-debug-connectors.md) troubleshooting article.  |
|5 | If issues persist, go to connector debugging | There could be a connectivity issue between the proxy and the connector or between the connector and the back end. Go to the [Debug private network connectors](application-proxy-debug-connectors.md) troubleshooting article. |
|6 | Publish all resources, check browser developer tools, and fix links | Make sure the publishing path includes all the necessary images, scripts, and style sheets for your application. For details, see [Add an on-premises app to Microsoft Entra ID](application-proxy-add-on-premises-application.md). <br></br>Use the browser's developer tools (F12 tools in Internet Explorer or Microsoft Edge) and check for publishing issues as described in [Application page doesn't display correctly](application-proxy-page-appearance-broken-problem.md). <br></br>Review options for resolving broken links in [Links on the page don't work](application-proxy-page-links-broken-problem.md). |
|7 | Check for network latency | If the page loads slowly, learn about ways to minimize network latency in [Considerations for reducing latency](application-proxy-network-topology.md#considerations-for-reducing-latency). | 
|8 | See more troubleshooting help | If issues persist, find more troubleshooting articles in the [Application proxy troubleshooting documentation](application-proxy-troubleshoot.md). |

## Next steps

- [Understand private network connectors](application-proxy-connectors.md)
- [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md)
- [Troubleshoot application proxy and connector errors](application-proxy-troubleshoot.md)

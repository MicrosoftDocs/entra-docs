---
title: Can't access this Corporate Application error with Microsoft Entra application proxy app
description: How to resolve common access issues with Microsoft Entra application proxy applications.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: troubleshooting
ms.date: 02/14/2024
ms.author: kenwith
ms.reviewer: asteen
---

# Troubleshoot corporate access to an application

This article helps you troubleshoot common issues for the `This corporate app can't be accessed` error on a Microsoft Entra application proxy application.

## Overview

When you see this error, find the status code on the error page. The status code is one of the following status codes:

- **Gateway Timeout**: The application proxy service is unable to reach the connector. The error typically indicates a problem with the connector assignment, connector itself, or the networking rules around the connector.
- **Bad Gateway**: The connector is unable to reach the backend application. The error could indicate a misconfiguration of the application.
- **Forbidden**: The user isn't authorized to access the application. The error can happen when the user isn't assigned to the application in Microsoft Entra ID. The error can also happen if the user doesn't have permission to access the application on the backend.

To find the code, look at the text at the bottom left of the error message for the `Status Code` field.

![Example: Gateway timeout error](./media/application-proxy-sign-in-bad-gateway-timeout-error/connection-problem.png)

## Gateway Timeout errors

A gateway timeout occurs when the service tries to reach the connector and fails within the timeout window. The error is seen when an application is assigned to a connector group with no working connectors. The error is also seen when the required ports aren't open.

## Bad Gateway errors

A bad gateway error indicates that the connector is unable to reach the backend application. Common mistakes that cause this error are:

- A typo or mistake in the internal URL
- Not publishing the root of the application. For example, publishing `http://expenses/reimbursement` but trying to access `http://expenses`
- Problems with the Kerberos Constrained Delegation (KCD) configuration
- Problems with the backend application

## Forbidden errors

If you see a forbidden error, the user isn't assigned to the application. This error could be either in Microsoft Entra ID or on the backend application.

To learn how to assign users to the application in Azure, see the [configuration documentation](application-proxy-add-on-premises-application.md#test-the-application).

## Check the application's internal URL

As a first quick step, double check and fix the internal URL by opening the application through **Enterprise Applications**, then selecting the **application proxy** menu. Verify the internal URL of the application is the one used from your on premises network.

## Check the application is assigned to a working connector group
You must confirm an application is assigned to a working connector group. For more information, see [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md).

## Check all required ports are open

Verify that all required ports are open. For required ports, see the open ports section of [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md). If all the required ports are open, move to the next section.

## Check for other connector errors

Look for issues or errors with the connector itself. For more information about common errors, see [application proxy troubleshooting](application-proxy-troubleshoot.md).

Look directly at the connector logs to identify any errors. Many of the error messages share specific recommendations for fixes. To view the logs, see the [private network connectors](application-proxy-connectors.md).

## Common solutions

If your application is configured to use integrated Windows authentication (IWA), test the application without single sign-on. To check the application without single sign-on, open your application through **Enterprise Applications,** and go to the **Single Sign-On** menu. Change the drop-down from *Integrated Windows authentication* to *Microsoft Entra single sign-on disabled*.

Now open a browser and try to access the application again. You should be prompted for authentication and get into the application. If you're able to authenticate, the problem is with the Kerberos Constrained Delegation (KCD) configuration that enables the single sign-on.

If you continue to see the error, go to the machine where the connector is installed, open a browser and attempt to reach the internal URL used for the application. The connector acts like another client from the same machine. If you can't reach the application, investigate why that machine is unable to reach the application, or use a connector on a server that is able to access the application.

## Next steps

- [Understand Microsoft Entra private network connectors](../../global-secure-access/concept-connectors.md)

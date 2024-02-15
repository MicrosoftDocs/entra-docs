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
- **Forbidden**: The user is not authorized to access the application. The error can happen when the user is not assigned to the application in Microsoft Entra ID. The error can also happen if the user does not have permission to access the application on the backend.

To find the code, look at the text at the bottom left of the error message for the `Status Code` field.

![Example: Gateway timeout error](./media/application-proxy-sign-in-bad-gateway-timeout-error/connection-problem.png)

## Gateway Timeout errors

A gateway timeout occurs when the service tries to reach the connector and fails within the timeout window. The error is seen when an application is assigned to a connector group with no working connectors. The error is also seen when the required ports are not open.

## Bad Gateway errors

A bad gateway error indicates that the connector is unable to reach the backend application. make sure that you have published the correct application. Common mistakes that cause this error are:

- A typo or mistake in the internal URL
- Not publishing the root of the application. For example, publishing `http://expenses/reimbursement` but trying to access `http://expenses`
- Problems with the Kerberos Constrained Delegation (KCD) configuration
- Problems with the backend application

## Forbidden errors

If you see a forbidden error, the user isn't assigned to the application. This error could be either in Microsoft Entra ID or on the backend application.

To learn how to assign users to the application in Azure, see the [configuration documentation](application-proxy-add-on-premises-application.md#test-the-application).

If you confirm the user is assigned to the application in Azure, check the user configuration in the backend application. If you are using Kerberos Constrained Delegation/Integrated Windows Authentication, see the KCD Troubleshoot page for guidelines.

## Check the application's internal URL

As a first quick step, double check and fix the internal URL by opening the application through **Enterprise Applications**, then selecting the **application proxy** menu. Verify the internal URL of the application is the one used from your on premises network.

## Check the application is assigned to a working connector group

To verify the application is assigned to a working connector group:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Application proxy**.
1. Look at the connector group field. If there are no active connectors in the group, you see a warning. If you don't see any warnings, move on to verify all [required ports](application-proxy-add-on-premises-application.md) are allowed.
1. If the wrong connector group is showing, use the drop-down to select the correct group, and confirm you no longer see any warnings. If the intended connector group is showing, click the warning message to open the page with connector management.
1. From here, there are a few ways to drill in further:

   - Move an active connector into the group: Move a connector into the assigned group. To do so, click the connector. In the **connector group** field, use the drop-down to select the correct group, and click **save**.
   - Download a new connector for the group: Install the connector on a machine with direct line of sight to the backend application. Typically, the connector is installed on the same server as the application. Use the download connector link to download a connector onto the target machine. Next, click the connector, and use the **connector group** drop-down to make sure it belongs to the right group. For more information on downloading and installing a connector, see [application proxy connectors](application-proxy-connectors.md).
   - Investigate an inactive connector: If a connector shows as inactive, it is unable to reach the service. This error is typically due to blocked ports that are required. To solve this issue, move on to verify all required ports are allowed.

After using these steps to ensure the application is assigned to a group with working connectors, test the application again. If it is still not working, continue to the next section.

## Check all required ports are open

Verify that all required ports are open. For required ports, see the open ports section of [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md). If all the required ports are open, move to the next section.

## Check for other connector errors

Look for issues or errors with the connector itself. For more information about common errors, see [application proxy troubleshooting](application-proxy-troubleshoot.md).

Look directly at the connector logs to identify any errors. Many of the error messages share specific recommendations for fixes. To view the logs, see the [application proxy connectors](application-proxy-connectors.md).

## Additional Resolutions

If your application is configured to use integrated Windows authentication (IWA), test the application without single sign-on. To check the application without single sign-on, open your application through **Enterprise Applications,** and go to the **Single Sign-On** menu. Change the drop-down from "Integrated Windows authentication" to "Microsoft Entra single sign-on disabled".

Now open a browser and try to access the application again. You should be prompted for authentication and get into the application. If you are able to authenticate, the problem is with the Kerberos Constrained Delegation (KCD) configuration that enables the single sign-on.

If you continue to see the error, go to the machine where the connector is installed, open a browser and attempt to reach the internal URL used for the application. The connector acts like another client from the same machine. If you can't reach the application, investigate why that machine is unable to reach the application, or use a connector on a server that is able to access the application.

If you can reach the application from that machine, to look for issues or errors with the connector itself. You can see some common errors in the [Troubleshoot document](application-proxy-troubleshoot.md#connector-errors). You can also look directly at the connector logs to identify any errors. Many of our error messages be able to share more specific recommendations for fixes. To learn how to view the logs, see [our connectors documentation](application-proxy-connectors.md#under-the-hood).

## Next steps

[Understand Microsoft Entra application proxy connectors](application-proxy-connectors.md)

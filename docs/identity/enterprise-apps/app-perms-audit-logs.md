---
title: View Activity logs of application permissions
description: Understand how to view the activity logs of what permissions are being granted and revoked for applications in my directory.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 04/08/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: enterprise-apps

#customer intent: As an admin, I want to understand how to view the activity logs of what permissions are being granted and revoked for applications in my directory so that I can review permissions granted to apps and remediate risks due to overprivileged apps.
---

# View activity logs for application permissions

Microsoft Entra is a platform that allows you to create and manage applications for your organization. You can grant different permissions to your applications, such as accessing data, or performing actions. However, you might want to review the permissions that are granted to your applications from time to time, to ensure that they're appropriate and secure. 

One way to review permissions granted to your apps is by using activity logs, which record the activities and events that occur in your Microsoft Entra applications. Activity logs help you to monitor the usage and performance of your applications, and to identify any potential issues or risks. By reviewing the activity logs, you can see what permissions your applications have and whether they're complying with your policies and expectations.

In this article, you:
- View activity logs to see API permission granting and removing activity for a specific application.
- View activity logs to see API permission granting and removing activity for all applications.
- Understand which audit logs are used to track granting and removing API permissions from app to app.

## Prerequisites

To view Activity Logs for applications, you need:

- A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Reports Reader, Security Reader, Security Administrator, Global Reader

## How to view permission audit logs for all applications in your directory

Only certain events recorded in the Activity Logs are needed to see application permission activity. To view all events using the Microsoft Entra admin center, Take the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with at least a [Reports reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) role

1. Browse to **Identity** > **Applications** > **Enterprise applications**.

1. In the left-hand navigation underneath **Activity**, browse to **Audit logs**.

1. Filter the audit logs by using the information included in the [Audit logs](#audit-logs) section to select only the needed logs to view permission activity for your applications.

1. Use **Manage view** on the top command bar to edit the columns shown. Select the **Date** column to view more detailed information per audit log.


## How to view permission audit logs for a specific resource application

It can be helpful to deep dive into the activity of a resource application to see which applications already have access through API permissions. For example, you might want to monitor the activity logs for the Microsoft Graph application, so you can see when permissions are granted for the resources it protects.

To view the activity logs for a resource application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with at least a [Reports reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) role

1. Browse to **Identity** > **Applications** > **Enterprise applications**.

1. Search for the resource application that owns the permission. For example, if you want to view which applications were awarded the Microsoft Graph `Mail.Read` permission in the last 30 days, search for *Microsoft Graph*.

1. In the left-hand navigation underneath **Activity**, browse to **Audit logs**.

1. Filter the audit logs by using the information included in the [Audit logs](#audit-logs) section to select only the needed logs to view permission activity for your applications.

1. Use **Manage view** on the top command bar to edit the columns shown. Select the **Date** column to view more detailed information per audit log.



## Audit logs

The following table outlines the scenarios and audit values available for the granting and revoking of permissions granted to apps.

|               Scenario                | Audit Service  |    Audit Category     |                  Audit Activity                   | Audit Actor  | Audit log limitations |
| ------------------------------------- | -------------- | --------------------- | ------------------------------------------------- | ------------ | --------------------- |
| Granting app-only access to an app    | Core Directory | ApplicationManagement | Add app role assignment to service principal      | User context |                       |
| Revoking app-only access to an app    | Core Directory | ApplicationManagement | Remove app role assignment from service principal | User context |                       |
| Granting delegated access to an app   | Core Directory | ApplicationManagement | Add delegated permission grant                    | User context |                       |
| User grants consent to an application | Core Directory | ApplicationManagement | Consent to application                            | User context |                       |

## Next steps

- [How to access Activity Logs through Microsoft Graph and PowerShell](../monitoring-health/howto-analyze-activity-logs-with-microsoft-graph.md)
- [Microsoft Entra audit log categories and activities](../monitoring-health/reference-audit-activities.md)

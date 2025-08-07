---
title: How to configure Health notifications (preview)
description: Learn how to configure the Microsoft Entra health monitoring email and webhook notifications to monitor and improve the health of your tenant.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 07/31/2025
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want configure email notifications for when my tenant receives a Microsoft Entra Health alert.

---

# How to configure notifications for Microsoft Entra Health monitoring alerts (preview)

Microsoft Entra Health provides tenant-level metrics and health signals for several key identity scenarios. These signals are fed into an anomaly detection service, which triggers alerts when significant changes are detected. You can configure email and webhook notifications for when an alert is triggered.

This article describes how to configure email and webhook notifications for Microsoft Entra Health monitoring alerts.

> [!IMPORTANT]
> Microsoft Entra Health scenario monitoring and alerts are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here. The Microsoft Entra admin center experience is being released to customers in phases, so you might not see all the features described in this article.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) is required to *view* the Microsoft Entra health scenario monitoring signals.
- A tenant with both a non-trial [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) *and* at least 100 monthly active users is required to *view alerts* and *receive alert notifications*.
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role required to *view scenario monitoring signals, alerts, and alert configurations*.
- The [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) is the least privileged role required to *update alerts* and *update alert notification configurations*.
- The `Group.Read.All` permission is the least privileged permission required to *view groups*.
- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- The `HealthMonitoringAlert.ReadWrite.All` permission is required to *view and modify the alerts using the Microsoft Graph API*.
- For a full list of roles, see [Least privileged role by task](../role-based-access-control/delegate-by-task.md#monitoring-and-health---audit-and-sign-in-logs-least-privileged-roles).

> [!NOTE]
> Newly onboarded tenants might not have enough data to generate alerts for about 30 days.

## Determine email notification recipients

We recommend daily review of the Microsoft Entra Health monitoring scenarios so you're familiar with the baseline metrics and so you can identify trends. It's important to also configure email notifications for when an alert is triggered.

Email notifications are sent to the [Microsoft Entra group](../../fundamentals/concept-learn-about-groups.md) of your choice. We recommend sending alerts to users with the appropriate access to investigate and take action on the alerts. Not every role can take the same action, so consider including a group with the following roles: 

- [Security Reader](../role-based-access-control/permissions-reference.md#security-reader)
- [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator)
- [Intune Administrator](../role-based-access-control/permissions-reference.md#intune-administrator)
- [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator)

## Configure email notifications

Email notification settings can be configured for each scenario in the Microsoft Entra admin center or using the Microsoft Graph API.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator).

1. Browse to **Entra ID** > **Monitoring & health** > **Health** and select the **Health monitoring** tab.

1. Select the scenario you want to configure email notifications for.

    :::image type="content" source="media/howto-configure-health-alert-emails/health-monitoring-landing-page.png" alt-text="Screenshot of the Microsoft Entra Health landing page." lightbox="media/howto-configure-health-alert-emails/health-monitoring-landing-page-expanded.png":::

1. From the **Group alert notifications** section, select either the **+Select** or **Edit** button.
    - If no group is selected, the **+Select** button is displayed.
    - If a group is already selected, the **Edit** button is displayed.

    :::image type="content" source="media/howto-configure-health-alert-emails/email-notifications-edit-button.png" alt-text="Screenshot of the group alert notifications edit button." lightbox="media/howto-configure-health-alert-emails/email-notifications-edit-button-expanded.png":::

1. From the panel that opens, select the group you want to receive the alerts and select the **Select** button. 
    - Only one group can be selected.
    - The group is updated in the **Group alert notifications** section of the scenario page.

Members of the selected group will receive an email notification the next time an alert is triggered for the scenario. Repeat this process for the other scenarios.

> [!NOTE]
> If the selected group has other groups added as members of that group, the notifications are sent to only the top three groups in the hierarchy.

### [Microsoft Graph API](#tab/microsoft-graph-api)

To configure alert notifications, you need the ID of the Microsoft Entra group you want to receive the alerts and the scenario alert ID. 

#### Locate the group ID and alert type

1. Sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) as at least a [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) and consent to the appropriate permissions.
1. Select **GET** as the HTTP method from the dropdown and set the API version to **v1.0**.
1. Run one of the following queries to locate the `id` of the group to receive the email notifications.

    - To retrieve the full list of groups:

    ```
    GET https://graph.microsoft.com/v1.0/groups
    ```

    - To retrieve a specific group by its display name:
    
    ```
    GET https://graph.microsoft.com/v1.0/groups?$filter=displayName eq 'GroupName'
    ```

1. Locate and save the `id` of the group you want to receive the alerts.

1. Choose an alert type for the email notifications.
    - Possible alert types: `unknown`, `mfaSignInFailure`, `managedDeviceSignInFailure`, `compliantDeviceSignInFailure`, and `conditionalAccessBlockedSignIn`.
    - You can set up alerts for each `alertType` but if you want to start with a scenario that has activity and alerts, run the following query for each `alertType` to review the activity. The example uses `mfaSignInFailure`.

    ```http
    GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts?$filter=alertType eq 'mfaSignInFailure'&$select=alertType,category,createdDateTime,id

    ```

#### Configure the email notifications

In Microsoft Graph Explorer, run the following PATCH query to configure email notifications for alerts.

- Replace `{alertType}` with the specific `alertType` you want to configure.
- Replace `Object ID of the group` with the `Object ID` of the group you want to receive the alerts.
- For more information, see [configure email notifications for alerts](/graph/api/healthmonitoring-alertconfiguration-update?view=graph-rest-beta&preserve-view=true).

```http
PATCH https://graph.microsoft.com/beta/reports/healthMonitoring/alertConfigurations/{alertType}
Content-Type: application/json

{
  "emailNotificationConfigurations": [
    {
      "groupId":"Object ID of the group",
      "isEnabled": true
    }
  ]
}
```
> [!NOTE]
> If the selected group has other groups added as members of that group, the notifications are sent to only the top three groups in the hierarchy.

---

## Configure webhook notifications

Microsoft Graph change notifications allow your application to receive real-time alerts whenever a resource is created, updated, or deleted. Unlike email notifications, these alerts are delivered directly to a secure HTTPS endpoint that you specify, making them ideal for automated workflows and integrations. Currently, change notifications for health monitoring alert *creations* are supported through webhooks. Microsoft Graph supports notifications for create, update, and delete operations, but at this time only alert creation notifications are available for health monitoring alerts.
 
To start receiving notifications, your application sends a `POST` request to the /`subscriptions` endpoint to subscribe to a specific resource, in this case, health monitoring alerts. Microsoft Graph then validates the request and confirms the subscription. Once the subscription is active, Microsoft Graph sends a notification to your designated endpoint whenever the subscribed resource is created. For more information, see [Microsoft Graph change notifications](/graph/change-notifications-overview).

After receiving a notification, you should investigate the alert either through the Microsoft Entra admin center or through the Microsoft Graph API. If you need to assess the alert's impact, we recommend either polling or introducing a short delay before calling the health monitoring alert API for impact assessment data to be available. For more information, see [How to investigate health scenario alerts](howto-investigate-health-scenario-alerts.md).

The following example shows a basic request to subscribe to changes to Health Monitoring alert changes.

### Example subscription request

```http
POST https://graph.microsoft.com/**beta**/subscriptions
Content-Type: application/json
{
  "changeType": "created",
  "notificationUrl": "https://webhook.azurewebsites.net/notificationClient",
  "lifecycleNotificationUrl": "https://webhook.azurewebsites.net/api/lifecycleNotifications",
  "resource": "/reports/healthmonitoring/alerts",
  "expirationDateTime": "2025-08-30T11:00:00.0000000Z",
  "clientState": "SecretClientState"
}
```

If you want to subscribe to notifications for only one specific alert type, amend the request to include the following details:

`"notificationQueryOptions":"$filter=alertType eq 'mfaSignInFailure'`

## Related content

- [Set up notifications for changes in resource data](/graph/change-notifications-overview)
- [Configure email notifications for alerts](/graph/api/healthmonitoring-alertconfiguration-update?view=graph-rest-beta&preserve-view=true)
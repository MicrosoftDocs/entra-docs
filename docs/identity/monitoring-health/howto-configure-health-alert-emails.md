---
title: How to configure Health notifications (preview)
description: Learn how to configure the Microsoft Entra health monitoring email and webhook notifications to monitor and improve the health of your tenant.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 02/05/2025
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

To configure alert notifications, you need the ID of the Microsoft Entra group you want to receive the alerts AND the scenario alert ID. 

#### Locate the group's Object ID

From the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](../role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Groups** > **All groups** > and select the group you want to receive the alerts.
1. Select **Properties** and copy the `Object ID` of the group. 

    :::image type="content" source="media/howto-configure-health-alert-emails/locate-group-id.png" alt-text="Screenshot of the group properties in the Microsoft Entra admin center." lightbox="media/howto-configure-health-alert-emails/locate-group-id-expanded.png":::

Using the Microsoft Graph API:
1. Sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) as at least a [Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) and consent to the appropriate permissions.
1. Select **GET** as the HTTP method from the dropdown and set the API version to **v1.0**.
1. Run the following query to retrieve the list of alerts for your tenant.

    ```
    GET https://graph.microsoft.com/v1.0/groups
    ```
1. Locate and save the `id` of the group you want to receive the alerts.

#### Locate the scenario alert type

1. Select **GET** as the HTTP method from the dropdown and set the API version to **beta**.
1. Run the following query to retrieve the list of alerts for your tenant.

    ```http
    GET https://graph.microsoft.com/beta/reports/healthMonitoring/alerts
    ```
1. Locate and save the `alertType` of the alert you want to be notified about, for example `alertType: "mfaSignInFailure`.

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

Webhook change notifications allow applications to receive alerts when a Microsoft Graph resource you're interested in is created, updated, or deleted. These notifications differ from email notifications in that when a service or system subscribes to the notification, the notification is sent to an HTTPS endpoint, not an email address.

For the Microsoft Entra Health monitoring alerts, the service calls the subscription API to listen for health monitoring alerts. You provide Microsoft Graph an HTTPS endpoint so when a new alert is created, updated, or deleted, Microsoft Graph sends that notification to the specified HTTPS endpoint. 

With the Microsoft Entra Health monitoring alerts onboarded to the Microsoft Graph change notifications, you can set up webhook notifications. For mor information, see [Microsoft Graph change notifications](/graph/change-notifications-overview). 

The client app sends a **POST** request to the `/subscriptions` endpoint. The following example shows a basic request to subscribe to changes to a specific mail folder on behalf of the signed-in user. For more information about other Microsoft Graph resources that support change notifications, see [supported resources](/graph/change-notifications-overview#supported-resources).

### Example subscription request

<!-- {
  "blockType": "request",
  "name": "change-notifications-subscriptions-example"
}-->
```http
POST https://graph.microsoft.com/v1.0/subscriptions
Content-Type: application/json

{
  "changeType": "created,updated",
  "notificationUrl": "https://webhook.azurewebsites.net/notificationClient",
  "lifecycleNotificationUrl": "https://webhook.azurewebsites.net/api/lifecycleNotifications",
  "resource": "/me/mailfolders('inbox')/messages",
  "expirationDateTime": "2016-03-20T11:00:00.0000000Z",
  "clientState": "SecretClientState"
}
```
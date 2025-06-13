---
title: Retirement of service principal-less authentication
description: Learn about the mitigation steps tenant administrators should perform for the retirement of service principal-less authentication.
author: shirlingxu
ms.author: xushirling
ms.topic: how-to
ms.date: 03/30/2025
---
# Service principal-less authentication mitigation

From March 2026, Microsoft Entra ID will no longer support app authentication without a service principal. In this article, you'll learn how to prepare for the retirement. As a tenant administrator, you'll identify affected apps, create a service principal, and verify the changes you made.

## Prerequisites
- An account with the **Application administrator** or **Cloud application administrator** role assigned. 

## Blocking app authentication without a service principal

Microsoft Entra ID will block authentication for all non-Microsoft multi-tenant applications that don't have a service principal in the tenant where they are authenticating. This scenario is also known as service principal-less authentication. This behavior has already been disabled for most non-Microsoft applications. This change addresses a few remaining exceptions and is a preventive security measure. 

App authentication without a service principal allows a multi-tenant client application to obtain an app-only token from a tenant without an object identifier (object ID) claim. In most cases, the absence of a service principal means the app has not been granted authorization to access any data, and this is harmless. However, in rare cases where the target API has implemented improper authorization checks, this capability could lead to unauthorized access. Microsoft has already verified that Microsoft-published APIs aren't vulnerable to this type of abuse. Disabling this behavior entirely also protects non-Microsoft APIs with insufficient authorization checks.

Additionally, by enforcing the requirement that all applications must have a service principal in every tenant where they authenticate, we facilitate tenant administrator's governance of all access, including the ability to target these apps individually with Conditional Access policies. 

If applications you rely on are authenticating without a service principal in your tenant, you must act **before March 31, 2026** to avoid disruption.

### April 2025 freeze

In April 2025, we froze most resource apps accessed by service principal-less client apps. We allowed traffic where the client app home tenant and resource tenant matched if it was observed between **February 11th and March 11th, 2025**, which will continue to work until March 2026. However, any traffic that wasn't identified during this period or new traffic after March 11 was blocked starting **April 2025**.

### Azure Bot Framework scenario
Azure Bot Framework is currently in the process of moving away from service principal-less authentication. Tenants may continue to see sign-ins with service principal-less authentication until **August 2025**. In the meantime, no action is required by customers. 

## Use sign-in logs to find applications authenticating without a service principal

> [!NOTE]
> Action is only required for apps authenticating without a service principal found in the "Service principal sign-ins" (app-only) sign-in logs. *User* sign-in logs will include Microsoft applications and services that are authenticating without a service principal. Sign-ins and authentication without a service principal by Microsoft apps is expected, and no action is required by customers.

First, you'll need to verify that access by the named applications to the resources listed is necessary. The application’s sign-in activity can be reviewed by the resource tenant’s administrator via [sign-in logs](../identity/monitoring-health/concept-sign-ins.md). The service principal ID of an application making a service principal-less authentication is shown as `00000000-0000-0000-0000-000000000000` in the sign-in logs of the resource tenant.  

1. Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com/).
2. On the left navigation panel, go to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
3. Go to the **Service principal sign-ins** tab.
4. Filter by **Service principal ID**, and enter `00000000-0000-0000-0000-000000000000` in the input field.
5. Set the date range to **Last 1 month**.
6. Click on a log entry to view the details, and identify the app's **Application ID**. You will need this in the next step.

:::image type="content" source="media/retire-service-principal-less-authentication/sign-in-logs.png" alt-text="Screenshot showing sign-in logs page of the Microsoft Entra admin center with filters applied to extract on SP-less auth sign ins.":::

## Create a service principal

Once you've identified an application authenticating without a service principal, use the details in the sign-in logs to decide whether it's expected and should continue to authenticate in your tenant.

If you do not recognize the app and wish to block it, [create a service principal](/entra/identity/enterprise-apps/create-service-principal-cross-tenant?pivots=msgraph-powershell) for the app, and then [disable the service principal](/entra/identity/enterprise-apps/disable-user-sign-in-portal?pivots=portal). Disabling the app's service principal will block all future sign-in and authentication attempts by that app in your tenant.

## Verify the changes you made

Once you've taken action for an application, the sign-in logs will include the app's new service principal ID, now with a unique alphanumeric GUID in the format `aaaaaaaa-bbbb-cccc-1111-222222222222`. This confirms that the app has a sevice principal in your tenant and will not be further affected by the upcoming change.

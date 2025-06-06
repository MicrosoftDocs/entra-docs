---
title: Retire Service Principal-Less Authentication
description: Learn about the mitigation steps tenant administrators should perform for service principal-less authentication behavior deprecation.
author: shirlingxu
ms.author: xushirling
ms.topic: how-to
ms.date: 03/30/2025
---
# Service principal-less authentication mitigation

From March 2026, Microsoft Entra ID will no longer support service principal-less authentication behavior. In this article, you'll learn how to prepare for the deprecation of service principal-less authentication. As a tenant administrator you'll verify access, create an enterprise application, and verify tokens.

## Prerequisites
- An account in the resource tenant with at least the **Application administrator** or **Cloud application administrator** role assigned. 

## Transitioning from Service Principal-less authentication

Microsoft Entra ID will block authentication for multitenant applications that don't have an enterprise application registration in the resource tenant. This scenario is also known as service principal-less authentication. This behavior has already been blocked for most resources. This change will address a few remaining exceptions. Service principal-less authentication issues tokens without permissions and without an object identifier (object ID). This is a preventive security measure. 

This change to service principal-less authentication will make client service principal a requirement for all applications in order to improve our "Security by default" ([See authentication behaviors](/graph/api/resources/authenticationbehaviors?view=graph-rest-beta&preserve-view=true)). Service principal-less authentication can be abused if the resource applications (i.e. APIs) perform incomplete validations. Microsoft has verified that validations aren't vulnerable to service principal-less authentication. However, with this action, the risk of this gap reappearing in future versions or being exploited in third-party resources outside Microsoft’s control is minimized. 

Additionally, by enforcing the requirement that applications must be registered in every tenant where they authenticate, we reinforce tenant administrator’s governance of all access, including the ability to write conditional access policies for these applications. 

You must act **before March 31, 2026**, to avoid authentication failure of applications. 

In February-March 2025, we froze most resource apps accessed by service principal-less client apps. We allowed traffic where the client app home tenant and resource tenant matched if it was observed between **February 11th and March 11th, 2025**, which will continue to work until March 2026. However, any traffic that wasn't identified during this period or new traffic after March 11 was blocked starting April 2025. 

We're now addressing the remaining client apps. Starting late June/July 2025, service principal-less traffic observed between **June 16th and 27th, 2025** will be allowed until March 2026. Low-volume traffic is excluded. This change only applies to a small set of first-party and third-party resource apps, including first-party apps such as EXO, AADGraph, and ARM. 

## Use sign-in logs to find service principal-less applications

> [!NOTE]
> Action is only required for apps authenticating without a service principal found in the "Service principal sign-ins" (app-only) sign-in logs. *User* sign-in logs will include Microsoft applications and services that are authenticating without a service principal. Sign-ins and authentication without a service principal by Microsoft apps is expected, and no action is required by customers.

First, you'll need to verify that access by the named applications to the resources listed is necessary. The application’s sign-in activity can be reviewed by the resource tenant’s administrator via [sign-in logs](../identity/monitoring-health/concept-sign-ins.md). The service principal ID of an application making a service principal-less authentication is shown as `00000000-0000-0000-0000-000000000000` in the sign-in logs of the resource tenant.  

1. Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com/#home).
2. On the left navigation panel, go to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
3. Go to the **Service principal sign-ins** tab.
4. Filter by **Service principal ID**, and enter `00000000-0000-0000-0000-000000000000` in the input field.
5. Change the Date sorting to be **Custom time interval**, and set it to **Last 1 month**.
6. Click on a log to view the details, and navigate to the **Application ID** in the side panel to find the Client Application ID for the next step.

:::image type="content" source="media/retire-service-principal-less-authentication/sign-in-logs.png" alt-text="Screenshot showing sign-in logs page of the Microsoft Entra admin center with filters applied to extract on SP-less auth sign ins.":::

## Create enterprise application

Next, you'll need to [create an enterprise application](/entra/identity/enterprise-apps/create-service-principal-cross-tenant?pivots=msgraph-powershell) in the resource tenant for each of the named applications. The resource tenant administrator must register the application using the Client App ID through the sign-in logs method from above.

## Verify tokens

Finally, the administrator of the resource tenant should verify that the tokens issued to the application are no longer service principal-less. This can be verified in sign-in logs. The Service principal ID should appear with a unique alphanumeric GUID in the format `aaaaaaaa-bbbb-cccc-1111-222222222222`.


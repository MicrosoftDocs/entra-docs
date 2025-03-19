---
title: Deprecate SP-Less Authentication
description: Learn about the mitigation steps tenant administrators should perform for SP-less authentication behavior deprecation.
author: shirlingxu
ms.author: xushirling
ms.topic: how-to
ms.date: 03/30/2025
---
# Service Principal-less authentication mitigation

From March 2026, Microsoft Entra ID will no longer support Service-Principal-less (SP-less) authentication behavior. In this article, you'll learn how to take action for the SP-less authentication behavior deprecation as a tenant administrator, including verifying access, creating an enterprise application, and verifying tokens.

## Prerequisites
- An account in the resource tenant with at least the **Application administrator** or **Cloud application administrator** role assigned. 

## Transitioning to SP-less authentication

Microsoft Entra ID will block authentication for multi-tenant applications that do not have an enterprise application registration in the resource tenant. This scenario is also known as Service-Principal-Less or “SP-Less Authentication.” This behavior has already been blocked for most resources. This change will address a few remaining exceptions. SP-less authentication issues tokens without permissions and without an object identifier (object ID). This is a preventive security measure. 

This change to SP-less authentication will make “requireClientServicePrincipal” a requirement for all applications in order to improve our “Security by default” ([See authentication behaviors](/graph/api/resources/authenticationbehaviors?view=graph-rest-beta&preserve-view=true)). SP-less authentication can be abused if the resource applications (i.e. APIs) perform incomplete validations.  Microsoft has verified validations for its resource applications. However, with this action, the risk of this gap re-appearing in future versions or being exploited in third-party resources outside Microsoft’s control is minimized. 

Additionally, by enforcing the requirement that applications must be registered in every tenant where they authenticate, we reinforce tenant administrator’s governance of all access, including the ability to write conditional access policies for these applications. 

You must act **before March 31, 2026**, to avoid partial authentication failure of applications. 

## Use sign-in logs to find SP-less applications

First, you'll need to verify that access by the named applications to the resources listed is necessary. The application’s sign-in activity can be reviewed by the resource tenant’s administrator via [sign-in logs](../identity/monitoring-health/concept-sign-ins). The service principal ID of an application making an SP-Less authentication is shown as `00000000-0000-0000-0000-000000000000` in the sign-in logs of the resource tenant.  

1. Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com/#home).
2. On the left navigation panel, go to **Identity** > **Show more...** > **Monitoring & health** > **Sign-in logs**.
3. Go to the **Service principal sign-ins** tab.
4. Filter by **Service principal ID**, and enter `00000000-0000-0000-0000-000000000000` in the input field.
5. Change the Date sorting to be **Custom time interval**, and set it to **Last 1 month**.
6. Click on a log to view the details, and navigate to the **Application ID** in the side panel to find the Client Application ID for the next step.

:::image type="content" source="media/deprecate-sp-less-auth/sign-in-logs.png" alt-text="Screenshot showing sign-in logs page of the Entra admin center with filters applied to extract on SP-less auth sign ins.":::

## Create enterprise application

Next you'll need to [create an enterprise application](/entra/identity/enterprise-apps/create-service-principal-cross-tenant?pivots=msgraph-powershell) in the resource tenant for each of the named applications. The resource tenant administrator must register the application using the Client App ID noted in the received email or through the sign-in logs method from above.

## Verify tokens

Finally, the administrator of the resource tenant should verify that the tokens issued to the application are no longer SP-less. This can be verified in sign-in logs. The Service principal ID should appear with a unique alphanumeric GUID in the format `aaaaaaaa-bbbb-cccc-1111-222222222222`.

## Related content

* [Microsoft Entra ID will no longer support authentication without a service principal](https://aka.ms/splessauthblog)

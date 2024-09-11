---
title: Interactive user sign-in logs
description: Learn about the type of information captured in the interactive user sign-in logs in Microsoft Entra monitoring and health.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 09/10/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg14

# Customer intent: As an IT admin, I need to know what information is captured in the interactive sign-in logs so that I can use the logs to monitor the health of my tenant and troubleshoot issues.
---
# What are interactive user sign-ins in Microsoft Entra?

Microsoft Entra monitoring and health provides several types of sign-in logs to help you monitor the health of your tenant. The interactive user sign-ins are the default view in the Microsoft Entra admin center.

## What is an interactive user sign-in?

Interactive sign-ins are performed *by* a user. They provide an authentication factor to Microsoft Entra ID. That authentication factor could also interact with a helper app, such as the Microsoft Authenticator app. Users can provide passwords, responses to MFA challenges, biometric factors, or QR codes to Microsoft Entra ID or to a helper app. This log also includes federated sign-ins from identity providers that are federated to Microsoft Entra ID.  

:::image type="content" source="media/concept-sign-ins/sign-in-logs-user-interactive.png" alt-text="Screenshot of the interactive user sign-in log." lightbox="media/concept-sign-ins/sign-in-logs-user-interactive-expanded.png":::

## Log details

**Report size:** small </br>
**Examples:**

- A user provides username and password in the Microsoft Entra sign-in screen.
- A user passes an SMS MFA challenge.
- A user provides a biometric gesture to unlock their Windows PC with Windows Hello for Business.
- A user is federated to Microsoft Entra ID with an AD FS SAML assertion.

In addition to the default fields, the interactive sign-in log also shows:

- The sign-in location
- Whether Conditional Access was applied

## Special considerations

**Non-interactive sign-ins on the interactive sign-in logs**

Previously, some non-interactive sign-ins from Microsoft Exchange clients were included in the interactive user sign-in log for better visibility. This increased visibility was necessary before the non-interactive user sign-in logs were introduced in November 2020. However, it's important to note that some non-interactive sign-ins, such as those using FIDO2 keys, might still be marked as interactive due to the way the system was set up before the separate non-interactive logs were introduced. These sign-ins might display interactive details like client credential type and browser information, even though they're technically non-interactive sign-ins.

**Passthrough sign-ins**

Microsoft Entra ID issues tokens for authentication and authorization. In some situations, a user who is signed in to the Contoso tenant might try to access resources in the Fabrikam tenant, where they don't have access. A no-authorization token called a passthrough token, is issued to the Fabrikam tenant. The passthrough token doesn't allow the user to access any resources.

Previously, when reviewing the logs for this situation, the sign-in logs for the home tenant (in this scenario, Contoso) didn't show a sign-in attempt because *the token wasn't granting access to a resource with any claims*. The sign-in token was only used to display the appropriate failure message.

Passthrough sign-in attempts now appear in the home tenant sign-in logs and any relevant tenant restriction sign-in logs. This update provides more visibility into user sign-in attempts from your users and deeper insights into your tenant restriction policies.

The `crossTenantAccessType` property now shows `passthrough` to differentiate passthrough sign-ins and is available in the Microsoft Entra admin center and Microsoft Graph.

**First-party, app-only service principal sign-ins**

The service principal sign-in logs don't include first-party, app-only sign-in activity. This type of activity happens when first-party apps get tokens for an internal Microsoft job where there's no direction or context from a user. We exclude these logs so you're not paying for logs related to internal Microsoft tokens within your tenant.

You might identify Microsoft Graph events that don't correlate to a service principal sign-in if you're routing `MicrosoftGraphActivityLogs` with `SignInLogs` to the same Log Analytics workspace. This integration allows you to cross reference the token issued for the Microsoft Graph API call with the sign-in activity. The `UniqueTokenIdentifier` for sign-in logs and the `SignInActivityId` in the Microsoft Graph activity logs would be missing from the service principal sign-in logs.
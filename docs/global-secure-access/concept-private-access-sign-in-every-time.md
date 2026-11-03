---
title: Microsoft Entra Private Access sign-in every time (preview)
description: Understand sign-in every time for Microsoft Entra Private Access, its Conditional Access dependency, and its five-minute reauthentication window.
ms.topic: concept-article
ms.subservice: entra-private-access
ms.date: 11/01/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
# Customer intent: As an administrator, I want to understand sign-in every time for private applications so that I can plan reauthentication for sensitive access.
---

# Microsoft Entra Private Access sign-in every time overview (preview)

Sign-in every time (preview) is a Microsoft Entra Private Access feature that uses Conditional Access to require reauthentication when users access sensitive private applications.

Use this overview to understand the supported client requirements, Conditional Access dependency, and reauthentication behavior before you plan your deployment.

Global Secure Access uses the Conditional Access **Every time strict (preview)** control for this feature. The Global Secure Access feature requires Conditional Access. You can use **Every time strict (preview)** in Conditional Access independently of Global Secure Access.

## Supported clients and platforms

Sign-in every time (preview) is currently supported only with the Global Secure Access client for Windows, version **2.34.222 or later**. Users with earlier Windows client versions or other operating systems are blocked from accessing applications where the feature is enforced.

## Scope enforcement by operating system

Depending on your requirements, you may want to allow access to these private applications from non-Windows devices, skipping sign in frequency requirements. You can use Conditional Access [device platform conditions](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms) to exclude non-Windows operating systems from policies that enforce sign-in every time.

<a name='reauthentication-window'></a>

## Reauthentication interval

Global Secure Access has a **five-minute reauthentication window**. It doesn't prompt the user to reauthenticate if it's been less than five minutes since the user signed in to a given private application. The following example illustrates sign-in prompt behavior and the user experience:

1. A Global Secure Access administrator configures a policy for the private application called 'SSH admin tools jump box' to use the **Every time strict (preview)** session control.
1. The user, a Linux administrator, opens the terminal on their Windows desktop and attempts to access the SSH admin tools application. Global Secure Access detects that more than five minutes have elapsed since the last sign-in and triggers an authentication prompt.
1. The user completes authentication at 09:01:15, accesses the application, runs one command, and closes the terminal at 09:01:55.
1. The user reopens the terminal at 09:03:45 and accesses the application again. Since it's been less than five minutes, a new sign-in prompt isn't triggered. The user completes the task and closes the terminal.
1. At 09:10:34, the user reopens the terminal. Since it's been more than five minutes since 09:01:15, the user is required to reauthenticate.

## Related content

* [Configure sign-in every time for Microsoft Entra Private Access (preview)](how-to-configure-sign-in-every-time.md)
* [Conditional Access adaptive session lifetime policies](~/identity/conditional-access/concept-session-lifetime.md#require-reauthentication-every-time)
* [Microsoft Entra Private Access overview](concept-private-access.md)

---
title: Single and multitenant apps in Microsoft Entra ID
description: Learn about the features and differences between single-tenant and multitenant apps in Microsoft Entra ID.
author: rwike77
manager: CelesteDG
ms.author: ryanwi
ms.custom:
ms.date: 04/26/2024
ms.reviewer: justhu
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As a developer, I want to understand the concept of tenancy in Microsoft Entra ID, so that I can configure my app to be either single-tenant or multi-tenant during app registration and determine who can sign in to my app.
---

# Tenancy in Microsoft Entra ID

Microsoft Entra ID organizes objects like users and apps into groups called *tenants*. Tenants allow an administrator to set policies on the users within the organization and the apps that the organization owns to meet their security and operational policies.

## Who can sign in to your app?

When it comes to developing apps, developers can choose to configure their app to be either single-tenant or multitenant during app registration.

- Single-tenant apps are only available in the tenant they were registered in, also known as their home tenant.
- Multitenant apps are available to users in both their home tenant and other tenants.

When you register an application, you can configure it to be single-tenant or multitenant by setting the audience as follows.

| Audience | Single/multi-tenant | Who can sign in |
| -------- | ------------------- | --------------- |
| Accounts in this directory only | Single tenant | All user and guest accounts in your directory can use your application or API.<br>Use this option if your target audience is internal to your organization. |
| Accounts in any Microsoft Entra directory | Multitenant | All users and guests with a work or school account from Microsoft can use your application or API. This includes schools and businesses that use Microsoft 365.<br>Use this option if your target audience is business or educational customers. |
| Accounts in any Microsoft Entra directory and personal Microsoft accounts (such as Skype, Xbox, Outlook.com) | Multitenant | All users with a work or school, or personal Microsoft account can use your application or API. It includes schools and businesses that use Microsoft 365 as well as personal accounts that are used to sign in to services like Xbox and Skype.<br>Use this option to target the widest set of Microsoft accounts. |

## Best practices for multitenant apps

Building great multitenant apps can be challenging because of the number of different policies that IT administrators can set in their tenants. If you choose to build a multitenant app, follow these best practices:

- Test your app in a tenant that has configured [Conditional Access policies](v2-conditional-access-dev-guide.md).
- Follow the principle of least user access to ensure that your app only requests permissions it actually needs.
- Provide appropriate names and descriptions for any permissions you expose as part of your app. This helps users and admins know what they're agreeing to when they attempt to use your app's APIs. For more information, see the best practices section in the [permissions guide](./permissions-consent-overview.md).

## Next steps

For more information about tenancy in Microsoft Entra ID, see:

- [How to convert an app to be multitenant](howto-convert-app-to-be-multi-tenant.md)

---
title: Conditional Access service dependencies 
description: Learn how conditions are used in Microsoft Entra Conditional Access to trigger a policy.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 06/14/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: calebb
---
# What are service dependencies in Microsoft Entra Conditional Access? 

With Conditional Access policies, you can specify access requirements to websites and services. For example, your access requirements can include requiring multifactor authentication (MFA) or [managed devices](./concept-conditional-access-grant.md).

When you access a site or service directly, the impact of a related policy is typically easy to assess. For example, if you have a policy that requires multifactor authentication (MFA) for SharePoint Online configured, MFA is enforced for each sign-in to the SharePoint web portal. However, it isn't always straight-forward to assess the impact of a policy because there are cloud apps with dependencies to other cloud apps. For example, Microsoft Teams can provide access to resources in SharePoint Online. So, when you access Microsoft Teams in our current scenario, you're also subject to the SharePoint MFA policy.

> [!TIP]
> Using the [Office 365](concept-conditional-access-cloud-apps.md#office-365) app will target all Office apps to avoid issues with service dependencies in the Office stack.

<!-- docutune:ignore "Windows Azure Active Directory" -->

## Policy enforcement

If you have a service dependency configured, the policy can apply using early-bound or late-bound enforcement.

- **Early-bound policy enforcement** means a user must satisfy the dependent service policy before accessing the calling app. For example, a user must satisfy SharePoint policy before signing into Microsoft Teams.
- **Late-bound policy enforcement** occurs after the user signs into the calling app. Enforcement is deferred to when calling app requests, a token for the downstream service. Examples include Microsoft Teams accessing Planner and Office.com accessing SharePoint.

The following diagram illustrates Microsoft Teams service dependencies. Solid arrows indicate early-bound enforcement the dashed arrow for Planner indicates late-bound enforcement.

![A diagram showing Microsoft Teams service dependencies.](./media/service-dependencies/01.png)

As a best practice, you should set common policies across related apps and services whenever possible. Having a consistent security posture provides you with the best user experience. For example, setting a common policy across Exchange Online, SharePoint Online, and Microsoft Teams reduces prompts that might arise from different policies being applied to downstream services.

A great way to accomplish a common policy with applications in Microsoft 365 is to use the [Office 365 app](concept-conditional-access-cloud-apps.md#office-365) instead of targeting individual applications.

The below table lists some more service dependencies, where the client apps must satisfy. This list isn't exhaustive.

| Client apps         | Downstream service                          | Enforcement |
| :--                 | :--                                         | ---         |
| Azure Data Lake     | Windows Azure Service Management API (portal and API) | Early-bound |
| Microsoft Classroom | Exchange                                    | Early-bound |
|                     | SharePoint                                  | Early-bound |
| Microsoft Teams     | Exchange                                    | Early-bound |
|                     | MS Planner                                  | Late-bound  |
|                     | Microsoft Stream                            | Late-bound  |
|                     | SharePoint                                  | Early-bound |
|                     | Skype for Business Online                   | Early-bound |
|                     | Microsoft Whiteboard                        | Late-bound  |
| Office Portal       | Exchange                                    | Late-bound  |
|                     | SharePoint                                  | Late-bound  |
| Outlook groups      | Exchange                                    | Early-bound |
|                     | SharePoint                                  | Early-bound |
| Power Apps          | Windows Azure Service Management API (portal and API) | Early-bound |
|                     | Windows Azure Active Directory              | Early-bound |
|                     | SharePoint                                  | Early-bound |
|                     | Exchange                                    | Early-bound |
| Power Automate      | Power Apps                                  | Early-bound |
| Project             | Dynamics CRM                                | Early-bound |
| Skype for Business  | Exchange                                    | Early-bound |
| Visual Studio       | Windows Azure Service Management API (portal and API) | Early-bound |
| Microsoft Forms     | Exchange                                    | Early-bound |
|                     | SharePoint                                  | Early-bound |
| Microsoft To Do     | Exchange                                    | Early-bound |
| SharePoint          | SharePoint Online Web Client Extensibility  | Early-bound |
|                     | SharePoint Online Web Client Extensibility Isolated | Early-bound |
|                     | SharePoint Client Extensibility web application principal (where present) | Early-bound |

## Troubleshooting service dependencies

The Microsoft Entra sign-in log is a valuable source of information when troubleshooting why and how a Conditional Access policy applied in your environment. For more information about troubleshooting unexpected sign-in outcomes related to Conditional Access, see the article [Troubleshooting sign-in problems with Conditional Access](troubleshoot-conditional-access.md#service-dependencies).

## Next steps

To learn how to implement Conditional Access in your environment, see [Plan your Conditional Access deployment in Microsoft Entra ID](plan-conditional-access.md).

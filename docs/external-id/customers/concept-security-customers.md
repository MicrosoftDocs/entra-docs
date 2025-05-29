---
title: Security and governance
description: Learn about security and governance in Microsoft Entra External ID. Use features like multifactor authentication (MFA), and Conditional Access to secure your applications and mitigate risks.
 
ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 04/03/2025
ms.custom: it-pro
---

# Security and governance in Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

The integration of customer capabilities into Microsoft Entra ID means that your customer scenarios benefit from the advanced security and governance features available in Microsoft Entra ID. Your customers are able to self-service register for your applications using their preferred authentication methods. These methods include social accounts through identity providers like Facebook, Google, Apple, or a custom-configured OpenID Connect (OIDC) identity provider. And you can use features like multifactor authentication (MFA) and Conditional Access to mitigate threats.

> [!NOTE]
> Conditional Access and MFA aren't available in free trial external tenants.

## Conditional Access

Microsoft Entra Conditional Access brings signals together, to make decisions, and enforce security policies. Conditional Access policies at their simplest are if-then statements; **if** a user wants to access your application, **then** they must complete an action.

Conditional Access policies are enforced after the user has completed first-factor authentication. For example, if a user's sign-in risk level is high, they must perform MFA to gain access. Alternatively, the most restrictive approach is to block access to the application.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CA)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Conditional Access and multifactor authentication” use case.

## Multifactor authentication (MFA)

Microsoft Entra MFA helps safeguard access to data and applications while maintaining simplicity for your users. Microsoft Entra External ID integrates directly with Microsoft Entra MFA so you can add security to your sign-up and sign-in experiences by requiring a second form of authentication. You can fine-tune MFA depending on the extent of security you want to apply to your apps. Consider the following scenarios:

- You offer a single app to customers and you want to enable MFA for an extra layer of security. You can enable MFA in a Conditional Access policy that's targeted to all users and your app.

- You offer multiple apps to your customers, but you don't require MFA for every application. For example, the customer can sign into an auto insurance application with a social or local account, but must verify the phone number before accessing the home insurance application registered in the same directory. In your Conditional Access policy, you can target all users but just those apps for which you want to enforce MFA.

Learn more about [MFA in external tenants](concept-multifactor-authentication-customers.md) or see [how to enable multifactor authentication](how-to-multifactor-authentication-customers.md).

<a name='identity-protection'></a>

## Analyze user authentication trends for your apps

The Application user activity  feature under Usage & insights provides data analytics on user activity for registered applications in your tenant. You can use this feature to view, query, and analyze user requests and authentication trends. It can help you track changes, access patterns, and potential security breaches.

For details see [application user activity dashboards](how-to-user-insights.md). 

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)

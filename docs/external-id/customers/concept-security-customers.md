---
title: CIAM security and governance
description: Learn about CIAM security and governance features.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: concept-article
ms.date: 01/18/2024
ms.author: mimart
ms.custom: it-pro

---

# Security and governance in Microsoft Entra External ID

The integration of customer capabilities into Microsoft Entra ID means that your customer scenarios benefit from the advanced security and governance features available in Microsoft Entra ID. Your customers are able to self-service register for your applications using their preferred authentication methods, including social accounts through identity providers like Google and Facebook. And you can use features like multifactor authentication, Conditional Access, and Identity Protection to mitigate threats and detect risks.

> [!NOTE]
> In Conditional Access, MFA, and Identity Protection aren't available in free trial external tenants.

## Conditional Access

Microsoft Entra Conditional Access brings signals together, to make decisions, and enforce security policies. Conditional Access policies at their simplest are if-then statements; **if** a user wants to access your application, **then** they must complete an action.

Conditional Access policies are enforced after the user has completed first-factor authentication. For example, if a user's sign-in risk level is high, they must perform multifactor authentication to gain access. Alternatively, the most restrictive approach is to block access to the application.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CA)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Conditional Access and multifactor authentication” use case.

## Multifactor authentication

Microsoft Entra multifactor authentication helps safeguard access to data and applications while maintaining simplicity for your users. Microsoft Entra External ID integrates directly with Microsoft Entra multifactor authentication so you can add security to your sign-up and sign-in experiences by requiring a second form of authentication. You can fine-tune multifactor authentication depending on the extent of security you want to apply to your apps. Consider the following scenarios:

- You offer a single app to customers and you want to enable multifactor authentication for an extra layer of security. You can enable MFA in a Conditional Access policy that's targeted to all users and your app.

- You offer multiple apps to your customers, but you don't require multifactor authentication for every application. For example, the customer can sign into an auto insurance application with a social or local account, but must verify the phone number before accessing the home insurance application registered in the same directory. In your Conditional Access policy, you can target all users but just those apps for which you want to enforce MFA.

For details, see [how to enable multifactor authentication](how-to-multifactor-authentication-customers.md).
## Identity protection

Microsoft Entra [Identity Protection](~/id-protection/overview-identity-protection.md) provides ongoing risk detection for your external tenant. It allows you to discover, investigate, and remediate identity-based risks. Identity Protection allows organizations to accomplish three key tasks:

- Automate the detection and remediation of identity-based risks.

- Investigate risks using data in the portal.

- Export risk detection data to other tools.

Identity Protection comes with risk reports that can be used to investigate identity risks in external tenants. For details, see [Investigate risk with Identity Protection in Microsoft Entra External ID](how-to-identity-protection-customers.md).

## Analyze user authentication trends for your apps

The Application user activity (Preview) feature under Usage & insights provides data analytics on user activity for registered applications in your tenant. You can use this feature to view, query, and analyze user requests and authentication trends. It can help you track changes, access patterns, and potential security breaches.

For details see [application user activity dashboards](how-to-user-insights.md). 

## Next steps

- [Planning for customer identity and access management](concept-planning-your-solution.md)

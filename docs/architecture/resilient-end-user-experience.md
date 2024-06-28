---
title: Resilient end-user experience using Azure AD B2C
description: Methods to build resilience in end-user experience using Azure AD B2C
ms.service: entra
ms.subservice: architecture
ms.topic: how-to
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.date: 06/28/2024
---

# Resilient end-user experience

The sign-up and sign-in end-user experience is made up of the following elements:

- Interfaces the user interacts with, such as CSS, HTML, and JavaScript
- User flows and custom policies you create, such as sign-up, sign-in, and profile edit
- Identity providers (IDPs) for your application, for instance local account username/password, Outlook, Facebook, and Google

## User flow and custom policy  

To help set up common identity tasks, use Azure AD B2C configurable [user flows](/azure/active-directory-b2c/user-flow-overview). Build your own [custom policies](/azure/active-directory-b2c/custom-policy-overview) for maximum flexibility. However, we recommend you use custom policies only to address complex scenarios.

### User flow or custom policy?

Choose built-in user flows, tested by Microsoft, for needed business requirements. Minimize testing to validate policy-level functional, performance, or scale of the flows. Test applications for functionality, performance, and scale.

If you [use custom policies](/azure/active-directory-b2c/user-flow-overview), perform policy-level testing for functional, performance, or scale. Include application-level testing.

To help you decide, see an article to [compare user flows and custom polices](/azure/active-directory-b2c/user-flow-overview#comparing-user-flows-and-custom-policies).

## Multiple IdPs

If you use an [external identity provider](/azure/active-directory-b2c/add-identity-provider) such as Facebook, have a fallback plan in case the external provider is unavailable.

### Set up multiple IdPs

As part of the external identity provider registration process, include a verified identity claim such user mobile number or email address. Commit the verified claims to the underlying Azure AD B2C directory instance. If the external provider is unavailable, revert to the verified identity claim, and fall back to the mobile number as an authentication method. Another option is to send the user a one-time passcode (OTP) to allow sign-in.

You can [build alternate authentication paths](https://github.com/azure-ad-b2c/samples/tree/master/policies/idps-filter):

 1. Configure your sign-up policy for sign-up by local accounts and external IdPs.
 2. Configure a profile policy for users to [link the other identity to their account](https://github.com/Azure-Samples/active-directory-b2c-advanced-policies/tree/master/account-linking).
 3. Notify and allow users to [switch to an alternate IdP](/azure/active-directory-b2c/customize-ui-with-html#configure-dynamic-custom-page-content-uri) during an outage.

## Availability of multifactor authentication

When using a [phone service for multifactor authentication (MFA)](/azure/active-directory-b2c/phone-authentication-user-flows), consider an alternative service provider. The current service provider might experience service disruptions.

### Choose an alternate MFA  

The Azure AD B2C service uses a phone-based MFA provider to deliver time-based OTPs. It's a voice call and text message to a user's preregistered phone number. There are alternative methods:

When you use user flows, there are two methods to build resilience:

- **Change user flow configuration**: During a disruption in the phone-based OTP delivery, change the delivery method to email. Redeploy the user flow, and leave the applications unchanged.

   ![Screenshot of sign-in sign-up](media/resilient-end-user-experiences/create-sign-in.png)

- **Change applications**: For each identity task, such as sign-up and sign-in, define two sets of user flows. Configure the first set to use phone-based OTP and the second to use email-based OTP. During a disruption in the phone OTP, change and redeploy the applications to the second flow. Leave the user flows unchanged.  

For custom policies, there are four methods to build resilience. The following list is in order of complexity. Ensure you redeploy updated policies.

- **Enable user selection of phone or email OTP**: Expose both options to users and enable self-select. Don't change the policies or applications.

- **Dynamically switch between phone and email OTP**: Collect phone and email at sign-up. Define custom policy to switch conditionally during a phone disruption to email OTP. Don't change the policies or applications.

- **Use an authenticator app**: Update custom policy to use an [authenticator app](https://github.com/azure-ad-b2c/samples/tree/master/policies/custom-mfa-totp). If your MFA is phone or email OTP, redeploy custom policies to use an authenticator app.

   >[!Note]
   >Users configure authenticator app integration during sign-up.

- **Use security questions**: If no previous method applies, implement security questions as backup. Set up security questions during onboarding or profile edit. Store the answers in a separate database. This security method doesn't meet the MFA requirement of *something you have*. Instead it's *something that you know*.

## Content delivery network

To store custom user flow UI, content delivery networks (CDNs) are better performing and less expensive than blob stores. The web page content goes faster from a geographically distributed network of highly available servers.  

Periodically test your CDN availability and content distribution performance by using end-to-end scenario and load testing. For surges from a promotion or holiday traffic, revise estimates for load testing.
  
## Next steps

- [Resilience resources for Azure AD B2C developers](resilience-b2c.md)
  - [Resilient interfaces with external processes](resilient-external-processes.md)
  - [Resilience through developer best practices](resilience-b2c-developer-best-practices.md)
  - [Resilience through monitoring and analytics](resilience-with-monitoring-alerting.md)
- [Build resilience in authentication infrastructure](resilience-in-infrastructure.md)
- [Increase resilience of authentication and authorization in applications](resilience-app-development-overview.md)

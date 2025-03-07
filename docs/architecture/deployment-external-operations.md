---
title: Microsoft Entra External ID deployment guide for operations
description: Learn about subscriptions, consumer app security, and fraud tactics in operations for Microsoft Entra External ID.
author: gargi-sinha
manager: martinco
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 03/07/2025
ms.author: gasinh

#customer intent: I need to understand subscriptions and billing, consumer app security, and how to prevent fraud tactics in Microsoft Entra External ID.
---

# Microsoft Entra External ID deployment guide for operations

Many deployments include a production and at least one nonproduction environment. The nonproduction environments enable validation of the configuration changes without affecting the production tenant. 

## Deployment plans: Microsoft Entra External ID environment

The deployments typically include production, development, staging, or development tenants, etc. Tenants are attached to subscriptions for billing. In certain cases, customers prefer the nonproduction billing separate from production billing. Subscription choice affects billing. Use the following job aid to document this tenant information. 

|Use|Tenant name|Billing subscription
|---|---|---|
|Production|||
|Development|||
|Test|||
|Quality Assurance|||

## Consumer application security

When designing your consumer-facing authentication experiences, consider how to protect services from abuse. With Microsoft Entra External ID, you control the user flow and balance the user experience with friction. Some security features increase friction, and others are transparent. 

Attackers constantly change the way they operate; therefore, a defence-in-depth strategy protects user flows by preventing sign-up and sign-in fraud. 

### Edge protection with custom domains

When a web-based redirect is used for user flows, consumers see the domain name of the authentication endpoint. By default, this endpoint uses the format **\<tenantprefix>.ciamlogin.com**, where **\<tenantprefix>** is the tenant-name prefix. For example, for **contoso.onmicrosoft.com**, the tenant prefix is **contoso**. 

In Microsoft Entra External ID, you can change the domain name to one that you own, and one that your customer can relate to your service. For example, you might use **login.contoso.com**. 

In addition to branding capabilities, using a custom domain name enables integration of a web application firewall (WAF) solution, which has more protection from bots and malicious actors.  

Learn more about [custom URL domains in external tenants](../external-id/customers/concept-custom-url-domain.md). 

In the following diagram, see the custom domain example. 

   [ ![Diagram of a custom domain example.](media/deployment-external/custom-domain.png)](media/deployment-external/custom-domain-expanded.png#lightbox)

When using other WAF protection in your solution, block access to the default **ciamlogin.com** domain name. Without this change, attackers use the domain name and bypass WAF protections. 

### Distributed denial of service

A distributed denial of service (DDoS) attack prevents users from authenticating. Because the authentication endpoint ***.ciamlogin.com** is publicly accessible, malicious actors can target it. Microsoft protects the authentication endpoint with throttling limits, ideally augmented with your edge protection. 

We recommend you use a WAF, such as Cloudflare or Akamai, with your custom domain name. This capability is available when you configure a custom domain name. 

### International Revenue Share Fraud

An International Revenue Share Fraud (IRSF) is a financially driven attack that can occur when you expose short message service (SMS) verification on a publicly accessible endpoint. When you enable Microsoft Entra multifactor authentication (MFA) on Microsoft Entra External ID, IRSF attacks are possible. Ask users to perform SMS verification to record a valid phone number and/or for multifactor authentication.  

If SMS verification is exposed on this page, the most vulnerable attack surface is the sign-up flow. 

To help prevent IRSF attacks, use other capabilities for multifactor authentication, such as email one-time password (OTP), and use edge protection to reduce bad actor access your sign-in page. 

### Sign-up fraud

User flow design influences the rate of sign-up fraud. Typically, sign-up journeys that verify minimal data have high sign-up fraud. Enable email or phone verification to reduce the rate of sign-up fraud. Users validate with another mechanism. 

Controls such as CAPTCHA or identity proofing techniques reduce sign-up fraud rates. CAPTCHA is challenge-response test to determine whether the user is human, and thus deter bot attacks and spam.

Many of these controls are in Microsoft Entra External ID and have varying degrees of friction applied to the user experience. Layer these controls, for example use email verification and CAPTCHA. 

You can use layers of protection, which affect the user experience less, such as integration with fraud prevention technologies. These tools profile user data and enforce MFA controls when risk rises above a defined threshold. 

### Account takeover

Account takeover means a user account is compromised. The attacker changes account credentials, such as email, password, or phone number. These actions prevent the account owner from regaining control.

Layer authentication methods to reduce the rate at which accounts are compromised. To harden user accounts, employ a combination of password credentials, passwordless credentials, and phone authentication.

When sign-in experiences demand less friction, ensure operations allow users to change authentication method details. For example, to change a password or phone number, ensure MFA occurs.

You can reduce the user flow attack surface. For example, block access from certain countries or regions, or enforce stringent authentication methods from countries you don't regularly operate in. Achieve this using [Microsoft Entra Conditional Access](../identity/conditional-access/overview.md) policies.

Use Conditional Access policies to enforce strong authentication methods when applications indicate more risk for some transactions. For example, a user tries to purchase a large quantity of items from an ecommerce website. Use Conditional Access and authentication strengths to enable the user to minimize the risk. 

## Next steps

Use the following articles to help you get started with a Microsoft Entra External ID deployment: 

* [Introduction to Microsoft Entra External ID deployment guide](deployment-external-intro.md)
* [Tenant design](deployment-external-tenant-design.md)
* [Customer authentication experience](deployment-external-customer-authentication.md)
* Operations
* [Authentication and access control architecture](deployment-external-authentication-access-control.md)
* [Auditing and monitoring](deployment-external-audit-monitor.md)

---
title: Service limits and restrictions
description: Learn about the service limits and restrictions in a customer tenant.
 
author: csmulligan
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: reference
ms.date: 02/29/2024
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an IT admin, I want to know about the service limits and restrictions in my customer tenant.
---
<!-- Based on https://learn.microsoft.com/en-us/entra/identity/users/directory-service-limits-restrictions and https://learn.microsoft.com/en-us/azure/active-directory-b2c/service-limits?pivots=b2c-custom-policy and https://microsoft.sharepoint.com/:w:/t/aad/CPIM/EVlzWDYaozFBg-K8W2epuhoBN7rBryTH99MQTNmws_Oqyg?e=2F8Zf0 -->
# Microsoft Entra ID for customers service limits and restrictions

This article contains the usage constraints and other service limits for the Microsoft Entra ID for customers (preview), Microsoft’s new customer identity and access management (CIAM) solution. If you’re looking for the full set of Microsoft Entra ID service limits, see [Microsoft Entra service limits and restrictions](/entra/identity/users/directory-service-limits-restrictions).

## User/consumption related limits

The number of users able to authenticate through a customer tenant is gated through request limits. The following table illustrates the request limits for your tenant.

|Category |Limit    |
|---------|---------|
|Maximum requests per IP per customer tenant       |6,000/5min          |
|Maximum requests per customer tenant     |200/sec          |

## Endpoint request usage

Microsoft Entra ID for customers is compliant with [OAuth 2.0](https://datatracker.ietf.org/doc/html/rfc6749), [OpenID Connect (OIDC)](https://openid.net/certification/) protocols. The following table lists the endpoints and the number of requests consumed by each endpoint.

|Endpoint                 |Endpoint type     |Requests consumed |
|-----------------------------|---------|------------------|
|/oauth2/v2.0/authorize       |Dynamic  |Varies |
|/oauth2/v2.0/token           |Static   |1                 |
|/openid/v2.0/userinfo        |Static   |1                 |
|/.well-known/openid-config   |Static   |1                 |
|/discovery/v2.0/keys         |Static   |1                 |
|/oauth2/v2.0/logout          |Static   |1                 |
|/samlp/sso/login             |Dynamic  |Varies |
|/samlp/sso/logout            |Static   |1                 |


## Token issuance rate

Each type of User Flow provides a unique user experience and will consume a different number of requests.
The token issuance rate of a User Flow is dependent on the number of requests consumed by both the static and dynamic endpoints. The below table shows the number of requests consumed at a dynamic endpoint for each User Flow.

|User Flow |Requests consumed    |
|---------|---------|
|Sign up        |6  |
|Sign in        |4   |
|Password reset |4   |
|Profile edit   |4   |
|Phone Sign Up and Sign In   |6   |

When you add more features to a User Flow, such as multifactor authentication, more requests are consumed. The below table shows how many additional requests are consumed when a user interacts with one of these features.

|Feature |Additional requests consumed    |
|---------|---------|
|Microsoft Entra multifactor authentication          |2   |
|Email one-time password      |2   |
|Age gating     |2   |
|Federated identity provider  |2   |

To obtain the token issuance rate per second for your User Flow:

1. Use the tables above to add the total number of requests consumed at the dynamic endpoint.
2. Add the number of requests expected at the static endpoints based on your application type.
3. Use the formula below to calculate the token issuance rate per second.

```
Tokens/sec = 200/requests-consumed
```

## Configuration limits for Microsoft Entra ID for customers

The following table lists the administrative configuration limits in the Microsoft Entra ID for customers service.

|Category  |Limit  |
|---------|---------|
|Number of scopes per application        |1000          |
|Number of custom attributes per user      |100         |
|Number of redirect URLs per application       |100         |
|Number of sign-out URLs per application        |1          |
|String Limit per Attribute      |250 Chars          |
|Number of customer tenants per subscription      |20         |
|Total number of objects (user accounts and applications) per trial tenant (can't be extended)| 10000 |
|Total number of objects (user accounts and applications) per tenant |50000 (can be extended up to 300000) |
|Number of policies per customer tenant |200          |
|Maximum policy file size      |1,024 KB          |
|Number of API connectors per tenant     |20         |

## Throttle limits for Microsoft Entra ID for customers

Microsoft Entra ID for customers uses throttling to protect the cloud service from denial-of-service (DoS) attacks. The following table lists the throttle limits for the Microsoft Entra ID for customers service.

|Throttling identifier |Limit per tenant |
|---------|---------|
|Application (gateway level)        | NA - 2,500,000 requests per 1 minute, EU - 1,500,000 requests per 1 minute, APAC - 2,000,000 requests per 1 minute, OC - 350000 requests per 1 minute |
|Tenant + Application + Fault Domain (gateway level)        |1,200,000 requests per 1 minute       |
|Tenant (gateway level)        |200 requests per 1 second       |
|IP  (gateway level)        |20 requests per 1 second        |
|IP + Tenant (gateway level)        |20 requests per 1 second        |


## Next steps

* [Start a free trial](quickstart-trial-setup.md)

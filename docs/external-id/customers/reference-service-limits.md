---
title: Service limits and restrictions
description: Learn about the service limits and restrictions in an external tenant.
 
author: csmulligan
manager: dougeby
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: reference
ms.date: 07/07/2025
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an IT admin, I want to know about the service limits and restrictions in my external tenant.
---
# Service limits and restrictions

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article outlines the service limits and usage constraints of Microsoft Entra External ID for external tenants, which is Microsoft’s latest customer identity and access management (CIAM) solution. If you’re looking for the full set of Microsoft Entra ID service limits, see [Microsoft Entra service limits and restrictions](/entra/identity/users/directory-service-limits-restrictions).

## User/consumption related limits

The number of users able to authenticate through an external tenant is gated through request limits. The following table illustrates the request limits for your tenant.


|Category |Limit    |
|---------|---------|
|Maximum requests per IP per external tenant       |20 per second  |  
|Maximum requests per external tenant     |200 per second          |
|Maximum requests per external trial tenant     |20 per second          |

## Endpoint request usage

Microsoft Entra External ID is compliant with [OAuth 2.0](https://datatracker.ietf.org/doc/html/rfc6749), [OpenID Connect (OIDC)](https://openid.net/certification/) protocols. The following table lists the endpoints and the number of requests consumed by each endpoint.

|Endpoint                 |Endpoint type     |Requests consumed |
|-----------------------------|---------|------------------|
|/oauth2/v2.0/authorize       |Dynamic  |Varies |
|/oauth2/v2.0/token           |Static   |1                 |
|/.well-known/openid-config   |Static   |1                 |
|/discovery/v2.0/keys         |Static   |1                 |
|/oauth2/v2.0/logout          |Static   |1                 |

## Token issuance rate

Each type of user flow provides a unique user experience and consumes a different number of requests.
The token issuance rate of a user flow is dependent on the number of requests consumed by both the static and dynamic endpoints. The following table shows the number of requests consumed at a dynamic endpoint for each user flow.
<!-- Add MS Graph limits here.-->
|User flow |Requests consumed    |
|---------|---------|
|Sign up        |6  |
|Sign in        |4   |
|Password reset |4   |

When you add more features to a user flow, such as multifactor authentication, more requests are consumed. The following table shows how many additional requests are consumed when a user interacts with one of these features.

|Feature |Additional requests consumed    |
|---------|---------|
|Email one-time password      |2   |

To obtain the token issuance rate per second for your user flow:

1. Use the previous tables to add the total number of requests consumed at the dynamic endpoint.
2. Add the number of requests expected at the static endpoints based on your application type.
3. Use the following formula to calculate the token issuance rate per second.

```
Tokens/sec = 200/requests-consumed
```

## Configuration limits for Microsoft Entra ID for external configuration tenants

The following table lists the administrative configuration limits in the Microsoft Entra External ID service.

|Category  |Limit  |
|---------|---------|
|Number of scopes per application        |1000          |
|Number of custom attributes per user      |100         |
|Number of redirect URLs per application       |100         |
|Number of sign-out URLs per application        |1          |
|String limit per attribute      |250 Chars          |
|Number of external tenants per subscription      |20         |
|Total number of objects (user accounts and applications) per trial tenant (can't be extended)| 10000 |
|Total number of objects (user accounts and applications) per tenant. If you want to increase this limit, contact [Microsoft Support](/entra/identity-platform/developer-support-help-options?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json#create-an-azure-support-request). | 300,000 |
|Number of [custom authentication extensions](/entra/identity-platform/custom-extension-overview)    |100         |
|Number of event listener policies    |249         |
|Maximum custom authentication extension timeout    |2,000 ms         |
|Maximum custom authentication extension retries    |1         |

## Telephony throttling limits
The following table lists the service limits we implement to prevent outages and slowdowns. [Learn more](~/identity/authentication/concept-mfa-telephony-fraud.md)

|Limit                        |Texts every 15 minutes|Texts every 60 minutes|Texts every 24 hours                                 |Texts every seven days |
|-----------------------------|----------------------|----------------------|-----------------------------------------------------|-------------------|
|Limits based on IP address   |20 texts              |60 texts              |100 texts without a proxy</br>200 texts with a proxy |No limit           |
|Limits based on phone number |15 texts              |20 texts              |30 texts                                             |50 texts           |
|Limits based on tenant       |100 texts             |300 texts             |1,000 texts                                          |No limit           |

## Next steps

- [Start a free trial without an Azure subscription](quickstart-trial-setup.md)
- [Create a tenant with an Azure subscription](quickstart-tenant-setup.md)

---
title: "Tutorial: Enforce secret and certificate standards using application management policies"
description: Learn how to enforce secret and certificate standards using application management policies in Microsoft Entra ID.
author: garrodonnell
manager: CelesteDG
ms.author: godonnell
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: tutorial
ms.date: 03/12/2024

# Customer intent: As an IT administrator, I want to enable secret restrictions using application management policies in Microsoft Entra ID to reduce the risk of unauthorized access to sensitive data.
---

# Tutorial: Enforce secret and certificate standards using application management policies

Ensuring that applications in your organization are using secure authentication is crucial for protecting sensitive data and maintaining the integrity of your systems. Microsoft Entra ID provides a way to enforce secret and certificate restrictions through application management policies. This can help you manage what kinds of secrets and keys can be used and ensure that they are rotated regularly. To learn more about application management policies, see [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy).

Policies can be applied to all applications in your organization or to specific applications. In this tutorial, you will learn how to apply an application management policy for all applications in your tenant. This policy will enable the following restrictions:

> [!div class="checklist"]
> * Disable application passwords / client secrets.
> * Disable symmetric key usage in applications. 
> * Limit asymmetric key (certificate) lifetime to 180 days.

To learn more about recommended security practices for Microsoft Entra tenants, please see [Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).

## Prerequisites

* An active Microsoft Entra tenant.
* An API client such as [Graph Explorer](https://aka.ms/ge). 
* An account with at least the [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) or [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role.

## Recommended practices for secrets and certificates 

Attacks on applications often target secrets such as passwords, keys and certificates, to gain unauthorized access to sensitive data. By enforcing restrictions you can help mitigate these risks and ensure that your applications remain secure. The following are our recommended restrictions to enforce using application management policies:

* **Disable application passwords / client secrets**: Applications that use client secrets might store them in configuration files, hardcode them in scripts, or risk their exposure in other ways. The complexities of secret management make client secrets susceptible to leaks and attractive to attackers.

* **Disable symmetric key usage in applications**: Symmetric keys are similar to client secrets in that they are shared between the application and the resource it accesses. This means that if an attacker gains access to the symmetric key, they can impersonate the application and access sensitive data.

* **Limit asymmetric key (certificate) lifetime to 180 days**: Certificates, if not securely stored, can be extracted and exploited by attackers, leading to unauthorized access. Long-lived certificates are more likely to be exposed over time. Credentials, when exposed, provide attackers with the ability to blend their activities with legitimate operations, making it easier to bypass security controls.

## Read your tenant application management policy

Before you create a new application management policy, you can read your existing policy to see if it meets your needs. The following example shows how to read the default application management policy for your tenant. You can also re-use this API request to confirm the policy has been applied later in this tutorial.

## Request

The following request reads the default application management policy for your tenant. The response will show the current policy settings.

```http
GET https://graph.microsoft.com/v1.0/policies/defaultAppManagementPolicy
```
### Response

The following is an example of the response that shows the default tenant app management policy. Your policy may differ from the example. 

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#policies/defaultAppManagementPolicy/$entity",
    "@odata.id": "https://graph.microsoft.com/v2/927c6607-8060-4f4a-a5f8-34964ac78d70/defaultAppManagementPolicy/00000000-0000-0000-0000-000000000000",
    "id": "00000000-0000-0000-0000-000000000000",
    "displayName": "Default app management tenant policy",
    "description": "Default tenant policy that enforces app management restrictions on applications and service principals. To apply policy to targeted resources, create a new policy under appManagementPolicies collection.",
    "isEnabled": false,
    "applicationRestrictions": {
        "passwordCredentials": [],
        "keyCredentials":[]
    },
    "servicePrincipalRestrictions": {
        "passwordCredentials": [],
        "keyCredentials":[]
    }
}
```
## Update the application management policy using Microsoft Graph

Updating the default application management policy to use our recommendations requires setting the following parameters:

* `passwordCredentials`: Allows you to set parameters for client secrets and symmetric keys.
    * The `restrictionType` parameter allows you to set the type of restriction we want to apply. In this case, we are restricting `passwordAddition`, `customPasswordAddition`, and `symmetricKeyAddition`.
    * The `state` parameter allows you to enable or disable the restriction. If set to `enabled`, the restriction will be applied. If set to `disabled`, the restriction will not be applied.
    * The `maxLifetime` parameter allows you to set the maximum lifetime of the secret.
    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to restrict the secret for applications created after a certain date. Any applications created before this date will be unaffected by the policy. Please ensure you update this date to suit your needs.

* `keyCredentials`: Allows you to set parameters for certificates. In this case, we are restricting the lifetime of application certificates to 180 days.
    * The `restrictionType` parameter allows you to set the type of restriction we want to apply. In this case, we are restricting `asymmetricKeyLifetime`.
    * The `state` parameter allows you to enable or disable the restriction. If set to `enabled`, the restriction will be applied. If set to `disabled`, the restriction will not be applied.
    * The `maxLifetime` parameter allows you to set the maximum lifetime of the certificate. In this case, we are restricting the lifetime to 180 days. This is done using the ISO 8601 duration format. The `P` indicates that this is a period of time, and `180D` indicates that the period is 180 days. For more information on duration formatting please see [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to restrict the secret for applications created after a certain date. Any applications created before this date will be unaffected by the policy. Please ensure you update this date to suit your needs.

### Request

The following request updates the the default application management policy. 

```http
PATCH https://graph.microsoft.com/v1.0/policies/defaultAppManagementPolicy
Content-Type: application/json

{
    "isEnabled": true,
    "applicationRestrictions": {
        "passwordCredentials": [
            {
                "restrictionType": "passwordAddition",
                "state": "enabled",
                "maxLifetime": null,
                "restrictForAppsCreatedAfterDateTime": "2025-02-20T10:37:00Z"
            },
            {
                "restrictionType": "customPasswordAddition",
                "state": "enabled",
                "maxLifetime": null,
                "restrictForAppsCreatedAfterDateTime": "2025-05-20T10:37:00Z"
            },
            {
                "restrictionType": "symmetricKeyAddition",
                "state": "enabled",
                "maxLifetime": null,
                "restrictForAppsCreatedAfterDateTime": "2025-02-20T10:37:00Z"
            },
        ],
        "keyCredentials": [
            {
                "restrictionType": "asymmetricKeyLifetime",
                "state": "enabled",
                "maxLifetime": "P180D",
                "restrictForAppsCreatedAfterDateTime": "2025-02-20T10:37:00Z"
            }
        ]
    },
}
```

### Confirm the policy has been applied

You can confirm that the application management policy has been applied by reading the default application management policy again as shown earlier. The response should show the updated policy with the restrictions you applied.

You can test that the policy has been applied by creating a new application and attempting to add a client secret. If the policy has been applied correctly, you should see a warning indicating that the operation is not allowed due to the restrictions in place.

## Related content

* [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy)
* [Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).
* [Migrate applications away from secret-based authentication](../enterprise-apps/migrate-applications-from-secrets.md)
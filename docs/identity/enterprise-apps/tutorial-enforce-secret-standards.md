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

Policies can be applied to all applications in your organization or to specific applications. In this tutorial, you will learn:

> [!div class="checklist"]
> * Learn about recommend restrictions for secrets and certificates.
> * Read the current application management policy for your tenant. 
> * Update that policy to enforce restrictions.
> * Confirm that the policy has been applied.

## Prerequisites

* An active Microsoft Entra tenant.
* An API client such as [Graph Explorer](https://aka.ms/ge). 
* An account with at least the [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) or [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role.

## Recommended practices for secrets and certificates 

Attacks on applications often target secrets such as passwords, keys and certificates, to gain unauthorized access to sensitive data. By enforcing restrictions you can help mitigate these risks and ensure that your applications remain secure. The following are our recommended restrictions for secrets and certificates:

* **Disable application passwords / client secrets**: Applications that use client secrets might store them in configuration files, hardcode them in scripts, or risk their exposure in other ways. The complexities of secret management make client secrets susceptible to leaks and attractive to attackers.

* **Disable symmetric key usage in applications**: Symmetric keys are similar to client secrets in that they are shared between the application and the resource it accesses. This means that if an attacker gains access to the symmetric key, they can impersonate the application and access the resource. Symmetric keys are also more difficult to manage than asymmetric keys, as they require both parties to share the same key.

* **Limit asymmetric key (certificate) lifetime to 180 days**: Certificates provide a more secure way to authenticate applications than client secrets. However, they can still be compromised if not managed properly. By limiting the lifetime of certificates, you can reduce the risk of long-lived certificates being exploited by attackers. Certificates should be rotated regularly to ensure that they are not compromised. The recommended maximum lifetime for certificates is 180 days. This means that you should rotate your certificates at least every 180. Setting a shorter lifetime for highly sensitive applications can further reduce the risk of compromise.

To learn more about recommended security practices for Microsoft Entra tenants, please see [Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).

## Read your tenant application management policy

Before you create a new application management policy, you can read your existing policy to see if it meets your needs. The following example shows how to read the default application management policy for your tenant. You can also re-use this API request to confirm the policy has been applied later in this tutorial.

## Request

The following request reads the default application management policy for your tenant. The response will show the current policy settings.

```http
GET https://graph.microsoft.com/v1.0/policies/defaultAppManagementPolicy
```
### Response

The following is an example of the response that shows the default tenant app management policy. Your policy may differ from the example. If no policy has been applied in your organization, the `id` field will be set to `00000000-0000-0000-0000-000000000000` and the `isEnabled` field will be set to `false`. 

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
    * The `maxLifetime` parameter allows you to set the maximum lifetime of the secret. For `passwordCredentials` we have set the value to `null`.
    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to set a date from which the policy will take effect. Any applications created before this date will be unaffected by the policy. In this case, we are applying restrictions for applications created after February 20th 2025. Please ensure you update this date to suit your needs.

* `keyCredentials`: Allows you to set parameters for certificates. In this case, we are restricting the lifetime of application certificates to 180 days.
    * The `restrictionType` parameter allows you to set the type of restriction we want to apply. In this case, we are restricting `asymmetricKeyLifetime`.
    * The `state` parameter allows you to enable or disable the restriction. If set to `enabled`, the restriction will be applied. If set to `disabled`, the restriction will not be applied.
    * The `maxLifetime` parameter allows you to set the maximum lifetime of the certificate. In this case, we are restricting the lifetime to 180 days. This is done using the ISO 8601 duration format. The `P` indicates that this is a period of time, and `180D` indicates that the period is 180 days. For more information on duration formatting please see [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations).
    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to restrict the secret for applications created after a certain date. Any applications created before this date will be unaffected by the policy. In this case, we are applying restrictions for applications created after February 20th 2025. Please ensure you update this date to suit your needs.

### Request

The following request updates the the default application management policy with the settings discussed above. 

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
### Response

Once the request is sent, you should receive a response indicating that the policy has been updated successfully. The response should be a `204 No Content` status code, indicating that the request was successful and there is no content to return.

```http
    HTTP/1.1 204 No Content
```

## Confirm the policy has been applied

Once you have updated your application management, you can confirm that it has been applied by reading the default application management policy again as [shown earlier](#read-your-tenant-application-management-policy). The response should show the updated policy with the restrictions you applied.

If this is the first time you are applying an application management policy you will also notice that the `id` field has changed from `00000000-0000-0000-0000-000000000000` to a new GUID. This indicates that the policy has been created.

## Related content

* To learn more about available restrictions and policy settings, see [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy)
* To learn more about security best practices for your organization, see[Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).
* To learn more about alternatives to authenticating with secrets, see [Migrate applications away from secret-based authentication](../enterprise-apps/migrate-applications-from-secrets.md)
---
title: "Tutorial: Enforce secret and certificate standards using application management policies"
description: Learn how to enforce secret and certificate standards using application management policies in Microsoft Entra ID.
author: garrodonnell
manager: dougeby
ms.author: godonnell
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: tutorial
ms.date: 03/12/2024
zone_pivot_groups: enterprise-app-graph-ps-ms-graph

# Customer intent: As an IT administrator, I want to enable secret restrictions using application management policies in Microsoft Entra ID to reduce the risk of unauthorized access to sensitive data.
---

# Tutorial: Enforce secret and certificate standards using application management policies

In this tutorial, you learn how to enforce secret and certificate standards using application management policies in Microsoft Entra ID. 

Ensuring that applications in your organization are using secure authentication is crucial for protecting sensitive data and maintaining the integrity of your systems. Microsoft Entra ID provides a way to enforce secret and certificate restrictions through application management policies. This feature can help you manage what kinds of secrets and keys can be used and ensure that they're rotated regularly. Application management policies can only be updated using Microsoft Graph PowerShell or Microsoft Graph API. To learn more about this feature, see [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy).

Policies can be applied to all applications in your organization or to specific applications. In this tutorial, you learn:

> [!div class="checklist"]
> * Learn about recommended restrictions for secrets and certificates.
> * Read the current application management policy for your tenant. 
> * Update the application policy to enforce restrictions.
> * Confirm that the policy has been applied.

> [!Important]
> Making changes to your application management policy can have a significant impact on your applications and their ability to authenticate. Before making any changes, it's important to understand the implications of those changes and how they might affect your applications. You should test any changes in a non-production environment before applying them to your production environment and make a copy of the current policy settings before you update them. 

## Prerequisites

* A user account. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* At least the [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) or [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator) role.
* An API client such as [Graph Explorer](https://aka.ms/ge) **OR**
* Microsoft Graph PowerShell module installed. See [Install the Microsoft Graph PowerShell module](/powershell/microsoftgraph/installation?view=graph-powershell-1.0&preserve-view=true).


## Recommended practices for secrets and certificates

Attacks on applications often target secrets such as passwords, keys, and certificates, to gain unauthorized access to sensitive data. By enforcing restrictions, you can mitigate these risks and ensure that your applications remain secure. The following are our recommended restrictions for secrets and certificates:

* **Disable application passwords / client secrets**: Applications that use client secrets might store them in configuration files, hardcode them in scripts, or risk their exposure in other ways. The complexities of secret management make client secrets susceptible to leaks and attractive to attackers.

* **Disable symmetric key usage in applications**: Symmetric keys are similar to client secrets in that they're shared between the application and the resource it accesses. This means that if an attacker gains access to the symmetric key, they can impersonate the application and access the resource. Symmetric keys are also more difficult to manage than asymmetric keys, as they require both parties to share the same key.

* **Limit asymmetric key (certificate) lifetime to 180 days**: Certificates provide a more secure way to authenticate applications than client secrets. However, they can still be compromised if not managed properly. By limiting the lifetime of certificates, you can reduce the risk of long-lived certificates being exploited by attackers. Certificates should be rotated regularly to ensure that they aren't compromised. The recommended maximum lifetime for certificates is 180 days. This means that you should rotate your certificates at least every 180 days. Setting a shorter lifetime for highly sensitive applications can further reduce the risk of compromise. We also recommend you configure automatic rotation of certificates using Azure Key Vault. To learn more, see [Automate the rotation of a secret for resources that use one set of authentication credentials](/azure/key-vault/secrets/tutorial-rotation)

To learn more about recommended security practices for Microsoft Entra tenants, see [Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).

## Read your tenant application management policy

Before you create a new application management policy, you can read your existing policy to see if it meets your needs. The following example shows how to read the default application management policy for your tenant. You can also reuse this API request to confirm the policy has been applied later in this tutorial.

### Example

The following example reads the default application management policy for your tenant. The response shows the current policy settings.

:::zone pivot="ms-powershell"

Connect to Microsoft Graph using the `Connect-MgGraph` cmdlet and the `Policy.Read.All` permission. Sign in with at least the [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator) role. Then, run the following commands to read the default application management policy for your tenant.

```powershell
Connect-MgGraph -Scopes 'Policy.Read.All'
# Get the default application management policy
Get-MgPolicyDefaultAppManagementPolicy | format-list
```
For more info on this cmdlet, see [Get-MgPolicyDefaultAppManagementPolicy](/powershell/module/microsoft.graph.identity.signins/get-mgpolicydefaultappmanagementpolicy?view=graph-powershell-1.0&preserve-view=true).

### Output

The following example shows the output of the default tenant app management policy. Your policy might differ from the example. If no policy is applied in your organization, the `id` field is set to `00000000-0000-0000-0000-000000000000` and the `isEnabled` field is set to `false`.

```output
ApplicationRestrictions      : Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppManagementApplicationConfiguration
DeletedDateTime              :
Description                  : Default tenant policy that enforces app management restrictions on applications and service principals. To apply policy to targeted resources, create a new policy under appManagementPolicies collection.
DisplayName                  : Default app management tenant policy
Id                           : 00000000-0000-0000-0000-000000000000
IsEnabled                    : false
ServicePrincipalRestrictions : Microsoft.Graph.PowerShell.Models.MicrosoftGraphAppManagementServicePrincipalConfiguration
AdditionalProperties         : {[@odata.context, https://graph.microsoft.com/v1.0/$metadata#policies/defaultAppManagementPolicy/$entity]}
```

:::zone-end

:::zone pivot="ms-graph"

Sign into Microsoft Graph explorer with at least a [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator) role. Then, run the following request to read the default application management policy for your tenant. Ensure you consent to the `Policy.Read.All` permission.


```http
GET https://graph.microsoft.com/v1.0/policies/defaultAppManagementPolicy
```
For more info on this request, see [Get tenantAppManagementPolicy](/graph/api/tenantappmanagementpolicy-get?view=graph-rest-1.0&tabs=http&preserve-view=true).

### Response

The following example shows the response of the default tenant app management policy. Your policy might differ from the example. If no policy is already applied in your organization, the `id` field is set to `00000000-0000-0000-0000-000000000000` and the `isEnabled` field is set to `false`. 

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

:::zone-end

> [!Important]
> Make a copy of the current policy settings before you update them. This will allow you to revert back to the original settings if needed. You can do this by copying the current policy settings to a file or by taking a screenshot of the settings. You won't be able to find the original settings after you update them if you have not saved them.

## Update the application management policy

To implement secret and certificate restrictions, you need to update the default application management policy. This example provides our recommended settings but you can adjust them to suit your needs or even omit certain elements if you don't want to apply them. The following example shows how to update the default application management policy with the recommended settings:

* `passwordCredentials`: Allows you to set policies to restrict attributes for client secrets and symmetric keys. This can be omitted if you don't want to set a policy to restrict these types of credentials.

    * The `restrictionType` parameter allows you to set the type of restriction you want to apply. In this case, you're restricting `passwordAddition`, `customPasswordAddition`, and `symmetricKeyAddition`. These settings will limit the creation of client secrets, custom passwords and symmetric keys.

    * The `state` parameter allows you to enable or disable the restriction. If set to `enabled`, the restriction will be applied. If set to `disabled`, the restriction won't be applied.

    * The `maxLifetime` parameter allows you to set the maximum lifetime of the secret. For `passwordCredentials` you have set the value to `null`. Setting the value to `null` means that the maximum lifetime isn't restricted. This is because you're disabling the creation of client secrets and symmetric keys entirely. If you want to set a maximum lifetime for client secrets, you can set this value to a duration in ISO 8601 format. You'll find an example of this in the next section. For more information on duration formatting, see [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations).

    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to set a date from which the policy will take effect for new applications. Any applications created before this date will be unaffected by the policy. In this case, you're applying restrictions for applications created after February 20th 2025. Please ensure you update this date to suit your needs. If you want to set different restrictions for applications created before or after a certain date you can set multiple policies with different `restrictForAppsCreatedAfterDateTime` values. 

* `keyCredentials`: Allows you to set parameters for certificates. In this case, you're restricting the lifetime of application certificates to 180 days.

    * The `restrictionType` parameter allows you to set the type of restriction you want to apply. In this case, you're restricting `asymmetricKeyLifetime`. This will limit the lifetime of application certificates to a user-defined value.

    * The `state` parameter allows you to enable or disable the restriction. If set to `enabled`, the restriction will be applied. If set to `disabled`, the restriction won't be applied.

    * The `maxLifetime` parameter allows you to set the maximum lifetime of the certificate. In this case, you're restricting the lifetime of certificates to 180 days. This is done using the ISO 8601 duration format. The prefix `P` indicates that the value is for a period of time, and `180D` indicates that the period is 180 days. You can change the number from `180` to another value to suit your specific needs. For more information on duration formatting, please see [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations).

    * The `restrictForAppsCreatedAfterDateTime` parameter allows you to set a date from which the policy will take effect for new applications. Any applications created before this date will be unaffected by the policy. In this case, you're applying restrictions for applications created after February 20th 2025. Please ensure you update this date to suit your needs. If you want to set different restrictions for applications created before or after a certain date you can set multiple policies with different `restrictForAppsCreatedAfterDateTime` values. 

### Example

The following example updates the default application management policy with the settings discussed in the previous section. 

:::zone pivot="ms-powershell"

```powershell
Connect-MgGraph -Scopes 'Policy.ReadWrite.All'
Import-Module Microsoft.Graph.Identity.SignIns
# Define the parameters for the application management policy
$params = @{
isEnabled = $true
applicationRestrictions = @{
    passwordCredentials = @(
        @{
            restrictionType = "passwordAddition"
            state = "enabled"
            maxLifetime = $null
            restrictForAppsCreatedAfterDateTime = [System.DateTime]::Parse("2025-02-20T10:37:00Z")
        }
        @{
            restrictionType = "customPasswordAddition"
            state = "enabled"
            maxLifetime = $null
            restrictForAppsCreatedAfterDateTime = [System.DateTime]::Parse("2025-05-20T10:37:00Z")
        }
        @{
            restrictionType = "symmetricKeyAddition"
            state = "enabled"
            maxLifetime = $null
            restrictForAppsCreatedAfterDateTime = [System.DateTime]::Parse("2025-02-20T10:37:00Z")
        }
    )
    keyCredentials = @(
        @{
            restrictionType = "asymmetricKeyLifetime"
            maxLifetime = "P180D"
            restrictForAppsCreatedAfterDateTime = [System.DateTime]::Parse("2025-02-20T10:37:00Z")
        }
    )
}
}
# Update the default application management policy
Update-MgPolicyDefaultAppManagementPolicy -BodyParameter $params
```
For more info on this cmdlet, see [Update-MgPolicyDefaultAppManagementPolicy](/powershell/module/microsoft.graph.identity.signins/update-mgpolicydefaultappmanagementpolicy?view=graph-powershell-1.0&preserve-view=true).

:::zone-end

:::zone pivot="ms-graph"

Ensure you consent to the `Policy.ReadWrite.All` permission. Then, run the following request to update the default application management policy for your tenant.

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

For more info on this request, see [Update tenantAppManagementPolicy](/graph/api/tenantappmanagementpolicy-update?view=graph-rest-1.0&tabs=http&preserve-view=true).

### Response

Once the request is sent, you should receive a response indicating that the policy is updated successfully. The response should be a `204 No Content` status code, indicating that the request was successful and there's no content to return.

```http
    HTTP/1.1 204 No Content
```

:::zone-end

## Confirm the policy is applied

Once you update your application management policy, you can confirm that it's applied by reading the default application management policy again as [shown earlier](#read-your-tenant-application-management-policy). The response should show the updated policy with the restrictions you applied.

If it's the first time, you're applying an application management policy the `id` field should have changed from `00000000-0000-0000-0000-000000000000` to a new GUID. This change indicates that the policy is created.

You can also confirm that the policy is applied by creating a new application and checking if the restrictions are enforced. For example, if you try to create a new application with a client secret or symmetric key, you should receive an error indicating that the operation isn't allowed as shown in the below screenshot.

:::image type="content" source="media/tutorial-enforce-secret-standards/client-secrets-blocked.png" alt-text="Screenshot of the Microsoft Entra admin center showing a warning that client secrets are blocked by tenant wide policy.":::

## Related content

* To learn how to automate secret rotation, see [Automate the rotation of a secret for resources that use one set of authentication credentials](/azure/key-vault/secrets/tutorial-rotation).
* To learn more about available restrictions and policy settings, see [Microsoft Entra application management policies API overview](/graph/api/resources/applicationauthenticationmethodpolicy)
* To learn more about security best practices for your organization, see[Configure Microsoft Entra for increased security](https://aka.ms/EntraSecurityRecommendations).
* To learn more about alternatives to authenticating with secrets, see [Migrate applications away from secret-based authentication](../enterprise-apps/migrate-applications-from-secrets.md)

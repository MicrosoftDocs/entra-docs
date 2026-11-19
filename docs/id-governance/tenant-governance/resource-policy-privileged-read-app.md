---
title: Configure a privileged-read app for Microsoft Entra resource policy (preview)
description: Configure and maintain a customer-owned application for read-only Microsoft Graph calls from resource policies that use fetchAsPolicy.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a policy administrator, I want to configure least-privileged policy reads so that policies can evaluate related resource state without relying on caller read access.
---

# Configure a privileged-read app for Microsoft Entra resource policy (preview)

Follow these steps to let resource policies read Microsoft Graph data through `fetchAsPolicy()`, independently of the caller's permissions. For function details, see [Read additional Microsoft Graph data](resource-policy-rego.md#read-additional-microsoft-graph-data).

The trust values below apply to the global service. Confirm resource policy availability and trust values before using another cloud.

## Prerequisites

- An existing single-tenant application registration and its service principal in the target tenant.
- A work or school member account in that tenant that owns the application registration and has an active [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) role. Application ownership lets you manage its federated identity credential without a tenant-wide application administrator role. See [Create a federated identity credential](/graph/api/federatedidentitycredential-post).
- [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), signed in to that tenant with this account, with admin consent for the delegated `Application.ReadWrite.All` and `ResourcePolicyConfiguration.ReadWrite.All` permissions for the setup requests.
- An administrator with the [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) role to [grant tenant-wide admin consent](~/identity/enterprise-apps/grant-admin-consent.md) for the read application's Microsoft Graph **application permissions**.
- The read application's permission list, determined from the Microsoft Graph API reference for each read your policies make. The [live-read validation example](#validate-a-live-privileged-read) uses the `Application.Read.All` application permission.

Activate any eligible roles through Privileged Identity Management (PIM) before starting. Graph Explorer's delegated setup permissions are separate from the privileged-read application's application permissions.

## Configure the application

Use the Microsoft Entra admin center to configure the application's API permissions and grant admin consent. Use Microsoft Graph Explorer for the Microsoft Graph setup requests below.

### Add application permissions

Use the application owner account for these steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) with the application owner account listed in [Prerequisites](#prerequisites). Confirm you're working in the target tenant.
1. Browse to **Entra ID** > **App registrations** > **Owned applications**, and select the existing privileged-read application.
1. On the application's **Overview** page, record the following values:

    | Value | Used for |
    | --- | --- |
    | **Application (client) ID** | Requesting the federated credential subject and setting the privileged-read app. |
    | **Object ID** | Creating the federated identity credential on the application object. |
    | **Directory (tenant) ID** | Setting the tenant-specific issuer for the federated identity credential. |

    Copy **Object ID** from the app registration, not from **Enterprise applications**, which shows the service principal's object ID.

1. Under **Manage**, select **API permissions** > **Add a permission**.
1. Select **Microsoft Graph** > **Application permissions**. Don't select **Delegated permissions** for the privileged-read app.
1. Search for and select only the read permissions required by your policies. For the [live-read validation example](#validate-a-live-privileged-read), select `Application.Read.All`.
1. Select **Add permissions**.
1. Review the **Configured permissions** list. Confirm the required Microsoft Graph permissions have **Application** as their **Type**. Don't add application-management or policy-management permissions to this app.

### Grant admin consent

Have the administrator with an active **Privileged Role Administrator** role complete these steps.

1. Sign in to the Microsoft Entra admin center in the same tenant.
1. Browse to **Entra ID** > **App registrations** > **All applications** and select the privileged-read app.
1. Confirm its **Application (client) ID** matches the value recorded above.
1. Open **API permissions** and review the full permission list.
1. Select **Grant admin consent for \<tenant name\>**, then select **Yes** to confirm.
1. Confirm the required application permissions show **Granted for \<tenant name\>** in the **Status** column.

Continue with the following Graph Explorer procedures using the application owner account listed in [Prerequisites](#prerequisites). Don't create a client secret.

### Create the federated identity credential

1. In Graph Explorer, call [getFederatedIdentityCredentialSubject](/graph/api/resourcepolicyconfiguration-getfederatedidentitycredentialsubject?view=graph-rest-beta&preserve-view=true). Use the application's client ID:

    ```http
    GET https://graph.microsoft.com/beta/admin/resourcePolicy/configuration/getFederatedIdentityCredentialSubject(appId='<application-client-id>')
    ```

1. Copy the response's `value` exactly. The subject is specific to the tenant and app; don't construct it or reuse another app's subject.
1. [Create the credential](/graph/api/federatedidentitycredential-post) with the following request. Replace every placeholder, using the application object's ID in the path:

    ```http
    POST https://graph.microsoft.com/v1.0/applications/<application-object-id>/federatedIdentityCredentials
    Content-Type: application/json

    {
      "name": "entra-resource-policy",
      "issuer": "https://login.microsoftonline.com/<tenant-id>/v2.0",
      "subject": "<value-returned-by-the-subject-function>",
      "audiences": [
        "api://AzureADTokenExchange"
      ]
    }
    ```

1. Confirm the response is `201 Created`.

Match issuer, subject, and audience exactly, including case. Don't use `common`, `organizations`, or the v1 issuer, append a trailing slash to the issuer, or append `/.default` to the audience.

### Set the privileged-read app

1. Read the current configuration and copy `@odata.etag`, if present:

    ```http
    GET https://graph.microsoft.com/beta/admin/resourcePolicy/configuration
    ```

1. Update the configured app ID with the application's client ID:

    ```http
    PATCH https://graph.microsoft.com/beta/admin/resourcePolicy/configuration
    Content-Type: application/json
    If-Match: <current-configuration-etag>
    ```

    ```json
    {
      "privilegedReadSetting": {
        "appId": "<application-client-id>"
      }
    }
    ```

1. Read the configuration again and confirm the intended app ID is saved.

For initial configuration, omit `If-Match` because the empty configuration has no ETag. For later updates, use the latest ETag; after `412 Precondition Failed`, reread the configuration before retrying. See [Update resourcePolicyConfiguration](/graph/api/resourcepolicyconfiguration-update?view=graph-rest-beta&preserve-view=true).

Configure the application before creating or updating a policy definition that uses `fetchAsPolicy()`.

## Validate a live privileged read

After configuring the app or changing its credentials or consent, use this test to read an application's ID through `fetchAsPolicy()`. Run it before deploying dependent policies. It doesn't create a definition or assignment or update the application.

For this validation, you need:

- A work or school account in the target tenant with an active [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) role.
- The [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation), with admin consent for Microsoft Graph PowerShell's delegated `ResourcePolicyEvaluation.Read.All` and `ResourcePolicyDefinition.ReadWrite.All` permissions. A grant to Graph Explorer doesn't grant these permissions to Microsoft Graph PowerShell.
- The configured privileged-read app with the consented `Application.Read.All` **application permission**, and an existing application's object ID in the same tenant. The evaluation client's permissions don't replace the app's permission.

Activate an eligible role through Privileged Identity Management (PIM) before signing in. Run these steps in the same PowerShell session:

1. Authenticate Microsoft Graph PowerShell. Replace `<tenant-id>` with your tenant ID:

    ```powershell
    Connect-MgGraph -TenantId '<tenant-id>' -Scopes `
        'ResourcePolicyEvaluation.Read.All', 'ResourcePolicyDefinition.ReadWrite.All'
    ```

1. Prepare the validation request. Replace `<application-object-id>` with the application object's ID, not its client ID or service principal ID. The policy reports compliance only if the read returns HTTP `200` and the expected ID:

    ```powershell
    $applicationObjectId = '<application-object-id>'
    $fetchPath = '/v1.0/applications/{0}?$select=id' -f $applicationObjectId
    $policy = @"
    package graph.privileged_read_validation["1.0.0"]

    __metadata__ := {
        "title": "Validate a privileged read",
        "description": "Check access to the configured application.",
        "selector": {
            "resourceName": "microsoft.graph.application",
            "operations": ["updateOrUpsert"]
        }
    }

    default deny := {"result": true, "reasons": ["Privileged read validation failed."]}

    deny := {"result": false, "reasons": []} if {
        response := fetchAsPolicy({"relativePathUri": "$fetchPath"})
        response.code == 200
        response.data.id == "$applicationObjectId"
    }
    "@

    $body = @{
        policy = $policy
        resourceUri = "/v1.0/applications/$applicationObjectId"
        httpMethod = 'patch'
        resourceBody = @{ displayName = 'Privileged read validation' }
        enforcementMode = 'doNotEnforce'
        isResultDetailed = $true
    }
    ```

1. Submit the request to [evaluatePolicy](/graph/api/resourcepolicyroot-evaluatepolicy?view=graph-rest-beta&preserve-view=true). The request omits `fetchResponses` so that the service performs a real read, not a simulated response:

    ```powershell
    $result = Invoke-MgGraphRequest -Method POST `
        -Uri 'https://graph.microsoft.com/beta/admin/resourcePolicy/evaluatePolicy' `
        -ContentType 'application/json' -Body ($body | ConvertTo-Json -Depth 10)
    $result | ConvertTo-Json -Depth 20
    ```

1. Confirm `appliedPoliciesEffects: "compliant"` and no loading or evaluation errors in `details`. A failed read, non-200 response, or mismatched ID isn't success. In `doNotEnforce` mode, `isBlocked: false` alone doesn't prove the read worked.

Repeat the test for the specific reads your policies require. This example verifies application-read access, not every Microsoft Graph permission.

Saving an app ID doesn't verify its read permissions. Use the live-read test after configuration or consent changes.

## Maintain or disable privileged reads

Use the following procedures to replace the application or stop privileged reads.

### Replace the application

1. Prepare the new app's federated credential and consent using [Configure the application](#configure-the-application).
1. [Update the configured app ID](#set-the-privileged-read-app) with the current ETag, then rerun live-read validation.
1. Review dependent policies and granted permissions. Revoke obsolete grants explicitly; adding a permission doesn't remove old grants.

Federated credentials don't need scheduled secret rotation. If a credential changes unexpectedly, restore its exact trust values and retest.

### Disable privileged reads

> [!WARNING]
> This change disables privileged reads tenant-wide and affects every policy that uses `fetchAsPolicy()`.

1. Review all policies that use `fetchAsPolicy()` and how they handle failed reads.
1. [Update the configuration](#set-the-privileged-read-app) with `appId` set to `null`:

    ```json
    {
      "privilegedReadSetting": {
        "appId": null
      }
    }
    ```

For configuration or read failures, see [Troubleshoot unexpected results](resource-policy-test-troubleshoot.md#troubleshoot-unexpected-results). Don't treat a failed read as evidence of compliance; test how your policies handle read errors.

## Related content

- [Author resource policies with Rego](resource-policy-rego.md).
- [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).

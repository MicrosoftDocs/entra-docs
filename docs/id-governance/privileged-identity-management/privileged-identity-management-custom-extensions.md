---
title: Configure custom extensions for PIM role activation (Preview)
description: Learn how to configure custom extensions in Microsoft Entra Privileged Identity Management (PIM) to integrate custom business logic into role activation workflows.
ms.topic: how-to
ms.date: 10/12/2026
ms.custom: pim, msecd-doc-authoring-1012
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to configure custom extensions in Privileged Identity Management so that I can integrate custom business logic into role activation workflows.

---

# Configure custom extensions for Privileged Identity Management role activation (Preview)

Custom extensions in Microsoft Entra Privileged Identity Management (PIM) enable organizations to integrate custom business logic into the role activation process. These extensions are implemented as REST APIs that PIM calls during policy evaluation. The custom extension evaluates the activation request and returns a decision to PIM indicating whether the activation should be allowed or denied.

Use custom extensions to:

- Validate ticket numbers against internal systems.
- Enforce HR-based access rules, such as employment status or role eligibility.
- Integrate compliance workflows or audit systems.
- Apply dynamic approval logic based on business context.
- Run asynchronous validation after manual approval and before PIM provisions the assignment.
- Collect extra business context, such as a cost center or project code, during activation.

Custom extensions support PIM for Groups, PIM for Microsoft Entra roles, and PIM for Azure resources.

:::image type="content" source="media/privileged-identity-management-custom-extensions/custom-extension-architecture-flow.png" alt-text="Diagram that shows the PIM custom extension architecture flow from activation request through policy evaluation to the custom extension API and external services." lightbox="media/privileged-identity-management-custom-extensions/custom-extension-architecture-flow.png":::

> [!IMPORTANT]
> Custom extensions for PIM are in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

## License requirements

Using custom extensions with PIM requires an active Microsoft Entra ID Governance or Microsoft Entra Suite license. Microsoft Entra ID P2 alone doesn't include PIM custom extensions. For more information, see [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).

## Prerequisites

- An assignment of at least the **Privileged Role Administrator** role.
- A REST API endpoint that accepts HTTP POST requests and returns evaluation responses in the format PIM expects. The API can be built in any language and hosted on any platform.
- A Microsoft Entra ID application registration to secure communication between PIM and your custom extension endpoint.
- The Microsoft Graph API `beta` endpoint is required because this feature is in preview.
- The following delegated Microsoft Graph permissions, depending on the operation:

  | Operation | Permission (least privileged) |
  |---|---|
  | Create or update a custom extension | `PrivilegedAccess-CustomExt.ReadWrite.All` |
  | Get or list custom extensions | `PrivilegedAccess-CustomExt.Read.All` |

## How custom extensions work

When a user submits a role activation request, PIM:

1. Evaluates the role management policy that applies to the request.
1. Calls the customer-hosted REST endpoint when a custom extension is configured for the applicable policy stage.
1. Sends the request information that the extension needs to evaluate the activation.
1. Waits for the extension to apply customer-defined business logic and return an outcome.
1. Records the interaction for audit and traceability.
1. Continues, denies, auto-approves, or defers the request based on the extension type and returned outcome.

## Step 1 - Build your custom extension endpoint

Build a REST API that accepts HTTP POST requests from PIM. During role activation, PIM sends a request payload to your endpoint with the information needed to evaluate the activation. Your API evaluates the request and returns a response indicating whether the activation should be approved, auto-approved, or denied.

The request model PIM sends depends on the resource type: Microsoft Entra group, Microsoft Entra role, or Azure resource. The following sections provide examples based on which resource type is being used.

### Request model for PIM for Groups

In the request model for PIM for groups, PIM sends a `privilegedAccessGroupAssignmentScheduleRequest` object. For the full schema, see [Create assignmentScheduleRequest](/graph/api/privilegedaccessgroup-post-assignmentschedulerequests).

```json
{
  "@odata.type": "#microsoft.graph.privilegedAccessGroupAssignmentScheduleRequest",
  "id": "String (identifier)",
  "status": "String",
  "action": "String",
  "justification": "String",
  "principalId": "String",
  "accessId": "String",
  "groupId": "String",
  "scheduleInfo": {
    "@odata.type": "microsoft.graph.requestSchedule"
  },
  "ticketInfo": {
    "@odata.type": "microsoft.graph.ticketInfo"
  }
}
```

### Request model for PIM for Microsoft Entra roles

In the request model for PIM for Microsoft Entra roles, PIM sends a `unifiedRoleAssignmentScheduleRequest` object. For the full schema, see [Create roleAssignmentScheduleRequests](/graph/api/rbacapplication-post-roleassignmentschedulerequests).

```json
{
  "@odata.type": "#microsoft.graph.unifiedRoleAssignmentScheduleRequest",
  "id": "String (identifier)",
  "status": "String",
  "action": "String",
  "principalId": "String",
  "roleDefinitionId": "String",
  "directoryScopeId": "String",
  "justification": "String",
  "scheduleInfo": {
    "@odata.type": "microsoft.graph.requestSchedule"
  },
  "ticketInfo": {
    "@odata.type": "microsoft.graph.ticketInfo"
  }
}
```

### Request model for PIM for Azure resources

In the request model for PIM for Azure resources, PIM sends a role assignment schedule request object. For the full schema, see [Role Assignment Schedule Requests - Create](/rest/api/authorization/role-assignment-schedule-requests/create).

```json
{
  "properties": {
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "principalType": "User",
    "requestType": "SelfActivate",
    "roleDefinitionId": "/subscriptions/{subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/{roleDefinitionId}",
    "scope": "/subscriptions/{subscriptionId}",
    "justification": "String",
    "scheduleInfo": {
      "startDateTime": "2020-09-09T21:35:27.91Z",
      "expiration": {
        "type": "AfterDuration",
        "duration": "PT8H"
      }
    },
    "ticketInfo": {
      "ticketNumber": "String",
      "ticketSystem": "String"
    }
  }
}
```

### Response model

After your custom extension evaluates the activation request, it must return a response to PIM that includes the evaluation result and supporting details.

| Field | Type | Description |
|---|---|---|
| `evaluationId` | String | A unique identifier generated by the custom extension for the evaluation. This value is logged in PIM audits for traceability. |
| `evaluationOutcome` | String | The result of the evaluation. A preapproval extension supports `Approved`, `AutoApproved`, and `Denied`. A postapproval extension supports `approved`, `denied`, and `deferred`. |
| `reason` | List\<String\> | Messages that explain the evaluation outcome. These messages appear in the UI when a request is denied. |

The following examples show valid response payloads for each outcome:

**Approved**: All validation checks passed, and the activation proceeds through normal PIM workflow:

```json
{
  "evaluationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "evaluationOutcome": "Approved",
  "reason": ["Valid request"]
}
```

**AutoApproved**: The request meets criteria for automatic approval, and the activation continues without requiring manual PIM approval:

```json
{
  "evaluationId": "bbbb1111-cc22-3333-44dd-555555eeeeee",
  "evaluationOutcome": "AutoApproved",
  "reason": ["High severity incident for on-call engineer, bypass manual approval"]
}
```

**Denied**: One or more validation checks failed, and PIM blocks the activation:

```json
{
  "evaluationId": "cccc2222-dd33-4444-55ee-666666ffffff",
  "evaluationOutcome": "Denied",
  "reason": ["Requestor has not cleared Cloud Screening"]
}
```

**Deferred**: A postapproval extension needs more time to make a decision. PIM pauses the request until the extension calls `/updateRequest`:

```json
{
  "evaluationId": "dddd3333-ee44-5555-66ff-777777aaaaaa",
  "evaluationOutcome": "deferred",
  "reason": ["Waiting for the change advisory board decision"]
}
```

## Step 2 - Secure your custom extension service with Microsoft Entra ID

Secure communication between PIM and your custom extension REST API by registering a Microsoft Entra ID application and configuring token validation.

### Step 2.A - Register a Microsoft Entra ID application for your custom extension service

Your custom extension service must be backed by a Microsoft Entra ID application. PIM uses this app registration to authenticate to your custom extension endpoint and to request an access token for the API. To register a Microsoft Entra ID application, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer). 
1. Go to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a descriptive application name, for example, `Contoso PIM Custom Extension API`.
1. For **Supported account types**, select **Accounts in this organizational directory only**.
1. A redirect URI isn't required for this service-to-service registration.
1. Select **Register**.

#### Configure the Application ID URI

After the app is created, configure an Application ID URI. The host name in the Application ID URI must match the host name of your custom extension endpoint URL.

1. Open the app registration and go to **Expose an API**.
1. Select **Set** next to **Application ID URI**.
1. Enter a value that represents your API. The URI must end with the Application (client) ID of the app registration. For example, if your custom extension endpoint is `https://api.contoso.com/webhooks/entra-role-assignments` and the Application (client) ID is `00001111-aaaa-2222-bbbb-3333cccc4444`, set the Application ID URI to: `api://api.contoso.com/00001111-aaaa-2222-bbbb-3333cccc4444`

1. Select **Save**.
    :::image type="content" source="media/privileged-identity-management-custom-extensions/app-registration-api.png" alt-text="Screenshot of the app registration that protects the PIM custom extension API." lightbox="media/privileged-identity-management-custom-extensions/app-registration-api.png":::

Save the Application ID URI. You provide this value as the `resourceId` when you configure the custom extension in PIM.

### Step 2.B - Verify that requests to your custom extension come from PIM

When PIM calls your custom extension REST API, it sends an HTTP Authorization header with a bearer token issued by Microsoft Entra ID. Implement the following token validation checks in your API:

- **Calling application claim** - Validate that the `appid` claim (for V1 tokens) or `azp` claim (for V2 tokens) contains the value `00001111-aaaa-2222-bbbb-3333cccc4444`. This value identifies Microsoft Entra Privileged Identity Management as the caller.
- **Audience claim** -  Validate that the `aud` claim contains the Application ID URI you configured for your app registration.
- **Issuer claim** - Validate that the `iss` claim contains the Microsoft Entra issuer URL for your tenant: `https://login.microsoftonline.com/{tenantId}/v2.0`.

## Step 3 - Onboard a custom extension to PIM

Create a custom extension in your tenant so that PIM can call your endpoint during role activation requests. When you create the extension, you define the endpoint PIM calls, the Microsoft Entra ID resource used to secure that endpoint, and the PIM resource type the extension applies to.

### Delegated Microsoft Graph permissions required

Use `PrivilegedAccess-CustomExt.ReadWrite.All` to create or update custom extensions. Use `PrivilegedAccess-CustomExt.Read.All` to read or list custom extensions.

### Create a custom extension by using Microsoft Graph

Send a POST request to the Microsoft Graph API `beta` endpoint to create the custom extension:

```http
POST https://graph.microsoft.com/beta/identityGovernance/privilegedAccess/customExtensions
Content-Type: application/json
```

The following example creates a custom extension for PIM for Groups:

```json
{
  "@odata.type": "#microsoft.graph.roleManagementCustomCalloutExtension",
  "displayName": "Role Assignment Ticket Validation",
  "description": "Validates ticket info provided by requestor against ServiceNow",
  "type": "postApproval",
  "endpointConfiguration": {
    "@odata.type": "#microsoft.graph.httpRequestEndpoint",
    "targetUrl": "https://api.contoso.com/webhooks/entra-role-assignments"
  },
  "clientConfiguration": {
    "@odata.type": "#microsoft.graph.customExtensionClientConfiguration",
    "timeoutInMilliseconds": 10000,
    "maximumRetries": 3
  },
  "authenticationConfiguration": {
    "@odata.type": "#microsoft.graph.azureAdTokenAuthentication",
    "resourceId": "api://api.contoso.com/a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1"
  },
  "resourceType": "entraGroups",
  "customAttributes": [
    "costCenter",
    "projectCode"
  ]
}
```

> [!NOTE]
> For resource ID in that code snippet, enter in your own ID to be used.

The following table describes the key fields in the custom extension API model:

| Field | Type | Description |
|---|---|---|
| `id` | String | Unique identifier assigned to the custom extension. |
| `displayName` | String | Friendly name shown for the custom extension in management experiences. |
| `description` | String | Description of what the custom extension does. |
| `type` | String | Stage when PIM calls the extension. Valid values are `preApproval` and `postApproval`. |
| `endpointConfiguration` | Object | Configuration for the HTTP endpoint that PIM calls. |
| `endpointConfiguration.@odata.type` | String | Endpoint configuration type. Use `#microsoft.graph.httpRequestEndpoint`. |
| `endpointConfiguration.targetUrl` | String | HTTPS endpoint that receives the custom extension call. |
| `clientConfiguration` | Object | Timeout and retry configuration for calls to the endpoint. |
| `clientConfiguration.@odata.type` | String | Client configuration type. Use `#microsoft.graph.customExtensionClientConfiguration`. |
| `clientConfiguration.timeoutInMilliseconds` | Integer | Maximum time PIM waits for the endpoint to respond. |
| `clientConfiguration.maximumRetries` | Integer | Maximum number of retry attempts if the call fails. |
| `authenticationConfiguration` | Object | Microsoft Entra authentication configuration for the endpoint. |
| `authenticationConfiguration.@odata.type` | String | Authentication configuration type. Use `#microsoft.graph.azureAdTokenAuthentication`. |
| `authenticationConfiguration.resourceId` | String | Application ID URI of the Microsoft Entra app that secures the endpoint. |
| `resourceType` | String | Identifies the PIM provider the extension applies to. |
| `customAttributes` | String collection | Optional attribute names that collect extra information during role activation and include it in the extension request. |

A successful response returns an HTTP `201 Created` status code with the created custom extension object.

### UI walkthrough

You can also create a custom extension by using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. Go to **Identity governance** > **Privileged Identity Management** > **Custom Extensions**.
1. Select **Create a custom extension**.
1. On the **Basics** tab, enter a name and description, and select the resource type.
1. Select **Pre-approval** or **Post-approval** as the custom extension type. A postapproval extension runs after manual approval and immediately before PIM provisions the assignment.

    :::image type="content" source="media/privileged-identity-management-custom-extensions/create-extension-basics.png" alt-text="Screenshot of the Basics tab for a new PIM custom extension, including preapproval and postapproval extension types." lightbox="media/privileged-identity-management-custom-extensions/create-extension-basics.png":::

1. On the **Endpoint configuration** tab, enter the target URL, timeout, and maximum retries for your custom extension endpoint.

    :::image type="content" source="media/privileged-identity-management-custom-extensions/create-extension-endpoint.png" alt-text="Screenshot of the endpoint configuration for a PIM custom extension." lightbox="media/privileged-identity-management-custom-extensions/create-extension-endpoint.png":::

1. On the **API authentication** tab, select the application registration that secures your custom extension endpoint.

    :::image type="content" source="media/privileged-identity-management-custom-extensions/create-extension-authentication.png" alt-text="Screenshot of the API authentication configuration for a PIM custom extension." lightbox="media/privileged-identity-management-custom-extensions/create-extension-authentication.png":::

1. On the **Custom attributes** tab, add the names of any extra attributes that users must provide during activation. For more information, see [Custom attributes](#custom-attributes).

    :::image type="content" source="media/privileged-identity-management-custom-extensions/create-extension-custom-attributes.png" alt-text="Screenshot of the custom attributes configuration for a PIM custom extension." lightbox="media/privileged-identity-management-custom-extensions/create-extension-custom-attributes.png":::

1. On the **Review + create** tab, review the configuration, and select **Create**.

    :::image type="content" source="media/privileged-identity-management-custom-extensions/create-extension-review.png" alt-text="Screenshot of the review page for a new PIM custom extension." lightbox="media/privileged-identity-management-custom-extensions/create-extension-review.png":::

After the custom extension is created, it appears in the **Custom Extensions** list.

:::image type="content" source="media/privileged-identity-management-custom-extensions/custom-extensions-list.png" alt-text="List of custom extensions available in Privileged Identity Management after creation.":::

## Step 4 - Link a custom extension to PIM role settings

After you onboard a custom extension, link it to the role settings for each role where you want PIM to call the extension during activation. To update role settings for a group, you need the Owner role for that group.

### Link to PIM for Groups role settings

To link a custom extension to a group role, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Go to **Identity governance** > **Privileged Identity Management**.
1. Select **Groups**.
1. Select the target group and open its role management experience.
1. Select **Settings** to view the available roles for the group.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/group-settings-roles.png" alt-text="Screenshot of the group role settings." lightbox="media/privileged-identity-management-custom-extensions/group-settings-roles.png":::

1. Select the role you want to configure, such as **Owner** or **Member**, and open the role settings.
1. Select **Edit**.
1. Select **Require pre-approval custom extension to activate** or **Require post-approval custom extension to activate**.
1. Select the custom extension you want to link to this role.
1. To call the extension and record the result without enforcing a denial or call failure, enable **Audit mode**.

    :::image type="content" source="media/privileged-identity-management-custom-extensions/configure-role-extension.png" alt-text="Screenshot of group role settings with a preapproval custom extension selected." lightbox="media/privileged-identity-management-custom-extensions/configure-role-extension.png":::
1. Select **Save** to apply the updated role settings.

After you save, the role setting details page confirms the custom extension is linked.

:::image type="content" source="media/privileged-identity-management-custom-extensions/role-setting-details-custom-extension.png" alt-text="Screenshot of the role setting details in custom extension." lightbox="media/privileged-identity-management-custom-extensions/role-setting-details-custom-extension.png":::

You can follow a similar process to link custom extensions to Azure resource roles and Microsoft Entra directory roles.

## Step 5 - Verify the role activation flow

After you complete the configuration, verify that the custom extension works as expected by activating a role and confirming that PIM sends the request to your API and enforces the decision.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a user who is eligible for the role.
1. Go to **Privileged Identity Management** and activate the role that has the custom extension configured.
1. Provide the required justification, ticket information, and custom attributes.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/activate-role-with-ticket-info.png" alt-text="Screenshot of activating a role with ticket information and custom attributes." lightbox="media/privileged-identity-management-custom-extensions/activate-role-with-ticket-info.png":::

1. Submit the activation request.
1. Verify that your API endpoint receives the POST request from PIM.
1. Confirm that PIM enforces the decision returned by your custom extension:
    - **Approved**: The activation proceeds through the normal PIM workflow, including any other approval steps.
    - **AutoApproved**: The activation proceeds without requiring manual PIM approval.
    - **Denied**: The activation is blocked, and the reason messages from your API response appear in the PIM UI.

   The following example shows an activation denied by a custom extension that validated ticket information:

   :::image type="content" source="media/privileged-identity-management-custom-extensions/extension-denied-activation.png" alt-text="Screenshot of a PIM activation denied because the custom extension rejected the ticket number." lightbox="media/privileged-identity-management-custom-extensions/extension-denied-activation.png":::

## Preapproval and postapproval extensions

Preapproval and postapproval extensions are blocking gates, but they run at different points in the activation workflow.

| Capability | `preApproval` | `postApproval` |
| --- | --- | --- |
| Execution point | Before manual approval | After manual approval and immediately before assignment provisioning |
| Supported outcomes | `Approved`, `Denied`, `AutoApproved` | `approved`, `denied`, `deferred` |
| Skip manual approval | Yes, with `AutoApproved` | No, because manual approval is already complete |
| Deferred evaluation | No | Yes, through `/updateRequest` |
| Blocks | Manual approval and provisioning | Assignment provisioning |
| Common scenarios | Compliance prescreening, risk assessment, early denial, and conditional automatic approval | IT service management validation, security scanning, external approval, and asynchronous processing |

Use a preapproval extension to evaluate a request before a PIM approver sees it. Use a postapproval extension when custom logic must run after the built-in PIM approval stage but before PIM provisions the assignment.

> [!NOTE]
> A postapproval extension doesn't run after role activation. It runs after manual approval, but before the role assignment is provisioned.

### When to use each extension type

Use a preapproval extension to:

- Perform compliance or risk checks before a human approver sees the request.
- Auto-approve low-risk requests that meet defined criteria.
- Deny requests early based on external data.
- Reduce approver workload by filtering clearly valid or invalid requests.

Use a postapproval extension to:

- Run another custom approval workflow after PIM approval.
- Validate an IT service management ticket before provisioning access.
- Perform a security scan or another long-running process.
- Defer the decision and call PIM later with the final outcome.

### Complete a deferred postapproval evaluation

A postapproval extension can return `deferred` when it needs more time to make a decision. PIM places the request in `PostApprovalExtensionPendingEvaluation` and doesn't provision the role assignment. After the asynchronous process finishes, the extension calls `/updateRequest` on the original activation request with a final `approved` or `denied` decision.

The extension must authenticate to the callback API by using the same Microsoft Entra app registration configured for the extension. PIM verifies that the calling application ID matches the registered application. The callback can't return `deferred` again.

The deferred flow works as follows:

1. PIM calls the postapproval extension after manual approval.
1. The extension returns `deferred` because it needs more time.
1. PIM moves the request to `PostApprovalExtensionPendingEvaluation`.
1. The extension completes its asynchronous validation or approval process.
1. The extension calls the provider-specific `/updateRequest` endpoint with `approved` or `denied`.
1. PIM validates the callback and either provisions or denies the assignment.

#### Microsoft Entra roles

Use:

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignmentScheduleRequests/{requestId}/updateRequest
Content-Type: application/json
```

```json
{
  "evaluationOutcome": "approved",
  "evaluationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "reason": "The external compliance system approved the request."
}
```

#### PIM for Groups

Use:

```http
POST https://graph.microsoft.com/beta/identityGovernance/privilegedAccess/group/assignmentScheduleRequests/{requestId}/updateRequest
Content-Type: application/json
```

```json
{
  "evaluationOutcome": "denied",
  "evaluationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "reason": "The external compliance system denied the request."
}
```

#### Azure resources

Use:

```http
POST https://management.azure.com/{scope}/providers/Microsoft.Authorization/roleAssignmentScheduleRequests/{requestId}/updateRequest?api-version=2020-10-01
Content-Type: application/json
```

```json
{
  "evaluationOutcome": "denied",
  "evaluationId": "aaaa0000-bb11-2222-33cc-444444dddddd",
  "reason": [
    "The change advisory board rejected ticket CHANGE-9921."
  ]
}
```

#### Callback endpoint summary

| Provider | Endpoint |
|---|---|
| Microsoft Entra roles | `POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignmentScheduleRequests/{requestId}/updateRequest` |
| PIM for Groups | `POST https://graph.microsoft.com/beta/identityGovernance/privilegedAccess/group/assignmentScheduleRequests/{requestId}/updateRequest` |
| Azure resources | `POST https://management.azure.com/{scope}/providers/Microsoft.Authorization/roleAssignmentScheduleRequests/{requestId}/updateRequest?api-version=2020-10-01` |

The callback request body supports the following properties:

| Property | Required | Description |
|---|---|---|
| `evaluationOutcome` | Yes | Final outcome. Use `approved` or `denied`; a callback can't return `deferred`. |
| `evaluationId` | Yes | Correlation identifier from the original extension response. |
| `reason` | No | Human-readable reason for the decision. Azure Resource Manager accepts a string collection; Microsoft Graph accepts a string. |
| `scheduleInfo` | No | Microsoft Graph only. Optional updated activation schedule for an approved request. |

Handle callback failures based on the returned HTTP status:

| HTTP status | Cause |
|---|---|
| `400 Bad Request` | The request isn't waiting for a callback, or the callback outcome isn't `approved` or `denied`. |
| `401 Unauthorized` | The calling application doesn't match the app registered for the custom extension. |
| `404 Not Found` | The request ID doesn't exist. |

## Custom attributes

Custom attributes collect extra key-value context during activation and include it in the extension request. Use custom attributes when your extension needs information that isn't part of the standard request, such as a cost center, project code, business justification category, or identifier in an external system.

Add the attribute names when you create the extension. During activation, the user enters the corresponding values. PIM sends the values in a provider-specific format.

### Azure resources

For Azure resource roles, PIM sends a `customAttributes` array:

```json
{
  "customAttributes": [
    {
      "attributeName": "costCenter",
      "attributeValue": "CC-4521"
    },
    {
      "attributeName": "projectCode",
      "attributeValue": "PROJ-ALPHA"
    }
  ]
}
```

### Microsoft Entra roles

For Microsoft Entra roles, PIM sends a JSON-encoded `customData` string:

```json
{
  "customData": "{\"costCenter\":\"CC-4521\",\"projectCode\":\"PROJ-ALPHA\"}"
}
```

### PIM for Groups

For PIM for Groups, PIM also sends a JSON-encoded `customData` string:

```json
{
  "customData": "{\"costCenter\":\"CC-4521\",\"approverGroup\":\"finance-approvers\"}"
}
```

| Provider | Field | Format |
|---|---|---|
| Azure resources | `customAttributes` | Array of `attributeName` and `attributeValue` objects. |
| Microsoft Entra roles | `customData` | JSON-encoded string. |
| PIM for Groups | `customData` | JSON-encoded string. |

Validate custom-attribute names and values in your API before using them in a query, workflow, or access decision.

## Quick reference

### Extension type decision matrix

| Scenario | `preApproval` | `postApproval` |
|---|---|---|
| Compliance check before approvers | Best fit | Not applicable |
| Auto-approve low-risk requests | Best fit | Not supported |
| Block based on external data | Supported | Supported |
| Custom approval after PIM approval | Not applicable | Best fit |
| Asynchronous processing with callback | Not supported | Best fit |
| Security scan before provisioning | Not applicable | Best fit |

### Evaluation outcome quick reference

| Outcome | `preApproval` effect | `postApproval` effect | Callback effect |
|---|---|---|---|
| `Approved` / `approved` | Continues to manual approval. | Continues to provisioning. | Resolves a deferred request and provisions the role. |
| `Denied` / `denied` | Denies the request. | Denies the request. | Resolves a deferred request and denies it. |
| `deferred` | Not supported. | Pauses and waits for `/updateRequest`. | Not supported; a callback can't defer again. |
| `AutoApproved` | Skips manual approval. | Not supported. | Not supported. |

### Postapproval request status transitions

The following table shows how the request status transitions based on the postapproval evaluation outcome and the callback decision:

| Stage | Outcome | New status | Next step |
|---|---|---|---|
| Postapproval extension | `approved` | Granted | PIM provisions the assignment. |
| Postapproval extension | `denied` | Denied | The request ends. |
| Postapproval extension | `deferred` | `PostApprovalExtensionPendingEvaluation` | PIM waits for `/updateRequest`. |
| Callback | `approved` | `PostApprovalExtensionAdminApproved` | PIM provisions the assignment. |
| Callback | `denied` | `PostApprovalExtensionAdminDenied` | The request ends. |

## Related content

- [What is Microsoft Entra Privileged Identity Management?](pim-configure.md)
- [Configure PIM for Groups settings](groups-role-settings.md)
- [Configure Microsoft Entra role settings in PIM](pim-how-to-change-default-settings.md)

---
title: Configure custom extensions for PIM role activation (Preview)
description: Learn how to configure custom extensions in Microsoft Entra Privileged Identity Management (PIM) to integrate custom business logic into role activation workflows.
ms.topic: how-to
ms.date: 06/02/2026
author: owinfreyATL
ms.author: owinfrey
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

Custom extensions support PIM for Groups, PIM for Microsoft Entra roles, and PIM for Azure resources.

:::image type="content" source="media/privileged-identity-management-custom-extensions/custom-extension-architecture-flow.png" alt-text="Diagram that shows the PIM custom extension architecture flow from activation request through policy evaluation to the custom extension API and external services." lightbox="media/privileged-identity-management-custom-extensions/custom-extension-architecture-flow.png":::

> [!IMPORTANT]
> Custom extensions for PIM are in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

## License Requirements

Using Custom Extensions with PIM requires an active Microsoft Entra ID Governance (EIG) or Entra Suite license. For more information on licensing, see: [Microsoft Entra ID Governance licensing fundamentals](~/id-governance/licensing-fundamentals.md).

## Prerequisites

-  An assignment of at least the **Privileged Role Administrator** role.
- A REST API endpoint that accepts HTTP POST requests and returns evaluation responses in the format PIM expects. The API can be built in any language and hosted on any platform.
- A Microsoft Entra ID application registration to secure communication between PIM and your custom extension endpoint.
- The Microsoft Graph API `beta` endpoint is required because this feature is in preview.
- The following delegated Microsoft Graph permissions, depending on the operation:

  | Operation | Permission (least privileged) |
  |---|---|
  | Create or update a custom extension | `PrivilegedAccess-CustomExt.ReadWrite.All` |
  | Get or list custom extensions | `PrivilegedAccess-CustomExt.Read.All` |

## Build your custom extension endpoint

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
| `evaluationOutcome` | String | The result of the evaluation. Supported values: `Approved`, `AutoApproved`, `Denied`. |
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

## Secure your custom extension service

Secure communication between PIM and your custom extension REST API by registering a Microsoft Entra ID application and configuring token validation.

### Register a Microsoft Entra ID application

Your custom extension service must be backed by a Microsoft Entra ID application. PIM uses this app registration to authenticate to your custom extension endpoint and to request an access token for the API. To register a Microsoft Entra ID application, do the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer). 
1. Go to **Identity** > **Applications** > **App registrations**.
1. Select **New registration**.
1. Enter a descriptive application name, for example, `Contoso PIM Custom Extension API`.
1. For **Supported account types**, select **Accounts in this organizational directory only**.
1. A redirect URI isn't required for this service-to-service registration.
1. Select **Register**.

### Configure the Application ID URI

After the app is created, configure an Application ID URI. The host name in the Application ID URI must match the host name of your custom extension endpoint URL.

1. Open the app registration and go to **Expose an API**.
1. Select **Set** next to **Application ID URI**.
1. Enter a value that represents your API. The URI must end with the Application (client) ID of the app registration. For example, if your custom extension endpoint is `https://api.contoso.com/webhooks/entra-role-assignments` and the Application (client) ID is `00001111-aaaa-2222-bbbb-3333cccc4444`, set the Application ID URI to: `api://api.contoso.com/00001111-aaaa-2222-bbbb-3333cccc4444`

1. Select **Save**.
    :::image type="content" source="media/privileged-identity-management-custom-extensions/app-registration-expose-api.png" alt-text="Screenshot of the app registration to expose API page." lightbox="media/privileged-identity-management-custom-extensions/app-registration-expose-api.png":::

Save the Application ID URI. You provide this value as the `resourceId` when you configure the custom extension in PIM.

### Validate bearer tokens in your API

When PIM calls your custom extension REST API, it sends an HTTP Authorization header with a bearer token issued by Microsoft Entra ID. Implement the following token validation checks in your API:

- **Calling application claim** - Validate that the `appid` claim (for V1 tokens) or `azp` claim (for V2 tokens) contains the value `1c67c054-65c8-4f7f-92a1-eb7ba6e48627`. This value identifies Microsoft Entra Privileged Identity Management as the caller.
- **Audience claim** -  Validate that the `aud` claim contains the Application ID URI you configured for your app registration.
- **Issuer claim** - Validate that the `iss` claim contains the Microsoft Entra issuer URL for your tenant: `https://login.microsoftonline.com/{tenantId}/v2.0`.

## Onboard a custom extension to PIM

Create a custom extension in your tenant so that PIM can call your endpoint during role activation requests. When you create the extension, you define the endpoint PIM calls, the Microsoft Entra ID resource used to secure that endpoint, and the PIM resource type the extension applies to.

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
    "resourceId": "api://api.contoso.com/00001111-aaaa-2222-bbbb-3333cccc4444"
  },
  "resourceType": "entraGroups",
  "customAttributes": []
}
```

> [!NOTE]
> For resource ID in that code snippet, enter in your own ID to be used.

The following table describes the key fields in the custom extension API model:

| Field | Type | Description |
|---|---|---|
| `displayName` | String | Friendly name shown for the custom extension in management experiences. |
| `description` | String | Description of what the custom extension does. |
| `endpointConfiguration.targetUrl` | String | HTTPS endpoint that receives the custom extension call. |
| `clientConfiguration.timeoutInMilliseconds` | Integer | Maximum time PIM waits for the endpoint to respond. |
| `clientConfiguration.maximumRetries` | Integer | Maximum number of retry attempts if the call fails. |
| `authenticationConfiguration.resourceId` | String | Application ID URI of the Microsoft Entra app that secures the endpoint. |
| `resourceType` | String | Identifies the PIM provider the extension applies to. |

A successful response returns an HTTP `201 Created` status code with the created custom extension object.

### Create a custom extension in the portal

You can also create a custom extension by using the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. Go to **Identity governance** > **Privileged Identity Management** > **Custom Extensions**.
1. Select **Create a custom extension**.
1. On the **Basics** tab, enter a name, description, and resource type for the custom extension.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/create-custom-extension-basics.png" alt-text="Screenshot of the basics of creating custom extension." lightbox="media/privileged-identity-management-custom-extensions/create-custom-extension-basics.png":::

1. On the **Endpoint configuration** tab, enter the target URL, timeout, and maximum retries for your custom extension endpoint.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/create-custom-extension-endpoint-configuration.png" alt-text="Screenshot of the create custom extension endpoint configuration." lightbox="media/privileged-identity-management-custom-extensions/create-custom-extension-endpoint-configuration.png":::

1. On the **API authentication** tab, select the application registration that secures your custom extension endpoint.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/create-custom-extension-api-authentication.png" alt-text="Screenshot of creating custom extension API authentication.":::

1. On the **Review + create** tab, review the configuration, and select **Create**.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/create-custom-extension-review-create.png" alt-text="Screenshot of the Review and create tab showing a summary of the custom extension configuration including basics, endpoint, and API authentication details.":::

After the custom extension is created, it appears in the **Custom Extensions** list.

:::image type="content" source="media/privileged-identity-management-custom-extensions/custom-extensions-list.png" alt-text="List of custom extensions available in Privileged Identity Management after creation.":::

## Link a custom extension to PIM role settings

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
1. Select the checkbox for **Require pre-approval custom extension to activate**.
1. Select the custom extension you want to link to this role.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/edit-role-setting-select-custom-extension.png" alt-text="Screenshot of setting the role settings when selecting the custom extension." lightbox="media/privileged-identity-management-custom-extensions/edit-role-setting-select-custom-extension.png":::
1. Select **Save** to apply the updated role settings.

After you save, the role setting details page confirms the custom extension is linked.

:::image type="content" source="media/privileged-identity-management-custom-extensions/role-setting-details-custom-extension.png" alt-text="Screenshot of the role setting details in custom extension." lightbox="media/privileged-identity-management-custom-extensions/role-setting-details-custom-extension.png":::

You can follow a similar process to link custom extensions to Azure resource roles and Microsoft Entra directory roles.

## Verify the role activation flow

After you complete the configuration, verify that the custom extension works as expected by activating a role and confirming that PIM sends the request to your API and enforces the decision.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a user who is eligible for the role.
1. Go to **Privileged Identity Management** and activate the role that has the custom extension configured.
1. Provide the required justification and ticket information.

   :::image type="content" source="media/privileged-identity-management-custom-extensions/activate-role-with-ticket-info.png" alt-text="Screenshot of activating a role with ticket information." lightbox="media/privileged-identity-management-custom-extensions/activate-role-with-ticket-info.png":::

1. Submit the activation request.
1. Verify that your API endpoint receives the POST request from PIM.
1. Confirm that PIM enforces the decision returned by your custom extension:
   - **Approved**: The activation proceeds through the normal PIM workflow, including any other approval steps.
   - **AutoApproved**: The activation proceeds without requiring manual PIM approval.
   - **Denied**: The activation is blocked, and the reason messages from your API response appear in the PIM UI.

   The following example shows an activation denied by a custom extension that validated ticket information:

   :::image type="content" source="media/privileged-identity-management-custom-extensions/activation-denied-custom-extension.png" alt-text="Screenshot of the activation denied with custom extension.":::

## Related content

- [What is Microsoft Entra Privileged Identity Management?](pim-configure.md)
- [Configure PIM for Groups settings](groups-role-settings.md)
- [Configure Microsoft Entra role settings in PIM](pim-how-to-change-default-settings.md)

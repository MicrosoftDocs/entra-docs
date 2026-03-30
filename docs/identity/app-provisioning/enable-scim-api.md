---
title: Enable the SCIM Provisioning API in Microsoft Entra ID
description: Learn how to enable the SCIM Provisioning API feature in the Microsoft Entra admin center and link an Azure subscription for billing.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: how-to
ms.date: 03/23/2026
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted

#customer intent: As an IT administrator, I want to enable the SCIM Provisioning API in Microsoft Entra ID so that I can use SCIM 2.0 to programmatically manage users and groups in my tenant.
---

# Enable the SCIM Provisioning API in Microsoft Entra ID

This article describes how to enable the SCIM Provisioning API feature in the Microsoft Entra admin center. Once enabled, you can use the SCIM 2.0 protocol to automate the management of users and groups in your Microsoft Entra ID tenant.

> [!NOTE]
> By enabling this feature, Microsoft Entra ID acts as the SCIM service provider (server), allowing external SCIM‑compatible clients—such as HR apps, identity platforms, orchestration tools, or custom automation frameworks—to provision and manage users and groups in Entra using standard SCIM operations at scale. This feature is intended for direct programmatic access to the SCIM API; if you want to use Entra ID's built-in [app provisioning](user-provisioning.md), [HR-driven provisioning](what-is-hr-driven-provisioning.md) or [API-driven provisioning](inbound-provisioning-api-concepts.md) capabilities, you don't need to enable it. For more details refer to [SCIM support in Entra ID](scim-support-in-entra-id.md).

For the full API reference, see [Microsoft Entra ID SCIM API reference](entra-id-scim-api-reference.md).

## Prerequisites

- An Entra ID P1 license or any license that contains Entra ID P1 (e.g., Entra ID P2, M365 E3, M365 E5, etc)
- An active Azure subscription to link for billing.
- An admin with the [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) role to create an app registration with the permissions required to invoke the SCIM API.
- An admin with the [Billing Administrator](/entra/identity/role-based-access-control/permissions-reference#billing-administrator) role to enable SCIM API billing and link the Azure subscription.

## License and billing

The SCIM Provisioning API is a paid add-on that requires a subscription and billing configuration:

- **Cost:** USD $0.002 per API call.
- **Billing:** Monthly, through a linked Azure subscription.

## Enable the SCIM Provisioning API

Use the following steps to turn on the SCIM Provisioning API from the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. In the left navigation, expand **ID Governance** and select **Dashboard**.

1. On the Dashboard page, locate the **SCIM Provisioning API** tile and select **Get Started**. If the feature was previously configured, the tile shows the current status and an **Edit** button instead.

1. In the **SCIM Provisioning API** pane that opens on the right side:

   1. Under **Link subscription**, select an **Azure subscription** from the dropdown.

   1. Select an existing **Resource group** or select **Create new** to create one.

   1. Review the **Billing Unit** details. Every SCIM Provisioning API call is billed.

   1. Select **Turn on**.

1. After the feature is enabled, the SCIM Provisioning API tile on the Dashboard updates to show **SCIM Provisioning API is enabled**.

## Set up credentials for the SCIM API client

After you enable the SCIM Provisioning API, set up the credentials that your SCIM client uses to authenticate. You can choose one of the following options.

> [!NOTE]
> SCIM APIs operate exclusively in application context (app-only token) and do not support delegated, user-on-behalf-of scenarios. As a result, properties that require delegated authorization, such as `assignedLabels`, cannot be updated via SCIM.

### Option 1: Register an application (client credentials flow)

Register an application in your Microsoft Entra tenant, grant the required application permissions, and use the [OAuth 2.0 client credentials grant flow](/entra/identity-platform/v2-oauth2-client-creds-grant-flow) to obtain an access token.

1. [Register an application with the Microsoft identity platform](/graph/auth-register-app-v2). Save the following values from the app registration:
   - The application ID (referred to as Object ID on the Microsoft Entra admin center).
   - A client secret (application password), a certificate, or a federated identity credential.

1. Under **API permissions**, select **Microsoft Graph** > **Application permissions** and grant one or more of the following permissions depending on how you plan to use the SCIM APIs:

   | Permission | Description |
   |---|---|
   | `User.Read.All` | Read-only access to users. |
   | `User.ReadWrite.All` | Read and write access to users. |
   | `User-Mail.ReadWrite.All` | Least privileged permission to update **emails[type eq "other"].value** that maps to *otherMails* user property |
   | `User-Phone.ReadWrite.All` | Least privileged permission to update **phoneNumbers[type eq "mobile"].value** and **phoneNumbers[type eq "work"].value** that map to *mobilePhone* and *businessPhones* user properties respectively |
   | `User.EnableDisableAccount.All` | Least privileged permission to update **active** SCIM attribute that maps to *accountEnabled* user property |
   | `Group.Read.All` | Read-only access to groups. |
   | `Group.ReadWrite.All` | Read and write access to groups. |
   | `CustomSecAttributeAssignment.Read.All` | Read-only access to Custom Security Attributes on users. |
   | `CustomSecAttributeAssignment.ReadWrite.All` | Read and write access to Custom Security Attributes on users. |
   | `CustomSecAttributeDefinition.Read.All` | Read access to Custom Security Attributes schema. |
   | `User-LifeCycleInfo.ReadWrite.All` | Update lifecycle attributes like `employeeLeaveDateTime`. |

1. Grant **Admin consent** for all assigned permissions.

1. Use the following HTTP request to obtain an access token, replacing the placeholder values to match your environment. For production usage, it's highly recommended to use client certificate or managed identity for authentication.

   **Request:**

   ```http
   POST https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token HTTP/1.1
   Host: login.microsoftonline.com
   Content-Type: application/x-www-form-urlencoded

   client_id={client_id}&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret={client_secret}&grant_type=client_credentials
   ```

   **Response (200 OK):**

   ```json
   {
     "token_type": "Bearer",
     "expires_in": 3599,
     "access_token": "eyJhbGciOiJIUzI1NiJ9…"
   }
   ```

1. Include the access token in the `Authorization` header (Bearer scheme) when calling the SCIM API.

### Option 2: Use a managed identity

Assign a [managed identity](/entra/identity/managed-identities-azure-resources/overview) (system-assigned or user-assigned) to the Azure resource that hosts your SCIM client, and grant it the same Microsoft Graph application permissions listed in Option 1.

1. Enable a managed identity on your Azure resource (for example, a virtual machine or Azure Function).

1. Grant the managed identity the required Microsoft Graph application permissions listed in the table in [Option 1](#option-1-register-an-application-client-credentials-flow).

1. At runtime, acquire an access token from the managed identity endpoint and include it in the `Authorization` header when calling the SCIM API.

For more information on acquiring tokens with a managed identity, see [How to use managed identities for Azure resources on an Azure VM to acquire an access token](/entra/identity/managed-identities-azure-resources/how-to-use-vm-token).

## Invoke SCIM API endpoints

After you set up credentials and obtain an access token, you can start calling SCIM API endpoints. The following example retrieves the service provider configuration for the Microsoft Entra ID SCIM implementation.

**Request:**

```http
GET https://graph.microsoft.com/rp/scim/serviceproviderconfig HTTP/1.1
Authorization: Bearer <access_token>
Accept: application/json
Host: graph.microsoft.com
```

**Response (200 OK):**

```json
{
  "schemas": ["urn:ietf:params:scim:schemas:core:2.0:ServiceProviderConfig"],
  "documentationUri": "/graph/overview",
  "pagination": {
    "cursor": true,
    "index": false,
    "defaultPaginationMethod": "cursor",
    "defaultPageSize": 100,
    "maxPageSize": 1000
  },
  "patch": {
    "supported": true
  },
  "bulk": {
    "supported": false,
    "maxOperations": 0,
    "maxPayloadSize": 0
  },
  "filter": {
    "supported": true,
    "maxResults": 200
  }
}
```

For the full list of supported SCIM operations including user and group management, see the [Microsoft Entra ID SCIM API reference](entra-id-scim-api-reference.md).

## View SCIM API billing information

SCIM API usage is billed through the Azure subscription and resource group you linked when you enabled the feature. You can view accumulated costs and usage forecasts in the Azure portal using the **Cost analysis** blade.

### Prerequisites for viewing billing

You must have one of the following Azure roles on the linked resource group to access Cost analysis:

- **Owner**
- **Contributor**
- **Reader**
- **Cost Management Reader**

### Steps to view billing

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the top search bar, search for **Resource groups** and select it.

1. From the list of resource groups, select the resource group you linked when enabling SCIM API billing.

1. In the left navigation pane, expand **Cost Management** and select **Cost analysis**.

1. In the Cost analysis view:

   - Set the **Scope** to your resource group.
   - Set the **View** to **AccumulatedCosts**.
   - Set the date range to the month you want to review.

1. The chart shows your accumulated SCIM API spend over the selected period. The summary cards at the top show:
   - **Actual cost (USD)** – charges billed so far in the current period.
   - **Forecast** – projected total cost for the period based on current usage.

1. Use the breakdown tiles at the bottom to view costs by **Service name**, **Location**, and **Resource**. SCIM API charges appear under **Microsoft Entra** as the service name.

## Disable the SCIM Provisioning API

If you no longer need programmatic SCIM access, you can turn off the SCIM Provisioning API to stop all API access and billing.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. In the left navigation, expand **ID Governance** and select **Dashboard**.

1. On the Dashboard page, locate the **SCIM Provisioning API** tile and select **Edit**.

1. In the **SCIM Provisioning API** pane, select **Turn off**.

1. Confirm the action when prompted. After the feature is turned off, all SCIM API calls to the tenant return an error and billing stops.

## Next steps

- [Microsoft Entra ID SCIM API reference](entra-id-scim-api-reference.md) – Learn about the supported SCIM API endpoints, request formats, and constraints.
- [Troubleshoot SCIM API errors](troubleshoot-scim-api-errors.md) – Resolve common errors encountered when calling the SCIM APIs.
---
title: "Configure a custom authentication extension for account recovery"
description: Learn how to configure a custom authentication extension for account recovery in Microsoft Entra ID. You can customize the account recovery experience using a REST API.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.date: 04/02/2026
ms.reviewer: stsoneff
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As a developer, I want to configure a custom authentication extension for account recovery, so that I can customize the recovery experience for users in my organization.
---

# Configure a custom authentication extension for account recovery

This article describes how to configure a custom authentication extension for an account recovery event. Using an existing Azure Functions REST API, you register a custom authentication extension that integrates with the account recovery flow in Microsoft Entra ID.

## Prerequisites

- An Azure subscription with the ability to create Azure Functions. If you don't have an existing Azure account, sign up for a [free trial](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) or use your [Visual Studio Subscription](https://visualstudio.microsoft.com/subscriptions/) benefits when you [create an account](https://account.windowsazure.com/Home/Index).
- A basic understanding of the concepts covered in [Custom authentication extensions overview](custom-extension-overview.md).
- A Microsoft Entra ID tenant with [account recovery](~/identity/authentication/concept-account-recovery-overview.md) enabled.

## Overview

Custom authentication extensions for account recovery allow you to integrate external logic into the account recovery flow. When a user initiates account recovery, the custom extension calls your REST API to perform additional validation or custom processing.

The account recovery custom authentication extension supports the following scenarios:

- **Custom verification** - Add extra identity verification steps during account recovery.
- **External system integration** - Notify or validate against external identity systems during recovery.
- **Custom recovery flows** - Implement organization-specific recovery logic.

## Step 1: Create an Azure Function

[!INCLUDE [portal-include](./includes/custom-extension-azure-function.md)]

Create an HTTP trigger function that handles the account recovery event. The function receives a JSON payload from Microsoft Entra ID with details about the recovery request and returns a response indicating whether to continue or block the recovery.

## Step 2: Register a custom authentication extension

# [Microsoft Entra admin center](#tab/entra-admin-center)

Register the custom authentication extension in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Custom authentication extensions**.
1. Select **Create a custom extension**.
1. In **Basics**, select the **Account recovery** event type and select **Next**.
1. In **Endpoint Configuration**, fill in the following properties:
    - **Name** - A name for your custom authentication extension. For example, *Account recovery extension*.
    - **Target URL** - The URL of your Azure Function.
    - **Description** - A description for your custom authentication extension.
1. Select **Next**.
1. In **API Authentication**, select **Create new app registration** to create an app registration that represents your Azure Function.
1. Give the app a name, for example *Account recovery extension API*.
1. Select **Next**.
1. Select **Create** to create the custom authentication extension and the associated app registration.

# [Microsoft Graph](#tab/microsoft-graph)

Register the custom authentication extension using Microsoft Graph.

```http
POST https://graph.microsoft.com/v1.0/identity/customAuthenticationExtensions
Content-type: application/json

{
    "@odata.type": "#microsoft.graph.onAccountRecoveryCustomExtension",
    "displayName": "Account recovery extension",
    "description": "Custom extension for account recovery flow",
    "authenticationConfiguration": {
        "@odata.type": "#microsoft.graph.azureAdTokenAuthentication",
        "resourceId": "api://{Azure Function app ID}"
    },
    "endpointConfiguration": {
        "@odata.type": "#microsoft.graph.httpRequestEndpoint",
        "targetUrl": "https://{your-azure-function}.azurewebsites.net/api/accountRecovery"
    }
}
```

---

## Step 3: Configure the application

Configure the application registration for the custom authentication extension to allow it to call your Azure Function.

1. In the Microsoft Entra admin center, browse to **Identity** > **Applications** > **App registrations** and select the app registration created in the previous step.
1. Select **API permissions** > **Add a permission**.
1. Select **Microsoft APIs** > **Microsoft Graph** > **Application permissions**.
1. Select **CustomAuthenticationExtension.Receive.Payload** and then select **Add permissions**.
1. Select **Grant admin consent for {tenant}**.

## Step 4: Protect your Azure Function

The custom authentication extension for account recovery uses server-to-server authentication. Ensure your Azure Function validates the incoming token.

[!INCLUDE [portal-include](./includes/custom-extension-protect-function.md)]

## Step 5: Test the extension

To test the custom authentication extension:

1. Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Custom authentication extensions**.
1. Select the custom authentication extension you created.
1. Select **Test** to send a test request to your Azure Function endpoint.

## Troubleshooting

If the custom authentication extension doesn't work as expected, you can review the Azure Function logs to debug the issue.

1. Navigate to your Azure Function in the Azure portal.
1. Select **Monitor** > **Logs**.
1. Review the logs for any errors or unexpected behavior.

For more information about custom authentication extensions, see [Custom authentication extensions overview](custom-extension-overview.md).

## Related content

- [Custom authentication extensions overview](custom-extension-overview.md)
- [Account recovery overview](~/identity/authentication/concept-account-recovery-overview.md)
- [Configure a custom claim provider for a token issuance event](custom-extension-tokenissuancestart-configuration.md)

---
title: Set up SMS and voice with your own telephony provider by using APIs (BYOT)
description: Deploy your provider's published BYOT integration and configure SMS and voice authentication by using Microsoft Graph APIs.
ms.topic: how-to
ms.date: 11/23/2026
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to deploy my provider's BYOT integration and configure SMS and voice authentication by using APIs.
---

# Set up SMS and voice with your own telephony provider by using APIs (BYOT)

**Audience:** Customers deploying a telephony provider's published Bring Your Own Telephony (BYOT) integration in their own Azure subscription.

> **Are you a telephony provider building an integration?** Use the [Telephony provider guide: Bring Your Own Telephony (BYOT)](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/Telephony%20provider%20guide-%20Bring%20Your%20Own%20Telephony%20%28BYOT%29.md) instead.

Choose Your Own Telephony Provider (CYOT) is the recommended option for SMS and voice authentication. Use a supported CYOT provider whenever it meets your organization's needs. For setup instructions, see [Set up SMS and voice with a CYOT provider](choose-your-own-telephony-set-up.md). Use Bring Your Own Telephony (BYOT) only when regulatory, compliance, or other specific requirements call for a provider outside the supported CYOT offerings. With BYOT, you set up an account directly with your provider, deploy the provider's published integration in your Azure subscription, and configure Microsoft Entra to route SMS or voice authentication through your provider.

> [!IMPORTANT]
> Before following this guide, obtain a ready-to-deploy integration package containing an adapter for your telephony provider, along with its setup instructions. Your provider can use the [Telephony provider guide: Bring Your Own Telephony (BYOT)](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/Telephony%20provider%20guide-%20Bring%20Your%20Own%20Telephony%20%28BYOT%29.md) to prepare the integration.

This article walks you through the end-to-end setup, including setting up your provider account, deploying the integration, configuring the authentication method policy, and testing the experience before moving to production.

## How the integration works

BYOT uses an Azure Function in your Azure subscription to connect Microsoft Entra with your telephony provider. The Azure Function processes SMS or voice requests from Microsoft Entra and sends them to your provider for delivery.

Request flow: Microsoft Entra → Azure Function in your Azure subscription → your telephony provider → the recipient.

## Prerequisites

Before you begin, prepare:

- A ready-to-deploy integration package containing an adapter for your telephony provider, along with its setup instructions. Obtain these from your provider before starting setup.

- A Microsoft Entra workforce tenant.

- An Azure subscription with a valid payment method to host the integration. Set up your telephony provider account in step 1.

- [Azure Cloud Shell](/azure/cloud-shell/overview) in PowerShell mode (recommended), or PowerShell 7.0+ with Azure CLI 2.61+ for integration deployment.

- A test user with a phone number registered for SMS or voice authentication.

## Required permissions

Use accounts with the following permissions:

| **Task** | **Required access** | **Why it's needed** |
| --- | --- | --- |
| Create the application | Permission to register applications in your tenant | Lets setup create the application that securely connects Microsoft Entra to your integration. |
| Deploy Azure resources | Subscription Owner, or Contributor + Role Based Access Control Administrator at the required scope | Lets setup deploy the integration in your subscription. |
| Grant directory access during deployment | Privileged Role Administrator | Lets setup grant the directory permissions that Microsoft Entra needs to route requests to your integration. |
| Read authentication method policy | Delegated `Policy.Read.AuthenticationMethod` permission and a supported role, such as Authentication Policy Administrator | Allows setup to read the existing SMS or voice authentication method configuration. |
| Update authentication method policy | Authentication Policy Administrator and delegated `Policy.ReadWrite.AuthenticationMethod` permission | Allows setup to configure the SMS or voice authentication method to use the integration. |

> [!IMPORTANT]
> Before you begin, confirm that your Microsoft Entra policies allow the setup script to create the application and credentials it needs. If you use app management policies for credentials, multitenant apps, or custom Application ID URIs, review them with your Microsoft Entra administrator.

## Step 1: Set up your telephony provider account

1. Create or sign in to your account directly with your telephony provider and enable the SMS or voice services you plan to use.

1. Ask your provider for its setup command, GitHub repository, tested source version, provider ID, supported runtime, and Function package download URL.

1. Confirm that your provider supports your intended channels and countries, and obtain any account settings required for deployment.

1. Continue to step 2 to deploy the integration.

> [!IMPORTANT]
> Use your provider's published integration package and the setup values supplied with it. You don't need to build an adapter. Your provider follows the [Telephony provider guide: Bring Your Own Telephony (BYOT)](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/Telephony%20provider%20guide-%20Bring%20Your%20Own%20Telephony%20%28BYOT%29.md) to build and publish the integration.

## Step 2: Deploy the integration

Use Azure Cloud Shell in PowerShell mode to run the setup script from your telephony provider's GitHub repository.

### What the setup script does

The setup script deploys your provider's integration and the Azure resources needed to connect Microsoft Entra ID to your telephony provider. It walks you through a few choices, then shows the full deployment plan. Resource creation starts after you approve the plan.

After you approve, the script creates or uses the Microsoft Entra application, deploys and secures the Azure resources, and applies your provider's configuration. Deployment usually takes a few minutes.

You configure the authentication method policy in step 4.

### Costs

> [!IMPORTANT]
> The integration runs on Azure resources in your subscription, billed based on your configuration and usage. To plan your budget, see [Estimate telecom-provider and Azure hosting costs](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/COST-CALCULATOR.md) before you deploy.

### Run the setup script

1. Sign in to the Azure portal and select the Cloud Shell icon (\>\_) in the top toolbar. You can also go directly to [https://shell.azure.com](https://shell.azure.com).

1. Select PowerShell. If Cloud Shell opens in Bash, select Switch to PowerShell in the toolbar.

1. If this is your first time, select No storage account required, choose your subscription, and then select Apply.

1. Download and review the setup script. Replace the repository and source-version placeholders with the values supplied by your provider in step 1:

    ```powershell
    $repository = '<provider-organization>/<provider-repository>'
    $revision = '<provider-tested-commit-id>'
    Invoke-WebRequest `
        -Uri "https://raw.githubusercontent.com/$repository/$revision/setup/Setup-Epp.ps1" -OutFile .\Setup-Epp.ps1
    ```

1. Run the script. Replace the provider ID, runtime, and package download URL with your provider's values. Use the HTTPS download URL for your provider's published Function ZIP package.

    ```powershell
    .\Setup-Epp.ps1 -SourceRepository $repository -SourceRef $revision `
        -Provider '<provider-id>' -Language '<runtime>' `
        -PackagePath '<package-download-url>'
    ```

1. Follow the prompts to select your tenant, hosting subscription, application, Azure region, and hosting plan. Provide any additional account settings requested by your provider, then approve the deployment plan.

    > [!TIP]
    > **Choose region and plan for performance.** Deploy the Function App in the Azure region closest to your tenant's Microsoft Entra region. For low latency, use the Flex Consumption plan with one always-ready instance to avoid cold starts.

1. Save the deployment summary, including your tenant ID, endpoint URL, Application (client) ID, and provider values. You need these values to complete provider authorization and configure the authentication method policy.

> [!IMPORTANT]
> Save a copy of these values before you leave the Cloud Shell window so you can use them in the remaining setup steps.

## Step 3: Complete telephony provider authorization

After deployment completes, follow your telephony provider's instructions to authorize the integration for your account.

1. For providers using Microsoft Entra OAuth, send your provider your tenant ID, Application (client) ID, intended channels, and provider values from the deployment summary. Your provider authorizes the application and links it to your account.

1. For providers using an API key, open Key Vault \> Secrets in the Azure portal and select each secret named by your provider. Select New Version, enter the real credential, and make sure the new version is enabled. Store the credentials in these Key Vault secrets.

1. Complete any additional provider requirements, such as sender registration and supported countries, and confirm that your account is ready for the intended channels.

> [!IMPORTANT]
> Complete provider authorization and credential setup before configuring Microsoft Entra to send authentication traffic through your provider.

## Step 4: Update the authentication method policy

Configure each channel with the endpoint URL and application client ID from the deployment summary. Start in evaluation mode, validate the integration, and then gradually move delivery to your telephony provider.

> [!IMPORTANT]
> BYOT updates your existing SMS or voice authentication method policy, so changes also apply to current SMS and voice users. Before you update the policy, save the full JSON response from Read the current policy. In production, preserve your existing includeTargets, and use evaluation mode and migrationPercentage to roll out gradually. Test targeting changes in a test tenant.

### Read the current policy

Use [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to read and update the policy. Confirm that you're signed in to the tenant whose ID matches the Tenant ID in the deployment summary.

Use these request URLs for the corresponding channel:

| **Channel** | **Request URL** |
| --- | --- |
| SMS | <https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/Sms> |
| Voice | <https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/Voice> |

1. Set the request method to GET and enter the corresponding channel's request URL.

1. Open Modify permissions and consent to `Policy.Read.AuthenticationMethod`.

1. Select Run query and save the complete JSON response as a record of the existing policy.

1. Repeat for the other channel if you're configuring both SMS and voice.

> [!IMPORTANT]
> When you prepare the updated policy, use the saved response to preserve your existing `includeTargets` and other intended authentication method settings.

### Configure BYOT settings

Configure these properties:

| **Property** | **Value** |
| --- | --- |
| `telecomProviderSettings.url` | Endpoint URL from the deployment summary. |
| `telecomProviderSettings.appId` | Integration application client ID. |
| `telecomProviderSettings.isEvaluationModeEnabled` | Set to `true` for evaluation mode or `false` to enable telephony provider delivery. |
| `telecomProviderSettings.migrationPercentage` | Percentage of eligible authentication requests sampled during evaluation, or routed to your telephony provider when evaluation mode is disabled. |
| `includeTargets` | Preserve the existing production configuration. These targets are shared with the existing SMS or voice authentication method policy. |

### Start in evaluation mode

Start in evaluation mode to validate the integration before moving authentication delivery to your telephony provider. Evaluation validates endpoint authentication and request decryption. The provider-delivery tests in step 5 validate credentials and actual SMS or voice delivery.

Use `migrationPercentage` to set the evaluation sampling percentage.

1. Use the tested SMS or voice JSON example provided below in Request body.

1. Replace the endpoint URL and application client ID with the values for your deployment.

1. Set `isEvaluationModeEnabled` to `true`.

1. For production tenants, preserve the existing includeTargets from your saved policy configuration. Use a test tenant to validate BYOT with different targets.

1. Open Modify permissions, consent to `Policy.ReadWrite.AuthenticationMethod`, and send the PATCH request to the corresponding channel's URL.

1. Read the policy again with GET and verify the endpoint URL, application client ID, evaluation-mode setting, migration percentage, and existing targets.

1. Complete the [evaluation-mode tests](#test-in-evaluation) in step 5.

> [!IMPORTANT]
> The JSON examples below contain the tested configuration values. Before using an example, replace the endpoint URL and application client ID with the values for your deployment.

For evaluation mode, set isEvaluationModeEnabled to true. In a production tenant, preserve the includeTargets from your existing SMS or voice policy. Use a test tenant if you want to validate BYOT with different target users or groups.

For SMS:

```json
{
  "@odata.type": "#microsoft.graph.smsAuthenticationMethodConfiguration",
  "state": "enabled",
  "telecomProviderSettings": {
    "url": "<YOUR-ENDPOINT-URL>",
    "appId": "<YOUR-APPLICATION-CLIENT-ID>",
    "isEvaluationModeEnabled": false,
    "migrationPercentage": 100
  }
}
```

For Voice:

```json
{
  "@odata.type": "#microsoft.graph.voiceAuthenticationMethodConfiguration",
  "state": "enabled",
  "includeTargets": [
    {
      "verificationMode": "voiceOneTimePasscode"
    }
  ],
  "telecomProviderSettings": {
    "url": "<YOUR-ENDPOINT-URL>",
    "appId": "<YOUR-APPLICATION-CLIENT-ID>",
    "isEvaluationModeEnabled": false,
    "migrationPercentage": 100
  }
}
```

### Move to production mode

After evaluation succeeds:

1. Set `telecomProviderSettings.isEvaluationModeEnabled` to `false`.

1. Set `telecomProviderSettings.migrationPercentage` to your initial traffic percentage.

1. Keep the existing production `includeTargets` unchanged.

1. Submit the policy update.

1. Read the configuration again and verify the endpoint URL, application client ID, evaluation mode, migration percentage, and targets.

1. Test [telephony provider delivery](#test-provider-delivery) before increasing traffic.

### Increase traffic gradually

1. Keep `isEvaluationModeEnabled` set to `false`.

1. Increase `migrationPercentage` in increments until you reach `100`.

1. Keep the endpoint URL, application client ID, and existing `includeTargets` unchanged while changing the migration percentage.

1. [Validate authentication and telephony provider delivery](#test-provider-delivery) after each change.

1. Increase the percentage after each stage validates successfully. To investigate an issue, hold at the current percentage and see [Monitor and troubleshoot](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).

> [!IMPORTANT]
> When each stage validates successfully, continue to 100 percent without delay. Completing your rollout early helps ensure uninterrupted authentication for your users. For dates, see [Passkeys by default and retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).

## Step 5: Test the integration

Use a test user with a phone number registered for SMS or voice.

### Test in Evaluation

1. In an InPrivate browser session, sign in as the test user and complete an SMS or voice authentication.

1. In the Azure portal, go to your Function App → Functions → SendOtp → Invocations and open the latest transaction. In Invocation details, confirm Evaluation request completed with HTTP `200`.

1. In the Microsoft Entra admin center, go to Monitoring & health \> Audit logs and filter by Service: Azure MFA. Open the latest entry and confirm DeliveryMethod is `CyotEvaluation`.

### Test provider delivery

After evaluation succeeds, set `isEvaluationModeEnabled` to `false` and configure your initial `migrationPercentage`.

1. In a new InPrivate browser session, sign in as the test user. Confirm the SMS or voice code arrives and authentication completes.

1. In the Azure portal, go to your Function App → Functions → SendOtp → Invocations and open the latest transaction. In Invocation details, confirm the request completed with HTTP `200`.

1. In the Microsoft Entra admin center, go to Audit logs and filter by Service: Azure MFA. Open the latest entry and confirm Delivery Method is `Cyot`.

1. In your provider's portal, confirm the message was delivered.

At a partial percentage, only some requests route through your provider, so make a few attempts. If something doesn't look right, see [Monitor and troubleshoot your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).

## Troubleshooting

To diagnose integration issues, use the troubleshooting guide to identify whether the issue is with the Microsoft Entra configuration, Azure Function, telephony provider, or authentication flow.

See [Monitor and troubleshoot your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider) for diagnostic steps, logs, common issues, and remediation guidance.

## Related content

- [Set up SMS and voice with your own telephony provider in the Microsoft Entra admin center (CYOT)](choose-your-own-telephony-set-up.md) (the alternative to BYOT).

- [Troubleshoot SMS and voice with your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).

- [Protect against telephony fraud with your own telephony provider](choose-your-own-telephony-fraud-protection.md).

- [Plan for resiliency and high availability](choose-your-own-telephony-reliability.md).

- For telephony providers building an integration: [Telephony provider guide: Bring Your Own Telephony (BYOT)](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/Telephony%20provider%20guide-%20Bring%20Your%20Own%20Telephony%20%28BYOT%29.md).

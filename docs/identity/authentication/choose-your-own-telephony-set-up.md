---
title: Set up SMS and voice with your own telecom provider in the Microsoft Entra admin center
description: Use the Microsoft Entra admin center to set up your telecom integration, validate evaluation mode, and gradually roll out SMS and voice delivery.
ms.topic: how-to
ms.date: 10/30/2026
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to use the Microsoft Entra admin center to configure and test SMS and voice with my telecom provider.
---

# Set up SMS and voice with your own telecom provider in the Microsoft Entra admin center

<a id="set-up-sms-and-voice"></a>
<a id="set-up-sms-and-voice-with-your-own-telecom-providers"></a>

Use Choose Your Own Telephony Provider (CYOT) to deliver SMS and voice authentication through your organization's telephony provider. With CYOT, you purchase a supported provider offer through [Microsoft Security Store](https://securitystore.microsoft.com/), deploy the integration in your Azure subscription, and configure Microsoft Entra to route SMS or voice authentication through your provider.

This article walks you through the end-to-end setup in the Microsoft Entra admin center, including purchasing your provider offer, deploying the integration, configuring the authentication method policy, and testing the experience before moving to production.

## How the integration works

CYOT uses an Azure Function in your Azure subscription to connect Microsoft Entra with your telephony provider. The Azure Function processes SMS or voice requests from Microsoft Entra and sends them to your provider for delivery.

:::image type="content" source="media/concept-phone-providers/telephony-provider-integration-diagram.jpeg" alt-text="Diagram of the CYOT integration connecting Microsoft Entra to a telephony provider through an Azure Function in your Azure subscription.":::

<a id="before-you-begin"></a>

## Prerequisites

Before you begin, prepare:

- A Microsoft Entra workforce tenant.
- An Azure subscription with a valid payment method to host the integration and subscribe to your provider. See [Security Store purchasing prerequisites](/security/store/customers/how-to-purchase-a-saas-solution-and-deploy-a-linked-solution#prerequisites).
- [Azure Cloud Shell](/azure/cloud-shell/overview) in PowerShell mode (recommended), or PowerShell 7.0+ with Azure CLI 2.61+ for integration deployment.
- A test user with a phone number registered for SMS or voice authentication.

## Required permissions

Use accounts with the following permissions:

| Task | Required access | Why it's needed |
|---|---|---|
| Create the application during deployment | Permission to register applications in the customer tenant. | Lets setup create the application that securely connects Microsoft Entra to your integration. |
| Deploy Azure resources | Subscription Owner, or Contributor + Role Based Access Control Administrator at the required scope. | Lets setup deploy the integration in your subscription. |
| Grant directory access during deployment | Privileged Role Administrator. | Lets setup grant the directory permissions that Microsoft Entra needs to route requests to your integration. |
| Configure authentication method profiles | Authentication Policy Administrator. | Allows you to review existing SMS or voice settings and configure the integration in the Microsoft Entra admin center. |

> [!IMPORTANT]
> Before you begin, confirm that your Microsoft Entra policies allow the setup script to create the application and credentials it needs. If you use app management policies for credentials, multitenant apps, or custom Application ID URIs, review them with your Microsoft Entra administrator.

<a id="step-1-subscribe-and-activate-the-provider"></a>

## Step 1: Purchase and activate your telecom provider

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an Authentication Policy Administrator.
1. Go to **Entra ID** > **Authentication methods** > **Policies** and select **Add telecom profile**. The **Set up an SMS or voice provider** page guides you through subscription, integration, and profile setup.

    :::image type="content" source="media/choose-your-own-telephony-set-up/setup-overview.png" alt-text="Redacted screenshot of the Set up an SMS or voice provider page and its three setup tasks." lightbox="media/choose-your-own-telephony-set-up/setup-overview.png":::

1. Select **Subscribe to a telecom provider** and choose a supported telecom provider. Use **Get solution** to open its offer in [Microsoft Security Store](https://securitystore.microsoft.com/), or select an existing subscription with **Select details**. See [Available telephony providers](concept-phone-providers.md#available-telephony-providers).

    :::image type="content" source="media/choose-your-own-telephony-set-up/subscribe-telecom-provider.png" alt-text="Redacted screenshot of the telecom provider selection pane. Demo pricing and offer details are obscured." lightbox="media/choose-your-own-telephony-set-up/subscribe-telecom-provider.png":::

1. Purchase your provider's offer. For detailed purchasing instructions, see [Purchase and deploy a SaaS solution from Security Store](/security/store/customers/how-to-purchase-a-saas-solution-and-deploy-a-linked-solution).
1. After you **Place Order**, select **Configure Account Now** and follow your provider's registration instructions.
1. Keep the registration page available and return to the Microsoft Entra setup page. Continue to step 2; you'll complete registration in step 3 with the application ID from the deployment summary.

<a id="step-2-set-up-the-integration"></a>

## Step 2: Deploy the integration

On **Set up an SMS or voice provider**, select **Set up the provider integration**. Select the Azure hosting subscription and review the telecom provider configuration populated in the pane.

:::image type="content" source="media/choose-your-own-telephony-set-up/integration-setup.png" alt-text="Redacted screenshot of the provider integration pane with subscription selection, Function App setup, registration guidance, and Verify." lightbox="media/choose-your-own-telephony-set-up/integration-setup.png":::

### What the setup script does

The setup script deploys everything needed to connect Microsoft Entra ID to your telecom provider, so you don't have to create Azure resources by hand. It walks you through a few choices, then shows the full deployment plan. Nothing is created until you approve it.

After you approve, the script creates the Microsoft Entra application, deploys and secures the Azure resources, and applies your provider's configuration. Deployment usually takes a few minutes.

### Costs

> [!IMPORTANT]
> The integration runs on Azure resources in your subscription, billed based on your configuration and usage. To plan your budget, see [Estimate telecom-provider and Azure hosting costs](phone-providers-faq.yml#how-much-does-choose-your-own-telephony-provider-cost) before you deploy.

### Run the setup script

1. Select **View setup script on GitHub** in the integration pane and review the setup instructions.
1. Sign in to the Azure portal and select the **Cloud Shell** icon (**>_**) in the top toolbar. You can also go directly to <https://shell.azure.com>.
1. Select **PowerShell**. If Cloud Shell opens in Bash, select **Switch to PowerShell** in the toolbar.
1. If this is your first time, select **No storage account required**, choose your subscription, and then select **Apply**.
1. Download the setup script:

    ```powershell
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/main/setup/Setup-Epp.ps1' `
        -OutFile '.\Setup-Epp.ps1'
    ```

1. Run the script.

    ```powershell
    .\Setup-Epp.ps1
    ```

1. Follow the prompts to select the customer tenant, hosting subscription, Azure region, telecom provider, runtime, and hosting plan. Use the configuration shown in the integration pane and approve the deployment plan.
1. Save the deployment summary, including its tenant ID, endpoint URL, and **Application (client) ID**. You need these values to complete provider registration and configure your profile.

> [!IMPORTANT]
> Copy these values before you leave the Cloud Shell window. Cloud Shell sessions are temporary and can end when you navigate away, and the output isn't saved.

## Step 3: Complete telecom provider registration

After deployment completes, return to your telecom provider's registration page to complete the provider setup.

1. Provide the **Application (client) ID** created by the setup script when requested by your telecom provider.
1. Complete any additional registration steps required by the provider.
1. In [Microsoft Security Store](https://securitystore.microsoft.com/), go to **Management** > **My Solutions** and confirm that the **Subscription status** is '**Subscribed**' before continuing.
1. Return to **Set up the provider integration** in the Microsoft Entra admin center and select **Verify** to check the telecom provider subscription.

<a id="step-3-create-an-sms-or-voice-profile"></a>

## Step 4: Update the authentication method policy

<a id="read-the-current-policy"></a>

Create a profile for each intended channel. The wizard carries over the current channel's targets and populates the endpoint and application ID when you select the deployed Function App. Start in **Evaluation**, validate the integration, and then gradually move delivery to your telecom provider.

> [!WARNING]
> **Target users** are shared with your existing SMS or voice policy, so any change here also affects users who sign in with SMS or voice today. Keep the current selections during rollout, and use a test tenant to try different users or groups.

### Configure CYOT settings

1. Go to **Set up an SMS or voice provider** and select **Create an SMS or voice profile**.
1. On **Delivery channel**, select **SMS** or **Voice call**, then select **Next**. Each profile configures one delivery channel.

    :::image type="content" source="media/choose-your-own-telephony-set-up/delivery-channel.png" alt-text="Redacted screenshot of the Delivery channel step with SMS and Voice call options." lightbox="media/choose-your-own-telephony-set-up/delivery-channel.png":::

1. On **Target users**, review the targets carried over from the built-in channel configuration. Preserve the existing production **Include** and **Exclude** selections, then select **Next**.

    :::image type="content" source="media/choose-your-own-telephony-set-up/target-users.png" alt-text="Redacted screenshot of Target users with the carried-over targeting notice and included group values obscured." lightbox="media/choose-your-own-telephony-set-up/target-users.png":::

### Start in evaluation mode

1. On **Profile plan**, select **Evaluation**. Review the **Evaluation sampling percentage**, then select **Next**.

    :::image type="content" source="media/choose-your-own-telephony-set-up/evaluation-plan.png" alt-text="Redacted screenshot of the Evaluation plan, Microsoft-managed delivery explanation, and evaluation sampling control." lightbox="media/choose-your-own-telephony-set-up/evaluation-plan.png":::

1. On **Function App**, select the Function App deployed for the channel's integration. The wizard populates its **Function App URL** and **App ID**, along with subscription and resource details. Compare the endpoint and application client ID with the deployment summary, then select **Next**.

    :::image type="content" source="media/choose-your-own-telephony-set-up/select-function-app.png" alt-text="Redacted screenshot of Function App selection and automatically populated endpoint, application, subscription, and resource details." lightbox="media/choose-your-own-telephony-set-up/select-function-app.png":::

1. On **Review and finalize**, confirm the delivery channel, existing targets, **Evaluation** plan, and selected Function App, then select **Create profile**.

    > [!NOTE]
    > Changes to the authentication method policy can take up to an hour to take effect. Wait before you start testing.

1. Complete the [evaluation-mode tests](#test-evaluation-mode) in step 5.

Saving applies the selected plan and targets to the channel. In **Evaluation**, Microsoft-managed telephony continues delivering authentication messages while the integration processes validation requests. Repeat profile configuration for each channel you intend to support.

### Move to production mode

After evaluation succeeds:

1. Open the saved SMS or voice profile from **Authentication methods** > **Policies** and return to its **Profile plan** settings.
1. Select **Production** and set **Traffic routed through provider percentage** to your initial traffic percentage.

    :::image type="content" source="media/choose-your-own-telephony-set-up/production-plan.png" alt-text="Redacted screenshot of the Production plan and Traffic routed through provider percentage control." lightbox="media/choose-your-own-telephony-set-up/production-plan.png":::

1. Keep the existing production targets and selected Function App unchanged.
1. Review and save the profile changes. Confirm the saved plan, percentage, endpoint, application ID, and targets.
1. Test [telecom provider delivery](#test-telecom-provider-delivery) before increasing traffic.

<a id="step-5-gradually-roll-out"></a>

### Increase traffic gradually

1. Keep the profile in **Production**.
1. Increase **Traffic routed through provider percentage** in increments until you reach `100`.
1. Keep the endpoint URL, application client ID, and existing production targets unchanged while updating the traffic percentage.
1. [Validate authentication and telecom provider delivery](#check-each-rollout-stage) after every percentage change.
1. Increase the percentage after each stage validates successfully. To investigate an issue, hold at the current percentage and see [Monitor and troubleshoot](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).

> [!IMPORTANT]
> When each stage validates successfully, continue to 100 percent without delay. Completing your rollout early helps ensure uninterrupted authentication for your users. For dates, see [Passkeys by default and retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).

<a id="step-4-validate-the-request-path-and-real-delivery"></a>

## Step 5: Test the integration

Use a test user with a phone number registered for SMS or voice.

<a id="test-evaluation-mode"></a>

### Test in Evaluation

1. In an InPrivate browser session, sign in as the test user and complete an SMS or voice authentication.
1. In the Azure portal, go to your **Function App** → **Functions** → **SendOtp** → **Invocations** and open the latest transaction. In **Invocation details**, confirm **Evaluation request completed** with HTTP `200`.
1. In the Microsoft Entra admin center, go to **Monitoring & health** > **Audit logs** and filter by **Service: Azure MFA**. Open the latest entry and confirm **DeliveryMethod** is `CyotEvaluation`.

<a id="test-telecom-provider-delivery"></a>
<a id="check-each-rollout-stage"></a>

### Test provider delivery

After evaluation succeeds, switch to **Production** and set your initial traffic percentage.

1. In a new InPrivate browser session, sign in as the test user. Confirm the SMS or voice code arrives and authentication completes.
1. In the Azure portal, go to your **Function App** → **Functions** → **SendOtp** → **Invocations** and open the latest transaction. In **Invocation details**, confirm the request completed with HTTP `200`.
1. In the Microsoft Entra admin center, go to **Audit logs** and filter by **Service: Azure MFA**. Open the latest entry and confirm **Delivery Method** is `Cyot`.
1. In your provider's portal, confirm the message was delivered.

At a partial percentage, only some requests route through your provider, so make a few attempts. If something doesn't look right, see [Monitor and troubleshoot your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).

## Troubleshooting

To diagnose integration issues, use the troubleshooting guide to identify whether the issue is with the Microsoft Entra configuration, Azure Function, telecom provider, or authentication flow.

See [Monitor and troubleshoot your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider) for diagnostic steps, logs, common issues, and remediation guidance.

## Related content

- [Monitor and troubleshoot your own telephony provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).
- [Prevent telephony fraud when using your own telecom provider](choose-your-own-telephony-fraud-costs.md).
- [Plan for resiliency when using your own telecom provider](choose-your-own-telephony-reliability.md).

---
title: Configure the AI Gateway Prompt Shield (preview)
description: Secure your Enterprise generative AI apps from prompt injection attacks with Microsoft's AI Gateway Prompt Shield.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/06/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: KaTabish
ms.custom: sfi-image-nochange

#customer intent: As a security administrator, I want to configure the AI Gateway Prompt Shield content policies so that I can safeguard AI applications against malicious inputs.

---

# Protect AI applications with the AI Gateway Prompt Shield (preview)

Prompt injection attacks pose a significant risk for generative AI apps. As the frontier solution for securing AI and users' access to AI, Microsoft's Secure Web Gateway (SWG) is now the Secure Web and AI Gateway. This change adds Prompt Shield to protect enterprise generative AI apps from prompt injection attacks.

Prompt injection attacks are a serious threat to generative AI applications. Attackers craft malicious input to make a large language model (LLM) ignore instructions, expose sensitive data, perform unintended actions, or generate harmful content. It works like code injection for LLMs: instead of exploiting a SQL interpreter, attackers exploit the LLM's tendency to follow textual commands.

To protect enterprise AI, Microsoft's Secure Web Gateway (SWG) is now the Secure Web and AI Gateway. This update introduces Prompt Shield, which defends against prompt injection attacks and safeguards Global Secure Access. Without protection, prompt injection can lead to leaked credentials or personal data, disallowed content, unwanted actions in connected systems, and bypassed policy controls.

> [!IMPORTANT]
> The Prompt Shield feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:
- A valid [Microsoft Entra Internet Access license](overview-what-is-global-secure-access.md#licensing-overview). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- One or more devices or virtual machines running Windows that are either Microsoft Entra joined or hybrid joined to your organization's Microsoft Entra ID.
- To configure Global Secure Access settings, you need the [Global Secure Access Administrator role](reference-role-based-permissions.md#global-secure-access-administrator).
- To configure Conditional Access policies, you need the [Conditional Access Administrator role](reference-role-based-permissions.md#conditional-access-administrator).

## Configuration steps

To configure Prompt Shield for your organization, complete the following steps:
1. [Enable the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md#enable-the-internet-access-traffic-forwarding-profile) and configure the appropriate user assignments.
1. Configure [Transport Layer Security (TLS) inspection settings](how-to-transport-layer-security-settings.md) and [TLS Inspection policies](how-to-transport-layer-security.md).
1. Install and configure the Global Secure Access client on user devices. Follow the steps in [Install the Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md).
    > [!IMPORTANT]
    > Before you continue, test and ensure your client’s internet traffic is routed through the Global Secure Access service.

## Create a new content policy for Prompt Shield

To create new content policies for Prompt Shield protection:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **Prompt policies**.
1. Select **Create policy**.
1. On the **Basics** tab, enter a **Name** and **Description** for the policy.
1. Complete the **Settings** tab as needed.
1. Select **Next**.
1. On the **Rules** tab, select **Add rule**.
1. On the **Prompt rule** page:
    1. Enter or select a **Rule Name**, **Description**, **Priority**, and **Status**.
    1. Set **Action** to **Block** to block malicious prompts.
    :::image type="content" source="media/how-to-ai-prompt-shield/prompt-rule.png" alt-text="Screen shot of the Prompt Rule screen with example values in the form fields." lightbox="media/how-to-ai-prompt-shield/prompt-rule.png":::
1. Select **+ Conversation scheme** to choose the target LLMs for your Enterprise Gen AI.
1. From the **Type** menu, select the language model that matches your app. If the appropriate Gen AI model isn't on the list:
    1. Select **Custom**.
    1. Specify the **URL** of the service endpoint where the prompts are sent.
    1. Provide the **JSON path** for the prompt location in the request body.
1. Select **Add** to add the Conversation scheme. You can add multiple schemes.
1. Select **Next**.
1. To create the content policy, select **Create**.

## Link the content policy to your security profile

After you create the Prompt Shield content policy, link it to a new or existing security profile.
1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.
1. Select or create the security profile you want to link the content policy to.
1. Select the **Link policies** tab.
1. Select **+ Link a policy** > **Existing content policy**.
1. Select the Prompt Shield content policy you created earlier.
1. To link the Prompt Shield content policy, select **Add**.

## Create a Conditional Access policy

To create a Conditional Access policy:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**.
1. Enter a name for your policy.
1. Select **Users** to specify the users or groups that the policy applies to.
1. Set the **Target resources** to **All internet resources with Global Secure Access**.
1. Configure the **Network**, **Conditions**, and **Grant** settings as needed.
1. For **Session**, select **Use Global Secure Access Security Profile** and choose the security profile you created earlier.
1. Select **Create** to create the Conditional Access policy.

For more information, see [Create a Conditional Access policy targeting Global Secure Access internet traffic](how-to-target-resource-microsoft-profile.md#create-a-conditional-access-policy-targeting-global-secure-access-internet-traffic).

## Generative AI models
The following sections list more details about the AI models that work with Prompt Shield.

### Top supported generative AI models
Prompt Shield is preconfigured with the following models, with custom extractors on the backend: Copilot, ChatGPT, Claude, Grok, Llama Mistral, Cohere, Pi, and Qwen.

### Custom model support
You can protect any custom JSON-based LLM or GenAI app by configuring a custom type model with a URL and JSON path.

### Unsupported models
Prompt Shield doesn't support Gemini.

### Rate limits
- When the system reaches the rate limit, it blocks subsequent requests.
- To optimize the performance for custom LLMs, specify the exact URL and JSON path for each.
- The rate limit for Prompt Shield is []. <!--need rate limit info-->

## Known limitations

- Prompt Shield currently supports only text prompts. It doesn't support files.
- Prompt Shield supports only JSON-based GenAI apps. It doesn't support URL-based encoding.
- Prompt Shield supports only exact URL matching for the URL used to send prompt to the app.

## Related content

- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)
- [Apply Conditional Access policies to Global Secure Access traffic](how-to-target-resource-microsoft-profile.md)

---
title: "AI Gateway: Prompt Shield" (preview)
description: 
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: KaTabish
ms.custom: sfi-image-nochange

#customer intent: As an IT admin, I want to secure my Enterprise Gen AI apps from prompt injection attacks.

---

# Protect AI applications with the AI gateway Prompt Shield (preview)

Prompt injection attacks pose a significant risk for generative AI apps. As the frontier solution for securing AI and users' access to AI, Microsoft's Secure Web Gateway (SWG) is now the Secure Web and AI Gateway. This change adds Prompt Shield to protect Enterprise Gen AI apps from prompt injection attacks.

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
1. Configure [TLS inspection settings](how-to-transport-layer-security-settings.md) and [TLS Inspection policies](how-to-transport-layer-security.md).
1. Install and configure the Global Secure Access client on user devices. Follow the steps in [Install the Global Secure Access client for Microsoft Windows](how-to-install-windows-client.md).
    > [!IMPORTANT]
    > Before continuing, test and ensure your client’s internet traffic is routed through the Global Secure Access service.

## Create a new content policy for Prompt Shield

To create new content policies for Prompt Shield protection:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Create a new content policy:
1. Browse to **Global Secure Access** > **Secure** > **Content policies**.
1. Select **Create policy**.
1. Complete the **Basics** and **Settings** tabs as needed.
1. Select **Next**.
1. On the **Rules** tab, select **Add rule** > **Prompt shield scan rule**.
1. On the **Add Prompt shield scan rule** page, configure the appropriate settings for your organization.
1. Select **Add destination** and specify the FQDNs of your Enterprise Gen AI apps.
1. Select **Add** and then select **Next**.
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

## Known limitations

- Prompt Shield currently supports only text prompts. It doesn't support files.
- For Prompt Shield we support only JSON-based GenAI apps (for example, for public Apps chatGPT will work but 
Gemini won't as it uses URL-based encoding).
- Only exact URL matching for Prompt Shield (and this isn't the URL that is in your browser, this is URL which is 
used to send prompt to the app) 
- Note that apps may use multiple URLs and FQDNs under the hood when you interact with them (so when not 
seeing policies applied check with dev tools to confirm URLs and FQDNs, and collect flow correlation ids for 
investigation). E.g. chatgpt uses different URLs and FQDNs:
    - For prompt, they use "https://chatgpt.com/backend-api/conversation", 
"https://chatgpt.com/backend-api/f/conversation" (and "https://" part is required!, so they can use
browser dev tools to get exact).
    - For file upload they use FQDNs: files.oaiusercontent.com, files08.oaiusercontent.com,
files09.oaiusercontent.com, etc.
- For WebCat based matching you need a webcat policy (eg. something in baseline profile that will trigger 
webcat - currently, we reuse web categorization results from web filtering filter).
- Multipart encoding is not supported, so file policy will not work for such applications (e.g. Google Drive uses 
multipart encoding for file upload) 
- Compressed content will be detected just as zip (we don't decompress content yet) 
- Accuracy of true file type detection is not 100%. 

## Related content

- [Global Secure Access traffic forwarding profiles](concept-traffic-forwarding.md)
- [Apply Conditional Access policies to Global Secure Access traffic](how-to-target-resource-microsoft-profile.md)

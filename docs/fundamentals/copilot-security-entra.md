---
title: Security Copilot in Microsoft Entra
description: Overview of Security Copilot in Microsoft Entra and how to get started with embedded experiences and agents.
keywords:
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 08/25/2025
ms.update-cycle: 180-days
ms.topic: overview
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
#Customer intent: As a SOC analyst or IT admin using Copilot in Microsoft Entra, I want to get an understanding of the Microsoft Entra integrations, including agents and embedded experiences.
---

# Security Copilot in Microsoft Entra

**Applies to:** Microsoft Entra ![Green circle with a white check mark symbol.](../media/common/applies-to-yes.png)

[Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) is a platform that brings together the power of AI and human expertise to help administrators and security teams respond to attacks faster and more effectively. Microsoft Entra is one of the Microsoft plugins that enable the Security Copilot platform to generate accurate and relevant information. Through this plugin, Security Copilot can help you investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly. Security Copilot gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more. 

You can explore sign-ins and risky users, get contextualized insights on how to resolve incidents, learn how to protect accounts using natural language. Built on top of real-time machine learning, Security Copilot can help you find gaps in access policies, generate identity workflows, and troubleshoot faster. Security Copilot can assist with scenarios across different products in the Microsoft Entra admin center, such as an incident investigation that includes the Microsoft Entra ID Protection risky user reports and Microsoft Entra sign-in logs.

This article introduces you to Security Copilot in Microsoft Entra.

## Security Copilot experiences

Security Copilot in Microsoft Entra includes the standalone Security Copilot experience, embedded experiences in the Microsoft Entra admin center, specialized agents that can perform tasks, and natural language prompts that can be used in several end-to-end scenarios.

For more information, see:

- [Microsoft Security Copilot experiences](/security-copilot/experiences-security-copilot)
- [Microsoft Security Copilot agents](/security-copilot/agents-overview)
- [Microsoft Security Copilot scenarios](copilot-entra-security-scenarios.md)

## Get started

In the Security Copilot platform, Microsoft Entra is a plugin that provides access to your organization's identity data and insights. To use Security Copilot in Microsoft Entra, you need to onboard to Security Copilot and turn on the Microsoft Entra plugin. 

1. Onboard to Security Copilot by following the [Get started with Microsoft Security Copilot](/security-copilot/get-started-security-copilot) guide.
    - This guide contains guidance around subscription requirements, billing, and capacity.
    - Take a moment to [understand authentication in Microsoft Security Copilot](/security-copilot/authentication).
1. In the Security Copilot standalone experience, select the **Sources** icon from the prompt bar and turn on the Microsoft Entra plugin for Security Copilot, if it's not already on.

Once you're all set up in Security Copilot, you can start using [natural language prompts](/security-copilot/prompting-security-copilot) to help remediate identity-based incidents. You can always check the **Promptbook library** in the standalone [Security Copilot](https://securitycopilot.microsoft.com/) experience for more examples.

- *Give me all user details for karita@woodgrovebank.com and extract the user Object ID.*
- *Does karita@woodgrovebank.com have any registered devices in Microsoft Entra?*
- *List the recent risky sign-ins for karita@woodgrovebank.com.*
- *Can you give me sign-in logs for karita@woodgrovebank.com for the past 48 hours? Put this information in a table format.*
- *Get Microsoft Entra audit logs for karita@woodgrovebank.com for the past 72 hours. Put information in table format.*

## Provide feedback

Copilot in Microsoft Entra uses AI and machine learning to process data and generate responses for each of the key features. However, AI-generated content might be incorrect. Your feedback on the generated responses helps improve the accuracy of Copilot and Microsoft Entra over time.

All key features have an option for providing feedback, but the exact steps vary based on the feature. Look for the thumbs up and thumbs down icons to let us know if the response was helpful or not.

:::image type="content" source="./media/copilot-security-entra/thumbs-up-thumbs-down.png" alt-text="Screenshot of the Copilot thumbs up and thumbs down icons for providing feedback.":::

## Privacy and data security in Security Copilot

To understand how Security Copilot handles your prompts and the data that’s retrieved from the service(prompt output), see [Privacy and data security in Microsoft Security Copilot](/security-copilot/privacy-data-security).

## Related content

- [Responsible AI FAQs](/security-copilot/responsible-ai-overview-security-copilot)
- [Investigate security incidents](copilot-security-entra-investigate-incident.md) using the Microsoft Entra skills in Microsoft Security Copilot.
- [Investigate risky apps](copilot-security-entra-investigate-risky-apps.md) using the Microsoft Entra skills in Microsoft Security Copilot.
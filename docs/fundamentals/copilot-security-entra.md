---
# required metadata

title: Respond to identity threats using Copilot.
description: Use Copilot in Microsoft Entra to investigate identity risks and troubleshoot identity tasks quickly.
keywords:
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 12/10/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot, ignite-2024
ms.collection: ce-skilling-ai-copilot
#Customer intent: As a SOC analyst or IT admin using Copilot in Microsoft Entra, I want to get an understanding of the Microsoft Entra integration, so that I can use it to respond to and remediate identity risks.
---

# Copilot in Microsoft Entra

**Applies to:** Microsoft Entra ![Green circle with a white check mark symbol.](../media/common/applies-to-yes.png)

[Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) is a platform that brings together the power of AI and human expertise to help administrators and security teams respond to attacks faster and more effectively. Security Copilot is embedded in Microsoft Entra so you can investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.  Copilot in Microsoft Entra (Copilot) gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more. 

You can explore sign-ins and risky users and get contextualized insights on how to resolve incidents and what to do to protect the accounts in natural language.  Built on top of real-time machine learning, Copilot can help you find gaps in access policies, generate identity workflows, and troubleshoot faster. You can also unlock new skills that allow admins at all levels to complete complex tasks such as incident investigation, sign-in log analysis, and more, to gain savings in time and resources.

This article introduces you to Copilot in Microsoft Entra.

## Know before you begin

If you're new to Security Copilot, you should familiarize yourself with it by reading these articles:
- [What is Microsoft Security Copilot?](/security-copilot/microsoft-security-copilot)
- [Microsoft Security Copilot experiences](/security-copilot/experiences-security-copilot)
- [Get started with Microsoft Security Copilot](/security-copilot/get-started-security-copilot)
- [Understand authentication in Microsoft Security Copilot](/security-copilot/authentication)
- [Prompting in Microsoft Security Copilot](/security-copilot/prompting-security-copilot)

## Security Copilot integration in Microsoft Entra

Microsoft Entra is one of the Microsoft plugins that enable the Security Copilot platform to generate accurate and relevant information. Through the Microsoft Entra plugin, the Security Copilot portal can provide more context to incidents and generate more accurate results. The key features mentioned in this article are capabilities that are also available in the Security Copilot portal.

## Key features

Microsoft Entra brings the capabilities of Security Copilot to the Microsoft Entra admin center, enabling administrators and security teams to respond to identity threats quickly. Bringing AI to Microsoft Entra allows teams to understand risks immediately and determine remediation steps in a timely manner. For more information about the key features, see [Microsoft Security Copilot scenarios in Microsoft Entra](./copilot-entra-security-scenarios.md).

## Enable the Security Copilot integration in Microsoft Entra

You can learn more about plugins implemented in the Security Copilot portal in [Manage plugins in Security Copilot](/security-copilot/manage-plugins). Additionally, you can learn more about the embedded experiences in other Microsoft security products in [Security Copilot experiences](/security-copilot/experiences-security-copilot).

## Sample Microsoft Entra prompts

Once you're all set up in Security Copilot, you can start using natural language prompts to help remediate identity-based incidents:

- *Give me all user details for karita@woodgrovebank.com and extract the user Object ID.*
- *Does karita@woodgrovebank.com have any registered devices in Microsoft Entra?*
- *List the recent risky sign-ins for karita@woodgrovebank.com.*
- *Can you give me sign-in logs for karita@woodgrovebank.com for the past 48 hours? Put this information in a table format.*
- *Get Microsoft Entra audit logs for karita@woodgrovebank.com for the past 72 hours. Put information in table format.*

## Provide feedback

Copilot in Microsoft Entra uses AI and machine learning to process data and generate responses for each of the key features. However, AI might misinterpret some data, which sometimes cause a mismatch in responses. Your feedback on the generated responses helps improve the accuracy of Copilot and Microsoft Entra over time.

All key features have an option for providing feedback. To provide feedback, perform the following steps:

1. Select the thumb up icon located at the bottom of any response card in the Copilot pane.
1. Answer the question **What did you like?**
1. Select **Yes, share** samples or **No, don't share** samples.
1. Select **Submit**.

Or

1. Select the thumb down icon located at the bottom of any response card in the Copilot pane.
1. Select **Inaccurate** if any detail is incorrect or incomplete based on your assessment. Select **Offensive or inappropriate** if it contains potentially harmful, questionable, or ambiguous information.  Select **Other** for some other reason.
1. Whenever possible, write a few words explaining what can be done to improve the outcome in the **What went wrong?** text box.
1. Select **Yes, share** samples or **No, don't share** samples.
1. Select **Submit**.

## Privacy and data security in Security Copilot

To understand how Security Copilot handles your prompts and the data that’s retrieved from the service(prompt output), see [Privacy and data security in Microsoft Security Copilot](/security-copilot/privacy-data-security).

## Next steps

- Learn more about [risky user summarization](copilot-entra-risky-user-summarization.md).
- [Investigate security incidents](copilot-security-entra-investigate-incident.md) using the Microsoft Entra skills in Microsoft Security Copilot.
- [Investigate risky apps](copilot-security-entra-investigate-risky-apps.md) using the Microsoft Entra skills in Microsoft Security Copilot.

## See also

- [Get started with Microsoft Security Copilot](/security-copilot/get-started-security-copilot)
- [What is Security Copilot?](/security-copilot/microsoft-security-copilot)
- [Privacy and data security in Security Copilot](/security-copilot/privacy-data-security)
- [Responsible AI FAQs](/security-copilot/responsible-ai-overview-security-copilot)

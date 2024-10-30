---
# required metadata

title: Respond to identity threats quickly using Copilot in Microsoft Entra
description: Use Microsoft Copilot in Microsoft Entra to investigate identity risks and troubleshoot identity tasks quickly.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 08/08/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
ms.collection: ce-skilling-ai-copilot

#Customer intent: As a SOC analyst or IT admin using Microsoft Copilot in Microsoft Entra, I want to get an understanding of the Microsoft Entra integration, so that I can use it to respond to and remediate identity risks.
---

# Microsoft Copilot in Microsoft Entra

**Applies to:**

- Microsoft Entra

[Microsoft Copilot for Security](/security-copilot/microsoft-security-copilot) is a platform that brings together the power of AI and human expertise to help administrators and security teams respond to attacks faster and more effectively. Copilot for Security is embedded in Microsoft Entra so you can investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.  Microsoft Copilot in Microsoft Entra gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more. 

You can explore sign-ins and risky users and get contextualized insights on how to resolve incidents and what to do to protect the accounts in natural language.  Built on top of real-time machine learning, Copilot in Microsoft Entra can help you find gaps in access policies, generate identity workflows, and troubleshoot faster. You can also unlock new skills that allow admins at all levels to complete complex tasks such as incident investigation, sign-in log analysis, and more, to gain savings in time and resources.

This article introduces you to Copilot in Microsoft Entra.

## Key features

Microsoft Entra brings the capabilities of Copilot for Security to the Microsoft Entra admin center, enabling administrators and security teams to respond to identity threats quickly. Bringing AI to Microsoft Entra allows teams to understand risks immediately and determine remediation steps in a timely manner.

### Create Copilot for Security prompts in the Microsoft Entra admin center (preview)

Copilot for Security is a part of the Microsoft Entra admin center, use it to create your own prompts.  Launch Copilot from a globally available button in the menu bar. Click-to-run Starter Prompts appear at the top of the Copilot window. Suggested Prompts may also appear after a response, these are predefined prompts that Copilot selects based on the skill used in the prior response. 

:::image type="content" source="./media/copilot-security-entra/security-copilot-entra-admin-center.png" alt-text="Screenshot that shows Security Copilot in the Microsoft Entra admin center.":::

Specific scenarios supported by Microsoft Entra skills: 

- As an IT admin, I need to troubleshoot user’s sign-in events.
- As an IT admin or SOC Analyst, I need details about these users and groups.
- As an IT admin or SOC Analyst, I need to understand changes made in Entra to users, roles, groups, and apps in audit log details.
- As an IT admin or SOC Analyst, I want Copilot to help me improve security posture and reduce application / workload identity risk.
- As an IT admin or SOC Analyst, I need to see relevent [Microsoft Entra documentation](/entra/) while investigating incidents. 

Copilot responses in the Microsoft Entra admin center only use Microsoft Entra, Microsoft Intune, Windows AutoPatch, Cloud PC, and Microsoft Documentation skills and not skills for other services such as Microsoft Defender XDR or Microsoft Purview.

### Summarize a user's risk level

Microsoft Entra ID Protection applies the capabilities of Copilot for Security to [summarize a user's risk level](copilot-entra-risky-user-summarization.md), provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot for Microsoft Entra helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

## Providing feedback

Copilot in Microsoft Entra uses AI and machine learning to process data and generate responses for each of the key features. However, AI might misinterpret some data, which sometimes cause a mismatch in responses. Providing your feedback about the generated responses enable both Copilot in Microsoft Entra and Microsoft Entra to continuously improve delivery of more accurate responses in the future.

All key features have an option for providing feedback. To provide feedback, perform the following steps:

1. Select the thumb up icon located at the bottom of any response card in the Copilot in Microsoft Entra pane.
1. Answer the question **What did you like?**
1. Select **Yes, share** samples or **No, don't share** samples.
1. Select **Submit**.

Or

1. Select the thumb up icon located at the bottom of any response card in the Copilot in Microsoft Entra pane.
1. Select **Inaccurate** if any detail is incorrect or incomplete based on your assessment. Select **Offensive or inappropriate** if it contains potentially harmful, questionable, or ambiguous information.  Select **Other** for some other reason.
1. Whenever possible, write a few words explaining what can be done to improve the outcome in the **What went wrong?** text box.
1. Select **Yes, share** samples or **No, don't share** samples.
1. Select **Submit**.


## Microsoft Entra plugin in Copilot for Security

Microsoft Entra is one of the Microsoft plugins that enable the Copilot for Security platform to generate accurate and relevant information. Through the Microsoft Entra plugin, the Copilot for Security portal can provide more context to incidents and generate more accurate results. The key features mentioned in this article are capabilities that are also available in the Copilot for Security portal.

You can learn more about plugins implemented in the Copilot for Security portal in [Manage plugins in Copilot for Security](/security-copilot/manage-plugins). Additionally, you can learn more about the embedded experiences in other Microsoft security products in [Copilot for Security experiences](/security-copilot/experiences-security-copilot).

## Next steps

- Learn more about [risky user summarization](copilot-entra-risky-user-summarization.md).
- [Investigate security incidents](copilot-security-entra-investigate-incident.md) using the Microsoft Entra skills in Microsoft Copilot for Security.

## See also

- [Get started with Microsoft Copilot for Security](/security-copilot/get-started-security-copilot)
- [What is Copilot for Security?](/security-copilot/microsoft-security-copilot)
- [Privacy and data security in Copilot for Security](/security-copilot/privacy-data-security)
- [Responsible AI FAQs](/security-copilot/responsible-ai-overview-security-copilot)


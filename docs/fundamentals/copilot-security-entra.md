---
# required metadata

title: Respond to identity threats using Copilot.
description: Use Copilot in Microsoft Entra to investigate identity risks and troubleshoot identity tasks quickly.
keywords:
author: rwike77
ms.author: ryanwi
manager: celestedg
ms.date: 12/10/2024
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot, ignite-2024
ms.collection: ce-skilling-ai-copilot
#Customer intent: As a SOC analyst or IT admin using Copilot in Microsoft Entra, I want to get an understanding of the Microsoft Entra integration, so that I can use it to respond to and remediate identity risks.
---

# Copilot in Microsoft Entra

**Applies to:**

- Microsoft Entra

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

Microsoft Entra brings the capabilities of Security Copilot to the Microsoft Entra admin center, enabling administrators and security teams to respond to identity threats quickly. Bringing AI to Microsoft Entra allows teams to understand risks immediately and determine remediation steps in a timely manner.

### Create Security Copilot prompts in the Microsoft Entra admin center (preview)

Security Copilot is a part of the Microsoft Entra admin center, use it to create your own prompts.  Launch Security Copilot from a globally available button in the menu bar. Choose from a set of starter prompts that appear at the top of the Security Copilot window or enter your own in the prompt bar to get started. Suggested prompts may also appear after a response, these are predefined prompts that Security Copilot selects based on the prior response. 

:::image type="content" source="./media/copilot-security-entra/security-copilot-entra-admin-center.png" alt-text="Screenshot that shows Security Copilot in the Microsoft Entra admin center.":::

Specific scenarios supported by Security Copilot embedded in Microsoft Entra skills: 

- Troubleshoot a user’s sign-in events.
- Find details about users and groups.
- Find and summarize changes made to users, roles, groups, and apps from Microsoft Entra audit log details.
- Improve your security posture and reduce application/workload identity risk.
- Learn more about Microsoft Entra and receive guidance on identity & access administration from relevant [Microsoft Entra documentation](/entra/). 

### Summarize a user's risk level

Microsoft Entra ID Protection applies the capabilities of Security Copilot to [summarize a user's risk level](copilot-entra-risky-user-summarization.md), provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

### Investigate access reviews

Administrators can use Microsoft Security Copilot with Microsoft Entra ID Governance Access Reviews to extract and analyze access review data. This integration allows admins to explore, track, and analyze access reviews at scale. For more information, see [Investigate access reviews in Microsoft Entra Copilot](copilot-entra-access-reviews.md).

### Investigate recommendations

The Microsoft Entra recommendations feature helps monitor the status of your tenant, so you don't have to. Entra Recommendations applies the capabilities of Microsoft Security Copilot  to help your security team investigate how to evolve your tenants to secure and healthy state while also helping you maximize the value of the features available in Microsoft Entra ID. For more information, see [Microsoft Entra Recommendations with Microsoft Security Copilot](copilot-entra-recommendations.md).

### Investigate insights within entitlements management

Use Microsoft Security Copilot with Microsoft Entra ID Governance Entitlement Management to get quick access to information about access packages, policies, connected organizations, and catalog resources. For more information, see [Investigate insights within entitlements management in Microsoft Entra Copilot](copilot-entra-entitlement-management.md).

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

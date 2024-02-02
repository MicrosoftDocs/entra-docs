---
# required metadata

title: Use Security Copilot to respond to identity threats quickly
description: You can use Security Copilot for Microsoft Entra to investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.
keywords:
author: rwike77
ms.author: ryanwi
manager: celested
ms.date: 01/29/2024
ms.topic: conceptual
ms.service: active-directory
ms.subservice: fundamentals
ms.workload: identity

# 
---

# Security Copilot in Microsoft Entra

**Applies to:**

- Microsoft Entra

The Microsoft Security Copilot in Microsoft Entra Early Access Program is an invitation-only, paid preview. If your organization is interested in this program, work with your Microsoft account manager to learn more about nominations for a potential invite. To learn more about this program, see the [Microsoft Security Copilot Early Access Program FAQ](/security-copilot/faq-security-copilot).

If you use [Microsoft Entra ID](/entra/fundamentals/whatis), then you can use Security Copilot to investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.

Specifically, Security Copilot gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more. You can explore sign-ins and risky users and get contextualized insights on how to resolve and what to do to protect the accounts in natural language.  Built on top of real-time machine learning, Security Copilot can help you find gaps in access policies, generate identity workflows, and troubleshoot faster. You can also unlock new skills that allow admins at all levels to complete complex tasks such as incident investigation, sign-in log analysis, and more, to gain savings in time and resources.

This article introduces you to Security Copilot and includes sample prompts that can help Microsoft Entra ID admins.

## Access Security Copilot in Microsoft Entra

To ensure that you have access to Security Copilot, see the [Security Copilot purchase and licensing information](/security-copilot/faq-security-copilot). Once you have access to Security Copilot, the key capabilities discussed below become accessible in [Security Copilot](https://go.microsoft.com/fwlink/?linkid=2247989) and the [Microsoft Entra admin center](https://entra.microsoft.com/).

## Key features

In Security Copilot, there are built in system features. These features can get data from the different plugins that are enabled.

To view the list of built-in system capabilities for Microsoft Entra, use the following steps:

1. In the prompt, enter **/**.
2. Select **See all system capabilities**. The **Entra** section lists all the available capabilities for Microsoft Entra that you can use.

There are many prompts you can use to get information about your Microsoft Entra data. This section lists some ideas and examples.

### Get Microsoft Entra user details 

Get specific information about **Microsoft Entra users in the tenant**, details for the authentication methods enabled for a given user, the user’s group membership information, and more.

**Sample prompts**:

- Tell me more about Entra user: username@contoso.com 

- Who is this user: "Given_name Surname"

- What is the email for this Entra user:  xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx 

- List the active users created in the last x days

- Is this user’s account enabled?

- Show me the authentication method details for Entra user Given_name Surname

- What auth methods does this user have?

### Get Microsoft Entra group details 

Get details on **Microsoft Entra groups** in Microsoft Entra ID, like who the group owner is or if a certain user is a member of the group.

**Sample prompts**:

- Tell me more about this group: xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  

- Who is the owner of this group: Group Name 

- Tell me about the group with the name that starts with 'XYZ'

- Is user@contoso.com a member of this group?

- How many members are in this group:  xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx 

- List all groups with names starting with 'XYZ'

- Who created this group?

### Get Entra sign-in Logs 

Get information on **sign-in logs** for Microsoft Entra user, like the last X sign-ins or the last X failed sign-ins.

**Sample prompts**:

- Show me the last X sign-ins for this Microsoft Entra user: xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx 

- Show me the sign-ins from this location

- Show me failed sign-ins for user@contoso.com

### Get Entra risky users

Get the details for Microsoft Entra users carrying an elevated risk of compromise. 

**Sample prompts**:

- What is the risk level for user: xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx 

- Is this user risky?

## Providing feedback

Security Copilot and Microsoft Entra uses AI and machine learning to process data and generate responses for each of the key features. However, AI might misinterpret some data, which sometimes cause a mismatch in responses. Providing your feedback about the generated responses enable both Security Copilot and Microsoft Entra to continuously improve delivery of more accurate responses in the future.

To provide feedback, in Security Copilot, use the feedback buttons at the bottom of each completed prompt:

:::image type="content" source="./media/copilot-security-entra/security-copilot-prompt-feedback.png" alt-text="Screenshot that shows how to submit feedback on the prompt results in Microsoft Security Copilot.":::

Your options:

- **Looks right**: The results match expectations.
- **Needs improvement**: The results don't match expectations.
- **Inappropriate**: The results are harmful in some way.

Whenever possible, and when the result is **Needs improvement**, write a few words explaining what can be done to improve the outcome. If you entered Microsoft Entra-specific prompts and the results aren't Microsoft Entra related, then include that information.

## Microsoft Entra plugin in Security Copilot

Microsoft Entra is one of the Microsoft plugins that enable the Security Copilot platform to generate accurate and relevant information. Through the Microsoft Entra plugin, the Security Copilot portal can provide more context to incidents and generate more accurate results. The key features mentioned in this article are capabilities that are also available in the Security Copilot portal.

You can learn more about plugins implemented in the Security Copilot portal in [Manage plugins in Security Copilot](/security-copilot/manage-plugins). Additionally, you can learn more about the embedded experiences in other Microsoft security products in [Microsoft Security Copilot experiences](/security-copilot/experiences-security-copilot).

## Next steps

## See also

- [Get started with Security Copilot](/security-copilot/get-started-security-copilot)
- [What is Microsoft Security Copilot?](/security-copilot/microsoft-security-copilot)
- [Privacy and data security in Microsoft Security Copilot](/security-copilot/privacy-data-security)
- [Responsible AI FAQs](/security-copilot/responsible-ai-overview-security-copilot)
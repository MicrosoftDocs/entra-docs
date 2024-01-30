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

# Copilot for Security in Entra

> [!IMPORTANT]
> The information in this article applies to the Microsoft Security Copilot Early Access Program, which is an invite-only paid preview program. Some information in this article relates to prereleased product, which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided in this article.

Security Copilot is a cloud-based AI platform that provides a natural language copilot experience. It can help support security professionals in different scenarios, like incident response, threat hunting, and intelligence gathering. For more information about what it can do, go to [What is Microsoft Security Copilot?](/security-copilot/microsoft-security-copilot).

**Security Copilot integrates with Microsoft Entra**.

If you use [Microsoft Entra ID](/entra/fundamentals/whatis), then you can use Security Copilot to investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.

Specifically, Security Copilot gets insights from your Microsoft Entra ID data. You can explore sign-ins and risky users and get contextualized insights on how to resolve and what to do to protect the accounts in natural language.  Built on top of real-time machine learning, Security Copilot can help you find gaps in access policies, generate identity workflows, and troubleshoot faster. You can also unlock new skills that allow admins at all levels to complete complex tasks such as incident investigation, sign-in log analysis, and more, to gain savings in time and resources.

This article introduces you to Security Copilot and includes sample prompts that can help Microsoft Entra ID admins.

## Know before you begin

- Be clear and specific with your prompts. You might get better results if you include specific device IDs/names, app names, or policy names in your prompts.

  It might also help to add **Microsoft Entra** to your prompt, like:

  - **Tell me more about this Entra user: username@contoso.com**
  - **Who is the owner of this Entra group: xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx **

- Experiment with different prompts and variations to see what works best for your use case. Chat AI models vary, so iterate and refine your prompts based on the results you receive.

- Security Copilot saves your prompt sessions. To see the previous sessions, in Security Copilot, go to the menu > **My Sessions**:

  :::image type="content" source="./media/copilot-security-entra/security-copilot-menu-my-sessions.png" alt-text="Screenshot that shows the Microsoft Security Copilot menu and My investigations with previous sessions.":::

  For a walkthrough on Security Copilot, including the pin and share feature, go to [Navigating Microsoft Security Copilot](/security-copilot/navigating-security-copilot).

For more information on writing Security Copilot prompts, go to [Microsoft Security Copilot prompting tips](/security-copilot/prompting-tips).

## Open Security Copilot

1. Go to [Microsoft Security Copilot](https://go.microsoft.com/fwlink/?linkid=2247989) and sign in with your credentials.
2. By default, Microsoft Entra should be enabled. To confirm, select **plugins** (bottom left corner):

    :::image type="content" source="./media/copilot-security-entra/security-copilot-plugins.png" alt-text="Screenshot that shows the plugins that are available, enabled, and disabled in Microsoft Security Copilot.":::

    In **My plugins**, confirm Microsoft Entra is on. Close **Plugins**.

    > [!NOTE]
    > Some roles can enable or disable plugins, like Microsoft Entra. For more information, go to [Manage plugins in Microsoft Security Copilot](/security-copilot/manage-plugins).

3. Enter your prompt.

## Built-in system features

In Security Copilot, there are built in system features. These features can get data from the different plugins that are enabled.

To view the list of built-in system capabilities for Microsoft Entra, use the following steps:

1. In the prompt, enter **/**.
2. Select **See all system capabilities**.
3. In the Entra section, you can:

    - Get Entra audit logs
    - Get Entra diagnostics logs
    - Get Entra group details
    - Get Entra risky users
    - Get Entra sign in logs
    - Get Entra user details
    - And more

## Sample prompts for Microsoft Entra

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

## Provide feedback

Your feedback on the Microsoft Entra integration with Security Copilot helps with development. To provide feedback, in Security Copilot, use the feedback buttons at the bottom of each completed prompt:

:::image type="content" source="./media/copilot-security-entra/security-copilot-prompt-feedback.png" alt-text="Screenshot that shows how to submit feedback on the prompt results in Microsoft Security Copilot.":::

Your options:

- **Looks right**: The results match expectations.
- **Needs improvement**: The results don't match expectations.
- **Inappropriate**: The results are harmful in some way.

Whenever possible, and when the result is **Needs improvement**, write a few words explaining what can be done to improve the outcome. If you entered Microsoft Entra-specific prompts and the results aren't Microsoft Entra related, then include that information.

## Data processing and privacy

When you interact with the Security Copilot to get Microsoft Entra data, Security Copilot pulls that data from Microsoft Entra ID. The prompts, the Microsoft Entra data that's retrieved, and the output shown in the prompt results is processed and stored within the Security Copilot service.

For more information about data privacy in Security Copilot, go to [Privacy and data security in Microsoft Security Copilot](/security-copilot/privacy-data-security).

## Related articles

- [What is Microsoft Security Copilot?](/security-copilot/microsoft-security-copilot)
- [Privacy and data security in Microsoft Security Copilot](/security-copilot/privacy-data-security)
---
title: Microsoft Entra Support Assistant
description: Discover how the Microsoft Entra Support Assistant uses AI and Microsoft Graph data to analyze product logs, resolve issues, and enhance IT admin workflows.
author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: tychusnyanga
ms.date: 01/23/2026
ms.topic: how-to
ms.service: entra
# customer intent: As an IT admin, I want to troubleshoot identity and access issues using the Support Assistant so that I can resolve problems quickly.

---
# Use the Microsoft Entra Support Assistant (Preview)

The Microsoft Entra Support Assistant is an AI-driven conversational support experience that enables IT admins to troubleshoot identity and access issues and get answers to product questions. The assistant uses Microsoft public documentation from [learn.microsoft.com](https://learn.microsoft.com) as its knowledge base.

The Support Assistant analyzes product logs accessed with the Microsoft Graph API to identify the root cause of issues and provide relevant resolution guidance. The assistant is offered at no cost to Microsoft Entra customers. This article describes how to use the Support Assistant.

## Key features

The Support Assistant provides a conversational chat interface where users in the Microsoft Entra admin center can interact using natural language prompts. The chat experience can be initiated through the **Diagnose and solve problems** page.

The Support Assistant uses Microsoft Graph data and public documentation from [learn.microsoft.com](https://learn.microsoft.com) as a knowledge base to analyze failures and suggest step-by-step resolutions through guided troubleshooting. As you interact with the Support Assistant, it uses this knowledge base to provide context, explanations, and guidance.

If issues remain unresolved, you can seamlessly escalate them to Microsoft support. The assistant includes a feedback loop that lets you submit ratings and comments to help enhance the quality of responses.

## Prerequisites

The Support Assistant is available to users with permissions to create and manage support tickets, such as [Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator) and [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).

For a full list of roles, see [Lease privileged role by task](../identity/role-based-access-control/delegate-by-task.md).

## How to work with the Microsoft Entra Support Assistant

1. Sign in to the Microsoft Entra admin center as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Go to **Diagnose and solve problems**.
1. Select **Support Assistant**.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-button.png" alt-text="Screenshot of the Microsoft Entra Support Assistant interface." lightbox="media/how-to-entra-support-assistant/support-assistant-button.png":::

1. Either select one of the prebuilt prompts or enter a natural language question in the text box.

1. Some responses provide the option to answer more questions or select a specific event to troubleshoot. Select an option to troubleshoot further.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-event-options.png" alt-text="Screenshot of the Microsoft Entra Support Assistant with event option buttons highlighted." lightbox="media/how-to-entra-support-assistant/support-assistant-event-options.png":::

1. As you continue to provide further clarification or select specific events to troubleshoot, the Support Assistant uses Microsoft public documentation to provide context, explanations, and guidance. Select the appropriate option or enter more natural language prompts to continue.

1. After your initial question, you can ask follow-up questions to refine the troubleshooting process. On the third response (after two follow-up questions), the option to create a support request appears at the top of the window.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-support-request.png" alt-text="Screenshot of the Microsoft Entra Support Assistant with the create support requestion option highlighted." lightbox="media/how-to-entra-support-assistant/support-assistant-request-option.png":::

### Special considerations

As you use the Microsoft Entra Support Assistant, keep in mind the following details:

- The Support Assistant conversation flow is dynamic and flexible, so each experience can vary slightly.
- Select **New chat** at the top of the window to refresh the conversation.
- At this time, the Support Assistant provides identity-related troubleshooting for the following types of scenarios:
    - Authentication and multifactor authentication failures
    - Device registration and sync issues
    - Microsoft Entra Connect provisioning errors
    - Conditional Access misconfigurations
    - Application SSO errors
- The Support Assistant can't perform actions in your tenant - it only provides guidance.
- Select **Switch to classic experience** at the top of the window to switch to the non-AI legacy search experience.

## Provide feedback

Each assistant response includes a feedback prompt for rating, comments, or suggestions. Use the "thumbs up" or "thumbs down" buttons to provide feedback on the responses. This feedback is important and is used to improve the accuracy of the Support Assistant.

​The Support Assistant might make mistakes or provide incomplete information. Always verify important actions and consult the official Microsoft documentation when needed.
​
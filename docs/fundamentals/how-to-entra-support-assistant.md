---
title: Microsoft Entra Support Assistant
description: Discover how the Microsoft Entra Support Assistant uses AI and Microsoft Graph data to analyze product logs, resolve issues, and enhance IT admin workflows.
author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: tychusnyanga
ms.date: 01/13/2026
ms.topic: concept-article
ms.service: entra
# customer intent: As an IT admin, I want to troubleshoot identity and access issues using the Support Assistant so that I can resolve problems quickly.

---
# Use the Microsoft Entra Support Assistant (Preview)

The Microsoft Entra Support Assistant is an AI-driven conversational support experience that enables IT admins to troubleshoot identity and access issues and get answers to product questions. The assistant uses Microsoft public documentation from [learn.microsoft.com](https://learn.microsoft.com) as its knowledge base.

The Support Assistant analyzes product logs accessed with the Microsoft Graph API to identify the root cause of issues and provide relevant resolution guidance. The assistant is offered at no cost to Microsoft Entra customers. This article describes how to use the Support Assistant.

## Key features

The Support Assistant provides a conversational chat interface where users in the Microsoft Entra admin center can interact using natural language prompts. The chat experience can be initiated through standard entry points or seamlessly integrated within other workflows.

The Support Assistant uses Microsoft Graph data and public documentation from [learn.microsoft.com](https://learn.microsoft.com) as a knowledge base to analyze failures and suggest step-by-step resolutions through guided troubleshooting. As you interact with the Support Assistant, it uses this knowledge base to provide context, explanations, and guidance.

If issues remain unresolved, you can seamlessly escalate them to Microsoft support. The assistant includes a feedback loop that lets you submit ratings and comments to help enhance the quality of responses. An interactive dashboard lets you track key metrics such as engagement, self-help success rates, customer positive feedback rate, and Support Assistant uptime.

## Prerequisites

The following roles can create and manage support tickets and have access to use the Support Assistant:

- [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator)
- [Billing Administrator](../identity/role-based-access-control/permissions-reference.md#billing-administrator)
- [Cloud Application Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator)
- [Cloud Device Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-device-administrator)
- [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator)
- [Customer Lockbox Access Approver](../identity/role-based-access-control/permissions-reference.md#customer-lockbox-access-approver)
- [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)
- [Groups Administrator](../identity/role-based-access-control/permissions-reference.md#groups-administrator)
- [Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator)
- [License Administrator](../identity/role-based-access-control/permissions-reference.md#license-administrator)
- [Privileged Role Administrator](../identity/role-based-access-control/permissions-reference.md#privileged-role-administrator)
- [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)
- [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)
- [User Administrator](../identity/role-based-access-control/permissions-reference.md#user-administrator)

## How to work with the Microsoft Entra Support Assistant

1. Sign in to the Microsoft Entra admin center as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Go to **Diagnose and solve problems**.
1. Select **Support Assistant**.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-button.png" alt-text="Screenshot of the Microsoft Entra Support Assistant interface." lightboc="media/how-to-entra-support-assistant/support-assistant-button.png":::

1. Either select one of the prebuilt prompts or enter a natural language question in the text box.

1. Some responses provide the option to answer more questions or select a specific event to troubleshoot. Select an option to troubleshoot further.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-event-options.png" alt-text="Screenshot of the Microsoft Entra Support Assistant with event option buttons highlighted." lightboc="media/how-to-entra-support-assistant/support-assistant-event-options.png":::

1. As you continue to provide further clarification or select specific events to troubleshoot, the Support Assistant uses Microsoft public documentation to provide context, explanations, and guidance. Select the appropriate option or enter more natural language prompts to continue.

1. If the options provided don't match your scenario or don't resolve the issue, the Support Assistant provides an option at the top of the window to create a support request.

    :::image type="content" source="media/how-to-entra-support-assistant/support-assistant-support-request.png" alt-text="Screenshot of the Microsoft Entra Support Assistant with event option buttons highlighted." lightboc="media/how-to-entra-support-assistant/support-assistant-request-option.png":::

### Special considerations

As you use the Microsoft Entra Support Assistant, keep in mind the following:

- The Support Assistant conversation flow is dynamic and flexible, so each experience can vary slightly.
- Select **New chat** at the top of the window to refresh the conversation.
- Select **Switch to classic experience** at the top of the window to use the prompts to search for and select the appropriate options to create a support request.
- At this time, the Support Assistant provides identity-related troubleshooting for the following types of scenarios:
    - Authentication and multifactor authentication failures
    - Device registration and sync issues
    - Microsoft Entra Connect provisioning errors
    - Conditional Access misconfigurations
    - Application SSO errors
- The Support Assistant can't perform actions in your tenant - it only provides guidance.

## Provide feedback

Each assistant response includes a feedback prompt for rating, comments, or suggestions. Use the "thumbs up" or "thumbs down" buttons to provide feedback on the responses. This feedback is important and is used to improve the accuracy of the Support Assistant.

​The Support Assistant might make mistakes or provide incomplete information. Always verify important actions and consult the official Microsoft documentation when needed.
​
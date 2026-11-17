---
title: Install the Microsoft Entra External ID agent toolkit
description: Set up the Microsoft Entra External ID agent toolkit with your AI coding agent, then choose the skill for your app's task.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
ms.custom: msecd-doc-authoring-1030
# Customer intent: As an app developer, I want to install the Microsoft Entra External ID agent toolkit for my coding agent so that I can use its skills in my app.
---

# Install the Microsoft Entra External ID agent toolkit

Install the Microsoft Entra External ID agent toolkit for your AI coding agent so you can choose a skill for your app's task. Installation is shared across the toolkit; follow the guide for your chosen skill after setup.

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

## Prerequisites

- [Node.js](https://nodejs.org/en/download) 22.20 or later, only if you use the Skills CLI installation option.
- An AI coding agent, such as GitHub Copilot CLI, Claude Code, Codex, GitHub Copilot in Visual Studio Code, or Cursor.

## Install the toolkit

Choose the tab for your coding agent. The plugin installation options use the identifier `eeid-toolkit`. The Skills CLI option installs the toolkit's skills for agents such as GitHub Copilot in Visual Studio Code and Cursor.

### [GitHub Copilot CLI](#tab/github-copilot)

- Run these commands in your terminal:

    ```bash
    copilot plugin marketplace add AzureAD/ms-eeid-agent-toolkit
    copilot plugin install eeid-toolkit@ms-eeid-agent-toolkit
    ```

### [Claude Code](#tab/claude-code)

- Run these commands in a Claude Code session:

    ```text
    /plugin marketplace add AzureAD/ms-eeid-agent-toolkit
    /plugin install eeid-toolkit@ms-eeid-agent-toolkit
    ```

### [Codex](#tab/codex)

1. Run this command in your terminal:

    ```bash
    codex plugin marketplace add AzureAD/ms-eeid-agent-toolkit
    ```

1. Start Codex, enter `/plugins`, and install `eeid-toolkit` from the plugin list.

### [Other agents](#tab/other-agents)

Use the [Skills CLI](https://github.com/vercel-labs/skills) to install all the toolkit's skills for Cursor, GitHub Copilot in Visual Studio Code, and other agents.

- Run this command in your terminal:

    ```bash
    npx skills add AzureAD/ms-eeid-agent-toolkit --all
    ```

To install all the skills for a specific agent instead, use `--agent` with the agent's name. For example, use this optional form for Cursor:

```bash
npx skills add AzureAD/ms-eeid-agent-toolkit --skill '*' --agent cursor
```

---

## Choose your next skill

Select the guide for the task you want to complete. The guides describe skill-specific prerequisites and procedures without requiring you to repeat toolkit installation.

1. Review the [skills catalog](ai-agent-toolkit-overview.md#skills-catalog) and choose the skill for your task.
1. Follow the corresponding guide:

    - Use [`eeid-onboarding`](how-to-ai-agent-toolkit-onboard.md) to onboard an app to Microsoft Entra External ID.
    - Use [`eeid-native-auth-migrate-v2`](how-to-ai-agent-toolkit-migrate-native-auth-v2.md) to migrate an existing app from native authentication V1 to V2.

## Related content

- Explore the [Microsoft Entra External ID agent toolkit overview](ai-agent-toolkit-overview.md).
- Learn about [native authentication](~/identity-platform/concept-native-authentication.md).

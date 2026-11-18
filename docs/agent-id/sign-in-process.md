---
title: Microsoft Entra Agent ID sign-in process
description: Learn about the Microsoft Entra Agent ID sign-in process, including consent pages, trust criteria, and how to manage agent permissions for secure access to AI agents using work accounts.
ms.topic: concept-article
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
#customer-intent: As an end user, I want to understand agent sign-in and consent so that I can decide whether to approve an agent's access to my work account.
---

# Microsoft Entra Agent ID sign-in process

When you sign in to an AI agent that uses Microsoft Entra Agent ID, a consent page explains the permissions the agent requests. Review the publisher and requested access before you approve.

This article explains how to assess that request, decide whether to approve it, and get help if the agent looks suspicious. The following image shows an example consent page:

:::image type="content" source="./media/sign-in-process/consent-page.png" alt-text="Screenshot of a sample consent page for signing in to an AI agent.":::

## Sign-in to an agent

An AI agent is software that can perform tasks for you or your team. It might summarize information, watch for issues, send alerts, or prepare drafts you can review. Unlike a regular app that waits for you to select or type, an agent can act on its own within the limits you approve.

To sign you in, AI agents must register their product or service with Microsoft by creating an Agent ID. Each AI agent has a unique Agent ID.

An Agent ID allows the AI agent to:

- Sign you in and identify you.
- Request access to data and actions you allow.

## Consent pages

Agents need permissions before they can access your organization's data. Depending on your organization's policies and previous approvals, you might see requests to:

- **Add this agent to your organization.** This makes the agent available in your organization. If the agent is already added, you don't need to add it again.

- **Allow the agent to access data.** This request lists the information or actions the agent needs, such as reading your profile or email. You can allow or deny the request. Your organization might require administrator approval.

This page gives you control over how AI agents use your accounts and data you have access to.

## Trust an agent

The consent page includes information to help you assess the trustworthiness of an agent that you sign in to:

- The name of the agent, product, or service
- Whether the agent has completed Microsoft's publisher verification process
- The organization that published the agent
- Whether the agent is built by Microsoft

For details about the consent page, see [Application consent experience](~/identity-platform/application-consent-experience.md).

**If you did not intentionally sign-in to this agent, always deny access. Never sign-in to apps or agents you're unfamiliar with.**

## Add agent to your organization

AI agents can't participate in your organization unless a member approves them. When you add an agent to your organization, the agent becomes available to you and other employees or members to use. The agent is able to sign-in other members and request access to their data and information.

An agent might also use a dedicated agent account to access resources that require a user account, such as a mailbox. Adding the agent doesn't give it unlimited permission to create accounts or access resources. Account creation and resource access remain subject to the permissions and policies approved by your administrator. For more information, see [Agent's user accounts](agent-users.md).

**If you're uncertain whether to add an agent to your organization, pause and contact your administrator.**

## Allow an agent to access data

Approving the agent to access data means the following:

- The agent can use the listed permissions without asking again each time.
- The agent can run in the background to carry out tasks you or your organization configured.

It doesn't give the agent unlimited access. It only gets the specific items shown and can't go outside them unless you or an administrator later grant more permissions.

**When in doubt, pause and ask your administrator if permissions are safe to grant to an agent**.

## Disable an agent or its permissions

You (or an administrator) can remove or disable the agent or its permissions. For more information, see [Manage agents in the end-user experience](manage-agent-identities-end-user.md). For global removal, administrators can delete the agent identity using Microsoft Graph API or Microsoft Entra PowerShell.

## Criteria to report a suspicious agent

Report an agent if:

- The publisher name looks wrong or suspicious.
- Permissions seem far too broad for the described task.
- You were prompted unexpectedly and no recent change explains it.
- The agent appears to misuse data.

Use the **report it here** link on the consent screen or notify your security desk.

## Need help?

If you're unsure, don't approve. Capture a screenshot, note the agent name, and contact your helpdesk or security team for guidance.

---
title: Add authentication with the AI agent toolkit
description: Use the eeid-onboarding skill to choose an authentication experience, plan or implement app changes, and get manual tenant setup instructions.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
ms.custom: msecd-doc-authoring-1030
# Customer intent: As an app developer, I want to use an AI coding agent to onboard my app to Microsoft Entra External ID so that I can choose an authentication experience and review the required app and tenant changes.
---

# Add Microsoft Entra External ID authentication with the AI agent toolkit

Use the `eeid-onboarding` skill to choose an authentication experience for your app, create an implementation plan or apply approved code changes, and get tenant configuration instructions. You make the authentication choices, approve application changes, and complete tenant setup manually.

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

## Prerequisites

- Completion of [Install the AI agent toolkit](how-to-install-ai-agent-toolkit.md).
- Your application's source code, available to your coding agent.
- A Microsoft Entra external tenant and its tenant ID. If you need a tenant, [create an external tenant](how-to-create-external-tenant-portal.md).
- An account with permission to complete the tenant configuration steps for your selected authentication experience.
- Your project's existing build and test tools, if you choose to implement code changes.

## Start the onboarding skill

Start in your app's source folder so that the agent can base its recommendations on your project.

1. Open the application's source folder in your coding agent.
1. Ask the agent to use the `eeid-onboarding` skill. For example, enter:

    ```text
    /eeid-onboarding Help me add Microsoft Entra External ID authentication to this app.
    ```

1. Choose **Hosted authentication (faster setup)** or **Custom authentication experience (more control)** when prompted. Select **Other / help me choose** to discuss the trade-offs before continuing.
1. Let the agent inspect your repository without changing it. Review its recommended authentication approach and confirm your choice.

The skill presents **Web authentication**, **Native authentication**, or **BYO UX** according to your selected experience and the repository findings. It asks for your choice before moving on.

## Select journeys, tenant details, and factors

Your choices determine the application changes and the manual tenant setup instructions.

1. Select the journeys you want to enable: **Sign in**, **Sign up**, **MFA**, or **Self-service password reset (SSPR)**.
1. Provide your tenant ID. The agent attempts to resolve the external-tenant subdomain from authenticated tenant metadata. If it can't resolve the subdomain, provide it when prompted.
1. Confirm the tenant details the agent presents.
1. Select the sign-in factors. Without MFA, choose **Email + password** or **Email one-time passcode**. With MFA, review and select the first-factor and second-factor combination the agent presents.

## Choose a plan or approved implementation

Choose whether you want a technical plan to review or application code changes. Tenant setup remains manual in either mode.

1. Review the selected authentication approach, journeys, tenant details, and factors with the agent.
1. Choose an implementation mode:

    - **Create a dry-run plan** produces a dependency-ordered technical plan without changing your repository or tenant. Review the proposed files, packages, configuration, routes, scopes, tests, tenant steps, and rollback guidance.
    - **Implement changes** prepares application code changes for your approval. Review the exact files and package changes, repository checkpoint information, and targeted rollback procedure before confirming.

The onboarding skill requires approval before changing code, installing packages, or replacing an existing authentication stack. For implementation, it records the Git branch, commit, and working-tree status. For dirty or non-Git projects, its checkpoint procedure copies the files it will change to a location outside the repository.

## Complete the manual tenant setup

Use the tailored instructions the agent provides for your chosen approach. The standard onboarding workflow doesn't run tenant automation scripts.

1. Review the generated Microsoft Entra admin center instructions. Each step should identify the action, its purpose, the expected result, and how to verify it.
1. Complete the applicable tenant configuration steps manually. Check that the application registration, platform, redirect URIs, scopes, and selected journeys match the application code or dry-run plan.
1. If you selected Web authentication and want branding, review the offered branding package and follow the generated upload and configuration instructions.

## Verify the result and review the handoff

Distinguish changes the agent completed from configuration and tests that you still need to perform.

1. If the agent implemented code changes, review the changed files and the results of your project's applicable format, lint, type, build, and test commands.
1. If you chose a dry run, confirm that the plan includes dependency-ordered implementation tasks, acceptance checks, tenant instructions, tests, and rollback guidance.
1. Complete the manual checks for your selected journeys and factors. Compare redirect URIs exactly and check the applicable authority, scopes, protected routes, and logout behavior.
1. Review the handoff for completed checks, remaining tenant steps, and blocked items. Don't treat a generated instruction as a completed tenant configuration step.

## Related content

- Explore the [AI agent toolkit overview and available skills](ai-agent-toolkit-overview.md).
- Review how to [choose an authentication approach](concept-choose-authentication-approach.md).
- Learn how to [migrate native authentication with the toolkit](how-to-ai-agent-toolkit-migrate-native-auth-v2.md).

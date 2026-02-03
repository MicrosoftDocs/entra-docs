---
title: Identity Risk Management Agent Settings
description: Learn how to configure the settings for the Identity Risk Management Agent in Microsoft Entra ID Protection.
ms.service: entra-id-protection

ms.topic: concept-article
ms.date: 10/20/2025

author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: chuqiaoshi
---

# Identity Risk Management Agent (Preview) settings

The Identity Risk Management Agent in Microsoft Entra ID Protection provides proactive risk management capabilities by analyzing user behavior and suggesting actions to mitigate potential identity risks. You can configure the settings to meet your organization's needs, such as how often it runs, and email notifications.

> [!NOTE]
> The Identity Risk Management Agent is currently being deployed and in preview. This information relates to a prerelease product that might be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Access the agent settings

Once the agent is enabled, you can adjust a few settings. To review and adjust the settings:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **ID Protection** > **Risky users**.
1. With the **Agent view** selected, select the ellipses in the upper-right corner and then select **Settings**.
1. On the agent page, select the **Settings** tab. The settings are organized into **Controls**, **Communications**, and **Memory**.
1. After making any changes, select **Save** at the bottom of the page.

You can also access the settings from the Microsoft Entra agent library. Select **Agents** from the left-hand navigation, select the **Identity Risk Management Agent**, and then select the **Settings** tab.

### Controls

The **Controls** section provides the roles and permissions required for the agent to run. You can also adjust how the agent is triggered and the scope of the agent.

#### Trigger

By default, the agent continuously monitors your tenant, but you can also change the frequency or set to manual run only. When the agent is set to run daily or manually, the agent can send [email notifications](#communications) to selected recipients after each run.

The following options are available:

- **Continuous monitoring**: The agent checks for new risky users every 5 minutes and automatically investigates them.
- **Daily trigger**: The agent runs automatically every 24 hours.
- **Manual run**: The agent runs only when started manually.

#### Permissions and role-based access

The agent requires specific permissions to read risk detections, risk history, sign-in and audit logs, and user information. These permissions are granted through the [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) role.

#### Scope

By default, the agent investigates the most recent 100 risky users within the last 90 days. You can control the scope of for agent scan by adjusting several options. 

- Select the **Select users and groups** option to search for and select the users and groups you want the agent to scan.
- Set the maximum recent risky users to scan within 1-100.
- Select which risk levels to include in the scan. All risk levels are selected by default.
- Set a specific time frame for the scope:
   - Last 7 days
   - Last 14 days
   - Last 30 days
   - Custom time frame up to 90 days

### Communications

The Identity Risk Management Agent can send email notifications to selected recipients. Notifications aren't turned on by default. 

1. Set the **Email notifications** toggle to **On**.
1. Select the **No users selected** link under the **Additional recipients** heading to search for and add more recipients.

### Memory

The Identity Risk Management Agent uses your feedback to refine its suggestions over time. If you mark a false positive as "confirmed safe", the agent remembers that feedback for future runs. The history of the input you and your team provide appears in this list.
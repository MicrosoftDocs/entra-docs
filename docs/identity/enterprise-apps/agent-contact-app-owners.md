---
title: Contact application owners for unused app remediation
description: Learn how to use the Microsoft Entra App Lifecycle Management agent to notify application owners about unused applications and collect their feedback for remediation decisions.
ms.author: jomondi
author: omondiatieno
manager: mwongerapk
ms.date: 11/04/2025
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.reviewer: ariels
#customer intent: As an IT administrator, I want to engage application owners in the remediation process for unused applications so that I can safely reduce security risk while avoiding unintended business disruption.
---

# Contact application owners for unused app remediation

The Microsoft Entra App Lifecycle Management agent can automatically notify application owners about unused applications in your environment. This capability streamlines the remediation process by collecting owner feedback before making decisions about application removal or retention.

The contact owners feature enables you to:

- Identify applications with assigned owners from unused app reports
- Send automated notifications via email or Microsoft Teams
- Collect owner feedback on whether applications should be retained or removed
- Track the response status and escalate unresponsive cases
- Integrate owner decisions into remediation planning workflows

This feature works as part of the broader app lifecycle management workflow, helping you safely reduce your application attack surface while maintaining business continuity.

## Prerequisites

To contact application owners, you need:


- A Microsoft Entra ID P2 or Workload Identity Premium P2
- One of the following Microsoft Entra ID roles:
   - [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator)
   - [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
   - [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)
   - [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator)
   - [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role in Security Copilot.
- For app owners to use the Microsoft Teams bot to respond to notifications from the App Lifecycle Management Agent, they must have access to Microsoft Teams and must have an active access review assigned to them. They must also have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role assigned to them.
- The App Lifecycle Management agent configured and running
- Security Copilot with provisioned SCUs
- Applications with owners assigned in Microsoft Entra ID

## Ensure app owners can respond to Teams bot messages about their apps

App owners can respond to notifications about their apps through a [Microsoft Teams App](https://teams.microsoft.com/l/app/dca72f77-b157-4ce3-b119-653a7d1b5adf). If your organizations' [Microsoft Teams org-wide app settings](/microsoftteams/manage-apps#manage-org-wide-app-settings) allow Microsoft applications, no action is required. If your organization has disabled Microsoft apps in the Microsoft Teams org-wide app settings, your organizations' Microsoft Teams administrator must explicitly approve the app.

You must also ensure that all reviewers have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role so that they can use the agent to complete their reviews. This is required because the natural language conversation in Microsoft Teams is opening a Microsoft Security Copilot session behind the scenes. Participating reviewers access the agentic experience via Microsoft Teams, but with the role assignment they have access to the [Security Copilot portal](https://securitycopilot.microsoft.com/) or the Security Copilot experience in other Microsoft Security administrative portals. If reviewers access Security Copilot outside of Microsoft Teams, their data access with Security Copilot is still subject to [default user permissions](../../fundamentals/users-default-permissions).

## How it works

The agent identifies unused applications with assigned owners and facilitates communication through this process:

- **Owner identification:** The agent scans applications for owners assigned in the Microsoft Entra application registration or service principal owner properties.

- **Communication workflow:** Notifications are sent via email from `AppRiskAgent-noreply@microsoft.com` or through Microsoft Teams bot messages, depending on your configuration.

- **Response tracking:** The agent monitors owner responses and integrates feedback into remediation planning. Owners can indicate whether applications should be retained, removed, or if they're not the correct contact.

- **Integration with remediation:** Owner decisions are incorporated into batch remediation plans, allowing for safe, graduated application removal based on owner consent.

## Contact application owners

To notify owners about unused applications:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Select **Agents** from the left navigation.

1. Select the **App Lifecycle Management** agent.

1. From the **Suggestions** tab, locate the **Contact known app owners for remediation** suggestion.

1. Select **Review** to view applications with assigned owners.

1. Review the list of applications and their owners. Select the checkbox next to each application you want to include in notifications.

   > [!TIP]
   > Select the **+** symbol next to an owner name to view all owners for applications with multiple assigned owners. All listed owners receive notifications.

1. Choose your notification method:
   - **Contact via Outlook**: Sends email notifications that you can review before sending
   - **Contact via Teams**: Sends Microsoft Teams bot notifications (if configured)

1. If using email notifications:
   1. Select **Contact via Outlook** to open the email template
   1. Review the prepopulated email content
   1. Modify the message if needed
   1. Select **Send** to deliver notifications

1. If you're using Teams notifications:
   1. Select **Contact via Teams** to open the Teams notification template
   1. Review the prepopulated message content
   1. Modify the message if needed
   1. Select **Send** to deliver notifications

> [!NOTE]
> Allow up to 15 minutes for email delivery. Teams notifications are typically delivered immediately. If emails aren't received, check spam filters for messages from `AppLifecycleManagementAgent-noreply@microsoft.com`.

The agent currently supports notifying owners of up to 20 unused applications per notification cycle during private preview.

## Monitor owner responses

After sending notifications, track owner responses through the agent interface:

1. Return to the **App Lifecycle Management** agent.

1. Select the **Activities** tab to view notification status and responses.

1. Monitor response categories:
   - **Disable app**: Owner agrees the application can be disabled
   - **Keep app**: Owner requests the application be retained
   - **Not the owner**: Owner indicates they're not responsible for the application

> [!NOTE]
> App owner responses are only possible with Teams notifications, not emails.

For nonresponsive owners, the agent tracks response timeframes and identifies applications with no owner feedback. Consider reaching out directly to owners through alternative communication channels. Applications with nonresponsive owners might be included in lower-priority remediation batches.

Owner decisions are automatically incorporated into remediation planning workflows. Applications with owner consent are prioritized for removal, while those marked to be retained are excluded from future remediation suggestions.

## Handle applications without owners

When the agent identifies unused applications without assigned owners, it attempts to suggest potential owners based on the application creator (and other factors in the future). It then reviews suggested owners in the agent interface based on those factors

:::image type="content" source="media/agent-contact-app-owners/suggested-app-owners.png" alt-text="Screenshot showing suggested owner identification interface." lightbox="media/agent-contact-app-owners/suggested-app-owners.png":::

To assign owners manually, follow the guidance provided in the [Assign app owners](assign-app-owners.md) guide.

   > [!TIP]
   > If you can't identify appropriate owners, consider contacting IT or security teams for guidance before proceeding with remediation.

For applications with no identifiable owners, consider implementing organization-wide policies requiring owner assignment for all applications.

## Related content

- [Create remediation plans for unused applications](agent-app-lifecycle-remediation-plans.md)
- [Monitor and identify risky applications](agent-identify-prioritize-risky-apps.md)
- [App ownership overview](overview-assign-app-owners.md)
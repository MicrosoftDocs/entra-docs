---
title: Microsoft Entra Conditional Access optimization agent
description: Learn how the Microsoft Entra Conditional Access optimization agent with Microsoft Security Copilot can help secure your organization.
ms.author: sarahlipsey
author: shlipsey3
manager: pmwongera
ms.reviewer: jodah

ms.date: 12/11/2025

ms.update-cycle: 180-days
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.custom: security-copilot, sfi-ga-nochange
ms.collection: msec-ai-copilot
---
# Conditional Access Optimization Agent Settings

The Conditional Access Optimization Agent helps organizations improve their security posture by analyzing Conditional Access policies for gaps, overlap, and exceptions. As Conditional Access becomes a central component of an organization's Zero Trust strategy, the capabilities of the agent must be configurable to meet the unique needs of each organization.

The agent settings described in this article cover standard options like triggers, notifications, and scope. But the settings also include advanced options like custom instructions, Intune integrations, and permissions.

## How to configure agent settings

You can access the settings from two places in the Microsoft Entra admin center:

- From **Agents** > **Conditional Access optimization agent** > **Settings**.
- From **Conditional Access** > select the **Conditional Access optimization agent** card under **Policy summary** > **Settings**.

:::image type="content" source="media/conditional-access-agent-optimization/agent-settings.png" alt-text="Screenshot of the trigger option in the Conditional Access Optimization agent settings." lightbox="media/conditional-access-agent-optimization/agent-settings.png":::

After making any changes, select the **Save** button at the bottom of the page. 

## Trigger

The agent is configured to run every 24 hours based on when it's initially configured. You can change when the agent runs by toggling the **Trigger** setting off and then back on when you want it to run.

## Microsoft Entra objects to monitor

Use the checkboxes under **Microsoft Entra objects to monitor** to specify what the agent should monitor when making policy recommendations. By default the agent looks for both new users and applications in your tenant over the previous 24 hour period.

## Agent capabilities

By default, the Conditional Access optimization agent can create new policies *in report-only mode*. You can change this setting so that an administrator must approve the new policy before it's created. The policy is still created in report-only mode, but only after admin approval. After reviewing the policy impact, you can turn on the policy directly from the agent experience or from Conditional Access.

## Notifications

As part of a preview capability, the Conditional Access optimization agent can send notifications through Microsoft Teams to a select set of recipients. With the **Conditional Access agent** app in Microsoft Teams, recipients receive notifications directly in their Teams chat when the agent surfaces a new suggestion.

To add the agent app to Microsoft Teams:

1. In Microsoft Teams, select **Apps** from the left navigation menu and search for and select the **Conditional Access agent**.

   :::image type="content" source="media/conditional-access-agent-optimization/agent-teams-app.png" alt-text="Screenshot of the Conditional Access app button in Teams." lightbox="media/conditional-access-agent-optimization/agent-teams-app.png":::

1. Select the **Add** button, then select the **Open** button to open the app.
1. To make accessing the app easier, right-click the app icon in the left navigation menu and select **Pin**.

To configure notifications in the Conditional Access optimization agent settings:

1. In the Conditional Access optimization agent settings, select the **Select users and groups** link.
1. Select the users or groups you want to receive notifications, then select the **Select** button.
 
   :::image type="content" source="media/conditional-access-agent-optimization/agent-teams-people-picker.png" alt-text="Screenshot of the Conditional Access agent setting to pick the users and groups for notifications." lightbox="media/conditional-access-agent-optimization/agent-teams-people-picker.png":::

1. At the bottom of the main **Settings** page, select the **Save** button.

You can select up to 10 recipients to receive notifications. You can select a group to receive the notifications, but the membership of that group can't exceed 10 users. If you select a group that has fewer than 10 users but more are added later, the group no longer receives notifications. Similarly, the notifications can only be sent to five objects, such as a combination of individual users or groups. To stop receiving notifications, remove your user object or the group you're included in from the recipient's list. 

At this time, the agent's communication is one direction, so you can receive notifications but can't respond to them in Microsoft Teams. To take action on a suggestion, select **Review suggestion** from the chat to open the Conditional Access optimization agent in the Microsoft Entra admin center.

   :::image type="content" source="media/conditional-access-agent-optimization/agent-teams-suggestion-message.png" alt-text="Screenshot of the Conditional Access agent notification message in Teams." lightbox="media/conditional-access-agent-optimization/agent-teams-suggestion-message.png":::

## Phased rollout

When the agent creates a new policy in report-only mode, the policy is rolled out in phases, so you can monitor the effect of the new policy. Phased rollout is on by default.

You can change the number of days between each phase by either dragging the slider or entering a number in the text box. The number of days between each phase is the same for all phases. Make sure you're starting the phased rollout with enough time to monitor the impact before the next phase starts and so the rollout doesn't start on a weekend or holiday, in case you need to pause the rollout.

:::image type="content" source="media/conditional-access-agent-optimization/phased-rollout-settings.png" alt-text="Screenshot of the phased rollout settings in the Conditional Access Optimization agent settings." lightbox="media/conditional-access-agent-optimization/phased-rollout-settings.png":::

## Identity and permissions

This section of the agent settings describes the identity under which the agent runs and the permissions it requires to operate effectively. 

### Identity

The Conditional Access Optimization Agent now supports [Microsoft Entra Agent ID](../agent-id/identity-professional/microsoft-entra-agent-identities-for-ai-agents.md), allowing the agent to run under its own identity rather than a specific user’s identity. This capability improves security, simplifies management, and provides greater flexibility.

- New installations of the agent default to use an [agent identity](../agent-id/identity-platform/what-is-agent-id.md).
- Existing installations can switch from the user context to run under an agent identity at any time. 
  - This change does not impact reporting or analytics.
  - Existing policies and recommendations remain unaffected.
  - Customers can't switch back to user context.
  - Admins with the Security Administrator or Global Administrator roles can make this change. Select **Create agent identity** from either the banner message on the agent page or the **Identity and permissions** section of the agent settings.

:::image type="content" source="media/conditional-access-agent-optimization/identity-permissions.png" alt-text="Screenshot conditional-access-agent-optimization/identity-permissions.png":::

Turning on and using the Conditional Access Optimization Agent also requires Security Copilot roles. Security Administrator has access to Security Copilot by default. You can assign Conditional Access Administrators with Security Copilot access. This authorization gives your Conditional Access Administrators the ability to use the agent as well. For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).

### Permissions

The agent identity uses the following permissions to perform its tasks. These permissions are assigned automatically when you create the agent identity.

`AuditLog.Read.All`
`CustomSecAttributeAssignment.Read.All`
`DeviceManagementApps.Read.All`
`DeviceManagementConfiguration.Read.All`
`GroupMember.Read.All`
`LicenseAssignment.Read.All`
`NetworkAccess.Read.All`
`Policy.Create.ConditionalAccessRO`
`Policy.Read.All`
`RoleManagement.Read.Directory`
`User.Read.All`

### ServiceNow integration (Preview)

Organizations that use the [ServiceNow plugin for Security Copilot](/copilot/security/plugin-servicenow) can now have the Conditional Access optimization agent create ServiceNow change requests for each new suggestion the agent generates. This allows IT and security teams to track, review, and approve or reject agent suggestions within existing ServiceNow workflows. At this time, only change requests (CHG) are supported.

To use the ServiceNow integration, your organization must have the [ServiceNow plugin](/copilot/security/plugin-servicenow) configured.

:::image type="content" source="media/conditional-access-agent-optimization/agent-service-now-integration-setting.png" alt-text="Screenshot of the ServiceNow integration settings." lightbox="media/conditional-access-agent-optimization/agent-service-now-integration-setting.png":::

When the ServiceNow plugin is turned on in the Conditional Access optimization agent settings, each new suggestion from the agent creates a ServiceNow change request. The change request includes details about the suggestion, such as the type of policy, the users or groups affected, and the rationale behind the recommendation. The integration also provides a feedback loop: The agent monitors the state of the ServiceNow change request and can automatically implement the change when the change request is approved.

:::image type="content" source="media/conditional-access-agent-optimization/agent-service-now-integration-ticket.png" alt-text="Screenshot of the ServiceNow integration within an agent suggestion." lightbox="media/conditional-access-agent-optimization/agent-service-now-integration-ticket.png":::

### Custom instructions

You can tailor the policy to your needs using the optional **Custom Instructions** field. This setting allows you to provide a prompt to the agent as part of its execution. These instructions can be used to:

- Include or exclude specific users, groups, and roles
- Exclude objects from being considered by the agent or added to the Conditional Access policy 
- Apply exceptions to specific policies, such as excluding a specific group from a policy, requiring MFA, or requiring mobile application management policies. 

You can enter either the name or the object ID in the custom instructions. Both values are validated. If you add the name of the group, the object ID for that group is automatically added on your behalf. Example custom instructions:

- "Exclude users in the "Break Glass" group from any policy that requires multifactor authentication."
- "Exclude user with Object ID dddddddd-3333-4444-5555-eeeeeeeeeeee from all policies"

A common scenario to consider is if your organization has lots of guest users that you don't want the agent to suggest adding to your standard Conditional Access policies. If the agent runs and sees new guest users that aren't covered by recommended policies, SCUs are consumed to suggest covering those guest users by policies that aren't necessary. To prevent guest users from being considered by the agent:

1. Create a dynamic group called "Guests" where `(user.userType -eq "guest")`.
1. Add a custom instruction, based on your needs.
    - "Exclude the "Guests" group from agent consideration."
    - "Exclude the "Guests" group from any mobile application management policies."

For more information about how to use custom instructions, check out the following video. 

> [!VIDEO 5879a0f7-3644-4e34-a8ce-b186b8e5f128]

Please note that some of the content in the video, such as the user interface elements, is subject to change as the agent is updated frequently.

## Intune integration

The Conditional Access Optimization Agent integrates with Microsoft Intune to monitor device compliance and application protection policies configured in Intune and identify potential gaps in Conditional Access enforcement. This proactive and automated approach ensures that Conditional Access policies remain aligned with organizational security goals and compliance requirements. The agent suggestions are the same as the other policy suggestions, except that Intune provides part of the signal to the agent.

Agent suggestions for Intune scenarios cover specific user groups and platforms (iOS or Android). For example, the agent identifies an active Intune app protection policy that targets the "Finance" group, but determines there isn't a sufficient Conditional Access policy that enforces app protection. The agent creates a report-only policy that requires users to access resources only through compliant applications on iOS devices.

To identify Intune device compliance and app protection policies, the agent must be running as a Global Administrator or Conditional Access Administrator AND Global Reader. Conditional Access Administrator isn't sufficient on its own for the agent to produce Intune suggestions.

## Global Secure Access integration

Microsoft Entra Internet Access and Microsoft Entra Private Access (collectively known as Global Secure Access) integrate with the Conditional Access Optimization Agent to provide suggestions specific to your organization's network access policies. The suggestion, **Turn on new policy to enforce Global Secure Access network access requirements**, helps you to align your Global Secure Access policies that include network locations and protected applications.

With this integration, the agent identifies users or groups that aren't covered by a Conditional Access policy to require access to corporate resources only through approved Global Secure Access channels. This policy requires users to connect to corporate resources using the organization's secure Global Secure Access network before accessing corporate apps and data. Users connecting from unmanaged or untrusted networks are prompted to use the Global Secure Access client or web gateway. You can review sign-in logs to verify compliant connections.
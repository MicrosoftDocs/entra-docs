---
title: Create remediation plans for risky apps
description: Learn how to create safe batch removal plans for unused high-privileged applications using customizable criteria and monitoring workflows.
ms.author: jomondi
author: omondiatieno
manager: mwongerapk
ms.date: 11/04/2025
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.reviewer: ariels
#customer intent: As an IT administrator, I want to execute large-scale application cleanup initiatives using controlled batch processes so that I can minimize business disruption while maintaining operational safety.
---

# Create remediation plans for risky apps

The App lifecycle management agent creates safe batch displacement plans for unused applications with high-privilege permissions. These plans use staged processes with owner engagement, admin approval, and impact monitoring to reduce your organization's attack surface while maintaining operational stability.

## Prerequisites

Before creating remediation plans, ensure you have:

- At least one of the following Microsoft Entra roles:
  - [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
  - [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)
  - [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator)
- Microsoft Entra ID P2 or Workload Identity Premium P2 license
- Provisioned Security Copilot SCUs (Security Compute Units)
- Completed unused app identification and owner communication workflows

## How batch remediation works

The agent follows Safe Deployment Practice (SDP) principles through staged processes that prioritize safety and reversibility. The process begins with detection & validation, where the agent identifies unused apps and applies any configured exclusions. This is followed by owner engagement, during which the agent collects decisions and reactive exceptions from application owners.

The agent then moves to the review & plan phase, where it reviews dispositioned apps and creates a safe disablement plan. During execution with monitoring, apps are disabled in carefully sized batches with continuous impact monitoring. Finally, the process maintains full reversibility, ensuring that disablement can be reversed as needed by administrators if business impact is detected.

The agent creates remediation plans using recommended batch criteria to balance security outcomes with operational risk and allows customization with AI to meet organizational needs

## Default batch criteria

The agent uses five default batch types prioritized by risk and owner consent:

| Batch                         | Criteria                                                  | Typical size     | Purpose                                                          |
|-------------------------------|-----------------------------------------------------------|------------------|------------------------------------------------------------------|
| Batch 1 | Unused + High Privileged + Approved by App Owner to Disable | Five applications   | Removes the highest risk applications with explicit owner approval |
| Batch 2 | Unused + High Privileged + Notified with No Exception from App Owner     | 10 applications  | Addresses high-privilege apps where owners haven't requested exceptions after notification |
| Batch 3 | Unused + Not High Privileged + Approved by App Owner to Disable | 15 applications  | Removes unused apps with owner consent regardless of privilege level |
| Batch 4 | Unused + Not High Privileged + Notified App Owner | 15 applications  | Removes unused apps with any notification to app owner |
| Batch 5 | Unused + No App Owner + Not Notified | 15 applications  | Removes unused apps with no app owner and no notification |


The maximum batch size is 15 applications, with highest privilege apps and those with owner approval in earlier batches.

## Create remediation plans

To create a batch removal plan for unused applications:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator)
1. Browse to **Agents** in the left menu
1. Navigate to the unused app suggestions in the agent dashboard
1. Select the remediation plan option for batch removal
1. Review the automatically generated batch recommendations
1. The agent displays each batch with:
   - Batch criteria summary
   - Number of applications included
   - Justification for batch selection

     
### Customize batch criteria

You can modify the default batch criteria using natural language instructions. This allows the agent to adapt the batching logic to your organization's specific needs and risk preferences. This step consumes SCUs because it uses AI capabilities to interpret and apply your custom instructions.

:::image type="content" source="media/agent-app-lifecycle-remediation-plans/customize-disablement-plan.png" alt-text="Screenshot showing the interface for customizing batch disablement criteria using natural language instructions" lightbox="media/agent-app-lifecycle-remediation-plans/customize-disablement-plan.png":::

To customize batch criteria:

1. Navigate to the **Customize with AI** section of the remediation plan
1. Enter natural language instructions to modify batch behavior
    Example customization prompts:
    - "Prioritize removal of apps with one or less owners"  
    - "Deprioritize apps to later batches that have 'Production' or 'Prod' in the application name"
    - "Include apps with no owners or no high privileged permissions"
    - "Only include apps that have been contacted by the agent"
1. Select **Save** to apply the custom instructions
1. Review the updated batch plan to see how criteria changes affect app groupings

The agent generates a dynamic batch description that updates based on your custom instructions, providing transparency about the selection logic.

## Execute batch disablement plans

Once you've configured the batch criteria, you can begin the staged disablement process.

### Admin approval workflow

Before any applications are disabled, the agent requires explicit administrative approval:

1. Review the complete batch disablement plan
1. Verify the applications included in each batch by selecting **Edit** next to a batch
1. Decide which apps you would like to disable in the batch and which apps you might want to move to another batch or dismiss altogether
1. Select **Disable apps** to authorize the removal process

    :::image type="content" source="media/agent-app-lifecycle-remediation-plans/disablement-plan-show-batch.png" alt-text="Screenshot showing the batch disablement plan interface with batch details and approval options" lightbox="media/agent-app-lifecycle-remediation-plans/disablement-plan-show-batch.png":::

The agent maintains detailed audit trails for all approval decisions and batch modifications.

### Batch execution process

During batch execution, the agent processes batches sequentially, ensuring each batch completes before the next begins. The agent continuously monitors for impact by tracking disabled applications and any re-enablement actions by app owners or administrators. 

Throughout the process, the agent provides progress visibility by showing metrics for each batch, including applications successfully disabled, applications re-enabled due to business impact, and any errors or issues encountered during the disablement process.

### Monitor and control execution

App disablement and re-enablement via the agent is executed by the Microsoft Graph API to the `isDisabled` property on the application object. For information about the API, see [application resource type](/graph/api/resources/application).

Throughout the batch removal process, you have several control and monitoring options available. After disablement has taken place, you can view all disabled applications at the top of the batch disablement plan and re-enable applications, as needed. This is useful if you detect unexpected business impact or need to reassess the disablement strategy, coordinating with app owners and business users.

You can also edit batch contents by moving applications between batches or removing them from the plan entirely by dismissing them before execution of disablement. This flexibility allows you to adjust the remediation approach based on real-time feedback or changing business requirements.

### Reversibility and rollback

We support individual app re-enablement. Navigate to the **View disabled apps** button at top of the plan for a list of disabled applications and select **Re-enable** to restore specific apps.

:::image type="content" source="media/agent-app-lifecycle-remediation-plans/view-disabled-enable-apps.png" alt-text="Screenshot showing the interface for viewing disabled applications and re-enabling them." lightbox="media/agent-app-lifecycle-remediation-plans/view-disabled-enable-apps.png":::

## Related content

- [Identify and prioritize risky apps](agent-identify-prioritize-risky-apps.md)
- [Learn about Microsoft Entra application management](what-is-application-management.md)
- [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)

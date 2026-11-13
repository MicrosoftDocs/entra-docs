---
title: Configuration deployments (Preview)
description: Learn how configuration deployments apply baseline settings to home and governed tenants in Microsoft Entra Tenant Governance.
ms.topic: concept-article
ms.date: 11/12/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to understand deployments so that I can apply approved configuration and handle failures.
---

# Configuration deployments (Preview)

A configuration deployment applies baseline-defined settings to a target tenant. Use Configuration deployments to apply baseline-defined configuration to the home tenant or governed tenants.

Use deployments to roll out approved settings, establish a known-good configuration, or apply controlled changes. Unlike a monitor, which evaluates configuration, a deployment changes resource settings.

The deployment list shows the source template, target tenant, and status for each deployment.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-deployments.png" alt-text="Screenshot of configuration deployments with source templates, target tenants, and statuses." lightbox="../media/tenant-governance-configuration-management/configuration-deployments.png":::

## Supported resources

Configuration deployments currently support only the following 23 resource types: 15 Microsoft Entra resources and 8 Exchange resources. This list doesn't apply to resource support for snapshots or monitoring.

### Microsoft Entra resources (15)

- `microsoft.entra.conditionalaccesspolicy`
- `microsoft.entra.namedlocationpolicy`
- `microsoft.entra.authorizationpolicy`
- `microsoft.entra.authenticationmethodpolicy`
- `microsoft.entra.authenticationmethodpolicyemail`
- `microsoft.entra.authenticationmethodpolicyfido2`
- `microsoft.entra.authenticationmethodpolicysms`
- `microsoft.entra.authenticationmethodpolicyvoice`
- `microsoft.entra.authenticationmethodpolicyx509`
- `microsoft.entra.crosstenantaccesspolicyconfigurationdefault`
- `microsoft.entra.crosstenantaccesspolicyconfigurationpartner`
- `microsoft.entra.externalidentitypolicy`
- `microsoft.entra.roledefinition`
- `microsoft.entra.securitydefaults`
- `microsoft.entra.tenantdetails`

### Exchange resources (8)

- `microsoft.exchange.accepteddomain`
- `microsoft.exchange.antiphishpolicy`
- `microsoft.exchange.casmailboxplan`
- `microsoft.exchange.hostedcontentfilterpolicy`
- `microsoft.exchange.mailboxplan`
- `microsoft.exchange.malwarefilterpolicy`
- `microsoft.exchange.owamailboxpolicy`
- `microsoft.exchange.safelinkspolicy`

## Baseline and target tenant

Create a deployment from baseline JSON, a snapshot, or a configuration baseline template. Review the resource properties and dependencies before applying the baseline.

Configuration management supports operations in the home tenant and in other tenants that are connected through governance relationships. For a governed tenant, verify the active relationship, delegated access, and workload permissions. A relationship alone doesn't grant permission to change every resource.

## Deployment status

A deployment is asynchronous. Use its status and resource-level results to determine the outcome.

The deployment list displays **Running** or **Completed**. These lifecycle states don't describe whether every resource was applied successfully. Review the run outcome on **Deployment results**, and use **Resource deployment failures** to inspect errors.

| Execution outcome | Meaning | Next action |
| --- | --- | --- |
| **In progress** | The deployment is applying configuration. | Wait for completion and review available resource outcomes. |
| **Successful** | The execution reports successful completion. | Use a monitor to validate alignment with the baseline. |
| **Partially successful** | Some configuration changes succeeded and others didn't. | Review each failed resource and resolve its error before retrying. |
| **Failed** | The deployment didn't complete successfully. | Review errors and actual resource state before planning another deployment. |

Don't treat a failed or partially successful deployment as proof that no settings changed. Inspect resource outcomes and the target tenant before retrying. Don't assume that deployment failure rolls back successful changes.

The following details view illustrates a partially successful deployment and its baseline version.

:::image type="content" source="../media/tenant-governance-configuration-management/configuration-deployment-details.png" alt-text="Screenshot of deployment details with the template version and a partial-success status." lightbox="../media/tenant-governance-configuration-management/configuration-deployment-details.png":::

## Validate after deployment

Create or update a monitor for the deployed baseline and target tenant. A successful monitor evaluation provides evidence that the actual configuration aligns with the expected values. Later monitor runs detect changes after deployment.

On **Ongoing monitoring** in the deployment wizard, select **Yes** to create a separate monitor from the same configuration. If monitor creation fails, the deployment can still exist; review the warning and create the monitor separately.

Workload-specific systems remain the source of truth for the resource state.

## Related content

- [Create a configuration deployment](how-to-create-configuration-deployment.md).
- [Use configuration baseline templates](how-to-use-configuration-baseline-templates.md).
- [Configure configuration management service permissions](how-to-set-up-permissions-tenant-monitoring.md).
- [View monitor results and manage monitors](how-to-see-monitor-results.md).

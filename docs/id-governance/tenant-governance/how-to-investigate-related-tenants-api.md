---
title: Investigate related tenant signals by using Microsoft Graph (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to use Microsoft Graph to retrieve the underlying users and applications behind Tenant Governance related tenant discovery signals.
ms.topic: how-to
ms.date: 07/14/2026
---

# Investigate related tenant signals by using Microsoft Graph (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

Discovery signals for a related tenant are summarized as aggregated, order-of-magnitude metrics. To investigate a signal in depth, you can retrieve the underlying users and applications that contribute to it. The admin center exposes this as a [drill-down experience](how-to-interpret-discovery-data.md#step-4-drill-into-a-signal-to-see-the-underlying-entities). The same data is available programmatically through Microsoft Graph.

This article describes the workflow for investigating related tenant signals with Microsoft Graph. For the full request and response schema, see the Microsoft Graph API reference linked in [Related content](#related-content).

## Prerequisites

- A Microsoft Entra Tenant Governance license. For more information, see [Tenant Governance licensing](licensing.md).
- Related tenants must be enabled for your tenant. If it isn't enabled yet, call the [enableRelatedTenants](/graph/api/tenantgovernanceservices-tenantgovernancesetting-enablerelatedtenants?view=graph-rest-beta&preserve-view=true) action first.
- An appropriate Microsoft Graph permission:

  | Permission type | Least privileged permission |
  |---|---|
  | Delegated (work or school account) | `TenantGovernance-RelatedTenant.Read.All` |
  | Application | `TenantGovernance-RelatedTenant.Read.All` |

  Personal Microsoft accounts aren't supported.

- For delegated access, the signed-in user must have one of the following Microsoft Entra roles: **Tenant Governance Administrator**, **Global Reader**, or **Tenant Governance Reader**.

The related tenant discovery APIs are available in the Microsoft Graph **beta** endpoint.

## When to use investigation hints

Investigation hints let you move from an aggregated, order-of-magnitude metric to the specific users or applications behind it. Use them when you want to:

- Automate related tenant investigation as part of a security or governance workflow.
- Export the underlying users or applications behind a signal for reporting or ticketing.
- Correlate related tenant activity with other signals in your environment.

As with the [drill-down experience](how-to-interpret-discovery-data.md#step-4-drill-into-a-signal-to-see-the-underlying-entities), investigation hints return live data that can differ from the aggregated metric, and sign-in based signals are limited by your tenant's log retention period. For more information about interpreting these results, see [Interpret tenant discovery data](how-to-interpret-discovery-data.md).

## Step 1: List related tenants

Retrieve the related tenants for your tenant. Each related tenant returns its discovery metrics (such as `b2BRegistrationMetrics`, `b2BSignInActivityMetrics`, `appB2BSignInActivityMetrics`, `multiTenantApplicationMetrics`, and `billingMetrics`) expanded by default.

``` http
GET https://graph.microsoft.com/beta/directory/tenantGovernance/relatedTenants
```

Identify the related tenant (by its tenant ID in the `id` property) and the signal that you want to investigate.

## Step 2: Request investigation hints for a signal

Investigation hints aren't returned by default. To get them, read a related tenant and use a nested `$expand` on the metric relationship that you're investigating. For example, to get the investigation steps for the B2B sign-in signal:

``` http
GET https://graph.microsoft.com/beta/directory/tenantGovernance/relatedTenants/{relatedTenantId}?$expand=b2BSignInActivityMetrics($expand=investigationHints)
```

The `investigationHints` relationship returns an ordered collection of investigation steps. The following response is illustrative and shortened for readability.

``` json
{
  "b2BSignInActivityMetrics": {
    "investigationHints": [
      {
        "stepNumber": "1",
        "text": "Guidance that explains what this step reveals about the metric.",
        "actionUrl": {
          "displayName": "b2BSignInActivityMetrics.recent.inboundMonthlyTotalUsers§single§§$output",
          "url": "https://graph.microsoft.com/beta/..."
        }
      }
    ]
  }
}
```

## Step 3: Run the investigation steps

Each step is an [investigationActionStep](/graph/api/resources/tenantgovernanceservices-investigationactionstep?view=graph-rest-beta&preserve-view=true):

- **stepNumber**: The order to run the step in. Run steps in ascending order, because later steps can depend on the output of earlier steps.
- **text**: Human-readable guidance that describes what the step reveals.
- **actionUrl**: An [investigationActionUrl](/graph/api/resources/tenantgovernanceservices-investigationactionurl?view=graph-rest-beta&preserve-view=true) that identifies the follow-on Microsoft Graph or Azure Resource Manager (ARM) API to call:
  - **url**: A URL template to invoke. It can contain placeholders such as `{@id}`, `{startDate}`, `{endDate}`, or `{sourceDomain}` that you resolve from the related tenant, the caller context, or the output of an earlier step. The value can be empty for steps that only transform data returned by a previous step.
  - **displayName**: A machine-readable directive in the form `metricPath§operation§input§output` that describes how to run the step and how to chain its output into later steps.

Resolve the placeholders, call each step's `url` in ascending `stepNumber` order, and combine the results to reveal the underlying users or applications behind the metric.

## Related content

- [Interpret tenant discovery data](how-to-interpret-discovery-data.md)
- [Signals and metrics for tenant discovery](signals-metrics.md)
- [Related tenants in Tenant Governance](related-tenants.md)
- [List relatedTenants](/graph/api/tenantgovernanceservices-list-relatedtenants?view=graph-rest-beta&preserve-view=true)
- [investigationActionStep resource type](/graph/api/resources/tenantgovernanceservices-investigationactionstep?view=graph-rest-beta&preserve-view=true)
- [investigationActionUrl resource type](/graph/api/resources/tenantgovernanceservices-investigationactionurl?view=graph-rest-beta&preserve-view=true)

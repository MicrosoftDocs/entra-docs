---
title: Analyze Microsoft Entra resource policy evaluation audit logs (preview)
description: Retrieve evaluation audit events through Microsoft Graph to troubleshoot policies and assess assignment impact before enabling enforcement.
ms.topic: how-to
ms.date: 11/12/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to inspect evaluation audit events through Microsoft Graph so that I can troubleshoot policies and decide when to enforce them.
---

# Analyze Microsoft Entra resource policy evaluation audit logs (preview)

Use [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to investigate a policy decision or identify applications affected by an assignment. You don't need diagnostic export or a Log Analytics workspace to retrieve these events. Logs describe evaluated requests, not the compliance of every preexisting resource.

## Prerequisites

- A tenant where resource policy preview is available. For assignment-impact queries, record the assignment's unique name. See [resource policy licensing requirements](licensing.md#resource-policy-preview).
- A work or school account in the target tenant with an active [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) role.
- [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), signed in to that tenant with the same account, with admin consent for the delegated `AuditLog.Read.All` permission.
- Representative traffic after assignment changes propagate.

Personal Microsoft accounts aren't supported. `ResourcePolicyEvaluation.Read.All`, used to test policies, doesn't grant access to audit events.

If your role is eligible through Privileged Identity Management (PIM), activate it before signing in to Graph Explorer.

## Retrieve evaluation audit events

Use evaluation audit events to investigate an individual request.

By default, queries return events from the past 24 hours. Filter on `evaluatedDateTime` to specify a different window. The examples use `ge` and `le` to include both the start and end times.

1. Sign in to Graph Explorer with the account described in [Prerequisites](#prerequisites), and select **GET** and **beta**.
1. Record the operation's UTC time and response `request-id` or the `client-request-id` you supplied.
1. Filter on `requestId` to retrieve the matching event and its policy details. Replace the placeholder with the recorded identifier and the timestamps with a UTC window that includes the operation:

    ```http
    GET https://graph.microsoft.com/beta/auditLogs/resourcePolicy?$filter=requestId eq '{request-id-or-client-request-id}' and evaluatedDateTime ge 2026-11-06T09:00:00Z and evaluatedDateTime le 2026-11-06T18:00:00Z&$select=id,requestId,appId,evaluatedDateTime,policyDecision,policyDetails
    ```

1. Select **Run query**. In **Response preview**, review `policyDecision` and the matching assignment in `policyDetails`. Check the policy version, `policyMessage`, and any loading or evaluation errors.

`policyDecision` describes the overall request: `deny` means blocked, `compliant` means no violations or errors were found, and `none` means nonblocking noncompliance or errors. A successful request doesn't prove policy compliance.

If no event appears, allow for logging delay and check the time window, tenant, assignment propagation, and read permissions. For error investigation, see [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).

## Assess assignment impact from evaluation events

Keep a new assignment in report-only mode while assessing it. For a version update, leave the old assignment enforced and follow [Roll out the new version](resource-policy-lifecycle.md#roll-out-the-new-version).

1. Record the new assignment's unique name and introduction time. Choose an end time that covers representative traffic after [assignment changes take effect](resource-policy-evaluation.md#assignment-propagation).
1. In Graph Explorer, use **GET** and **beta** to query the assignment's events. Replace the assignment name and timestamps with your observation window:

    ```http
    GET https://graph.microsoft.com/beta/auditLogs/resourcePolicy?$select=id,appId,evaluatedDateTime,policyDecision,policyDetails&$filter=policyDetails/any(c:c/assignmentUniqueName eq '{unique-assignment-name}') and evaluatedDateTime ge 2026-11-06T09:00:00Z and evaluatedDateTime le 2026-11-06T18:00:00Z&$count=true
    ```

1. Select **Run query**. Follow `@odata.nextLink` if returned to retrieve the remaining pages.
1. Use `appId` to identify caller applications. In each event, review the selected assignment's version, `isApplicable`, `isCompliant`, `policyMessage`, and errors. An applicable, noncompliant result without errors indicates a violation; investigate errors separately.
1. Work with application owners to update their applications or plan supported temporary exceptions. Repeat the query after changes, and follow [safe deployment](resource-policy-safe-deployment.md) before enabling enforcement.

Don't filter report-only assessment to `policyDecision eq 'deny'`: that would exclude nonblocking violations. An overall deny can come from another enforced assignment. Missing events or incomplete details don't prove compliance.

The examples show spaces for readability. URL-encode query values when sending requests.

## Optional diagnostic export

For custom KQL queries, archival, or integration with other monitoring systems, see [Export resource policy logs](resource-policy-export-logs.md). Export is optional and isn't required for Graph access.

## Protect evaluation data

Limit access to evaluation events and follow your organization's retention requirements. Policy messages and request context can contain sensitive information.

## Related content

- [Quickstart: Assign a built-in resource policy](resource-policy-quickstart-portal.md).
- [How resource policy evaluation works](resource-policy-evaluation.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
- [Export resource policy logs](resource-policy-export-logs.md).

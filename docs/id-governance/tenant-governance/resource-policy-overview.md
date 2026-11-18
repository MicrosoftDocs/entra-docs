---
title: What is Microsoft Entra resource policy (preview)?
description: Learn how Microsoft Entra resource policy evaluates Microsoft Graph requests to help prevent noncompliant resource configuration changes.
ms.topic: overview
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to understand resource policy so that I can prevent configuration changes that don't meet my organization's requirements.
---

# What is Microsoft Entra resource policy (preview)?

Microsoft Entra resource policy helps you prevent configuration changes that don't meet your organization's requirements. You assign policies in your tenant, and the service evaluates matching Microsoft Graph requests before the requested changes occur.

Resource policy is a feature of Microsoft Entra Tenant Governance. You can adopt it in an individual tenant without enabling related tenant discovery or establishing a governance relationship.

## Prevent noncompliant changes

Use resource policy to express configuration requirements for [supported resource types and actions](resource-policy-supported-resources.md). For example, a policy can evaluate a resource name or restrict a configuration value.

A policy assignment controls how the service handles a noncompliant request:

- In `doNotEnforce` mode, the policy evaluates the request and records the result without blocking it.
- In `enforce` mode, a noncompliant result can block the request and return a policy-specific explanation.

Another assignment in `enforce` mode can still block a request evaluated in `doNotEnforce` mode.

Resource policy evaluates matching requests. Assigning a policy doesn't automatically scan or remediate preexisting resources, and it doesn't replace the permissions required to perform a Microsoft Graph operation.

## Start with a built-in policy

Built-in policies let you apply predefined requirements without writing policy code. Select a policy, supply its required parameters, and assign it in your tenant.

Start with the [built-in policy quickstart](resource-policy-quickstart-portal.md) to assign and test a policy with simulated requests. Then follow the [tutorial to observe and enforce the policy](resource-policy-tutorial-portal.md) with real requests. Assess its impact in `doNotEnforce` mode before you enforce it.

## Author a custom policy

If a built-in policy doesn't meet your needs, author a custom policy in Rego, the declarative policy language used by Open Policy Agent. Define which requests the policy evaluates and the requirements they must meet.

The policy's `deny` rule identifies noncompliance. The assignment's enforcement mode determines whether that result blocks the request.

Learn about [resource policy parameters](resource-policy-parameters.md), [authoring with Rego](resource-policy-rego.md), and [managing policy versions](resource-policy-lifecycle.md).

## Choose a management method

Use the management method that fits your workflow.

| Method | Use |
| --- | --- |
| Microsoft Entra admin center | Discover policies and manage definitions and assignments through the [admin center experience](resource-policy-manage-portal.md). |
| Microsoft Graph REST APIs | Integrate policy management, simulated evaluation, and evaluation audit-log retrieval with your tools. |

Keep Rego, tests, and assignment configuration in source control for review and repeatable API-based management.

## Assess impact before enforcement

Use simulated evaluations to test policy behavior without performing the requested write. Then use `doNotEnforce` assignments and the Microsoft Graph policy evaluation audit-log API to understand the impact on real requests. Inspect per-assignment results to identify noncompliance, affected applications and operations, and evaluation errors.

The preview provides evaluation audit events, not service-generated aggregated impact reports. Diagnostic settings aren't required to retrieve events through Microsoft Graph. For the assessment workflow and optional custom analysis, see [Analyze resource policy evaluation audit logs](resource-policy-logs.md).

Follow [safe assignment deployment practices](resource-policy-safe-deployment.md) before enabling enforcement.

## Compare Tenant Governance features

Tenant Governance features address different parts of your governance workflow.

| Feature | Purpose |
| --- | --- |
| Related tenants | Discover tenants with observable relationships to your tenant. |
| Governance relationships | Establish approved cross-tenant administrative access. |
| Configuration management | Compare existing resource configuration with a baseline and report drift. |
| Resource policy | Evaluate matching requests and help prevent noncompliant configuration changes. |
| Secure tenant creation | Create add-on tenants with governance and recovery capabilities. |

Use [configuration management](configuration-management.md) to detect configuration drift and resource policy to help prevent supported changes that would introduce noncompliance. Their supported resources and permissions aren't necessarily the same.

## Licensing and availability

Most resource policy operations during preview require a Microsoft Entra ID Governance service plan. See [Tenant Governance licensing](licensing.md#resource-policy-preview) for requirements and exceptions.

## Related content

- [Resource policy concepts](resource-policy-concepts.md).
- [How resource policy evaluation works](resource-policy-evaluation.md).
- [Quickstart: Assign a built-in resource policy](resource-policy-quickstart-portal.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).

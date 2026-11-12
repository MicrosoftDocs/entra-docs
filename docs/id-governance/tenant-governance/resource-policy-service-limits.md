---
title: Microsoft Entra resource policy service limits (preview)
description: Review limits for resource policy definitions, assignments, Rego built-ins, request evaluation, additional reads, version history, and API requests.
ms.topic: reference
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a policy administrator, I want to understand service limits so that I can plan policy assignments and keep evaluation within supported capacity.
---

# Microsoft Entra resource policy service limits (preview)

Resource policy limits apply to policy objects, policy content, request evaluation, and API request rates. Keep your policies and additional Microsoft Graph reads within the limits below.

## Definitions, assignments, and content

| Scope | Limit | Value | Details |
| --- | --- | --- | --- |
| Resource type | Custom definition versions | 25. | Includes current and previous versions. Built-in definitions don't count. Creating or restoring a version that would exceed the limit returns HTTP 400. |
| Tenant | Custom definition versions | 1,000. | Soft-deleted versions don't count, but restoring them checks the quotas again. The definition collection's `$count` counts definitions, not individual versions. Exceeding the limit returns HTTP 400. |
| Resource type | Policy assignments | 25. | Includes assignments to built-in and custom policies, even when disabled. Exceeding the limit returns HTTP 400. |
| Tenant | Policy assignments | 1,000. | Includes disabled assignments and assignments to built-in policies. Soft-deleted assignments don't count, but restoring them checks the quotas again. Exceeding the limit returns HTTP 400. |
| Definition version | Live assignments per tenant | 1. | Disabling an assignment doesn't allow a second assignment. Update the existing assignment to change its settings. |
| Policy definition | Top-level Rego entries | 50. | Includes metadata and helper rule results. Policy validation returns HTTP 400 if exceeded. |
| Policy definition | Rego source size in UTF-8 | 1 MiB (1,048,576 bytes). | Oversized source returns HTTP 413. For line-formatting requirements, see [Format policy source](resource-policy-rego.md#format-policy-source). |
| Policy assignment | Serialized parameter values | 40 KiB (40,960 bytes). | Measured as compact UTF-8 JSON. Both submitted values and values after merging and applying defaults must fit. Exceeding the limit returns HTTP 413. |
| Policy assignment | Serialized assignment size | 50 KiB (51,200 bytes). | Measured as compact UTF-8 JSON. Applies to the complete assignment after an update, not just changed properties. Exceeding the limit returns HTTP 413. |
| Policy assignment evaluation | Distinct additional Microsoft Graph read paths | 2. | Covers both `applicable` and `deny` evaluations for one request. A different resource ID or query string counts as another path. See [Additional read limits](#additional-read-limits). |
| Policy assignment evaluation | `fetchAsPolicy()` invocations, including repeated paths | 5. | Every call counts, even when it reads the same path again. The count resets for each incoming request. |
| Request evaluation | Distinct additional-read paths across assignments | 10. | Shared across all assignments for one request. Reading the same path in multiple assignments counts once toward this limit. |
| Additional Microsoft Graph read | `relativePathUri` length | 2,048 characters. | Includes the API version, resource path, and query string. |
| Additional Microsoft Graph read | Response size | 100 KiB (102,400 bytes), by default. | Includes both `code` and `data` for live and simulated reads. Use `$select` to request only the properties your policy needs. |

## Disabled Rego built-in functions

Resource policy restricts the supported native Rego built-in functions. Only the functions listed here are permitted; all other native built-ins are disabled. For example, `time.now_ns` isn't permitted, including in metadata or helper rules.

| Category | Permitted native built-ins |
| --- | --- |
| Aggregates | `count`, `max`, `min`, `sort`, `sum` |
| Arrays | `array.concat`, `array.reverse`, `array.slice` |
| Sets | `intersection`, `union` |
| Numbers | `abs`, `ceil`, `floor`, `round`, `to_number` |
| Type checks | `is_array`, `is_boolean`, `is_null`, `is_number`, `is_object`, `is_set`, `is_string` |
| Bitwise operations | `bits.and`, `bits.lsh`, `bits.negate`, `bits.or`, `bits.rsh`, `bits.xor` |
| Strings | `concat`, `contains`, `endswith`, `indexof`, `lower`, `replace`, `split`, `sprintf`, `startswith`, `strings.reverse`, `substring`, `trim`, `trim_left`, `trim_prefix`, `trim_right`, `trim_space`, `trim_suffix`, `upper` |
| Objects | `object.filter`, `object.get`, `object.keys`, `object.remove`, `object.union` |
| URL encoding and UUID parsing | `urlquery.encode`, `urlquery.decode`, `uuid.parse` |

Use the exact names and casing shown.

Calls to disallowed native built-ins cause policy validation or loading errors, not a policy-compliance result. Replace those calls with permitted functions and [test the policy](resource-policy-test-troubleshoot.md) before assigning it.

Service-provided functions such as `fetchAsPolicy()` aren't native Rego built-ins. Their separate restrictions are described in [Additional read limits](#additional-read-limits).

## Additional read limits

Each assignment can read two distinct `relativePathUri` values per incoming request, across its `applicable` and `deny` rules. A different API version, resource ID, or query string, including `$select`, counts as another path.

For example, reading `/v1.0/applications/<id>?$select=displayName` twice uses one distinct path but two invocations. Adding a read of another application uses the second path. A third distinct path causes that assignment's evaluation to fail. The limit counts requested URIs, not the number of objects returned by a collection read.

Across assignments, the same path counts once toward the request-wide limit of 10 paths. Each assignment still counts every invocation, including repeated paths, toward its five-call limit.

For an example that processes a read response, see [Read additional Microsoft Graph data](resource-policy-rego.md#read-additional-microsoft-graph-data).

## Version history and deleted items

A custom definition can have up to 10 previous versions, in addition to its current version. An update that would exceed this limit returns HTTP 400. Delete an unused previous version before publishing another update when the history limit is reached.

Soft-deleted definitions and assignments are retained for 30 days.

Individual previous-version deletion is permanent and doesn't use the soft-delete retention period.

For dependency handling, see [Update and retire resource policies](resource-policy-lifecycle.md).

## API request throttling

These limits apply to management and explicit evaluation requests under `/admin/resourcePolicy`, separately for each app and tenant combination.

| Request type | Preview limit per app per tenant | Equivalent sustained request rate |
| --- | --- | --- |
| Write policy definitions and assignments, or update configuration | 40 requests per 20 seconds | 2 requests per second |
| Read policy definitions, assignments, and configuration | 60 requests per 20 seconds | 3 requests per second |
| [evaluatePolicy](/graph/api/resourcepolicyroot-evaluatepolicy?view=graph-rest-beta&preserve-view=true) | 100 requests per 20 seconds | 5 requests per second |
| [evaluateAssignedPolicies](/graph/api/resourcepolicyroot-evaluateassignedpolicies?view=graph-rest-beta&preserve-view=true) | 60 requests per 20 seconds | 3 requests per second |

Automatic policy evaluation on ordinary Microsoft Graph write requests doesn't count toward these limits.

Throttled requests return HTTP 429. Wait for the interval in the `Retry-After` header before retrying. For more information, see [Microsoft Graph throttling guidance](/graph/throttling).

## Evaluation limits

| Scope | Limit | Value |
| --- | --- | --- |
| Request being evaluated | Real or simulated request body size | 2 MiB (2,097,152 bytes), by default. |
| `evaluatePolicy` | Simulated additional-read responses | 2. |
| `evaluatePolicy` | Combined serialized `data` values in simulated responses | 2 MiB (2,097,152 bytes). |

Keep request bodies within the size limit so your policies can evaluate them. For explicit evaluation actions, this limit applies to `resourceBody`, not the complete action payload.

If the body is too large, policy evaluation is skipped and enforced policies can still block the request. An explicit evaluation can still return HTTP 200, so check the response message, `isBlocked`, and policy error details.

Invalid simulated-response counts or oversized combined `data` values return HTTP 400. Correct the supplied responses and try again. Each simulated response must also fit within the [additional-read response limit](#additional-read-limits).

Use [evaluation audit logs](resource-policy-logs.md) to investigate errors on real requests.

## Related content

- [Supported resources and actions](resource-policy-supported-resources.md).
- [Author resource policies with Rego](resource-policy-rego.md).
- [Resource policy known issues](resource-policy-known-issues.md).

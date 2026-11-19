---
title: Microsoft Entra resource policy known issues (preview)
description: Understand resource policy assignment propagation and collect diagnostics for unexpected policy behavior.
ms.topic: reference
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to recognize known resource policy issues so that I can distinguish service limitations from configuration problems.
---

# Microsoft Entra resource policy known issues (preview)

Use this article with [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md) when policy management or request-time behavior differs from your expectations.

## Assignment changes aren't immediately reflected in requests

Assignment changes can take up to 10 minutes to affect incoming requests. Use `evaluateAssignedPolicies` to test saved settings without that delay, then wait for [assignment propagation](resource-policy-evaluation.md#assignment-propagation) before testing real requests again.

## Report an unexpected result

Collect the operation, approximate time, request correlation information, assignment reference, policy version, enforcement mode, and available evaluation error details. Remove secrets and unnecessary personal data before sharing diagnostic information.

## Related content

- [How resource policy evaluation works](resource-policy-evaluation.md).
- [Analyze resource policy evaluation audit logs](resource-policy-logs.md).
- [Resource policy service limits](resource-policy-service-limits.md).

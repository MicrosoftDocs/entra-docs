---
title: Troubleshoot user provisioning validation for Microsoft Entra App Gallery (preview)
description: Diagnose failed tests in the Azure Logic Apps validation template and fix common SCIM endpoint issues before you submit your gallery submission.
author: hsaini
manager: msteele
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: troubleshooting
ms.date: 08/26/2026
ms.author: hsaini
ms.reviewer: hsaini
ms.custom: enterprise-apps-article, msecd-doc-authoring-1023
ai-usage: ai-generated

# Customer intent: As an ISV application developer, I want to diagnose failed validation tests so that I can fix my SCIM endpoint and submit passing results for Microsoft Entra App Gallery.
---

# Troubleshoot user provisioning validation for Microsoft Entra App Gallery (preview)
When a test in the Azure Logic Apps validation template fails, the results tell you which phase and action broke, and the underlying HTTP response tells you why. This article shows you how to trace a failure to its root cause and fix the System for Cross-Domain Identity Management (SCIM) endpoint issues that come up most often.

Before you troubleshoot, confirm the failure actually blocks you. Some results are expected, and some failures are warnings that don't prevent onboarding. For the full list, see [Understand what passing means](validate-user-provisioning-app-gallery.md#understand-what-passing-means).

## Trace a failed test

Work from the results JSON outward. The `provisioningErrorDetails` field usually names the root cause on its own.

1. Open the `Final_TestResults` action in your `Orchestrator_Workflow` run, and then select **Show raw outputs**.

1. Find the failed test. The `testResult` value names the phase and the action that failed, as in this example.

    ```json
    {
      "testName": "Delete_Group_Test",
      "testResult": "FAILED - [Delete Phase] Failed Action: Delete_Step5_Delete_Group_By_Id",
      "provisioningErrorDetails": {
        "provisioningLogs": {
          "statusCode": 403,
          "body": {
            "error": {
              "code": "Authorization_RequestDenied",
              "message": "Insufficient privileges to complete the operation."
            }
          }
        }
      }
    }
    ```

    This result failed during the delete phase at `Delete_Step5_Delete_Group_By_Id`, and the 403 response shows the Logic App's managed identity is missing a permission.

1. Read `provisioningErrorDetails` for the HTTP status code and error message.

1. If you need more detail, select the `runLink` value to open the child workflow run.

1. In the workflow designer, use the search icon to find the failed action by name.

1. Select the action and compare **Inputs** with **Outputs**. The response body holds the exact error returned by Microsoft Graph or your SCIM endpoint.

If you used the SCIM onboarding agent, it performs these steps for you, reports the root cause, and reruns automatically after failures it can fix.

## Fix common failures

Most failures trace back to one of the following issues. Fix the underlying problem, and then rerun the tests.

### Requests fail when the endpoint URL includes a feature flag

Feature flags such as `aadOptscim062020` belong in the provisioning configuration, not in the Logic App parameters. When the flag appears in the `scimEndpoint` parameter, requests fail.

Remove the flag from the Logic App configuration. Set it only in **Enterprise applications** > your application > **Provisioning** > **Tenant URL**.

### Runs fail partway through with authentication errors

A full validation run takes 60–90 minutes, which is longer than many access tokens live. When the token expires mid-run, the remaining tests fail to authenticate.

Use a bearer token that stays valid for at least 24 hours.

### The Get_Templates action returns an unauthorized error

The Logic App's managed identity is missing permissions on the template resources.

Rerun the permissions script and allow a few minutes for the assignments to propagate. If the error persists, recreate the Logic App, and then reconfigure the managed identity and permissions.

### Filtered SCIM requests fail

Microsoft Entra ID issues SCIM `GET` requests filtered on any attribute configured as a matching property. If your endpoint doesn't support filtering on one of those attributes, the request fails and appears as an error in the provisioning logs.

Support filtered `GET` requests for every attribute configured as a matching property in **Provisioning** > **Attribute mappings**. For example, if `emails[type eq "work"].value` is a matching property, your endpoint must handle this request:

```http
GET /scim/v2/Users?filter=emails[type eq "work"].value eq "user@contoso.com"
```

### A test fails with a SCIM 409 Conflict error

The provisioning service retries an update when your SCIM service doesn't respond as expected, and the retry can produce a conflict.

Rerun the test to see whether the error is transient. If it repeats, check that your service responds correctly to update requests and doesn't delay its responses.

### A query for a nonexistent user fails

The SCIM specification allows a `404 Not Found` response for a user that doesn't exist, but the Microsoft Entra provisioning service doesn't support that behavior.

Return `200 OK` with zero results for filter-based queries that match no users, such as `totalResults: 0` with an empty `Resources` array. This behavior is a requirement for onboarding. For the full list, see [SCIM API requirements](app-gallery-user-provisioning-requirements.md#scim-api-requirements).

### The schema discoverability test fails

`Schema_Discoverability_Test` fails when your provisioning mappings include attributes that your SCIM schema doesn't advertise. The details show how many attributes are supported compared to how many are mapped.

Prune the attribute mappings so they match your endpoint. In your application, select **Provisioning** > **Mappings** > **Provision Users**, select **Show advanced options**, select **Edit attribute list**, and then remove the unsupported attributes.

### A test fails with a schema validation error

Your SCIM server restricts an attribute to a set of values, and the test user profile used a value outside that set.

Add the allowed values to the `defaultUserProperties` parameter. If your `/Schemas` endpoint publishes `canonicalValues`, the agent detects the restriction automatically.

### Group tests fail

Group provisioning is required for gallery onboarding. If your `/Schemas` endpoint doesn't publish a group schema, every group test fails rather than being skipped.

Implement a SCIM 2.0 group endpoint, including support for updating multiple group memberships with a single `PATCH` request.

### Requests fail with HTTP 429

Your endpoint is rate limiting the provisioning service.

Support at least 25 requests per second per tenant.

## Related content

- [Validate user provisioning for Microsoft Entra App Gallery](validate-user-provisioning-app-gallery.md)
- [User provisioning requirements for Microsoft Entra App Gallery](app-gallery-user-provisioning-requirements.md)
- [Known issues for application provisioning](~/identity/app-provisioning/known-issues.md?pivots=app-provisioning)

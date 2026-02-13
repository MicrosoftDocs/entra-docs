---
title: Apply security policies to remote network traffic
description: Learn how to apply security policies like web content filtering, threat intelligence, and cloud firewall to remote network traffic in Global Secure Access.
ms.topic: how-to
ms.date: 02/13/2026
ms.reviewer: abhijeetsinha
ai-usage: ai-assisted

# Customer intent: As an IT admin, I want to apply security policies to remote network traffic so that I can protect branch offices and remote locations without installing the client on individual devices.
---

# Apply security policies to remote network traffic

Global Secure Access enables you to apply comprehensive security policies to remote network traffic, providing consistent protection across your entire network perimeter. By leveraging the baseline security profile, you can enforce tenant-wide security controls on all remote networks without requiring Conditional Access policies.

This article explains how to configure and apply security policies to protect traffic from remote networks such as branch offices, retail locations, and other remote sites.

## Prerequisites

To apply security policies to remote network traffic, you must have:

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- Remote networks configured and connected to Global Secure Access. For more information, see [How to create a remote network](how-to-create-remote-networks.md).
- At least one security policy created (web content filtering, threat intelligence, TLS inspection, or cloud firewall).
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Understanding the baseline security profile

The baseline security profile is a special tenant-wide security profile that applies to all traffic routed through Global Secure Access, including both client-based and remote network traffic. Unlike user-specific security profiles that require Conditional Access policies, the baseline profile enforces policies at the tenant level by default.

Key characteristics of the baseline profile:

- **Automatic enforcement**: Applies to all traffic without requiring Conditional Access policy configuration.
- **Tenant-wide coverage**: Enforces policies on all remote network traffic automatically.
- **Lowest priority**: Operates at priority 65,000 in the policy stack, allowing user-specific profiles to override when needed.


For more information on security profile concepts, see [Understand Microsoft Entra Internet Access](concept-internet-access.md).    

## [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

Follow these steps to apply security policies to remote network traffic using the baseline profile.

### Step 1: Create or select a security policy

If you haven't already created a security policy, create one first:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** and select the type of policy you want to create, such as:
   - **Web content filtering policy**
   - **Threat intelligence policies**
   - **TLS inspection policies**
   - **Cloud firewall policies**
1. Select **Create policy** and configure your policy rules.
1. Save the policy.

### Step 2: Link the policy to the baseline profile

1. Browse to **Global Secure Access** > **Secure** > **Security profiles** > **Baseline profile**.
1. Select **Edit profile**.
1. In the **Link policies** view, select **Link a policy** > **Existing policy**.
1. Choose the policy type (web content filtering, threat intelligence, TLS inspection, or cloud firewall).
1. Select the policy you want to apply and assign it a priority.
1. Select **Add**.
1. Select **Save**.

> [!NOTE]
> The baseline security profile automatically applies to all traffic routed through Global Secure Access, including remote network traffic. No Conditional Access policy configuration is required.

## [Microsoft Graph API](#tab/microsoft-graph-api)

You can configure the baseline profile programmatically using Microsoft Graph network access APIs. For a complete tutorial on configuring Internet Access policies with Microsoft Graph, see [Configure Microsoft Entra Internet Access using Microsoft Graph APIs](/graph/tutorial-entra-internet-access).

### Prerequisites for API access

- Delegated permissions: **NetworkAccess.Read.All** and **NetworkAccess.ReadWrite.All**.
- An API client such as [Graph Explorer](https://aka.ms/ge).
- **Global Secure Access Administrator** role.

### Step 1: Retrieve the baseline profile ID

Get the ID of the baseline security profile.

#### Request

```http
GET https://graph.microsoft.com/beta/networkaccess/filteringProfiles
```

#### Response

```json
{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#networkaccess/filteringProfiles",
  "value": [
    {
      "id": "00001111-aaaa-2222-bbbb-3333cccc4444",
      "name": "Baseline Profile",
      "description": "Default baseline security profile",
      "priority": 65000,
      "state": "enabled",
      "version": "1.0.0",
      "createdDateTime": "2024-01-01T00:00:00Z",
      "lastModifiedDateTime": "2024-01-01T00:00:00Z"
    }
  ]
}
```

### Step 2: Create a security policy

Create the security policy you want to apply. This example creates a web content filtering policy.

#### Request

```http
POST https://graph.microsoft.com/beta/networkaccess/filteringPolicies
Content-type: application/json

{
  "name": "Block Social Media for Remote Networks",
  "policyRules": [
    {
      "@odata.type": "#microsoft.graph.networkaccess.webCategoryFilteringRule",
      "name": "Block Social Media",
      "ruleType": "webCategory",
      "destinations": [
        {
          "@odata.type": "#microsoft.graph.networkaccess.webCategory",
          "name": "SocialNetworking"
        }
      ]
    }
  ],
  "action": "block"
}
```

#### Response

```json
{
  "id": "cccccccc-2222-3333-4444-dddddddddddd",
  "name": "Block Social Media for Remote Networks",
  "description": null,
  "version": "1.0.0",
  "lastModifiedDateTime": "2024-02-11T18:10:28Z",
  "createdDateTime": "2024-02-11T18:10:27Z",
  "action": "block"
}
```

### Step 3: Link the policy to the baseline profile

Link your security policy to the baseline profile.

#### Request

```http
POST https://graph.microsoft.com/beta/networkaccess/filteringProfiles/{baseline-profile-id}/policies
Content-type: application/json

{
  "priority": 100,
  "state": "enabled",
  "@odata.type": "#microsoft.graph.networkaccess.filteringPolicyLink",
  "loggingState": "enabled",
  "policy": {
    "id": "cccccccc-2222-3333-4444-dddddddddddd",
    "@odata.type": "#microsoft.graph.networkaccess.filteringPolicy"
  }
}
```

#### Response

```json
{
  "id": "dddddddd-9999-0000-1111-eeeeeeeeeeee",
  "priority": 100,
  "state": "enabled",
  "version": "1.0.0",
  "loggingState": "enabled",
  "lastModifiedDateTime": "2024-02-11T18:31:32Z",
  "createdDateTime": "2024-02-11T18:31:32Z",
  "policy": {
    "@odata.type": "#microsoft.graph.networkaccess.filteringPolicy",
    "id": "cccccccc-2222-3333-4444-dddddddddddd",
    "name": "Block Social Media for Remote Networks",
    "description": null,
    "version": "1.0.0",
    "action": "block"
  }
}
```

---

## Verify policy enforcement

After configuring security policies for remote networks, verify that they're being enforced:

1. Browse to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Filter the logs by traffic from your remote networks by applying the **DeviceCategory** filter.
1. Verify that blocked traffic shows the appropriate action and policy information.
1. Check that allowed traffic flows through as expected.

> [!NOTE]
> Configuration changes to the baseline profile typically take effect within a few minutes. Monitor traffic logs to confirm policy enforcement.

## Policy priority and interaction

When both the baseline profile and user-specific security profiles are configured:

- User-specific profiles (linked to Conditional Access policies) are evaluated first and have higher priority.
- The baseline profile operates at the lowest priority (65,000) and provides a fallback policy.
- Policies within a profile are evaluated based on their assigned priority numbers (100 is highest priority).
- Once a policy matches and takes action (block/allow), policy evaluation stops.

This design allows you to:

- Apply broad tenant-wide policies via the baseline profile.
- Override baseline policies for specific users or groups using Conditional Access-linked profiles. User awareness is possible only through the Global Secure Access client. Non-client traffic coming through remote networks goes through the baseline profile.
- Ensure consistent protection for all remote network traffic while maintaining flexibility for exceptions.

## Related content

- [Understand remote network connectivity](concept-remote-network-connectivity.md)
- [Manage remote networks](how-to-manage-remote-networks.md)
- [How to configure web content filtering](how-to-configure-web-content-filtering.md)
- [Understand Microsoft Entra Internet Access](concept-internet-access.md)
- [Configure Microsoft Entra Internet Access using Microsoft Graph APIs](/graph/tutorial-entra-internet-access)

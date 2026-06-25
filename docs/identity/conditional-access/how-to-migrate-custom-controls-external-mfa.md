---
title: Migrate from custom controls to external MFA in Conditional Access
description: Learn how to migrate from custom controls to external multifactor authentication in Microsoft Entra Conditional Access.
ms.topic: how-to
ms.date: 05/19/2026
manager: pmwongera
ms.reviewer: akuloomba
ai-usage: ai-assisted
---

# Migrate from custom controls to external multifactor authentication

External multifactor authentication (MFA) lets users choose an external provider to meet MFA requirements when they sign in with a work or school account. Custom controls in Microsoft Entra Conditional Access previously provided similar functionality, but with the general availability of external MFA (previously known as external authentication methods), custom controls are deprecated and scheduled for retirement. This guide provides the steps to migrate existing custom control Conditional Access policies to external MFA.

> [!IMPORTANT]
> Custom controls are deprecated. Adding new custom controls and editing existing custom controls will not be allowed starting September 2026. Full retirement is scheduled for early 2027. Start planning your migration now. For more information, see the [External MFA GA announcement](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/external-mfa-in-microsoft-entra-id-is-now-generally-available/4488926).

*This guide is relevant only if your organization currently uses custom controls. If you don't use custom controls, no action is needed.*

## Prerequisites

Before you begin, ensure you have:

- Microsoft Entra ID P1 or P2 license.
- [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role (or Global Administrator).
- [Privileged Role Administrator](../role-based-access-control/permissions-reference.md#privileged-role-administrator) role to grant admin consent for the provider's application.
- Metadata from your external MFA provider:
  - **Application ID**: App Registration ID (typically multitenant).
  - **Client ID**: Identifies Microsoft Entra requests to the provider.
  - **Discovery URL**: OIDC metadata endpoint (for example, `https://provider.example.com/.well-known/openid-configuration`).
- A test user group in Microsoft Entra ID for testing.
- An inventory of all existing Conditional Access policies that use custom controls.

## Why migrate?

External MFA addresses key limitations of custom controls:

| Capability | Custom controls | External MFA |
|---|---|---|
| Satisfies CA "Require MFA" grant | ❌ No | ✅ Yes (native MFA claim) |
| Sign-in log accuracy | ❌ MFA not reflected | ✅ Full MFA reporting |
| Privileged Identity Management (PIM) | ❌ Not supported | ✅ Supported |
| Risk-based Conditional Access | ❌ Not supported | ✅ Supported |
| Intune device registration | ❌ Not supported | ✅ Supported |

## Migration overview

The high-level migration process includes the following steps:

1. [Audit your existing custom control policies.](#audit-your-existing-custom-control-policies)
1. [Configure the external MFA authentication method policy.](#configure-the-external-mfa-authentication-method-policy)
1. [Register test users for external MFA.](#register-test-users-for-external-mfa)
1. [Create a test Conditional Access policy requiring MFA.](#create-a-test-conditional-access-policy-requiring-mfa)
1. [Move test users from custom control policy to external MFA policy.](#move-test-users-from-custom-control-policy-to-external-mfa-policy)
1. [Test sign-in to protected apps.](#test-sign-in-to-protected-apps)
1. [Full rollout.](#full-rollout)

## Audit your existing custom control policies

Before making changes, document your current state. To identify Conditional Access policies using custom controls:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Review each policy and note any that use custom controls under the **Grant** controls.
1. For each policy, record:
   - Policy name and ID
   - Targeted users/groups
   - Targeted cloud apps
   - The custom control provider referenced
   - Any conditions (locations, device platforms, and so on)

Alternatively, run the following Microsoft Graph PowerShell command to identify all policies using custom controls:

```powershell
Connect-MgGraph -Scopes "Policy.Read.All"

Get-MgIdentityConditionalAccessPolicy -All | Where-Object {
    $_.GrantControls -and (
        @($_.GrantControls.CustomAuthenticationFactors) |
        Where-Object { $_ -is [string] -and $_.Trim().Length -gt 0 }
    ).Count -gt 0
} | Select-Object Id, DisplayName, State, @{
    N = "CustomAuthFactors"
    E = { ($_.GrantControls.CustomAuthenticationFactors | Where-Object { $_ -is [string] -and $_.Trim().Length -gt 0 }) -join "," }
}
```

> [!TIP]
> Large tenants might have dozens or hundreds of Conditional Access policies. Export the results and track migration status per policy to avoid underestimating migration effort.

## Configure the external MFA authentication method policy

This step registers your external MFA provider as a recognized authentication method in Microsoft Entra ID. We recommend configuring your external MFA provider in the Microsoft Entra admin center for better visibility and easier management, but you can also use the Microsoft Graph API and PowerShell.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Policies**.
1. Select **Add external method** (or **Add method** > **External Authentication Method**).
1. Fill in the required fields:
   - **Display Name**: A user-friendly name (for example, "Contoso External MFA - Duo"). This value can't be changed after creation.
   - **Client ID**: The Client ID provided by your external MFA vendor.
   - **App ID**: The Application (registration) ID for the provider's app in Microsoft Entra ID.
   - **Discovery Endpoint**: The OIDC discovery URL from your provider.
1. When prompted, grant admin consent for the external provider's application. If you don't consent immediately, the method remains disabled until consent is granted.
1. Under **Enable and target**:
   - Set the state to **Enabled**.
   - Initially, target only your test user group (not **All users**).
   - Optionally configure exclude targets for break-glass/emergency accounts.
1. Select **Save**.

### [Microsoft Graph API](#tab/microsoft-graph-api)

If you prefer automation, use the Microsoft Graph API:

```http
POST https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations
Content-Type: application/json

{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "displayName": "Contoso External MFA",
  "state": "enabled",
  "appId": "<provider-app-registration-id>",
  "openIdConnectSetting": {
    "clientId": "<provider-client-id>",
    "discoveryUrl": "https://provider.example.com/.well-known/openid-configuration"
  },
  "includeTargets": [
    {
      "@odata.type": "microsoft.graph.authenticationMethodTarget",
      "id": "<test-group-object-id>",
      "targetType": "group"
    }
  ],
  "excludeTargets": []
}
```

### [PowerShell](#tab/powershell)

```powershell
Connect-MgGraph -Scopes "Policy.ReadWrite.AuthenticationMethod"

$params = @{
    "@odata.type"        = "#microsoft.graph.externalAuthenticationMethodConfiguration"
    displayName          = "Contoso External MFA"
    state                = "enabled"
    appId                = "<provider-app-registration-id>"
    openIdConnectSetting = @{
        clientId     = "<provider-client-id>"
        discoveryUrl = "https://provider.example.com/.well-known/openid-configuration"
    }
    includeTargets       = @(
        @{
            "@odata.type" = "microsoft.graph.authenticationMethodTarget"
            id            = "<test-group-object-id>"
            targetType    = "group"
        }
    )
}

New-MgPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration -BodyParameter $params
```
---

## Register test users for external MFA

Once the external MFA policy is configured and targeted at your test group, ensure users are registered for the external authentication method.

### Verify user registration status

Check which authentication methods are registered for a specific user:

```powershell
Connect-MgGraph -Scopes "UserAuthenticationMethod.Read.All"

$userId = "<user-object-id-or-upn>"
Get-MgUserAuthenticationMethod -UserId $userId |
    Format-Table Id, @{N='Type'; E={$_.'@odata.type'}}
```

### Register users for external MFA

If users need to be registered for the external authentication method, admins can register them in the Microsoft Entra admin center:

1. Browse to **Users** > **All users**.
1. Select the user who needs to be registered for external MFA.
1. In the User menu, select **Authentication Methods**, then select **+ Add Authentication Method**.
1. Select **External authentication method**.
1. Select one or more external MFA methods, and select **Save**.

For more information about bulk registration options, see [Manage external MFA in Microsoft Entra ID](../authentication/how-to-authentication-external-method-manage.md).

### Confirm registration across the test group

Generate a registration report:

```powershell
Connect-MgGraph -Scopes "UserAuthenticationMethod.Read.All", "GroupMember.Read.All"

$groupId = "<test-group-object-id>"
$members = Get-MgGroupMember -GroupId $groupId -All

$report = foreach ($member in $members) {
    $methods = Get-MgUserAuthenticationMethod -UserId $member.Id
    $hasExternalMFA = $methods | Where-Object { $_.'@odata.type' -like '*external*' }
    [PSCustomObject]@{
        UserId           = $member.Id
        UPN              = $member.AdditionalProperties.userPrincipalName
        ExternalMFA      = if ($hasExternalMFA) { "Yes" } else { "No" }
        MethodCount      = $methods.Count
    }
}

$report | Format-Table -AutoSize
$report | Export-Csv -Path "ExternalMFA-Registration-Report.csv" -NoTypeInformation
```

> [!NOTE]
> If your organization previously enabled the external MFA registration public preview, users who registered during that period should already appear as registered. Verify with the registration check before bulk-registering.

## Create a test Conditional Access policy requiring MFA

Create a new Conditional Access policy that uses the standard **Require multifactor authentication** grant, which external MFA now satisfies, rather than a custom control.

> [!NOTE]
> Due to caching and replication, it might take up to a few hours for a new policy to take effect at authentication time.

### Create the policy in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **+ New policy**.
1. Configure the policy:
   - **Name**: `Test - Require MFA via External Auth Method`
   - **Assignments:**
     - **Users**: Select your test user group only.
     - **Exclude**: Your break-glass/emergency access accounts.
   - **Target resources:**
     - **Cloud apps**: Select the same apps that your existing custom control policy targets (for example, Office 365, or specific line-of-business apps).
   - **Conditions** (Optionally mirror your existing custom control policy):
     - Client apps, device platforms, locations, and so on.
   - **Grant:**
     - Select **Grant access**.
     - Check **Require multifactor authentication**.
     - Select **Select**.
1. Set the policy to **Report-only** mode initially.
1. Select **Create**.

> [!IMPORTANT]
> Don't use **Require authentication strength** for external MFA. Use the standard **Require multifactor authentication** grant. External MFA isn't yet compatible with authentication strength policies.

### Verify report-only behavior

1. Have a test user sign in to one of the targeted apps.
1. Browse to **Protection** > **Sign-in logs**.
1. Find the test user's sign-in and check the **Conditional Access** tab:
   - Confirm the new policy shows as **Report-only: Not applied** or **Report-only: Success**.
   - Verify the MFA method is listed as your external authentication method.

### Enable the policy

Once satisfied with report-only results:

1. Edit the policy.
1. Change from **Report-only** to **On**.
1. Save.

## Move test users from custom control policy to external MFA policy

To avoid users being subject to both the old custom control policy and the new external MFA policy simultaneously, exclude test users from the old custom control policy.

### Exclude test users from the custom control policy

1. Open your existing custom control Conditional Access policy.
1. Under **Users** > **Exclude**, add your test user group.
1. Save the policy.

### Verify policy assignment with What If

1. Browse to **Protection** > **Conditional Access** > **What If**.
1. Select a test user.
1. Select a target app.
1. Select **What If**.
1. Confirm:
   - The old custom control policy does **NOT** apply to the test user.
   - The new MFA policy **DOES** apply.

## Test sign-in to protected apps

To confirm the sign-in to protected apps works as expected, have your test users sign in and then verify they were challenged for MFA by the external provider, not the old custom control, and that the sign-in logs reflect the new policy and authentication method correctly.

### Perform test sign-ins

Have each test user (or a representative sample) perform the following steps:

1. Sign in to a targeted app (for example, Office 365, Azure portal, or your line-of-business app).
1. Verify:
   - The user is challenged by the external MFA provider (not custom controls).
   - After completing MFA, the user gains access to the app.
   - The experience is seamless and matches expectations.
1. Test edge cases:
   - Sign in from a new device/browser.
   - Sign in from a noncompliant device (if device compliance policies exist).
   - Sign in from a blocked location (if location-based conditions exist).
   - Attempt sign-in with an expired or revoked MFA session.

### Validate sign-in logs

1. Browse to **Protection** > **Sign-in logs**.
1. Filter for test users.
1. For each sign-in, confirm:
   - **MFA result**: Success
   - **Authentication method**: Your external authentication method name
   - **Conditional Access**: The new policy evaluated and granted access
   - **MFA requirement satisfied by**: External authentication method (not custom control)

### Validate downstream integrations

If applicable, verify that these scenarios work correctly with external MFA:

- **Self-Service Password Reset (SSPR)**: User can reset password using external MFA.
- **PIM role activation**: User can activate privileged roles with external MFA.
- **Risk-based policies**: Sign-in risk and user risk policies correctly interact with external MFA.
- **Intune device enrollment**: Device registration completes with external MFA.

## Full rollout

After successful testing, expand the migration to all users.

### Phased rollout plan

| Phase | Scope | Actions |
|---|---|---|
| Phase 1 | Test group (5–10 users) | Steps 1–6 above |
| Phase 2 | IT/early adopters (50–100 users) | Expand external MFA targeting and CA policy scope |
| Phase 3 | Department-by-department | Gradually move groups from custom control to MFA policy |
| Phase 4 | All users | Full migration, remove custom control policy |

### Expand external MFA targeting

Update the external MFA authentication method policy to include broader groups:

```powershell
Connect-MgGraph -Scopes "Policy.ReadWrite.AuthenticationMethod"

$configId = "<external-mfa-configuration-id>"
$params = @{
    "@odata.type"  = "#microsoft.graph.externalAuthenticationMethodConfiguration"
    includeTargets = @(
        @{
            "@odata.type" = "microsoft.graph.authenticationMethodTarget"
            id            = "all_users"
            targetType    = "group"
        }
    )
}

Update-MgPolicyAuthenticationMethodPolicyAuthenticationMethodConfiguration `
    -AuthenticationMethodConfigurationId $configId `
    -BodyParameter $params
```

### Update the MFA Conditional Access policy

Expand the new Conditional Access policy to target all users (replacing the test group).

### Remove custom control references

Once all users are migrated:

1. Disable the old custom control Conditional Access policy.
1. Monitor sign-in logs for 1–2 weeks to confirm no regressions.
1. Delete the old custom control policy.
1. Remove the custom control definition from the tenant.

> [!WARNING]
> Don't delete custom control configurations until you confirm the new external MFA policy is stable. Keep the old policy disabled (not deleted) for at least two weeks as a rollback option.

## Troubleshooting

| Issue | Possible cause | Resolution |
|---|---|---|
| External MFA method not appearing for users | Method not enabled or user not in includeTargets | Verify external MFA policy targeting in Authentication Methods |
| Admin consent error | Insufficient privileges | Use a Global Admin or Privileged Role Admin to grant consent |
| MFA not recognized in sign-in logs | Policy misconfiguration | Ensure **Require MFA** grant is used (not authentication strength) |
| User not challenged for MFA | CA policy not applying | Use the **What If** tool to debug policy evaluation |
| External provider errors | OIDC configuration mismatch | Verify Discovery URL, Client ID, and App ID with vendor |
| Users seeing both prompts | User not excluded from old policy | Verify exclusion groups on the custom control policy |

## Related content

- [Custom controls (preview)](controls.md)
- [Manage external MFA in Microsoft Entra ID](../authentication/how-to-authentication-external-method-manage.md)
- [External MFA provider reference (OIDC spec)](../authentication/concept-authentication-external-method-provider.md)
- [Conditional Access grant controls](concept-conditional-access-grant.md)
- [External MFA in Microsoft Entra ID is now generally available](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/external-mfa-in-microsoft-entra-id-is-now-generally-available/4488926)

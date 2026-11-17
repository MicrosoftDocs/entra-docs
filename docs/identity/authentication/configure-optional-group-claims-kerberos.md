---
title: Configure optional group SID claims for Microsoft Entra Kerberos tickets (Preview)
description: Learn how to select the group SID categories and group membership scope included in Microsoft Entra Kerberos service tickets.
ms.topic: how-to
ms.date: 10/22/2026
ms.reviewer: Vimala
ai-usage: ai-assisted
# Customer intent: As an application administrator, I want to control which group SIDs Microsoft Entra ID includes in Kerberos service tickets.
---

# Configure optional group SID claims for Microsoft Entra Kerberos tickets (Preview)

Microsoft Entra Kerberos service tickets can include group security identifiers (SIDs) in the Privilege Attribute Certificate (PAC). Resources can use these SIDs to authorize access to files, applications, and other Kerberos-protected resources.

Kerberos tickets support a maximum of 1,010 group SIDs. If a user's effective group membership exceeds this limit, Microsoft Entra ID can't issue the service ticket. Configure optional group SID claims to include only the SID categories and group memberships that the resource requires.

> [!IMPORTANT]
> The `kerberosTicket` optional claim applies only to Kerberos tickets. However, `groupMembershipClaims` is an application-wide setting and can affect group claims in ID, access, and SAML tokens. Review existing token consumers before changing this setting.

## Prerequisites

To configure optional group SID claims, you need:

- A Microsoft Entra tenant with Microsoft Entra Kerberos enabled for the workload.
- An application registration that represents the Kerberos-protected resource.
- A role that can update the application registration, such as Cloud Application Administrator or Application Administrator. An application owner can also update an application when the administration model and Microsoft Graph permissions allow it.
- Groups assigned or available to the application, based on the `groupMembershipClaims` value that you select.

During preview, the Microsoft Entra admin center experience and Microsoft Graph schema might become available at different times. If the **Kerberos** section isn't displayed in **Token configuration**, use the Microsoft Graph beta endpoint.

## How group SID selection works

The configuration has two parts:

- `groupMembershipClaims` controls which group memberships are eligible for the optional Kerberos group SID categories.
- `optionalClaims.kerberosTicket` selects which SID representations Microsoft Entra ID adds to the PAC.

The SID category and its PAC location are separate concepts. Microsoft Entra ID determines the PAC location based on the user's identity type and SID authority. Applications select SID categories; they don't select PAC fields directly.

### Select the group membership scope

Use `groupMembershipClaims` to control the group memberships considered for the optional SID categories.

| Value | Optional group memberships considered |
| --- | --- |
| `None` | No optional group memberships. |
| `SecurityGroup` | Security-enabled groups. |
| `All` | Security groups, directory roles, and distribution lists. |
| `ApplicationGroup` | Only groups assigned to the application. |
| `DirectoryRole` | No optional group SIDs when used by itself. |

Use `ApplicationGroup` when possible. This value limits the memberships considered for the application and helps reduce the likelihood of exceeding the 1,010-group SID limit. For more information, see [Manage users and groups assignment to an application](../enterprise-apps/assign-user-or-group-access-portal.md?pivots=portal).

> [!IMPORTANT]
> For hybrid users, the user's base on-premises group SIDs remain part of the normal Kerberos PAC behavior. The `kerberosTicket` optional claim and `groupMembershipClaims` scope the optional SID categories; they don't remove the hybrid user's base on-premises group memberships.

If both the client application and resource application configure Kerberos group SID claims, Microsoft Entra ID combines the selected categories and eligible groups from both applications.

### Select the group SID categories

Add a `groups` claim to `optionalClaims.kerberosTicket`, and use one or more of the following exact, case-sensitive values in `additionalProperties`.

| Selector | Group SID selected | PAC behavior |
| --- | --- | --- |
| `hybrid_group_onpremises_sids` | The original on-premises SID (`S-1-5-21-...`) of a group that is synchronized to Microsoft Entra ID. | For a cloud-only user, the SID is added to `ExtraSids`. For a hybrid user, original on-premises group SIDs are already included through the normal PAC group processing. |
| `hybrid_group_cloud_sids` | The Microsoft Entra cloud SID (`S-1-12-1-...`) of a synchronized group that also has an on-premises SID. | The SID is added to `ExtraSids`. For a hybrid user, the user's cloud SID is also added first in `ExtraSids`. |
| `cloud_only_group_sids` | The Microsoft Entra cloud SID (`S-1-12-1-...`) of a group that doesn't have an on-premises SID. | The SID is added to `ExtraSids`. For a hybrid user, the user's cloud SID is also added first in `ExtraSids`. |

For a cloud-only user, the user's cloud SID is required and remains the first entry in `ExtraSids`. The selected group SID categories follow it.

> [!IMPORTANT]
> Use only the canonical selector names in the preceding table. The pre-release names `hybrid_group_sids` and `onpremises_group_sids` aren't supported.

## Configure the application

# [Microsoft Entra admin center](#tab/entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an administrator who can update the application.
1. Browse to **Entra ID** > **App registrations**.
1. Select the application registration for the Kerberos-protected resource.
1. Under **Manage**, select **Token configuration**.
1. Select **Add groups claim**, or edit the existing `groups` claim.
1. Select the group membership scope:

    - **Security groups**
    - **All groups**
    - **Groups assigned to the application**

1. Expand **Kerberos**, and select one or more SID categories:

    - **Hybrid group on-premises SIDs**
    - **Hybrid group cloud SIDs**
    - **Cloud-only group SIDs**

1. Select **Save**.

:::image type="content" source="media/configure-optional-group-claims-kerberos/select-kerberos-group-sids.png" alt-text="Screenshot of the Edit groups claim pane with Kerberos group SID category options." lightbox="media/configure-optional-group-claims-kerberos/select-kerberos-group-sids.png":::

After you save the configuration, the `groups` claim appears with the **Kerberos** token type.

:::image type="content" source="media/configure-optional-group-claims-kerberos/kerberos-groups-claim.png" alt-text="Screenshot of Token configuration showing a groups claim for the Kerberos token type." lightbox="media/configure-optional-group-claims-kerberos/kerberos-groups-claim.png":::

# [Microsoft Graph](#tab/microsoft-graph)

During preview, use the Microsoft Graph beta endpoint.

1. Read the current application configuration. Replace `{applicationObjectId}` with the object ID of the application registration, not its application (client) ID.

    ```http
    GET https://graph.microsoft.com/beta/applications/{applicationObjectId}?$select=id,appId,displayName,groupMembershipClaims,optionalClaims
    ```

1. Preserve the existing `idToken`, `accessToken`, and `saml2Token` optional-claim collections. Updating the `optionalClaims` complex property can replace the collections supplied in the request.
1. Submit a `PATCH` request. The following example limits optional group SID evaluation to groups assigned to the application and requests all three supported SID categories:

    ```http
    PATCH https://graph.microsoft.com/beta/applications/{applicationObjectId}
    Content-Type: application/json

    {
      "groupMembershipClaims": "ApplicationGroup",
      "optionalClaims": {
        "idToken": [],
        "accessToken": [],
        "saml2Token": [],
        "kerberosTicket": [
          {
            "name": "groups",
            "source": null,
            "essential": false,
            "additionalProperties": [
              "hybrid_group_onpremises_sids",
              "hybrid_group_cloud_sids",
              "cloud_only_group_sids"
            ]
          }
        ]
      }
    }
    ```

    Replace the empty token collections with the existing values returned by the `GET` request when the application already has optional claims.

1. A successful update returns `204 No Content`. Read the application again to confirm that the configuration was saved:

    ```http
    GET https://graph.microsoft.com/beta/applications/{applicationObjectId}?$select=id,appId,displayName,groupMembershipClaims,optionalClaims
    ```

---

## Configuration examples

The following examples show only the `kerberosTicket` collection. Preserve the application's other optional-claim collections when you update the complete `optionalClaims` property.

### Include cloud SIDs for cloud-only groups

```json
"kerberosTicket": [
  {
    "name": "groups",
    "source": null,
    "essential": false,
    "additionalProperties": [
      "cloud_only_group_sids"
    ]
  }
]
```

### Include both SID representations for synchronized groups

```json
"kerberosTicket": [
  {
    "name": "groups",
    "source": null,
    "essential": false,
    "additionalProperties": [
      "hybrid_group_onpremises_sids",
      "hybrid_group_cloud_sids"
    ]
  }
]
```

### Include all supported optional group SID categories

```json
"kerberosTicket": [
  {
    "name": "groups",
    "source": null,
    "essential": false,
    "additionalProperties": [
      "hybrid_group_onpremises_sids",
      "hybrid_group_cloud_sids",
      "cloud_only_group_sids"
    ]
  }
]
```

## Assign groups to the application

If you set `groupMembershipClaims` to `ApplicationGroup`, assign each required group to the enterprise application:

1. In the Microsoft Entra admin center, browse to **Entra ID** > **Enterprise applications**.
1. Select the enterprise application that corresponds to the application registration.
1. Under **Manage**, select **Users and groups**.
1. Select **Add user/group**, select the required groups, and then select **Assign**.

Only assigned groups that the user is a member of are eligible for the optional Kerberos group SID categories.

## Verify the configuration

1. Read the application object and confirm that `optionalClaims.kerberosTicket` contains a claim whose `name` is `groups`.
1. Confirm that each `additionalProperties` value uses the exact supported spelling and casing.
1. Confirm that `groupMembershipClaims` matches the intended scope.
1. If you use `ApplicationGroup`, confirm that the required groups are assigned to the enterprise application.
1. Clear cached tickets when appropriate for your test environment, and request a new Kerberos service ticket for the resource.
1. Validate that access succeeds and that the expected SIDs are present in the ticket or resource-side authorization evaluation.
1. Test each identity topology that the application supports, such as hybrid users, cloud-only users, synchronized groups, and cloud-only groups.
1. Review the Microsoft Entra sign-in logs and resource-side Kerberos events if ticket issuance or access fails.

## Migrate from a legacy application tag

Some preview applications use the `kdc_enable_cloud_group_sids` application tag to opt in to cloud group SIDs. The `kerberosTicket` optional claim replaces this tag with an explicit per-application group scope and SID category selection.

To migrate:

1. Keep the legacy tag while you add the equivalent `kerberosTicket` optional claim.
1. Read the application configuration to verify that the optional claim was saved.
1. Test service-ticket issuance and resource authorization with representative users and groups.
1. Remove the legacy tag only after the optional-claim configuration is deployed and validated end to end.

> [!IMPORTANT]
> Don't remove a working legacy configuration until the optional claim has been saved, read back, and validated in the target environment.

## Troubleshoot

| Symptom | Cause or action |
| --- | --- |
| The **Kerberos** section isn't displayed in **Token configuration**. | The preview admin center experience isn't available for the tenant. Use the Microsoft Graph beta endpoint. |
| `kerberosTicket` is reported as an invalid property, or the saved collection is empty. | The Microsoft Graph or application-manifest schema used by the administration surface doesn't support the preview property in that environment. Use the supported beta endpoint and verify feature availability. |
| The `groups` claim is ignored. | Confirm that it is inside `optionalClaims.kerberosTicket`. Kerberos group SID selectors aren't honored in `idToken`, `accessToken`, or `saml2Token`. |
| A selector is ignored. | Use the exact canonical values: `hybrid_group_onpremises_sids`, `hybrid_group_cloud_sids`, and `cloud_only_group_sids`. |
| No optional group SIDs are included. | Check `groupMembershipClaims`, group assignment, user membership, and the selected SID categories. The `name` value must be `groups`. |
| Assigned groups are missing. | When `groupMembershipClaims` is `ApplicationGroup`, confirm that the groups are assigned to the enterprise application. |
| Hybrid on-premises group SIDs are still present when a narrow optional scope is configured. | Hybrid users retain their base on-premises PAC group memberships. The optional claim scopes additional SID categories and doesn't remove the base group projection. |
| Ticket issuance fails for a user with many group memberships. | Kerberos tickets support a maximum of 1,010 group SIDs. Reduce the scope, preferably by using `ApplicationGroup`, and assign only the groups required by the resource. |
| Sign-in logs show error `140011` (`KerberosUsersGroupNumberExceeded`). | The effective PAC group SID count exceeded 1,010. Microsoft Entra ID returns a Kerberos field-too-long error and doesn't issue the service ticket. |
| Sign-in succeeds but resource access fails. | Kerberos service-ticket issuance occurs when the user accesses the resource. Review the sign-in log entry for the TGS request and the resource's Kerberos and authorization logs. |

## Security and operational guidance

- Request only the SID categories that the resource requires. Additional authorization data increases ticket size.
- Prefer `ApplicationGroup` to create a predictable, least-privileged group scope.
- Assign only the groups required by the resource.
- Treat group SIDs as authorization inputs only after the resource validates the Kerberos ticket and its intended service identity.
- Monitor sign-in logs and resource-side Kerberos events during deployment and migration.
- Validate cloud-only and hybrid identity topologies separately.

## Related content

- [Introduction to Microsoft Entra Kerberos](kerberos.md)
- [Configure and manage optional claims in ID tokens, access tokens, and SAML tokens](../../identity-platform/optional-claims.md)
- [Configure group claims for applications by using Microsoft Entra ID](../hybrid/connect/how-to-connect-fed-group-claims.md)
- [Manage users and groups assignment to an application](../enterprise-apps/assign-user-or-group-access-portal.md?pivots=portal)
- [optionalClaims resource type](/graph/api/resources/optionalclaims)
- [Update application](/graph/api/application-update)

---
title: Manage CIMD clients in Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: Add, approve, find, monitor, and remove Client ID Metadata Document clients in Microsoft Entra ID.
ms.topic: how-to
ms.date: 10/30/2026
ai-usage: ai-assisted

#customer-intent: As an Entra administrator, I want to control and monitor CIMD clients in my tenant so that users can connect approved MCP clients without bypassing organizational consent and security policies.
---

# Manage CIMD clients in Microsoft Entra ID (preview)

Microsoft Entra ID represents a client discovered through a Client ID Metadata Document (CIMD) as an agent identity in your tenant. You can add a trusted CIMD client in advance, grant delegated permissions, monitor its activity, and disable or delete it by using the same management surfaces used for other agent identities.

> [!IMPORTANT]
> Client ID Metadata Document support in Microsoft Entra ID is in public preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

Before enabling CIMD scenarios, review [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md), including the limitations and governance considerations.

**In this article**

- [Choose a tenant posture](#choose-a-tenant-posture)
  - [Understand the default posture](#understand-the-default-posture)
  - [Configure the strict posture](#configure-the-strict-posture)
  - [Configure the open posture](#configure-the-open-posture)
- [Add a CIMD client](#add-a-cimd-client)
  - [Add via Admin Center](#add-via-admin-center)
  - [Add via Microsoft Graph](#add-via-microsoft-graph)
- [List CIMD clients](#list-cimd-clients)
  - [List via Admin Center](#list-via-admin-center)
  - [List via Microsoft Graph](#list-via-microsoft-graph)
- [Monitor a CIMD client](#monitor-a-cimd-client)

## Choose a tenant posture

Tenant consent policy determines whether users can add CIMD clients to a tenant and which delegated permissions they can grant. Review the default behavior, then choose a strict or open posture for your organization. Prefer the strict posture when your organization requires review before a new client can access its data.

| Posture | Behavior | Consider when |
| --- | --- | --- |
| Default | Users can add CIMD clients and grant a limited set of scopes, such as `openid` and Microsoft Graph `User.Read`. Risk-based step-up consent requires administrator approval for other permissions. | Your organization allows self-service onboarding for basic scopes but requires administrator approval for additional permissions. |
| Strict | An administrator adds each approved CIMD client through consent, the admin center, or Microsoft Graph, then grants its required OAuth scopes for all users. Users don't approve new CIMD clients or additional scopes. | Your organization requires a security or application-onboarding review. |
| Open | An administrator enables user consent for selected OAuth permissions, including for unverified clients, and disables risk-based step-up consent. The policy applies to CIMD and non-CIMD clients that match its conditions. Each user consents for their own access. | Your organization accepts self-service onboarding of unverified clients within a reviewed permission boundary. |

> [!WARNING]
> Don't allow users to consent to all CIMD clients for any OAuth scope. Anyone can publish a CIMD document; control of a URL doesn't establish trustworthiness. Unrestricted consent exposes your tenant to consent phishing attacks and unauthorized access to organizational data. The open posture must limit user consent to specific, reviewed permissions. Its consent policy also permits matching non-CIMD clients, including unverified apps; it can't be limited to CIMD clients.

### Understand the default posture

Under the default consent policy, users can sign in to any CIMD client and create an agent identity in the tenant. They can grant only a limited set of OAuth scopes, such as `openid` and Microsoft Graph `User.Read`. Risk-based step-up consent is enabled by default and prevents users from granting other permissions to CIMD clients without administrator approval.

### Configure the strict posture

To prevent users from adding CIMD clients to a tenant, update your tenant's consent settings to block user consent to unverified apps. Entra treats CIMD clients as unverified apps. Use one of the following two approaches:

- **Consent settings:** Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a **Global Administrator**. Browse to **Entra ID** > **Enterprise apps** > **Consent and permissions** > **User consent settings**. Select **Do not allow user consent**, then select **Save**. This blocks user consent to all apps, including verified apps. See [Configure user consent](/entra/identity/enterprise-apps/configure-user-consent).

- **Consent policy:** As a **Privileged Role Administrator**, configure and assign a custom user consent policy that requires `clientApplicationsFromVerifiedPublisherOnly` to be `true`. CIMD clients can't be publisher verified, so this blocks user consent to CIMD and other unverified apps while allowing verified apps that meet the policy's other conditions. See [Manage app consent policies](/entra/identity/enterprise-apps/manage-app-consent-policies).

Review all assigned user consent policies: a verified-publisher requirement doesn't override another policy that allows unverified apps. These settings don't revoke existing consent grants or delete existing identities. Review and revoke existing grants separately if you need to stop previously approved access.

### Configure the open posture

To enable users to add CIMD clients to your tenant and grant them specific permissions, update your tenant's consent policy:

1. **Define a custom consent policy.** Limit consent to specific resource applications and reviewed delegated permissions that allow user consent. Set `clientApplicationsFromVerifiedPublisherOnly` to `false` so CIMD clients can qualify. See [Manage app consent policies](/entra/identity/enterprise-apps/manage-app-consent-policies).

1. **Apply the policy to all users.** Assign it to the default user role using the steps in [Configure user consent](/entra/identity/enterprise-apps/configure-user-consent). Review other assigned policies and remove broader user consent permissions that would bypass your restrictions.

1. **Turn off risk-based step-up consent.** After verifying the policy restrictions, follow [Configure risk-based step-up consent](/entra/identity/enterprise-apps/configure-risk-based-step-up-consent) to disable the check that otherwise requires administrator approval for nonbasic CIMD permissions.

> [!WARNING]
> Choosing the open posture can put your users at risk of consent phishing attacks from malicious clients. The consent policy also applies to matching non-CIMD clients, including unverified apps. Disabling risk-based step-up consent is tenant-wide and removes automatic administrator step-up for risky consent requests. Don't combine it with unrestricted user consent.

## Add a CIMD client

In the strict posture, review a client and create its agent identity before users connect.

### Add via Admin Center

Before you begin, obtain the CIMD URL from the client owner. Use an account in your Microsoft Entra tenant with a role that can create agent identities, such as **Global Administrator**, **Agent ID Administrator**, or **AI Administrator**.

To add a trusted client before a user connects:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Select **Add agent identity**.
1. Enter the client's CIMD URL and continue.
1. Complete the creation process.
1. [Grant only the delegated permissions required by the protected resource](grant-agent-access-microsoft-365.md).

### Add via Microsoft Graph

Before you begin, obtain the CIMD URL from the client owner. Use an account in your Microsoft Entra tenant with a role that can create agent identities, such as **Global Administrator**, **Agent ID Administrator**, or **AI Administrator**.

You can create the tenant-local agent identity by using the Microsoft Graph beta endpoint. Administrator-created identities require at least one owner or sponsor. This example binds a sponsor user from the target tenant; replace `<sponsor-user-object-id>` with the user's object-ID GUID.

```http
POST https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity
Authorization: Bearer {token}
Content-Type: application/json

{
  "displayName": "Contoso Agent",
  "clientIdMetadataDocumentUrl": "https://client.contoso.com/oauth/client-metadata.json",
  "sponsors@odata.bind": [
    "https://graph.microsoft.com/v1.0/users/<sponsor-user-object-id>"
  ]
}
```

A successful response resembles:

```json
{
  "@odata.type": "#microsoft.graph.agentIdentity",
  "id": "11111111-2222-3333-4444-555555555555",
  "agentIdentityBlueprintId": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
  "displayName": "Contoso Agent",
  "clientIdMetadataDocumentUrl": "https://client.contoso.com/oauth/client-metadata.json",
  "hasClientIdMetadataDocument": true
}
```

## List CIMD clients

CIMD clients appear alongside other agent identities in your tenant. Use the admin center to browse identities or Microsoft Graph to retrieve a CIMD-only list.

### List via Admin Center

Sign in with a Microsoft Entra user account in the tenant you want to inspect.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Add the filter **Has Client ID Metadata Document**.
1. Select the identity to review its details, owners, sponsors, granted permissions, and sign-in logs.

### List via Microsoft Graph

To list all CIMD-backed agent identities, use an advanced query:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity?$filter=hasClientIdMetadataDocument eq true&$count=true
Authorization: Bearer {token}
ConsistencyLevel: eventual
```

To find an identity by its canonical CIMD URL:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity?$filter=clientIdMetadataDocumentUrl eq 'https://client.contoso.com/oauth/client-metadata.json'&$count=true
Authorization: Bearer {token}
ConsistencyLevel: eventual
```

Both filters require `$count=true` and the `ConsistencyLevel: eventual` request header.

## Monitor a CIMD client

CIMD-backed identities appear in Microsoft Entra sign-in and audit logs as agent identities.

Monitor:

- Successful and failed sign-ins.
- Users who authorize or use the client.
- Resources and delegated scopes the client accesses.
- Creation, update, disablement, deletion, and consent-grant events.
- Unexpected changes in client behavior or redirect destinations.

The app ID shown in logs is derived from the CIMD URL. The client has no home application tenant. For more information, see [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md).

**Related content**

- [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md)
- [Configure a client to use a Client ID Metadata Document](configure-client-id-metadata-document.md)
- [Manage agent identities in your organization](manage-agent-identities-admin.md)
- [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md)

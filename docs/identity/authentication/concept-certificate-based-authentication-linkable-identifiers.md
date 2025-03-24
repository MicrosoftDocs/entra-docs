---
title: Track and investigate identity activities with linkable identifiers in Microsoft Entra (preview)
description: Discover how linkable identifiers like session IDs and unique token identifiers in Microsoft Entra help track and investigate identity-related activities, enhancing security and transparency.
ms.topic: conceptual
ms.date: 03/23/2025
ms.author: justinha
author: vimrang
manager: femila
ms.reviewer: vraganathan
---

# Track and investigate identity activities with linkable identifiers in Microsoft Entra (preview)

Microsoft includes certain identifiers in all tokens that can be used to link activities from one root authentication. Linkable identifiers are currently in preview and exposed in customer-facing logs. Linkable identifiers help threat hunters and analysts investigate and remediate identity-related attacks. They significantly improve how security analysts and professionals can track, investigate, and remediate identity-related attacks across sessions and tokens, providing you with a more secure and transparent ecosystem.

There are two types of linkable identifiers:

- One is based on session ID (SID). It helps link all authentication artifacts issued from a single root authentication with the same identifier, which can be used to link or connect tokens in a single chain together. For example, a SID-based linkable identifier can track all the activities done by all the access tokens issued from a long-lived token, like a [refresh token (RT)](/entra/identity-platform/refresh-tokens) or session cookies.
- Another tracks activities done by a specific token access, like an [access token (AT)](/entra/identity-platform/access-tokens) or [ID token](/entra/identity-platform/id-tokens).

To help link all authentication artifacts issued from a single root authentication, the SID claim is created and included in primary refresh tokens (PRT), refresh token, or session cookie each time a user performs an interactive authentication for an account. The same SID value is added to each access token issued from a refresh token or in session cookie. It can be used to link all authentication artifacts, and can further filter for a specific user or device within a session.

SID-based scenarios include:

- Start with a session ID from Microsoft Entra sign in logs, and join with workload logs like Exchange Online audit logs or Microsoft Graph activity logs to identify all the activities done by all of the access tokens with the same session ID.
- Filter results further by UserId or DeviceId, or with a token issued within a time frame of a specific session.
- Determine how many sessions are alive for a given user (UserId) or a given device (DeviceId).

In addition, Microsoft Entra has another important linkable security claim called unique token identifier (UTI) that is a unique GUID present in all Microsoft Entra tokens. It serves to uniquely identify a token or request.

For token investigation, UTI gives finer granularity when you want to track down a particular suspicious token. A UTI is unique for every AT and SID and helps you investigate all of the tokens within a specific session. For more information about these claims, see [Access token](/entra/identity-platform/access-tokens) or [ID token](/entra/identity-platform/id-tokens).

UTI-based scenarios include:

- Start with a UTI (which points to a specific access token) from Microsoft Entra sign in logs and join with workload logs like Exchange Online audit logs or Microsoft Graph activity logs to identify all the activities done on behalf of the access token (UTI).

## Linkable identifier claims

| **Claim** | **Format**            | **Description**                                                                                                                                                                                              |
|-----------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| oid       | String, a GUID        | The immutable identifier for the requestor, which is the verified identity of the user or service principal. This ID uniquely identifies the requestor across applications.                                  |
| tid       | String, a GUID        | Represents the tenant that the user is signing in to.                                                                                                                                                        |
| sid       | String, a GUID        | Represents a unique identifier for an entire session and is generated when a user does interactive authentication. This ID helps link all authentication artifacts issued from a single root authentication. |
| deviceid  | String, a GUID        | Represents a unique identifier for the device from which a user is interacting with an application.                                                                                                          |
| uti       | String                | Represents the token identifier claim This ID is a unique, per-token identifier that is case-sensitive.                                                                                                                      |
| iat       | int, a Unix timestamp | Specifies when the authentication for this token occurred.                                                                                                                                                   |

As of now, linkable identifiers are logged into Microsoft Entra sign in logs, Exchange Online Audit logs and Microsoft Graph Activity logs.

## Linkable identifiers in Microsoft Entra sign in logs

A sign-in logs entry has the following linkable identifier claims under the attributes below.

| **Claim** | **Sign in log attribute name** |
|-----------|--------------------------------|
| oid       | User ID                        |
| tid       | Resource Tenant ID             |
| sid       | Session ID                     |
| deviceid  | Device ID                      |
| uti       | Unique Token Identifier        |
| iat       | Date                           |

To view the sign-in logs from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader).
2. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
3. Filter by time, or by specific user to look at the specific log entries.
4. Click any sign-in log entry.
5. **Basic Info** shows the User ID, Resource Tenant ID, Session ID, Unique Token Identifier, and Date. **Devices** shows the Device ID for registered and domain-joined devices.

:::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/sign-in-logs-entry.png" alt-text="Screenshot of sign-in log entry in Microsoft Entra admin center.":::

:::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/log-entry-details.png" alt-text="Screenshot of sign-in log entry details in Microsoft Entra admin center.":::

:::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/log-entry-linkable-identifiers.png" alt-text="Screenshot of sign-in log entry with linkable identifiers.":::

You should start with Microsoft Entra sign-in logs UTI attribute and manually search on the workload audit logs to track all the activities using a specific access token. Similarly, session ID attribute can be used to manually search on the workload audit logs to track all the activities.

## Microsoft Exchange Online logs

Exchange Online audit logs will help provide organization access to critical audit log event data to gain insight and further investigate user activities. Exchange Online will carry forward the linkable identifiers from Microsoft Entra tokens and will log all the linkable identifiers in the Exchange Online audit logs.

For scenarios involving exchange online like mailbox update, items moved or deleted, you can start with linkable identifiers from Microsoft Entra sign in logs and search Microsoft Purview Audit (Standard) and Audit (Premium) to track all user actions on any items in a mailbox. For more information about how to search Exchange Online audit logs, see [Search the audit log | Microsoft Learn](/purview/audit-search).

| **Claim** | **Exchange Online audit log attribute name**                              |
|-----------|---------------------------------------------------------------|
| oid       | TokenObjectId                                                 |
| tid       | TokenTenantId                                                 |
| sid       | SessionID / AADSessionId within App Access Context object     |
| deviceid  | DeviceId (Available only for registered/domain joined device) |
| uti       | UniqueTokenId within App Access Context object                |
| iat       | IssuedAtTime within App Access Context object                 |

### View Exchange Online logs using Purview portal

1. Go to [Microsoft Purview portal](https://purview.microsoft.com/).
2. Search for logs with a specific timeframe and record types starting with Exchange.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/purview-search.png" alt-text="Screenshot of Microsoft Purview portal showing search for logs.":::

3. You can further filter for a specific user, or a UTI value from Microsoft Entra sign-in logs. You can filter all the activity logs within a session with `SessionId`.
4. The results show all the linkable identifiers.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/purview-search-linkable-identifiers.png" alt-text="Screenshot of Microsoft Purview portal showing log item with linkable identifiers.":::

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/purview-search-linkable-identifiers-details.png" alt-text="Screenshot of Microsoft Purview portal showing detailed log item.":::

5. Export the audit log and investigate for a specific `SessionId` or `UniqueTokenId` for all the activities for Exchange Online.

### View Exchange Online logs using PowerShell commandlets


1. Run PowerShell as an administrator.
2. If the ExchangeOnlineManagement module isn't installed, run:

   ```powershell
   Install-Module -Name ExchangeOnlineManagement
   ```

3. Connect to Exchange Online:

   ```powershell
   Connect-ExchangeOnline -UserPrincipalName <user@4jkvzv.onmicrosoft.com>
   ```

4. Run some mailbox commands:

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 97MB
   ```

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 98MB
   ```

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 99MB
   ```

5. Search the unified audit log:

   ```powershell
   Search-UnifiedAuditLog -StartDate 01/06/2025 -EndDate 01/08/2025 -RecordType ExchangeItem, ExchangeAdmin, ExchangeAggregatedOperation, ExchangeItemAggregated, ExchangeItemGroup, ExchangeSearch
   ```

6. The results have all of the linkable identifiers.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/powershell-linkable-identifiers.png" alt-text="Screenshot of PowerShell command results showing linkable identifiers.":::

> [!NOTE]
> The linkable identifiers aren't available in the Exchange Online audit logs on some aggregated log entries, or logs generated from background processes.

For more information, see [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell).

## Microsoft Graph activity logs

Microsoft Graph activity logs are an audit trail of all HTTP requests that the Microsoft Graph service received and processed for a tenant. The logs are stored in Log Analytics for analysis.

If you send Microsoft Graph activity logs to a Log Analytics workspace, you can query the logs using Kusto Query Language (KQL). For scenarios involving Microsoft Graph activity, you can start with linkable identifiers from Microsoft Entra sign in logs, and check against Microsoft Graph activity logs to track all user actions on any items in a mailbox. For more information about how to search Microsoft Graph activity logs, see [Microsoft Graph Activity Logs](/graph/microsoft-graph-activity-logs-overview).

| **Claim** | **Attribute name in the Exchange Online audit log**                |
|-----------|--------------------------------------------------------------------|
| oid       | UserId                                                             |
| tid       | TenantId                                                           |
| sid       | SessionId                                                          |
| deviceid  | DeviceId (available only for registered and domain-joined devices) |
| uti       | SignInActivityId                                                   |
| iat       | TokenIssuedAt                                                      |

### Join sign-in logs and Microsoft Graph activity logs using KQL

You can use KQL to join Microsoft Entra sign-in logs and Microsoft Graph Activity logs. You can filter logs by `uti` attribute to analyze all the activities by a specific access token. Or you can filter logs by `sid` claim to analyze all activities of all access tokens from a refresh token obtained from a root interactive authentication. The log can be filtered further by using other attributes like `UserId`, `DeviceId`, and so on.

```kql
MicrosoftGraphActivityLogs
| where TimeGenerated > ago(4d) and UserId == '4624cd8c-6c94-4593-b0d8-a4983d797ccb'
| join kind=leftouter (union
SigninLogs,
AADNonInteractiveUserSignInLogs,
AADServicePrincipalSignInLogs,
AADManagedIdentitySignInLogs,
ADFSSignInLogs
| where TimeGenerated > ago(4d))
on $left.SignInActivityId == $right.UniqueTokenIdentifier
```

:::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/kusto-query.png" alt-text="Screenshot of KQL query results showing joined logs.":::

For more information about queries in Log Analytics Workspace, see [Analyze Microsoft Entra activity logs with Log Analytics](/azure/active-directory/reports-monitoring/howto-analyze-activity-logs-log-analytics).


## Scenario walkthrough

Let's walk through an example where a user logs into office.com. Then the user accesses Microsoft Graph, and executes some commands. Finally, the user access Exchange Online to use Outlook email, and do some mail operations.

1. Find the interactive login log line in the sign in logs, and capture the `SessionId`:

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/sign-in-log-session-id.png" alt-text="Screenshot of interactive sign-in log line with session ID.":::

1. Add a filter by `SessionId`. You can get the `SessionId` for interactive or noninteractive sign-ins.

   **Interactive sign-ins:**

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/interactive-sign-in.png" alt-text="Screenshot of interactive sign-ins filtered by session ID.":::

   **Noninteractive sign-ins:**

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/noninteractive-sign-in.png" alt-text="Screenshot of non-interactive sign-ins filtered by session ID.":::

1. To get all the activities on Microsoft Graph workload done by the user within this specific session, go to Log Analytics in Microsoft Entra portal and run the query to join Microsoft Entra sign in logs and Microsoft Graph Activity logs. The following query filters by `UserId` and `SessionId`.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/graph-filter.png" alt-text="Screenshot of Microsoft Graph activities filtered by user ID and session ID.":::

   Further filtering can be done on a `SignInActivityId` (uti claim) attribute to learn more about the access by specific request.

1. To get Exchange Online activities, open the Microsoft Purview portal and search by Users or Record Types.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/purview-record-types.png" alt-text="Screenshot of Microsoft Purview portal showing search by Users or Record Types.":::

1. Export the data.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/export-data.png" alt-text="Screenshot of data export in Microsoft Purview portal.":::

1. The log entry has all of the linkable identifiers. You can search by `UniqueTokenId` for each unique activity, and search by `AADSessionId` for all activities within the session.

   :::image type="content" border="true" source="media/concept-certificate-based-authentication-linkable-identifiers/search-token-id.png" alt-text="Screenshot of log line with linkable identifiers.":::

## Related content

[Microsoft Entra certificate-based authentication technical deep dive](concept-certificate-based-authentication-technical-deep-dive.md)
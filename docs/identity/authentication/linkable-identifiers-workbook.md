---
title: Linkable identifiers in Microsoft Entra
description: Learn about linkable identifiers in Microsoft Entra, including session IDs and unique token identifiers, and how they aid in tracking and investigating identity-related activities.
ms.topic: conceptual
ms.date: 03/22/2025
ms.author: justinha
author: vimrang
manager: femila
ms.reviewer: vraganathan
---

# Linkable identifiers

Microsoft will include certain identifiers in all tokens that can be used to link activities from one root authentication. Linkable identifiers will also be exposed in customer-facing logs which will aid customers, especially threat hunters, to investigate and remediate identity-related attacks. The implementation of linkable identifiers significantly improves the ability of security analysts and professionals to track, investigate, and remediate identity-related attacks across sessions and tokens, providing customers with a more secure and transparent ecosystem.

There are two types of linkable identifiers:

- one that is Session ID based that helps link all authentication artifacts issued from a single root authentication with the same identifier, which can be used to link/connect tokens in a single chain together. An example would be to track all the activities done by all the access tokens issued from a long-lived token like [refresh token (RT)](/entra/identity-platform/refresh-tokens) or Session cookies.
- another that will help track activities done by a specific token access like [access token](/entra/identity-platform/access-tokens) (AT) or [ID token](/entra/identity-platform/id-tokens).

To help link all authentication artifacts issued from a single root authentication the session id (SID) claim is created and included in primary refresh tokens (PRT)/Refresh token/Session cookie each time a user performs an interactive authentication for an account. The same sid value would be added to each access token issued from a refresh token or in session cookie so it can be used to link all authentication artifacts and can further be granularly filtered for a specific user or device within a session.

SID-based scenarios include:

- Start with a session ID from Microsoft Entra sign in logs and join with workload logs like Exchange Online audit logs or MSGraph activity logs to identify all the activities done by all the access tokens with the same session id.
- Filter out results further by User Id or Device Id or with token issued time frame within a specific session.
- Determine how many sessions are alive for a given user (UserId) or a given device (DeviceId).

In addition, Microsoft Entra has another important linkable security claim called UTI (unique token identifier) that is a unique GUID present in all Microsoft Entra tokens. It serves to uniquely identify a token/request.

For token investigation, UTI gives finer granularity when we want to track down a particular suspicious token as UTI is unique for every AT and session id helps investigate all the tokens within a specific session. Refer to [Access token](/entra/identity-platform/access-tokens) or [ID token](/entra/identity-platform/id-tokens) for more details on these claims.

UTI based scenarios include

- Start with a Unique Token Identifier (which points to a specific access token) from Microsoft Entra sign in logs and join with workload logs like Exchange Online audit logs or MSGraph activity logs to identify all the activities done on behalf of the access token (UTI).

## Linkable identifier claims

| **Claim** | **Format**            | **Description**                                                                                                                                                                                              |
|-----------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| oid       | String, a GUID        | The immutable identifier for the requestor, which is the verified identity of the user or service principal. This ID uniquely identifies the requestor across applications.                                  |
| tid       | String, a GUID        | Represents the tenant that the user is signing in to.                                                                                                                                                        |
| sid       | String, a GUID        | Represents a unique identifier for an entire session and will be generated when a user does interactive authentication and helps link all authentication artifacts issued from a single root authentication. |
| deviceid  | String, a GUID        | Represents a unique identifier for the device from which a user is interacting with an application.                                                                                                          |
| uti       | String                | Represents Token identifier claim, Unique, per-token identifier that is case-sensitive.                                                                                                                      |
| iat       | int, a Unix timestamp | Specifies when the authentication for this token occurred.                                                                                                                                                   |

As of now, linkable identifiers are logged into Microsoft Entra sign in logs, Exchange Online Audit logs and MSGraph Activity logs.

## Linkable identifiers in Microsoft Entra sign in logs

Sign in log entry will have the following linkable identifier claims under the attributes below.

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
3. Filter by time or by specific user to look at the specific logs.
4. Click on any sign-in log entry.
5. In **Basic Info** tab, you will see User ID, Resource Tenant ID, Session ID, Unique Token Identifier and Date and in Devices Tab you will see Device ID (only for registered and domain joined device).

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/eb1f41a17125177ac3647a90be797db0faa29626.png" alt-text="Screenshot of sign-in log entry in Microsoft Entra admin center.":::

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/5daef6542a9d904ccdbe4f143cf2ac66184920b3.png" alt-text="Screenshot of sign-in log entry details in Microsoft Entra admin center.":::

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/image3.png" alt-text="Screenshot of sign-in log entry with linkable identifiers.":::

Customers should start with Microsoft Entra sign-in logs UTI attribute and manually search on the workload audit logs to track all the activities using a specific access token. Similarly, session ID attribute can be used to manually search on the workload audit logs to track all the activities.

## Exchange Online logs

Exchange online (EXO) audit logs will help provide organization access to critical audit log event data to gain insight and further investigate user activities. EXO will carry forward the linkable identifiers from Microsoft Entra tokens and will log all the linkable identifiers in the EXO audit logs.

For scenarios involving exchange online like mailbox update, items moved or deleted, customers can start with linkable identifiers from Microsoft Entra sign in logs and search Microsoft Purview Audit (Standard) and Audit (Premium) to track all user actions on any items in a mailbox. More info on how to search EXO audit logs at [Search the audit log | Microsoft Learn](https://learn.microsoft.com/en-us/purview/audit-search?tabs=microsoft-purview-portal)

| **Claim** | **EXO audit log attribute name**                              |
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

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/image4.png" alt-text="Screenshot of Microsoft Purview portal showing search for logs.":::

3. You can further filter out for a specific user or an UTI value from Microsoft Entra sign-in logs. You can filter all the activity log within a session with session id.
4. The results log item will show all the linkable identifiers.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/image5.png" alt-text="Screenshot of Microsoft Purview portal showing log item with linkable identifiers.":::

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/image6.png" alt-text="Screenshot of Microsoft Purview portal showing detailed log item.":::

5. Export the audit log and investigate for a specific session ID or Unique Token Identifier for all the activities on exchange online.

### View Exchange Online logs using PowerShell commandlets

More info on Exchange Online PowerShell <https://learn.microsoft.com/en-us/powershell/exchange/exchange-online-powershell?view=exchange-ps>

1. Open a power shell as an administrator.
2. If ExchangeOnlineManagement module is not installed, run Install-Module -Name ExchangeOnlineManagement.
3. Connect-ExchangeOnline -UserPrincipalName <user@4jkvzv.onmicrosoft.com>.
4. Run some mailbox commands
  1. Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 97MB.
  2. Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 98MB.
  3. Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 99MB.
5. Search-UnifiedAuditLog -StartDate 01/06/2025 -EndDate 01/08/2025 -RecordType ExchangeItem, ExchangeAdmin, ExchangeAggregatedOperation, ExchangeItemAggregated, ExchangeItemGroup, ExchangeSearch.
6. Results will have all the linkable identifiers.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/image7.png" alt-text="Screenshot of PowerShell command results showing linkable identifiers.":::

> [!NOTE]
> The linkable identifiers will not be available in the EXO audit logs on some aggregated log lines as well as logs generated from background processes.

## Microsoft Graph activity logs

Microsoft Graph activity logs are an audit trail of all HTTP requests that the Microsoft Graph service received and processed for a tenant. The logs are stored in Log Analytics for analysis.

If you send Microsoft Graph activity logs to a Log Analytics workspace, you can query the logs using Kusto Query Language (KQL). For scenarios involving MSGraph activity customers can start with linkable identifiers from Microsoft Entra sign in logs and check against MSGraph activity logs to track all user actions on any items in a mailbox. More info on how to search MSGraph activity logs at [Microsoft Graph Activity Logs](https://learn.microsoft.com/en-us/graph/microsoft-graph-activity-logs-overview)

| **Claim** | **EXO audit log attribute name**                              |
|-----------|---------------------------------------------------------------|
| oid       | UserId                                                        |
| tid       | TenantId                                                      |
| sid       | SessionId                                                     |
| deviceid  | DeviceId (Available only for registered/domain joined device) |
| uti       | SignInActivityId                                              |
| iat       | TokenIssuedAt                                                 |

### Join Sign in logs and MS Graph activity logs using KQL

For more information about queries in Log Analytics Workspace, see [Analyze Microsoft Entra activity logs with Log Analytics](https://learn.microsoft.com/en-us/azure/active-directory/reports-monitoring/howto-analyze-activity-logs-log-analytics).

1. Join Microsoft Entra sign-in logs and Microsoft Graph Activity logs and filter logs by uti attribute to analyze all the activities by a specific access token or by sid claim to analyze all activities of all access tokens from a refresh token obtained from a root interactive authentication. The log can be filtered further using other attributes like UserId, DeviceId etc.

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

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/b8e45d8711cbedf25985ba039176c8a39ae33c73.png" alt-text="Screenshot of KQL query results showing joined logs.":::

## Scenario walkthrough

A user logs into office.com, then accesses Microsoft Graph and executes some commands, access exchange online outlook mail and does some mail operations.

Find the interactive login log line in sign in log and capture the session Id

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/a1d1e8a46c7fa961f02a7d98dbd7f0696cbf75c1.png" alt-text="Screenshot of interactive login log line with session ID.":::

1. Add a filter by session id to get all the interactions by the session id. You can do this on interactive as well as non-interactive sign-ins.

**Interactive sign-ins:**

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/3888625612e28330f31f8afa33e0b7bff8ba5b3f.png" alt-text="Screenshot of interactive sign-ins filtered by session ID.":::

**Non-interactive sign-ins:**

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/81b7f95ba4d4c799cf9ca299e62ff7bf5964d312.png" alt-text="Screenshot of non-interactive sign-ins filtered by session ID.":::

2. MS Graph activities: To get all the activities on MSGraph workload done by the user within this specific session go to Log Analytics in Microsoft Entra portal and run the query to join Microsoft Entra sign in logs and MSGraph Activity logs. Below is a query filtered by UserId and Session Id.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/ac4cbc25396e718846c8dc0053c7fbfdac630184.png" alt-text="Screenshot of MS Graph activities filtered by UserId and Session Id.":::

Further filtering can be done on a SignInActivityId (uti claim) attribute to learn more about the access by specific request.

3. Exchange online activities: Go to Microsoft Purview portal and search by Users or Record Types.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/1b385941245d902a0bcf92cc810ba15546758e56.png" alt-text="Screenshot of Microsoft Purview portal showing search by Users or Record Types.":::

4. Export the data.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/9b0d315949cdf7a76c43900d95e0d2022b751618.png" alt-text="Screenshot of data export in Microsoft Purview portal.":::

5. The log line will have all the linkable identifiers, and you can search by UniqueTokenId for each unique activity and AADSessionId for all activities within the session.

:::image type="content" source="media/concept-certificate-based-authentication-linkable-identifiers/2ccca9b3adbbc45c25d82ec3bd90d4943a2985a7.png" alt-text="Screenshot of log line with linkable identifiers.":::

---
title: Data collection for dynamic permissions
description: Learn what Snowflake data Microsoft Entra ID Governance dynamic permissions collects, including identity, access, configuration, and activity metadata.
ms.topic: reference
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
# Customer intent: As an administrator, I want to understand what data is collected from supported applications so that I can evaluate the data requirements for permission remediation.
---

# Data collection for dynamic permissions

This reference describes data read by Microsoft Entra ID Governance dynamic permissions for permission remediation from the Snowflake application. This information is leveraged by Microsoft Entra for analyzing non-human identities and ensuring least privilege.

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

## Permissions required for dynamic permissions

Dynamic permissions relies on the effective privileges of the connection identity in each supported application to:

- **Detect excessive access:** Read the identity, role, permission, and activity metadata needed to evaluate agent access.
- **Remediate excessive access:** Revoke or adjust supported role assignments to right-size access, or disable supported identities.
- **Assign task-scoped permissions:** Grant and revoke supported access for an approved task.

The required privileges and supported operations depend on the application.

## Snowflake

When Microsoft Entra is integrated with Snowflake for dynamic permissions, then Microsoft Entra reads Snowflake metadata about users, roles, permissions, objects, security configuration, and activity. Collection depends on the connector's privileges, Snowflake visibility rules, and the features available in your account.


### Identity and configuration data

The following table summarizes the forms of metadata which may be collected.

| Category | Data collected |
| --- | --- |
| Users | User identifiers, names, email addresses, user types, account status, timestamps, session defaults, ownership, comments, and authentication-configuration indicators. |
| Roles and grants | Account, database, application, and instance roles; role properties; privilege grants; user and role assignments; role hierarchies; and grants to Snowflake Native Apps. Grant details include the privilege, object, recipient, grant option, grantor role, and timestamps. |
| Future grants | Definitions of privileges to apply automatically to new objects, including the recipient role, object type, and database or schema scope. These aren't grants on existing objects. |
| Objects and account information | Inventory and properties of database and data objects, compute resources, processing objects, functions, procedures, AI objects, applications, and security objects. Metadata can include names, identifiers, owners, comments, timestamps, object definitions, and service endpoint details. Account context includes organization, account, region, and Snowflake version. |
| Security configuration | Security integration properties exposed by Snowflake, including integration type and enabled status; the account setting for blocking privileged roles in External OAuth; and network and authentication policy inventory. Collection doesn't include every network or authentication policy's full definition. |
| Selected tags | Selected sensitivity, classification, criticality, environment, certification, privacy, and semantic tags. Collected data includes tag values and direct object or column associations, not every tag value or inherited association. |

User authentication indicators describe whether credentials or authentication methods are configured. They aren't password, private-key, or token values.

Role and grant records describe assignments and hierarchies, not a precomputed list of every user's effective privileges.

### Activity data

The default activity lookback is 90 days. This window applies to activity queries, not all metadata collection.

| Activity source | Data collected |
| --- | --- |
| [Login history](https://docs.snowflake.com/en/sql-reference/account-usage/login_history) | The latest successful login per identified user within the collection window, rather than all login attempts. Details include event time, user name, client IP address, client type, authentication factors, and connection information. |
| [Query history](https://docs.snowflake.com/en/sql-reference/account-usage/query_history) | Aggregated query activity by user, role, query type, execution status, errors, and warehouse. Summaries include query counts and first and last occurrence times. Both successful and unsuccessful activity can be represented. Executed SQL text isn't selected. |
| [Access history](https://docs.snowflake.com/en/sql-reference/account-usage/access_history) | Aggregated activity for directly referenced objects, underlying objects, and modified objects. Details include users, object identifiers and types, query counts, latest activity time, and accessed or modified column names. |

Access history collection doesn't include every field in the source view. Collected column names aren't a complete inventory of every column in every table.

### Data boundaries and limitations

This collection doesn't query business-data rows from Snowflake customer-defined tables or select executed SQL text from query history.


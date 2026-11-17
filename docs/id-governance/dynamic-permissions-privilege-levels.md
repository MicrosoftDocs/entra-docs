---
title: Privilege levels for dynamic permissions
description: Learn how Microsoft Entra ID Governance categorizes privilege levels and which Snowflake permissions and roles are flagged as critical during preview.
ms.topic: reference
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1032
ai-usage: ai-generated
#customer intent: As an administrator, I want to identify critical permissions and roles so that I can understand why dynamic permissions flags AI agents.
---

# Privilege levels for dynamic permissions

Microsoft Entra ID Governance dynamic permissions uses a canonical privilege-classification model to categorize permissions and roles into four levels: **Low**, **Medium**, **High**, and **Critical**.

Applications and resources express access differently, using their own permissions, roles, and authorization constructs. The canonical model maps those application-specific constructs to a common set of privilege levels. This gives organizations a consistent way to understand and assess privilege across supported Microsoft and non-Microsoft applications and resources, without replacing their native authorization models.

The model is designed to scale across applications and resource types. Privilege level reflects the intrinsic authority a permission or role grants, independently of the sensitivity or business criticality of the application or resource. It describes what the permission allows an identity to do, not how sensitive the target resource or its data is.

For example, a permission classified as **Critical** because it allows granting access to others or changing security controls remains **Critical** in a test subscription containing only test data. The lower sensitivity of that environment doesn't reduce the permission's intrinsic authority.

The permission classification level alone isn't a complete assessment of the risk that access poses in a particular environment. Privilege level is one of multiple inputs that dynamic permissions uses alongside others, such as resource sensitivity.

During preview, dynamic permissions flags AI agents that have permissions or roles categorized as **Critical**. This reference lists the Snowflake permissions and roles currently classified as **Critical**.

Microsoft continually reassesses and updates privilege-level classifications. The classifications in this reference were last refreshed on **2026-11-12**.

[!INCLUDE [Dynamic permissions licensing](~/includes/licensing-dynamic-permissions.md)]

## How privilege levels are determined

Microsoft evaluates the documented capabilities of each permission or role and applies reviewed classification rules to the authority those capabilities provide. The following table summarizes typical capabilities at each level.

| Privilege level | Typical authority |
| --- | --- |
| **Low** | View metadata about resources, without reading their content or changing them. |
| **Medium** | Read content, use services or functions, perform limited operations, create objects within a bounded scope, or view broader metadata. |
| **High** | Modify existing resources, run automation, control broader operations, or perform destructive lifecycle actions. |
| **Critical** | Own resources, grant access to others, control credentials, change security policies or boundaries, control an organization, or execute code with the permissions of its owner. |

If a permission provides capabilities at multiple levels, the highest applicable level determines its classification. For roles, dynamic permissions evaluates their permissions and capabilities, along with relevant role hierarchies and inheritance relationships, to determine the overall privilege level.

These descriptions explain the classification model across all four levels. The application-specific reference in this article currently lists only Snowflake permissions and roles classified as **Critical** during preview.

## Snowflake critical privileges

All 197 Snowflake permissions and five account roles listed in the expandable sections are categorized as **Critical** during the dynamic permissions preview. Expand a section to see the identifiers.

### Critical account permissions

<details>
<summary>Show 47 critical account permissions</summary>

These account-level permission identifiers have the **Critical** privilege level.

:::row:::
    :::column:::
        - `snowflake:account:apply-aggregation-policy`
        - `snowflake:account:apply-authentication-policy`
        - `snowflake:account:apply-backup-retention-lock`
        - `snowflake:account:apply-data-movement-policy`
        - `snowflake:account:apply-join-policy`
        - `snowflake:account:apply-legal-hold`
        - `snowflake:account:apply-maintenance-policy`
        - `snowflake:account:apply-masking-policy`
        - `snowflake:account:apply-multi-party-approval-policy`
        - `snowflake:account:apply-packages-policy`
        - `snowflake:account:apply-password-policy`
        - `snowflake:account:apply-privacy-policy`
        - `snowflake:account:apply-projection-policy`
        - `snowflake:account:apply-resource-group`
        - `snowflake:account:apply-row-access-policy`
        - `snowflake:account:apply-session-policy`
        - `snowflake:account:apply-snapshot-retention-lock`
        - `snowflake:account:attach-policy`
        - `snowflake:account:bind-service-endpoint`
        - `snowflake:account:create-account`
        - `snowflake:account:create-external-access-integration`
        - `snowflake:account:create-integration`
        - `snowflake:account:create-organization-user`
        - `snowflake:account:create-organization-user-group`
    :::column-end:::
    :::column:::
        - `snowflake:account:create-security-integration`
        - `snowflake:account:full-management`
        - `snowflake:account:grant-management`
        - `snowflake:account:import-organization-user-groups`
        - `snowflake:account:manage-accounts`
        - `snowflake:account:manage-application-specifications`
        - `snowflake:account:manage-caller-grants`
        - `snowflake:account:manage-cortex-extension-security-scan`
        - `snowflake:account:manage-event-sharing`
        - `snowflake:account:manage-firewall-configuration`
        - `snowflake:account:manage-grants`
        - `snowflake:account:manage-listing-auto-fulfillment`
        - `snowflake:account:manage-organization-access`
        - `snowflake:account:manage-organization-terms`
        - `snowflake:account:manage-organization-user-groups`
        - `snowflake:account:manage-organization-users`
        - `snowflake:account:manage-postgres-private-connectivity`
        - `snowflake:account:manage-service-caller-access`
        - `snowflake:account:manage-share-target`
        - `snowflake:account:manage-tenants`
        - `snowflake:account:override-share-restrictions`
        - `snowflake:account:ownership`
        - `snowflake:account:read-unredacted-error-table`
    :::column-end:::
:::row-end:::

</details>

### Critical object permissions

<details>
<summary>Show 150 critical object permissions</summary>

These object-level permission identifiers have the **Critical** privilege level.

:::row:::
    :::column:::
        - `snowflake:agent:ownership`
        - `snowflake:aggregation-policy:apply`
        - `snowflake:aggregation-policy:ownership`
        - `snowflake:ai-gateway:ownership`
        - `snowflake:alert:ownership`
        - `snowflake:application-package:grant-management`
        - `snowflake:application-package:ownership`
        - `snowflake:application-service:ownership`
        - `snowflake:application:grant-management`
        - `snowflake:application:ownership`
        - `snowflake:artifact-repository:ownership`
        - `snowflake:authentication-policy:apply`
        - `snowflake:authentication-policy:ownership`
        - `snowflake:backup-policy:apply`
        - `snowflake:backup-policy:ownership`
        - `snowflake:backup-set:ownership`
        - `snowflake:budget:ownership`
        - `snowflake:class:ownership`
        - `snowflake:code-bundle:ownership`
        - `snowflake:compute-pool:ownership`
        - `snowflake:connection:ownership`
        - `snowflake:contact:ownership`
        - `snowflake:cortex-agent-server:ownership`
        - `snowflake:cortex-extension:ownership`
        - `snowflake:cortex-search-service:ownership`
        - `snowflake:custom-runtime-environment:ownership`
        - `snowflake:data-connectivity-proxy:ownership`
        - `snowflake:data-exchange-listing:ownership`
        - `snowflake:data-exchange-profile:ownership`
        - `snowflake:data-exchange:ownership`
        - `snowflake:data-metric-function:ownership`
        - `snowflake:data-movement-policy:ownership`
        - `snowflake:data-movement-rule:ownership`
        - `snowflake:database-role:ownership`
        - `snowflake:database:grant-management`
        - `snowflake:database:manage-grants`
        - `snowflake:database:ownership`
        - `snowflake:dataset:ownership`
        - `snowflake:dbt-project-object:ownership`
        - `snowflake:dbt-project:ownership`
        - `snowflake:dcm-project:ownership`
        - `snowflake:directory-table:ownership`
        - `snowflake:dynamic-table:ownership`
        - `snowflake:event-table:ownership`
        - `snowflake:experiment:ownership`
        - `snowflake:external-consumer:ownership`
        - `snowflake:external-function:ownership`
        - `snowflake:external-table:ownership`
        - `snowflake:external-volume:ownership`
        - `snowflake:failover-group:ownership`
        - `snowflake:feature-policy:ownership`
        - `snowflake:file-format:ownership`
        - `snowflake:function:ownership`
        - `snowflake:gateway:ownership`
        - `snowflake:git-repository:ownership`
        - `snowflake:gscluster:ownership`
        - `snowflake:gssubcluster:ownership`
        - `snowflake:hybrid-table:ownership`
        - `snowflake:iceberg-table:ownership`
        - `snowflake:image-repository:ownership`
        - `snowflake:integration:ownership`
        - `snowflake:integration:use-any-role`
        - `snowflake:interactive-table:ownership`
        - `snowflake:internal-marketplace-config:ownership`
        - `snowflake:join-policy:apply`
        - `snowflake:join-policy:ownership`
        - `snowflake:machine-learning-experiment:ownership`
        - `snowflake:maintenance-policy:apply`
        - `snowflake:maintenance-policy:ownership`
        - `snowflake:masking-policy:apply`
        - `snowflake:masking-policy:ownership`
        - `snowflake:materialized-view:ownership`
        - `snowflake:mcp-server:ownership`
        - `snowflake:metadata-connector:ownership`
        - `snowflake:migration:ownership`
    :::column-end:::
    :::column:::
        - `snowflake:model-monitor:ownership`
        - `snowflake:model:ownership`
        - `snowflake:multi-party-approval-policy:apply`
        - `snowflake:native-app:ownership`
        - `snowflake:network-policy:ownership`
        - `snowflake:network-policy:usage`
        - `snowflake:network-rule:ownership`
        - `snowflake:notebook:ownership`
        - `snowflake:online-feature-table:ownership`
        - `snowflake:openflow-deployment:ownership`
        - `snowflake:openflow-runtime:ownership`
        - `snowflake:organization-profile:ownership`
        - `snowflake:packages-policy:apply`
        - `snowflake:packages-policy:ownership`
        - `snowflake:password-policy:apply`
        - `snowflake:password-policy:ownership`
        - `snowflake:pipe:ownership`
        - `snowflake:postgres-instance:ownership`
        - `snowflake:privacy-policy:apply`
        - `snowflake:privacy-policy:ownership`
        - `snowflake:procedure:ownership`
        - `snowflake:projection-policy:apply`
        - `snowflake:projection-policy:ownership`
        - `snowflake:provisioned-throughput:ownership`
        - `snowflake:replication-group:ownership`
        - `snowflake:resource-group:ownership`
        - `snowflake:resource-monitor:ownership`
        - `snowflake:restricted-session-scope:ownership`
        - `snowflake:role:ownership`
        - `snowflake:row-access-policy:apply`
        - `snowflake:row-access-policy:ownership`
        - `snowflake:schema-variable:ownership`
        - `snowflake:schema:create-function`
        - `snowflake:schema:create-procedure`
        - `snowflake:schema:grant-management`
        - `snowflake:schema:manage-grants`
        - `snowflake:schema:ownership`
        - `snowflake:secret:modify`
        - `snowflake:secret:ownership`
        - `snowflake:secret:read`
        - `snowflake:secret:usage`
        - `snowflake:semantic-view:ownership`
        - `snowflake:sequence:ownership`
        - `snowflake:service-class:ownership`
        - `snowflake:service:ownership`
        - `snowflake:session-policy:apply`
        - `snowflake:session-policy:ownership`
        - `snowflake:share:attach-listing`
        - `snowflake:share:ownership`
        - `snowflake:snapshot-policy:ownership`
        - `snowflake:snapshot-set:ownership`
        - `snowflake:snapshot:ownership`
        - `snowflake:snowflake-intelligence:ownership`
        - `snowflake:stage:ownership`
        - `snowflake:storage-lifecycle-policy:ownership`
        - `snowflake:stored-procedure:ownership`
        - `snowflake:stream:ownership`
        - `snowflake:streamlit:ownership`
        - `snowflake:table:ownership`
        - `snowflake:tag:ownership`
        - `snowflake:task:ownership`
        - `snowflake:type:ownership`
        - `snowflake:user-defined-function:ownership`
        - `snowflake:user-defined-types:ownership`
        - `snowflake:user:apply-authentication-policy`
        - `snowflake:user:apply-password-policy`
        - `snowflake:user:apply-session-policy`
        - `snowflake:user:impersonate`
        - `snowflake:user:modify-programmatic-authentication-methods`
        - `snowflake:user:ownership`
        - `snowflake:view:ownership`
        - `snowflake:volume:ownership`
        - `snowflake:warehouse:ownership`
        - `snowflake:workspace:ownership`
        - `snowflake:zerocopy-connector:ownership`
    :::column-end:::
:::row-end:::

</details>

### Critical account roles

<details>
<summary>Show 5 critical account roles</summary>

These account role identifiers have the **Critical** privilege level.

- `snowflake:account-role:accountadmin`
- `snowflake:account-role:globalorgadmin`
- `snowflake:account-role:orgadmin`
- `snowflake:account-role:securityadmin`
- `snowflake:account-role:useradmin`

</details>

---
title: Prepare your Snowflake account for discovery and identity governance connectivity
description: Prepare a Snowflake account for discovery and identity governance connectivity with a dedicated service user.
author: AlexFilipin
ms.author: alfilipi
ms.service: entra-id-governance
ms.topic: include
ms.date: 11/16/2026
ms.custom: include file, msecd-doc-authoring-1032
ai-usage: ai-generated
---

> [!NOTE]
> Microsoft recommends previewing this capability with a non-production or test Snowflake account. The preview script grants the dedicated service user the `ACCOUNTADMIN` role. Microsoft is partnering with Snowflake to unify advanced identity governance connectivity and the System for Cross-domain Identity Management (SCIM) connection between Snowflake and Microsoft Entra. A future update will move both connections to a single, least-privilege, workload identity-based authentication approach.

The current preview configuration below allows connections from any IPv4 address (`0.0.0.0/0`) and requires programmatic access token (PAT) authentication.

1. Sign in to your Snowflake account as a user with the `ACCOUNTADMIN` role.
1. Open a SQL worksheet in your Snowflake workspace and paste the following script into it. Don't run the script until you update the warehouse name. The warehouse name is case sensitive. The script creates a dedicated service user, assigns the `ACCOUNTADMIN` role, configures a network policy, and generates a PAT:

    ```sql
    USE ROLE ACCOUNTADMIN;

    -- This warehouse provides compute for recurring discovery queries.
    SET warehouse_name = 'REPLACE_WITH_YOUR_WAREHOUSE';

    CREATE USER IF NOT EXISTS ENTRA_ID_GOV_CONNECTIVITY_USER
      TYPE = SERVICE
      DEFAULT_ROLE = ACCOUNTADMIN
      DEFAULT_WAREHOUSE = $warehouse_name
      COMMENT = 'Snowflake connectivity service user for advanced Microsoft Entra ID Governance scenarios';
    GRANT ROLE ACCOUNTADMIN TO USER ENTRA_ID_GOV_CONNECTIVITY_USER;

    -- Snowflake's default PAT policy requires a network policy for service users to generate or use a PAT.
    CREATE NETWORK POLICY IF NOT EXISTS ENTRA_ID_GOV_CONNECTIVITY_NETWORK_POLICY
      ALLOWED_IP_LIST = ('0.0.0.0/0');
    ALTER USER ENTRA_ID_GOV_CONNECTIVITY_USER SET NETWORK_POLICY = ENTRA_ID_GOV_CONNECTIVITY_NETWORK_POLICY;

    ALTER USER ENTRA_ID_GOV_CONNECTIVITY_USER
      ADD PROGRAMMATIC ACCESS TOKEN snowflake_connector_token
      ROLE_RESTRICTION = 'ACCOUNTADMIN'
      DAYS_TO_EXPIRY   = 60
      COMMENT          = 'Snowflake connectivity PAT for advanced Microsoft Entra ID Governance scenarios';
    ```

1. Find the name of the warehouse you'll use for discovery.

    > [!NOTE]
    > The warehouse provides compute for connectivity. Discovery and remediation capabilities aren't limited to the selected warehouse. Query costs charged to the warehouse can vary based on the size of your Snowflake account.

1. In the worksheet, replace `REPLACE_WITH_YOUR_WAREHOUSE` in the `SET warehouse_name` statement with the warehouse name. The script uses this variable to set the service user's default warehouse.
1. Run the full script in the same worksheet so that the warehouse variable is available to the statements that use it.
1. Save the generated access token securely. You'll need it later when configuring discovery and identity governance connectivity in Microsoft Entra.

---
title: Govern agent access to data in Azure Database for PostgreSQL flexible server
description: Learn how to use Microsoft Entra agent ID identity governance and conditional access for an agent accessing an Azure Database for PostgreSQL database.
ms.topic: tutorial
ms.date: 10/28/2026
ms.author: mwahl
author: markwahl-msft
ms.service: entra-id
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to understand how to deploy an AI agent that is able to authenticate to a Azure Database for PostgreSQL database using a Microsoft Entra Agent ID and has permissions to interact in that database.

---

# Govern agent access to data in Azure Database for PostgreSQL flexible server

Microsoft Entra Agent ID provides a centralized set of tools for managing agent identities and their access to applications across your organization. This guide illustrates how to govern an agent with a Microsoft Entra Agent ID needing access to data in an example application, [Azure Database for PostgreSQL](https://azure.microsoft.com/products/postgresql/). Azure Database for PostgreSQL integrates with Microsoft Entra for authentication and authorization for service principals and agent identities.  For more information, see [Use Microsoft Entra ID authentication in Azure Database for PostgreSQL flexible server](/azure/postgresql/security/security-entra-configure).

In this tutorial, you configure Microsoft Entra and Azure Database for PostgreSQL so that an AI agent authenticates using its own Entra agent identity, and is authorized to interact with the database. You configure Microsoft Entra **Entitlement Management** access packages to set up the security group membership that grants the agent access to a table in the database. This enables additional agents to be able to obtain the same access as this agent, while maintaining their own identities and without needing to make changes to the database security principals.

## Prerequisites

[!INCLUDE [entra-agent-id-license](../includes/licensing-agent-id.md)]

You'll need to have an Azure Database for PostgreSQL server in an Azure subscription, with a database where you are an administrator. If you don't have one already, see [Quickstart: Create an Azure Database for PostgreSQL flexible server](/azure/postgresql/configure-maintain/quickstart-create-server).

You'll also need an agent which has a Microsoft Entra agent ID.

## Architecture

:::image type="content" source="media/govern-agent-access-azure-postgresql/database-authorization-components.png" alt-text="Diagram showing the relationship of the agent, Microsoft Entra components, and the Azure Database for PostgreSQL.":::

### Authentication interactions

The agent uses a two-step token exchange flow to obtain a short-lived access token for the Azure Database for PostgreSQL derived from its Microsoft Entra Agent ID. When the agent needs to use the database,

1. The agent authenticates to Microsoft Entra as an agent blueprint, providing blueprint credentials and an agent ID.
1. The agent exchanges at a Microsoft Entra authentication endpoint for an access token with the Azure Database scope.
1. The agent sends the security group name and that access token to the Azure Database for PostgreSQL server as the credential to authenticate.
1. Azure Database for PostgreSQL validates that the agent identity in the token is a member of the group, and therefore is authorized to act as the principal named by that group in the server's databases.

## Enable Microsoft Entra authentication and authorization for Azure Database for PostgreSQL

In this section, you'll enable agents to authenticate using Microsoft Entra agent ID to your database, and create a security group that you'll authorize to read a table named `employees` in a database.

### Create a security group for authorization to read from a PostgreSQL data set

1. In the Microsoft Entra Admin Center, go to **Microsoft Entra ID**, select **Groups**, and select **New group**.
1. Set **Group type** to **Security**.
1. Enter a **Group name** such as `pg-employees-readers`. Keep the name short; you will use it verbatim inside PostgreSQL.
1. Leave membership type as **Assigned**, as Entitlement Management will be used to assign membership. Do not add any members yet. 
1. Select **Create**.
1. After creation, open the group and note the name and Object ID, which you'll use when creating the principal and role assignment in the PostgreSQL database.

### Enable Microsoft Entra authentication in Azure Database for PostgreSQL

If you have not enabled Microsoft Entra authentication in the database, then do so to allow the agent to use a Microsoft Entra agent ID. If you have already configured Microsoft Entra authentication, then continue at the next section.

1. In the [Azure portal](https://portal.azure.com), open your **Azure Database for PostgreSQL** resource.
2. In the left menu, go to **Security** > **Authentication**.
3. Under **Microsoft Entra authentication**, toggle **Enable** to on.
4. Select **Add Microsoft Entra Admins**.
5. Search for and select your own account (or a group of database administrators). This account will have the ability to perform operations inside PostgreSQL as a superuser-equivalent Entra identity.
6. Select **Save**.

> [!IMPORTANT]
> Enabling Entra authentication does not disable password authentication. If you want to enforce Entra-only connections, additionally set the server parameter `azure.enable_passwordless_auth=on` (preview) or remove the local `postgres` superuser password and rely solely on Entra identities.

### Create a table in the database

Connect to your Azure Database for PostgreQL server using the Entra admin account you just configured. 

Once connected, confirm you have an `employees` table. If you don't have a table with that name in your PostgreSQL database, connect to PostgreSQL and create that table. 

### Create the database role for the security group to read from that database

Create a PostgreSQL principal for the security group created earlier, and grant it SELECT access on the `employees` table:

```sql
-- Create a role whose name matches the Entra security group name exactly (case-sensitive)
SELECT pgaadauth_create_principal('pg-employees-readers', false, false);

-- Grant the group role read access to the employees table
GRANT SELECT ON TABLE employees TO "pg-employees-readers";
```

> [!NOTE]
> `pgaadauth_create_principal` is a helper function provided by the `pgaadauth` extension that Azure Database for PostgreSQL loads automatically when Entra authentication is enabled. The second parameter controls whether the role is a superuser; always set it to `false` for agent identities. The third parameter controls whether login is enabled on the role itself; set it to `false` because individual Microsoft Entra ID principals (not the group role) will log in.

Then, verify the role and grant are present.

```sql
-- List Entra-authenticated roles
SELECT * FROM pgaadauth_list_principals(false);

-- Confirm the table grant
\dp employees
```

You should see `pg-employees-readers` listed with `r` (SELECT) privileges on the `employees` table.

## Create an access package to assign agent identites to the security group

Entitlement Management lets you define an *access package* that bundles the security group membership and attach a policy describing how identities, including agent identities, can request access.

### Create a catalog to contain the access package

1. In the Entra Admin Center, go to **Identity Governance** > **Entitlement management** > **Catalogs**.
1. Select to create a **New catalog**.
1. Name it `AI Agents` and provide a description. Set **Enabled** to **Yes**. Select **Create**.
1. Open the new catalog and choose **Resources** > **Add resources**.
1. Select **Groups and teams**, find and select `pg-employees-readers`, then choose **Add**.

### Create the access package

1. In the catalog, change to **Access packages**.
1. Select **New access package**.
1. On the **Basics** tab:
   * **Name**: `Employee Database Readers`
   * **Catalog**: `AI Agents`
   * Select **Next: Resource roles**.
1. On the **Resource roles** tab:
   * Select **Groups and teams**, choose `pg-employees-readers`.
   * Set the role to **Member**.
   * Select **Next: Requests**.
1. On the **Requests** tab:
   * Under **Who can request access**, select **None (administrator direct assignments only)**. In this first policy, a human administrator controls which agent identities get access; the agent never self-requests.
   * Select **Next: Requestor information**, skip optional questions, **Next: Lifecycle**.
1. On the **Lifecycle** tab:
   * Set **Access package assignment expires** to an appropriate duration (for example, 180 days).
   * Select **Next: Rules**, then **Next: Review + create**.
1. Select **Create**.


## Register an agent blueprint and agent identity in Microsoft Entra

In this section, you'll create the representation of the agent in Microsoft Entra.

1. Ensure you are signed into the Entra Admin Center as a user in the **Agent ID Developer** or **Agent ID Administrator** roles.
1. Navigate to **Agents**, **Agent Blueprints**, and select **New agent blueprint (Preview)**.
1. Give the agent a name such as `EmployeeAgentIdentity`, and confirm the sponsor.
1. One the blueprint is created, navigate to the blueprint, select **Credentials (Preview)**, select **Client secrets**, and select **New client secret**.
1. Record the displayed client secret value.
1. Change to the **Overview (Preview)** tab, and record the blueprint app ID and blueprint principal object ID.
1. Change to the **Linked agent identities (Preview)** tab, select the agent identity. Record the object ID.

For more information on other options for how agent identities are created in Microsoft Entra, see [How are agent identities created?](agent-id-creation-channels.md).

## Authorize the agent identity using Microsoft Entra entitlement management

You can authorize the agent by directly assigning the agent identity to the access package.

1. In the Entra Admin Center, go to **Identity Governance** > **Entitlement management** > **Access packages**.
1. Open the **Employee Database Readers** access package created earlier.
1. Choose **Assignments** > **New assignment**.
1. Under **Select policy**, choose **Initial policy** (or the administrator assignment policy you created).
1. Under **Select user or service principal**, search for and select `EmployeeAgentIdentity`.
1. Set the assignment end date consistent with the lifecycle policy.
1. Select **Add**.

After the assignment request is processed, usually within a few minutes, `EmployeeAgentIdentity` becomes a member of the `pg-employees-readers` security group.

> [!NOTE]
> You can verify group membership in the Microsoft Entra Admin Center, by changing to **Microsoft Entra ID** > **Groups**, Selecting **pg-employees-readers** and viewing the **Members**.

---

## Agent connects to the database

Now that the agent's identity is a member of the security group, when it connects to the Azure Database for PostgreSQL server, the server can validate its identity and check its authorization for subsequent SQL calls. In order to connect to the database, the agent first obtains a token for the database as a resource.

:::image type="content" source="media/agent-autonomous-app-oauth-flow/autonomous-app-flow-token-sequence.png" alt-text="Diagram showing the token sequence of autonomous app token acquisition flow for agents.":::

1. The agent authenticates to Microsoft Entra as the blueprint, and indicates the agent identity.

   In this step, the agent supplies the blueprint credentials and the identity of the agent ID, and receives an intermediate token. For more information on other authentication options, see [Agent autonomous app OAuth flow - App-only protocol](agent-autonomous-app-oauth-flow.md).

   ```
   POST https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token
   Content-Type: application/x-www-form-urlencoded

   grant_type=client_credentials
   &scope=api%3A%2F%2FAzureADTokenExchange%2F.default
   &client_id=<blueprint-client-id>
   &client_secret=<blueprint-client-secret>
   &Fmi_Path=<agent-id>
   ```

   In this step, Microsoft Entra ID checks:
   * The blueprint credentials are valid.
   * Conditional Access policies assigned to the blueprint principal are satisfied.
   * The `Fmi_Path` value resolves to a known agent identity within the tenant.

1. If the checks were successful, Microsoft Entra ID provides a response to the agent with the intermediate token. 

   This token consists of a short-lived JWT, the intermediate token, issued for the `api://AzureADTokenExchange` audience. 

1. The agent obtains from Microsoft Entra ID a PostgreSQL access token.

   In this step, the agent exchanges the intermediate token for an access token it can supply to the Azure Database for PostgreSQL.

   ```
   POST https://login.microsoftonline.com/<tenant-id>/oauth2/v2.0/token
   Content-Type: application/x-www-form-urlencoded

   grant_type=client_credentials
   &client_id=<agent-id>
   &scope=https%3A%2F%2Fossrdbms-aad.database.windows.net%2F.default
   &client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer
   &client_assertion=<intermediate-token>
   ```

   In this step, Microsoft Entra ID checks:
   * The intermediate token signature and audience are valid.
   * The `client_id` matches the agent identity registration.
   * Any Conditional Access policies assigned to the `EmployeeAgentIdentity` service principal are evaluated here. If the request violates the network or risk policy, Entra returns `conditional_access_failed` and the agent cannot connect.
   * The agent identity is not blocked or disabled.

1. If the checks are successful, Microsoft Entra ID provides a response with a token for the resource.

   The response includes a short-lived JWT access token issued for the `https://ossrdbms-aad.database.windows.net` audience. 

1. The agent connects to the database.

   When connecting, the agent uses the group name as the username, and the access token as the PostgreSQL user password. PostgreSQL then:
   1. Validates the token signature using Entra's public keys.
   1. Confirms the token audience is `https://ossrdbms-aad.database.windows.net`.

1. The agent sends a request to the database.

   Because the session included in the `groups` claim included `pg-employees-readers`, the session has the privileges associated with that role — including `SELECT` on the `employees` table.


## Related content

- [Assign agents to applications](/entra/identity/enterprise-apps/assign-agent-identities-to-applications)
- [Call Azure services](call-api-azure-services.md)
- [Conditional Access for agents](/entra/identity/conditional-access/agent-id)
- [ID Governance for agents](/entra/id-governance/agent-id-governance-overview)
- [Access packages for agents](agent-access-packages.md)
- [Microsoft Entra authentication in Azure Database for PostgreSQL flexible server](/azure/postgresql/security/security-entra-concepts)
- [Use Microsoft Entra ID authentication in Azure Database for PostgreSQL flexible server](/azure/postgresql/security/security-entra-configure)

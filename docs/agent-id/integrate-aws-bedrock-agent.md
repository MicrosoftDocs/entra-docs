---
title: Secure an Amazon Bedrock agent with Microsoft Entra Agent ID
titleSuffix: Microsoft Entra Agent ID
description: Learn how to use the Microsoft Entra Auth SDK (sidecar) to secure an Amazon Bedrock AI agent with its own identity for calling downstream APIs.
ms.service: entra
ms.topic: how-to
ms.date: 04/30/2026
author: Dickson-Mwendia
ms.author: dmwendia
ms.reviewer: razi.rais
ms.custom: agent-id, msecd-doc-authoring-1012

#customer intent: As a developer building AI agents on Amazon Bedrock, I want to secure my agent with Microsoft Entra Agent ID so that it can call downstream APIs with its own identity.
---

# Secure an Amazon Bedrock agent with Microsoft Entra Agent ID

This guide shows you how to secure an [Amazon Bedrock](https://aws.amazon.com/bedrock/) agent by using the Microsoft Entra Auth SDK (sidecar) to authenticate to downstream APIs. The sidecar runs as a separate container and handles all credential management and token exchange with Microsoft Entra ID. Your agent requests an authorization header from the sidecar, and the sidecar handles the OAuth 2.0 exchange with Microsoft Entra ID.

## Prerequisites

Before you begin, make sure you have:

- A Microsoft Entra tenant.
- An Azure subscription.
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (macOS/Windows) or Docker Engine with Compose v2 (Linux).
- [PowerShell 7+](/powershell/scripting/install/installing-powershell).
- [Azure CLI](/cli/azure/install-azure-cli).
- [AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- An AWS account with Bedrock model access enabled for Anthropic Claude 3 Haiku (or your preferred model). Enable access in the AWS Bedrock console under **Model access** > **Manage model access**.
- **Global Administrator** role for first-time Microsoft Entra setup. Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to activate this role just-in-time.

## Clone the sample repository

1. Clone the repository and go to the AWS sample directory:

   ```bash
   git clone https://github.com/microsoft/entra-agentid-samples.git
   cd entra-agentid-samples/sidecar/aws
   ```

## Architecture

The Microsoft Entra Auth SDK (sidecar) sits between your agent and Microsoft Entra ID. The agent never talks to Microsoft Entra ID directly and never manages credentials. It asks the sidecar for an `Authorization` header to call a downstream API. Amazon Bedrock handles LLM inference separately, without having to worry about identity.

:::image type="content" source="media/integrate-aws-bedrock-agent/bedrock-sidecar-token-flow.png" alt-text="Diagram showing the token flow between the Bedrock agent, sidecar, Entra ID, and Weather API." lightbox="media/integrate-aws-bedrock-agent/bedrock-sidecar-token-flow.png":::

The sample runs three containers on a Docker bridge network:

- **`llm-agent-aws`:** Flask app with a chat UI and a LangGraph ReAct agent that calls Amazon Bedrock (Claude) for reasoning. Exposed on port 3001.
- **`agent-id-sidecar-aws`:** The official Microsoft Entra Auth SDK container. Acquires and caches tokens. No host port, reachable only from within the Docker network.
- **`weather-api-aws`:** A downstream API that validates the agent's JWT (signature, issuer, expiry, audience) on every request and returns weather data.

The request flows through these steps:

1. You type a query in the chat UI at `http://localhost:3001`.
1. The Flask app sends the query to AWS Bedrock (Claude) via the LangGraph ReAct agent.
1. When Claude decides it needs weather data, it calls the `get_weather` tool.
1. The tool asks the sidecar for an authorization header by calling `GET /AuthorizationHeader?AgentIdentity={agentId}`.
1. The sidecar authenticates to Microsoft Entra ID using OAuth 2.0 (client credentials or OBO exchange).
1. Microsoft Entra ID returns the requested token (TR) to the sidecar.
1. The agent calls the weather API with `Authorization: Bearer TR`.
1. The weather API validates TR and returns the weather JSON response.

### Understand the token flow

Three tokens are involved in the identity exchange:

| Token | Issued to | When | How |
|---|---|---|---|
| **Tc** | Signed-in user | OBO flow only | MSAL.js in the browser |
| **T1** | Blueprint app | Both flows | Sidecar (client credentials) |
| **TR** | Agent (downstream API) | Both flows | Sidecar-app-only (autonomous) or OBO exchange |

In the autonomous flow, the sidecar uses client credentials to get T1, then exchanges it for TR scoped to the downstream API. In the OBO flow, the sidecar also receives Tc (the user's token) and performs an OBO exchange to get TR that acts on behalf of the signed-in user.

In this setup, only the chat UI (port 3001) is exposed to your host. The sidecar and weather API are only reachable within the Docker network, which establishes a clear security boundary.

## Choose an execution mode and identity flow

The sample supports two execution modes and two identity flows that you can combine:

| | **Autonomous** (app-only) | **OBO** (on behalf of user) |
|---|---|---|
| **Direct** (no LLM) | Fast demo path. Token fetched and weather API called directly. | Same, but uses the authenticated sidecar endpoint with the user token. |
| **Bedrock + LangChain** | LangGraph ReAct agent decides when to call `get_weather`. | Same, but the agent passes the user token through when the tool runs. |

Use **Direct** mode to verify your token flow end-to-end without needing AWS Bedrock access. Switch to **Bedrock** mode for the full agent experience.

## Choose an AWS authentication tier

The sample supports three ways to authenticate to Amazon Bedrock. Choose the tier that matches your environment:

- **Temporary STS credentials:** Best for local development with AWS SSO. Set `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN` in your `.env` file. These credentials expire after approximately one hour.
- **Bedrock API key:** Best for demos and workshops. Set `AWS_BEARER_TOKEN_BEDROCK` in your `.env` file. Scoped to Bedrock only with a configurable lifetime.
- **OIDC federation:** Best for production deployments on Azure App Service. Uses `AWS_ROLE_ARN` and `AWS_WEB_IDENTITY_TOKEN_FILE` set by the platform. No secrets stored anywhere.

> [!TIP]
> For production deployments, see the [Azure App Service deployment guide](https://github.com/microsoft/entra-agentid-samples/blob/dev/sidecar/aws/DEPLOY-AZURE-APP-SERVICE.md) for step-by-step instructions on setting up OIDC federation between Azure and AWS with zero stored secrets.

## Select a Bedrock model

The sample defaults to `us.anthropic.claude-3-haiku-20240307-v1:0` because it's the cheapest Anthropic model on Bedrock and supports tool calling. The `us.` prefix indicates a cross-region inference profile that routes between US regions for higher availability.

Other supported models:

| Model ID | Cost per 1K input tokens | Notes |
|---|---|---|
| `us.anthropic.claude-3-haiku-20240307-v1:0` | $0.00025 | Default. Fast, cheapest, supports tool calling. |
| `us.anthropic.claude-3-5-haiku-20241022-v1:0` | $0.0008 | Newer, smarter, still affordable. |
| `us.anthropic.claude-3-5-sonnet-20241022-v2:0` | $0.003 | Best quality/cost ratio. |

Override the default by setting `BEDROCK_MODEL_ID` in your `.env` file. You must enable each model in the **AWS Bedrock console** > **Model access** before it can be invoked.

## Create the Entra objects (first-time setup)

If you already have a `.env` file from a previous run with `BLUEPRINT_APP_ID` populated, skip to [Configure environment variables](#configure-environment-variables).

Run the following commands once per tenant to create the Blueprint app, Agent ID, and the SPA app used for OBO sign-in.

1. Create the Blueprint app and Agent ID for the autonomous flow by following the PowerShell workflow in [Create an agent identity blueprint](create-blueprint.md) and [Create agent identities](create-delete-agent-identities.md). At the end you have:

   - **`TENANT_ID`:** Your Entra tenant.
   - **`BLUEPRINT_APP_ID`:** Blueprint app registration.
   - **`BLUEPRINT_CLIENT_SECRET`:** Client secret for the Blueprint.
   - **`AGENT_CLIENT_ID`:** The Agent ID created from the Blueprint.

1. (Optional) Create the SPA app and configure OBO. This step is required only if you want to use the OBO identity flow:
    
   Run the following scripts to create the SPA app registration and configure OBO permissions on the Blueprint. The scripts register the SPA redirect URI and grant the required delegated permissions.

   **Bash:**

   ```bash
   bash ../../scripts/setup-obo-client-app.sh
   bash ../../scripts/setup-obo-blueprint.sh
   ```

   **PowerShell:**

   ```powershell
   pwsh ../../scripts/setup-obo-client-app.ps1
   pwsh ../../scripts/setup-obo-blueprint.ps1 `
       -TenantId        '<TENANT_ID>' `
       -BlueprintAppId  '<BLUEPRINT_APP_ID>' `
       -AgentAppId      '<AGENT_CLIENT_ID>' `
       -ClientSpaAppId  '<CLIENT_SPA_APP_ID>'
   ```

The SPA redirect URI for this sample is `http://localhost:3001` (port 3001, not 3003). Make sure this URI is registered.

## Configure environment variables

The sidecar supports multiple credential types through the `AzureAd__ClientCredentials__0__SourceType` setting in `docker-compose.yml`:

- **`ClientSecret`:** Local development only. The sample includes this type.
- **`SignedAssertionFromManagedIdentity`:** Deployed on Azure. Zero secrets, recommended for production.
- **`KeyVault`:** Certificate from Azure Key Vault.
- **`StoreWithThumbprint`:** Certificate from local machine store.

1.  Create a local `.env` configuration file from the included template. This file stores your tenant, app, and AWS credentials:

   **Bash:**

   ```bash
   cp .env.example .env
   ```

   **PowerShell:**

   ```powershell
   Copy-Item .env.example .env
   ```

1. Set the following variables in your `.env` file:

   - **`TENANT_ID`:** Your Entra tenant ID.
   - **`BLUEPRINT_APP_ID`:** Blueprint app registration. The sidecar authenticates as this app.
   - **`BLUEPRINT_CLIENT_SECRET`:** Blueprint client secret (local development only).
   - **`AGENT_CLIENT_ID`:** Your Agent ID. Appears as the `AgentIdentity` query parameter.
   - **`CLIENT_SPA_APP_ID`:** SPA app ID used by MSAL.js for browser sign-in (OBO only).
   - **`AWS_REGION`:** AWS region for Bedrock, such as `us-east-2`.
   - **`BEDROCK_MODEL_ID`:** Model ID. Default: `us.anthropic.claude-3-haiku-20240307-v1:0`.
   - **`VALIDATE_TOKEN_SIGNATURE`:** Default `true`. Set to `false` to skip JWKS signature validation in the weather API (debugging only).

1. Add your AWS credentials based on the tier you chose:
   - **Tier A (STS):** Set `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN`.
   - **Tier B (API key):** Set `AWS_BEARER_TOKEN_BEDROCK`.
   - **Tier C (OIDC):** Configured through platform App Settings, not in `.env`.

> [!TIP]
> If you already have a `.env` from a previous session, you only need to refresh your AWS credentials (STS tokens expire after about one hour). Skip directly to [Start the stack](#start-the-stack).

## Start the stack

1. Verify that Docker Desktop (or Docker Engine) is running on your machine.

1. Build the container images and start all three services (agent, sidecar, and weather API) in detached mode:

   ```bash
   docker compose up --build -d
   ```

1. Check that all containers started successfully by querying the status endpoint. The response reports whether the agent can reach AWS Bedrock:

   **Bash:**

   ```bash
   curl http://localhost:3001/api/status
   ```

   **PowerShell:**

   ```powershell
   Invoke-RestMethod http://localhost:3001/api/status
   ```

   You see a response indicating `bedrock_available: true` (or `false` if you're using Direct mode without AWS credentials).

> [!IMPORTANT]
> When you update `.env` (for example, to refresh expired STS credentials), `docker compose restart` doesn't reload environment variables. Use `docker compose up -d --force-recreate llm-agent-aws` instead.

## Send a query through the chat UI

1. Open `http://localhost:3001` in your browser.

1. Use the header bar to configure your demo:
   - **Execution Mode:** `Direct` (skip LLM) or `Bedrock` (LangChain ReAct agent on Claude).
   - **Identity Flow:** `Autonomous` (app-only token) or `OBO` (acts for a signed-in user).

1. If you select **OBO**, select **Sign in** to authenticate through the MSAL.js popup.

1. Type a query like *"Weather in Dallas?"* and select **Send**.

1. Watch the **Identity Trace** panel on the right side for a step-by-step breakdown of every token exchange and API call. The panel shows color-coded JWT cards for each token (Tc, T1, TR) with decoded claims.

## Troubleshoot common issues

If something isn't working as expected, check the following table for common issues and fixes:

| Symptom | Likely cause | Fix |
|---|---|---|
| `/api/status` shows `bedrock_available: false` | AWS credentials missing or expired, or model access not granted. | Check `docker logs llm-agent-aws`. Refresh STS credentials with `aws sso login`. Enable the model in the Bedrock console. |
| `ExpiredTokenException` from Bedrock | STS session token (Tier A) expired. | Paste fresh credentials in `.env`, then run `docker compose up -d --force-recreate llm-agent-aws`. |
| `AccessDeniedException` on `InvokeModel` | IAM principal lacks `bedrock:InvokeModel` permission, or model access isn't enabled. | Grant `bedrock:InvokeModel` on the model and inference profile ARNs. |
| `ValidationException: invalid model identifier` | Region doesn't host the model, or you used a bare model ID instead of the `us.` inference profile. | Use the `us.`-prefixed inference profile ID (for example, `us.anthropic.claude-3-haiku-20240307-v1:0`). |
| Weather API returns `401 Unauthorized` | Token tenant mismatch, expired secret, or signature check failed. | Verify `TENANT_ID` matches the Blueprint's tenant. Check sidecar logs. |
| LLM responds without calling the tool | Query wasn't clearly tool-shaped, or model doesn't support tool calling. | Use Claude 3 Haiku or newer. Phrase the request as *"What's the weather in \<city\>?"*. |
| OBO sign-in popup blocked | Browser popup blocker. | Allow popups for `localhost:3001`. |
| `4xx` from sidecar during OBO | `CLIENT_SPA_APP_ID` missing or SPA redirect URI mismatch. | Rerun `setup-obo-client-app`. Ensure `http://localhost:3001` is on the SPA's redirect URIs. |

If an issue persists even after following the troubleshooting steps, inspect the container logs directly. Each service logs to its own container:

```bash
docker logs llm-agent-aws          # Agent app: Bedrock calls, tool invocations
docker logs agent-id-sidecar-aws   # Sidecar: token acquisition, credential errors
docker logs weather-api-aws        # Weather API: JWT validation, request handling
```
## Clean up resources

When you finish testing, stop the local containers to free system resources. Choose one of the following cleanup options based on whether you want to keep images for faster restarts.

> [!IMPORTANT]
> `docker compose down` removes only the local Docker containers. Microsoft Entra objects (agent blueprint, Agent ID, SPA app registration) are tenant-side state and persist. Delete them manually in the Microsoft Entra admin center if you no longer need them.

```bash
# Stop containers but keep volumes and images for faster restarts
docker compose down

# Remove everything including volumes and images
docker compose down -v --rmi all

## Related content

- [Authentication with Microsoft Entra Auth SDK (sidecar)](authentication-with-auth-sdk-sidecar.md)
- [Integrate third-party agents with Microsoft Entra Agent ID](configure-third-party-agents.md)
- [Microsoft Entra Auth SDK sidecar container image](https://mcr.microsoft.com/en-us/artifact/mar/entra-sdk/auth-sidecar)
---
title: Integrate third-party agents with Microsoft Entra Agent ID
description: Learn how to integrate third-party AI agents with Microsoft Entra Agent ID for secure authentication using sidecar and federation patterns.
ms.service: entra
ms.topic: how-to
ms.date: 04/29/2026 
ms.reviewer: gargi.sinha
manager: Dougeby
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1012

#customer intent: As a developer or IT admin, I want to integrate third-party AI agents with Microsoft Entra Agent ID so that those agents can authenticate securely without embedded credentials.
---

# Integrate third-party agents with Microsoft Entra Agent ID

Microsoft Entra Agent ID enables AI agents from third-party platforms to authenticate and access your APIs securely without handling credentials directly. This article covers two integration patterns - the Microsoft Entra Auth SDK (sidecar) and federation - for platforms such as Amazon Web Service (AWS) Bedrock and n8n.

## Prerequisites

Before you start, make sure you have:

- **Microsoft Entra tenant** with agent identity capabilities enabled.
- **Azure subscription**, required for some deployment options.
- **Docker** and **Docker Compose** for the sidecar pattern.
- **Credentials or federation setup**, depending on the pattern you choose.
- **PowerShell 7.5 or later** with the Microsoft Graph PowerShell module.
- **Global Administrator** role, required only for initial setup. Use [Privileged Identity Management (PIM)](/entra/id-governance/privileged-identity-management/pim-configure) to activate this role just-in-time.
- **Cloud Application Administrator** or **Application Administrator** role to grant Microsoft Graph delegated permissions for agent management operations.

To verify your environment is ready:

1. Confirm you have the permissions to create applications and service principals in your Microsoft Entra tenant.
1. If you're deploying to Azure, confirm your subscription and resource group.
1. Review the documentation for your agent platform, such as AWS Bedrock or n8n.

## Why you need third-party agent integration

Organizations use AI agents from multiple platforms, such as AWS Bedrock, n8n, and others. These agents often need to:

- Call Microsoft APIs such as Microsoft Graph and Azure services.
- Access your internal APIs and resources.
- Authenticate securely without storing secrets in code or configuration.

Microsoft Entra Agent ID provides a centralized, secure identity service that third-party agents can use to acquire tokens on demand, without managing secrets or certificates directly. By using Microsoft Entra Agent ID, you can:

- Remove the need for agents to handle credentials directly.
- Use workload identity federation for agents running outside Azure.
- Support multiple authentication patterns, including client credentials, federated identity, and on-behalf-of.
- Integrate with third-party agent platforms by using the Microsoft Entra Auth SDK (sidecar).

## Integration patterns for third-party agents

To integrate third-party agents with Microsoft Entra Agent ID, choose from the following patterns:

### Use the Microsoft Entra Auth SDK (sidecar)

The **sidecar pattern** runs the Microsoft Entra Auth SDK as a companion container alongside your agent. The agent calls the sidecar to request tokens for API calls. The agent never handles credentials directly; instead, it delegates token acquisition to the sidecar.

**Best for:**

- Containerized agents on Docker or Kubernetes.
- AWS Bedrock agents running in your own orchestration.
- Local development with Docker Compose.
- Organizations already using container infrastructure.

**Supported platforms:**

- AWS Bedrock, including Claude and other foundation models.
- Local Large Language Models (LLMs) such as Ollama with LangChain.
- Any containerized agent.

**Advantages:**

- Credential-free agent code.
- Works with any containerized agent.
- Easy local development with Docker Compose.
- Can be deployed to Azure Container Apps, Kubernetes, or on-premises.

**Consideration:**

- Requires managing a second container.

The following diagram shows the sidecar architecture. An agent container and a sidecar container run together in the same orchestration environment. The agent requests tokens from the sidecar, which communicates with Microsoft Entra Agent ID to acquire access tokens.

:::image type="content" source="media/configure-third-party-agents/sidecar-pattern-architecture.png" alt-text="Diagram that shows the sidecar pattern architecture with an agent and sidecar container running in the same orchestration environment, where the sidecar requests tokens from Microsoft Entra Agent ID." lightbox="media/configure-third-party-agents/sidecar-pattern-architecture.png" border="false":::

### Use Workload Identity Federation (direct identity exchange)

The **federation pattern** uses Workload Identity Federation to exchange credentials from external identity providers such as AWS Security Token Service (STS) directly for Microsoft Entra tokens. This pattern doesn't need a sidecar.

**Best for:**

- AWS agents that use STS and OIDC.
- Organizations that already have federation infrastructure.
- Agents that can't run containers.

**Supported platforms:**

- GCP Workload Identity → Microsoft Entra Agent ID.
- AWS STS → Microsoft Entra Agent ID.

**Advantages:**

- No sidecar required.
- Uses existing infrastructure in AWS, and other platforms.
- Direct token exchange at the identity layer.

**Requirements:**

- A preconfigured Federated Identity Credential in Microsoft Entra.
- An agent platform that supports OIDC or STS.

The following diagram shows the federation flow. An agent on a third-party platform authenticates through its native workload identity provider, exchanges the resulting OIDC token for a Microsoft Entra token, and then calls your APIs.

:::image type="content" source="media/configure-third-party-agents/federation-pattern-token-exchange.png" alt-text="Diagram that shows the federation pattern flow where a third-party platform agent exchanges an OIDC token through Microsoft Entra Agent ID to access your APIs or Microsoft APIs." lightbox="media/configure-third-party-agents/federation-pattern-token-exchange.png" border="false":::

## Understand the token flow

Both patterns follow the same core token flow:

1. **Agent requests a token.** The agent, or the sidecar on the agent's behalf, calls Microsoft Entra Agent ID with authentication credentials.
1. **Microsoft Entra validates the identity.** Microsoft Entra verifies the agent's identity through client credentials, a federated credential, or another supported method.
1. **Microsoft Entra returns a token.** The agent receives a Microsoft Entra access token.
1. **Agent calls the API.** The agent uses the token to authenticate to Microsoft or custom APIs.
1. **API validates the token.** The API checks the token signature and claims, then grants access.

## Common integration scenarios

### AWS Bedrock agent calling Microsoft Graph

An AWS Bedrock agent, such as Claude, needs to query Microsoft 365 data or manage resources through Microsoft Graph. The sidecar pattern is ideal for this scenario. To integrate an AWS Bedrock agent with the sidecar pattern:

1. Deploy the agent and sidecar to AWS or your own infrastructure.
1. Configure an Agent Identity in Microsoft Entra with permissions to Microsoft Graph.
1. The agent calls the sidecar for a token.
1. The sidecar acquires a token from Microsoft Entra Agent ID.
1. The agent uses the token to call Microsoft Graph.

For step-by-step instructions, see [Secure an Amazon Bedrock agent with Microsoft Entra Agent ID](integrate-aws-bedrock-agent.md).

### n8n agent calling Microsoft Graph and MCP Server for Enterprise

An n8n agent needs to access Microsoft 365 data through Microsoft Graph or the Microsoft Graph MCP Server for Enterprise. This scenario uses the n8n-nodes-entraagentid community node to manage token acquisition directly within n8n workflows. To integrate an n8n agent:

1. Deploy n8n to Azure Container Apps by using the Azure Developer CLI (`azd`).
1. Configure an Agent Identity in Microsoft Entra with permissions to Microsoft Graph.
1. The n8n workflow uses the community node to acquire a token from Microsoft Entra Agent ID.
1. The agent uses the token to call Microsoft Graph or the MCP Server for Enterprise.

For step-by-step instructions, see [Secure an n8n agent with Microsoft Entra Agent ID](integrate-n8n-agent.md).

### Local development with Ollama

You're developing with a local LLM like Ollama and want to test authentication before deploying. Use the sidecar pattern with Docker Compose. To test locally:

1. Run the agent and sidecar in Docker Compose.
1. The agent calls `localhost:7000/token` to request a token from the sidecar.
1. The sidecar acquires a token from Microsoft Entra Agent ID.
1. Test agent behavior locally before deploying.

For step-by-step instructions, see [Run the sidecar for local development](sidecar-local-development.md).

## High-level roadmap

Use the following table to identify the steps for your chosen pattern:

| Step | Pattern | Task |
|------|---------|------|
| 1 | Both | Set up Agent Identity and permissions in Microsoft Entra. |
| 2 | Both | Choose an integration pattern: sidecar or federation. |
| 3 | Sidecar | Deploy agent and sidecar containers, then test locally. |
| 4 | Sidecar | Deploy to production on Azure Container Apps, Kubernetes, or another platform. |
| 5 | Federation | Configure federated identity credentials in Microsoft Entra. |
| 6 | Federation | Deploy the agent to the target platform. |

## Security best practices

When you integrate third-party agents, follow these security principles:

- **Never embed credentials in agent code.** Use Microsoft Entra Agent ID to acquire tokens dynamically.
- **Use least privilege.** Grant Agent Identities only the permissions they need through roles or scopes.
- **Validate token audience and issuer.** Always verify that tokens come from your Microsoft Entra tenant.
- **Rotate credentials regularly.** If you use client secrets, rotate them on a schedule. Consider federated credentials instead.
- **Monitor token usage.** Use Microsoft Entra logs to track which agents access which APIs.
- **Keep the Microsoft Entra SDK updated.** Security and compatibility updates are released regularly.

## Troubleshoot common issues

If you run into problems during integration, use the following guidance to identify the cause and resolution:

| Issue | Cause | Solution |
|-------|-------|----------|
| Agent can't reach sidecar | Network configuration issue or sidecar not running | Verify the sidecar is running, check DNS and networking, and confirm port binding. The default port is 7000. |
| Sidecar fails to acquire token | Microsoft Entra authentication failed | Verify Agent Identity credentials, check Microsoft Entra permissions, and review the tenant ID and client ID. |
| Token request returns 401 | Invalid Microsoft Entra credentials or federated credential not configured | Confirm credentials are correct and verify the federated identity credential is set up if you're using the federation pattern. |
| API rejects token | Token lacks the required scope or permission | Add required API permissions to the Agent Identity and request a token with the correct scope. |

## Related content

- [Configure SDK for agent identities](microsoft-entra-sdk-for-agent-identities.md)
- [Call Microsoft Graph API](call-api-microsoft-graph.md)
- [Call custom APIs](call-api-custom.md)
- [Call Azure services](call-api-azure-services.md)
- [Best practices for Agent ID](best-practices-agent-id.md)
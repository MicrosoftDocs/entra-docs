---
title: Understand agent SSO, provisioning, and authorization
titleSuffix: Microsoft Entra Agent ID
description: Understand how agent SSO, provisioning, and ID-JAG support identity and access to third-party applications.
ms.date: 11/13/2026
ms.topic: concept-article
ai-usage: ai-assisted
---
# Understand agent SSO, provisioning, and authorization

AI agents increasingly need to access third-party applications and services. Applications use different approaches to authenticate agents, represent agent identities, provision permissions, and authorize access.

Microsoft Entra Agent ID helps organizations manage, govern, and protect AI agent identities. **Identity Assertion JWT Authorization Grant (ID-JAG)** enables delegated authorization across applications. We'd like to understand how your application supports agent identity and access today and what you plan to support in the future.

If you're familiar with these capabilities, go directly to the [Identity Assertion JWT Authorization Grant (ID-JAG) | Partner and Customer Interest](https://forms.cloud.microsoft/r/HWqN80MaeS) form.

## How agent identity and access work

| Capability | What it does |
| --- | --- |
| **Microsoft Entra Agent ID** | Manages the agent's identity in Microsoft Entra. |
| **Agent SSO and authentication** | Authenticates the agent to your application. |
| **Agent provisioning** | Creates and manages the agent's identity and permissions in your application, when required. |
| **ID-JAG** | Enables the agent to obtain delegated access to your application. |

## Microsoft Entra Agent ID

Microsoft Entra Agent ID provides identity, security, and governance capabilities for AI agents. Creating an agent identity in Microsoft Entra doesn't automatically create a corresponding identity in your application.

For more information, see [Microsoft Entra Agent ID documentation](index.yml).

## Agent SSO and authentication

Authentication establishes the identity of an agent accessing your application or API. The authentication methods you support depend on your application's identity architecture.

## Agent provisioning

Some applications require an agent to have an identity in their system before access can be granted. For these applications, provisioning creates and manages the agent's identity and permissions.

Provisioning can use SCIM, application-specific APIs, or other mechanisms.

> [!IMPORTANT]
> Provisioning here refers to how the agent is represented and managed in your application, not to creating the agent identity in Microsoft Entra Agent ID.

## ID-JAG

ID-JAG provides delegated authorization to your application. The target application's authorization server validates the grant, applies its authorization policies, and issues an appropriately scoped access token.

## Tell us what your application supports

**Help shape future Microsoft Entra integrations for AI agents.** Tell us how your application supports agent identity and access today, and what you plan to support in the future.

Complete the [Identity Assertion JWT Authorization Grant (ID-JAG) | Partner and Customer Interest](https://forms.cloud.microsoft/r/HWqN80MaeS) form to share your application's:

- Agent authentication and SSO capabilities
- Provisioning approach
- ID-JAG readiness and plans

We ask about provisioning and ID-JAG separately because they serve different purposes. Provisioning creates and manages an agent's identity and permissions in your application when required. ID-JAG enables delegated authorization to your application. Your application can support either capability without supporting the other.

> [!NOTE]
> Sharing this information doesn't commit you to supporting ID-JAG and doesn't mean Microsoft has validated your implementation. Your input helps Microsoft understand partner readiness and inform future integration and testing plans.

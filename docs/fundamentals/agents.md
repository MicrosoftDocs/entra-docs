---
title: Microsoft Security Copilot agents in Microsoft Entra
description: Learn about the available Microsoft Security Copilot agents in Microsoft Entra.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 04/11/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
---
# Microsoft Security Copilot agents in Microsoft Entra

Microsoft Entra agents work seamlessly with [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot).

## Available agents

### Microsoft Entra Conditional Access optimization agent

The [Conditional Access optimization agent](../identity/conditional-access/agent-optimization.md) ensures all users are protected by policy. It recommends policies and changes based on best practices aligned with [Zero Trust](/security/zero-trust/deploy/identity) and Microsoft's learnings. In preview, the agent evaluates policies requiring multifactor authentication (MFA), enforces device based controls (device compliance, app protection policies, and Domain Joined Devices), and blocks legacy authentication and device code flow.

#### Trigger​

The agent runs every 24 hours but can also run manually. 

#### Permissions​

The agent reviews your policy configuration but acts only with your approval of the suggestions.

#### Identity​

It runs in the context of the administrator who configured the agent.

#### Products​

[Microsoft Entra Conditional Access](/entra/identity/conditional-access/) and [Security Copilot](/copilot/security/microsoft-security-copilot)

#### Plugins​

[Microsoft Entra](/entra/fundamentals/copilot-security-entra)

#### Role-based access ​

Administrators need the [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) or [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role during the preview.

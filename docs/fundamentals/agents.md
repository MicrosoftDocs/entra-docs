---
title: Microsoft Security Copilot agents in Microsoft Entra
description: Learn about the available Microsoft Security Copilot agents in Microsoft Entra.
ms.author: joflore
author: MicrosoftGuyJFlo

ms.date: 04/25/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
---
# Microsoft Security Copilot agents in Microsoft Entra

Microsoft Entra agents work seamlessly with [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot). Microsoft Security Copilot agents automate repetitive tasks and reduce manual workloads. They enhance security and IT operations across cloud, data security and privacy, identity, and network security. These agents handle high-volume, time-consuming tasks by pairing data and code with an AI language model. They respond to user requests and system events, helping teams work more efficiently and focus on higher-impact tasks.

Agents fit naturally into existing workflows. You don't need special training or other licensing to use them. Agents utilize SCUs to operate just like other features in the product. They integrate seamlessly with Microsoft Security solutions and the broader supported partner ecosystem. Agents learn based on feedback and keep you in control on the actions it takes. They handle resource-intensive tasks like threat intelligence briefings, and Conditional Access optimization. With Microsoft Security Copilot agents, you can scale up your teams, people, and processes.

Microsoft Security Copilot agents offer significant benefits for security teams and IT operations by automating routine tasks and freeing up valuable time for teams to concentrate on strategic initiatives and complex problem-solving. This leads to improved operational efficiency, enhanced security and giving teams the ability to respond more swiftly to emerging threats. With Security Copilot agents, organizations can achieve greater scalability and resilience in their security and IT processes.

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

### Microsoft Entra Access Review Agent

The [Access Review Agent](../id-governance/access-review-agent.md.md) helps reviewers quickly complete access reviews of users in their organization by providing suggestions for decisions based on both Microsoft Entra best practices, and specific knowledge of the reviewers environment.

#### Trigger​

The agent runs every 24 hours but can also run manually. 

#### Permissions​

The agent reviews users currently in the scope of your access reviews, and makes suggestions on whether access should be approved or declined. The agent acts based on your selections.

#### Identity​

It runs in the context of the administrator who configured the agent.

#### Products​

[Access Reviews](../id-governance/access-reviews-overview.md) and [Security Copilot](/copilot/security/microsoft-security-copilot)

#### Plugins​

[Microsoft Entra](/entra/fundamentals/copilot-security-entra)

#### Role-based access ​

Administrators need the [Global Administrator](../identity/role-based-access-control/permissions-reference.md#global-administrator) role, or both the [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) and [Lifecycle Workflows Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) roles during the preview.


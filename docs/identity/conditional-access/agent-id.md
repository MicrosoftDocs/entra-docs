---
title: Conditional Access Agentic Identities (Preview)
description: 

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: concept-article
ms.date: 09/22/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: kvenkit
---
# Conditional Access and agent identities (Preview)

## Conditional Access for agents -> what it is?

Conditional Access for Agent ID is a new capability in Microsoft Entra ID that brings Conditional Access evaluation and enforcement to AI agents—the same zero-trust controls that already protect human users and apps.
Conditional Access treats agents as first-class identities in Entra ID and evaluates their access requests exactly as it does for human users or workload identities, but with agent-specific logic.

## Agents -> how is it modeled in Entra

To understand how Conditional Access works for Agent ID, it is important to understand the Agent ID platform fundamentals. Agent ID introduces first-class identity constructs for agents. These are modelled as applications (agent identities) and users (agent users).

| Term | Description |
| --- | --- |
| Agent Blueprint | Logical definition of an agent type. Necessary for agent identity blueprint principal creation in the tenant. |
| Agent Identity Blueprint Principal | Service Principal representing the Agent Blueprint in the tenant; only executes creation of agent identities and agent users |
| Agent Identity | Instantiated agent identity. Performs token acquisitions to access resources. |
| Agent User | Non-human user identity used for agentic experiences that require a user account. Performs token acquisitions to access resources. |
| Agentic Resource | Agent blueprint or Agent identity acting as the resource app (e.g. in A2A flows) |

For more information see the article [Microsoft Entra Agent ID](XXXXXXXXXXXXXX).

## Conditional Access capabilities for agent apps and agent users

Conditional Access enforces Zero Trust principles across all token acquisition flows initiated by agent identities and agent users.

Conditional Access applies when: 

- An agent identity requests a token for any resource (agent identity → resource flow). 
- An agent user requests a token for any resource (agent user → resource flow).

Conditional Access does not apply when:

1. Agent identity blueprint acquires a token for Microsoft graph to create an agent identity or agent user.

   > [!NOTE]
   > Agent blueprints have limited functionality. They cannot act independently to access resources and are only involved in creation of agent identities and agent users. Agentic tasks are always performed by the AGENT IDENTITY (AGENT ID). 

1. Agent identity blueprint or agent identity performs an intermediate token exchange at the AAD Token Exchange Endpoint: Public endpoint (Resource ID: fb60f99c-7a34-4190-8149-302f77469936).

   > [!NOTE]
   > Tokens scoped to AAD Token Exchange Endpoint: Public cannot call MS Graph. Agentic flows are protected because we protect token acquisition from agent identity or agent user.

1. Conditional Access policies scoped to users or workload identities do not apply to agents.
1. [Security defaults](../../fundamentals/security-defaults.md) do not apply to agents.

| Flow | Conditional Access Applies | Details |
| --- | --- | --- |
| AGENT IDENTITY BLUEPRINT  → Graph (create AGENT IDENTITY (AGENT ID)/AGENT USER) | ❌ | Blueprint can only create agent identities and agent users; not a risk. |
| AGENT IDENTITY BLUEPRINT  or AGENT IDENTITY (AGENT ID) → Token Exchange | ❌ | Internal flow, limited audience scope. |
| AGENT IDENTITY (AGENT ID) → Resource | ✅ | Governed by agent identity policies. |
| AGENT USER → Resource | ✅ | Governed by agent user policies. |

## Policy configuration

Creating a Conditional Access policy for agents involves the following four key components: 

SCREENSHOT TO GO HERE OF A CONDITIONAL ACCESS POLICY WITH AGENT ID STUFF

1. Assignments (Agent Selection) 
   1. Scope policies to: 
      1. All agent identities in the tenant
      1. Specific agent identities based on their GUID
      1. Agent identities grouped by Custom Security Attributes such as sensitivity, approval status, or department
      1. Agent identities grouped by their blueprint
      1. All agent users in the tenant*
1. Target Resources 
   1. Resource targeting options include: 
      1. All resources (cloud apps + agent blueprints + agent identities)
      1. All agent resources (agent blueprints and agent identities)
      1. Specific resources grouped by custom security attributes (CSAs)
      1. Specific resources based on their GUID.
      1. Agent blueprints (Note: targeting the blueprint covers the agent identities parented by the blueprint)
1. Conditions 
   1. Agent Risk Level (high, medium, low)
      1. Detections: Unfamiliar Resource Access, Sign-In Spike, Failed Access Attempt, and Sign-In by Risky User
1. Access Controls 
   1. Block 
1. Policies can be toggled On, Off, or set to Report-only for simulation.

## Common Conditional Access scenarios - biz scenarios

### Scenario 1: My organization is testing agents. I want to configure a CA policy to allow only approved agents to access specific resources.

#### Method 1: The first method is using custom security attributes. This uses steps similar to those documented in Filter for applications in Conditional Access policy - Microsoft Entra ID | Microsoft Learn

First, create the custom security attributes using the following steps:
•	Create an **Attribute set** named *AgentAttributes*.
•	Create **New attributes** named *agentStatus* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. We add the following predefined values: New, In Review, Approved.
•	Next, assign the ‘Approved’ value to agents that your organization is ready to test.
Similarly, create another attribute set to group resources that your agents are allowed to access.
•	Create an **Attribute set** named *sensitivity*.
•	Create **New attributes** named *busnessImpact* that **Allow multiple values to be assigned** and **Only allow predefined values to be assigned**. We add the following predefined values: Low, Medium, High.
•	Next, assign the ‘Low’ value to resources that your agent is allowed to access.
Note that attributes across multiple attribute sets can be assigned to an agent or cloud application.
Once, done, the following steps help create a Conditional Access policy to block all agent identities except those vetted and approved by your organization. 
1.	Sign in to the Microsoft Entra admin center as at least a Conditional Access Administrator.
2.	Browse to Entra ID > Conditional Access > Policies.
3.	Select New policy.
4.	Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
5.	Under Assignments, select Users, agents or workload identities. 
1.	Under Include, select All agent identities
2.	Under Exclude: 
1.	Select Select agents > Select agents based on attributes
2.	Set Configure to Yes. 
3.	Select the Attribute we created earlier called agentStatus.
4.	Set Operator to Contains.
5.	Set Value to approved.
6.	Select Done.
6.	Under Target resources, select the following options: 
1.	Select what this policy applies to Resources (formerly ‘cloud apps’).
2.	Include Select resources.
3.	Select Select resources based on attributes.
4.	Set Configure to Yes.
5.	Select the Attribute we created earlier called businessImpact.
6.	Set Operator to Contains.
7.	Set Value to low
8.	Select a second Attribute called department.
9.	Set Operator to Contains.
10.	Set Value to HR.
11.	Select Done.
7.	Under Access controls > Grant. 
1.	Select Block.
2.	Select Select.
8.	Confirm your settings and set Enable policy to Report-only.
9.	Select Create to create to enable your policy.

#### Method 2: The second method uses enhanced agent and resource selection experience



### Scenario 2: I want to configure a CA policy to block high risk agent identities from accessing my organization’s resources

Use CA template: Block high risk agent identities from accessing resources (See CA templates section below)



## Conditional Access policy evaluation details for agents

## FAQ: (a) My org doesn't want to deploy agents - what do I do? SKU .....

## Next steps

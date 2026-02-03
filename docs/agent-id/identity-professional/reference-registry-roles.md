---
title: Agent Registry Built-In Roles
description: Learn about the built-in roles available in Microsoft Entra Agent Registry for managing agents, collections, and role assignments.
author: shlipsey3
ms.service: entra-id
ms.topic: reference
ms.date: 11/07/2025
ms.author: sarahlipsey
ms.reviewer: paparth

---
# Microsoft Entra Agent Registry roles

In the Microsoft Entra Agent Registry, you can assign roles to administrators or other security principals to manage agent instances, agent card manifests, and agent collections. These roles provide the permissions required to perform specific actions, such as creating or updating agent instances, creating agent card manifests, or managing collection membership.

This article lists the Agent Registry roles you can assign to manage Agent Registry resources. Agent Registry also allows the [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator) built-in Microsoft Entra role.

## Assign Agent Registry roles

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Agent Registry Administrator](../../identity/role-based-access-control/permissions-reference.md#agent-registry-administrator).
1. Browse to **Entra ID** > **Agent ID** > **Agent collections** > **Custom** > **Manage role assignments**.
1. Under **Access Control**, select **Role Assignments** > **Create Role Assignment**.
1. Choose **Select principal** > select **Role** > **Resource scope** > **Next**. Role assignment to Groups isn't supported. If you're choosing Resource scope as specific resource, select Resource type and enter Resource ID as the corresponding objectId.
1. Review and select **Create**.

## All roles

| Role | Description |
| --- | --- |
| [Agent Card Manifest Administrator](#agent-card-manifest-administrator) | Can create agent card manifests, view and update the properties of agent card manifest objects. |
| [Agent Card Manifest Reader](#agent-card-manifest-reader) | Can view the properties of agent card manifest objects. |
| [Agent Card Manifest Creator](#agent-card-manifest-creator) | Can create agent card manifests as specified in the request body. |
| [Agent Instance Administrator](#agent-instance-administrator) | Can create agent instances, view and update instance properties, permanently delete agent instances, and list all collections associated with an agent instance. |
| [Agent Instance Reader](#agent-instance-reader) | Can view agent instance properties and list all collections associated with an agent instance. |
| [Agent Instance Creator](#agent-instance-creator) | Can create agent instances as specified in the request body. |
| [Agent Collection Administrator](#agent-collection-administrator) | Can create collections, view collection properties, list collection members, update, and delete collections, except for the global and quarantined collections. |
| [Agent Collection Reader](#agent-collection-reader) | Can view collection properties and list members of collections. |
| [Agent Collection Creator](#agent-collection-creator) | Can create collections as specified in the request body. |

## Agent Card Manifest Administrator

Can create agent card manifests, view and update the properties of agent card manifest objects.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCardManifest |create	| Create a new agent card manifest.        		  	|
| agentCardManifest |read	| Get the properties of an agent card manifest.		|
| agentCardManifest |update	| Update the properties of an agent card manifest.	|

## Agent Card Manifest Reader

Can view the properties of agent card manifest objects.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCardManifest |read	| Get the properties of an agent card manifest.		|

## Agent Card Manifest Creator

Can create agent card manifests as specified in the request body.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCardManifest |create	| Create a new agent card manifest.		|

## Agent Instance Administrator

Can create agent instances, view and update instance properties, permanently delete agent instances, and list all collections associated with an agent instance.

| Resource type | Action | Description |
| --- |--- | --- |
| agentInstance |create				| Create a new agent instance.						|
| agentInstance |read				| Get the properties of an agent instance.			|
| agentInstance |update				| Update the properties of an agent instance.		|
| agentInstance |delete				| Delete an agent instance permanently.				|
| agentInstance |listCollections	| List all the collections of an agent instance.	|

## Agent Instance Reader

Can view agent instance properties and list all collections associated with an agent instance.

| Resource type | Action | Description |
| --- |--- | --- |
| agentInstance |read	| Get the properties of an agent instance.	|
| agentInstance |listCollections	| List all the collections of an agent instance.	|

## Agent Instance Creator

Can create agent instances as specified in the request body.

| Resource type | Action | Description |
| --- |--- | --- |
| agentInstance |create	| Create a new agent instance.	|

## Agent Collection Administrator

Can create collections, view collection properties, list collection members, update, and delete collections, except for the global and quarantined collections.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCollection |create		| Create a new agent collection.				|
| agentCollection |read			| Get the properties of an agent collection.	|
| agentCollection |update		| Update the properties of an agent collection.	|
| agentCollection |delete		| Delete an agent collection permanently.		|
| agentCollection |listMembers	| List all the members of an agent collection.	|

## Agent Collection Reader

Can view collection properties and list members of collections.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCollection |read			| Get the properties of an agent collection.	|
| agentCollection |listMembers	| List all the members of an agent collection.	|

## Agent Collection Creator

Can create collections as specified in the request body.

| Resource type | Action | Description |
| --- |--- | --- |
| agentCollection |create	| Create a new agent collection.	|

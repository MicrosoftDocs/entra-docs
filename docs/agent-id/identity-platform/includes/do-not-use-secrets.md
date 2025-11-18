---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id

ms.topic: include
# Purpose:
# To warn users against using client secrets in agent identity blueprints.
---
> [!WARNING]
> Client secrets shouldn't be used as client credentials in production environments for agent identity blueprints due to security risks. Instead, use more secure authentication methods such as [federated identity credentials (FIC) with managed identities](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity) or client certificates. These methods provide enhanced security by eliminating the need to store sensitive secrets directly within your application configuration.

---
title: Built-in policy definitions for Microsoft Entra Domain Services
description: Lists Azure Policy built-in policy definitions for Microsoft Entra Domain Services. These built-in policy definitions provide common approaches to managing your Azure resources.
ms.date: 09/19/2023
ms.service: entra-id
ms.subservice: domain-services
author: justinha
ms.author: justinha
ms.topic: reference
ms.custom: subject-policy-reference
---
# Azure Policy built-in definitions for Microsoft Entra Domain Services

This page is an index of [Azure Policy](/azure/governance/policy/overview) built-in policy definitions for Microsoft Entra Domain Services. For additional Azure Policy built-ins for other services, see
[Azure Policy built-in definitions](/azure/governance/policy/samples/built-in-policies).

The name of each built-in policy definition links to the policy definition in the Microsoft Entra admin center. Use the link in the **Version** column to view the source on the
[Azure Policy GitHub repo](https://github.com/Azure/azure-policy).

<a name='azure-active-directory-domain-services'></a>

## Microsoft Entra Domain Services

|Name<br /><sub>(Azure portal)</sub> |Description |Effect(s) |Version<br /><sub>(GitHub)</sub> |
|---|---|---|---|
|[Microsoft Entra Domain Services managed domains should use TLS 1.2 only mode](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F3aa87b5a-7813-4b57-8a43-42dd9df5aaa7) |Use TLS 1.2 only mode for your managed domains. By default, Microsoft Entra Domain Services enables the use of ciphers such as NTLM v1 and TLS v1. These ciphers may be required for some legacy applications, but are considered weak and can be disabled if you don't need them. When TLS 1.2 only mode is enabled, any client making a request that is not using TLS 1.2 will fail. Learn more at [Harden a Microsoft Entra Domain Services managed domain](./secure-your-domain.md). |Audit, Deny, Disabled |[1.1.0](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Active%20Directory/AADDomainServices_TLS_Audit.json) |
|[Microsoft Entra ID should use private link to access Azure services](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F2e9411a0-0c5a-44b3-9ddb-ff10a1a2bf28) |Azure Private Link lets you connect your virtual networks to Azure services without a public IP address at the source or destination. The Private Link platform handles the connectivity between the consumer and services over the Azure backbone network. By mapping private endpoints to Microsoft Entra ID, you can reduce data leakage risks. Learn more at: [https://aka.ms/privateLinkforAzureADDocs](https://aka.ms/privateLinkforAzureADDocs). It should be only used from isolated VNETs to Azure services, with no access to the Internet or other services (M365). |AuditIfNotExists, Disabled |[1.0.0](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Active%20Directory/PrivateLinkForAzureAD_PrivateLink_AuditIfNotExists.json) |
|[Configure Private Link for Microsoft Entra ID with private endpoints](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fb923afcf-4c3a-4ed6-8386-1ff64b68de47) |Private endpoints connect your virtual networks to Azure services without a public IP address at the source or destination. By mapping private endpoints to Microsoft Entra ID, you can reduce data leakage risks. Learn more at: [https://aka.ms/privateLinkforAzureADDocs](https://aka.ms/privateLinkforAzureADDocs). It should be only used from isolated VNETs to Azure services, with no access to the Internet or other services (M365). |DeployIfNotExists, Disabled |[1.0.0](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Azure%20Active%20Directory/PrivateLinkForAzureAD_PrivateEndpoint_DeployIfNotExists.json) |

## Next steps

- See the built-ins on the [Azure Policy GitHub repo](https://github.com/Azure/azure-policy).
- Review the [Azure Policy definition structure](/azure/governance/policy/concepts/definition-structure).
- Review [Understanding policy effects](/azure/governance/policy/concepts/effects).

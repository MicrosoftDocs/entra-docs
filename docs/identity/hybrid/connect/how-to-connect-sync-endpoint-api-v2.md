---
title: 'Microsoft Entra Connect Sync V2 endpoint'
description: This document covers updates to the Microsoft Entra Connect Sync v2 endpoints API.

author: billmath
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.date: 04/09/2025
ms.subservice: hybrid-connect
ms.author: billmath

---

# Microsoft Entra Connect Sync V2 endpoint API 
Microsoft has deployed a new endpoint (API) for Microsoft Entra Connect that improves the performance of the synchronization service operations to Microsoft Entra ID. By using the new V2 endpoint, you experience noticeable performance gains on export and import to Microsoft Entra ID. This new endpoint supports:
    
 - Syncing groups with up to 250k members.
 - Performance gains on export and import to Microsoft Entra ID.
 
> [!NOTE]
> Currently, the new endpoint does not have a configured group size limit for Microsoft 365 groups that are written back. This may have an effect on your Active Directory and sync cycle latencies. It is recommended to increase your group sizes incrementally.  

>[!NOTE]
> The Microsoft Entra Connect Sync V2 endpoint API is Generally Available but currently can only be used in these Azure environments:
> - Azure Commercial
> - Microsoft Azure operated by 21Vianet cloud
> - Azure US Government cloud
> It won't be made available in the Azure German cloud

## Prerequisites  
In order to use the new V2 endpoint, you need to use Microsoft Entra Connect V2.0. When you deploy Microsoft Entra Connect V2.0, the V2 endpoint is automatically enabled.
There's a known issue where upgrading to the latest V1.6 build resets the group membership limit to 50k. When a server is upgraded to Azure AD Connect V1.6, the customer should reapply the rule changes they initially applied to increase the group membership limit to 250k. This should be done before enabling sync for the server. 

## Frequently asked questions  
 
**When will the new end point become the default for upgrades and new installations?**  
The V2 endpoint is the default setting for Microsoft Entra Connect V2.0, and we advise customers to upgrade to Microsoft Entra Connect V2.0 to use the benefits of this endpoint.
There's an issue for customers running the V2 endpoint with an older version. When they try to upgrade to a newer V1.6 release, the 50-K limitation on group membership is reinstated. When a server is upgraded to Azure AD Connect V1.6, the customer should reapply the rule changes they initially applied to increase the group membership limit to 250k. This should be done before enabling sync for the server. 

## Next steps

* [Microsoft Entra Connect Sync: Understand and customize synchronization](how-to-connect-sync-whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md)

---
title: Limitations of B2B collaboration
description: Current limitations for Microsoft Entra B2B collaboration

 
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 04/15/2025

ms.author: cmulligan
author: csmulligan
manager: dougeby

ms.collection: content-health, M365-identity-device-management

#Customer intent: As a user of Microsoft Entra B2B collaboration, I want to understand the limitations and potential issues with the platform, so that I can effectively manage and troubleshoot any authentication or replication problems that may arise.
---

# Limitations of Microsoft Entra B2B collaboration
Microsoft Entra B2B collaboration is currently subject to the limitations described in this article.

## Possible double multifactor authentication
With Microsoft Entra B2B, you can enforce multifactor authentication at the resource organization (the inviting organization). The reasons for this approach are detailed in [Conditional Access for B2B collaboration users](authentication-conditional-access.md). If a partner already has multifactor authentication set up and enforced, their users might have to perform the authentication once in their home organization and then again in yours.

## Instant-on
In the B2B collaboration flows, we add users to the directory and dynamically update them during invitation redemption, app assignment, and so on. The updates and writes ordinarily happen in one directory instance and must be replicated across all instances. Replication is completed once all instances are updated. Sometimes when the object is written or updated in one instance and the call to retrieve this object is to another instance, replication latencies can occur. If that happens, refresh or retry to help. If you're writing an app using our API, then retries with some back-off is a good, defensive practice to alleviate this issue.

<a name='azure-ad-directories'></a>

## Microsoft Entra directories
Microsoft Entra B2B is subject to Microsoft Entra service directory limits. For details about the number of directories a user can create and the number of directories to which a user or guest user can belong, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

## Next steps

See the following articles on Microsoft Entra B2B collaboration:

- [Microsoft Entra B2B in government and national clouds](b2b-government-national-clouds.md)
- [What is Microsoft Entra B2B collaboration?](what-is-b2b.md)
- [Delegate B2B collaboration invitations](external-collaboration-settings-configure.md)

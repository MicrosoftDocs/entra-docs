---
title: 'Security hardening to the auto-upgrade process for Microsoft Entra Connect and Microsoft Entra Connect Health '
description: This article describes what to do if you find that you're running a deprecated version.

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath

---

# Security hardening to the auto-upgrade process for Microsoft Entra Connect and Microsoft Entra Connect Health 

As part of Microsoft’s push to harden the security of our features, we are making service changes to Microsoft Entra Connect Sync and Microsoft Entra Connect Health. This includes a change to Product Key Services. PKS is an internal service used by Microsoft Entra Connect Sync and Microsoft Entra Connect Health to auto-upgrade client components to an updated version. We are in the process of deprecating PKS, as the service is currently being replaced by the Hybrid Upgrade Service (HUS). 

To take advantage of our latest security improvements, we strongly encourage customers to upgrade to the following builds by <deadline>: 

- Microsoft Entra Connect: version X or higher 
- Microsoft Entra Connect Health 
     - Connect Sync agent: version 2.3.2.0 or higher 
     - AD DS agent: version X or higher 
     - AD FS agent: version X or higher 



## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
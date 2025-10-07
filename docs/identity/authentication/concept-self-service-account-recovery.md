---
title: Overview of Microsoft Entra ID Account Recovery
description: Overview of Microsoft Entra ID Account Recovery.
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 09/24/2025
ms.author: justinha
author: BullittRacer
manager: dougeby
ms.reviewer: timlarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn about self-service account recovery.
---
# Overview of Microsoft Entra ID Account Recovery


Concept article: recovery == reonboarding and restablishing trust in the human behind the account, IDV is the route to achieve. Similar article: Why the future of security depends on verifiable identity | Okta
Microsoft Entra ID self-service account recovery (SSAR) is a feature that allows users to recover access to their Microsoft Entra ID accounts without needing to contact IT support. This feature is particularly useful in scenarios where users have forgotten their passwords, lost access to their authentication methods, or are otherwise unable to sign in.

In today’s identity-first enterprise landscape, administrators face mounting pressure to secure user access while minimizing friction and support overhead. Entra ID Account recovery is now available as a transformative solution, enabling secure, self-service recovery for users who have lost access to all registered devices and authentication methods. By leveraging government-issued Verified IDs and biometric Face Check verification, admins can confidently validate account ownership without relying on help desk interventions. This not only reduces operational costs and improves user experience, but also strengthens defenses against impersonation and MFA fatigue attacks, which continue to rise across global organizations.

Account recovery in many ways is simialr to first time user onboarding and these are the basic phases a user will work through to recover their account:
(Bullets?)
1 - Discover "Recover My Account" option in the standard login UX when looking at other signin methods to use.
2 - User will provide proof of identity using their governemnt supplied documents such as a passport or driver's license through an admin selected Identity Verification Provider.
3 - Check verified credential from the Identity Verification Provider matches the user's photo and face for the account the user is attempting to recover.
4 - If user account ownership validation is successful, then the user issued a temporary access code they can use to register a new auth method, typically a passkey now.

If thre user fails at any of these steps they 


## Related content

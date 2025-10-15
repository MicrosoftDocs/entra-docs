---
title: Browser access guidance for third party mobile device management providers
description: Remove support for TLS 1.0 and 1.1 for the Microsoft Entra Device Registration Service


ms.service: entra-id
ms.subservice: devices
ms.topic: reference
ms.date: 10/15/2025

ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: zhvolosh

---


# Browser access guidance for third party mobile device management providers

Update your [Android Device policy](https://developers.google.com/android/management/reference/rest/v1/enterprises.policies) resource to support automatically enabling browser access during device registration.

As announced in September 2024 and November 2025 in the What’s New in Microsoft Entra blog, we are automatically enabling browser access by default for Android users. This change is part of hardening all Microsoft products as part of the [Secure Future Initiative](https://www.microsoft.com/microsoft-cloud/resources/secure-future-initiative). As part of this initiative, we are eliminating the mechanism to export device registration keys from device storage after registration completes. 


This change means that users of Android devices will no longer be able to modify their browser access settings in Authenticator app or Company Portal after their device has been registered in Microsoft Entra ID.  Instead, Android users will have browser access enabled by default. 


<!-- 3. Prerequisites --------------------------------------------------------------------

Optional: Make **Prerequisites** your first H2 in the article. Use clear and unambiguous
language and use a unordered list format. 

-->

## If you are an MDM provider


<!-- 4. H2s (Article body)
--------------------------------------------------------------------

Required: In a series of H2 sections, the article body should discuss the ideas that explain how "X is a (type of) Y that does Z":

* Give each H2 a heading that sets expectations for the content that follows.
* Follow the H2 headings with a sentence about how the section contributes to the whole.
* Describe the concept's critical features in the context of defining what it is.
* Provide an example of how it's used where, how it fits into the context, or what it does. If it's complex and new to the user, show at least two examples.
* Provide a non-example if contrasting it will make it clearer to the user what the concept is.
* Images, code blocks, or other graphical elements come after the text block it illustrates.
* Don't number H2s.

-->




## Related content
TODO: Add your next step link(s)
- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the 
main branch.

-->

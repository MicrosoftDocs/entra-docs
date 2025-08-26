---
title: Username lookup during sign-in
description: How on-screen messaging reflects username lookup during sign-in in Microsoft Entra ID
author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: article
ms.date: 12/17/2024
ms.author: barclayn
ms.reviewer: kexia
ms.custom: it-pro, sfi-image-nochange
---

# Home realm discovery for Microsoft Entra sign-in pages

We are changing sign-in behavior in Microsoft Entra ID, part of Microsoft Entra, to make room for new authentication methods and improve usability. During sign-in, Microsoft Entra ID determines where a user needs to authenticate. Microsoft Entra ID makes intelligent decisions by reading organization and user settings for the username entered on the sign-in page. This is a step towards a password-free future that enables other credentials like FIDO 2.0.

## Home realm discovery behavior

Traditionally, home realm discovery depended on either the domain provided at sign-in or a Home Realm Discovery policy for legacy applications. For instance, if a Microsoft Entra user entered their username incorrectly but included their organization's domain name, such as "contoso.com," they would still be directed to their organization's credential collection screen. This method didn't allow for customized experiences on an individual user level.

To enhance usability and support a broader range of credentials, Microsoft Entra ID uses a different process. Microsoft Entra ID's username lookup behavior during sign-in intelligently assesses organization-level and user-level settings based on the entered username. If the username is found within the specified domain, the user is directed accordingly; otherwise, the user is redirected to provide their credentials.


Another benefit of this work is improved error messaging. Here are some examples of the improved error messaging when signing in to an application that supports Microsoft Entra users only.

- The username is mistyped or the username hasn't yet been synced to Microsoft Entra ID:
  
   :::image type="content" source="./media/signin-realm-discovery/typo-username.png" alt-text="Screenshot of the username is mistyped or not found.":::
  
- The domain name is mistyped:

   :::image type="content" source="./media/signin-realm-discovery/typo-domain.png" alt-text="Screenshot of the domain name is mistyped or not found.":::
  
- User tries to sign in with a known consumer domain:
  
   :::image type="content" source="./media/signin-realm-discovery/consumer-domain.png" alt-text="Screenshot of sign-in with a known consumer domain.":::
  
- The password is mistyped but the username is accurate:  

   :::image type="content" source="./media/signin-realm-discovery/incorrect-password.png" alt-text="Screenshot of password is mistyped with good username.":::
  
> [!IMPORTANT]
> This feature might have an impact on federated domains relying on the old domain-level Home Realm Discovery to force federation. Federated domain support for this new behavior it's not currently available. In the meantime, some organizations have trained their employees to sign in with a username that doesn’t exist in Microsoft Entra ID but contains the proper domain name, because the domain names routes users currently to their organization's domain endpoint. The new sign-in behavior doesn't allow this. The user is notified to correct the user name, and they aren't allowed to sign in with a username that does not exist in Microsoft Entra ID.
> If you or your organization have practices that depend on the old behavior, it is important for organization administrators to update employee sign-in and authentication documentation and to train employees to use their Microsoft Entra username to sign in.
If you have concerns with the new behavior, leave your remarks in the **Feedback** section of this article.  

## Next steps

[Customize your sign-in branding](~/fundamentals/add-custom-domain.yml)

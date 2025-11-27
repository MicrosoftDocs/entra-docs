---
author: kengaderdus
manager: dougeby
ms.service: identity-platform 
ms.subservice: external
ms.topic: include
ms.date: 11/17/2025
ms.author: kengaderdus
---

You can allow users who sign in with an email address and password to also sign in with a username and password. The username also called an alternate sign-in identifier, can be a customer ID, account number, or another identifier that you choose to use as a username. 

You can assign usernames to the user account manually via the Microsoft Entra admin center or automate it in your app via the Microsoft Graph API.    

Use the steps in [Sign in with an alias or username](../../../external-id/customers/how-to-sign-in-alias.md) article to allow your users to sign-in using a username in your application:

1. [Enable username in sign-in](../../../external-id/customers/how-to-sign-in-alias.md#enable-username-in-sign-in-identifier-policy).
1. [Create users with username in the admin center](../../../external-id/customers/how-to-sign-in-alias.md#create-users-with-username-in-the-admin-center) or [update existing users to by adding a username](../../../external-id/customers/how-to-sign-in-alias.md#update-existing-users-to-add-a-username-in-the-admin-center). Alternatively, you can also [automate user creation and updating in your app by using the Microsoft Graph API](../../../external-id/customers/how-to-sign-in-alias.md#add-a-username-to-existing-users-with-the-microsoft-graph-api).
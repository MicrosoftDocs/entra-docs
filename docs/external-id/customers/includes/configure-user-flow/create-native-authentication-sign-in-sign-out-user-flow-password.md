---
author: henrymbugua
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/12/2023
ms.author: henrymbuguakiarie
ms.manager: mwongerapk
---

Follow these steps to create a user flow.  
 
1. Sign in to the <a href="https://entra.microsoft.com/" target="_blank">Microsoft Entra admin center</a> as at least an [Application Developer](../../../../identity/role-based-access-control/permissions-reference.md#application-developer). 
1. If you have access to multiple tenants, make sure you use the directory that contains your external tenant: 
 
   1. Select the **Directories + subscriptions** icon in the toolbar. 
   1. On the **Portal settings | Directories + subscriptions** page, find your external tenant directory in the **Directory name** list, and then select **Switch**. 
 
1. On the sidebar menu, select **Identity**. 
1. Select **External Identities** > **User flows**. 
1. Select **+ New user flow**. 
1. On the **Create** page: 
 
   1. Enter a **Name** for the user flow, such as *SignInSignUpSample*. 
   1. In the **Identity providers** list, select **Email Accounts**. This identity provider allows users to sign-in or sign-up using their email address. 
   1. Under **Email accounts**, you can select one of the two options. For this tutorial, select **Email with password**. 
 
      - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first factor credential. 
      - **Email one-time passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first factor credential. For this option to be available at the user flow level, make sure you enable email one-time passcode (OTP) at the tenant level (select **All Identity Providers**, and then for **Email One-time passcode** select **Configured**, select the **Yes** option, and then select **Save**). 
 
   1. Under **User attributes**, you can choose the attributes you want to collect from the user upon sign-up. For this guide, select **Country/Region** and **City**. 
 
1. Select **Create**. The new user flow appears in the **User flows** list. If necessary, refresh the page. 

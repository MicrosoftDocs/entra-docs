---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 07/12/2023
ms.author: kengaderdus
ms.manager: dougeby
---
Follow these steps to create a user flow a customer can use to sign in or sign up for an application.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External ID User Flow Administrator](~/identity/role-based-access-control/permissions-reference.md#external-id-user-flow-administrator).  
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu. 
1. Browse to **Entra ID** > **External Identities** > **User flows**.
1. Select **+ New user flow**.
1. On the **Create** page:

   1. Enter a **Name** for the user flow, such as *SignInSignUpSample*.
   1. In the **Identity providers** list, select **Email Accounts**. This identity provider allows users to sign-in or sign-up using their email address.
   
         > [!NOTE]
         > Additional identity providers will be listed here only after you set up federation with them. For example, if you set up federation with [Google](../../how-to-google-federation-customers.md), [Facebook](../../how-to-facebook-federation-customers.md), [Apple](../../how-to-apple-federation-customers.md) or an [OIDC identity provider](../../how-to-custom-oidc-federation-customers.md), you'll be able to select those additional identity providers here.  

   1. Under **Email accounts**, you can select one of the two options. For this tutorial, select **Email with password**.

      - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first factor credential.  
      - **Email one-time-passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first factor credential. Email one-time passcode must be enabled at the tenant level (**All Identity Providers** > **Email One-time-passcode**) for this option to be available at the user flow level. 

   1. Under **User attributes**, choose the attributes you want to collect from the user upon sign-up. By selecting **Show more**, you can choose attributes and claims for **Country/Region**, **Display Name**, and **Postal Code**. Select **OK**. (Users are only prompted for attributes when they sign up for the first time.)

1. Select **Create**. The new user flow appears in the **User flows** list. If necessary, refresh the page.

To enable self-service password reset, use the steps in [Enable self-service password reset](../../how-to-enable-password-reset-customers.md) article.

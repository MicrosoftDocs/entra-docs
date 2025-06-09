---
title: Create a User Flow
description: Add sign-up and sign-in user flows for your consumer and business customers. Create a branded, customized user experience for apps in your external tenant.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 04/23/2025
ms.reviewer: kengaderdus
ms.custom: it-pro, seo-july-2024, sfi-image-nochange
#Customer intent: As a dev, devops, or it admin, I want to create and customize a user flow, which determines the sign-up and sign-in experience for my customer users.
---

# Create a sign-up and sign-in user flow for an external tenant app

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

> [!TIP]
> This article applies to user flows in external tenants. For information about workforce tenants, see [Add a self-service sign-up user flow to an app](../self-service-sign-up-user-flow.yml).

You can create a simple sign-up and sign-in experience for your customers by adding a user flow to your application. The user flow defines the series of sign-up steps customers follow and the sign-in methods they can use (such as email and password, one-time passcodes, or social accounts from [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md), [Apple](how-to-apple-federation-customers.md)) or a custom [OIDC federation](how-to-custom-oidc-federation-customers.md). You can also collect information from customers during sign-up by selecting from a series of built-in user attributes or adding your own custom attributes.

This article describes how to create a sign-in and sign-up user flow. After you create the user flow, the next step is to [add your application to the user flow](how-to-user-flow-add-application.md). You can create multiple user flows if you have multiple applications that you want to offer to customers. Or, you can use the same user flow for many applications. However, an application can have only one user flow. 

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=OnlineRetail)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Online retail” use case.

## Prerequisites

- **A Microsoft Entra external tenant**: Before you begin, create your Microsoft Entra external tenant. You can set up a <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">free trial</a>, or you can create a new external tenant in Microsoft Entra ID.
- **Email one-time passcode enabled (optional)**: If you want customers to use their email address and a one-time passcode each time they sign in, make sure Email one-time passcode is enabled at the tenant level (in the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **External Identities** > **All Identity Providers** > **Email One-time-passcode**).
- **Custom attributes defined (optional)**: User attributes are values collected from the user during self-service sign-up. Microsoft Entra ID comes with a built-in set of attributes, but you can [define custom attributes to collect during sign-up](how-to-define-custom-attributes.md). Define custom attributes in advance so they're available when you set up your user flow. Or you can create and add them later.
- **Identity providers defined (optional)**: You can set up federation with [Google](how-to-google-federation-customers.md), [Facebook](how-to-facebook-federation-customers.md) or an [OIDC identity provider](how-to-custom-oidc-federation-customers.md) in advance, and then select them as sign-in options as you create the user flow.

## Create and customize a user flow

Follow these steps to create a user flow a customer can use to sign in or sign up for an application. These steps describe how to add a new user flow, select the attributes you want to collect, and change the order of the attributes on the sign-up page.

### To add a new user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.

1. Browse to **Entra ID** > **External Identities** > **User flows**.

1. Select **New user flow**.

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/new-user-flow.png" alt-text="Screenshot of the new user flow option.":::

1. On the **Create** page, enter a **Name** for the user flow (for example, "SignUpSignIn").

1. Under **Identity providers**, select the **Email Accounts** check box, and then select one of these options:

   - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first-factor authentication method. You can also configure options for showing, hiding, or customizing the self-service password reset link on the sign-in page ([learn more](how-to-customize-branding-customers.md#to-customize-self-service-password-reset)). If you plan to require multifactor authentication, this option lets you choose from email one-time passcodes, SMS text codes, or both as second-factor methods.

   - **Email one-time passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first-factor authentication method. If you plan to require multifactor authentication, you can enable SMS text codes as a second-factor method.

   > [!NOTE]
   > The **Microsoft Entra ID Sign up** option is unavailable because although customers can sign up for a local account using an email from another Microsoft Entra organization, Microsoft Entra federation isn't used to authenticate them. **[Google](how-to-google-federation-customers.md)** and **[Facebook](how-to-facebook-federation-customers.md)** become available only after you set up federation with them. [Learn more about authentication methods and identity providers](concept-authentication-methods-customers.md).

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/create-user-flow-identity-providers.png" alt-text="Screenshot of Identity provider options on the Create a user flow page.":::

1. Under **User attributes**, choose the attributes you want to collect from the user during sign-up.

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes.png" alt-text="Screenshot of the user attribute options on the Create a user flow page." lightbox="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes.png":::

1. Select **Show more** to choose from the full list of attributes, including **Job Title**, **Display Name**, and **Postal Code**.

   This list also includes any [custom attributes you defined](how-to-define-custom-attributes.md). Select the checkbox next to each attribute you want to collect from the user during sign-up

   :::image type="content" source="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes-show-more.png" alt-text="Screenshot of the user attribute pane after selecting Show more." lightbox="media/how-to-user-flow-sign-up-sign-in-customers/user-attributes-show-more.png":::

1. Select **OK**.

1. Select **Create** to create the user flow.

[//]: # (For Disable sign-up in a sign-up and sign-in user flow, ask kengaderdus)

## Disable sign-up in a sign-up and sign-in user flow

If you want your customer users to only sign in and not sign up, you can disable the sign-up experience in your user flow by using the [Update authenticationEventsFlow API in Microsoft Graph](/graph/api/authenticationeventsflow-update), and updating the **onInteractiveAuthFlowStart** property > **isSignUpAllowed** property to `false`. You need to know the ID of the user flow whose sign-up you want to disable. You can't read the user flow ID from the Microsoft Entra admin center, but you can retrieve it via Microsoft Graph API if you know the app associated with it.

1. Read the application ID associated with the user flow:
    1. Browse to **Entra ID** > **External Identities** > **User flows**.
    1. From the list, select your user flow.
    1. In the left menu, under **Use**, select **Applications**.
    1. From the list, under **Application (client) ID** column, copy the Application (client) ID.

1. Identify the ID of the user flow whose sign-up you want to disable. To do so, [List the user flow associated with the specific application](/graph/api/identitycontainer-list-authenticationeventsflows#example-4-list-user-flow-associated-with-specific-application-id). This is a Microsoft Graph API, which requires you to know the application ID you obtained from the previous step. 

1. [Update your user flow](/graph/api/authenticationeventsflow-update) to disable sign-up. 

    **Example**:

   ```http
   PATCH https://graph.microsoft.com/beta/identity/authenticationEventsFlows/{user-flow-id} 
   ```   

    **Request body**

    ```json
        {    
            "@odata.type": "#microsoft.graph.externalUsersSelfServiceSignUpEventsFlow",    
            "onInteractiveAuthFlowStart": {    
                "@odata.type": "#microsoft.graph.onInteractiveAuthFlowStartExternalUsersSelfServiceSignUp",    
                "isSignUpAllowed": false    
          }    
        }
    ```

    Replace `{user-flow-id}` with the user flow ID that you obtained in the previous step. Notice the `isSignUpAllowed` parameter is set to *false*. To re-enable sign-up, make a call to the Microsoft Graph API endpoint, but set the `isSignUpAllowed` parameter to *true*.   

## Next steps

- [Add your application to the user flow](how-to-user-flow-add-application.md)
- [Create custom user attributes and customize the order of the attributes on the sign-up page](how-to-define-custom-attributes.md).
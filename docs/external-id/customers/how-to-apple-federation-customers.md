---
title: Add Apple for customer sign-in
description: Learn how to add Apple as an identity provider for your external tenant.
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 11/29/2024
ms.author: cmulligan
ms.custom: it-pro, sfi-image-nochange
#Customer intent: As a dev, devops, or it admin, I want to learn how to add Apple as an identity provider for my external tenant.
---
# Add Apple as an identity provider (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

By setting up federation with Apple, you can allow customers to sign in to your applications with their own Apple accounts. After you've added Apple as one of your application's sign-in options, on the sign-in page, customers can sign-in to Microsoft Entra External ID with an Apple account. (Learn more about [authentication methods and identity providers for customers](concept-authentication-methods-customers.md).)

## Create an Apple application

To enable sign-in for customers with an Apple ID, you need to create an application in [Apple Developer panel](https://developer.apple.com/). If you don't already have an Apple ID, you can create one at Certificates, Identifiers & Profiles section.

> [!NOTE]
> This document was created using the state of the provider’s developer page at the time of creation, and changes may occur.
1. Sign in to the Apple Developer Portal with your account credentials.
2. From the menu, select **Certificates, IDs, & Profiles**, and then select **(+)**.
3. In the Register a New Identifier section, select **App IDs**, and then select **Continue**.
4. For Select a type, select **App**, and then select **Continue**.
5. To Register your App ID:
   1. Enter a Description.
   1. Enter the Bundle ID, such as `com.contoso.azure-ad`. Explicit naming such as `com.myappdomain.myappname` recommended.
   1. For Capabilities, select **Sign in with Apple** from the capabilities list.
   1. Take note of your Team ID (App ID Prefix) from this step. You'll need it later.
   1. Select **Continue** and then **Register**.
6. From the menu, select **Certificates, IDs, & Profiles**, and then select **(+)**.
7. In the **Register a new identifier** section, select **Services IDs**, and then select **Continue**.
8. In Register a Services ID:
   1. Enter a **Description**. The description is shown to the user on the consent screen.
   1. Enter the **Identifier**, such as `com.contoso.entra-service`. Explicit naming such as `com.myappdomain.myappname.service` is recommended. Take note of your Service ID identifier. The identifier is your Client ID.
   1. Select **Continue**, and then select **Register**.
9. From **Identifiers**, select the Service ID identifier you created.
10. Select **Sign In with Apple**, and then select **Configure**.
    1. Select the Primary App ID you want to configure Sign in with Apple with.
    2. In **Domains and Subdomains**, enter the following by replacing
      - `<tenant-id>` with your tenant ID or your primary domain name, and
      - `<tenant-name>` with your tenant name. All characters should be in lower-case.
         As an example:
         - `<tenant-name>.ciamlogin.com`
         - `<tenant-id>.ciamlogin.com`

    3. In **Return URLs**, enter the following by replacing `<tenant-id>`with your tenant ID or your primary domain name, and `<tenant-name>` with your tenant name. All characters should be in lower-case.

         As an example:
         - `https://<tenant-id>.ciamlogin.com/<tenant-id>/federation/oauth2`
         - `https://<tenant-id>.ciamlogin.com/<tenant-name>/federation/oauth2`
         - `https://<tenant-name>.ciamlogin.com/<tenant-id>/federation/oauth2`
    4. Select **Next**, and then select **Done**.
    5. When the pop-up window is closed, select **Continue**, and then select **Save**.

## Create an Apple client secret

1. From the Apple Developer portal menu, select **Keys**, and then select **(+)**.
2. To Register a New Key:
    1. Type a **Key Name**.
    1. Select **Sign in with Apple**, and then select **Configure**.
    1. For the Primary App ID, select the app you created previously, and then select **Save**.
3. Select **Continue**, and then select **Register** to finish the key registration process.
4. Take note of the **Key ID**. This key is required when you configure the identity provider.
5. To Download Your Key, select **Download** to download the `.p8` file that contains your key.
6. Select **Done**.

> [!IMPORTANT]
> Sign in with Apple requires the admin to renew their client secret every 6 months. You'll need to manually renew the Apple client secret if it expires and store the new value in the policy key. We recommend you set your own reminder within 6 months to generate a new client secret.

## Configure Apple federation in Microsoft Entra External ID

After you create the Apple app, in this step you set the Apple app details in Microsoft Entra External ID. You can use the Microsoft Entra admin center to do so. To configure Apple federation in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **External Identities** > **All identity providers**.
1. Under the Built-in tab, select **Apple**.

    :::image type="content" source="media/how-to-apple-federation-customers/configure-apple-identity-provider.png" alt-text="Screenshot that shows how to add Apple identity provider.":::

1. The **Name** *Apple* is autopopulated. It cannot be changed.
1. Enter the following details: 
    - **Client (Apple service) ID**: The client ID of the Apple application you created in the previous step.
    - **Apple developer team ID**: The Apple developer team ID related to the Apple application you created in the previous step.
    - **Key ID**: The key ID of the Apple application you created in the previous step.
    - **Client secret (.p8) key**: The client secret key of the Apple application you created in the previous step.
1. Select **Save**. You’ll see Apple listed as a configured identity provider.

    :::image type="content" source="media/how-to-apple-federation-customers/configured-apple-identity-provider.png" alt-text="Screenshot that shows that Apple is added to the identity providers list.":::

## Add Apple identity provider to a user flow

At this point, the Apple identity provider has been set up in your Microsoft Entra External ID, but it's not yet available in any of the sign-in pages. To add the Apple identity provider to a user flow:

1. In your customer tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow where you want to add the Apple identity provider.
1. Under Settings, select **Identity providers**.
1. Under **Other Identity Providers**, select **Apple**.
1. Select **Save**.

## Related content

- [Add Google as an identity provider](how-to-google-federation-customers.md)
- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md)

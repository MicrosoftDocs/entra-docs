---
title: Add attributes to token claims
description: Learn how to add built-in user attributes and custom attributes as claims to the application token. Use directory extension attributes for sending user data to applications in token claims.
ms.author: cmulligan
author: csmulligan
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 04/14/2025
ms.custom: it-pro, sfi-image-nochange
---

# Add user attributes to token claims  

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

User attributes are values collected from the user during self-service sign-up. In addition to built-in user attributes, you can create custom attributes when you need to collect additional information. Because your application might rely on certain user attributes to function as designed, you can add any of these attributes to the token that is sent from Microsoft Entra ID to your application.

You can specify which built-in or custom attributes you want to include as claims in the token that Microsoft Entra ID sends to your application.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=TokenAugmentation)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Add claims to security tokens from a REST API” use case.


## Prerequisites

- [Register the application](/entra/identity-platform/quickstart-register-app) with Microsoft Entra ID.
- [Create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md) and selected the attributes you want to collect during sign-up.
- [Create the custom attributes](how-to-define-custom-attributes.md) you want to include.

## Add built-in or custom attributes to the token

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations**.
1. Select your application in the list to open the application's **Overview** page.

    :::image type="content" source="media/how-to-add-attributes-to-token/select-app.png" alt-text="Screenshot of the overview page of the app registration." border="true":::

1. In the **Essentials** section, under **Managed application in local directory**, select the link showing the name of your application.

    :::image type="content" source="media/how-to-add-attributes-to-token/managed-app-in-local-directory-link.png" alt-text="Screenshot of the managed application in local directory link." border="true":::

1. Under **Manage**, select **Single Sign-on**.
1. In the **Attributes & Claims** section, select the **Edit** icon.

    :::image type="content" source="media/how-to-add-attributes-to-token/single-sign-on-edit.png" alt-text="Screenshot of the attributes and claims section and the edit icon." border="true":::

### To add a built-in attribute to the token as a claim

1. On the **Attributes & Claims** page, select **Add new claim**.
1. Enter a **Name**.
1. Next to **Source**, select **Attribute**. Then use the drop-down list to select the built-in attribute.

    :::image type="content" source="media/how-to-add-attributes-to-token/add-built-in-claim.png" alt-text="Screenshot of the drop-down list of built-in attributes." border="true":::

1. Select **Save**. Repeat for all built-in attributes you want to add.

### To add a custom attribute to the token as a claim

1. On the **Attributes & Claims** page, select **Add new claim**.
1. Enter a **Name**.
1. Next to **Source**, select **Directory schema extension**.

    :::image type="content" source="media/how-to-add-attributes-to-token/manage-claim-directory-schema.png" alt-text="Screenshot of the Directory schema extension option." border="true":::

1. In the **Select Application** pane, select **b2c-extensions-app** (the app that contains all extension attributes for your external tenant), and then choose **Select**.
1. In the **Add Extension Attributes** pane, find the custom attribute you want to add as a claim to the token, and then select it.
1. Select **Add**.
1. Select **Save**. Repeat for each custom attribute you want to add.

### Update the application manifest to accept mapped claims in Microsoft Graph App Manifest(New)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations**.
1. Select your application in the list to open the application's **Overview** page.
1. In the left menu, under **Manage**, select **Manifest** to open the application manifest.
1. Find the **acceptMappedClaims** key and set its value to **true**.
1. Find the **isFallbackPublicClient** key and set its value to **true**.
1. Select **Save**.

## See also

- [Create a REST API with a token issuance start event](~/identity-platform/custom-extension-tokenissuancestart-setup.md)
- [Configure a custom claims provider for a token issuance event](~/identity-platform/custom-extension-tokenissuancestart-configuration.md)

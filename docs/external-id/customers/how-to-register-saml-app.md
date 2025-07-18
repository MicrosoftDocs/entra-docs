---
title: Register a SAML app
description: Learn how to create and register a SAML app with External ID for customer identity and access management (CIAM). Choose your app type and get detailed steps. 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 06/26/2025
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about how to register a SAML app through the Microsoft Entra admin center.
---
# Register a SAML app in your external tenant 

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

In external tenants, you can register applications that use the OpenID Connect (OIDC) or Security Assertion Markup Language (SAML) protocol for authentication and single sign-on. The [app registration](how-to-register-ciam-app.md) process is designed specifically for OIDC apps. But you can use the Enterprise applications feature to create and register your SAML app. This process generates a unique application ID (client ID) and adds your app to the App registrations, where you can view and manage its properties.

This article describes how to register your own SAML application in your external tenant by creating a *non-gallery* app in **Enterprise applications**.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovebanking.com/)
> 
> To try out SAML app with External ID for customer identity and access management (CIAM), go to the Woodgrove live demo and select the sign-in option.

## Prerequisites

- An Azure account that has an active subscription. <a href="https://azure.microsoft.com/free/?WT.mc_id=A261C142F" target="_blank">Create an account for free</a>.
- A Microsoft Entra [external tenant](how-to-create-external-tenant-portal.md).
- [A sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md).

## Create and register a SAML app

1. Sign in to the Microsoft Entra admin center as at least an Application Administrator.

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories** menu.
1. Go to **Identity** > **Applications**> **Enterprise applications**.

1. Select **New application**, and then select **Create your own application**.

   :::image type="content" source="media/how-to-register-saml-app/create-your-own-application.png" alt-text="Screenshot of the Create your own application option in the Microsoft Entra Gallery.":::

1. On the **Create your own application** pane, enter a name for your app.

1. Select **Integrate any other application you don't find in the gallery (Non-gallery)**.

1. Select **Create**.

1. The app **Overview** page opens. In the left menu under **Manage**, select **Properties**. Switch the **Assignment required?** toggle to **No** so that users can use self-service sign-up, and then select **Save**.

   :::image type="content" source="media/how-to-register-saml-app/assignment-toggle-no.png" alt-text="Screenshot of the Assignment required toggle.":::

1. In the left menu under **Manage**, select **Single sign-on**.

1. Under **Select a single sign-on method**, select **SAML**.

   :::image type="content" source="media/how-to-register-saml-app/select-single-sign-on-method.png" alt-text="Screenshot of the Single sign-on method tile.":::

1. On the **SAML-based Sign-on** page, do one of the following:

   - Select **Upload metadata file**, browse to the file containing your metadata, and then select **Add**. Select **Save**.
   - Or, use the **Edit** pencil option to update each section, and then select **Save**. 

1. At the third section under **SAML Certificates**, note that there's no **Download** button next to **Federation Metadata XML**. This button appears only in workforce tenants, not in external tenants.  To download the metadata file in an external tenant, copy the link and paste it into your browser.

   :::image type="content" source="media/how-to-register-saml-app/federation-metadata-xml.png" alt-text="Screenshot of the federation metadata xml link.":::

1. Select **Test**, and then select the **Test sign-in** button to see if single sign-on is working. This test verifies that your current admin account can sign in using the `https://login.microsoftonline.com` endpoint.

   :::image type="content" source="media/how-to-register-saml-app/test-application.png" alt-text="Screenshot of the test single sign-on option.":::

   You can test external user sign-in with these steps:

   - [Create a sign-up and sign-in user flow](~/external-id/customers/how-to-user-flow-sign-up-sign-in-customers.md) if you haven't already.
   - [Add your SAML application to the user flow](~/external-id/customers/how-to-user-flow-add-application.md).
   - Run your application.
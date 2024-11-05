---
title: Get started guide features
description: Learn about the features you set up with the get started guide. 

author: csmulligan
manager: celestedg
ms.service: entra-external-id

ms.subservice: external
ms.topic: concept-article
ms.date:  04/24/2024
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, I want to know about the functions I set up with the get started guide so that I can understand the value of the features and how to use them.
---
# Get started guide features

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

After completing the [get started guide](/entra/external-id/customers/quickstart-get-started-guide), you can recreate, edit, and customize the initial configuration to meet your company’s needs. This helps you become familiar with the features and functions of Microsoft Entra External ID, better understand how to use them, and appreciate the value they provide. During this process, you might even discover new features that you want to use.

The get started guide set up the below features for you automatically. This article explains these features and guides you on how to configure them manually.

:::image type="content" source="media/concept-guide-explained/guide-flow.png" alt-text="Flowchart that shows the steps in the guide.":::

## Trial tenant creation

:::image type="content" source="media/concept-guide-explained/trial-creation.png" alt-text="Flowchart that shows the trial tenant creation step in the guide.":::

An external tenant is the first resource you need to create to get started with Microsoft Entra External ID. If you have an Azure subscription, you can create your new tenant in the Microsoft Entra admin center by following [these steps](how-to-create-external-tenant-portal.md). 

If you don’t have an Azure subscription, you can sign up for a [free trial](quickstart-trial-setup.md#get-started-with-trying-out-external-id). The trial gives you access to a tenant for 30 days. During the free trial period, you have access to all product features, with few exceptions. For more information, see the [Start a free trial without Azure subscription](quickstart-trial-setup.md). 

## App registration

:::image type="content" source="media/concept-guide-explained/app-registration.png" alt-text="Flowchart that shows the app registration step in the guide.":::

To enable your application to sign in with Microsoft Entra External ID, you need to register your app with Microsoft Entra External ID. The get started guide creates this trusted relationship between the sample app and your tenant. It not only registers the app but also creates an endpoint, the redirect URI, and adds basic delegated permissions to the app for you to test the sign-in process.

If you register your app manually, you can also grant API permission if your app needs to call an API. Based on your app type, you have to choose the right registration process. You can find more information on how to register your app [here](how-to-register-ciam-app.md#choose-your-app-type).

## User flow

:::image type="content" source="media/concept-guide-explained/user-flow.png" alt-text="Flowchart that shows the user flow step in the guide.":::

The get started guide automatically creates the user flow for you. A user flow defines the authentication methods a customer can use to sign in to your application and the information they need to provide during sign-up. You can configure the existing user flow or create a new one. If you want the same sign-in experience for all of your apps, you can add multiple apps to the same user flow. However, only one sign-in experience is needed for an application, so you can add each application to just one user flow.

You can find more information on how to create a user flow [here](how-to-user-flow-sign-up-sign-in-customers.md) and how to add an application to the user flow [here](how-to-user-flow-add-application.md). After you create the user flow, you can test your sign-up and sign-in experience with the [Run user flow feature](how-to-test-user-flows.md).

If your app requires more information than the built-in user attributes provide, you can add your own attributes. We refer to these attributes as custom user attributes. You can create custom user attributes manually and add them to your user flow. You can find more information on how to create custom attributes [here](how-to-define-custom-attributes.md#create-custom-user-attributes).

## Branding

:::image type="content" source="media/concept-guide-explained/branding.png" alt-text="Flowchart that shows the branding step in the guide.":::

The get started guide provided you with several basic options to customize the sign-in page, including adding your company logo, changing the background color, and adjusting the layout. 

After the initial setup, you can manually edit these settings and add more branding options. You can refine the layout, add headers and footers, configure text, images, and hyperlinks, and add languages to your sign-in and sign-up pages. 
For more details about the various branding options available in your new external tenant, visit the [Branding options](how-to-customize-branding-customers.md) page.
 
## Sign-in preview with your first user

:::image type="content" source="media/concept-guide-explained/sign-in-preview.png" alt-text="Flowchart that shows the sign-in preview step in the guide.":::

The get started guide allowed you to preview the sign-in experience with your first user. At this step in the guide, you had to create a new user only to test the sign-up steps. In the guide, your newly created user was redirected to JWT.ms instead of your app.
 
To find the user you created during the guide setup, you can go to the [admin center](https://entra.microsoft.com/) and look for the user in the users list. You can find the user in the users list as a [customer user](how-to-manage-customer-accounts.md) and also manage your own account as a [tenant admin](how-to-manage-admin-accounts.md). If you’d like to see data on user activity and engagement for registered applications in your tenant, you can use the [Application user activity dashboards](how-to-user-insights.md).

The guide set up the authentication method for your customer users; you choose between email and password, or one-time passcode sign-in.
You can also manually configure other options for authenticating users of your applications, including enabling sign-in with social accounts like Facebook and Google, or using a custom OpenID Connect identity provider.
For more information on how to configure these options, visit the [Authentication methods and identity providers](concept-authentication-methods-customers.md) page. You can also [enable self-service password reset](how-to-enable-password-reset-customers.md) for your customers. 

## App samples

:::image type="content" source="media/concept-guide-explained/app-sample.png" alt-text="Flowchart that shows the app sample step in the guide.":::

The get started guide provides a downloadable sample app to test the features of your new tenant. When you register your app manually, Microsoft Entra ID generates a unique identifier known as an **Application (client) ID**. This value is used to identify your app when creating authentication requests, enabling a trusted relationship between your app and your tenant. The samples are automatically configured with your **clientId** and the **authority** is set to `<trialtenant>.ciamlogin.com`.

You can find the comprehensive list of app samples and guides [here](samples-ciam-all.md) that explains the process in detail.

The **Code sample guide** links point to the relevant sample articles and guide you through the process of registering your app, creating a user flow, associating your app with the user flow, and running your project to sign in. In some cases, it also guides you on how to call an API.

For more information on configuring your app for authentication, see the **Build and integrate guide** links. These tutorials assist you in building and integrating your own apps with Microsoft Entra External ID. You can also add [custom authentication extensions](concept-custom-extensions.md) at specific points within the authentication flow.


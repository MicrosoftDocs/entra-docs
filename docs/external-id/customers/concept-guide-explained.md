---
title: Get started guide features
description: Learn about the features you set up with the get started guide. 

author: csmulligan
manager: celestedg
ms.service: active-directory

ms.subservice: ciam
ms.topic: conceptual
ms.date:  02/23/2023
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As an it admin, I want to know about the functions I set up with the get started guide so that I can understand the value of the features and how to use them.
---
<!--Check the wording: functions or features or explanation. -->
# Get started guide features

After completing the get started guide, you can edit and customize the initial configuration to meet your company’s needs. This will help you become familiar with the features and functions of Microsoft Entra ID for customers, better understand how to use them, and appreciate the value they provide. During this process, you may even discover new features that you want to use.

## Prerequisites

- External ID for customers tenant. If you don't already have one, <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">sign up for a free trial</a> or [create a tenant with customer configurations in the Microsoft Entra admin center](quickstart-tenant-setup.md). 

## Customize your sign-in experience

The first step in the guide is to customize the sign-in experience for your customers.

    :::image type="content" source="media/how-to-create-customer-tenant-portal/guide-link.png" alt-text="Screenshot that shows how to start the guide.":::

You configured email and password, or one-time passcode sign-in. After the initial configuration in the guide, you can change this setting and even  [enable self-service password reset](how-to-enable-password-reset-customers.md) in the [admin center](https://entra.microsoft.com/). At this stage, you can also configure social accounts to allow your customers to sign in using their [Google](how-to-google-federation-customers.md) or [Facebook](how-to-facebook-federation-customers account.md). You can also [define custom attributes](how-to-define-custom-attributes.md) to collect additional information during sign-up.
On the same first page of the guide, you might have also customized the company logo, background color, and layout of your sign-in page. If you’d like to add more details and customization to your sign-in page, you can customize [customize the default branding](how-to-customize-branding-customers.md) and [add languages](how-to-customize-languages-customers.md) later.

## Your first user

During the initial setup, you might have created your first user to test the sign-in experience. 

    :::image type="content" source="media/quickstart-trial-setup/successful-trial-setup.png" alt-text="Screenshot that shows the successful creation of the sign-up experience.":::

You can find the user in the users list as a [customer user](how-to-manage-customer-accounts.md) in the [admin center](https://entra.microsoft.com/). You can also manage your own account as a [tenant admin](how-to-manage-admin-accounts.md). If you’d like to see data on user activity and engagement for registered applications in your tenant, you can use the [Application user activity dashboards](how-to-user-insights.md).

After the initial setup, you might be prompted to set up additional authentication factors for added security of your tenant admin account. Learn more about [multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md) and [Identity Protection](how-to-identity-protection-customers.md). 

Using role-based access control (RBAC), you can enforce authorizations in applications. An application developer can define roles for the application, and the tenant administrator can then assign roles to different users and groups to control who has access to content and functionality in the application. You can learn more about it [here](how-to-use-app-roles-customers.md).

## Your sample app

In the guide, you configured a sample app. The guide provides a limited set of app samples to test the features of your new tenant. 

    :::image type="content" source="media/quickstart-trial-setup/sample-app-setup.png" alt-text="Screenshot of the sample app setup.":::

You can find the comprehensive list of app samples and guides [here](https://learn.microsoft.com/en-us/entra/external-id/customers/samples-ciam-all?tabs=apptype). 

The **Code sample guide** links will point to the relevant sample articles and will guide you through the process of registering your app, creating a user flow, associating your app with the user flow, and running your project to sign in. In some cases, it will also guide you on how to call an API.

For more information on configuring your app for authentication, refer to the **Build and integrate guide** links. These tutorials will assist you in building and integrating your own apps with Microsoft Entra ID for customers. You can also add [custom authentication extensions](concept-custom-extensions) at specific points within the authentication flow. 

To have an overview of all the supported features in your new tenant visit the [Supported features in Microsoft Entra ID for customers (preview)](concept-supported-features-customers.md) page. 

## Related content

- [Overview of CIAM samples](samples-ciam-all.md)
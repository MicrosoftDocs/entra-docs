---
title: "How to register an app in Microsoft Entra ID"
description: Learn how to register your app in Microsoft Entra ID and configure it for single-tenant or multitenant use.
author: cilwerner
manager: pmwongera
ms.author: cwerner
ms.custom: mode-other
ms.date: 01/29/2025
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As developer, I want to know how to register my application in Microsoft Entra tenant. I want to understand the additional configurations to help make my application secure. 
---

# Register an application in Microsoft Entra ID

In this how-to guide, you learn how to register an application in Microsoft Entra ID. This process is essential for establishing a trust relationship between your application and the Microsoft identity platform. By completing this quickstart, you enable identity and access management (IAM) for your app, allowing it to securely interact with Microsoft services and APIs. 

## Prerequisites

- An Azure account that has an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- The Azure account must be at least a [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
- A workforce or external tenant. You can use your **Default Directory** for this quickstart. If you need an external tenant, complete [set up an external tenant](/entra/external-id/customers/quickstart-tenant-setup).

## Register an application

Registering your application in Microsoft Entra establishes a trust relationship between your app and the Microsoft identity platform. The trust is unidirectional. Your app trusts the Microsoft identity platform, and not the other way around. Once created, the application object can't be moved between different tenants.

Follow these steps to create the app registration:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="./media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the tenant in which you want to register the application.
1. Browse to **Entra ID** > **App registrations** and select **New registration**.
1. Enter a meaningful **Name** for your app, for example *identity-client-app*. App users can see this name, and it can be changed at any time. You can have multiple app registrations with the same name.
1. Under **Supported account types**, specify who can use the application. We recommend you select **Accounts in this organizational directory only** for most applications. Refer to the table for more information on each option.

   | Supported account types | Description   |
   | ----------------------- | ------------- |
   | **Accounts in this organizational directory only** | For *single-tenant* apps for use only by users (or guests) in *your* tenant. |
   | **Accounts in any organizational directory** | For *multitenant* apps and you want users in *any* Microsoft Entra tenant to be able to use your application. Ideal for software-as-a-service (SaaS) applications that you intend to provide to multiple organizations. |
   | **Accounts in any organizational directory and personal Microsoft accounts** | For *multitenant* apps that support both organizational and personal Microsoft accounts (for example, Skype, Xbox, Live, Hotmail). |
   | **Personal Microsoft accounts** | For apps used only by personal Microsoft accounts (for example, Skype, Xbox, Live, Hotmail). |

1. Select **Register** to complete the app registration.

   :::image type="content" source="./media/quickstart-register-app/portal-02-app-reg-01.png" alt-text="Screenshot of Microsoft Entra admin center in a web browser, showing the Register an application pane." lightbox="./media/quickstart-register-app/portal-02-app-reg-01.png":::

1. The application's **Overview** page is displayed. Record the **Application (client) ID**, which uniquely identifies your application and is used in your application's code as part of validating the security tokens it receives from the Microsoft identity platform.

    :::image type="content" source="./media/quickstart-register-app/portal-03-app-reg-02.png" alt-text="Screenshot of the Microsoft Entra admin center in a web browser, showing an app registration's Overview pane." lightbox="./media/quickstart-register-app/portal-03-app-reg-02.png":::

> [!IMPORTANT]
> New app registrations are hidden to users by default. When you're ready for users to see the app on their [My Apps page](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510) you can enable it. To enable the app, in the Microsoft Entra admin center navigate to **Entra ID** > **Enterprise apps** and select the app. Then on the **Properties** page, set **Visible to users?** to **Yes**.

## Grant admin consent (external tenants only)

Once you register your application, it gets assigned the **User.Read** permission. However, for external tenants, the customer users themselves can't consent to permissions themselves. You as the admin must consent to this permission on behalf of all the users in the tenant:

1. From the **Overview** page of your app registration, under **Manage** select **API permissions**.
1. Select **Grant admin consent for < tenant name >**, then select **Yes**.
1. Select **Refresh**, then verify that **Granted for < tenant name >** appears under **Status** for the permission.

## Related content

- [Add a redirect URI to your application](how-to-add-redirect-uri.md)
- [Add credentials to your application](how-to-add-credentials.md)
- [Configure an application to expose a web API](quickstart-configure-app-expose-web-apis.md)
- [Microsoft identity platform code samples](./sample-v2-code.md)
- [Add your application to a user flow](/entra/external-id/customers/how-to-user-flow-add-application)

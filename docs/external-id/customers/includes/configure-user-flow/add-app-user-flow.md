---
author: kengaderdus
ms.service: entra-external-id
ms.subservice: customers
ms.topic: include
ms.date: 07/23/2024
ms.author: kengaderdus
ms.manager: mwongerapk
---
For the customer users to see the sign-up or sign-in experience when they use your app, you need to associate your app with a user flow. Although many applications can be associated with your user flow, a single application can only be associated with one user flow.

1. On the sidebar menu, select **Identity**.

1. Select **External Identities**, then **User flows**.

1. In the **User flows** page, select the **User flow name** you created earlier, for example, *SignInSignUpSample*.

1. Under **Use**, select **Applications**.

1. Select **Add application**.
   <!--[Screenshot the shows how to associate an application to a user flow.](media/20-create-user-flow-add-application.png)-->

1. Select the application from the list such as *ciam-client-app* or use the search box to find the application, and then select it.

1. Choose **Select**. 

Once you associate your app with a user flow, you can test your user flow by simulating a user’s sign-up or sign-in experience with your application from within the Microsoft Entra admin center. To do so, use the steps in [Test your sign-up and sign-in user flow](../../how-to-test-user-flows.md). 
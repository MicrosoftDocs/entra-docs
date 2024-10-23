---
title: 'Tutorial - multifactor authentication for B2B'
description: In this tutorial, learn how to require multifactor authentication when you use Microsoft Entra B2B to collaborate with external users and partner organizations.

 
ms.service: entra-external-id
ms.topic: tutorial
ms.date: 06/27/2024

ms.author: cmulligan
author: csmulligan
manager: CelesteDG
ms.custom: it-pro
ms.collection: M365-identity-device-management
# Customer intent: As an IT admin managing external B2B guest users, I want to enforce multifactor authentication for access to cloud or on-premises applications, so that I can ensure the security of our resources and protect against unauthorized access.
---

# Tutorial: Enforce multifactor authentication for B2B guest users

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

When collaborating with external B2B guest users, it’s a good idea to protect your apps with multifactor authentication policies. Then external users need more than just a user name and password to access your resources. In Microsoft Entra ID, you can accomplish this goal with a Conditional Access policy that requires MFA for access. MFA policies can be enforced at the tenant, app, or individual guest user level, the same way that they're enabled for members of your own organization. The resource tenant is always responsible for Microsoft Entra multifactor authentication for users, even if the guest user’s organization has multifactor authentication capabilities.

Example:

:::image type="content" source="media/tutorial-mfa/b2b-mfa-example.png" alt-text="Diagram showing a guest user signing into a company's apps.":::


1. An admin or employee at Company A invites a guest user to use a cloud or on-premises application that is configured to require MFA for access.
1. The guest user signs in with their own work, school, or social identity.
1. The user is asked to complete an MFA challenge. 
1. The user sets up MFA with Company A and chooses their MFA option. The user is allowed access to the application.

>[!NOTE]
>Microsoft Entra multifactor authentication is done at resource tenancy to ensure predictability. When the guest user signs in, they'll see the resource tenant sign-in page displayed in the background, and their own home tenant sign-in page and company logo in the foreground.

In this tutorial, you will:

> [!div class="checklist"]
>
> - Test the sign-in experience before MFA setup.
> - Create a Conditional Access policy that requires MFA for access to a cloud app in your environment. In this tutorial, we’ll use the Windows Azure Service Management API app to illustrate the process.
> - Use the What If tool to simulate MFA sign-in.
> - Test your Conditional Access policy.
> - Clean up the test user and policy.

If you don’t have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

## Prerequisites

To complete the scenario in this tutorial, you need:

- **Access to Microsoft Entra ID P1 or P2 edition**, which includes Conditional Access policy capabilities. To enforce MFA, you need to create a Microsoft Entra Conditional Access policy. MFA policies are always enforced at your organization, regardless of whether the partner has MFA capabilities.
- **A valid external email account** that you can add to your tenant directory as a guest user and use to sign in. If you don't know how to create a guest account, see [Add a B2B guest user in the Microsoft Entra admin center](add-users-administrator.yml).

<a name='create-a-test-guest-user-in-azure-ad'></a>

## Create a test guest user in Microsoft Entra ID

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user**, and then select **Invite external user**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-new-user.png" alt-text="Screenshot showing where to select the new guest user option." lightbox="media/tutorial-mfa/tutorial-mfa-new-user.png":::

1. Under **Identity** on the **Basics** tab, enter the email address of the external user. Optionally, include a display name and welcome message.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-new-user-identity.png" alt-text="Screenshot showing where to enter the guest email.":::

1. Optionally, you can add further details to the user under the **Properties** and **Assignments** tabs.
1. Select **Review + invite** to automatically send the invitation to the guest user. A **Successfully invited user** message appears.
1. After you send the invitation, the user account is automatically added to the directory as a guest.

## Test the sign-in experience before MFA setup

1. Use your test user name and password to sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. You should be able to access the Microsoft Entra admin center using only your sign-in credentials. No other authentication is required.
1. Sign out.

## Create a Conditional Access policy that requires MFA

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name, like **Require MFA for B2B portal access**. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, choose **Select users and groups**, and then select **Guest or external users**. You can assign the policy to different [external user types](authentication-conditional-access.md#assigning-conditional-access-policies-to-external-user-types), built-in directory roles, or users and groups. 

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-user-access.png" alt-text="Screenshot showing selecting all guest users.":::

1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, choose **Windows Azure Service Management API**, and select **Select**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-app-access.png" alt-text="Screenshot showing the Cloud apps page and the Select option." lightbox="media/tutorial-mfa/tutorial-mfa-app-access.png":::

1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-grant-access.png" alt-text="Screenshot showing the option for requiring multifactor authentication.":::

1. Under **Enable policy**, select **On**.
1. Select **Create**.

## Use the What If option to simulate sign-in

1. On the **Conditional Access | Policies** page, select **What If**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-what-if.png" alt-text="Screenshot that highlights where to select the What if option on the Conditional Access - Policies page.":::

1. Select the link under **User**. 
1. In the search box, type the name of your test guest user. Choose the user in the search results, and then choose **Select**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-what-if-user.png" alt-text="Screenshot showing a guest user selected.":::

1. Select the link under **Cloud apps, actions, or authentication content**. Choose **Select resources**, and then choose the link under **Select**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-what-if-app.png" alt-text="Screenshot showing the app selected." lightbox="media/tutorial-mfa/tutorial-mfa-what-if-app.png":::

1. On the **Cloud apps** page, in the applications list, choose **Windows Azure Service Management API**, and then choose **Select**.
1. Choose **What If**, and verify that your new policy appears under **Evaluation results** on the **Policies that will apply** tab.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-whatif-4.png" alt-text="Screenshot showing the results of the What If evaluation.":::

## Test your Conditional Access policy

1. Use your test user name and password to sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. You should see a request for more authentication methods. It can take some time for the policy to take effect.

    :::image type="content" source="media/tutorial-mfa/mfa-required.PNG" alt-text="Screenshot showing the More information required message.":::

    > [!NOTE]
    > You also can configure [cross-tenant access settings](cross-tenant-access-overview.md) to trust the MFA from the Microsoft Entra home tenant. This allows external Microsoft Entra users to use the MFA registered in their own tenant rather than register in the resource tenant.

1. Sign out.

## Clean up resources

When no longer needed, remove the test user and the test Conditional Access policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select the test user, and then select **Delete user**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. In the **Policy Name** list, select the context menu (…) for your test policy, and then select **Delete**. Select **Yes** to confirm.

## Next step

In this tutorial, you created a Conditional Access policy that requires guest users to use MFA when signing in to one of your cloud apps. To learn more about adding guest users for collaboration, see [Add Microsoft Entra B2B collaboration users in the Microsoft Entra admin center](add-users-administrator.yml).

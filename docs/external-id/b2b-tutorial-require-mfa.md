---
title: 'Tutorial - multifactor authentication for B2B'
description: In this tutorial, learn how to require multifactor authentication when you use Microsoft Entra B2B to collaborate with external users and partner organizations.
ms.service: entra-external-id
ms.topic: tutorial
ms.date: 04/28/2025
ms.author: cmulligan
author: csmulligan
manager: CelesteDG
ms.collection: M365-identity-device-management
ms.custom: it-pro, sfi-image-nochange
# Customer intent: As an IT admin managing external B2B guest users, I want to enforce multifactor authentication for access to cloud or on-premises applications, so that I can ensure the security of our resources and protect against unauthorized access.
---

# Tutorial: Enforce multifactor authentication for B2B guest users

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

When you collaborate with external B2B guest users, protect your apps with multifactor authentication policies. External users need more than just a username and password to access your resources. In Microsoft Entra ID, you can accomplish this goal with a Conditional Access policy that requires MFA for access. You can enforce MFA policies at the tenant, app, or individual guest user level, just like for members of your own organization. The resource tenant is responsible for Microsoft Entra multifactor authentication for users, even if the guest user's organization has multifactor authentication capabilities.

Example:

:::image type="content" source="media/tutorial-mfa/b2b-mfa-example.png" alt-text="Diagram showing a guest user signing into a company's apps.":::


1. An admin or employee at Company A invites a guest user to use a cloud or on-premises application that is configured to require MFA for access.
1. The guest user signs in with their own work, school, or social identity.
1. The user is asked to complete an MFA challenge. 
1. The user sets up MFA with Company A and chooses their MFA option. The user is allowed access to the application.

>[!NOTE]
>Microsoft Entra multifactor authentication is done at resource tenancy to ensure predictability. When the guest user signs in, they see the resource tenant sign-in page displayed in the background, and their own home tenant sign-in page and company logo in the foreground.

In this tutorial, you will:

> [!div class="checklist"]
>
> - Test the sign-in experience before setting up MFA.
> - Create a Conditional Access policy that requires MFA for access to a cloud app in your environment. In this tutorial, we’ll use the Azure Resource Manager app to illustrate the process.
> - Use the What If tool to simulate MFA sign-in.
> - Test your Conditional Access policy.
> - Clean up the test user and policy.

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) to get started.

## Prerequisites

To complete the scenario in this tutorial, you need:

- **Access to Microsoft Entra ID P1 or P2 edition**, which includes Conditional Access policy capabilities. To enforce MFA, create a Microsoft Entra Conditional Access policy. MFA policies are always enforced at your organization, even if the partner doesn't have MFA capabilities.
- **A valid external email account** that you can add to your tenant directory as a guest user and use to sign in. If you don't know how to create a guest account, follow the steps in [Add a B2B guest user in the Microsoft Entra admin center](add-users-administrator.yml).

<a name='create-a-test-guest-user-in-azure-ad'></a>

## Create a test guest user in Microsoft Entra ID


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** and then **Invite external user**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-new-user.png" alt-text="Screenshot of where to select the new guest user option." lightbox="media/tutorial-mfa/tutorial-mfa-new-user.png":::

1. Under **Identity** on the **Basics** tab, enter the email address of the external user. You can optionally include a display name and welcome message.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-new-user-identity.png" alt-text="Screenshot of where to enter the guest email.":::

1. You can optionally add further details to the user under the **Properties** and **Assignments** tabs.
1. Select **Review + invite** to automatically send the invitation to the guest user. A **Successfully invited user** message appears.
1. After you send the invitation, the user account is added to the directory as a guest.

## Test the sign-in experience before MFA setup

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using your test user name and password.
1. Access the Microsoft Entra admin center using only your sign-in credentials. No other authentication is required.
1. Sign out of the Microsoft Entra admin center.

## Create a conditional access policy that requires MFA

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Name your policy, like **Require MFA for B2B portal access**. Create a meaningful standard for naming policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, choose **Select users and groups**, and then select **Guest or external users**. You can assign the policy to different [external user types](authentication-conditional-access.md#assigning-conditional-access-policies-to-external-user-types), built-in directory roles, or users and groups. 

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-user-access.png" alt-text="Screenshot showing selecting all guest users.":::

1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, choose **Azure Resource Manager**, and then **Select** the resource.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-app-access.png" alt-text="Screenshot showing the Cloud apps page and the Select option." lightbox="media/tutorial-mfa/tutorial-mfa-app-access.png":::

1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and select **Select**.

    :::image type="content" source="media/tutorial-mfa/tutorial-mfa-grant-access.png" alt-text="Screenshot showing the option for requiring multifactor authentication.":::

1. Under **Enable policy**, select **On**.
1. Select **Create**.

## Use the What If option to simulate sign-in

The **Conditional Access What If policy tool** helps you understand the effects of Conditional Access policies in your environment. Instead of manually testing your policies with multiple sign-ins, you can use this tool to simulate a user's sign-in. The simulation predicts how this sign-in will affect your policies and generates a report. For more information, see [Use the What If tool to understand Conditional Access policies](/entra/identity/conditional-access/what-if-tool).

## Test your conditional access policy

1. Use your test user name and password to sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. You should see a request for more authentication methods. It can take some time for the policy to take effect.

    :::image type="content" source="media/tutorial-mfa/mfa-required.PNG" alt-text="Screenshot of the 'More information required' message.":::

    > [!NOTE]
    > You can also configure [cross-tenant access settings](cross-tenant-access-overview.md) to trust the MFA from the Microsoft Entra home tenant. This allows external Microsoft Entra users to use the MFA registered in their own tenant rather than register in the resource tenant.

1. Sign out.

## Clean up resources

When no longer needed, remove the test user and the test Conditional Access policy.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select the test user, and then select **Delete user**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. In the **Policy Name** list, select the context menu (…) for your test policy, then select **Delete**, and confirm by selecting **Yes**.

## Next steps

In this tutorial, you created a Conditional Access policy that requires guest users to use MFA when signing in to one of your cloud apps. To learn more about adding guest users for collaboration, go to [Add Microsoft Entra B2B collaboration users in the Microsoft Entra admin center](add-users-administrator.yml).
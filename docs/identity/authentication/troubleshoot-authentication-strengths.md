---
title: Troubleshoot Conditional Access Authentication Strengths
description: Learn how to resolve errors when you're using Microsoft Entra Conditional Access authentication strengths.
ms.topic: troubleshooting
ms.date: 03/04/2025
author: inbarckms
ms.reviewer: inbarc
ms.custom: sfi-image-nochange
---
# Troubleshoot Conditional Access authentication strengths

This article describes how to resolve problems that might happen when you use Microsoft Entra Conditional Access authentication strengths.

## A user is asked to sign in with another method, but an expected method doesn't appear

For sign-in, the authentication method needs to be:

- Registered for the user.
- Enabled by the policy for authentication methods.

For more information, see [How Conditional Access authentication strengths work](concept-authentication-strength-how-it-works.md).

To verify that you can use a method:

1. Check which authentication strength is required. Select **Security** > **Authentication methods** > **Authentication strengths**.

1. Check the policy for authentication methods to see if the user is enabled for any method that the authentication strength requires. Select **Security** > **Authentication methods** > **Policies**.

1. As needed, check if the tenant is enabled for any method that the authentication strength requires. Select **Security** > **Multifactor Authentication** > **Additional cloud-based multifactor authentication settings**.

1. Check which authentication methods are registered for the user in the policy for authentication methods. Select **Users and groups** > *username* > **Authentication methods**.

If the user is registered for an enabled method that meets the authentication strength, the user might need to use another method that isn't available after primary authentication, such as Windows Hello for Business. For more information, see [Authentication methods in Microsoft Entra ID](concept-authentication-methods.md). The user needs to restart the session, select **Sign-in options**, and then select a method that the authentication strength requires.

:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/choose-another-method.png" alt-text="Screenshot of the dialog for choosing another sign-in method.":::

## A user can't access a resource

If an authentication strength requires a method that a user can't use, the user is blocked from signing in. To check which method an authentication strength requires, and which method the user is registered and enabled to use, follow the steps in the [previous section](#a-user-is-asked-to-sign-in-with-another-method-but-an-expected-method-doesnt-appear).

## You need to check which authentication strength was enforced during sign-in

Use the **Sign-ins** log to find more information about the sign-in:

- On the **Authentication Details** tab, the **Requirement** column shows the name of the authentication strength policy.

  :::image type="content" source="./media/troubleshoot-authentication-strengths/sign-in-logs-authentication-details.png" alt-text="Screenshot that shows authentication strengths in a sign-in log.":::

- On the **Conditional Access** tab, you can see which Conditional Access policy was applied. Select the name of the policy, and look for **Grant Controls** to see the authentication strength that was enforced.

  :::image type="content" source="./media/troubleshoot-authentication-strengths/sign-in-logs-control.png" alt-text="Screenshot that shows an authentication strength under Conditional Access policy details in a sign-in log.":::

## A user can't register a new method during sign-in

Some methods can't be registered during sign-in, or they need more setup beyond the combined registration. For more information, see [Register passwordless authentication methods](concept-authentication-strength-how-it-works.md#registration-of-passwordless-authentication-methods).

:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/register.png" alt-text="Screenshot of a sign-in error when a user can't register a method.":::

## Related content

- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md)
- [How authentication strengths work for external users](concept-authentication-strength-external-users.md)

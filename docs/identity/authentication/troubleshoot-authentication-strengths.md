---
title: Troubleshoot Conditional Access authentication strength 
description: Learn how to resolve errors when using Microsoft Entra Conditional Access authentication strength.


ms.service: entra-id
ms.subservice: authentication
ms.topic: troubleshooting
ms.date: 01/12/2024

ms.author: justinha
author: inbarckms
manager: amycolannino
ms.reviewer: inbarc
---
# Troubleshoot Conditional Access authentication strength

This topic covers errors you might see when you use Microsoft Entra Conditional Access authentication strength and how to resolve them.  

## A user is asked to sign in with another method, but they don't see a method they expect

<!---What could be a good example?--->

For sign in, the authentication method needs to be:

- Registered for the user 
- Enabled by the Authentication methods policy 

For more information, see [How Conditional Access authentication strength works](concept-authentication-strength-how-it-works.md).

To verify if a method can be used:

1. Check which authentication strength is required. Click **Security** > **Authentication methods** > **Authentication strengths**. 
1. Check if the user is enabled for a required method:
   1. Check the Authentication methods policy to see if the user is enabled for any method required by the authentication strength. Click **Security** > **Authentication methods** > **Policies**.
   1. As needed, check if the tenant is enabled for any method required for the authentication strength. Click **Security** > **Multifactor Authentication** > **Additional cloud-based multifactor authentication settings**. 
1. Check which authentication methods are registered for the user in the Authentication methods policy. Click **Users and groups** > *username* > **Authentication methods**. 

If the user is registered for an enabled method that meets the authentication strength, they might need to use another method that isn't available after primary authentication, such as Windows Hello for Business. For more information, see [How each authentication method works](concept-authentication-methods.md#how-each-authentication-method-works). The user needs to restart the session, choose **Sign-in options** , and select a method required by the authentication strength.

:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/choose-another-method.png" alt-text="Screenshot of how to choose another sign-in method.":::

## A user can't access a resource

If an authentication strength requires a method that a user can’t use, the user is blocked from sign-in. To check which method is required by an authentication strength, and which method the user is registered and enabled to use, follow the steps in the [previous section](#a-user-is-asked-to-sign-in-with-another-method-but-they-dont-see-a-method-they-expect). 

## How to check which authentication strength was enforced during sign-in
Use the **Sign-ins** log to find more information about the sign-in: 

- Under the **Authentication details** tab, the **Requirement** column shows the name of the authentication strength policy.

  :::image type="content" source="./media/troubleshoot-authentication-strengths/sign-in-logs-authentication-details.png" alt-text="Screenshot showing the authentication strength in the sign-in log.":::

- Under the **Conditional Access** tab, you can see which Conditional Access policy was applied. Click the name of the policy, and look for **Grant controls** to see the authentication strength that was enforced. 

  :::image type="content" source="./media/troubleshoot-authentication-strengths/sign-in-logs-control.png" alt-text="Screenshot showing the authentication strength under Conditional Access Policy details in the sign-in log.":::


## A user can't register a new method during sign-in 

Some methods can't be registered during sign-in, or they need more setup beyond the combined registration. For more information, see [Register passwordless authentication methods](concept-authentication-strength-how-it-works.md#register-passwordless-authentication-methods).
 
:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/register.png" alt-text="Screenshot of a sign-in error when they are unable to register the method."::: 

## Next steps

- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)

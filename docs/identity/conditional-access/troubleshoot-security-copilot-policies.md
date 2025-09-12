---
title: Troubleshoot Conditional Access policies for Microsoft Security Copilot
description: Security Copilot Conditional Access - Learn to create, assign, and troubleshoot policies using custom security attributes for better protection.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: troubleshooting
ms.date: 06/04/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: lhuangnorth
---
# Troubleshoot Conditional Access policies for Microsoft Security Copilot

[Generative artificial intelligence (AI)](/ai/playbook/technology-guidance/generative-ai/) services like [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) can bring value to your organization when used appropriately.

Apply Conditional Access policy to these generative AI services by following [our recommendation to target all resources](concept-conditional-access-cloud-apps.md#all-resources). These policies might include those for [all users](policy-all-users-mfa-strength.md), risky [users](policy-risk-based-user.md), [sign-ins](policy-risk-based-sign-in.md), [device compliance](policy-all-users-device-compliance.md), and users with [insider risk](policy-risk-based-insider-block.md).

Some organizations target these services directly by using the underlying service principals and custom security attributes in their Conditional Access policies:

- 43d7b169-1d9e-4d32-8cd8-06c5974ed90c - Security Copilot Agent Management
- bb5ffd56-39eb-458c-a53a-775ba21277da - Security Copilot Portal
- bb3d68c2-d09e-4455-94a0-e323996dbaa3 - Security Copilot API
- b0cf1501-8e0f-4fbb-b70a-52ca5ea7bda6 - Security Copilot Logic Apps Connector

In these cases, admins create, assign, and target these underlying service principals with custom security attributes.

## Required roles

Custom security attributes are security sensitive and only delegated users can manage them. Assign one or more of the following roles to the user who manages or reports on these attributes.

| Role name | Description |
| --- | --- |
| [Attribute Assignment Administrator](../role-based-access-control/permissions-reference.md#attribute-assignment-administrator) | Assign custom security attribute keys and values to supported Microsoft Entra objects. |
| [Attribute Assignment Reader](../role-based-access-control/permissions-reference.md#attribute-assignment-reader) | Read custom security attribute keys and values for supported Microsoft Entra objects. |
| [Attribute Definition Administrator](../role-based-access-control/permissions-reference.md#attribute-definition-administrator) | Define and manage the definition of custom security attributes. |
| [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader) | Read the definition of custom security attributes. |

Assign the appropriate role to the users who manage or report on these attributes at the directory scope. For detailed steps, see [Assign Microsoft Entra roles](../role-based-access-control/manage-roles-portal.md#assign-roles-with-tenant-scope).

[!INCLUDE [security-attributes-roles](../../includes/security-attributes-roles.md)]

## Create custom security attributes

Follow the instructions in the article [Add or deactivate custom security attributes in Microsoft Entra ID](~/fundamentals/custom-security-attributes-add.md) to add the following **Attribute set** and **New attributes**.

- Create an **Attribute set** named *SecurityCopilotAttributeSet*.
- Create **New attributes** named *SecurityCopilotAttribute* with **Allow multiple values to be assigned** set to **No** and **Only allow predefined values to be assigned** set to **Yes**. Add the following predefined value:
   - MFARequired

> [!NOTE]
> Conditional Access filters for applications only work with custom security attributes of type "string". Custom security attributes support creating the Boolean data type, but Conditional Access Policy only supports "string".

## Assign custom security attributes to applications

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Assignment Administrator](../role-based-access-control/permissions-reference.md#attribute-assignment-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select the apps to apply a custom security attribute to:
   1. 43d7b169-1d9e-4d32-8cd8-06c5974ed90c - Security Copilot Agent Management
   1. bb5ffd56-39eb-458c-a53a-775ba21277da - Security Copilot Portal
   1. bb3d68c2-d09e-4455-94a0-e323996dbaa3 - Security Copilot API
   1. b0cf1501-8e0f-4fbb-b70a-52ca5ea7bda6 - Security Copilot Logic Apps Connector
1. Under **Manage** > **Custom security attributes**, select **Add assignment**.
1. Under **Attribute set**, select the attribute set you created.
1. Under **Attribute name**, select the attribute you created.
1. Under **Assigned values**, select **Add values**, choose the value you created from the list, then select **Done**.
1. Select **Save**.

## Targeting custom security attributes in Conditional Access policy

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) and [Attribute Definition Reader](../role-based-access-control/permissions-reference.md#attribute-definition-reader).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **New policy** or select an existing policy to update.
1. When configuring your **Target resources**, select the following options:
   1. Select what this policy applies to **Cloud apps**.
   1. Include **Select resources**.
   1. Select **Edit filter**.
   1. Set **Configure** to **Yes**.
   1. Select the **Attribute** you created.
   1. Set **Operator** to **Contains**.
   1. Set **Value** to one of your custom attributes.
   1. Select **Done**.

## Which policy is causing issues?

It's sometimes hard for an admin to check which policy to update when there's an issue. Use the guidance in [Troubleshooting sign-in problems with Conditional Access](troubleshoot-conditional-access.md#microsoft-entra-sign-in-events) to check which policies apply, which policies don't apply, and run sign-in diagnostics to avoid ongoing issues.

## Next steps

[Understand authentication in Microsoft Security Copilot](/copilot/security/authentication)

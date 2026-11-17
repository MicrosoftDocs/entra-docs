---
title: Configure Global Secure Access Policy in Microsoft Edge (Preview)
description: Configure the Global Secure Access policy in Microsoft Edge secure enterprise browser settings and assign it to employee work profiles on Windows and macOS.
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
#customer intent: As an Edge administrator, I want to configure and assign the Global Secure Access policy in Microsoft Edge secure enterprise browser settings so that employees can use secure enterprise browser in their work profiles.
---

# Configure Global Secure Access policy in Microsoft Edge secure enterprise browser settings (preview)

Configure a Microsoft Edge policy in Edge Management Experience (EMX) to enable secure enterprise browser for your employees. Create and assign a cloud policy to enable secure network access for Edge on Windows and macOS. Before you begin, configure Global Secure Access for browser access and confirm your Edge Administrator role assignment. For the full requirements, see [Prerequisites](#prerequisites).

The Edge policy enables the browser integration. Global Secure Access traffic forwarding profiles determine the traffic forwarding rules that apply to each user.

## Prerequisites

- Global Secure Access traffic forwarding and browser enablement configured for your deployment. Complete the [Global Secure Access configuration steps](how-to-configure-global-secure-access-browser-settings.md#configure-traffic-forwarding-in-global-secure-access) before configuring Edge.
- An account with an active [Edge Administrator](../identity/role-based-access-control/permissions-reference.md#edge-administrator) role, the least-privileged role for this task.
- Microsoft Edge for Windows or macOS, version **157.0.4341.46** or newer.
- Employee work accounts in your Global Secure Access tenant. Business-to-business (B2B) guest accounts aren't supported.

> [!IMPORTANT]
> On Windows, the Global Secure Access client can run while Edge is configured for Global Secure Access. On macOS, this coexistence isn't supported and results in certificate prompts. Keep the client disabled while using the Edge integration on macOS.

## Create and assign the Edge policy

Create a cloud policy and choose the employees who receive it. You configure the secure network access setting after creating the policy.

1. In the Microsoft 365 admin center, open the [Microsoft Edge policy creation page](https://admin.cloud.microsoft/#/Edge/PolicyConfiguration/id/CreateConfiguration). Sign in with your Edge Administrator account.
1. On **Basics**, enter a **Name** for the policy, such as *Global Secure Access Settings*, and a **Description**.
1. Under **Platforms**, select **Windows 10+**, **macOS 11+**, or both for your deployment. Set **Policy type** to **Cloud**.

    :::image type="content" source="media/how-to-configure-edge-policy-global-secure-access/create-policy.png" alt-text="Screenshot of the policy Basics page with a name, description, Windows and macOS platforms, and Cloud policy type." lightbox="media/how-to-configure-edge-policy-global-secure-access/create-policy.png":::

1. Skip to **Assignments**. Select **Add all users** to apply the policy to all users in your tenant. Alternatively, use **Select group** to target a specific security group.

    :::image type="content" source="media/how-to-configure-edge-policy-global-secure-access/assign-policy.png" alt-text="Screenshot of the Assignments page showing the All users assignment and the controls for selecting a group or adding all users." lightbox="media/how-to-configure-edge-policy-global-secure-access/assign-policy.png":::

1. On **Finish**, review the policy name, platforms, and assignments. Select **Review and create**.

    :::image type="content" source="media/how-to-configure-edge-policy-global-secure-access/review-policy.png" alt-text="Screenshot of the Finish page showing the cloud policy configuration, user assignment, and Review and create button." lightbox="media/how-to-configure-edge-policy-global-secure-access/review-policy.png":::

## Enable secure network access

Open the policy you created to configure its security settings.

1. On **Configuration policies**, select your new policy.

    :::image type="content" source="media/how-to-configure-edge-policy-global-secure-access/select-policy.png" alt-text="Screenshot of the Configuration policies list with the newly created Global Secure Access Settings cloud policy." lightbox="media/how-to-configure-edge-policy-global-secure-access/select-policy.png":::

1. Select **Customization Settings** > **Security settings**.
1. Under **Secure Network Access**, set **Enable secure network access (preview)** to **Enabled**.

    :::image type="content" source="media/how-to-configure-edge-policy-global-secure-access/enable-secure-network-access.png" alt-text="Screenshot of Security settings with Enable secure network access set to Enabled and Save changes available." lightbox="media/how-to-configure-edge-policy-global-secure-access/enable-secure-network-access.png":::

1. If your organization relies on universal tenant restrictions, you can also configure **Enable browser-based tenant restrictions**. Microsoft Entra traffic doesn't pass through the Global Secure Access network channel in Edge. Global Secure Access universal tenant restrictions aren't enforced for that traffic. The browser-based setting is separate from the Global Secure Access integration.
1. Select **Save changes**.

The configuration policy applies when assigned employees sign in to Edge with a work account from your organization.

## Validate the policy

Test with an employee account included in both the Edge policy assignment and the applicable Global Secure Access traffic forwarding profiles.

1. Open Edge on a supported Windows or macOS device and sign in to a work profile with the employee's account.
1. Open `edge://policy` and check the effective policy value and any reported errors.
1. Complete [Validate browser access](how-to-configure-global-secure-access-browser-settings.md#validate-browser-access) to test destinations and confirm the corresponding Global Secure Access transactions.

## Related content

- [Configure Global Secure Access secure enterprise browser settings](how-to-configure-global-secure-access-browser-settings.md)
- [Secure enterprise browser overview](concept-secure-enterprise-browser.md)
- [Troubleshoot secure enterprise browser](troubleshoot-secure-enterprise-browser.md)

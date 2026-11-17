---
title: Configure Global Secure Access Browser Settings (Preview)
description: Configure Global Secure Access secure enterprise browser settings and traffic forwarding for native Microsoft Edge integration on Windows and macOS.
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
ms.author: alexpav
# Customer intent: As an IT administrator, I want to configure Global Secure Access secure enterprise browser settings so that employees can use protected browsing and private web applications on Windows and macOS.
---

# Configure Global Secure Access secure enterprise browser settings (preview)

Configure secure enterprise browser with Microsoft Edge and Global Secure Access to give employees browser-only access to private web applications and protect browsing activity of users signed in to Microsoft Edge for Business using your organization's work account.

Enable the traffic types for secure enterprise browser using the Entra admin center, and then use the Microsoft 365 Admin center to configure an Edge Management Service (EMS) policy. This preview supports Windows and macOS.

## Prerequisites

- A tenant onboarded to Global Secure Access. See [Access Global Secure Access in the admin center](quickstart-access-admin-center.md).
- The **Global Secure Access Administrator** role to configure Global Secure Access.
- The **Application Administrator** role to assign users to traffic forwarding profiles and to configure Private Access enterprise applications and connector groups.
- Licenses for the Global Secure Access capabilities you plan to use. See [Global Secure Access licensing](overview-what-is-global-secure-access.md#licensing-overview).
- The [Edge Administrator](../identity/role-based-access-control/permissions-reference.md#edge-administrator) role, the least-privileged role to configure and assign the Edge policy in the M365 admin center.
- Configuration allowing for [M365 targeted releases](/microsoft-365/admin/manage/release-options-in-office-365) in your tenant. Alternatively, you can access the M365 admin center using the secure enterprise browser settings preview URL https://admin.cloud.microsoft/?flagOverrides=EnableEdgeGSA:true#/Edge/PolicyConfiguration/id/SecurityProtections .
- Microsoft Edge for Windows or macOS, version **157.0.4341.46** or newer.
- Work accounts in your tenant for the employees who use the feature. Business-to-business (B2B) guest accounts aren't supported because users can't sign in to Edge with those accounts.
- For Private Access, private web applications configured by fully qualified domain name (FQDN) and the associated private network connectors. See [Configure per-app access](how-to-configure-per-app-access.md).

> [!IMPORTANT]
> EMS is the only supported method to enable this integration in Edge for the preview. Intune app policies aren't supported for this configuration.

On Windows, the Global Secure Access client can run while Microsoft Edge is configured for Global Secure Access.

> [!IMPORTANT]
> On macOS, running the Global Secure Access client while Edge is configured for Global Secure Access isn't supported and results in certificate prompts. Keep the client disabled while using the Edge integration on macOS.

## Configure traffic forwarding in Global Secure Access

Global Secure Access calculates the user's traffic forwarding policy from traffic forwarding profiles, just as it does for the Global Secure Access client. Configure these profiles for your intended users before testing Edge.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a **Global Secure Access Administrator**.
1. Go to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Configure the profiles for the traffic types you want to forward:

    - For internet and Microsoft 365 browsing, configure the [Internet traffic profile](how-to-manage-internet-access-profile.md) and the [Microsoft traffic profile](how-to-manage-microsoft-profile.md).
    - For private web applications, configure a [Private Access traffic forwarding profile](how-to-manage-private-access-profile.md) and the applications employees need.

1. [Assign the profiles to the intended users](how-to-manage-users-groups-assignment.md). Confirm that the users who receive the Edge policy are included in the applicable Global Secure Access profile assignments.

The Edge policy enables the browser integration. It doesn't define a separate set of traffic forwarding rules.

## Enable browser access in the Global Secure Access portal

Choose which traffic types Edge can forward to Global Secure Access. Internet Access and Microsoft 365 share a browser enablement control; Private Access is enabled separately.

1. In the Microsoft Entra admin center, go to **Global Secure Access** > **Connect** > **Explicit forward proxy**.
1. Turn on **Global Secure Access with Microsoft Edge**.
1. Under **Settings**, select the traffic types required for your deployment:

    - **Internet Access with Microsoft Edge**. Select this option for both internet and Microsoft 365 traffic. There isn't a separate Microsoft 365 browser enablement option.
    - **Private Access with Microsoft Edge**. Select this option for private web applications.

    :::image type="content" source="media/howto-secure-enterprise-browser/enable-browser-access.png" alt-text="Screenshot of Global Secure Access with Microsoft Edge enabled, with Internet Access and Private Access selected." lightbox="media/howto-secure-enterprise-browser/enable-browser-access.png":::

1. Configure the Edge policy in the M365 admin center.

Enabling Internet Access for Edge also enables Microsoft 365 support in the browser configuration. Continue to manage the forwarding rules and user assignments for each traffic profile in Global Secure Access.

## Configure the Edge policy

Use the M365 admin center to enable the Edge integration for the users who need browser-based access. Global Secure Access portal enablement and the EMS policy are both required.

Follow [Configure Global Secure Access policy in Microsoft Edge secure enterprise browser settings](how-to-configure-global-secure-access-edge-policy.md) to create and assign the cloud policy, set **Enable secure network access (preview)** to **Enabled**, and save your changes.

Global Secure Access delivers Transport Layer Security (TLS) inspection certificate trust automatically to Edge. No separate manual certificate deployment to Edge is required for this integration. For Internet Access, configure the certificate and [TLS inspection policies](how-to-transport-layer-security.md) in Global Secure Access. Automatic trust delivery to Edge doesn't replace that service configuration or establish device-wide certificate trust.

## Validate browser access

Test from an employee account included in both the Edge policy assignment and the applicable Global Secure Access traffic forwarding profiles.

1. On a Windows or macOS device, open the supported version of Edge and sign in to a work profile with the employee's account.
1. Open `edge://policy` and confirm that the policy configured in EMS appears with the intended value.
1. Browse to destinations covered by your enabled profiles:

    - An internet destination covered by your Internet Access policy.
    - A Microsoft 365 destination covered by your Microsoft traffic profile, if enabled.
    - A private web application using its FQDN, if Private Access is enabled.

1. In the Microsoft Entra admin center, go to **Global Secure Access** > **Monitor** > **Traffic logs**.
1. Select **Transactions** and filter **Device Category** to **Secure enterprise browser**.
1. Review the corresponding transactions. Compare the traffic type, destination, and access decision with your configured policies.

The Microsoft Entra traffic profile isn't supported in this preview. Don't use compliant network checks or tenant restrictions v2 policies for Microsoft Entra ID to validate this integration. Private DNS is also unsupported.

If access fails or traffic doesn't match your policy, use [Troubleshoot secure enterprise browser](troubleshoot-secure-enterprise-browser.md) to check assignments, effective Edge policies, and traffic logs.

## Related content

- [Secure enterprise browser overview](concept-secure-enterprise-browser.md)
- [Assign users to traffic forwarding profiles](how-to-manage-users-groups-assignment.md)
- [Use Global Secure Access traffic logs](how-to-view-traffic-logs.md)

---
title: Enable compliant network check with Conditional Access
description: Learn how to require known compliant network locations in order to connect to your secured resources with Conditional Access.

ms.service: network-access
ms.subservice: 
ms.topic: how-to
ms.date: 12/14/2023

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: mamkumar
---
# Enable compliant network check with Conditional Access

Organizations who use Conditional Access along with the Global Secure Access preview, can prevent malicious access to Microsoft apps, third-party SaaS apps, and private line-of-business (LoB) apps using multiple conditions to provide defense-in-depth. These conditions may include device compliance, location, and more to provide protection against user identity or token theft. Global Secure Access introduces the concept of a compliant network within Conditional Access and continuous access evaluation. This compliant network check ensures users connect from a verified network connectivity model for their specific tenant and are compliant with security policies enforced by administrators.

The Global Secure Access Client installed on devices or users behind configured remote networks allows administrators to secure resources behind a compliant network with advanced Conditional Access controls. This compliant network feature makes it easier for administrators to manage and maintain, without having to maintain a list of all of an organization's locations IP addresses. Administrators don't need to hairpin traffic through their organization's VPN egress points to ensure security.

Continuous Access Evaluation (CAE) with the compliant network feature is currently supported for SharePoint Online. With CAE, you can enforce defense-in-depth with token theft replay protection.

This compliant network check is specific to each tenant.

- Using this check you can ensure that other organizations using Microsoft's Global Secure Access services can't access your resources.
  - For example: Contoso can protect their services like Exchange Online and SharePoint Online behind their compliant network check to ensure only Contoso users can access these resources.
  - If another organization like Fabrikam was using a compliant network check, they wouldn't pass Contoso's compliant network check.

The compliant network is different than [IPv4, IPv6, or geographic locations](../identity/conditional-access/location-condition.md) you may configure in Microsoft Entra ID. No administrator upkeep is required.

## Prerequisites

* Administrators who interact with **Global Secure Access preview** features must have one or more of the following role assignments depending on the tasks they're performing.
   * The **Global Secure Access Administrator** role to manage the Global Secure Access preview features
   * [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) or [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) to create and interact with Conditional Access policies and named locations.
* The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
* To use the Microsoft 365 traffic forwarding profile, a Microsoft 365 E3 license is recommended.

### Known limitations

- Organizations can protect other Microsoft Entra integrated apps with Conditional Access policies requiring a compliant network check. During the preview, administrators must choose the individual applications from the app picker instead of choosing *All cloud apps*. **Do not choose *All cloud apps*.**
- Compliant network check is currently not supported for private access apps.

## Enable Global Secure Access signaling for Conditional Access

To enable the required setting to allow the compliant network check, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access (Preview)** > **Global settings** > **Session management** **Adaptive access**.
1. Select the toggle to **Enable Global Secure Access signaling in Conditional Access**.
1. Browse to **Protection** > **Conditional Access** > **Named locations**.
   1. Confirm you have a location called **All Compliant Network locations** with location type **Network Access**. Organizations can optionally mark this location as trusted.

:::image type="content" source="media/how-to-compliant-network/toggle-enable-signaling-in-conditional-access.png" alt-text="Screenshot showing the toggle to enable signaling in Conditional Access.":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on compliant network check, and you disable Global Secure Access signaling in Conditional Access, you may unintentionally block targeted end-users from being able to access the resources. If you must disable this feature, first delete any corresponding Conditional Access policies.

## Protect your resources behind the compliant network

The compliant network Conditional Access policy can be used to protect your Microsoft 365 and third-party resources.

The following example shows this type of policy. In addition, you can enforce token theft replay protection using CAE for SharePoint Online.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's [emergency access or break-glass accounts](#user-exclusions).
1. Under **Target resources** > **Include**, and select **Select apps**.
   1. Choose **Office 365 Exchange Online**, and/or **Office 365 SharePoint Online**, and/or any of your third-party SaaS apps.
   1. The specific *Office 365* cloud app in the app picker is currently NOT supported, so do not select this cloud app.
1. Under **Conditions** > **Location**.
   1. Set **Configure** to **Yes**
   1. Under **Include**, select **Any location**.
   1. Under **Exclude**, select **Selected locations**
      1. Select the **All Compliant Network locations** location.
   1. Select **Select**.
1. Under **Access controls**:
   1. **Grant**, select **Block Access**, and select **Select**.

  > [!NOTE]
  > Token theft replay protection is now available for SharePoint Online.

9. If your policy is only targeting SharePoint Online, for **Session**, select **Customize continuous access evaluation** and **Strictly enforce location policies (Preview)** and select **Select**.

   :::image type="content" source="media/how-to-compliant-network/ca-policy-cae-settings.png" alt-text="Screenshot of the session control with the continuous access evaluation option highlighted.":::

10. Confirm your settings and set **Enable policy** to **On**.
11. Select the **Create** button to create to enable your policy.

### User exclusions

[!INCLUDE [conditional-access-recommended-exclusions](includes/conditional-access-recommended-exclusions.md)]

## Try your compliant network policy

1. On an end-user device with the [NaaS client installed and running](how-to-install-windows-client.md)
1. Browse to [https://outlook.office.com/mail/](https://outlook.office.com/mail/) or `https://yourcompanyname.sharepoint.com/`, you have access to resources.
1. Pause the NaaS client by right-clicking the application in the Windows tray and selecting **Pause**.
1. Browse to [https://outlook.office.com/mail/](https://outlook.office.com/mail/) or `https://yourcompanyname.sharepoint.com/`, you're blocked from accessing resources with an error message that says **You cannot access this right now**.

:::image type="content" source="media/how-to-compliant-network/you-cannot-access-this-right-now-error.png" alt-text="Screenshot showing error message in browser window You can't access this right now.":::

## Troubleshooting

Verify the new named location was automatically created using [Microsoft Graph](https://developer.microsoft.com/graph/graph-explorer).

`GET https://graph.microsoft.com/beta/identity/conditionalAccess/namedLocations`

:::image type="content" source="media/how-to-compliant-network/graph-explorer-expected-result-location-creation.png" alt-text="Screenshot showing Graph Explorer results of query":::

[!INCLUDE [Public preview important note](./includes/public-preview-important-note.md)]

## Next steps

[The Global Secure Access Client for Windows (preview)](how-to-install-windows-client.md)

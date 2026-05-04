---
title: Configure a Conditional Access Policy for Explicit Forward Proxy
description: Learn how to configure a Conditional Access policy for Explicit Forward Proxy.
ms.topic: how-to
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# Configure a Microsoft Entra Conditional Access policy for Explicit Forward Proxy (preview)

Explicit Forward Proxy for Microsoft Entra Internet Access relies on IP affinity, among other mechanisms, for session management. Although a Conditional Access policy isn't required, we recommend that you configure one that restricts the use of Explicit Forward Proxy on networks that your organization trusts. Additionally, you use Conditional Access policies to assign the Microsoft Entra Internet Access security profiles to users.

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in preview. This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- Administrators who configure and manage the Conditional Access policy for Explicit Forward Proxy must have at least the Conditional Access Administrator role.
- Enable Explicit Forward Proxy in the **Global Secure Access** > **Session Management** section of the Microsoft Entra admin center. Enabling Explicit Forward Proxy creates the workload identity in your tenant. This workload identity is the target for the Conditional Access policy.
- Configure a security profile in **Global Secure Access** > **Secure** > **Security Profiles**.
- Define a named location that represents known company networks in Microsoft Entra Conditional Access.

> [!NOTE]
> As you configure groups in the following sections, keep in mind that Explicit Forward Proxy (preview) is not currently included in the **All internet resources with Global Secure Access** group.

## Scope Explicit Forward Proxy to known networks

1. Go to the Microsoft Entra admin center. Under **Entra ID**, select  **Conditional Access**. Then, select **+Create new policy**.

1. Give the policy a name that aligns with your organization's policy naming standards. For example, use **GSA – Explicit Forward Proxy Known Locations Policy**.

1. Under **Assignments**, select **Users and Groups**. Typically, you would scope this policy to **All Users** and make exceptions (for example, your break-glass accounts) as necessary on the **Exclude** tab.

1. Under **Target Resources**, choose **Select resources** > **Select specific resources**. Search for the **GSA-ExplicitForwardProxy** workload identity and select it.

1. On the **Network** tab of the new policy, select **Configure** and leave the defaults under **Include** – **Any network or location**. Under **Exclude**, select a named location that represents known networks from which you allow the use of Explicit Forward Proxy.

1. On the **Grant** tab, select **Block**.

1. Set the **Enable policy control** toggle to **On**, and then select the **Create** button.

## Assign security profiles to Explicit Forward Proxy

Security profiles are assigned using Microsoft Entra Conditional Access policies. You can assign policies to Explicit Forward Proxy by explicitly targeting the GSA-ExplicitForwardProxy workload identity.

1. Go to the Microsoft Entra admin center. Under **Entra ID**, select  **Conditional Access**. Then, select **+Create new policy**.

1. Give the policy a name that aligns with your organization's policy naming standards. For example, use **GSA – Explicit Forward Proxy Security Profile**.

1. Under **Assignments**, select **Users and Groups**. You can scope the policy to apply to all users, or you can create multiple policies to assign different security profiles to different groups of users. Configure exceptions (for example, your break-glass accounts) as necessary on the **Exclude** tab.

1. Under **Target Resources**, choose **Select resources** > **Select specific resources**. Search for the **GSA-ExplicitForwardProxy** workload identity and select it.

1. On the **Session** tab of the new policy, select **Use Global Secure Access security profile**. You don't have to configure the **Grant** section.

1. Set the **Enable policy control** toggle to **On**, and then select the **Create** button.

## Related content

- [Explicit Forward Proxy session management](concept-explicit-forward-proxy-session-management.md)
- [Configure web filtering policies](how-to-configure-web-content-filtering.md)

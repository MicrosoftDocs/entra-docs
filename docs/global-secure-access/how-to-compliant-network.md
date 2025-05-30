---
title: Enable Compliant Network Check with Conditional Access
description: Learn how to require known compliant network locations in order to connect to your secured resources with Conditional Access.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/21/2025
ms.author: kenwith
author: kenwith
manager: femila
ms.reviewer: smistry
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---
# Enable compliant network check with Conditional Access

Organizations that use Conditional Access along with the Global Secure Access can prevent malicious access to Microsoft apps, third-party SaaS apps, and private line-of-business (LoB) apps using multiple conditions to provide defense-in-depth. These conditions might include strong factor authentication, device compliance, location, and others. Enabling these conditions protects your organization against user identity compromise or token theft. Global Secure Access introduces the concept of a compliant network within Microsoft Entra ID Conditional Access. This compliant network check ensures users connect via the Global Secure Access service for their specific tenant and are compliant with security policies enforced by administrators.

The Global Secure Access Client installed on devices or users behind configured remote networks allows administrators to secure resources behind a compliant network with advanced Conditional Access controls. This compliant network feature makes it easier for administrators to manage access policies, without having to maintain a list of egress IP addresses and removes the requirement to hairpin traffic through organization's VPN in order to maintain source IP anchoring and apply IP-based Conditional Access policies.
To learn more about Conditional Access, see [What is Conditional Access?](../identity/conditional-access/overview.md)

## Compliant network check enforcement
Compliant network enforcement reduces the risk of token theft/replay attacks. Authentication plane enforcement is performed by Microsoft Entra ID at the time of user authentication. If an adversary has stolen a session token and attempts to replay it from a device that is not connected to your organization’s compliant network (for example, requesting an access token with a stolen refresh token), Entra ID will immediately deny the request and further access will be blocked. Data plane enforcement works with services integrated with Global Secure Access and that support Continuous Access Evaluation (CAE) - currently, Microsoft Graph. With apps that support CAE, stolen access tokens that are replayed outside your tenant’s compliant network will be rejected by the application in near-real time. Without CAE, a stolen access token will last up to its full lifetime (default is between 60 and 90 minutes). 

This compliant network check is specific to the tenant in which it is configured. For example, if you define a Conditional Access policy requiring compliant network in contoso.com, only users with the Global Secure Access or with the Remote Network configuration are capable of passing this control. A user from fabrikam.com will not be able to pass contoso.com's compliant network policy.

The compliant network is different than [IPv4, IPv6, or geographic locations](../identity/conditional-access/concept-assignment-network.md) you might configure in Microsoft Entra. Administrators are not required to review and maintain compliant network IP addresses/ranges, strengthening the security posture and minimizing the administrative overhead. 

## Prerequisites

- Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   - The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   - [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to enable Global Secure Access signaling for Conditional Access, as well as to create and interact with Conditional Access policies and named locations.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Enable Global Secure Access signaling for Conditional Access

To enable the required setting to allow the compliant network check, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with an account which has the [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) and [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role activated.
1. Browse to **Global Secure Access** > **Settings** > **Session management** > **Adaptive access**.
1. Select the toggle to **Enable CA Signaling for Entra ID (covering all cloud apps)**. 
1. Browse to **Protection** > **Conditional Access** > **Named locations**.
   1. Confirm you have a location called **All Compliant Network locations** with location type **Network Access**. Organizations can optionally mark this location as trusted.

:::image type="content" source="media/how-to-compliant-network/toggle-enable-signaling-in-conditional-access.png" alt-text="Screenshot showing the toggle to enable signaling in Conditional Access.":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on compliant network check, and you later disable Global Secure Access signaling in Conditional Access, you may unintentionally block targeted end-users from being able to access the resources. If you must disable this feature, first delete any corresponding Conditional Access policies.

## Protect your resources behind the compliant network

The compliant network Conditional Access policy can be used to protect your Microsoft and third-party applications that are integrated with Entra ID single sign-on. A typical policy will have a 'Block' grant for all network locations except Compliant Network. The following example demonstrates the steps to configure this type of policy:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's [emergency access or break-glass accounts](#user-exclusions).
1. Under **Target resources** > **Include**, and select **All resources (formerly 'All cloud apps')**.
   1. If your organization is enrolling devices into Microsoft Intune, it is recommended to exclude the applications **Microsoft Intune Enrollment** and **Microsoft Intune** from your Conditional Access policy to avoid a circular dependency.
1. Under **Network**.
   1. Set **Configure** to **Yes**.
   1. Under **Include**, select **Any location**.
   1. Under **Exclude**, select the **All Compliant Network locations** location.
1. Under **Access controls**:
   1. **Grant**, select **Block Access**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **On**.
1. Select the **Create** button to create to enable your policy.

> [!NOTE]
> Use Global Secure Access along with Conditional Access policies that require a Compliant Network for *All Resources*.
> 
> Global Secure Access resources are automatically excluded from the Conditional Access policy when *Compliant Network* is enabled in the policy. There's no explicit resource exclusion required. These automatic exclusions are required to ensure the Global Secure Access client is not blocked from accessing the resources it needs. The resources Global Secure Access needs are:
> * Global Secure Access Traffic Profiles 
> * Global Secure Access Policy Service (internal service)
>
> Sign-in events for authentication of excluded Global Secure Access resources appear in the Microsoft Entra ID sign-in logs as: 
> * Internet resources with Global Secure Access 
> * Microsoft apps with Global Secure Access 
> * All private resources with Global Secure Access 
> * ZTNA Policy Service 

### User exclusions

[!INCLUDE [entra-policy-exclude-user](../includes/entra-policy-exclude-user.md)]

## Try your compliant network policy

1. On an end-user device with the [Global Secure Access client installed and running](how-to-install-windows-client.md), browse to [https://myapps.microsoft.com](https://myapps.microsoft.com) or any other application that uses Entra ID single sign-on in your tenant.
1. Pause the Global Secure Access client by right-clicking the application in the Windows tray and selecting **Disable**.
1. After disabling the Global Secure Access client, access another application integrated with Entra ID single sign-on. For example, you can try signing in to the Azure portal. Your access should be blocked by Entra ID Conditional Access.

> [!NOTE]
> If you are already signed in to an application, access will not be interrupted. Compliant Network condition is evaluated by Entra ID, and if you are already signed in, you may have an existing session with the application. In this scenario, Compliant Network check will be re-evaluated next time the Entra ID sign-in is required, when your application session has expired.
> 
:::image type="content" source="media/how-to-compliant-network/you-cannot-access-this-right-now-error.png" alt-text="Screenshot showing error message in browser window You can't access this right now.":::

## Next steps

[Universal Tenant Restrictions](how-to-universal-tenant-restrictions.md)

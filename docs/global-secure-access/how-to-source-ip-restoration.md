---
title: Enable Source IP Restoration with Global Secure Access
description: Learn how to enable source IP restoration to ensure the source IP matches in downstream resources.
ms.topic: how-to
ms.date: 03/18/2026
ms.reviewer: alexpav
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---
# Source IP restoration
When you use cloud-based network proxy and SSE solutions, they abstract the original source IP of the user from the service that the user connects to. Instead, the service detects the user's IP address as the egress address of the cloud-based network proxy. While this abstraction helps with privacy-related concerns in consumer scenarios, not having the original source IP information makes it difficult to achieve enterprise security goals. For example, without an actual client egress IP address, you can't apply Microsoft Entra ID Conditional Access policies based on your organization's well-known IP addresses, and audit logs don't reflect accurate location information.

Source IP restoration is part of the Adaptive Access feature of Microsoft Entra Internet Access for Microsoft Services. Source IP restoration detects and securely communicates the original egress IP address of the end user to Microsoft Entra ID and Microsoft Graph, bringing the following benefits to your organization:

- You can continue to enforce IP-based location policies in [Microsoft Entra ID Conditional Access](/azure/active-directory/conditional-access/overview).
- It improves the accuracy of risk detection in [Microsoft Entra ID Protection risk detections](/entra/id-protection/concept-identity-protection-risks).
- It elevates your threat detection and response by recording accurate source IP in [Microsoft Entra sign-in logs](/azure/active-directory/reports-monitoring/concept-all-sign-ins) and in [Microsoft Entra audit logs](/entra/identity/monitoring-health/concept-audit-logs).

> [!NOTE]
> To achieve source IP restoration for non-Microsoft apps, you must also configure Conditional Access policies and ensure traffic flows through a compliant network. For more information, see [Enable compliant network check with Conditional Access](/entra/global-secure-access/how-to-compliant-network#protect-your-resources-behind-the-compliant-network).

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have both of the following role assignments depending on the tasks they're performing:
   * The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   * The [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.
* The product requires Microsoft Entra ID P1 licenses. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
* You must enable the [Microsoft Traffic Profile](concept-microsoft-traffic-profile.md) to use Source IP restoration.

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Enable Global Secure Access signaling for Conditional Access

> [!NOTE]
> Source IP restoration is now enabled by default for new tenants. If you enabled Global Secure Access features in your tenant before June 2025, you might need to explicitly enable Source IP Restoration.

To enable the required setting to allow source IP restoration, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session management** > **Adaptive Access**.
1. Select the toggle to **Enable Conditional Access Signaling for Microsoft Entra ID**.

By using this functionality, Microsoft Entra ID and Microsoft Graph receive the public egress source IP address of the user.

:::image type="content" source="media/how-to-source-ip-restoration/enable-conditional-access-signaling.png" alt-text="Screenshot showing the toggle to enable Conditional Access Signaling for Microsoft Entra ID." lightbox="media/how-to-source-ip-restoration/enable-conditional-access-signaling.png":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on IP location checks, and you disable Global Secure Access signaling in Conditional Access, you might unintentionally block targeted end users from accessing the resources. If you must disable this feature, first delete any corresponding Conditional Access policies. 

## Sign-in log behavior

To see source IP restoration in action, administrators can take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](/azure/active-directory/roles/permissions-reference#security-reader).
1. Browse to **Entra ID** > **Users** > select one of your test users > **Sign-in logs**.
1. When you enable source IP restoration, you see IP addresses that include their actual IP address. 
   - When you disable source IP restoration, you can't see their actual IP address.

Sign-in log data might take some time to appear. This delay is normal as there's some processing that must take place.

:::image type="content" source="media/how-to-source-ip-restoration/user-log-data.png" alt-text="Screenshot of the sign-in logs showing events with source IP restoration on, then off, then on again." lightbox="media/how-to-source-ip-restoration/user-log-data.png":::

## Related content

- [Set up tenant restrictions v2 (preview)](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
- [Strictly enforce location policies using continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md)
- [Microsoft Traffic Profile](concept-microsoft-traffic-profile.md) 

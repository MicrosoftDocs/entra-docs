---
title: Authentication flows as a condition in Conditional Access policy
description: Learn how authentication flows provide a seamless experience across all application and device types
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: conceptual
ms.date: 02/27/2024
ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: anjusingh, ludwignick
---
# Conditional Access: Authentication flows (Preview)

Microsoft Entra ID supports a wide variety of authentication and authorization flows to provide a seamless experience across all application and device types. Some of these authentication flows, are higher risk than others. To provide more control over your security posture, we’re adding the ability to control certain authentication flows to Conditional Access. This control starts with the ability to explicitly target [device code flow](../../identity-platform/v2-oauth2-device-code.md).

## Device code flow

Device code flow is used when signing into devices that might lack local input devices like shared devices or digital signage. Device code flow is a high-risk authentication flow that might be used as part of a phishing attack or to access corporate resources on unmanaged devices. You can configure the device code flow control along with other controls in your Conditional Access policies. For example, if device code flow is used for android based conference room devices, you might choose to block device code flow everywhere except for android devices in a specific network location. 

You should only allow device code flow where necessary. Microsoft recommends blocking device code flow wherever possible.

## Authentication transfer

Authentication transfer is a new flow that offers a seamless way to transfer authenticated state from one device to another. For example, users could be presented with a QR code within the desktop version of Outlook that, when scanned on their mobile device, transfers their authenticated state to the mobile device. This capability provides a simple and intuitive user experience that reduces the overall friction level for users.  

The ability to control authentication transfer is in preview use the **Authentication flows** condition in Conditional Access to manage the feature.

## Protocol tracking 

To ensure Conditional Access policies are accurately enforced on specified authentication flows, we use functionality called protocol tracking. This tracking is applied to the session using device code flow or authentication transfer. In these cases, the sessions are considered protocol tracked. Any protocol tracked sessions are subject to policy enforcement if a policy exists. Protocol tracking state is sustained through subsequent refreshes. Nondevice code flow or authentication transfer flows can be subject to enforcement of authentication flows policies if the session is protocol tracked.  

For example: 

1. You configure a policy to block device code flow everywhere except for SharePoint. 
1. You use device code flow to sign-in to SharePoint, as allowed by the configured policy. At this point, the session is considered protocol tracked 
1. You try to sign in to Exchange within the context of the same session using any authentication flow not just device code flow. 
1. You're blocked by the configured policy due to the protocol tracked state of the session  

## Sign-in logs  

When configuring a policy to restrict or block device code flow, it’s important to understand if and how device code flow is used in your organization. Creating a Conditional Access policy in report-only mode or filtering the sign-in logs for device code flow events with the **authentication protocol** filter can help.

To aid in troubleshooting protocol tracking related errors, we’ve added a new property called **original transfer method** to the **activity details** section of the Conditional Access **sign-in logs**. This property displays the protocol tracking state of the request in question. For example, for a session in which device code flow was performed previously the **original transfer method** is set to **Device code flow**.

## Enforcement of Authentication Flows policies on Device Registration Service resource
Starting early September, 2024, Microsoft will begin enforcing authentication flows policies on Device Registration Service. This will apply only to policies which target **all resources** in the resource picker. If your organization currently uses Device Code Flow for device registration purposes, and you have an authentication flows policy targeting **all resources**, you will need to exempt the Device Registration Resource from the scope of your conditional access policy to avoid impact. You can find the Device Registration Service resource in the [Target Resources](concept-conditional-access-cloud-apps.md) option present within the Conditional Access policy configuration experience. To exempt Device Registration Service via Conditional Access UX, you will need to go to **Target Resources** -> **Exclude** -> **Select excluded cloud apps** -> **Device Registration Service**. For API, you will need to update your policy by excluding the Client ID for Device Registration Service: 01cb2876-7ebd-4aa4-9cc9-d28bd4d359a9. 

If you are unsure whether your organization uses Device Code Flow against Device Registration Service, you can utilize the Microsoft Entra [Sign-in logs](../monitoring-health/concept-sign-ins.md) to determine this. There, you can filter for the Device Registration Service client ID in the **Resource ID** filter, and narrow it down to Device Code Flow usage by utilizing the **Device code** option within the **Authentication Protocol** filter.

## Troubleshooting unexpected blocks 

If you have a sign-in unexpectedly blocked by a Conditional Access policy, you should confirm whether the policy was an authentication flows policy. You can do this confirmation by going to **sign-in logs**, clicking on the blocked sign-in, and then navigating to the **Conditional Access** tab in the **Activity details: sign-ins** pane. If the policy enforced was an authentication flows policy, select the policy to determine which authentication flow was matched.

If device code flow was matched but device code flow wasn't the flow performed for that sign-in, that means the refresh token was protocol tracked. You can verify this case by clicking on the blocked sign-in and searching for the **Original transfer method** property in the **Basic info** portion of the **Activity details: sign-ins** pane.

> [!NOTE]
> Blocks due to protocol tracked sessions are expected behavior for this policy. There is no recommended remediation.  

## Related content

- [Block authentication flows with Conditional Access policy](policy-block-authentication-flows.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)

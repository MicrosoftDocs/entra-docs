---
title: [Follow SEO guidance at 
https://review.learn.microsoft.com/en-us/help/platform/seo-meta-title]
description: "[Article description]."
ms.service: global-secure-access
ms.topic: how-to
ms.date: 10/17/2025
ms.author: jayrusso
author: HULKsmashGithub
manager: dougeby
ms.reviewer: sumeetmittal
ms.custom: sfi-image-nochange

#customer intent: As a <role>, I want <what> so that <why>.

---

# "[verb] * [noun]"

Global Secure Access supports network content filtering. This feature enables customers to safeguard against unintended data exposure, preventing inline data leaks to generative AI applications and internet destinations. By extending data protection capabilities to the network layer through Global Secure Access, network content filtering enables organizations to enforce data policies on network traffic in real time. Organizations can discover and protect files shared with unsanctioned destinations, such as gen AI and unmanaged cloud apps, from managed endpoints through browsers, applications, add-ins, APIs, and more.

The network content filtering solution brings together Microsoft Purview's data classification service and the identity-centric network security policies in Global Secure Access. This combination creates an advanced network-layer data security solution, Data Loss Prevention (DLP), that is identity-centric and policy-driven. By combining deep content inspection with real-time user risk evaluation, customers can enforce granular controls over sensitive data movement across the network without compromising user productivity or security posture.

> [!IMPORTANT]
> The network content filtering feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.      

This article explains how to create a file policy to filter internet traffic flowing through Global Secure Access.

## Prerequisites

To use the File Policy feature, you need the following:
- A valid Microsoft Entra tenant.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
    - A valid Microsoft Entra Internet Access license.
    - A valid Microsoft Purview license, required for advanced content inspection. (You can use basic content inspection without a Purview license.)
- A user with the [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID to configure Global Secure Access settings.
- A [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) role to configure Conditional Access policies.
- The Global Secure Access client requires a device (or virtual machine) that is either Microsoft Entra ID joined or Entra ID Hybrid joined.

## Initial configuration

To configure file policies, complete the following initial setup steps:
1. [Enable the Internet Access traffic forwarding profile](how-to-manage-internet-access-profile.md#enable-the-internet-access-traffic-forwarding-profile) and ensure correct user assignments.  
1. [Configure the Transport Layer Security (TLS) inspection](how-to-transport-layer-security.md) policy.  
1. Install and configure the Global Secure Access client:
    1. Install the Global Secure Access client on Windows or macOS.
        > [!IMPORTANT]
        > Before continuing, test and ensure your client's internet traffic is being routed through Global Secure Access. See the steps below to verify client configuration.
    1. Select the **Global Secure Access** icon and select the Troubleshooting tab.
    1. Under **Advanced Diagnostics**, select **Run tool**.
    1. In the Global Secure Access Advanced Diagnostics window, select the **Forwarding Profile** tab. 
    1. Verify that **Internet Access** rules are present in the **Rules** section. This configuration might take up to 15 minutes to apply to clients after enabling the Internet Access traffic profile in the Microsoft Entra Portal.
        :::image type="content" source="media/how-to-network-content-filtering/internet-access-rules.png" alt-text="Screenshot of the Global Secure Access client Advanced Diagnostics window, open to the Forwarding Profile tab, with the Internet Access rules highlighted." lightbox="media/how-to-network-content-filtering/internet-access-rules.png":::
1. Confirm access to web applications you plan for file policies.

## Configure a file policy

[Introduce the procedure.]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **File policies**.
1. Select **+Create Policy**. Pick the appropriate options.
1. On the Basic tab: 
    1. Enter the Policy Name 
    1. Enter the Policy Description
1. On the Rules tab:  
    1. Add Rule 
    1. Configure the appropriate fields.
    1. If you've configured data policies in Microsoft Purview, select **Scan with Purview**.
    1. Select the appropriate **Matching conditions**.
    1. Add the destination.
1. 


## sections to add as needed



## Related content

* [Related article title](link.md)
* [Related article title](link.md)



<!-- image syntax

:::image type="content" source="media/how-to-network-content-filtering/[].png" alt-text="Screenshot of []." lightbox="media/how-to-network-content-filtering/[].png":::

-->
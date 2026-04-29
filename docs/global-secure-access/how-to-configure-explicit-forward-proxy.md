---
title: Learn how to configure Explicit Forward Proxy
description: Learn how to configure Explicit Forward Proxy
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# How to Configure Explicit Forward Proxy (preview)

Explicit Forward Proxy (EFP) allows you to use Secure Web and AI Gateway capabilities of Microsoft Entra Internet Access without installing the Global Secure Access (GSA) client. EFP works with any browser that supports proxy automatic configuration (PAC).

> [!IMPORTANT]
> The Explicit Forward Proxy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- Ensure that you have the following Microsoft Entra admin roles:
    - The Global Secure Access Administrator role to manage the GSA features
    - The Conditional Access Administrator role to create and manage Microsoft Entra Conditional Access policies.
- Complete the Get started with Global Secure Access guide
- Review the EFP concepts and EFP Session Management concepts.
- Enable the Internet Access traffic forwarding profile
- Configure Transport Layer Security (TLS) Inspection

## Enable EFP

You can enable and manage EFP using the Microsoft Entra admin portal.
1. Sign in to https://entra.microsoft.com
1. Navigate to Global Secure Access > Session management and navigate to the Explicit Forward Proxy tab.
1. Toggle the Internet Access setting to On. By default, Smart Session Management is enabled when you enable EFP.
1. Optionally, enable HTTP Header Session Management. For more information, see [Configure HTTP Header Session management](how-to-configure-explicit-forward-proxy-headers.md).

   :::image type="content" border="true" source="./media/how-to-configure-explicit-forward-proxy/enable-explicit-forward-proxy.png" alt-text="Screenshot of the Configure EFP screen." lightbox="./media/how-to-configure-explicit-forward-proxy/enable-explicit-forward-proxy.png":::

> [!IMPORTANT]
> EFP session management relies on IP affinity as one of the session management anchors. We recommend that you configure a Conditional Access policy that restricts the use of EFP to networks you trust. For more information, please see EFP Session Management and Configure Conditional Access Policy for EFP.

## Next steps

[Configure Conditional Access Policy for Explicit Forward Proxy](how-to-configure-conditional-access-policy-for-explicit-forward-proxy.md)
[Configure HTTP Header Session management](how-to-configure-explicit-forward-proxy-headers.md)
[Configure EFP in Microsoft Edge using Intune Mobile Application Management (MAM)](how-to-configure-explicit-forward-proxy-intune-policy.md)

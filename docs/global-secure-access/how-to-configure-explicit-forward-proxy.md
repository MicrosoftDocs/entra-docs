---
title: Learn How to Configure Explicit Forward Proxy
description: Learn How to Configure Explicit Forward Proxy
ms.topic: concept-article
ms.date: 04/06/2026
ms.author: alexpav
author: idmdev
ms.reviewer: 
---

# How to Configure Explicit Forward Proxy

## Overview

Explicit Forward Proxy (EFP) allows you to use Secure Web and AI Gateway capabilities of Entra Internet Access without installing the Global Secure Access client. EFP works with any browser that supports proxy automatic configuration (PAC).

## Prerequisites

- Administrators who interact with Global Secure Access features must have one or more of the following role assignments depending on the tasks they are performing:
    - The Global Secure Access Administrator role to manage the GSA features
    - The Conditional Access Administrator role to create and manage Entra ID Conditional Access policies.
- Complete the Get started with Global Secure Access guide
- Review the EFP concepts and EFP Session Management concepts.
- Enable the Internet Access traffic forwarding profile
- Configure TLS Inspection

## Enable EFP

You can enable and manage EFP using the Microsoft Entra portal.
1. Sign in to https://entra.microsoft.com
1. Navigate to Global Secure Access > Session management and click the Explicit Forward Proxy tab.
1. Toggle the Internet Access setting to On. By default, Smart Session Management is enabled when you enable EFP.
1. Optionally, enable HTTP Header Session Management. If you do, additional configuration on your egress proxy/firewall is required. For more information, see Configure HTTP Header Session Management.

   :::image type="content" border="true" source="./media/how-to-configure-explicit-forward-proxy/enable-efp.png" alt-text="Screenshot of the Configure EFP screen." lightbox="./media/how-to-configure-explicit-forward-proxy/enable-efp.png":::

> [!IMPORTANT]
> EFP session management may rely on IP affinity as the session management anchor. We recommend that you configure a Conditional Access policy that restricts the use of EFP to networks you trust. For more information, please see EFP Session Management and Configure Conditional Access Policy for EFP.

## Next Steps

[Configure Conditional Access Policy for Explicit Forward Proxy](how-to-configure-conditional-access-policy-for-explicit-forward-proxy.md)
[Configure HTTP Header Session management](how-to-configure-efp-header-session-management.md)
[Configure EFP in Microsoft Edge using Intune Mobile Application Management (MAM)](how-to-configure-efp-with-edge-and-intune.md)

---
title: "Tutorial: Enable Internet Access traffic forwarding"
description: Learn how to enable the Internet Access traffic forwarding profile in Microsoft Entra and verify the configuration.
ms.topic: tutorial
ms.date: 03/07/2026
ms.subservice: entra-internet-access
ms.reviewer: jebley
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Tutorial: Enable Internet Access traffic forwarding

The Internet Access traffic forwarding profile routes internet traffic through the Global Secure Access client. Enabling this traffic forwarding profile allows workers to connect to the internet in a controlled and secure way. Internet Access allows organizations to discover and monitor all internet sites accessed by your users. As an administrator, you can control access to these internet sites through various policies like web content filtering policies, file scan policies, and more.

In this tutorial, you learn how to:
> [!div class="checklist"]
> - Enable the Internet Access traffic forwarding profile
> - Assign users and groups to the profile
> - Install the GSA client on a Windows machine
> - Verify the traffic forwarding profile is configured

## Key concepts

> [!TIP]
>
> **Traffic forwarding profiles** are the mechanism that tells the GSA client which traffic to capture and route through Microsoft's Security Service Edge (SSE). There are three profiles:
>
> | Profile | Traffic type | Purpose |
> |---------|--------------|----------|
> | **Microsoft Traffic** | Microsoft 365 services | Optimized routing for M365, tenant restrictions |
> | **Private Access** | Internal corporate resources | Zero Trust replacement for VPN |
> | **Internet Access** | All other internet traffic | Web filtering, threat protection, TLS inspection |
>
> When you enable the Internet Access profile, the GSA client intercepts outbound internet requests and tunnels them to Microsoft's SSE proxy before they reach their destination.

## Step 1: Enable the Internet Access traffic forwarding profile

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a **Global Secure Access Administrator**.
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Enable the **Internet access profile** by selecting the checkbox. 

> [!NOTE]
>
> When you enable the Internet Access forwarding profile, you should also enable the **Microsoft traffic forwarding profile** for optimal routing of Microsoft traffic. You can tunnel Microsoft traffic by selecting the **Microsoft traffic profile** toggle on the same page. Microsoft traffic is never routed through the Internet Access tunnel, so you can also leave the **Microsoft traffic** box unchecked if desired.

## Step 2: Assign users and groups

The Internet Access profile needs to be assigned to users before it takes effect. You can assign it to all users or scope it to specific users and groups for a phased rollout or POC testing.

1. On the **Traffic forwarding** page, locate the **Internet access profile** section.
1. Under **User and group assignments**, select **View**.
1. Under **Assigned**, select **0 users, 0 groups assigned**.
1. Select **Add user/group**.
1. Search for and select the users or groups you want to include.
1. Select **Assign**.

> [!NOTE]
>
> Internet traffic is now forwarded from client devices to Microsoft’s Security Service Edge (SSE) proxy for users who have the Global Secure Access (GSA) client installed and are assigned to the traffic forwarding profile.

![Screenshot showing the Internet Access traffic forwarding profile assignment page.](media/tutorial-internet-access-enable-traffic-forwarding/internet-access-traffic-forwarding-profile.png)

> [!NOTE]
>
> With the Internet Access traffic profile enabled and assigned to users, the GSA client begins intercepting web traffic bound for the internet. Instead of sending traffic directly to its destination, the GSA client forwards the traffic to the Global Secure Access service where security profiles are enforced. Only if the traffic is allowed does the GSA service then forward the traffic to its intended destination.

## Step 3: Install the GSA client

1. Download the GSA client for Windows 11 from one of these links OR using the [sample PowerShell script](scripts/powershell-windows-client-install-proof-of-concept.md).
   - For standard Windows 11 machines, use `https://aka.ms/GlobalSecureAccess-Windows`.
   - For ARM-based Windows 11 machines, use `https://aka.ms/GlobalSecureAccess-WindowsOnArm`.
1. Select the downloaded file and complete the wizard to install the GSA client.
1. Once installation is complete, verify the GSA client icon appears in the Windows system tray.

![Screenshot showing the GSA client icon in the Windows system tray.](media/tutorial-internet-access-enable-traffic-forwarding/global-secure-access-tray-icon.png)

## Step 4: Verify results

1. Right-click the GSA icon from the Windows system tray and select **Advanced Diagnostics**.
1. Select **Forwarding profile**.
1. Verify the **Internet access rules** are present.

   ![Screenshot showing the traffic profile verification in the GSA client.](media/tutorial-internet-access-enable-traffic-forwarding/internet-access-client-verify.png)

1. Optionally, review the **Health check** tab results.

> [!TIP]
>
> The GSA client automatically checks for updates to traffic forwarding profile changes every 5 minutes. You can see the date and time of the last check next to the **Forwarding profile last checked** field in the **Forwarding profile** tab. If you don't see the desired results, wait 5 minutes and then select **Refresh**.

> [!NOTE]
>
> If you expand the ruleset for Internet Access, you can see a long list of rules, most of which are `bypass` rules. These are primarily Microsoft traffic destinations. These bypass rules ensure that Microsoft traffic isn't tunneled via the Internet Access tunnel. Instead, this traffic must be tunneled via the **Microsoft traffic profile**, which is specially optimized for Microsoft traffic. At the end of the Internet rules, you'll see `0.0.0.0-255.255.255.255` targeting TCP 80 and 443, which is the catch-all rule to tunnel the rest of the internet-bound traffic that isn't explicitly bypassed.

## What you learned

In this exercise, you accomplished the following:

- **Enabled the Internet Access traffic forwarding profile** - This activated the GSA client's ability to tunnel internet-bound traffic to Microsoft's SSE.
- **Understood traffic flow** - Internet traffic now flows from user device, to GSA client, to Microsoft SSE proxy, to internet destination.
- **Scoped the deployment** - By assigning specific users and groups, you learned how to implement a phased rollout strategy.

With the traffic forwarding profile enabled, you now have a foundation to apply security policies (web filtering, TLS inspection, threat intelligence) to internet traffic. Without this step, traffic bypasses the GSA service and no policies can be enforced.

## Next steps

> [!div class="nextstepaction"]
> [Configure web content filtering](tutorial-internet-access-web-content-filtering.md)

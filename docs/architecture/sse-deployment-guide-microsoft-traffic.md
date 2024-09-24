---
title: Microsoft's Security Service Edge solution deployment guide for Microsoft Entra Internet Access for Microsoft traffic proof of concept
description: Deploy and verify Microsoft Entra Internet Access for Microsoft Traffic
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 11/15/2023
ms.author: jricketts
---
# Microsoft's Security Service Edge solution deployment guide for Microsoft Entra Internet Access for Microsoft Traffic proof of concept

This Proof of Concept (PoC) Deployment Guide helps you to deploy Microsoft's Security Service Edge (SSE) solution that features [Microsoft Entra Internet Access for Microsoft Traffic](../global-secure-access/how-to-manage-microsoft-profile.md).

## Overview

[Microsoft's identity-centric Security Service Edge solution](../global-secure-access/overview-what-is-global-secure-access.md) converges network, identity, and endpoint access controls so that you can secure access to any app or resource, from any location, device, or identity. It enables and orchestrates access policy management for employees, business partners, and digital workloads. You can continuously monitor and adjust user access in real time if permissions or risk level changes to your private apps, SaaS apps, and Microsoft endpoints. This section describes how to complete Microsoft Entra Internet Access for Microsoft traffic proof of concept in your production or test environment.

### Microsoft Entra Internet Access for Microsoft Traffic deployment

Complete the [Configure initial product](sse-deployment-guide-intro.md) steps. This includes configuration of Microsoft Entra Internet Access for Microsoft Traffic, enabling the Microsoft traffic forwarding profile, and installing the Global Secure Access client. You should scope your configuration to specific test users and groups.

### Sample PoC scenario: protect against data exfiltration

Data exfiltration is a concern for all companies, especially those that operate in highly regulated industries such as government or finance. With outbound controls in [cross-tenant access settings](~/external-id/cross-tenant-access-overview.md), you can block unauthorized identities from foreign tenants from accessing your Microsoft data when using your managed devices.

Microsoft Entra Internet Access for Microsoft Traffic can enhance your Data Loss Prevention (DLP) controls by enabling you to:

- protect against token theft by requiring users can only access Microsoft resources if coming through a compliant network.
- enforce Conditional Access policies on connections to Microsoft's Security Service Edge.
- deploy universal tenant restrictions v2, eliminating the need to route all user traffic through customer-managed network proxies.
- configure tenant restrictions that prevent users from accessing unauthorized external tenants with any third-party identity (for example, personal or issued by an external organization).
- protect against token infiltration/exfiltration to ensure users can't bypass your tenant restrictions by moving access tokens to and from unmanaged devices or network locations.

This section describes how to enforce compliant network access to Microsoft traffic, protect the connection to the Microsoft's Security Service Edge with Conditional Access, and prevent external identities from accessing external tenants on your managed devices and/or networks by using universal tenant restrictions v2. Tenant restrictions only apply to external identities; they don't apply to identities within your own tenant. To control outbound access for your own users' identities, use [cross-tenant access settings](~/external-id/cross-tenant-access-settings-b2b-collaboration.yml). Configuring the tenant restrictions policy in Microsoft Entra ID to block access applies to users who get the tenant restrictions header injection. This only includes users who route through customer network proxies that inject the headers, users with deployed Global Secure Access Client, or users on Windows devices with enabled tenant restrictions header injection via the Windows OS setting. When testing, ensure tenant restrictions are enforced by the Global Secure Access service and not via customer network proxies or Windows settings to avoid unintentionally impacting other users. Additionally, you need to enable Conditional Access signaling to enable Global Secure Access options in Conditional Access. 

1. [Enable Global Secure Access signaling for Conditional Access](../global-secure-access/how-to-compliant-network.md#enable-global-secure-access-signaling-for-conditional-access).
1. [Enable universal tenant restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md). 
1. [Configure the tenant restrictions policy in the Microsoft Entra admin center to block access for all external identities and all applications](../external-id/tenant-restrictions-v2.md#step-1-configure-default-tenant-restrictions-v2).
1. Create a Conditional Access policy that requires a compliant network for access. Configuring the compliant network requirement blocks all access to Office 365 Exchange Online and Office 365 SharePoint Online for your test users, from any location, unless they connect using Microsoft's Security Service Edge Solution. Configure your Conditional Access policy as follows:
   1. **Users**: Select your test user or a pilot group.
   1. **Target resources**: Select the applications **Office 365 Exchange Online** and **Office 365 SharePoint Online**.
   1. **Conditions**:
     1. For **Locations**, select **Not configured**.
     1. Toggle **Configure** to **Yes**.
     1. Include **Any location**.
     1. Exclude **Selected locations**.
     1. For **Select**, select **None**.
     1. Select **All Compliant Network locations**.
1. **Access controls** > **Grant** > Select **Block access**.
1. Create a second Conditional Access policy that requires controls to allow the Global Secure Access Client to connect to the SSE solution (such as MFA, compliant device, TOU). Configure your Conditional Access policy as follows:
   1. **Users**: Select your test user or a pilot group.
   1. **Target resources**:
     1. For **Select what this policy applies to**, select **Global Secure Access**.
     1. For **Select the traffic profiles this policy applies to**, select **Microsoft traffic**.

        :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/conditional-access-policy-options.png" alt-text="Screenshot of Conditional Access policy options.":::
        
1. **Access controls** > **Grant** > Select the controls that you want to enforce such as requiring multifactor authentication.
1. Attempt to sign-in to SharePoint Online or Exchange Online and verify that you are prompted to authenticate to Global Secure Access. The Global Secure Access Client uses access tokens and refresh tokens to connect to Microsoft's Security Service Edge Solution. If you have previously connected the Global Secure Access Client, then you may need to wait for the access token to expire (up to one hour) before the Conditional Access policy that you created is applied.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/global-secure-access-credentials-prompt.png" alt-text="Screenshot of the Global Secure Access credentials prompt window.":::

1. To verify that your Conditional Access policy was successfully applied, view the sign-in logs for your test user for the **ZTNA Network Access Client - M365** application.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-user-sign-ins-interactive-inline.png" alt-text="Screenshot of list of sign-in logs window showing User sign-ins interactive tab." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-user-sign-ins-interactive-expanded.png":::

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-conditional-access-inline.png" alt-text="Screenshot of sign-in logs window showing Conditional Access tab." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-conditional-access-expanded.png":::

1. Validate that the Global Secure Access Client is connected by opening the tray in the bottom right corner and verifying that there's a green check on the icon.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/global-secure-access-client-connected.png" alt-text="Screenshot of the Global Secure Access Client icon showing successful Connected status.":::

1. Use your test user to sign in to SharePoint Online or Exchange Online by using your test device.
   1. Confirm that the user can successfully access the resource.
   1. In the sign-in logs, confirm that the Conditional Access policy that blocks access outside compliant networks indicates **Not Applied**.

      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-success-inline.png" alt-text="Screenshot of a line in the sign-in logs window showing success indicator." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-success-expanded.png":::

      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/logs-conditional-access-not-applied-inline.png" alt-text="Screenshot of sign-in logs-window showing that Conditional Access policy is Not Applied.":::

1. From a different device without the Global Secure Access Client, use your test user identity to attempt to sign in to SharePoint Online or Exchange Online. Alternatively, you can right-click the Global Secure Access Client in your system tray and click **Pause**, and then use your test user identity to attempt to sign in to SharePoint Online or Exchange Online on the same device.
   1. Confirm that access is blocked.
   1. In the sign-in logs, confirm the Conditional Access policy that blocks access outside compliant networks was applied.
   
      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-failure-inline.png" alt-text="Screenshot of a line in the sign-in logs window showing failure indicator." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-failure-expanded.png":::

      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/logs-conditional-access-failure-inline.png" alt-text="Screenshot of sign-in logs window showing Conditional Access tab highlighting a line where Result column is Failure." lightbox="media/sse-deployment-guide-microsoft-traffic/logs-conditional-access-failure-expanded.png":::

1. From your test device with the Global Secure Access Client enabled, attempt to sign in to a different Microsoft Entra tenant with an external identity. Confirm that tenant restrictions block access.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/log-in-access-is-blocked.png" alt-text="Screenshot of log-in window after submitting credentials showing Access is blocked message.":::

1. Go to the external tenant and navigate to its sign-in logs. In the sign-in logs of the external tenant, confirm that access to the foreign tenant shows as blocked and logged.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-blocked-logged-inline.png" alt-text="Screenshot of sign-in logs window line where Result column is Failure." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-blocked-logged-expanded.png":::

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-log-basic-info-tab-inline.png" alt-text="Screenshot of sign-in logs showing Basic info tab for an item that indicates a Failure reason of tenant restrictions policy not allowing access." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-log-basic-info-tab-expanded.png":::

### Sample PoC scenario: source IP address restoration

Network proxies and third-party SSE solutions overwrite the sending device's public IP address, which prevents Microsoft Entra ID from being able to use that IP address for policies or reports. This restriction causes the following issues:

- Microsoft Entra ID can't enforce certain location-based Conditional Access policies (such as blocking untrusted countries).
- Risk-based detections that leverage a user's baseline familiar locations degrade because the system limits Microsoft Entra ID Protection machine learning algorithms to your proxy's IP address. They can't detect or train on the user's true source IP address.
- SOC operations/investigations must leverage third-party/proxy logs to determine the original source IP and then correlate it with subsequent activity logs, resulting in inefficiencies.

This section demonstrates how Microsoft Entra Internet Access for Microsoft Traffic overcomes these issues by preserving the user's original source IP address, simplifying security investigations and troubleshooting.

To test source IP address restoration, Global Secure Access signaling for Conditional Access must be enabled. You need a Conditional Access policy that requires a compliant network as described earlier in this article.

1. Validate that the Global Secure Access Client is connected by opening the tray in the bottom right corner and verifying that there's a green check on the icon. Using your test identity, sign in to either SharePoint Online or Exchange Online.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/global-secure-access-client-connected.png" alt-text="Screenshot of the Global Secure Access Client icon showing Connected status indicator.":::

1. View the sign-in log for this sign-in and make note of the IP address and location. Confirm that the compliant network Conditional Access policy wasn't applied.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-location-tab-inline.png" alt-text="Screenshot of sign-in logs showing Location tab for an item." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-location-tab-expanded.png":::

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/logs-conditional-access-not-applied-inline.png" alt-text="Screenshot of sign-in logs-window showing Conditional Access tab highlighting a line where Result column is Not Applied." lightbox="media/sse-deployment-guide-microsoft-traffic/logs-conditional-access-not-applied-expanded.png":::

1. Set the compliant network Conditional Access policy to report-only mode and select **Save**.
1. On your test client device, open the system tray, right-click the Global Secure Access Client icon, and select **Pause**. Hover over the icon and verify that the Global Secure Access Client no longer connects by confirming **Global Secure Access Client -- Disabled**.

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/global-secure-access-client-options-pause.png" alt-text="Screenshot of the Global Secure Access Client options menu showing the Pause option highlighted.":::

   :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/global-secure-access-client-disabled.png" alt-text="Screenshot of the Global Secure Access Client icon showing as disabled.":::

1. Using your test user, sign in to either SharePoint Online or Exchange Online. Confirm that you are able to successfully sign in and access the resource.
1. View the sign-in log for the last sign-in attempt.
   1. Confirm that the IP address and location match those previously noted.
   1. Confirm that the report-only Conditional Access policy would have failed as the traffic didn't route through Microsoft Entra Internet Access for Microsoft Traffic.

      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-location-tab-inline.png" alt-text="Screenshot of sign-in logs showing Location tab for an item." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-location-tab-expanded.png":::

      :::image type="content" source="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-report-only-failure-inline.png" alt-text="Screenshot of sign-in logs showing Report-only tab for an item with Report-only: Failure in the Result column." lightbox="media/sse-deployment-guide-microsoft-traffic/sign-in-logs-report-only-failure-expanded.png":::

## Next Steps
[Deploy and verify Microsoft Entra Private Access](sse-deployment-guide-private-access.md)
[Deploy and verify Microsoft Entra Internet Access](sse-deployment-guide-internet-access.md)

---
title: Source IP anchoring with Global Secure Access
description: Configure Microsoft Entra Private Access to tunnel specific application traffic through a private network for application's network-based access control policy.
author: jricketts
manager: martinco
ms.author: jricketts
ms.reviewer: jebley
ms.service: global-secure-access
ms.subservice: entra-internet-access 
ms.topic: conceptual
ms.date: 10/29/2024
---

# Source IP anchoring with Global Secure Access

Organizations with Software-as-a-Service (SaaS) or Line-of-Business (LOB) applications might enforce specific network locations before allowing access. One approach is to use Microsoft Entra Private Access to route specific web application traffic with a privately controlled network. This approach allows you to enforce specific egress IPs that only your organization uses. This article describes how to configure Microsoft Entra Private Access to tunnel specific application traffic through a private network to satisfy an application's network-based access control policy.

## Configure source IP anchoring to route traffic from a dedicated IP address

To enable application enforcement of a dedicated network, configure an enterprise application with Microsoft Entra Private Access. An example where this configuration might be necessary is when the application that allows access with local credentials isn't tied to your identity provider.

This solution acquires application traffic and routes it from the client device. It routes through Microsoft's Secure Service Edge then to a private network with a private network connector. From the private network, the traffic can access the application with internet or any other available private connection. The application sees the traffic as originating from the allowed egress IP address indicating that access is coming from the dedicated network that satisfies its own network access controls.

The following architectural diagram illustrates an example configuration.

:::image type="content" source="media/source-ip-anchoring/architectural-diagram-example-inline.png" alt-text="Example configuration architectural diagram." lightbox="media/source-ip-anchoring/architectural-diagram-example-expanded.png":::

In the example configuration, the application only allows connections that originate from 15.4.23.54, which is the egress IP address of customer's on-premises network. When a user attempts to access the application, the Global Secure Access client acquires and tunnels the traffic through Microsoft's Secure Service Edge where authorization control enforcement (such as Conditional Access) can occur. The traffic tunnels to the on-premises network using the Private Network Connector. Finally, the traffic uses the internet to connect to the web application. The application sees the connection originating from 15.4.23.54 and allows access.

> [!NOTE]
> Configuring source IP anchoring is necessary when a SaaS app enforces its own network-based controls. If your requirement is limited to location enforcement from the identity provider, [compliant network check](how-to-compliant-network.md) is sufficient. Compliant network check enforces network-based access controls at the authentication layer and avoids the need to hairpin traffic through your private network. Global Secure Access binds traffic to your tenant ID to ensure that other organizations using Global Secure Access can't satisfy your Conditional Access policies.

## Prerequisites

Before you get started with configuring source IP anchoring, make sure your environment is ready and compliant.

- You have a SaaS application that enforces its own network-based access control policy.
- Your license includes Microsoft Entra Suite or both Microsoft Entra Internet Access and Microsoft Entra Private Access.
- You enabled the Microsoft Entra Private Access forwarding profile.
- You have the latest version of the [Global Secure Access client](concept-clients.md).

## Deploy private network connectors

When you meet the prerequisites, perform the following steps to deploy private network connectors:

1. [Install a private network connector](how-to-configure-connectors.md) in a private network that has outbound connectivity to the destination web application. A good option is to host the connector in an Azure Virtual Network where you control the outbound egress IP. We recommend that you install two or more connectors for resiliency and high availability.
1. Provide the public IP address of the connectors to the SaaS app so that your users can connect to the app.

Placement and use of a forward proxy between the private network connector and the destination web application isn't supported.

## Configure source IP anchoring

After you install and configure the private network connectors, perform the following steps to create an enterprise application:

1. Navigate to `entra.microsoft.com`.
1. Select **Global Secure Access** > **Applications > Enterprise applications.**
1. Select **New application**.
1. Enter a name for the application.
1. Select the **Connector Group** that acquires and routes the traffic.
1. Select **Add application segment**.
1. Complete the following fields:
   1. **Destination type** -- Select **Fully qualified domain name**.
   1. **Fully qualified domain name** -- Enter the fully qualified domain name of the web application.
   1. **Ports** -- If the application uses HTTP, enter **80**. If the application uses HTTPS, enter **443**. You might also enter both ports.
   1. **Protocol** -- Select **TCP**.

      :::image type="content" source="media/source-ip-anchoring/create-application-segment.png" alt-text="Screenshot of Create application segment dialog.":::

1. Select **Apply**.
1. Select **Save**.
1. Navigate back to **Enterprise applications**. Select the application that you created.
1. Select **Users and groups**.
1. Select **Add user/group**.
1. Select **Users and groups** > **None Selected**.
1. Search for and select the users and groups that you want to assign to this application. Select **Select**.
1. Select **Assign**.

## Validate the configuration

After you configure an enterprise application for the web application, perform the following steps to validate that it's working properly.

1. In the Windows Global Secure Access client, open **Advanced Diagnostics**.
1. Select **Forwarding profile**.
1. Expand **Private access rules**. Validate that the web application's fully qualified domain name (FQDN) is in the list.

   :::image type="content" source="media/source-ip-anchoring/advanced-diagnostics-rules.png" alt-text=" Screenshot of Global Secure Access - Advanced diagnostics - Rules.":::

1. Select **Traffic**.
1. Select **Start collecting**.
1. In a browser, navigate to the web application.
1. Return to **Advanced Diagnostics**.
1. Select **Stop collecting.** 
1. Validate these settings:
   1. The web application appears under **Destination FQDN**.
   1. The **Channel** field is **Private Access**.
   1. The **Action** field is **Tunnel**.

      :::image type="content" source="media/source-ip-anchoring/advanced-diagnostics-network-traffic-inline.png" alt-text="Screenshot of Global Secure Access - Advanced diagnostics - Network traffic." lightbox="media/source-ip-anchoring/advanced-diagnostics-network-traffic-expanded.png":::

1. Check the application's logs (not in Microsoft Entra ID). Validate that the application sees the sign-in from an IP address that matches an egress IP of your private network.

## Troubleshooting

Ensure that you disabled QUIC, IPv6, and encrypted DNS. You can find details in our [troubleshooting guide for the Global Secure Access client](troubleshoot-global-secure-access-client-diagnostics-health-check.md).

## Next steps

- The [Global Secure Access dashboard](concept-traffic-dashboard.md) provides you with visualizations of the network traffic acquired by the Microsoft Entra Private and Microsoft Entra Internet Access services.

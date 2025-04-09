---
title: How DNS Name Resolution Works in Microsoft Entra Private and Internet Access  
description: Understand DNS name resolution in Microsoft Entra Private Access and Internet Access, including private DNS configurations, troubleshooting tips, and limitations.  
author: Justinha  
ms.topic: conceptual  
ms.date: 04/08/2025  
ms.author: justinha  
ms.reviewer: justinha  

# DNS handling in Microsoft Entra Private Access

This article describes the DNS name resolution in Microsoft Entra Private Access for various scenarios and configurations, including IA, PA, and private DNS within PA.

In Microsoft Entra private access there are two ways how internal network destinations/applications can be published:

- IP address or IP address range along with UDP/TCP port  
- FQDN + UDP/TCP port  

In the first scenario, when using an IP address, the global secure access (GSA) client will only acquire network traffic if a process on the device is trying to connect to the published IP address and the corresponding port. On the other hand, when publishing the internal application via FQDN, the client will capture the traffic even when the device OS is not capable of resolving the internal IP address of the FQDN.

The GSA client will intercept the DNS name resolution and provide a synthetic IP address from the range 6.6.0.0/16 to the device OS. This will ensure the correct routing of traffic to the GSA client. The flow is shown below.

:::image type="content" source="media/concept-name-resolution/image1.png" alt-text="Screenshot of a diagram showing DNS name resolution flow in Microsoft Entra Private Access.":::

Because of this behavior, the GSA client can capture traffic when using FQDN publishing in Microsoft Entra Private Access, even when private DNS functionality in Microsoft Entra Private Access is not enabled.

> [!NOTE]  
> Traditional troubleshooting tools like nslookup, trace route, and ping will return the synthetic IP address instead of the internal IP address. This might cause confusion during troubleshooting. Currently, Microsoft Entra Private Access does not support capturing ICMP traffic, which will block the use of tools like ping and trace route.  

## DNS handling in Microsoft Entra Internet Access

When the Microsoft Entra Internet Access or Microsoft traffic profile is enabled in global secure access, the GSA client will start to intercept all DNS traffic in the same way as described for Microsoft Entra Private Access in the previous section. This is required as all web traffic needs to be acquired in the Microsoft Entra Internet Access scenario.

You can check the resolved hostnames in the advanced diagnostic of the GSA client which will map the synthetic IP address and the original IP address.

:::image type="content" source="media/concept-name-resolution/image2.png" alt-text="Screenshot of a web page showing AI-generated content that may be incorrect.":::

## Private DNS in Microsoft Entra Private Access

To provide full private DNS name resolution, administrators can configure the private DNS functionality in Microsoft Entra Private Access. This feature will allow name resolution for the entire DNS Domain suffix instead of relying on individual FQDN publishing. While you can use FQDN publishing without the use of private DNS, it is recommended to use the private DNS functionality to provide DNS resolution for scenarios like DNS SRV records and SSO to on-premises ADDS Kerberos applications.

Administrators can use the quick access configuration to configure all internal domain suffixes which should be in scope for private DNS name resolution.

:::image type="content" source="media/concept-name-resolution/image3.png" alt-text="Screenshot of a computer showing private DNS configuration in Microsoft Entra Private Access.":::

The global secure access client will automatically receive the updated forwarding profile which includes the private DNS configuration.

:::image type="content" source="media/concept-name-resolution/image4.png" alt-text="Screenshot of a computer showing the global secure access client receiving the updated forwarding profile.":::

On Windows, the GSA client will create NRPT rules in the OS for each domain to send DNS traffic to the GSA client. [The NRPT | Microsoft Learn](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn593632(v=ws.11)).

Admins can use PowerShell to view the client's NRPT Policy.

:::image type="content" source="media/concept-name-resolution/image5.png" alt-text="Screenshot of a PowerShell window showing the NRPT policy for the client.":::

On MacOS, the GSA client will create similar DNS rules in the OS for each domain to send DNS traffic to the GSA client.

The client will also be able to handle hostname resolution for hostnames, aka. single label names without the domain suffix. The configuration will automatically exclude DNS name resolution for WPAD for each domain to avoid automatic proxy configuration via Microsoft Entra Private Access – private DNS.

## Name resolution flow in Private DNS

On Windows and MacOS clients, once the private DNS functionality is enabled, the OS will send DNS requests for the configured domain suffixes to the GSA client which will forward the requests to the private network connector group assigned to the Quick Access configuration. The private network connector will use its configured DNS server to resolve the internal IP address and provide it to the GSA client. Similarly to the FQDN name resolution earlier in this article, the GSA client will assign a synthetic IP address and return it back to the application.

:::image type="content" source="media/concept-name-resolution/image6.png" alt-text="Screenshot of a diagram showing the name resolution flow in Private DNS.":::

Traditional troubleshooting tools like nslookup and ping will return the synthetic IP address. If you want to troubleshoot the DNS name resolution, you can use the hostname acquisition tab in the GSA client advanced diagnostic to see synthetic IP address and the original resolved internal IP address.

:::image type="content" source="media/concept-name-resolution/image7.png" alt-text="Screenshot of the GSA client advanced diagnostic showing synthetic and resolved IP addresses.":::

## Single Label Names / hostname resolution

The private DNS functionality in Microsoft Entra Private Access also provides name resolution for hostnames without a domain suffix. The GSA client automatically adds an NRPT rule in the format of \<appID\>.globalsecureaccess.local.

:::image type="content" source="media/concept-name-resolution/image8.png" alt-text="Screenshot of a computer. AI-generated content may be incorrect.":::

When hostnames are resolved, the client will add the globalsecureaccess domain suffix and send the request to the Microsoft Entra Private Access cloud backend. The cloud backend will strip away the domain suffix and send the request to the Private Network Connector – PNC. The connector Windows server will then use the locally configured domain suffix list to query the hostname against the DNS server.

:::image type="content" source="media/concept-name-resolution/image9.png" alt-text="Diagram of a network. AI-generated content may be incorrect.":::

## Known limitations

- Today you can only use private DNS configuration as part of the quick access configuration. This means that all private DNS requests will be sent to the same connector group, and you cannot have multiple private DNS configurations for different domains.

- No support for DNSsec or DNS over HTTPS (DOH) at this point in time.

- The private DNS configuration does not support exceptions within a DNS domain at this point in time.

## Troubleshooting

*Refer to the new guide Arpad is publishing…*

## FAQ


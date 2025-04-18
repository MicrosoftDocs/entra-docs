---  
title: Configure Microsoft Entra Private DNS for Secure Internal Name Resolution  
description: Step-by-step guide to configure Microsoft Entra Private DNS with Quick Access for secure and efficient internal DNS query resolution in enterprise environments.  
author: Justinha  
contributors:  
ms.topic: conceptual  
ms.date: 04/16/2025  
ms.author: justinha  
ms.reviewer: justinha  
---  

# Configure Microsoft Entra Private DNS

Microsoft Entra Private Access provides a quick and easy way to replace legacy VPNs, providing granular and secure access to internal resources without exposing your full network. DNS plays a vital role by enabling name resolution for critical internal resources without remote users needing to know the configuration of internal DNS systems. Microsoft Entra Private DNS with Quick Access offers a simple setup using Connector local resolvers to respond to DNS queries for internal resources.

Private DNS service allows you to add domain suffixes for the organization to the Quick Access configuration. This will automatically update the traffic forwarding profile for clients. Once configured, any DNS queries for fully qualified domain names (FQDN) ending with the matching suffixes from client devices are sent to the DNS proxy at a GSA edge for resolution. If a cached result is available, DNS responses are returned to the clients. Otherwise, the DNS proxy forwards the request to the Connector, which sends the DNS query to its DNS server for resolution. The Connector then passes the responses back to the edge, which in turn returns the query to the client. The GSA client then assigns a synthetic IP address and returns it back to the application. The synthetic IP is used to steer the application traffic to GSA edges.

A high-level Private DNS flow for Windows clients is shown in the diagram below.

- Configuration:  
  - Admin enables Private DNS and adds a DNS suffix from Quick Access.  
  - On the client, an entry in the Name Resolution Policy Table (NRPT) is generated for the suffix to resolve via the GSA client.  
  - Client traffic forwarding profile is updated to send private DNS queries to the GSA edge.  

- Data path:  
  - User tries to access an enterprise app `https://app.contoso.com`, which triggers a DNS query for app.contoso.com. If not cached locally, the DNS query is sent to the DNS proxy at the GSA edge.  
  - DNS proxy either responds from its cache or forwards the query to the Connector Group defined in Quick Access.  
  - Connector local resolvers resolve the DNS query and return it back to the DNS proxy.  
  - DNS proxy responds back to the client with the internal IP.  
  - Client stores the internal IP address and returns a synthetic IP to the application.  

:::image type="content" border=true source="media/concept-private-name-resolution/queries.png" alt-text="Screenshot of a diagram showing DNS queries resolved via Private DNS when a DNS suffix is configured in Quick Access."::: 

When a DNS suffix is configured in Quick Access, all DNS queries for fully qualified domain names (FQDN) ending with the matching suffixes are resolved via Private DNS, including those used to define Enterprise Apps.


## Single Label Domain (SLD) resolution

The Private DNS provides name resolution for SLD without a domain suffix. An NRPT entry is created to send GSA suffix `globalsecureaccess.local.` to DNS proxy when Private DNS is configured. The client machine will attempt to resolve the SLD by appending the locally configured search suffixes. If none of the search suffixes are resolved, the GSA client appends the `<appid>.globalsecureaccess.local.` suffix to the SLD and sends the DNS request to the DNS proxy. DNS proxy strips away the search suffix before sending the DNS query to the connector. The connector then uses its local search suffixes to resolve the SLD query. Resolved IP address for the resource is returned to the DNS proxy and passed along to the client.

> [!NOTE]  
> For some applications such as Kerberos authentication, it is important to have the correct SPN. GSA synthetic suffix may break Kerberos flow, so it is recommended to use FQDN for applications that require Kerberos authentication.


To learn how to enable Private DNS with Quick Access, see [How to configure Quick Access](/entra/global-secure-access/how-to-configure-quick-access).

To learn how Private DNS works with SSO, see [Use Kerberos for single sign-on (SSO) to your resources with Microsoft Entra Private Access](/entra/global-secure-access/how-to-configure-kerberos-sso).

To learn tips on DNS troubleshooting, see [Troubleshoot application access - Global Secure Access](/entra/global-secure-access/troubleshoot-app-access#how-does-dns-work-with-global-secure-access).

To learn hostname acquisition advanced diagnostics, see [Troubleshoot the Global Secure Access client: diagnostics - Global Secure Access](/entra/global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics#hostname-acquisition-tab). 
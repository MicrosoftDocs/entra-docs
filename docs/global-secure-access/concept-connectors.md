---
title: Understand the Microsoft Entra private network connector
description: Learn how Microsoft Entra private network connectors work and how they're used by Microsoft Entra Private Access and application proxy.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: how-to
ms.date: 09/25/2025
ms.service: global-secure-access
ai-usage: ai-assisted
---

# Understand Microsoft Entra private network connector

Connectors make Microsoft Entra Private Access and Application Proxy possible. They're simple to deploy and maintain, and powerful. This article explains what connectors are, how they work, and how to optimize your deployment.

## What is a private network connector?

Private network connectors are lightweight agents you install on a Windows Server inside your network. They create outbound connections to Microsoft Entra Private Access and the application proxy service to reach backend resources. Organize connectors into connector groups that handle traffic for specific resources. For an architecture overview, see [Using Microsoft Entra application proxy to publish on-premises apps for remote users](../identity/app-proxy/overview-what-is-app-proxy.md). To set them up, see [How to configure private network connectors for Microsoft Entra Private Access](how-to-configure-connectors.md). Users connect to the cloud service, which routes traffic to apps through the connectors.

Set up and register a connector with the application proxy service:
1. Open outbound ports 80 and 443 and allow access to the required service and Microsoft Entra ID URLs.
1. Sign in to the Microsoft Entra admin center and run the installer on an on-premises Windows Server.
1. Start the connector so it listens to the application proxy service.
1. Add the on-premises application to Microsoft Entra ID and set the user-facing URLs.

Deploy at least two connectors for redundancy and scale. The service and connectors handle high availability, and you can add or remove connectors at any time. Each request routes to an available connector. If a connector is unavailable, it doesn't handle traffic. The service tags unused connectors as inactive and removes them after 10 days of inactivity.

> [!NOTE]
> You can monitor the [version history page](reference-version-history.md) to stay informed on the latest updates so that you can schedule appropriate connector upgrades.

Each private network connector belongs to a [connector group](concept-connector-groups.md). Connectors in the same group act as a single unit for high availability and load balancing. Create groups and assign connectors in the Microsoft Entra admin center, then map groups to specific applications. Use at least two connectors in each group for high availability.

Use connector groups for:

* Geographical app publishing
* Application segmentation/isolation
* Publishing web apps running in the cloud or on-premises

For guidance on where to install connectors and optimize your network, see [Network topology considerations when using Microsoft Entra application proxy](../identity/app-proxy/application-proxy-network-topology.md).

## Maintenance

Connectors and the service handle high availability. Add or remove connectors at any time. The service routes new requests to an available connector. If a connector is temporarily unavailable, it doesn't receive traffic.

Connectors are stateless and store no configuration data on the machine. They store only the settings for connecting to the service and the authentication certificate. When they connect to the service, they pull the required configuration data and refresh it every few minutes.

Connectors poll the service for updates. When a newer version is available, they update themselves.

Monitor connectors on the host machine by using the event log and performance counters. View status in the Microsoft Entra admin center. For Microsoft Entra Private Access: Go to Global Secure Access > Connect > Connectors. For application proxy: Go to Identity > Applications > Enterprise applications, and select the application. On the application page, select application proxy.

You don't need to delete unused connectors manually. The service tags inactive connectors `_inactive_` and removes them after 10 days. To uninstall a connector, uninstall both the Connector service and the Updater service, then restart the computer.

## Handling connector server issues
If one or more connector servers are down because of a server, network, or similar outage, follow these steps to maintain continuity:
 
1. Identify and remove the affected ("bad") servers from the connector group.
2. Add available healthy servers ("good") or backup servers into the connector group to restore capacity.
3. Reboot affected servers to drain any preexisting connections. Existing ongoing connections don’t drain immediately with connector group changes.
 
Use this sequence to keep service stable and minimize disruption when connector servers have issues.

## Connector updates

Microsoft Entra ID occasionally provides automatic updates for all the connectors that you deploy. As long as the private network connector updater service is running, your connectors can update to the latest major connector release automatically. If you don’t see the Connector Updater service on your server, you need to reinstall your connector to get updates.

If you don't want to wait for an automatic update, do a manual upgrade. Go to the [connector download page](https://download.msappproxy.net/subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/connector/download) on the server that hosts your connector and select **Download**. This action starts an upgrade for the local connector. Not all releases are scheduled for automatic update. Monitor the [version history page](reference-version-history.md) to see whether an update is deployed automatically or requires a manual deployment in the Microsoft Entra portal.

In tenants with multiple connectors, automatic updates target one connector at a time in each group to prevent downtime.

You might experience downtime during an update if:
  
- You have only one connector. Add a second connector and a connector group to avoid downtime and provide higher availability.  
- The update starts while a connector processes a transaction. The initial transaction is lost, but the browser automatically retries the operation or you can refresh the page. The re-sent request routes to a backup connector.

For details about previous versions and their changes, see [Application proxy version release history](reference-version-history.md).

## Create connector groups

Connector groups let you assign connectors to specific applications. Group connectors, then assign each resource or application to a group.

Connector groups simplify management of large deployments. They can reduce latency for tenants with resources and applications in different regions. Create location-based connector groups to serve only local applications.

Learn more in [Understand Microsoft Entra private network connector groups](concept-connector-groups.md).

## Security and networking

Connectors can be installed anywhere on the network that allows them to send requests to the Microsoft Entra Private Access and application proxy service. What's important is that the computer running the connector also has access to your apps and resources. You can install connectors inside of your corporate network or on a virtual machine that runs in the cloud. Connectors can run within a perimeter network, also known as a demilitarized zone (DMZ), but it's not necessary because all traffic is outbound so your network stays secure.

Connectors only send outbound requests. The outbound traffic is sent to the service and to the published resources and applications. You don't have to open inbound ports because traffic flows both ways once a session is established. You also don't have to configure inbound access through your firewalls.

For more information about configuring outbound firewall rules, see [Work with existing on-premises proxy servers](../identity/app-proxy/application-proxy-configure-connectors-with-proxy-servers.md).

## Performance and scalability

Scale for Microsoft Entra Private Access and the application proxy services is transparent, but scale is a factor for connectors. You need to have enough connectors to handle peak traffic. Connectors are stateless and the number of users or sessions don't affect them. Instead, they respond to the number of requests and their payload size. With standard web traffic, an average machine can handle 2,000 requests per second. The specific capacity depends on the exact machine characteristics.

CPU and network define connector performance. CPU performance is needed for TLS encryption and decryption, while networking is important to get fast connectivity to the applications and the online service.

In contrast, memory is less of an issue for connectors. The online service takes care of much of the processing and all unauthenticated traffic. Everything that can be done in the cloud is done in the cloud.

When connectors or machines are unavailable, traffic goes to another connector in the group. Multiple connectors in a connector group provide resiliency.

Another factor that affects performance is the quality of the networking between the connectors, including:

- **The online service**: Slow or high-latency connections to the Microsoft Entra service influence the connector performance. For the best performance, connect your organization to Microsoft with Express Route. Otherwise, have your networking team ensure that connections to Microsoft are handled as efficiently as possible.
- **The backend applications**: In some cases, there are extra proxies between the connector and the backend resources and applications that can slow or prevent connections. To troubleshoot this scenario, open a browser from the connector server and try to access the application or resource. If you run the connectors in cloud but the applications are on-premises, the experience might not be what your users expect.
- **The domain controllers**: If the connectors perform single sign-on (SSO) using Kerberos Constrained Delegation, they contact the domain controllers before sending the request to the backend. The connectors have a cache of Kerberos tickets, but in a busy environment the responsiveness of the domain controllers can affect performance. This issue is more common for connectors that run in Azure but communicate with domain controllers that are on-premises.

For more information about optimizing your network, see [Network topology considerations when using Microsoft Entra application proxy](../identity/app-proxy/application-proxy-network-topology.md).

## Expanding Ephemeral Port Range

Private Network connectors initiate TCP/UDP connections to designated destination endpoints, requiring available source ports on the connector host machine. Expanding the ephemeral port range can improve the availability of source ports, particularly when managing a high volume of concurrent connections.

To view the current dynamic port range on a system, use the following netsh commands:
- `netsh int ipv4 show dynamicport tcp`
- `netsh int ipv4 show dynamicport udp`
- `netsh int ipv6 show dynamicport tcp`
- `netsh int ipv6 show dynamicport udp`
 
Sample netsh commands to increase the ports
- `netsh int ipv4 set dynamicport tcp start=1025 num=64511`
- `netsh int ipv4 set dynamicport udp start=1025 num=64511`
- `netsh int ipv6 set dynamicport tcp start=1025 num=64511`
- `netsh int ipv6 set dynamicport udp start=1025 num=64511`

These commands set the dynamic port range from 1025 to the maximum of 65535. The minimum start port is 1025.

## Specifications and Sizing Requirements
The following specifications are recommended for each Microsoft Entra Private Network Connector:

- **Memory:** 8 GiB or more
- **CPU:** 4 CPU cores  or more

Keep peak CPU and memory utilization per connector under 70%. If sustained utilization exceeds 70%, add connectors to the group or scale up host capacity to distribute load. Monitor with Windows performance counters to validate that utilization returns to an acceptable range.

Up to ~1.5 Gbps aggregate TCP throughput (combined inbound + outbound) per connector on an Azure VM sized at 4 vCPU / 8 GiB RAM with standard networking. Higher throughput can be achieved by using larger VM sizes (more vCPUs, memory, accelerated/high-bandwidth NICs) or by adding more connectors in the same group to scale out.

**More details:**  
- Performance guidance (for example ~1.5 Gbps on a 4 vCPU / 8 GiB host) is derived from controlled lab tests using iPerf3 TCP data streams in a dedicated test tenant. Actual throughput can vary based on CPU generation, NIC capabilities (accelerated networking, offloads), TLS cipher suites, network latency and jitter, packet loss, concurrent protocol mix (HTTP(S), SMB, RDP), intermediate devices (firewalls, IDS/IPS, SSL inspection), and backend application responsiveness. Scenario-based benchmark data (mixed workloads, high-connection concurrency, latency-sensitive applications) will be added to this documentation as it becomes available.
- Once a connector is enrolled, it establishes outbound TLS tunnels to the Private Access cloud infrastructure. These tunnels handle all data path traffic. In addition, we have some control plane channel, driving keep-alive heartbeat, health reporting, connector upgrades and so on utilizing minimal bandwidth.
- You can deploy more connectors in the same connector group to increase overall throughput, provided adequate network and internet connectivity is available. It is recommended to maintain a minimum of two healthy connectors to ensure resiliency and consistent availability. For best practices regarding high availability, refer to the guidance [here](../identity/app-proxy/application-proxy-high-availability-load-balancing.md#best-practices-for-high-availability-of-connectors).

## Domain joining

Connectors can run on a machine that isn't domain-joined. However, if you want single sign-on (SSO) to applications that use integrated Windows authentication (IWA), you need a domain-joined machine. In this case, the connector machines must be joined to a domain that can perform [Kerberos](https://web.mit.edu/kerberos) Constrained Delegation on behalf of the users for the published applications.

Connectors can also be joined to domains in forests that have a partial trust, or to read-only domain controllers.

## Connector deployments on hardened environments

Usually, connector deployment is straightforward and requires no special configuration.

However, there are some unique conditions that should be considered:

- Outbound traffic requires specific ports to be open. To learn more, see [configure connectors](concept-connectors.md).
- FIPS-compliant machines might require a configuration change to allow the connector processes to generate and store a certificate.
- Outbound forward proxies could break the two-way certificate authentication and cause communication to fail.

## Connector authentication

To provide a secure service, connectors have to authenticate toward the service, and the service has to authenticate toward the connector. This authentication is done using client and server certificates when the connectors initiate the connection. This way the administrator’s username and password aren't stored on the connector machine.

The certificates used are specific to the service. They're created during the initial registration and automatically renewed every couple of months.

After the first successful certificate renewal, the Microsoft Entra private network connector service (Network Service) has no permission to remove the old certificate from the local machine store. If the certificate expires or isn't used by the service, you can delete it safely.

To avoid problems with certificate renewal, ensure that the network communication from the connector towards the [documented destinations](concept-connectors.md) is enabled.

If a connector isn't connected to the service for several months, its certificates could be outdated. In this case, uninstall and reinstall the connector to trigger registration. You can run the following PowerShell commands:

```
Import-module MicrosoftEntraPrivateNetworkConnectorPSModule
Register-MicrosoftEntraPrivateNetworkConnector -EnvironmentName "AzureCloud"
```

For government, use `-EnvironmentName "AzureUSGovernment"`. For more information, see [Install Agent for the Azure Government Cloud](../identity/hybrid/connect/reference-connect-government-cloud.md#install-the-agent-for-the-azure-government-cloud).

To learn how to verify the certificate and troubleshoot problems see [Verify Machine and backend components support for application proxy trust certificate](../identity/app-proxy/application-proxy-connector-installation-problem.md).

## Under the hood

Connectors are installed on Windows Server, so they have most of the same management tools including Windows Event Logs and Windows performance counters.

The connectors have both **Admin** and **Session** logs. The **Admin** log includes key events and their errors. The **Session** log includes all the transactions and their processing details.

To see the logs, open **Event Viewer** and go to **Applications and Services Logs** > **Microsoft** > **Microsoft Entra private network** > **Connector**. To make the **Session** log visible, on the **View** menu, select **Show Analytic and Debug Logs**. The **Session** log is typically used for troubleshooting, and is disabled by default. Enable it to start collecting events and disable it when it's no longer needed.

You can examine the state of the service in the Services window. The connector is made up of two Windows Services: the actual connector, and the updater. Both of them must run all the time.

## Inactive connectors
A common issue is that connectors appear as inactive in a connector group. A firewall blocking the required ports is a common cause for inactive connectors.

## Next steps

- [Understand Microsoft Entra private network connector groups](concept-connector-groups.md)
- [Work with existing on-premises proxy servers](../identity/app-proxy/application-proxy-configure-connectors-with-proxy-servers.md)
- [Troubleshoot application proxy and connector errors](../identity/app-proxy/application-proxy-troubleshoot.md)
- [How to silently install the Microsoft Entra private network connector](how-to-register-connector-powershell.md)

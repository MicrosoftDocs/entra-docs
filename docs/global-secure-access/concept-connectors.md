---
title: Microsoft Entra Private Network Connectors
description: Learn how Microsoft Entra private network connectors work and how Microsoft Entra Private Access and application proxy use them.
ms.topic: concept-article
ms.date: 09/25/2025
ai-usage: ai-assisted
---

# Microsoft Entra private network connectors

Connectors make Microsoft Entra Private Access and application proxy possible. This article explains what connectors are, how they work, and how to optimize your deployment.

## What is a private network connector?

Private network connectors are lightweight agents that you install on Windows Server inside your network. They create outbound connections to the Private Access and application proxy services to reach back-end resources.

Users connect to the cloud service, which routes traffic to apps through the connectors. For an architecture overview, see [Using Microsoft Entra application proxy to publish on-premises apps for remote users](../identity/app-proxy/overview-what-is-app-proxy.md).

To set up and register a connector with the application proxy service:

1. Open outbound ports 80 and 443, and allow access to the required service and Microsoft Entra ID URLs.
1. Sign in to the Microsoft Entra admin center and run the installer on an on-premises Windows Server machine.
1. Start the connector so that it listens to the application proxy service.
1. Add the on-premises application to Microsoft Entra ID, and set the user-facing URLs.

For more information about setup, see [How to configure private network connectors for Microsoft Entra Private Access and application proxy](how-to-configure-connectors.md).

Connectors and the service handle high availability. You can add or remove connectors at any time.

## Connector groups

You can organize connectors into connector groups that handle traffic for specific resources. Connectors in the same group act as a single unit for high availability and load balancing.

Create groups and assign connectors in the Microsoft Entra admin center, and then map groups to specific applications. Use at least two connectors in each group for high availability.

Use connector groups for:

- Geographical app publishing.
- Application segmentation and isolation.
- Publishing web apps running in the cloud or on-premises.

Connector groups simplify management of large deployments. They can reduce latency for tenants that have resources and applications in different regions. Create location-based connector groups to serve only local applications.

Learn more in [Microsoft Entra private network connector groups](concept-connector-groups.md).

## Maintenance

The service routes new requests to an available connector. If a connector is temporarily unavailable, it doesn't receive traffic.

Connectors are stateless and store no configuration data on the machine. They store only the settings for connecting to the service and the authentication certificate. When they connect to the service, they pull the required configuration data and refresh it every few minutes. To learn more about maintenance on connectors, see [How to configure private network connectors for Microsoft Entra Private Access and Microsoft Entra application proxy](how-to-configure-connectors.md).

### Connector status

You can view the status of connectors in the Microsoft Entra admin center:

- For Private Access: Go to **Global Secure Access** > **Connect** > **Connectors**.
- For application proxy: Go to **Identity** > **Applications** > **Enterprise applications**, and then select the application. On the application page, select **Application proxy**.

### Logs

Connectors are installed on Windows Server, so they have most of the same management tools. You can use Windows event logs and Windows performance counters to monitor connectors.

Connectors have both **Admin** and **Session** logs. The **Admin** log includes key events and their errors. The **Session** log includes all the transactions and their processing details.

To view the logs:

1. Open **Event Viewer** and go to **Applications and Services Logs** > **Microsoft** > **Microsoft Entra private network** > **Connector**.

   The **Admin** log is visible by default.
1. To make the **Session** log visible, on the **View** menu, select **Show Analytic and Debug Logs**.

   The **Session** log is typically used for troubleshooting and is disabled by default. Enable it to start collecting events, and disable it when you no longer need it.

### Service state

The connector consists of two Windows services: the actual connector and the updater. Both of them must run all the time. You can examine the state of the services in the **Services** window.

## Handling connector server problems

If one or more connector servers are down because of a server, network, or similar outage, follow these steps to maintain continuity:

1. Identify and remove the affected servers from the connector group.
2. Add available healthy servers or backup servers into the connector group to restore capacity.
3. Restart affected servers to drain any preexisting connections. Existing ongoing connections don't drain immediately with connector group changes.

Use this sequence to keep the service stable and minimize disruption when connector servers have problems.

## Connector updates

Microsoft Entra ID occasionally provides automatic updates for the connectors that you deploy. Connectors poll the updater service for updates. When a newer version is available for an automatic update, the connectors update themselves. As long as the updater service is running, your connectors can update to the latest major connector release automatically. If you don't see the updater service on your server, you need to reinstall your connector to get updates.

Not all releases are scheduled for automatic updates. Monitor the [version history page](reference-version-history.md) to see whether an update is deployed automatically or requires a manual deployment in the Microsoft Entra portal. If you need to do a manual update, on the server that hosts your connector, go to the [connector download page](https://download.msappproxy.net/subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/connector/download) and select **Download**. This action starts an update for the local connector.

In tenants that have multiple connectors, automatic updates target one connector at a time in each group to prevent downtime. You might experience downtime during an update if:
  
- You have only one connector. To avoid downtime and provide higher availability, add a second connector and a connector group.  
- The update starts while a connector processes a transaction. The initial transaction is lost, but the browser automatically retries the operation, or you can refresh the page. The re-sent request is routed to a backup connector.

For details about previous versions and their changes, see [Microsoft Entra private network connector: Version release history](reference-version-history.md).

## Security and networking

Connectors can be installed anywhere on the network that allows them to send requests to the Private Access and application proxy services. What's important is that the computer running the connector also has access to your apps and resources.

You can install connectors inside your corporate network or on a virtual machine (VM) that runs in the cloud. Connectors can run within a perimeter network, but it's not necessary because all traffic is outbound for network security.

Connectors only send outbound requests. The outbound traffic is sent to the service and to the published resources and applications. You don't have to open inbound ports because traffic flows both ways after a session is established. You also don't have to configure inbound access through your firewalls.

## Performance and scalability

Scale for the Private Access and application proxy services is transparent, but scale is a factor for connectors. You need to have enough connectors to handle peak traffic.

Connectors are stateless, and the number of users or sessions doesn't affect them. Instead, they respond to the number of requests and the payload size. With standard web traffic, an average machine can handle 2,000 requests per second. The specific capacity depends on the exact machine characteristics.

CPU and the network define connector performance. CPU performance is needed for TLS encryption and decryption, whereas networking is important to get fast connectivity to the applications and the online service.

In contrast, memory is less of an issue for connectors. The online service takes care of much of the processing and all unauthenticated traffic. Everything that can be done in the cloud is done in the cloud.

When connectors or machines are unavailable, traffic goes to another connector in the group. Multiple connectors in a connector group provide resiliency.

Another factor that affects performance is the quality of the networking between the connectors, including:

- **Online service**: Slow or high-latency connections to the Microsoft Entra service influence the connector performance. For the best performance, connect your organization to Microsoft through Azure ExpressRoute. Otherwise, have your networking team ensure that connections to Microsoft are handled as efficiently as possible.
- **Back-end applications**: In some cases, there are extra proxies between the connector and the back-end resources and applications that can slow or prevent connections. To troubleshoot this scenario, open a browser from the connector server and try to access the application or resource. If you run the connectors in cloud but the applications are on-premises, the experience might not be what your users expect.
- **Domain controllers**: If the connectors perform single sign-on (SSO) by using [Kerberos](https://web.mit.edu/kerberos) constrained delegation (KCD), they contact the domain controllers before sending the request to the back end. The connectors have a cache of Kerberos tickets, but the responsiveness of the domain controllers can affect performance in a busy environment. This issue is more common for connectors that run in Azure but communicate with domain controllers that are on-premises.

For guidance on where to install connectors and how to optimize your network, see [Optimize traffic flow with Microsoft Entra application proxy](../identity/app-proxy/application-proxy-network-topology.md).

## Expanding ephemeral port range

Private network connectors initiate TCP and UDP connections to designated destination endpoints. These connections require available source ports on the connector host machine. Expanding the ephemeral port range can improve the availability of source ports, particularly when you're managing a high volume of concurrent connections.

To view the current dynamic port range on a system, use the following `netsh` commands:

- `netsh int ipv4 show dynamicport tcp`
- `netsh int ipv4 show dynamicport udp`
- `netsh int ipv6 show dynamicport tcp`
- `netsh int ipv6 show dynamicport udp`

Here are sample `netsh` commands to increase the ports:

- `netsh int ipv4 set dynamicport tcp start=1025 num=64511`
- `netsh int ipv4 set dynamicport udp start=1025 num=64511`
- `netsh int ipv6 set dynamicport tcp start=1025 num=64511`
- `netsh int ipv6 set dynamicport udp start=1025 num=64511`

These commands set the dynamic port range from 1025 to the maximum of 65535. The minimum start port is 1025.

## Specifications and sizing requirements

We recommend the following specifications for each Microsoft Entra private network connector:

- **Memory**: 8 GiB or more.
- **CPU**: Four CPU cores or more.

Keep peak CPU and memory utilization per connector under 70%. If sustained utilization exceeds 70%, add connectors to the group or scale up host capacity to distribute load. Monitor with Windows performance counters to validate that utilization returns to an acceptable range.

You can expect up to 1.5-Gbps aggregate TCP throughput (combined inbound and outbound) per connector on an Azure VM sized at four vCPUs and 8 GiB of RAM with standard networking. You can achieve higher throughput by using larger VM sizes (more vCPUs, more memory, and accelerated or high-bandwidth NICs), or by adding more connectors in the same group to scale out.

We derived this performance guidance from controlled lab tests that used iPerf3 TCP data streams in a dedicated test tenant. Actual throughput can vary based on:

- CPU generation.
- NIC capabilities (accelerated networking, offloads).
- TLS cipher suites.
- Network latency and jitter.
- Packet loss.
- Concurrent protocol mix (HTTPS, SMB, RDP).
- Intermediate devices (firewalls, IDS/IPS, SSL inspection).
- Back-end application responsiveness.

Scenario-based benchmark data (mixed workloads, high-connection concurrency, latency-sensitive applications) will be added to this documentation as it becomes available.

After a connector is enrolled, it establishes outbound TLS tunnels to the Private Access cloud infrastructure. These tunnels handle all data path traffic. In addition, the control plane channel uses minimal bandwidth to drive keep-alive heartbeat, health reporting, connector updates, and other functions.

You can deploy more connectors in the same connector group to increase overall throughput, if adequate network and internet connectivity is available. We recommend that you maintain a minimum of two healthy connectors to ensure resiliency and consistent availability.

To learn more, see [Best practices for high availability of connectors](../identity/app-proxy/application-proxy-high-availability-load-balancing.md#best-practices-for-high-availability-of-connectors).

## Domain joining

Connectors can run on a machine that isn't domain joined. However, if you want SSO to applications that use integrated Windows authentication, you need a domain-joined machine. In this case, the connector machines must be joined to a domain that can perform KCD on behalf of the users for the published applications.

You can also join connectors to:

- Domains in forests that have a partial trust.
- Read-only domain controllers.

## Connector deployments in hardened environments

Usually, connector deployment is straightforward and requires no special configuration. But consider these unique conditions:

- Outbound traffic requires specific ports to be open (80 and 443).
- FIPS-compliant machines might require a configuration change to allow the connector processes to generate and store a certificate.
- Outbound forward proxies could break the two-way certificate authentication and cause communication to fail.

## Connector authentication

To provide a secure service, connectors have to authenticate toward the service, and the service has to authenticate toward the connector. This authentication uses client and server certificates when the connectors initiate the connection. This way, the administrator's username and password aren't stored on the connector machine.

The certificates are specific to the service. They're created during the initial registration and automatically renewed every couple of months.

After the first successful certificate renewal, the connector service has no permission to remove the old certificate from the local machine store. If the certificate expires or the service doesn't use it, you can delete it safely.

To avoid problems with certificate renewal, ensure that the network communication from the connector toward the documented destinations is enabled.

If a connector isn't connected to the service for several months, its certificates might be outdated. In this case, uninstall and reinstall the connector to trigger registration. You can run the following PowerShell commands:

```
Import-module MicrosoftEntraPrivateNetworkConnectorPSModule
Register-MicrosoftEntraPrivateNetworkConnector -EnvironmentName "AzureCloud"
```

For Azure Government, use `-EnvironmentName "AzureUSGovernment"`. For more information, see [Install the agent for the Azure Government cloud](../identity/hybrid/connect/reference-connect-government-cloud.md#install-the-agent-for-the-azure-government-cloud).

To learn how to verify the certificate and troubleshoot problems, see [Troubleshoot problems installing the private network connector](../identity/app-proxy/application-proxy-connector-installation-problem.md).

## Inactive connectors

You don't need to delete unused connectors manually. The service tags inactive connectors as `_inactive_` and removes them after 10 days.

To uninstall a connector, uninstall both the connector service and the updater service. Then, restart the computer.

If connectors that you expect to be active appear as inactive in a connector group, a firewall might be blocking the required ports. For more information about configuring outbound firewall rules, see [Work with existing on-premises proxy servers](../identity/app-proxy/application-proxy-configure-connectors-with-proxy-servers.md).

## Related content

- [Microsoft Entra private network connector groups](concept-connector-groups.md)
- [Troubleshoot application proxy and connector errors](../identity/app-proxy/application-proxy-troubleshoot.md)
- [Create an unattended installation script for the Microsoft Entra private network connector](how-to-register-connector-powershell.md)

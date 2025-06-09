---
title: Understand the Microsoft Entra private network connector
description: Learn how Microsoft Entra private network connectors work and how they're used by Microsoft Entra Private Access and application proxy.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: conceptual
ms.date: 02/21/2025
ms.service: global-secure-access
ai-usage: ai-assisted
---

# Understand the Microsoft Entra private network connector

Connectors are what make Microsoft Entra Private Access and application proxy possible. They're simple, easy to deploy and maintain, and super powerful. This article discusses what connectors are, how they work, and some suggestions for how to optimize your deployment.

## What is a private network connector?

Connectors are lightweight agents that sit in a private network and facilitate the outbound connection to the Microsoft Entra Private Access and application proxy services. Connectors must be installed on a Windows Server that has access to the backend resources. You can organize connectors into connector groups, with each group handling traffic to specific resources. For more information on application proxy and a diagrammatic representation of application proxy architecture, see [Using Microsoft Entra application proxy to publish on-premises apps for remote users](../identity/app-proxy/overview-what-is-app-proxy.md).


To learn how to configure the Microsoft Entra private network connector, see [How to configure private network connectors for Microsoft Entra Private Access](how-to-configure-connectors.md).

Private network connectors are lightweight agents deployed on-premises that facilitate the outbound connection to the application proxy service in the cloud. The connectors must be installed on a Windows Server that has access to the backend application. Users connect to the application proxy cloud service that routes their traffic to the apps via the connectors.

Setup and registration between a connector and the application proxy service is accomplished as follows:

1. The IT administrator opens ports 80 and 443 to outbound traffic and allows access to several URLs that are needed by the connector, the application proxy service, and Microsoft Entra ID.
2. The admin signs into the Microsoft Entra admin center and runs an executable to install the connector on an on-premises Windows server.
3. The connector starts to "listen" to the application proxy service.
4. The admin adds the on-premises application to Microsoft Entra ID and configures settings such as the URLs users need to connect to their apps.

It's recommended that you always deploy multiple connectors for redundancy and scale. The connectors, in conjunction with the service, take care of all the high availability tasks and can be added or removed dynamically. Each time a new request arrives it's routed to one of the connectors that is available. When a connector is running, it remains active as it connects to the service. If a connector is temporarily unavailable, it doesn't respond to this traffic. Unused connectors are tagged as inactive and removed after 10 days of inactivity.

Connectors also poll the server to find out if there's a newer version of the connector. Although you can do a manual update, connectors will update automatically as long as the private network connector Updater service is running. For tenants with multiple connectors, the automatic updates target one connector at a time in each group to prevent downtime in your environment.

> [!NOTE]
> You can monitor the [version history page](reference-version-history.md) to stay informed on the latest updates.

Each private network connector is assigned to a [connector group](concept-connector-groups.md). Connectors in the same connector group act as a single unit for high availability and load balancing. You can create new groups, assign connectors to them in the Microsoft Entra admin center, then assign specific connectors to serve specific applications. It's recommended to have at least two connectors in each connector group for high availability.

Connector groups are useful when you need to support the following scenarios:

* Geographical app publishing
* Application segmentation/isolation
* Publishing web apps running in the cloud or on-premises

For more information about choosing where to install your connectors and optimizing your network, see [Network topology considerations when using Microsoft Entra application proxy](../identity/app-proxy/application-proxy-network-topology.md).

## Maintenance

The connectors and the service take care of all the high availability tasks. They can be added or removed dynamically. New requests are routed to one of the available connectors. If a connector is temporarily unavailable, it doesn't respond to this traffic.

The connectors are stateless and have no configuration data on the machine. The only data they store is the settings for connecting the service and its authentication certificate. When they connect to the service, they pull all the required configuration data and refresh it every couple of minutes.

Connectors also poll the server to find out whether there's a newer version of the connector. If one is found, the connectors update themselves.

You can monitor your connectors from the machine they're running on, using either the event log and performance counters. You can also view their status in the Microsoft Entra admin center. For Microsoft Entra Private Access, navigate to Global Secure Access, Connect, and select Connectors. For application proxy, navigate to Identity, Applications, Enterprise applications, and select the application. On the application page select application proxy.

You don't have to manually delete connectors that are unused. When a connector is running, it remains active as it connects to the service. Unused connectors are tagged as `_inactive_` and are removed after 10 days of inactivity. If you do want to uninstall a connector, though, uninstall both the Connector service and the Updater service from the server. Restart the computer to fully remove the service.

## Automatic updates

Microsoft Entra ID provides automatic updates for all the connectors that you deploy. As long as the private network connector updater service is running, your connectors update with the latest major connector release automatically. If you don’t see the Connector Updater service on your server, you need to reinstall your connector to get updates.

If you don't want to wait for an automatic update to come to your connector, you can do a manual upgrade. Go to the [connector download page](https://download.msappproxy.net/subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/connector/download) on the server where your connector is located and select **Download**. This process kicks off an upgrade for the local connector.

For tenants with multiple connectors, the automatic updates target one connector at a time in each group to prevent downtime in your environment.

You could experience downtime when your connector updates if:
  
- You only have one connector. A second connector and a connector group are recommended to avoid downtime and provide higher availability.  
- A connector was in the middle of a transaction when the update began. Although the initial transaction is lost, your browser should automatically retry the operation or you can refresh your page. When the request is resent, the traffic is routed to a backup connector.

To see information about previously released versions and what changes they include, see [Application proxy- Version Release History](reference-version-history.md).

## Creating connector groups

Connector groups enable you to assign specific connectors to serve specific applications. You can group many connectors together, and then assign each resource or application to a group.

Connector groups make it easier to manage large deployments. They also improve latency for tenants that have resources and applications hosted in different regions, because you can create location-based connector groups to serve only local applications.

To learn more about connector groups, see [Understand Microsoft Entra private network connector groups](concept-connector-groups.md).

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
- netsh int ipv4 show dynamicport tcp
- netsh int ipv4 show dynamicport udp
- netsh int ipv6 show dynamicport tcp
- netsh int ipv6 show dynamicport udp
 
Sample netsh commands to increase the ports
- netsh int ipv4 set dynamicport tcp start=1025 num=64511
- netsh int ipv4 set dynamicport udp start=1025 num=64511
- netsh int ipv6 set dynamicport tcp start=1025 num=64511
- netsh int ipv6 set dynamicport udp start=1025 num=64511

These commands set the dynamic port range from 1025 to the maximum of 65535. The minimum start port is 1025.

## Specifications and Sizing Requirements
The following specifications are recommended for each Entra Private Network Connector:

- **Memory:** 8 GiB or more
- **CPU:** 4 CPU cores  or more

Ensure that your connectors are less than 70% for peak memory utilization and peak CPU utilization. If your CPU or memory utilization is above the suggested maximum, you may want to consider adding more connectors to distribute your workloads effectively. 

- **Throughput:** 
Each connector, configured with the above specifications, can support up to 1.5 Gbps throughput over TCP on an Azure VM. Throughput is measured as the total of both inbound and outbound traffic. Higher throughput can be achieved by running the connector on VMs with increased memory, CPU resources, and enhanced network link speeds.

**Additional Details:**  
- Sizing recommendations made above are based on performance testing done on a test tenant using iPerf3 tool with TCP data streams. Actual performance can vary under different testing environments. More details on specific test cases will be published as part of this documentation in coming months. 
- Once a connector is enrolled, it establishes outbound TLS tunnels to the Private Access cloud infrastructure. These tunnels handle all data path traffic. In addition, we have some control plane channel, driving keep-alive heartbeat, health reporting, connector upgrades and so on utilizing minimal bandwidth.
- You can deploy additional connectors within the same connector group to increase overall throughput, provided adequate network and internet connectivity is available. It is recommended to maintain a minimum of two healthy connectors to ensure resiliency and consistent availability. For best practices regarding high availability, refer to the guidance [here](../identity/app-proxy/application-proxy-high-availability-load-balancing.md#best-practices-for-high-availability-of-connectors).

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

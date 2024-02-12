---
title: Understand Microsoft Entra application proxy connectors
description: Learn how to use Microsoft Entra application proxy connectors.
author: kenwith
manager: amycolannino
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: conceptual
ms.date: 02/12/2024
ms.author: kenwith
ms.reviewer: ashishj
---

# Understand Microsoft Entra application proxy connectors

Connectors are what make Microsoft Entra application proxy possible. They're simple, easy to deploy and maintain, and super powerful. This article discusses what connectors are, how they work, and some suggestions for how to optimize your deployment.

## What is an application proxy connector?

Connectors are lightweight agents that sit on-premises and facilitate the outbound connection to the application proxy service. Connectors must be installed on a Windows Server that has access to the backend application. You can organize connectors into connector groups, with each group handling traffic to specific applications. For more information on Application proxy and a diagrammatic representation of application proxy architecture, see [Using Microsoft Entra application proxy to publish on-premises apps for remote users](overview-what-is-app-proxy.md#application-proxy-connectors).

## Requirements and deployment

To deploy application proxy successfully, you need at least one connector, but we recommend two or more for greater resiliency. Install the connector on a machine running Windows Server 2012 R2 or later. The connector needs to communicate with the application proxy service and the on-premises applications that you publish.

### Windows Server
You need a server running Windows Server 2012 R2 or later on which you can install the application proxy connector. The server needs to connect to the application proxy services in Azure, and the on-premises applications that you're publishing.

> [!IMPORTANT]
> Version 1.5.3437.0+ requires .NET version 4.7.1 or greater for installation or upgrade.

The server needs to have Transport Layer Security (TLS) 1.2 enabled before you install the application proxy connector. To enable TLS 1.2 on the server:

1. Set the following registry keys:

    ```
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.8.4250.0] "SchUseStrongCrypto"=dword:00000001
    ```

    A `regedit` file you can use to set these values follows:
    
    ```
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]
    "DisabledByDefault"=dword:00000000
    "Enabled"=dword:00000001
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server]
    "DisabledByDefault"=dword:00000000
    "Enabled"=dword:00000001
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.8.4250.0]
    "SchUseStrongCrypto"=dword:00000001
    ```
    
1. Restart the server

For more information about the network requirements for the connector server, see [Get started with application proxy and install a connector](application-proxy-add-on-premises-application.md).

## Maintenance

The connectors and the service take care of all the high availability tasks. They can be added or removed dynamically. New requests are routed to one of the available connectors. If a connector is temporarily unavailable, it doesn't respond to this traffic.

The connectors are stateless and have no configuration data on the machine. The only data they store is the settings for connecting the service and its authentication certificate. When they connect to the service, they pull all the required configuration data and refresh it every couple of minutes.

Connectors also poll the server to find out whether there's a newer version of the connector. If one is found, the connectors update themselves.

You can monitor your connectors from the machine they're running on, using either the event log and performance counters. For more information, see [Monitor and review logs for on-premises Microsoft Entra](~/identity/authentication/howto-password-ban-bad-on-premises-monitor.md).

You can also view their status from the application proxy page of the Microsoft Entra admin center:

![Example: Microsoft Entra application proxy connectors](media/application-proxy-connectors/app-proxy-connectors.png)

You don't have to manually delete connectors that are unused. When a connector is running, it remains active as it connects to the service. Unused connectors are tagged as _inactive_ and are removed after 10 days of inactivity. If you do want to uninstall a connector, though, uninstall both the Connector service and the Updater service from the server. Restart your computer to fully remove the service.

## Automatic updates

Microsoft Entra ID provides automatic updates for all the connectors that you deploy. As long as the application proxy Connector Updater service is running, your connectors [update with the latest major connector release](application-proxy-faq.yml#why-is-my-connector-still-using-an-older-version-and-not-auto-upgraded-to-latest-version-) automatically. If you don’t see the Connector Updater service on your server, you need to [reinstall your connector](application-proxy-add-on-premises-application.md) to get any updates.

If you don't want to wait for an automatic update to come to your connector, you can do a manual upgrade. Go to the [connector download page](https://download.msappproxy.net/subscription/d3c8b69d-6bf7-42be-a529-3fe9c2e70c90/connector/download) on the server where your connector is located and select **Download**. This process kicks off an upgrade for the local connector.

For tenants with multiple connectors, the automatic updates target one connector at a time in each group to prevent downtime in your environment.

You could experience downtime when your connector updates if:
  
- You only have one connector. A second connector and [create a connector group](application-proxy-connector-groups.md) are recommended to avoid downtime and provide higher availability.  
- A connector was in the middle of a transaction when the update began. Although the initial transaction is lost, your browser should automatically retry the operation or you can refresh your page. When the request is resent, the traffic is routed to a backup connector.

To see information about previously released versions and what changes they include, see [Application proxy- Version Release History](application-proxy-release-version-history.md).

## Creating connector groups

Connector groups enable you to assign specific connectors to serve specific applications. You can group many connectors together, and then assign each application to a group.

Connector groups make it easier to manage large deployments. They also improve latency for tenants that have applications hosted in different regions, because you can create location-based connector groups to serve only local applications.

To learn more about connector groups, see [Publish applications on separate networks and locations using connector groups](application-proxy-connector-groups.md).

## Capacity planning

Plan for enough capacity between connectors to handle the expected traffic volume. At least two connectors in a connector group provide high availability and scale. But three connectors are optimal.

The table provides volume and expected latency for different machine specifications. The data is based on expected Transactions Per Second (TPS) rather than by user because usage patterns vary and can't be used to predict load. There are some differences based on the size of the responses and the backend application response time - larger response sizes and slower response times result in a lower Max TPS. More machines distribute load and provide ample buffer. Extra capacity ensures high availability and resiliency.

|Cores|RAM|Expected Latency (MS)-P99|Max TPS|
| ----- | ----- | ----- | ----- |
|2|8|325|586|
|4|16|320|1150|
|8|32|270|1190|
|16|64|245|1200*|

\* The machine used a custom setting to raise some of the default connection limits beyond .NET recommended settings. We recommend running a test with the default settings before contacting support to get this limit changed for your tenant.

> [!NOTE]
> There isn't much difference in the maximum TPS between 4, 8, and 16 core machines. The main difference is the expected latency.
>
> The table focuses on the expected performance of a connector based on the type of machine it's installed on. This is separate from the application proxy service's throttling limits, see [Service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md).

## Security and networking

Connectors can be installed anywhere on the network that allows them to send requests to the application proxy service. What's important is that the computer running the connector also has access to your apps. You can install connectors inside of your corporate network or on a virtual machine that runs in the cloud. Connectors can run within a perimeter network, also known as a demilitarized zone (DMZ), but it's not necessary because all traffic is outbound so your network stays secure.

Connectors only send outbound requests. The outbound traffic is sent to the application proxy service and to the published applications. You don't have to open inbound ports because traffic flows both ways once a session is established. You also don't have to configure inbound access through your firewalls.

For more information about configuring outbound firewall rules, see [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md).

## Performance and scalability

Scale for the application proxy service is transparent, but scale is a factor for connectors. You need to have enough connectors to handle peak traffic. Connectors are stateless and the number of users or sessions don't affect them. Instead, they respond to the number of requests and their payload size. With standard web traffic, an average machine can handle 2,000 requests per second. The specific capacity depends on the exact machine characteristics.

CPU and network define connector performance. CPU performance is needed for TLS encryption and decryption, while networking is important to get fast connectivity to the applications and the online service.

In contrast, memory is less of an issue for connectors. The online service takes care of much of the processing and all unauthenticated traffic. Everything that can be done in the cloud is done in the cloud.

When connectors or machines are unavailable, traffic goes to another connector in the group. Multiple connectors in a connector group provide resiliency.

Another factor that affects performance is the quality of the networking between the connectors, including:

- **The online service**: Slow or high-latency connections to the application proxy service in Azure influence the connector performance. For the best performance, connect your organization to Azure with Express Route. Otherwise, have your networking team ensure that connections to Azure are handled as efficiently as possible.
- **The backend applications**: In some cases, there are extra proxies between the connector and the backend applications that can slow or prevent connections. To troubleshoot this scenario, open a browser from the connector server and try to access the application. If you run the connectors in Azure but the applications are on-premises, the experience might not be what your users expect.
- **The domain controllers**: If the connectors perform single sign-on (SSO) using Kerberos Constrained Delegation, they contact the domain controllers before sending the request to the backend. The connectors have a cache of Kerberos tickets, but in a busy environment the responsiveness of the domain controllers can affect performance. This issue is more common for connectors that run in Azure but communicate with domain controllers that are on-premises.

For more information about optimizing your network, see [Network topology considerations when using Microsoft Entra application proxy](application-proxy-network-topology.md).

## Domain joining

Connectors can run on a machine that isn't domain-joined. However, if you want single sign-on (SSO) to applications that use integrated Windows authentication (IWA), you need a domain-joined machine. In this case, the connector machines must be joined to a domain that can perform [Kerberos](https://web.mit.edu/kerberos) Constrained Delegation on behalf of the users for the published applications.

Connectors can also be joined to domains in forests that have a partial trust, or to read-only domain controllers.

## Connector deployments on hardened environments

Usually, connector deployment is straightforward and requires no special configuration.

However, there are some unique conditions that should be considered:

- Outbound traffic requires specific ports to be open. To learn more, see [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md#prepare-your-on-premises-environment).
- FIPS-compliant machines might require a configuration change to allow the connector processes to generate and store a certificate.
- Outbound forward proxies could break the two-way certificate authentication and cause communication to fail.

## Connector authentication

To provide a secure service, connectors have to authenticate toward the service, and the service has to authenticate toward the connector. This authentication is done using client and server certificates when the connectors initiate the connection. This way the administrator’s username and password aren't stored on the connector machine.

The certificates used are specific to the application proxy service. They're created during the initial registration and automatically renewed every couple of months.

After the first successful certificate renewal, the Microsoft Entra application proxy connector service (Network Service) has no permission to remove the old certificate from the local machine store. If the certificate expires or isn't used by the service, you can delete it safely.

To avoid problems with the certificate renewal, ensure that the network communication from the connector towards the [documented destinations](application-proxy-add-on-premises-application.md#prepare-your-on-premises-environment) is enabled.

If a connector isn't connected to the service for several months, its certificates could be outdated. In this case, uninstall and reinstall the connector to trigger registration. You can run the following PowerShell commands:

```
Import-module AppProxyPSModule
Register-AppProxyConnector -EnvironmentName "AzureCloud"
```

For government, use `-EnvironmentName "AzureUSGovernment"`. For more information, see [Install Agent for the Azure Government Cloud](~/identity/hybrid/connect/reference-connect-government-cloud.md#install-the-agent-for-the-azure-government-cloud).

To learn how to verify the certificate and troubleshoot problems see [Verify Machine and backend components support for application proxy trust certificate](application-proxy-connector-installation-problem.md).

## Under the hood

Connectors are based on Windows Server Web application proxy, so they have most of the same management tools including Windows Event Logs and Windows performance counters.

![Manage event logs with the Event Viewer](media/application-proxy-connectors/event-view-window.png)



![Add counters to the connector with the Performance Monitor](media/application-proxy-connectors/performance-monitor.png)

The connectors have both **Admin** and **Session** logs. The **Admin** log includes key events and their errors. The **Session** log includes all the transactions and their processing details.

To see the logs, open **Event Viewer** and go to **Applications and Services Logs** > **Microsoft** > **AadApplicationProxy** > **Connector**. To make the **Session** log visible, on the **View** menu, select **Show Analytic and Debug Logs**. The **Session** log is typically used for troubleshooting, and is disabled by default. Enable it to start collecting events and disable it when it's no longer needed.

You can examine the state of the service in the Services window. The connector is made up of two Windows Services: the actual connector, and the updater. Both of them must run all the time.

 ![Example: Services window showing Microsoft Entra services local](media/application-proxy-connectors/aad-connector-services.png)

## Next steps

- [Publish applications on separate networks and locations using connector groups](application-proxy-connector-groups.md)
- [Work with existing on-premises proxy servers](application-proxy-configure-connectors-with-proxy-servers.md)
- [Troubleshoot application proxy and connector errors](application-proxy-troubleshoot.md)
- [How to silently install the Microsoft Entra application proxy connector](application-proxy-register-connector-powershell.md)

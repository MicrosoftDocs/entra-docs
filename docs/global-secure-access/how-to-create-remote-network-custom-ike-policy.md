---
title: How to create a remote network with a customer IKE policy for Global Secure Access (preview)
description: Learn how to create a remote network with a customer IKE policy for Global Secure Access (preview).
author: shlipsey3
ms.author: sarahlipsey
manager: amycolannino
ms.topic: how-to
ms.date: 06/08/2023
ms.service: network-access
ms.custom: 

---
# Create a remote network with a customer IKE policy for Global Secure Access (preview)

IPSec tunnel is a bidirectional communication. This article provides the steps to set up the communication channel in MIcrosoft Entra admin center and the Microsoft Graph API. The other side of the communication is configured on your customer premises equipment. 

## Prerequisites

To create a remote network with a custom IKE policy, you must have:

- A **Global Secure Access Administrator** role in Microsoft Entra ID.
- Sent an email to Global Secure Access onboarding team according to the [onboarding process](how-to-create-remote-networks.md#onboard-your-tenant-for-remote-networks).
- Received the connectivity information from Global Secure Access onboarding.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

# [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access (preview)** > **Devices** > **Remote network**.
1. Select the **Create remote network** button and provide the following details:
    - **Name**
    - **Region**
1. Select the **Next** button.
1. Select the **+ Add a link** button.

**General**

1. Enter the following details:
    - **Link name**: Name of your CPE.
    - **Device type**: Choose one of the options from the dropdown list.
    - **IP address**: Public IP address of your device.
    - **Peer BGP address**: Enter BGP IP address of your CPE (customer premise equipment). Enter this address as the local BGP IP address on the CPE (who the peer vs. local is changes depending on  where the configuration is done).
    - **Local BGP address**: Enter a BGP IP address that is *not* part of your on-premises network where your CPE (customer premise equipment) resides. Suppose your on-premises network is 10.1.0.0/16, then you can use 10.2.0.4 as your Local BGP address. Enter this address as the peer BGP​​ IP address on your CPE (who the peer vs. local is changes depending on  where the configuration is done). 
    - **Link ASN**: Provide the autonomous system number of the CPE.  A BGP-enabled connection between two network gateways requires that they have different autonomous system numbers (ASNs). For more information, see the **Valid ASNs** section of the [Remote network configurations](reference-remote-network-configurations.md) article.
    - **Redundancy**: Select either *No redundancy* or *Zone redundancy* for your IPSec tunnel.
    - **Zone redundant local BGP address**: This is an optional field that shows up only when you select **Zone redundancy**. Enter a BGP IP address that is *not* part of your on-premises network where your CPE (customer premise equipment) resides and different from **Local BGP address**.
    - **Bandwidth capacity (Mbps)**: Specify tunnel bandwidth. Available options are 250, 500, 750, and 1000 Mbps.
1. Select the **Next** button.

**Details**

1. **IKEv2** is selected by default. Currently only IKEv2 is supported.
1. Change the IPSec/IKE policy to **Custom**.
    - Choose **Encryption**, **IKEv2 integrity** and **DHGroup** under IKE phase 1. You can choose any options from the dropdowns. Avilable options are listed here - [Remote network valid configurations](reference-remote-network-configurations.md).
    - Choose **IPsec encryption**, **IPsec integrity**, **PFS group** and **SA lifetime (seconds)** under IKE phase 2. Make sure your selection of  **IPsec encryption** and **IPsec integrity** aligns with combination documented here - [Remote network valid configurations](reference-remote-network-configurations.md).
3. Whether you choose Default or Custom, the IPSec/IKE policy you specify must match the crypto policy on your CPE.
4. Select the **Next** button.

![Screenshot of the custom details for the device link.](media/how-to-manage-remote-network-device-links/device-link-details.png)

**Security**

1. Enter the Preshared key (PSK). The same secret key must be used on your CPE.
1. Select **Add link**.

# [Microsoft Graph API](#tab/microsoft-graph-api) 

Remote networks with a custom IKE policy can be created using Microsoft Graph on the `/beta` endpoint.

To get started, follow these instructions to work with remote networks using the Microsoft Graph API in Graph Explorer. 

1. Sign in to [Graph Explorer](https://aka.ms/ge).
1. Select **POST** as the HTTP method from the dropdown.
1. Set the API version to **beta**.
1. Add the following query, then select the **Run query** button.

```http
    POST https://graph.microsoft.com/beta/networkaccess/connectivity/branches
{
    "name": "BranchOffice_CustomIKE",
    "region": "eastUS", 
    "deviceLinks": [
        {
            "name": "custom link",
            "ipAddress": "114.20.4.14",
            "deviceVendor": "ciscoMeraki",
            "tunnelConfiguration": {
                "saLifeTimeSeconds": 300,
                "ipSecEncryption": "gcmAes128",
                "ipSecIntegrity": "gcmAes128",
                "ikeEncryption": "aes128",
                "ikeIntegrity": "sha256",
                "dhGroup": "ecp384",
                "pfsGroup": "ecp384",
                "@odata.type": "#microsoft.graph.networkaccess.tunnelConfigurationIKEv2Custom",
                "preSharedKey": "SHAREDKEY"
            },
            "bgpConfiguration": {
                "localIpAddress": "10.1.1.11",
                "peerIpAddress": "10.6.6.6",
                "asn": 65000
            },
            "redundancyConfiguration": {
                "redundancyTier": "zoneRedundancy",
                "zoneLocalIpAddress": "10.1.1.12"
            },
            "bandwidthCapacityInMbps": "mbps250"
        }
    ]
}
```

[!INCLUDE [Public preview important note](./includes/public-preview-important-note.md)]

## Next steps

- [How to manage remote networks](how-to-manage-remote-networks.md)
- [How to manage remote network device links](how-to-manage-remote-network-device-links.md)

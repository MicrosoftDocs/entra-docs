---
title: Global Secure Access cloud firewall with remote networks for internet access
description: Learn how to configure and use GSA Cloud Firewall to protect against unauthorized internet access from branch offices using Remote Networks for Internet Access.
author: jenniferf-skc    
ms.author: jfields
manager: pmwongera
ms.topic: how-to
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.date: 11/18/2025
ms.custom: it-pro
ms.reviewer: shkhalid
---

# Global Secure Access cloud firewall with remote networks 

GSA Cloud Firewall (CFW) protects customers from unauthorized egress access (like connections to the Internet) by applying policies on network traffic, providing centralized management, visibility, and consistent policies for branches and roaming users that use managed devices (with GSA clients). 

The current scope of this preview is using GSA Cloud Firewall to enforce policies on Internet traffic from branch offices using Remote Networks for Internet Access (also in public preview).

With this preview, you'll be able to:

- Define granular Firewall filtering rules, where you'll define the traffic matching conditions and an action in case the traffic matches.

- Define five tuple rules based on source IP, source Port, destination IP, destination Port, and destination Protocol (TCP, UDP).

- Define and enforce an action between **Allow** and **Block**.

## Prerequisites

- Fully configured remote networks for Internet Access. 

## Available scenarios

In this public preview, these scenarios are supported:

<table>
<colgroup>
<col style="width: 4%" />
<col style="width: 95%" />
</colgroup>
<thead>
<tr>
<th>#</th>
<th><strong>Scenario</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td><p>Admin can create a cloud firewall policy with default Allow action (can't be changed).</p>
<p>The default action is applied to all traffic that does not match any of the rules in the policy.</p></td>
</tr>
<tr>
<td>2</td>
<td><p>Admin can add/update rules in a cloud firewall policy and assign priorities to each rule.</p>
<p>Rule Matching conditions: In each of these rules, admin can define these traffic matching conditions: source IPv4, source Port, destination IPv4, destination Port, and Protocol (TCP, UDP or both).</p>
<p>Action: Action for each rule can be set to **Allow** or **Block**.</p></td>
</tr>
<tr>
<td>3</td>
<td>Admin can enable or disable an individual cloud firewall policy rule.</td>
</tr>
<tr>
<td>4</td>
<td>Admin can delete an individual cloud firewall policy rule.</td>
</tr>
<tr>
<td>5</td>
<td>Admin can link a cloud firewall policy to the baseline profile for the remote network.</td>
</tr>
<tr>
<td>6</td>
<td>Admin can enable or disable the linked firewall policy to the baseline profile (security profile with priority=65000)</td>
</tr>
<tr>
<td>7</td>
<td>Admin can delete the linked firewall policy with the baseline profile and link another one.</td>
</tr>
</tbody>
</table>

## Scenario configuration steps

### Create a cloud firewall policy with the default **Allow** action.

1. Login to [Entra admin center](https://entra.microsoft.com/?Microsoft_Azure_Network_Access_isCloudFirewallPolicyEnabled=true&exp.isCloudFirewallPolicyEnabled=true#view/Microsoft_Azure_Network_Access/CloudFirewallPolicy.ReactView).

1. Browse to **Global Secure Access 🡪 Secure 🡪 Cloud firewall policies 🡪 Create firewall policy.**

1. Provide a **Name** and **Description**, then click **Create**.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/create-cloud-firewall-policy.png" alt-text="Screenshot showing the Create firewall policy page in the Entra admin center" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/create-cloud-firewall-policy.png":::

### Add or update a cloud firewall rule, assign priority and enable or disable

1. Click on the created firewall policy in the previous step.

1. Under **Rules**, select **Add** rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules.png" alt-text="Screenshot showing the Add rule option in the cloud firewall policy" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules.png":::

1. Configure the 5-tuple rule:

   1. Provide Name/Description.

   1. Assign a priority to the rule relevant to other rules in this policy.

   1. Select Rule status to **Enable/Disable**.

   1. Configure source and destination matching conditions. Please note these important limitations:

      - IPs can be defined as IPs or CIDRs. IP ranges aren't supported currently.

      - Destination FQDN isn't supported currently so we recommend keeping it at the **Not set** value (default).

      - Once the value is set, you can't restore it to the initial not-set state. As a workaround, you can delete and recreate the rule.

   1. Select Action to Allow or Block.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/select-action.png" alt-text="Screenshot showing the cloud firewall rule configuration page" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/select-action.png":::

   > [!NOTE]
   > In the rule, source IP, source port, destination IP, destination port, and protocol are logically AND.
   >
   > For instance, you configure a rule as below:
   >
   > - Source IP = 10.0.0.5
   > - Source Port = 12345
   > - Destination IP = 192.168.1.20
   > - Destination Port = 443
   > - Protocol = TCP
   >
   > This firewall rule matches traffic that simultaneously meets the conditions for source IP, source Port, destination Port, destination IP and Protocol.

1. (Optional) Update any values in the rule and save them.

### Delete a cloud firewall rule

1. Use the trash bin icon under the **Actions** column to permanently delete any rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules-2.png" alt-text="Screenshot showing the delete option for cloud firewall rules" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules-2.png":::

   > [!TIP]
   > You can also disable the rule if you intend to use the rule in the future rather than deleting it.

### Link a cloud firewall policy to the baseline profile for the remote network

> [!IMPORTANT]
> As a best practice, we recommend creating rules in the policy first before linking the policy to the baseline profile. This ensures all changes apply collectively. This is particularly important if you create a "block all" rule for the entire branch traffic and then add rules to allow certain traffic. Without following this best practice, you might inadvertently block yourself for all branch traffic.

1. In your Entra admin center, browse to **Global Secure Access > Secure > Security Profiles > Baseline Profile**.

   :::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image5.png" alt-text="Screenshot showing the navigation to Security Profiles":::

1. Click on Edit Profile and then select Link policy to an existing cloud firewall policy you have created.

   :::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image6.png" alt-text="Screenshot showing the Link policy option":::

### Enable or disable the linked firewall policy to the baseline profile

1. Use the pencil icon to change the status of a linked firewall policy from enabled to disabled or vice versa.

   :::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image7.png" alt-text="Screenshot showing the enable/disable option for linked firewall policy":::

### Delete the linked firewall policy and link to another one

1. Use the trash bin icon to permanently delete any rule and then link to another policy.

   :::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image8.png" alt-text="Screenshot showing the delete linked policy option":::

   :::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image9.png" alt-text="Screenshot showing the confirmation dialog for deleting linked policy":::

## Known limitations

- Destination FQDN is not supported in the cloud firewall rule.

- Traffic logs from Entra/GSA portal for cloud firewall are not available currently.

- It may take up to 15-20 minutes for any firewall policy updates to take effect.

- Remote networks acquire all Internet traffic except IP ranges for accessing the GSA service edge and IP ranges for Internet Access default bypass policy (please see the public preview document for Remote networks for Internet Access for these ranges). Currently IP ranges in M365 traffic profile including Entra traffic are acquired. To ensure M365 traffic is not blocked when you configure a block all rule to Internet traffic, please configure an allow rule for M365 traffic with a higher priority than the deny all rule using the traffic ranges:  
  
  132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19.



[def]: iority and enable or disable
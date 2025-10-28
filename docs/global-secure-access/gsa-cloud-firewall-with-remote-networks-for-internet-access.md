---
title: Global Secure Access cloud firewall with remote networks for internet access
description: Learn how to configure and use GSA Cloud Firewall to protect against unauthorized internet access from branch offices using Remote Networks for Internet Access.
author: jenniferf-skc    
ms.author: jfields
manager: pmwongera
ms.topic: how-to
ms.service: global-secure-access
ms.subservice: entra-private-access
ms.date: 11/07/2025
ms.custom: it-pro
ms.reviewer: shkhalid
---

# Global Secure Access cloud firewall with remote networks 

GSA Cloud Firewall (CFW) can protect customers from unauthorized egress access (like connections to the Internet) by applying policies on network traffic, providing centralized management, visibility, and consistent policies for branches and roaming users that use managed devices (with GSA clients). <u>The current scope of this public preview is using GSA Cloud Firewall to enforce policies on Internet traffic from branch offices using Remote Networks for Internet Access (also in public preview).</u>

With this public preview, you will be able to:

- Define granular Firewall filtering rules, where you will define the traffic matching conditions and an action in case the traffic matches.

- Define five tuple rules based on source IP, source Port, destination IP, destination Port, and destination Protocol (TCP, UDP).

- Define and enforce an action between Allow and Block.

Goals of the preview

The goals of the of this public preview are:

- Validate the capabilities and scenarios below and that these satisfy your core requirements and are ready for production use. 

- Gather feedback on this preview and any related use cases. Once you've tested this feature, please share your feedback with the Microsoft team.

Pre-requisites

- Fully configured remote networks for Internet Access. If not, please onboard and configure using the .

- Cloud firewall is now available in public preview. No enrollment form is required.

What is in this preview?

In this public preview, these scenarios will be supported:

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
<p>Action: Action for each rule can be set to Allow or Block.</p></td>
</tr>
<tr>
<td>3</td>
<td>Admin can enable or disable individual cloud firewall policy rule.</td>
</tr>
<tr>
<td>4</td>
<td>Admin can delete individual cloud firewall policy rule.</td>
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

Configuration Steps

S1: Admin can create a cloud firewall policy with default Allow Action

1\. Login to Entra Admin Center using this [link](https://entra.microsoft.com/?Microsoft_Azure_Network_Access_isCloudFirewallPolicyEnabled=true&exp.isCloudFirewallPolicyEnabled=true#view/Microsoft_Azure_Network_Access/CloudFirewallPolicy.ReactView).

2\. From the left nav menu, navigate to **Global Secure Access 🡪 Secure 🡪 Cloud firewall policies 🡪 Create firewall policy.**

> **a.** Provide Name and description and click create.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image1.png" alt-text="":::

S2-3: Admin can add/update a cloud firewall rule, assign priority and enable or disable

1\. Click on the created firewall policy in the previous step.

2\. Under Rules, select Add rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image2.png" alt-text="":::

3\. Configure the 5-tuple rule:

1.  Provide Name/Description.

2.  Assign a priority to the rule relevant to other rules in this policy.

3.  Select Rule status to Enable/Disable.

4.  Configure source and destination matching conditions. Please note these important limitations:

    1.  IPs can be defined as IPs or CIDRs. IP ranges are not supported currently.

    2.  Destination FQDN is not supported currently so recommend keeping it at Not set value (default).

    3.  Once the value is set, you can't restore it to the initial not-set state. As a workaround you can delete and recreate the rule.

5.  Select Action to Allow or Block.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image3.png" alt-text="":::

Please note that in the rule, source IP, source port, destination IP, destination port, and protocol) are logically AND.

For instance, you configure a rule as below:

- Source IP = 10.0.0.5

- Source Port = 12345

- Destination IP = 192.168.1.20

- Destination Port = 443

- Protocol = TCP

This firewall rule will match traffic that simultaneously meets the conditions for source IP, source Port, destination Port, destination IP and Protocol.

4\. You can update any values in the rule and save them.

S4: Admin can delete a cloud firewall rule

Use the trash bin icon under Actions column to permanently delete any rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image4.png" alt-text="":::

You can also disable the rule shown in previous scenario S2a if you intend to use the rule in the future rather than deleting it.

S5: Admin can link a cloud firewall policy to the baseline profile for the remote network.

**Important:**

***As a best practice, we recommend creating rules in the policy first before linking the policy to the baseline profile. This will ensure all changes apply collectively. This is particularly important if you create a "block all" rule for the entire branch traffic and then add rules to allow certain traffic. Without following this best practice, you might inadvertently block yourself for all branch traffic.***

1\. From the left nav menu, navigate to **Global Secure Access 🡪 Secure 🡪 Security Profiles 🡪 Baseline Profile**

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image5.png" alt-text="":::

2\. Click on Edit Profile and then select Link policy to an existing cloud firewall policy you have created in S1.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image6.png" alt-text="":::

S6: Admin can enable or disable the linked firewall policy to the baseline profile.

Use the pencil icon to change the status of a linked firewall policy from enabled to disabled or vice versa.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image7.png" alt-text="":::

S7: Admin can delete the linked firewall policy with the baseline profile and link to another one.

Use the trash bin icon to permanently delete any rule and then link to another policy.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image8.png" alt-text="":::

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/image9.png" alt-text="":::

Known Limitations

1\. Destination FQDN is not supported in the cloud firewall rule.

~~2. IP ranges in source or destination matching conditions in the cloud firewall rule is not supported. You can provide comma separated IPs or CIDRs.~~

~~3. Once the value is set in the rule, you can't restore it to the initial not-set state in the source and destination matching conditions. As a workaround you can delete and recreate the rule.~~

4\. Traffic logs from Entra/GSA portal for cloud firewall are not available currently.

5\. It may take up to 15-20 minutes for any firewall policy updates to take effect.

6\. Remote networks acquire all Internet traffic except IP ranges for accessing the GSA service edge and IP ranges for Internet Access default bypass policy (please see the public preview document for Remote networks for Internet Access for these ranges). Currently IP ranges in M365 traffic profile including Entra traffic are acquired. To ensure M365 traffic is not blocked when you configure a block all rule to Internet traffic, please configure an allow rule for M365 traffic with a higher priority than the deny all rule using the traffic ranges:  
  
132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19.


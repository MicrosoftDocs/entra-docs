---
title: Configure Global Secure Access cloud firewall with remote networks for internet access
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
ai-usage: ai-assisted

#customer intent: As a Global Secure Access administrator, I want to learn how to configure and use GSA Cloud Firewall to protect against unauthorized internet access from branch offices using Remote Networks for Internet Access.
---

# Configure Global Secure Access cloud firewall with remote networks for Internet access (Preview)

GSA Cloud Firewall (CFW) protects customers from unauthorized egress access (like connections to the Internet) by applying policies on network traffic, providing centralized management, visibility, and consistent policies for branches and roaming users that use managed devices (with GSA clients). 

The current scope of this preview is using GSA Cloud Firewall to enforce policies on Internet traffic from branch offices using Remote Networks for Internet Access (also in public preview).

With this preview, you'll be able to:

- Define granular Firewall filtering rules, where you'll define the traffic matching conditions and an action in case the traffic matches.

- Define five tuple rules based on source IP, source Port, destination IP, destination Port, and destination Protocol (TCP, UDP).

- Define and enforce an action between **Allow** and **Block**.

## Prerequisites

- You must have fully configured remote networks for Internet Access. 

## Supported scenarios

This public preview supports these scenarios:

| # | **Scenario** |
|---|--------------|
| 1 | Admin can create a cloud firewall policy with default Allow action (can't be changed).<br><br>The default action is applied to all traffic that does not match any of the rules in the policy. |
| 2 | Admin can add/update rules in a cloud firewall policy and assign priorities to each rule.<br><br>Rule Matching conditions: In each of these rules, admin can define these traffic matching conditions: source IPv4, source Port, destination IPv4, destination Port, and Protocol (TCP, UDP or both).<br><br>The action for each rule can be set to **Allow** or **Block**. |
| 3 | Admin can enable or disable an individual cloud firewall policy rule. |
| 4 | Admin can delete an individual cloud firewall policy rule. |
| 5 | Admin can link a cloud firewall policy to the baseline profile for the remote network. |
| 6 | Admin can enable or disable the linked firewall policy to the baseline profile (security profile with priority=65000) |
| 7 | Admin can delete the linked firewall policy with the baseline profile and link another one. |

## Scenario configuration steps

### Create a cloud firewall policy with the default **Allow** action.

1. Login to your [Entra admin center](https://entra.microsoft.com/?Microsoft_Azure_Network_Access_isCloudFirewallPolicyEnabled=true&exp.isCloudFirewallPolicyEnabled=true#view/Microsoft_Azure_Network_Access/CloudFirewallPolicy.ReactView).

1. Browse to **Global Secure Access 🡪 Secure 🡪 Cloud firewall policies 🡪 Create firewall policy.**

1. Provide a **Name** and **Description**, then click **Create**.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/create-cloud-firewall-policy.png" alt-text="Screenshot showing the Create firewall policy page in the Entra admin center" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/create-cloud-firewall-policy.png":::

### Add or update a cloud firewall rule, assign priority and enable or disable

1. Click on the created firewall policy in the previous step.

1. Under **Rules**, select **Add** rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules.png" alt-text="Screenshot showing the Add rule option in the cloud firewall policy" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules.png":::

3. Configure the 5-tuple rule:

   1. Provide a **Name** and **Description**.

   1. Assign a priority to the rule relevant to other rules in this policy.

   1. Select Rule settings **Status** to set to **Enable** or **Disable**.

   1. Configure the source and destination matching conditions. Please note these important limitations:

      - IPs can be defined as IPs or CIDRs. IP ranges aren't supported currently.

      - Destination FQDN isn't supported currently so we recommend keeping it at the **Not set** value (default).

      - Once the value is set, you can't restore it to the initial not-set state. As a workaround, you can delete and recreate the rule.

   1. Set the **Action** to **Allow** or **Block**.

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

4. (Optional) Update any values in the rule and save them.

### Delete a cloud firewall rule

1. Use the trash bin icon under the **Actions** column to permanently delete any rule.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules-2.png" alt-text="Screenshot showing the delete option for cloud firewall rules" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-rules-2.png":::

   > [!TIP]
   > You can also disable the rule if you intend to use the rule in the future rather than deleting it.

### Link a cloud firewall policy to the baseline profile for the remote network

> [!IMPORTANT]
> As a best practice, we recommend creating rules in the policy first before linking the policy to the baseline profile. This ensures all changes apply collectively. This is particularly important if you create a "block all" rule for the entire branch traffic and then add rules to allow certain traffic. Without following this best practice, you might inadvertently block yourself for all branch traffic.

1. In your Entra admin center, browse to **Global Secure Access > Secure > Security Profiles > Baseline Profile**.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/security-baseline-profile.png" alt-text="Screenshot showing the navigation to Security Profiles" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/security-baseline-profile.png":::

1. Click on **Edit profile**, then select **Link policy** to link an existing cloud firewall policy.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-baseline-policy-link-policies.png" alt-text="Screenshot showing the Link policy option" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/edit-baseline-policy-link-policies.png":::

### Enable or disable the linked firewall policy to the baseline profile

1. Use the pencil icon to change the State of a linked firewall policy from **enabled** to **disabled** or vice versa.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/link-policy-status.png" alt-text="Screenshot showing the enable/disable option for linked firewall policy" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/link-policy-status.png":::

### Delete the linked firewall policy and link to another one

1. Use the trash bin icon to permanently delete any rule. 
1. Navigate to the **Link a policy** section to link to another policy.

:::image type="content" source="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/link-a-policy.png" alt-text="Screenshot showing the confirmation dialog for deleting linked policy" lightbox="media/gsa-cloud-firewall-with-remote-networks-for-internet-access/link-a-policy.png":::

## Known limitations

- The destination FQDN isn't supported in the cloud firewall rule.

- Traffic logs from the Entra ID/GSA portal for cloud firewall aren't currently available.

- It may take up to 15-20 minutes for any firewall policy updates to take effect.

- Remote networks acquire all Internet traffic except IP ranges for accessing the GSA service edge and IP ranges for Internet Access default bypass policy (please see the public preview document for Remote networks for Internet Access for these ranges). Currently IP ranges in Microsoft 365 (M365) traffic profile, including Entra ID traffic, are acquired. To ensure M365 traffic isn't blocked when you configure a block-all rule to Internet traffic, please configure an allow rule for M365 traffic with a higher priority than the deny-all rule using the traffic ranges:  
  
  132.245.0.0/16, 204.79.197.215/32, 150.171.32.0/22, 131.253.33.215/32, 23.103.160.0/20, 40.96.0.0/13, 52.96.0.0/14, 40.104.0.0/15, 13.107.128.0/22, 13.107.18.10/31, 13.107.6.152/31, 52.238.78.88/32, 104.47.0.0/17, 52.100.0.0/14, 40.107.0.0/16, 40.92.0.0/15, 150.171.40.0/22, 52.104.0.0/14, 104.146.128.0/17, 40.108.128.0/17, 13.107.136.0/22, 40.126.0.0/18, 20.231.128.0/19, 20.190.128.0/18, 20.20.32.0/19.

## Next steps
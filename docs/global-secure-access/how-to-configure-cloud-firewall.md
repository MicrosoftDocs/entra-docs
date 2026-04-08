---
title: Configure Global Secure Access cloud firewall with remote networks for internet access
description: Learn how to configure and use GSA Cloud Firewall to protect against unauthorized internet access from branch offices using Remote Networks for Internet Access.
author: jenniferf-skc    
ms.author: jfields
ms.topic: how-to
ms.subservice: entra-private-access
ms.date: 11/18/2025
ms.custom: it-pro
ms.reviewer: shkhalid
ai-usage: ai-assisted

#customer intent: As a Global Secure Access administrator, I want to learn how to configure and use GSA Cloud Firewall to protect against unauthorized internet access from branch offices using Remote Networks for Internet Access.
---

# Configure Global Secure Access cloud firewall (preview)

Global Secure Access (GSA) Cloud Firewall (CFW) protects customers from unauthorized egress access by applying policies on network traffic. Cloud firewall provides centralized management, visibility, and consistent policies for branches. 

The current scope of this preview is using GSA Cloud Firewall to enforce policies on Internet traffic from branch offices using Remote Networks for Internet Access (also in preview).

With this preview, you can:

- Define granular Firewall filtering rules, where you'll define the traffic matching conditions and an action in case the traffic matches.

- Define 5-tuple rules based on source IP, source Port, destination IP, destination Port, and destination Protocol (TCP, UDP).

- Define and enforce an action between **Allow** and **Block**.

## Prerequisites

- Configure [remote networks for internet access](how-to-create-remote-networks.md). 

## Supported scenarios

This preview supports these scenarios:

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

1. Sign in to your [Entra admin center](https://entra.microsoft.com/?Microsoft_Azure_Network_Access_isCloudFirewallPolicyEnabled=true&exp.isCloudFirewallPolicyEnabled=true#view/Microsoft_Azure_Network_Access/CloudFirewallPolicy.ReactView).

1. Browse to **Global Secure Access 🡪 Secure 🡪 Cloud firewall policies 🡪 Create firewall policy.**

1. Under the **Basics** tab, provide a **Name** and **Description**, then click **Next >**.
1. Under **Policy settings**, make sure the Default Action is set to **Allow**, then click **Next >**.
1. Under **Review and create**, review the information you've provided, then click **Create**.

:::image type="content" source="media/how-to-configure-cloud-firewall/create-cloud-firewall-policy.png" alt-text="Screenshot showing the Create firewall policy page in the Entra admin center." lightbox="media/how-to-configure-cloud-firewall/create-cloud-firewall-policy.png":::

### Add or update a cloud firewall rule, assign priority and enable or disable

1. Click on the created firewall policy in the previous step.

1. Under **Rules**, select **+ Add rule**.

:::image type="content" source="media/how-to-configure-cloud-firewall/edit-rules.png" alt-text="Screenshot showing the Add rule option in the cloud firewall policy." lightbox="media/how-to-configure-cloud-firewall/edit-rules.png":::

3. Configure the 5-tuple rule:

   1. Provide a **Name** and **Description**.

   1. Assign a priority to the rule relevant to other rules in this policy. Rule priority must be greater than or equal to 100 and should be unique within the policy. Lower value means higher priority.

   1. Select Rule settings **Status** to set to **Enable** or **Disable**. Default status is disabled and starting the rule with disabled status is recommended until ready to enforce. 

   1. Configure the source and destination matching conditions. Note these important limitations:

      - IPs are defined as IPs, IP ranges, or Classless Inter-Domain Routings (CIDRs).

      - Destination Fully Qualified Domain Names (FQDNs) aren't supported currently so we recommend keeping it at the **Not set** value (default).

   1. Set the **Action** to **Allow** or **Block**.

:::image type="content" source="media/how-to-configure-cloud-firewall/select-action.png" alt-text="Screenshot showing the cloud firewall rule configuration page." lightbox="media/how-to-configure-cloud-firewall/select-action.png":::

   > [!NOTE]
   > In the rule, source IP, source port, destination IP, destination port, and protocol are logically AND.
   >
   > For instance, you configure a rule as shown here:
   >
   > - Source IP = 10.0.0.5
   > - Source Port = 12345
   > - Destination IP = 192.168.1.20
   > - Destination Port = 443
   > - Protocol = TCP
   >
   > This firewall rule matches traffic that simultaneously meets the conditions for source IP, source Port, destination Port, destination IP, and Protocol. Not set values (default) in source and destination matching conditions are ignored. 

4. (Optional) Update any values in the rule and save them.

### Delete a cloud firewall rule

1. Use the trash bin icon under the **Actions** column to permanently delete any rule.

:::image type="content" source="media/how-to-configure-cloud-firewall/edit-rules-2.png" alt-text="Screenshot showing the delete option for cloud firewall rules." lightbox="media/how-to-configure-cloud-firewall/edit-rules-2.png":::

   > [!TIP]
   > You can also disable the rule if you intend to use the rule in the future rather than deleting it.

### Link a cloud firewall policy to the baseline profile for the remote network

> [!IMPORTANT]
> As a best practice, we recommend creating rules in the policy first before linking the policy to the baseline profile. Creating rules in the policy ensures all changes apply collectively. Ensuring collective changes is important if you create a "block-all" rule for the entire branch traffic, then add rules to allow certain traffic. Without following this best practice, you might inadvertently block yourself for all branch traffic.

1. In your [Entra admin center](https://entra.microsoft.com/?Microsoft_Azure_Network_Access_isCloudFirewallPolicyEnabled=true&exp.isCloudFirewallPolicyEnabled=true#view/Microsoft_Azure_Network_Access/CloudFirewallPolicy.ReactView), browse to **Global Secure Access > Secure > Security Profiles > Baseline Profile**.

:::image type="content" source="media/how-to-configure-cloud-firewall/security-baseline-profile.png" alt-text="Screenshot showing the navigation to Security Profiles." lightbox="media/how-to-configure-cloud-firewall/security-baseline-profile.png":::

2. Click on **Edit profile**, then select **Link policies > + Link a policy** to link an existing cloud firewall policy.

:::image type="content" source="media/how-to-configure-cloud-firewall/edit-baseline-policy-link-policies.png" alt-text="Screenshot showing the Link policy option." lightbox="media/how-to-configure-cloud-firewall/edit-baseline-policy-link-policies.png":::

Only one cloud firewall policy can be linked to a baseline profile. Linking a cloud firewall policy to a security profile other than the baseline profile won’t have any effect.

### Enable or disable the linked firewall policy to the baseline profile

1. Use the pencil icon to change the State of a linked firewall policy from **enabled** to **disabled** or vice versa.

:::image type="content" source="media/how-to-configure-cloud-firewall/edit-baseline-policy.png" alt-text="Screenshot showing the enable/disable option for linked firewall policy." lightbox="media/how-to-configure-cloud-firewall/edit-baseline-policy.png":::

### Delete the linked firewall policy and link to another one

1. Use the trash bin icon to permanently delete any policy. 
1. Navigate to **+ Link a policy** to link to another policy.

## Known limitations

- The destination FQDN isn't supported in the cloud firewall rule.

- It may take 15-20 minutes for any firewall policy updates to take effect.

- Cloud firewall capability isn't currently supported with Global Secure Access clients. 

## Next steps

[How to use the Global Secure Access traffic logs](how-to-view-traffic-logs.md)
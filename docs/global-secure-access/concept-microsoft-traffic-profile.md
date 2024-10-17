---
title: Learn about the Microsoft Traffic Profile.
description: Learn about the capabilites and traffic handling in the Microsoft traffic profile
author: alexpav
ms.author: alexpav
manager: sineado
ms.topic: conceptual
ms.date: 10/11/2024
ms.service: global-secure-access
ms.reviewer: katabish
---

# Microsoft traffic profile overview
 
Microsoft traffic profile ensures the best performance characteristics for supported services and simplifies the configuration of rules governing traffic acquisition. Preconfigured fully qualified domain names (FQDNs) and IP ranges that are nessessary for Microsoft services to function enable you define traffic acquisition behavior based on the Microsoft services that your organization is using. 

## Traffic forwarding in the Microsoft traffic profile

A traffic forwarding rules includes the Destination Type (IP or FQDN), Destination (specific FQDNs or IP ranges), Protocol (TCP or UDP), Ports, Traffic Category, and Action. Microsoft traffic profile derives the traffic forwarding rules from the Microsoft 365 IP and FQDN list (https://aka.ms/M365IPlist) and combines related services based on the traffic category. The traffic category details are described in https://learn.microsoft.com/en-us/microsoft-365/enterprise/microsoft-365-network-connectivity-principles?view=o365-worldwide#optimizing-connectivity-to-microsoft-365-services.

You can configure traffic aquisition behavior for each rule according to specific needs of your organization. Configuring the action to Forward will instruct the Global Secure Access client and Remote Networks to acquire traffic. Configuring the rule action to Bypass will instruct the Global Secure Access Client and Remote Networks to skip traffic acquisition for FQDNs and IP ranges in that rule.

[!IMPORTANT]
> When a rule is set to Bypass, the Internet Access traffic profile will not acquire this traffic. Even with the Internet Access profile enabled, the bypassed traffic will skip Global Secure Access acquisition and use that client's network routing path to egress to the Internet. Traffic available for acquisition in the Microsoft traffic profile can be only acquired in the Microsoft traffic profile.

Traffic rules are grouped based on the application type. You can enable or disable traffic acquisition for an entire group. When the group is enabled, you can control the behavior of individual rules separately. When the group is disabled, all traffic covered by the rules in that group is bypassed.

## Default traffic acquisition behavior

When you enable the Microsoft traffic profile, the rule list available to you is populated based on the supported traffic rules at the time of the traffic profile enablement. When we introduce a new rule, it will become visible in your configuration in the Forward mode in the Microsoft traffic profile, and in Bypass mode in the Internet Access profile.

[!NOTE]
> We will be adding coverage for more services to the Microsoft traffic profile in the future.


## Next steps

- [Manage the Microsoft traffic profile](how-to-manage-microsoft-profile.md)


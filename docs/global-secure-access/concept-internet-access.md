---
title: Learn about Microsoft Entra Internet Access
description: Learn about how Microsoft Entra Internet Access secures access to the Internet.
author: kenwith
ms.author: kenwith
manager: femila
ms.topic: conceptual
ms.date: 02/21/2025
ms.service: global-secure-access
ms.subservice: entra-internet-access 
ms.reviewer: frankgomulka

---

# Learn about Microsoft Entra Internet Access for all apps

Microsoft Entra Internet Access provides an identity-centric Secure Web Gateway (SWG) solution for Software as a Service (SaaS) applications and other Internet traffic. It protects users, devices, and data from the Internet's wide threat landscape with best-in-class security controls and visibility through Traffic Logs.

## Web content filtering

The key introductory feature for Microsoft Entra Internet Access for all apps is **Web content filtering**. This feature provides granular access control for web categories and Fully Qualified Domain Names (FQDNs). By explicitly blocking known inappropriate, malicious, or unsafe sites, you protect your users and their devices from any Internet connection whether they're remote or within the corporate network.

When traffic reaches Microsoft's Secure Service Edge, Microsoft Entra Internet Access performs security controls in two ways. For unencrypted HTTP traffic, it uses the Uniform Resource Locator (URL). For HTTPS traffic encrypted with Transport Layer Security (TLS), it uses the Server Name Indication (SNI).

Web content filtering is implemented using filtering policies, which are grouped into security profiles, which can be linked to Conditional Access policies. To learn more about Conditional Access, see [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/).

> [!NOTE]
> While web content filtering is a core capability for any Secure Web Gateway, similar capabilities exist in other security products, such as endpoint security products like [Microsoft Defender for Endpoint](/defender-endpoint/web-content-filtering/) and firewalls like [Azure Firewall](/azure/firewall/web-categories/). Microsoft Entra Internet Access provides additional security value via policy integration with Microsoft Entra ID, policy enforcement on the cloud edge, universal support for all device platforms, and future security enhancements through Transport Layer Security (TLS) Inspection, such as higher fidelity web categorization. Learn more in the [FAQ](resource-faq.yml).

## Security profiles

Security profiles are objects you use to group filtering policies and deliver them through user aware Conditional Access policies. For instance, to block all **News** websites except for `msn.com` for user `angie@contoso.com` you create two web filtering policies and add them to a security profile. You then take the security profile and link it to a Conditional Access policy assigned to `angie@contoso.com`.

```
"Security Profile for Angie"       <---- the security profile
    Allow msn.com at priority 100  <---- higher priority filtering policies
    Block News at priority 200     <---- lower priority filtering policy
```

## Policy processing logic
Within a security profile, policies are enforced according to logical ordering of unique priority numbers, with 100 being the highest priority and 65,000 being the lowest priority (similar to traditional firewall logic). As a best practice, add spacing of about 100 between priorities to allow for policy flexibility in the future.

Once you link a security profile to a Conditional Access policy, if multiple Conditional Access policies match, both security profiles are processed in priority ordering of the matching security profiles.

> [!IMPORTANT]
> The baseline security profile applies to all traffic even without linking it to a Conditional Access policy. It enforces policy at the lowest priority in the policy stack, applying to all Internet Access traffic routed through the service as a 'catch-all' policy. The baseline security profile executes even if a Conditional Access policy matches another security profile.

## Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Next steps

- [Configure Web content filtering](how-to-configure-web-content-filtering.md)

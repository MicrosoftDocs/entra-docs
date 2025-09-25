---
title: Microsoft Global Secure Access Proof-of-Concept Guidance - Configure Microsoft Entra Internet Access
description: Learn how to deploy and test Microsoft Global Secure Access as a proof of concept with Microsoft Entra Internet Access.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: concept-article
ms.date: 01/22/2025
ms.author: jricketts

#customer intent: As a Microsoft partner, I want to deploy and test Microsoft Global Secure Access for Microsoft Entra Internet Access as a proof of concept in my production or test environment.
---

# Microsoft Global Secure Access proof-of-concept guidance: Configure Microsoft Entra Internet Access

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance begins with [Introduction to Microsoft Global Secure Access proof-of-concept guidance](gsa-poc-guidance-intro.md), continues with [Configure Microsoft Entra Private Access](gsa-poc-private-access.md), and concludes with this article.

This article helps you to configure Microsoft Entra Internet Access to act as a secure web gateway. This solution enables you to configure policies for filtering web content to allow or block internet traffic. You can then group those policies into security profiles that you apply to your users through Conditional Access policies.

> [!NOTE]
> Apply rules and policies in [order of priority](../global-secure-access/concept-internet-access.md#policy-processing-logic). For detailed guidance, refer to [Policy processing logic](../global-secure-access/concept-internet-access.md#policy-processing-logic).

## Configure Microsoft Entra Internet Access

To configure Microsoft Entra Internet Access, see [How to configure Global Secure Access web content filtering](../global-secure-access/how-to-configure-web-content-filtering.md). It provides guidance to perform these high-level steps:

1. Enable internet traffic forwarding.
1. Create a policy for filtering web content.
1. Create a security profile.
1. Link the security profile to a Conditional Access policy.
1. Assign users or groups to the traffic forwarding profile.

## Configure use cases

Configure and test Microsoft Entra Internet Access use cases with web content filtering policies, security profiles, and Conditional Access policies. The following sections provide example use cases with specific guidance.

> [!NOTE]
> Microsoft doesn't currently support blocking and allowing URLs because it requires Transport Layer Security (TLS) inspection, which isn't yet available.

### Create a baseline profile that applies to all internet traffic routed through the service

Perform the following steps to use a [baseline profile](../global-secure-access/concept-internet-access.md#policy-processing-logic) to help secure all traffic in your environment without needing to apply Conditional Access policies:

1. [Create a policy for filtering web content](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to allow or block fully qualified domain names (FQDNs) or web categories across your user base. For example, create a rule that blocks the **Social Networking** category to block all social media sites.

1. Link the policy for filtering web content to the [baseline profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile). In the Microsoft Entra admin center, go to **Global Secure Access** > **Secure** > **Security profiles** > **Baseline profile**.

1. Sign in to your test device and try to access the blocked site.

1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** for your test user.

### Block a group from accessing websites based on category

1. [Create a policy for filtering web content](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to block a web category. For example, create a rule that blocks the **Social Networking** category to block all social media sites.

1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your policies. Link the policy for filtering web content to this profile.

1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to your users.

1. Sign in to your test device and try to access a blocked site. You should see **DeniedTraffic** for `http` websites and a **Can't reach this page** notification for `https` websites. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.

1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** for your test user.

### Block a group from accessing websites based on FQDN

1. [Create a policy for filtering web content](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to block an FQDN (not a URL).

1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your policies. Link the policy for filtering web content to this profile.

1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to your users.

1. Sign in to your test device and try to access the blocked FQDN. You should see **DeniedTraffic** for `http` websites and a **Can't reach this page** notification for `https` websites. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.

1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** for your test user.

### Allow a user to access a blocked website

1. [Create a policy for filtering web content](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes a rule to allow an FQDN.

1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your policies for filtering web content. Give this allowed profile a higher priority than the blocked profile. For example, if the blocked profile is set to priority 500, set the allowed profile to 400.

1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to the users who need access to the blocked FQDN.

1. Sign in to your test device and try to access the allowed FQDN. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.

1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that entries for your target FQDN show as allowed. If necessary, use **Add filter** to filter results on **User principal name** for your test user.

### Enable and manage the Microsoft traffic forwarding profile

The ability to help secure Microsoft traffic is a key feature of Microsoft Entra Internet Access. You can quickly deploy an automatically configured [Microsoft traffic profile](../global-secure-access/concept-microsoft-traffic-profile.md) that includes traffic forwarding rules. You can then use these rules to help secure and monitor Microsoft traffic (such as SharePoint Online and Exchange Online) and authentication traffic for any application that's integrated with Microsoft Entra ID. There are [known limitations](../global-secure-access/reference-current-known-limitations.md#access-controls-limitations).

1. [Enable the Microsoft traffic profile](../global-secure-access/how-to-manage-microsoft-profile.md).

1. Assign users and groups to the profile.

1. If desired, configure Conditional Access policies to enforce compliant network checks.

1. Sign in to your test device and try to access SharePoint Online and Exchange Online.

1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that Global Secure Access enabled access. Verify in the sign-in logs that **Through Global Secure Access** shows as **Yes**.

### Implement universal tenant restrictions

[Universal tenant restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md) enable you to control access to external tenants by unmanaged identities on company-managed devices and networks. You can enforce this restriction with Entra ID Tenant Restrictions, by either blocking or allowing all traffic to an external tenant.

This scenario usually requires that you send all of your traffic through a corporate network proxy. With Universal Tenant Restrictions, organizations can apply tenant restrictions policies to users on any device with the Global Secure Access client, without the need to implement VPN and send traffic through a specific proxy, reducing network latency.

After you enable the Microsoft traffic profile, follow these steps to implement universal tenant restrictions:

1. [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2). If your organization currently uses tenant restrictions v1, review the [guide for migrating to tenant restrictions v2](https://aka.ms/trv2migration).

1. [Enable Global Secure Access signaling for tenant restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md#enable-global-secure-access-signaling-for-tenant-restrictions).

1. Sign in to your test device and use a private browser window to sign in to any application that is protected by Entra ID in a different tenant, using member account credentials from that tenant.

1. [Validate Univeral Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md#validate-the-authentication-plane-protection).

## Troubleshoot

If you have problems with your PoC, these articles can help you with troubleshooting, logging, and monitoring:

- [Global Secure Access FAQ](../global-secure-access/resource-faq.yml)
- [Troubleshoot problems installing the Microsoft Entra private network connector](../global-secure-access/troubleshoot-connectors.md)
- [Troubleshoot the Global Secure Access client: Diagnostics](../global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access client: Health check tab](../global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check.md)
- [Troubleshoot a Distributed File System issue with Global Secure Access](../global-secure-access/troubleshoot-distributed-file-system.md)
- [Global Secure Access logs and monitoring](../global-secure-access/concept-global-secure-access-logs-monitoring.md)
- [How to use workbooks with Global Secure Access](../global-secure-access/how-to-use-workbooks.md)

## Related content

- [Introduction to Microsoft Global Secure Access proof-of-concept guidance](gsa-poc-guidance-intro.md)
- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Introduction to the Microsoft Global Secure Access deployment guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft traffic](gsa-deployment-guide-microsoft-traffic.md)

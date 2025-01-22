---
title: Microsoft Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Internet Access
description: Learn how to deploy and test Microsoft Global Secure Access with Microsoft Entra Internet Access.
customer intent: As a Microsoft Partner, I want to deploy Microsoft Global Secure Access for Microsoft Entra Internet Access as a Proof of Concept in my production or test environment.
author: jricketts
manager: martinco
ms.service: global-secure-access
ms.topic: conceptual
ms.date: 01/22/2025
ms.author: jricketts
---
# Microsoft Global Secure Access Proof of Concept Guidance - Configure Microsoft Entra Internet Access

The Proof of Concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Global Secure Access with Microsoft Entra Internet Access, Microsoft Entra Private Access, and the Microsoft traffic profile.

Detailed guidance begins in [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md), continues with [Configure Microsoft Entra Private Access](gsa-poc-private-access.md), and concludes with this article.

This article helps you to configure Microsoft Entra Internet Access to act as a secure web gateway. This solution allows you to configure web content filtering policies to allow or block internet traffic. You can then group those policies into security profiles that you apply to your users with Conditional Access policies.

>[!NOTE]
>Apply rules and policies in [order of priority](../global-secure-access/concept-internet-access.md#policy-processing-logic). For detailed guidance, refer to the [Policy processing logic](../global-secure-access/concept-internet-access.md#policy-processing-logic) section of [Learn about Microsoft Entra Internet Access](../global-secure-access/concept-internet-access.md).

## Microsoft Entra Internet Access configuration steps

To configure Microsoft Entra Internet Access, [How to configure Global Secure Access web content filtering](../global-secure-access/how-to-configure-web-content-filtering.md) provides guidance to perform these high level steps:

1. Enable internet traffic forwarding.
1. Create a web content filtering policy.
1. Create a security profile.
1. Link the security profile to a Conditional Access policy.
1. Assign users or groups to the traffic forwarding profile.

## Configure Microsoft Entra Internet Access use cases

Configure and test use cases with web content filtering policies, security profiles, and Conditional Access policies. Here are example use cases with specific guidance in linked sections:

- [Create a baseline policy applying to all internet access traffic routed through the service](#create-a-baseline-profile-applying-to-all-internet-access-traffic-routed-through-the-service)
- [Block a group from accessing websites based on category](#block-a-group-from-accessing-websites-based-on-category)
- [Block a group from accessing websites based on fully qualified domain name (FQDN)](#block-a-group-from-accessing-websites-based-on-fqdn)
- [Allow a user to access a blocked website](#allow-a-user-to-access-a-blocked-website)
- [Enable and manage the Microsoft traffic forwarding profile](#enable-and-manage-the-microsoft-traffic-forwarding-profile)
- [Implement Universal Tenant Restrictions](#implement-universal-tenant-restrictions)

>[!NOTE]
>Microsoft doesn't currently support blocking and allowing URLs because it requires Transport Layer Security (TLS) inspection, which isn't yet available.

### Create a baseline profile applying to all internet access traffic routed through the service

Perform the following steps to use a [baseline profile](../global-secure-access/concept-internet-access.md#policy-processing-logic) to secure all traffic in your environment without needing to apply Conditional Access policies.

1. [Create a web content filtering policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to allow or block fully qualified domain names (FQDN) or web categories across your user base. For example, create a rule that blocks the **Social Networking** category to block all social media sites.
1. Link the web content filtering policy to the [baseline profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile). In the Microsoft Entra admin center, navigate to **Global Secure Access** > **Secure** > **Security profiles** > **Baseline profile**.
1. Sign in to your test device and attempt to access the blocked site.
1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** of your test user.

### Block a group from accessing websites based on category

1. [Create a web content filtering policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to block a web category. For example, create a rule that blocks the **Social Networking** category to block all social media sites.
1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your web content filtering policies. Link the web content filtering policy to this profile.
1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to your users.
1. Sign in to your test device and attempt to access a blocked site. You should see **DeniedTraffic** for http websites and a **Can't reach this page** notification for https websites. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.
1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** of your test user.

### Block a group from accessing websites based on FQDN

1. [Create a web content filtering policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes rules to block an FQDN (not URL).
1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your web content filtering policies. Link the web content filtering policy to this profile.
1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to your users.
1. Sign in to your test device and attempt to access the blocked FQDN. You should see **DeniedTraffic** for http websites and a **Can't reach this page** notification for https websites. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.
1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm entries for your target FQDN show as blocked. If necessary, use **Add filter** to filter results on **User principal name** of your test user.

### Allow a user to access a blocked website

1. [Create a web content filtering policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-web-content-filtering-policy) that includes a rule to allow an FQDN.
1. [Create a security profile](../global-secure-access/how-to-configure-web-content-filtering.md#create-a-security-profile) to group and prioritize your web content filtering policies. Give this allowed profile a higher priority than the block profile. For example, if the block profile is set to priority 500, set the allowed profile to 400.
1. Create a [Conditional Access policy](../global-secure-access/how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) to apply the security profile to the users that you want to allow access to the blocked FQDN.
1. Sign in to your test device and attempt to access the allowed FQDN. It can take up to 90 minutes for a newly assigned policy to take effect. It can take up to 20 minutes for changes to an existing policy to take effect.
1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm entries for your target FQDN show as allowed. If necessary, use **Add filter** to filter results on **User principal name** of your test user.

### Enable and manage the Microsoft traffic forwarding profile

The ability to secure Microsoft traffic is a key feature of Microsoft Entra Internet Access. It enables you to quickly deploy an automatically configured [Microsoft traffic profile](../global-secure-access/concept-microsoft-traffic-profile.md) that includes traffic forwarding rules. These rules can allow you to secure and monitor Microsoft traffic (such as SharePoint Online and Exchange Online) and authentication traffic for any application integrated with Microsoft Entra ID. There are [known limitations](../global-secure-access/reference-current-known-limitations.md#access-controls-limitations).

1. [Enable the Microsoft traffic profile](../global-secure-access/how-to-manage-microsoft-profile.md).
1. Assign users and groups to the profile.
1. If desired, configure Conditional Access policies to enforce compliant network check.
1. Sign in to your test device and attempt to access SharePoint Online and Exchange Online.
1. View activity in the [traffic log](../global-secure-access/how-to-view-traffic-logs.md) to confirm that Global Secure Access enabled access. Verify in the sign-in logs that **Through Global Secure Access** shows as **Yes**.

### Implement Universal Tenant Restrictions

[Universal Tenant Restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md) enable you to control access to external tenants by unmanaged identities on company-managed devices and networks. You can enforce this restriction at the authentication plane with Tenant Restrictions v1, either blocking or allowing all traffic to an external tenant. However, this scenario usually requires hair-pinning traffic to a corporate network proxy. With Universal Tenant Restrictions, organizations can restrict access on a per application level, extend protection to the data plane (in addition to the authentication plane), and eliminate the need to hair-pin traffic reducing network latency.

After you enable the Microsoft traffic profile, follow these steps to implement Universal Tenant Restrictions:

1. [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2). If your organization currently uses Tenant Restrictions v1, review the [TRv2 migration guide](https://aka.ms/trv2migration).
1. [Enable Global Secure Access signaling for tenant restrictions](../global-secure-access/how-to-universal-tenant-restrictions.md#enable-global-secure-access-signaling-for-tenant-restrictions).
1. Sign in to your test device and attempt to access a different tenant's SharePoint Online or Exchange Online resource for which you have valid credentials.
1. [Validate authentication plane protection](../global-secure-access/how-to-universal-tenant-restrictions.md#validate-the-authentication-plane-protection).
1. [Validate data plane protection](../global-secure-access/how-to-universal-tenant-restrictions.md#validate-the-data-plane-protection).

## Troubleshooting

If you run into issues during your PoC, these articles can help you with troubleshooting, logging, and monitoring:

- To aid in troubleshooting, review [Global Secure Access FAQ](../global-secure-access/resource-faq.yml).
- [Troubleshoot problems installing the Microsoft Entra private network connector](../global-secure-access/troubleshoot-connectors.md).
- [Troubleshoot the Global Secure Access client: diagnostics](../global-secure-access/troubleshoot-global-secure-access-client-advanced-diagnostics.md)
- [Troubleshoot the Global Secure Access Client: Health check tab](../global-secure-access/troubleshoot-global-secure-access-client-diagnostics-health-check.md)
- [Troubleshoot Distributed File System issue with Global Secure Access](../global-secure-access/troubleshoot-distributed-file-system.md)
- See [Global Secure Access logs and monitoring](../global-secure-access/concept-global-secure-access-logs-monitoring.md) for log locations and other details that can assist with monitoring and troubleshooting your Global Secure Access deployment.
- [How to use workbooks with Global Secure Access](../global-secure-access/how-to-use-workbooks.md).

## Next steps

- [Introduction to Global Secure Access Proof of Concept Guidance](gsa-poc-guidance-intro.md)](gsa-poc-guidance-intro.md)
- [Configure Microsoft Entra Private Access](gsa-poc-private-access.md)
- [Introduction to Microsoft Global Secure Access Deployment Guide](gsa-deployment-guide-intro.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Private Access](gsa-deployment-guide-private-access.md)
- [Microsoft Global Secure Access Deployment Guide for Microsoft Entra Internet Access](gsa-deployment-guide-internet-access.md)
- [Microsoft Global Secure Access deployment guide for Microsoft Traffic](gsa-deployment-guide-microsoft-traffic.md)
